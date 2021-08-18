Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11EE3F0260
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 13:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbhHRLMl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 07:12:41 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39539 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235629AbhHRLMZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 07:12:25 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 037786000A;
        Wed, 18 Aug 2021 11:11:49 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 15/16] iio: adc: max1027: Support software triggers
Date:   Wed, 18 Aug 2021 13:11:38 +0200
Message-Id: <20210818111139.330636-16-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210818111139.330636-1-miquel.raynal@bootlin.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Now that max1027_trigger_handler() has been freed from handling hardware
triggers EOC situations, we can use it for what it has been designed in
the first place: trigger software originated conversions. In other
words, when userspace initiates a conversion with a sysfs trigger or a
hrtimer trigger, we must do all configuration steps, ie:
1- Configuring the trigger
2- Configuring the channels to scan
3- Starting the conversion (actually done automatically by step 2 in
   this case)
4- Waiting for the conversion to end
5- Retrieving the data from the ADC
6- Push the data to the IIO core and notify it

Add the missing steps to this helper and drop the trigger verification
hook otherwise software triggers would simply not be accepted at all.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 8c5995ae59f2..bb437e43adaf 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -413,17 +413,6 @@ static int max1027_debugfs_reg_access(struct iio_dev *indio_dev,
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
@@ -512,7 +501,21 @@ static irqreturn_t max1027_trigger_handler(int irq, void *private)
 
 	pr_debug("%s(irq=%d, private=0x%p)\n", __func__, irq, private);
 
+	ret = max1027_configure_trigger(indio_dev);
+	if (ret)
+		goto out;
+
+	ret = max1027_configure_chans_to_scan(indio_dev);
+	if (ret)
+		goto out;
+
+	ret = max1027_wait_eoc(indio_dev);
+	if (ret)
+		goto out;
+
 	ret = max1027_read_scan(indio_dev);
+
+out:
 	if (ret)
 		dev_err(&indio_dev->dev,
 			"Cannot read scanned values (%d)\n", ret);
@@ -529,7 +532,6 @@ static const struct iio_trigger_ops max1027_trigger_ops = {
 
 static const struct iio_info max1027_info = {
 	.read_raw = &max1027_read_raw,
-	.validate_trigger = &max1027_validate_trigger,
 	.debugfs_reg_access = &max1027_debugfs_reg_access,
 };
 
-- 
2.27.0

