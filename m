Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFE865273C
	for <lists+linux-iio@lfdr.de>; Tue, 20 Dec 2022 20:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiLTTkq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Dec 2022 14:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiLTTkm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Dec 2022 14:40:42 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42576C22
        for <linux-iio@vger.kernel.org>; Tue, 20 Dec 2022 11:40:40 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so13225577pjj.4
        for <linux-iio@vger.kernel.org>; Tue, 20 Dec 2022 11:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8dgyZDjEY8UkolOUOGTbwHXBQrKQr/nGP55yuCJXC6k=;
        b=ZxMBiMnJzcdKH/2LFwdTU7pHYVFwxmSAgo4/uZMe3/t3PVVSp0Ei5fvvuYqDjEaqX6
         dyOGvvdqOdYiqDrTQta72PFgPV5lVCGBTM7QSv6IPa5BwI2zfeJXlGkNeA4SmqV0Ij0T
         kL6PsNvsIfAZt8ogRsl4cGw/t0c9so31h5B3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8dgyZDjEY8UkolOUOGTbwHXBQrKQr/nGP55yuCJXC6k=;
        b=qpY7gVTr7KUmkjLlxSuh8a1h/mls6DfWKk10KXp0T5ZD6pJh5a8MhZzphxXsKHIshE
         KBnbaAqfqLGCYy9rFIGnN50grDBpkJM8da5grTir9fX8mMSMwJfDLES+AHSEvL1cI/BF
         LjrlxphoGR1ufp9JmdDIi7PrAX5NTqTUGxGNhAt18hD45Q1gv0ypKY+SYimQX03pdrTs
         37QEeyonKEWLKHMRd4GCplYZL7sEU8zHDa8pKN0djNhepoLyDX8jczMZXLy9gNFX2ARH
         O8vwJV/pT7BZ0s4o2lFtYJnNKvXlazbl8zmfUsUYKSbXRtXizoylAp47hCg5j280vxQJ
         8DWA==
X-Gm-Message-State: AFqh2koXvd1w5Og/yypKyHOfRV9SI7l0Fp2mxaZcVAKY2QgtY1TahCxY
        +hQXLc6Z/XCCV0fKblKbSxnCTKKyRTmHIAE9
X-Google-Smtp-Source: AMrXdXu2i8hQ7INXHsjUe/uep0doydfAb4hpWJjlYCbL1J+iA3BiT2XFG99zoXoTg3Kn+zbva9maFA==
X-Received: by 2002:a05:6a20:45e:b0:a4:7132:ab5b with SMTP id b30-20020a056a20045e00b000a47132ab5bmr17481523pzb.58.1671565239611;
        Tue, 20 Dec 2022 11:40:39 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:4c5b:3b29:5bc0:c8e8])
        by smtp.gmail.com with UTF8SMTPSA id b4-20020a170902650400b00178b9c997e5sm9701440plk.138.2022.12.20.11.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 11:40:38 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] iio: proximity: sx_common: Add old register mapping
Date:   Tue, 20 Dec 2022 11:39:26 -0800
Message-Id: <20221220193926.126366-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Older firmwares still send sensor configuration using a list of
registers with opaque values defined during sensor tuning.
sx9234 and sx9360 sensor on ACPI based devices are concerned.
More schema to configure the sensors will be needed to support devices
designed for windows, like Samsung Galaxy Book2.

