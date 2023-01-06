Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBAC65FEF3
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jan 2023 11:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjAFK33 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Jan 2023 05:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjAFK27 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Jan 2023 05:28:59 -0500
X-Greylist: delayed 178 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Jan 2023 02:26:57 PST
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE69777FB
        for <linux-iio@vger.kernel.org>; Fri,  6 Jan 2023 02:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1673000634;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Jb9IBvuNk86KKVlimA224qpDnnH2DRT8qvPO/gspMWE=;
    b=PdpgEHCYapquYHM/RQqk5A+nZC2iFLeymMud74V+1/hQ4IM5++uNXFIR6r25YGK3KE
    0qLk2AoRTOcJSCE1wL8uPF+vIBELLwOUPF8RUwdvZ0kIiCoxgzKllnHPEyxln2WaC50c
    mIAPT887ZM74HIBdedbxxNErgd6kvMv9Mx7qrwottjNFSolWLNdQ0P9y71t6dMznz5VO
    5zMQlEwtXHghYct4dKxsG0KZLB7d5JmVZ7+EdNjqVExH9jc+FcL7XNL+9XFzekObN3HB
    ReOApTSaN1PRBRzD268T/jpYo9heymKvWFT7Hp6O99PSZvozVnaene+bPsCmO63IyQ02
    Xd6A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXTbAOHjRHIRvweFeMkcg="
X-RZG-CLASS-ID: mo01
Received: from droid..
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id Yce349z06ANsqz7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 6 Jan 2023 11:23:54 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 2/3] iio: accel: st_accel: Add LSM303C
Date:   Fri,  6 Jan 2023 11:22:38 +0100
Message-Id: <20230106102239.9647-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106102239.9647-1-stephan@gerhold.net>
References: <20230106102239.9647-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The accelerometer part of ST LSM303C is similar (perhaps even identical)
to the already supported standalone LIS2HH12 accelerometer, so just
add the new st,lsm303c-accel compatible for the existing definitions.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/accel/Kconfig         | 2 +-
 drivers/iio/accel/st_accel.h      | 1 +
 drivers/iio/accel/st_accel_core.c | 1 +
 drivers/iio/accel/st_accel_i2c.c  | 5 +++++
 drivers/iio/accel/st_accel_spi.c  | 5 +++++
 5 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 03ac410c162e..b6b45d359f28 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -380,7 +380,7 @@ config IIO_ST_ACCEL_3AXIS
 	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
 	help
 	  Say yes here to build support for STMicroelectronics accelerometers:
-	  LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC,
+	  LSM303C, LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC,
 	  LIS331DLH, LSM303DL, LSM303DLM, LSM330, LIS2DH12, H3LIS331DL,
 	  LNG2DM, LIS3DE, LIS2DE12, LIS2HH12
 
diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 5b0f54e33d9e..56ed0c776d4a 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -37,6 +37,7 @@
 #define LIS2DE12_ACCEL_DEV_NAME		"lis2de12"
 #define LIS2HH12_ACCEL_DEV_NAME		"lis2hh12"
 #define LIS302DL_ACCEL_DEV_NAME		"lis302dl"
+#define LSM303C_ACCEL_DEV_NAME		"lsm303c_accel"
 #define SC7A20_ACCEL_DEV_NAME		"sc7a20"
 
 
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index c8c8eb15c34e..6b8562f684d5 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -929,6 +929,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = LIS2HH12_ACCEL_DEV_NAME,
+			[1] = LSM303C_ACCEL_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_accel_16bit_channels,
 		.odr = {
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 45ee0ddc133c..3f02fd5d5946 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -111,6 +111,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,lis302dl",
 		.data = LIS302DL_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "st,lsm303c-accel",
+		.data = LSM303C_ACCEL_DEV_NAME,
+	},
 	{
 		.compatible = "silan,sc7a20",
 		.data = SC7A20_ACCEL_DEV_NAME,
@@ -151,6 +155,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
 	{ LIS2DE12_ACCEL_DEV_NAME },
 	{ LIS2HH12_ACCEL_DEV_NAME },
 	{ LIS302DL_ACCEL_DEV_NAME },
+	{ LSM303C_ACCEL_DEV_NAME },
 	{ SC7A20_ACCEL_DEV_NAME },
 	{},
 };
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 6c0917750288..5740dc1820bd 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -96,6 +96,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,lis302dl",
 		.data = LIS302DL_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "st,lsm303c-accel",
+		.data = LSM303C_ACCEL_DEV_NAME,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
@@ -152,6 +156,7 @@ static const struct spi_device_id st_accel_id_table[] = {
 	{ LIS3DHH_ACCEL_DEV_NAME },
 	{ LIS3DE_ACCEL_DEV_NAME },
 	{ LIS302DL_ACCEL_DEV_NAME },
+	{ LSM303C_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_accel_id_table);
-- 
2.39.0

