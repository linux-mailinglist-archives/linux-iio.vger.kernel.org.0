Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FA667FFF0
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jan 2023 16:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjA2PmR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Jan 2023 10:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjA2PmR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2023 10:42:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4858012870;
        Sun, 29 Jan 2023 07:42:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3DE860DC1;
        Sun, 29 Jan 2023 15:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C30C4339B;
        Sun, 29 Jan 2023 15:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675006935;
        bh=7EqEpNgTP+wTWSd+Y/4V+uBfgtR9/+Icmx3ms+nJliM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOe8/uyb9xQme2ljz31bUnmNt3p8S6jjFJyS2SW0tlJIWvYvVxFLlJKnfEtgehwpS
         OCjoTqivIOWhbdBUbVRLnVn1E/OlxtIizKtMp1lWjAA98Zlyoa4PBPYd+Ybz9GFLJl
         vq0vEl6H9wy8oHvq3AckqcPy/yad1b+wYyxO0Wzx1UnwLn7ykv+tjUfztaohKzEsoe
         lzKZVAsTcONqcuQcAa+Y06PUIwYWx45ff+FEF7RlfsfTE1yt0ICwVKbtzHmhs9L7OV
         ziSNlsfRCha28tiJlNgwhHg8Jaxg2vwNDcR9ro+vneccG50Lb1Zkhp6IezHdEPLDwv
         d5Ve6FZeH2j7g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 02/12] staging: iio: accel: adis16203: Drop excessive register comments
Date:   Sun, 29 Jan 2023 15:55:52 +0000
Message-Id: <20230129155602.740743-3-jic23@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129155602.740743-1-jic23@kernel.org>
References: <20230129155602.740743-1-jic23@kernel.org>
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

A lot of these comments added very little that was not obvious
from the register/field name. In one case the polarity was the opposite
of what would be expected so rename that field (currently unused
in the driver)

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/accel/adis16203.c | 71 +--------------------------
 1 file changed, 1 insertion(+), 70 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index dd02ceb00d40..60117aaf56d4 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -15,111 +15,42 @@
 
 #define ADIS16203_STARTUP_DELAY 220 /* ms */
 
-/* Flash memory write count */
 #define ADIS16203_FLASH_CNT      0x00
-
-/* Output, power supply */
 #define ADIS16203_SUPPLY_OUT     0x02
-
-/* Output, auxiliary ADC input */
 #define ADIS16203_AUX_ADC        0x08
-
-/* Output, temperature */
 #define ADIS16203_TEMP_OUT       0x0A
-
-/* Output, x-axis inclination */
 #define ADIS16203_XINCL_OUT      0x0C
-
-/* Output, y-axis inclination */
 #define ADIS16203_YINCL_OUT      0x0E
-
-/* Incline null calibration */
 #define ADIS16203_INCL_NULL      0x18
-
-/* Alarm 1 amplitude threshold */
 #define ADIS16203_ALM_MAG1       0x20
-
-/* Alarm 2 amplitude threshold */
 #define ADIS16203_ALM_MAG2       0x22
-
-/* Alarm 1, sample period */
 #define ADIS16203_ALM_SMPL1      0x24
-
-/* Alarm 2, sample period */
 #define ADIS16203_ALM_SMPL2      0x26
-
-/* Alarm control */
 #define ADIS16203_ALM_CTRL       0x28
-
-/* Auxiliary DAC data */
 #define ADIS16203_AUX_DAC        0x30
-
-/* General-purpose digital input/output control */
 #define ADIS16203_GPIO_CTRL      0x32
-
-/* Miscellaneous control */
 #define ADIS16203_MSC_CTRL       0x34
-
-/* Internal sample period (rate) control */
 #define ADIS16203_SMPL_PRD       0x36
-
-/* Operation, filter configuration */
 #define ADIS16203_AVG_CNT        0x38
-
-/* Operation, sleep mode control */
 #define ADIS16203_SLP_CNT        0x3A
-
-/* Diagnostics, system status register */
 #define ADIS16203_DIAG_STAT      0x3C
-
-/* Operation, system command register */
 #define ADIS16203_GLOB_CMD       0x3E
 
-/* MSC_CTRL */
-
-/* Self-test at power-on: 1 = disabled, 0 = enabled */
-#define ADIS16203_MSC_CTRL_PWRUP_SELF_TEST      BIT(10)
-
-/* Reverses rotation of both inclination outputs */
+#define ADIS16203_MSC_CTRL_PWRUP_SELF_TEST_DIS  BIT(10)
 #define ADIS16203_MSC_CTRL_REVERSE_ROT_EN       BIT(9)
-
-/* Self-test enable */
 #define ADIS16203_MSC_CTRL_SELF_TEST_EN         BIT(8)
-
-/* Data-ready enable: 1 = enabled, 0 = disabled */
 #define ADIS16203_MSC_CTRL_DATA_RDY_EN          BIT(2)
-
-/* Data-ready polarity: 1 = active high, 0 = active low */
 #define ADIS16203_MSC_CTRL_ACTIVE_HIGH          BIT(1)
-
-/* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
 #define ADIS16203_MSC_CTRL_DATA_RDY_DIO1        BIT(0)
 
-/* DIAG_STAT */
-
-/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
 #define ADIS16203_DIAG_STAT_ALARM2        BIT(9)
-
-/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
 #define ADIS16203_DIAG_STAT_ALARM1        BIT(8)
-
-/* Self-test diagnostic error flag */
 #define ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT 5
-
-/* SPI communications failure */
 #define ADIS16203_DIAG_STAT_SPI_FAIL_BIT      3
-
-/* Flash update failure */
 #define ADIS16203_DIAG_STAT_FLASH_UPT_BIT     2
-
-/* Power supply above 3.625 V */
 #define ADIS16203_DIAG_STAT_POWER_HIGH_BIT    1
-
-/* Power supply below 2.975 V */
 #define ADIS16203_DIAG_STAT_POWER_LOW_BIT     0
 
-/* GLOB_CMD */
-
 #define ADIS16203_GLOB_CMD_SW_RESET     BIT(7)
 #define ADIS16203_GLOB_CMD_CLEAR_STAT   BIT(4)
 #define ADIS16203_GLOB_CMD_FACTORY_CAL  BIT(1)
-- 
2.39.1

