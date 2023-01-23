Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C75678921
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jan 2023 22:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjAWVEo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Jan 2023 16:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjAWVEm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jan 2023 16:04:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645CF38026;
        Mon, 23 Jan 2023 13:04:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF93D61092;
        Mon, 23 Jan 2023 21:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF52C433A0;
        Mon, 23 Jan 2023 21:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674507878;
        bh=VnHxjBNrUG6CY7s6ScRwsoldize5YgLyA6igzmAEr7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Insh2jMuVk52Nlgs/dW1MFru6Ss0tplO925D2SaV1GPkPNH/5p/On4alhYPtBabPS
         S3Qttn1CPowls7FEmyDBFOlEFUDNo3ERTprGnCzRvpx44npXsSEHbVNFkVtAfpR03w
         GTxutgywKXvUj2zIET1GkeU0FNJAbgNsWLJqvt2pWV3aXBGjS1hPwmVN0udm1TmlMT
         P3FqghLfATSkiQZo7HAAFF4/14lDbyZpRHJVusTxQ6JJKMYRPblej++fLUag6SjP6s
         xWvUbydOSfNavqfqEWK6FKIcmcs4iog1CZXDCZ1uo9iZLHZ+8IQtgirFG3/ivIc+FO
         N2Q/AVY9m+tbQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Barry Song <baohua@kernel.org>
Subject: [PATCH 08/12] staging: iio: accel: adis16203: Trivial whitespace cleanup
Date:   Mon, 23 Jan 2023 21:17:54 +0000
Message-Id: <20230123211758.563383-9-jic23@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123211758.563383-1-jic23@kernel.org>
References: <20230123211758.563383-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Identation etc in this driver was inconsistent. Fix that.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/accel/adis16203.c | 97 +++++++++++++--------------
 1 file changed, 46 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index 271e560c41c0..20e9c9eb9436 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -16,49 +16,49 @@
 
 #define ADIS16203_STARTUP_DELAY_MS		220
 