Support schema is: "<_HID>.<register_name>". For instance
"STH9324,reg_adv_ctrl2" in:

    Scope (\_SB.PCI0.I2C2)
    {
        Device (SX28)
        {
            Name (_HID, "STH9324")  // _HID: Hardware ID
...
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /*
Device Properties for _DSD */,
                Package (0x3F)
                {
...
                    Package (0x02)
                    {
                        "STH9324,reg_adv_ctrl2",
                        Zero
                    },`

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v1:
- remove double empty lines.
- Add |property| field at end of structure to minimize changes.
- Cache acpi_id entry, use standard API to retrieve it from parent
  device.
- Use that entry to see if a legacy APCI entry exists.

 drivers/iio/proximity/sx9310.c    |   4 +-
 drivers/iio/proximity/sx9324.c    | 101 ++++++++++++++++--------------
 drivers/iio/proximity/sx9360.c    |  41 +++++++-----
 drivers/iio/proximity/sx_common.c |  22 ++++++-
 drivers/iio/proximity/sx_common.h |  12 +++-
 5 files changed, 114 insertions(+), 66 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 0e4747ccd3cf7..a7fd0b44ae267 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -796,7 +796,9 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
 }
 
 static const struct sx_common_reg_default *
-sx9310_get_default_reg(struct device *dev, int idx,
+sx9310_get_default_reg(struct device *dev,
+		       const struct acpi_device_id *acpi_id,
+		       int idx,
 		       struct sx_common_reg_default *reg_def)
 {
 	u32 combined[SX9310_NUM_CHANNELS];
diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 977cf17cec52b..e59f93bfa7179 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -783,73 +783,75 @@ static int sx9324_write_raw(struct iio_dev *indio_dev,
 
 static const struct sx_common_reg_default sx9324_default_regs[] = {
 	{ SX9324_REG_IRQ_MSK, 0x00 },
-	{ SX9324_REG_IRQ_CFG0, 0x00 },
-	{ SX9324_REG_IRQ_CFG1, SX9324_REG_IRQ_CFG1_FAILCOND },
-	{ SX9324_REG_IRQ_CFG2, 0x00 },
-	{ SX9324_REG_GNRL_CTRL0, SX9324_REG_GNRL_CTRL0_SCANPERIOD_100MS },
+	{ SX9324_REG_IRQ_CFG0, 0x00, "irq_cfg0" },
+	{ SX9324_REG_IRQ_CFG1, SX9324_REG_IRQ_CFG1_FAILCOND, "irq_cfg1" },
+	{ SX9324_REG_IRQ_CFG2, 0x00, "irq_cfg2" },
+	{ SX9324_REG_GNRL_CTRL0, SX9324_REG_GNRL_CTRL0_SCANPERIOD_100MS, "gnrl_ctrl0" },
 	/*
 	 * The lower 4 bits should not be set as it enable sensors measurements.
 	 * Turning the detection on before the configuration values are set to
 	 * good values can cause the device to return erroneous readings.
 	 */
-	{ SX9324_REG_GNRL_CTRL1, SX9324_REG_GNRL_CTRL1_PAUSECTRL },
+	{ SX9324_REG_GNRL_CTRL1, SX9324_REG_GNRL_CTRL1_PAUSECTRL, "gnrl_ctrl1" },
 
-	{ SX9324_REG_AFE_CTRL0, SX9324_REG_AFE_CTRL0_RINT_LOWEST },
-	{ SX9324_REG_AFE_CTRL3, 0x00 },
+	{ SX9324_REG_AFE_CTRL0, SX9324_REG_AFE_CTRL0_RINT_LOWEST, "afe_ctrl0" },
+	{ SX9324_REG_AFE_CTRL3, 0x00, "afe_ctrl3" },
 	{ SX9324_REG_AFE_CTRL4, SX9324_REG_AFE_CTRL4_FREQ_83_33HZ |
-		SX9324_REG_AFE_CTRL4_RES_100 },
-	{ SX9324_REG_AFE_CTRL6, 0x00 },
+		SX9324_REG_AFE_CTRL4_RES_100, "afe_ctrl4" },
+	{ SX9324_REG_AFE_CTRL6, 0x00, "afe_ctrl6" },
 	{ SX9324_REG_AFE_CTRL7, SX9324_REG_AFE_CTRL4_FREQ_83_33HZ |
-		SX9324_REG_AFE_CTRL4_RES_100 },
+		SX9324_REG_AFE_CTRL4_RES_100, "afe_ctrl7" },
 
 	/* TODO(gwendal): PHx use chip default or all grounded? */
-	{ SX9324_REG_AFE_PH0, 0x29 },
-	{ SX9324_REG_AFE_PH1, 0x26 },
-	{ SX9324_REG_AFE_PH2, 0x1a },
-	{ SX9324_REG_AFE_PH3, 0x16 },
+	{ SX9324_REG_AFE_PH0, 0x29, "afe_ph0" },
+	{ SX9324_REG_AFE_PH1, 0x26, "afe_ph1" },
+	{ SX9324_REG_AFE_PH2, 0x1a, "afe_ph2" },
+	{ SX9324_REG_AFE_PH3, 0x16, "afe_ph3" },
 
 	{ SX9324_REG_AFE_CTRL8, SX9324_REG_AFE_CTRL8_RESERVED |
-		SX9324_REG_AFE_CTRL8_RESFILTIN_4KOHM },
-	{ SX9324_REG_AFE_CTRL9, SX9324_REG_AFE_CTRL9_AGAIN_1 },
+		SX9324_REG_AFE_CTRL8_RESFILTIN_4KOHM, "afe_ctrl8" },
+	{ SX9324_REG_AFE_CTRL9, SX9324_REG_AFE_CTRL9_AGAIN_1, "afe_ctrl9" },
 
 	{ SX9324_REG_PROX_CTRL0,
 		SX9324_REG_PROX_CTRL0_GAIN_1 << SX9324_REG_PROX_CTRL0_GAIN_SHIFT |
-		SX9324_REG_PROX_CTRL0_RAWFILT_1P50 },
+		SX9324_REG_PROX_CTRL0_RAWFILT_1P50, "prox_ctrl0" },
 	{ SX9324_REG_PROX_CTRL1,
 		SX9324_REG_PROX_CTRL0_GAIN_1 << SX9324_REG_PROX_CTRL0_GAIN_SHIFT |
-		SX9324_REG_PROX_CTRL0_RAWFILT_1P50 },
-	{ SX9324_REG_PROX_CTRL2, SX9324_REG_PROX_CTRL2_AVGNEG_THRESH_16K },
+		SX9324_REG_PROX_CTRL0_RAWFILT_1P50, "prox_ctrl1" },
+	{ SX9324_REG_PROX_CTRL2, SX9324_REG_PROX_CTRL2_AVGNEG_THRESH_16K, "prox_ctrl2" },
 	{ SX9324_REG_PROX_CTRL3, SX9324_REG_PROX_CTRL3_AVGDEB_2SAMPLES |
-		SX9324_REG_PROX_CTRL3_AVGPOS_THRESH_16K },
+		SX9324_REG_PROX_CTRL3_AVGPOS_THRESH_16K, "prox_ctrl3" },
 	{ SX9324_REG_PROX_CTRL4, SX9324_REG_PROX_CTRL4_AVGNEG_FILT_2 |
-		SX9324_REG_PROX_CTRL4_AVGPOS_FILT_256 },
-	{ SX9324_REG_PROX_CTRL5, 0x00 },
-	{ SX9324_REG_PROX_CTRL6, SX9324_REG_PROX_CTRL6_PROXTHRESH_32 },
-	{ SX9324_REG_PROX_CTRL7, SX9324_REG_PROX_CTRL6_PROXTHRESH_32 },
-	{ SX9324_REG_ADV_CTRL0, 0x00 },
-	{ SX9324_REG_ADV_CTRL1, 0x00 },
-	{ SX9324_REG_ADV_CTRL2, 0x00 },
-	{ SX9324_REG_ADV_CTRL3, 0x00 },
-	{ SX9324_REG_ADV_CTRL4, 0x00 },
+		SX9324_REG_PROX_CTRL4_AVGPOS_FILT_256, "prox_ctrl4" },
+	{ SX9324_REG_PROX_CTRL5, 0x00, "prox_ctrl5" },
+	{ SX9324_REG_PROX_CTRL6, SX9324_REG_PROX_CTRL6_PROXTHRESH_32, "prox_ctrl6" },
+	{ SX9324_REG_PROX_CTRL7, SX9324_REG_PROX_CTRL6_PROXTHRESH_32, "prox_ctrl7" },
+	{ SX9324_REG_ADV_CTRL0, 0x00, "adv_ctrl0" },
+	{ SX9324_REG_ADV_CTRL1, 0x00, "adv_ctrl1" },
+	{ SX9324_REG_ADV_CTRL2, 0x00, "adv_ctrl2" },
+	{ SX9324_REG_ADV_CTRL3, 0x00, "adv_ctrl3" },
+	{ SX9324_REG_ADV_CTRL4, 0x00, "adv_ctrl4" },
 	{ SX9324_REG_ADV_CTRL5, SX9324_REG_ADV_CTRL5_STARTUP_SENSOR_1 |
-		SX9324_REG_ADV_CTRL5_STARTUP_METHOD_1 },
-	{ SX9324_REG_ADV_CTRL6, 0x00 },
-	{ SX9324_REG_ADV_CTRL7, 0x00 },
-	{ SX9324_REG_ADV_CTRL8, 0x00 },
-	{ SX9324_REG_ADV_CTRL9, 0x00 },
+		SX9324_REG_ADV_CTRL5_STARTUP_METHOD_1, "adv_ctrl5" },
+	{ SX9324_REG_ADV_CTRL6, 0x00, "adv_ctrl6" },
+	{ SX9324_REG_ADV_CTRL7, 0x00, "adv_ctrl7" },
+	{ SX9324_REG_ADV_CTRL8, 0x00, "adv_ctrl8" },
+	{ SX9324_REG_ADV_CTRL9, 0x00, "adv_ctrl9" },
 	/* Body/Table threshold */
-	{ SX9324_REG_ADV_CTRL10, 0x00 },
-	{ SX9324_REG_ADV_CTRL11, 0x00 },
-	{ SX9324_REG_ADV_CTRL12, 0x00 },
+	{ SX9324_REG_ADV_CTRL10, 0x00, "adv_ctrl10" },
+	{ SX9324_REG_ADV_CTRL11, 0x00, "adv_ctrl11" },
+	{ SX9324_REG_ADV_CTRL12, 0x00, "adv_ctrl12" },
 	/* TODO(gwendal): SAR currenly disabled */
-	{ SX9324_REG_ADV_CTRL13, 0x00 },
-	{ SX9324_REG_ADV_CTRL14, 0x00 },
-	{ SX9324_REG_ADV_CTRL15, 0x00 },
-	{ SX9324_REG_ADV_CTRL16, 0x00 },
-	{ SX9324_REG_ADV_CTRL17, 0x00 },
-	{ SX9324_REG_ADV_CTRL18, 0x00 },
-	{ SX9324_REG_ADV_CTRL19, SX9324_REG_ADV_CTRL19_HIGHT_FAILURE_THRESH_SATURATION },
-	{ SX9324_REG_ADV_CTRL20, SX9324_REG_ADV_CTRL19_HIGHT_FAILURE_THRESH_SATURATION },
+	{ SX9324_REG_ADV_CTRL13, 0x00, "adv_ctrl13" },
+	{ SX9324_REG_ADV_CTRL14, 0x00, "adv_ctrl14" },
+	{ SX9324_REG_ADV_CTRL15, 0x00, "adv_ctrl15" },
+	{ SX9324_REG_ADV_CTRL16, 0x00, "adv_ctrl16" },
+	{ SX9324_REG_ADV_CTRL17, 0x00, "adv_ctrl17" },
+	{ SX9324_REG_ADV_CTRL18, 0x00, "adv_ctrl18" },
+	{ SX9324_REG_ADV_CTRL19,
+		SX9324_REG_ADV_CTRL19_HIGHT_FAILURE_THRESH_SATURATION, "adv_ctrl19" },
+	{ SX9324_REG_ADV_CTRL20,
+		SX9324_REG_ADV_CTRL19_HIGHT_FAILURE_THRESH_SATURATION, "adv_ctrl20" },
 };
 
 /* Activate all channels and perform an initial compensation. */
@@ -872,7 +874,9 @@ static int sx9324_init_compensation(struct iio_dev *indio_dev)
 }
 
 static const struct sx_common_reg_default *
-sx9324_get_default_reg(struct device *dev, int idx,
+sx9324_get_default_reg(struct device *dev,
+		       const struct acpi_device_id *acpi_id,
+		       int idx,
 		       struct sx_common_reg_default *reg_def)
 {
 	static const char * const sx9324_rints[] = { "lowest", "low", "high",
@@ -889,6 +893,8 @@ sx9324_get_default_reg(struct device *dev, int idx,
 	const char *res;
 
 	memcpy(reg_def, &sx9324_default_regs[idx], sizeof(*reg_def));
+	sx_common_get_raw_register_config(dev, acpi_id, reg_def);
+
 	switch (reg_def->reg) {
 	case SX9324_REG_AFE_PH0:
 	case SX9324_REG_AFE_PH1:
@@ -1028,11 +1034,14 @@ sx9324_get_default_reg(struct device *dev, int idx,
 static int sx9324_check_whoami(struct device *dev,
 			       struct iio_dev *indio_dev)
 {
+	struct sx_common_data *data = iio_priv(indio_dev);
+
 	/*
 	 * Only one sensor for this driver. Assuming the device tree
 	 * is correct, just set the sensor name.
 	 */
 	indio_dev->name = "sx9324";
+	data->acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
 	return 0;
 }
 
diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 7fa2213d23baf..f12687c09a2de 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -663,37 +663,37 @@ static int sx9360_write_raw(struct iio_dev *indio_dev,
 
 static const struct sx_common_reg_default sx9360_default_regs[] = {
 	{ SX9360_REG_IRQ_MSK, 0x00 },
-	{ SX9360_REG_IRQ_CFG, 0x00 },
+	{ SX9360_REG_IRQ_CFG, 0x00, "irq_cfg" },
 	/*
 	 * The lower 2 bits should not be set as it enable sensors measurements.
 	 * Turning the detection on before the configuration values are set to
 	 * good values can cause the device to return erroneous readings.
 	 */
-	{ SX9360_REG_GNRL_CTRL0, 0x00 },
-	{ SX9360_REG_GNRL_CTRL1, 0x00 },
-	{ SX9360_REG_GNRL_CTRL2, SX9360_REG_GNRL_CTRL2_PERIOD_102MS },
+	{ SX9360_REG_GNRL_CTRL0, 0x00, "gnrl_ctrl0" },
+	{ SX9360_REG_GNRL_CTRL1, 0x00, "gnrl_ctrl1" },
+	{ SX9360_REG_GNRL_CTRL2, SX9360_REG_GNRL_CTRL2_PERIOD_102MS, "gnrl_ctrl2" },
 
-	{ SX9360_REG_AFE_CTRL1, SX9360_REG_AFE_CTRL1_RESFILTIN_0OHMS },
+	{ SX9360_REG_AFE_CTRL1, SX9360_REG_AFE_CTRL1_RESFILTIN_0OHMS, "afe_ctrl0" },
 	{ SX9360_REG_AFE_PARAM0_PHR, SX9360_REG_AFE_PARAM0_RSVD |
-		SX9360_REG_AFE_PARAM0_RESOLUTION_128 },
+		SX9360_REG_AFE_PARAM0_RESOLUTION_128, "afe_param0_phr" },
 	{ SX9360_REG_AFE_PARAM1_PHR, SX9360_REG_AFE_PARAM1_AGAIN_PHM_6PF |
-		SX9360_REG_AFE_PARAM1_FREQ_83_33HZ },
+		SX9360_REG_AFE_PARAM1_FREQ_83_33HZ, "afe_param1_phr" },
 	{ SX9360_REG_AFE_PARAM0_PHM, SX9360_REG_AFE_PARAM0_RSVD |
-		SX9360_REG_AFE_PARAM0_RESOLUTION_128 },
+		SX9360_REG_AFE_PARAM0_RESOLUTION_128, "afe_param0_phm" },
 	{ SX9360_REG_AFE_PARAM1_PHM, SX9360_REG_AFE_PARAM1_AGAIN_PHM_6PF |
-		SX9360_REG_AFE_PARAM1_FREQ_83_33HZ },
+		SX9360_REG_AFE_PARAM1_FREQ_83_33HZ, "afe_param1_phm" },
 
 	{ SX9360_REG_PROX_CTRL0_PHR, SX9360_REG_PROX_CTRL0_GAIN_1 |
-		SX9360_REG_PROX_CTRL0_RAWFILT_1P50 },
+		SX9360_REG_PROX_CTRL0_RAWFILT_1P50, "prox_ctrl0_phr" },
 	{ SX9360_REG_PROX_CTRL0_PHM, SX9360_REG_PROX_CTRL0_GAIN_1 |
-		SX9360_REG_PROX_CTRL0_RAWFILT_1P50 },
-	{ SX9360_REG_PROX_CTRL1, SX9360_REG_PROX_CTRL1_AVGNEG_THRESH_16K },
+		SX9360_REG_PROX_CTRL0_RAWFILT_1P50, "prox_ctrl0_phm" },
+	{ SX9360_REG_PROX_CTRL1, SX9360_REG_PROX_CTRL1_AVGNEG_THRESH_16K, "prox_ctrl1" },
 	{ SX9360_REG_PROX_CTRL2, SX9360_REG_PROX_CTRL2_AVGDEB_2SAMPLES |
-		SX9360_REG_PROX_CTRL2_AVGPOS_THRESH_16K },
+		SX9360_REG_PROX_CTRL2_AVGPOS_THRESH_16K, "prox_ctrl2" },
 	{ SX9360_REG_PROX_CTRL3, SX9360_REG_PROX_CTRL3_AVGNEG_FILT_2 |
-		SX9360_REG_PROX_CTRL3_AVGPOS_FILT_256 },
-	{ SX9360_REG_PROX_CTRL4, 0x00 },
-	{ SX9360_REG_PROX_CTRL5, SX9360_REG_PROX_CTRL5_PROXTHRESH_32 },
+		SX9360_REG_PROX_CTRL3_AVGPOS_FILT_256, "prox_ctrl3" },
+	{ SX9360_REG_PROX_CTRL4, 0x00, "prox_ctrl4" },
+	{ SX9360_REG_PROX_CTRL5, SX9360_REG_PROX_CTRL5_PROXTHRESH_32, "prox_ctrl5" },
 };
 
 /* Activate all channels and perform an initial compensation. */
@@ -716,13 +716,17 @@ static int sx9360_init_compensation(struct iio_dev *indio_dev)
 }
 
 static const struct sx_common_reg_default *
-sx9360_get_default_reg(struct device *dev, int idx,
+sx9360_get_default_reg(struct device *dev,
+		       const struct acpi_device_id *acpi_id,
+		       int idx,
 		       struct sx_common_reg_default *reg_def)
 {
 	u32 raw = 0, pos = 0;
 	int ret;
 
 	memcpy(reg_def, &sx9360_default_regs[idx], sizeof(*reg_def));
+	sx_common_get_raw_register_config(dev, acpi_id, reg_def);
+
 	switch (reg_def->reg) {
 	case SX9360_REG_AFE_CTRL1:
 		ret = device_property_read_u32(dev,
@@ -773,11 +777,14 @@ sx9360_get_default_reg(struct device *dev, int idx,
 
 static int sx9360_check_whoami(struct device *dev, struct iio_dev *indio_dev)
 {
+	struct sx_common_data *data = iio_priv(indio_dev);
+
 	/*
 	 * Only one sensor for this driver. Assuming the device tree
 	 * is correct, just set the sensor name.
 	 */
 	indio_dev->name = "sx9360";
+	data->acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
 	return 0;
 }
 
diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
index d70a6b4f0bf86..2286f118802d1 100644
--- a/drivers/iio/proximity/sx_common.c
+++ b/drivers/iio/proximity/sx_common.c
@@ -431,6 +431,25 @@ static void sx_common_regulator_disable(void *_data)
 	regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
 }
 
+void sx_common_get_raw_register_config(struct device *dev,
+				       const struct acpi_device_id *id,
+				       struct sx_common_reg_default *reg_def)
+{
+	u32 raw = 0, ret;
+	char prop[80];
+
+	if (!reg_def->property || !id)
+		return;
+
+	scnprintf(prop, ARRAY_SIZE(prop), "%s,reg_%s", id->id, reg_def->property);
+	ret = device_property_read_u32(dev, prop, &raw);
+	if (ret)
+		return;
+
+	reg_def->def = raw;
+}
+EXPORT_SYMBOL_NS_GPL(sx_common_get_raw_register_config, SEMTECH_PROX);
+
 #define SX_COMMON_SOFT_RESET				0xde
 
 static int sx_common_init_device(struct device *dev, struct iio_dev *indio_dev)
@@ -455,7 +474,8 @@ static int sx_common_init_device(struct device *dev, struct iio_dev *indio_dev)
 
 	/* Program defaults from constant or BIOS. */
 	for (i = 0; i < data->chip_info->num_default_regs; i++) {
-		initval = data->chip_info->ops.get_default_reg(dev, i, &tmp);
+		initval = data->chip_info->ops.get_default_reg(dev, data->acpi_id,
+							       i, &tmp);
 		ret = regmap_write(data->regmap, initval->reg, initval->def);
 		if (ret)
 			return ret;
diff --git a/drivers/iio/proximity/sx_common.h b/drivers/iio/proximity/sx_common.h
index 5d3edeb75f4e0..c8a10faffc9cb 100644
--- a/drivers/iio/proximity/sx_common.h
+++ b/drivers/iio/proximity/sx_common.h
@@ -8,6 +8,7 @@
 #ifndef IIO_SX_COMMON_H
 #define IIO_SX_COMMON_H
 
+#include <linux/acpi.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/types.h>
 #include <linux/regulator/consumer.h>
@@ -26,6 +27,7 @@ static_assert(SX_COMMON_MAX_NUM_CHANNELS < BITS_PER_LONG);
 struct sx_common_reg_default {
 	u8 reg;
 	u8 def;
+	const char *property;
 };
 
 /**
@@ -48,7 +50,9 @@ struct sx_common_ops {
 	int (*init_compensation)(struct iio_dev *indio_dev);
 	int (*wait_for_sample)(struct sx_common_data *data);
 	const struct sx_common_reg_default  *
-		(*get_default_reg)(struct device *dev, int idx,
+		(*get_default_reg)(struct device *dev,
+				   const struct acpi_device_id *acpi_id,
+				   int idx,
 				   struct sx_common_reg_default *reg_def);
 };
 
@@ -101,6 +105,7 @@ struct sx_common_chip_info {
  * @client:		I2C client structure.
  * @trig:		IIO trigger object.
  * @regmap:		Register map.
+ * @acpi_id: ACPI device entry when the device is using APCI, NULL otherwise.
  * @num_default_regs:	Number of default registers to set at init.
  * @supplies:		Power supplies object.
  * @chan_prox_stat:	Last reading of the proximity status for each channel.
@@ -119,6 +124,7 @@ struct sx_common_data {
 	struct i2c_client *client;
 	struct iio_trigger *trig;
 	struct regmap *regmap;
+	const struct acpi_device_id *acpi_id;
 
 	struct regulator_bulk_data supplies[2];
 	unsigned long chan_prox_stat;
@@ -151,6 +157,10 @@ int sx_common_probe(struct i2c_client *client,
 		    const struct sx_common_chip_info *chip_info,
 		    const struct regmap_config *regmap_config);
 
+void sx_common_get_raw_register_config(struct device *dev,
+				       const struct acpi_device_id *id,
+				       struct sx_common_reg_default *reg_def);
+
 /* 3 is the number of events defined by a single phase. */
 extern const struct iio_event_spec sx_common_events[3];
 
-- 
2.39.0.314.g84b9a713c41-goog

