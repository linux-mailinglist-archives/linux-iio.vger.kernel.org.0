Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E85540C8E2
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 17:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbhIOPxE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 11:53:04 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:35609 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238360AbhIOPwm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 11:52:42 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id CBA43200006;
        Wed, 15 Sep 2021 15:51:18 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 01/14] iio: adc: max1027: Fix style
Date:   Wed, 15 Sep 2021 17:51:04 +0200
Message-Id: <20210915155117.475962-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210915155117.475962-1-miquel.raynal@bootlin.com>
References: <20210915155117.475962-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Follow checkpatch.pl's main advices before hacking into the driver, mainly:
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: Prefer 'unsigned int *' to bare use of 'unsigned *'
CHECK: Comparison to NULL could be written "!foo"
CHECK: Alignment should match open parenthesis

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index b753658bb41e..5c4633a54b30 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -327,8 +327,8 @@ static int max1027_read_raw(struct iio_dev *indio_dev,
 }
 
 static int max1027_debugfs_reg_access(struct iio_dev *indio_dev,
-				      unsigned reg, unsigned writeval,
-				      unsigned *readval)
+				      unsigned int reg, unsigned int writeval,
+				      unsigned int *readval)
 {
 	struct max1027_state *st = iio_priv(indio_dev);
 	u8 *val = (u8 *)st->buffer;
@@ -424,7 +424,7 @@ static int max1027_probe(struct spi_device *spi)
 	pr_debug("%s: probe(spi = 0x%p)\n", __func__, spi);
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-	if (indio_dev == NULL) {
+	if (!indio_dev) {
 		pr_err("Can't allocate iio device\n");
 		return -ENOMEM;
 	}
@@ -443,9 +443,9 @@ static int max1027_probe(struct spi_device *spi)
 	indio_dev->available_scan_masks = st->info->available_scan_masks;
 
 	st->buffer = devm_kmalloc_array(&indio_dev->dev,
-				  indio_dev->num_channels, 2,
-				  GFP_KERNEL);
-	if (st->buffer == NULL) {
+					indio_dev->num_channels, 2,
+					GFP_KERNEL);
+	if (!st->buffer) {
 		dev_err(&indio_dev->dev, "Can't allocate buffer\n");
 		return -ENOMEM;
 	}
@@ -462,7 +462,7 @@ static int max1027_probe(struct spi_device *spi)
 
 		st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-trigger",
 						  indio_dev->name);
-		if (st->trig == NULL) {
+		if (!st->trig) {
 			ret = -ENOMEM;
 			dev_err(&indio_dev->dev,
 				"Failed to allocate iio trigger\n");
-- 
2.27.0