-#define ADIS16203_FLASH_CNT      0x00
-#define ADIS16203_SUPPLY_OUT     0x02
-#define ADIS16203_AUX_ADC        0x08
-#define ADIS16203_TEMP_OUT       0x0A
-#define ADIS16203_INCL_OUT       0x0C
-#define ADIS16203_INCL_OUT_180   0x0E
-#define ADIS16203_INCL_NULL      0x18
-#define ADIS16203_ALM_MAG1       0x20
-#define ADIS16203_ALM_MAG2       0x22
-#define ADIS16203_ALM_SMPL1      0x24
-#define ADIS16203_ALM_SMPL2      0x26
-#define ADIS16203_ALM_CTRL       0x28
-#define ADIS16203_AUX_DAC        0x30
-#define ADIS16203_GPIO_CTRL      0x32
-#define ADIS16203_MSC_CTRL       0x34
-#define ADIS16203_SMPL_PRD       0x36
-#define ADIS16203_AVG_CNT        0x38
-#define ADIS16203_SLP_CNT        0x3A
-#define ADIS16203_DIAG_STAT      0x3C
-#define ADIS16203_GLOB_CMD       0x3E
-
-#define ADIS16203_MSC_CTRL_PWRUP_SELF_TEST_DIS  BIT(10)
-#define ADIS16203_MSC_CTRL_REVERSE_ROT_EN       BIT(9)
-#define ADIS16203_MSC_CTRL_SELF_TEST_EN         BIT(8)
-#define ADIS16203_MSC_CTRL_DATA_RDY_EN          BIT(2)
-#define ADIS16203_MSC_CTRL_ACTIVE_HIGH          BIT(1)
-#define ADIS16203_MSC_CTRL_DATA_RDY_DIO1        BIT(0)
-
-#define ADIS16203_DIAG_STAT_ALARM2        BIT(9)
-#define ADIS16203_DIAG_STAT_ALARM1        BIT(8)
-#define ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT 5
-#define ADIS16203_DIAG_STAT_SPI_FAIL_BIT      3
-#define ADIS16203_DIAG_STAT_FLASH_UPT_BIT     2
-#define ADIS16203_DIAG_STAT_POWER_HIGH_BIT    1
-#define ADIS16203_DIAG_STAT_POWER_LOW_BIT     0
-
-#define ADIS16203_GLOB_CMD_SW_RESET     BIT(7)
-#define ADIS16203_GLOB_CMD_CLEAR_STAT   BIT(4)
-#define ADIS16203_GLOB_CMD_FACTORY_CAL  BIT(1)
-
-#define ADIS16203_ERROR_ACTIVE          BIT(14)
-
-#define ADIS16203_INCLI_NULL_MSK     GENMASK(13, 0)
+#define ADIS16203_FLASH_CNT			0x00
+#define ADIS16203_SUPPLY_OUT			0x02
+#define ADIS16203_AUX_ADC			0x08
+#define ADIS16203_TEMP_OUT			0x0A
+#define ADIS16203_INCL_OUT			0x0C
+#define ADIS16203_INCL_OUT_180			0x0E
+#define ADIS16203_INCL_NULL			0x18
+#define ADIS16203_ALM_MAG1			0x20
+#define ADIS16203_ALM_MAG2			0x22
+#define ADIS16203_ALM_SMPL1			0x24
+#define ADIS16203_ALM_SMPL2			0x26
+#define ADIS16203_ALM_CTRL			0x28
+#define ADIS16203_AUX_DAC			0x30
+#define ADIS16203_GPIO_CTRL			0x32
+#define ADIS16203_MSC_CTRL			0x34
+#define ADIS16203_SMPL_PRD			0x36
+#define ADIS16203_AVG_CNT			0x38
+#define ADIS16203_SLP_CNT			0x3A
+#define ADIS16203_DIAG_STAT			0x3C
+#define ADIS16203_GLOB_CMD			0x3E
+
+#define ADIS16203_MSC_CTRL_PWRUP_SELF_TEST_DIS	BIT(10)
+#define ADIS16203_MSC_CTRL_REVERSE_ROT_EN	BIT(9)
+#define ADIS16203_MSC_CTRL_SELF_TEST_EN		BIT(8)
+#define ADIS16203_MSC_CTRL_DATA_RDY_EN		BIT(2)
+#define ADIS16203_MSC_CTRL_ACTIVE_HIGH		BIT(1)
+#define ADIS16203_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
+
+#define ADIS16203_DIAG_STAT_ALARM2		BIT(9)
+#define ADIS16203_DIAG_STAT_ALARM1		BIT(8)
+#define ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT	5
+#define ADIS16203_DIAG_STAT_SPI_FAIL_BIT	3
+#define ADIS16203_DIAG_STAT_FLASH_UPT_BIT	2
+#define ADIS16203_DIAG_STAT_POWER_HIGH_BIT	1
+#define ADIS16203_DIAG_STAT_POWER_LOW_BIT	0
+
+#define ADIS16203_GLOB_CMD_SW_RESET		BIT(7)
+#define ADIS16203_GLOB_CMD_CLEAR_STAT		BIT(4)
+#define ADIS16203_GLOB_CMD_FACTORY_CAL		BIT(1)
+
+#define ADIS16203_ERROR_ACTIVE			BIT(14)
+
+#define ADIS16203_INCLI_NULL_MSK		GENMASK(13, 0)
 
 enum adis16203_scan {
 	 ADIS16203_SCAN_INCLI_X,
@@ -69,9 +69,7 @@ enum adis16203_scan {
 
 static int adis16203_write_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
-			       int val,
-			       int val2,
-			       long mask)
+			       int val, int val2, long mask)
 {
 	struct adis *st = iio_priv(indio_dev);
 
@@ -84,18 +82,16 @@ static int adis16203_write_raw(struct iio_dev *indio_dev,
 
 static int adis16203_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
-			      int *val, int *val2,
-			      long mask)
+			      int *val, int *val2, long mask)
 {
 	struct adis *st = iio_priv(indio_dev);
 	int ret;
-
 	s16 val16;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		return adis_single_conversion(indio_dev, chan,
-				ADIS16203_ERROR_ACTIVE, val);
+					      ADIS16203_ERROR_ACTIVE, val);
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
@@ -220,7 +216,6 @@ static const struct of_device_id adis16203_of_match[] = {
 	{ .compatible = "adi,adis16203" },
 	{ },
 };
-
 MODULE_DEVICE_TABLE(of, adis16203_of_match);
 
 static struct spi_driver adis16203_driver = {
-- 
2.39.1

