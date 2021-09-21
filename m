Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10134132ED
	for <lists+linux-iio@lfdr.de>; Tue, 21 Sep 2021 13:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhIULzv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Sep 2021 07:55:51 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:38337 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhIULzu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Sep 2021 07:55:50 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 48F0E240019;
        Tue, 21 Sep 2021 11:54:21 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 15/16] iio: adc: max1027: Allow all kind of triggers to be used
Date:   Tue, 21 Sep 2021 13:54:07 +0200
Message-Id: <20210921115408.66711-16-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210921115408.66711-1-miquel.raynal@bootlin.com>
References: <20210921115408.66711-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There is no reason to limit this driver to its internal trigger. The
only difference being, when using an external trigger, the sample
conversion must be manually started.

Drop the ->validate_trigger() hook in order to allow other triggers to
be bound.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 0fa7b0fbdba0..02735c604f82 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -429,17 +429,6 @@ static int max1027_debugfs_reg_access(struct iio_dev *indio_dev,
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
@@ -490,8 +479,8 @@ static irqreturn_t max1027_handler(int irq, void *private)
 	struct max1027_state *st = iio_priv(indio_dev);
 
 	/*
-	 * If buffers are disabled (raw read), we just need to unlock the
-	 * waiters which will then handle the data.
+	 * If buffers are disabled (raw read) or when using external triggers,
+	 * we just need to unlock the waiters which will then handle the data.
 	 *
 	 * When using the internal trigger, we must hand-off the choice of the
 	 * handler to the core which will then lookup through the interrupt tree
@@ -514,7 +503,19 @@ static irqreturn_t max1027_trigger_handler(int irq, void *private)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	int ret;
 
+	if (!iio_trigger_using_own(indio_dev)) {
+		ret = max1027_configure_chans_and_start(indio_dev);
+		if (ret)
+			goto out;
+
+		/* This is a threaded handler, it is fine to wait for an IRQ */
+		ret = max1027_wait_eoc(indio_dev);
+		if (ret)
+			goto out;
+	}
+
 	ret = max1027_read_scan(indio_dev);
+out:
 	if (ret)
 		dev_err(&indio_dev->dev,
 			"Cannot read scanned values (%d)\n", ret);
@@ -531,7 +532,6 @@ static const struct iio_trigger_ops max1027_trigger_ops = {
 
 static const struct iio_info max1027_info = {
 	.read_raw = &max1027_read_raw,
-	.validate_trigger = &max1027_validate_trigger,
 	.debugfs_reg_access = &max1027_debugfs_reg_access,
 };
 
-- 
2.27.0

