Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6293FF57C
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347353AbhIBVPw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:15:52 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:45861 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346633AbhIBVPu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:15:50 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 65F51240006;
        Thu,  2 Sep 2021 21:14:50 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 15/16] iio: adc: max1027: Add support for external triggers
Date:   Thu,  2 Sep 2021 23:14:36 +0200
Message-Id: <20210902211437.503623-16-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902211437.503623-1-miquel.raynal@bootlin.com>
References: <20210902211437.503623-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

So far the driver only supported to use the hardware cnvst trigger. This
was purely a software limitation.

The IRQ handler is already registered as being a poll function and thus
can be called upon external triggering. In this case, a new conversion
must be started, and one must wait for the data to be ready before
reading the samples.

As the same handler can be called from different places, we check the
value of the current IRQ with the value of the registered device
IRQ. Indeed, the first step is to get called with a different IRQ number
than ours, this is the "pullfunc" version which requests a new
conversion. During the execution of the handler, we will wait for the
EOC interrupt to happen. This interrupt is handled by the same
helper. This time the IRQ number is the one we registered, we can in
this case call complete() to unlock the primary handler and return. The
primary handler continues executing by retrieving the data normally and
finally returns.

In order to authorize external triggers, we need to drop the
->validate_trigger() verification.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 59 +++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index e734d32a5507..b9b7b9245509 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -414,17 +414,6 @@ static int max1027_debugfs_reg_access(struct iio_dev *indio_dev,
 	return spi_write(st->spi, val, 1);
 }
 
-static int max1027_validate_trigger(struct iio_dev *indio_dev,
-				    struct iio_trigger *trig)
-{
-	struct max1027_state *st = iio_priv(indio_dev);
-
-	if (st->trig != trig)
-		return -EINVAL;
-
-	return 0;
-}
-
 static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
@@ -469,6 +458,13 @@ static int max1027_read_scan(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static bool max1027_own_trigger_enabled(struct iio_dev *indio_dev)
+{
+	int ret = iio_trigger_validate_own_device(indio_dev->trig, indio_dev);
+
+	return ret ? false : true;
+}
+
 static irqreturn_t max1027_threaded_handler(int irq, void *private)
 {
 	struct iio_poll_func *pf = private;
@@ -487,7 +483,47 @@ static irqreturn_t max1027_threaded_handler(int irq, void *private)
 		return IRQ_HANDLED;
 	}
 
+	/* From that point on, buffers are enabled */
+
+	/*
+	 * The cnvst HW trigger is not in use:
+	 * we need to handle an external trigger request.
+	 */
+	if (!max1027_own_trigger_enabled(indio_dev)) {
+		if (irq != st->spi->irq) {
+			/*
+			 * First, the IRQ number will be the one allocated for
+			 * this poll function by the IIO core, it means that
+			 * this is an external trigger request, we need to start
+			 * a conversion.
+			 */
+			ret = max1027_configure_chans_and_start(indio_dev);
+			if (ret)
+				goto out;
+
+			ret = max1027_wait_eoc(indio_dev);
+			if (ret)
+				goto out;
+		} else {
+			/*
+			 * The pollfunc that has been called "manually" by the
+			 * IIO core now expects the EOC signaling (this is the
+			 * device IRQ firing), we need to call complete().
+			 */
+			complete(&st->complete);
+			return IRQ_HANDLED;
+		}
+	}
+
+	/*
+	 * We end here under two situations:
+	 * - an external trigger is in use and the *_wait_eoc() call succeeded,
+	 *   the data is ready and may be retrieved.
+	 * - the cnvst HW trigger is in use (the handler actually starts here),
+	 *   the data is also ready.
+	 */
 	ret = max1027_read_scan(indio_dev);
+out:
 	if (ret)
 		dev_err(&indio_dev->dev,
 			"Cannot read scanned values (%d)\n", ret);
@@ -504,7 +540,6 @@ static const struct iio_trigger_ops max1027_trigger_ops = {
 
 static const struct iio_info max1027_info = {
 	.read_raw = &max1027_read_raw,
-	.validate_trigger = &max1027_validate_trigger,
 	.debugfs_reg_access = &max1027_debugfs_reg_access,
 };
 
-- 
2.27.0

