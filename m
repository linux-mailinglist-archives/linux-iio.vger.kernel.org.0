Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B5F6ACC54
	for <lists+linux-iio@lfdr.de>; Mon,  6 Mar 2023 19:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCFSUM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Mar 2023 13:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjCFSUL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Mar 2023 13:20:11 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ACA65060;
        Mon,  6 Mar 2023 10:19:35 -0800 (PST)
Received: from stefanw-SCHENKER ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M4b5s-1pXaex3NmY-001j20; Mon, 06 Mar 2023 18:23:17 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, Li Yang <leoyang.li@nxp.com>,
        Denis Ciocca <denis.ciocca@st.com>, soc@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 8/8] ARM: imx_v6_v7_defconfig: Enable Tarragon peripheral drivers
Date:   Mon,  6 Mar 2023 18:22:49 +0100
Message-Id: <20230306172249.74003-9-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306172249.74003-1-stefan.wahren@i2se.com>
References: <20230306172249.74003-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:apHcp3EmZDFHmusTpF0RTcwoyJeqPvigk6+aX2bNJECC+tUgQ/N
 KUbP1kVDBGdaW8jNnatNLV01ny0L8kAQblGyGQ1ONpnD8q2kEPfIupcKhRxrLgNvYFFEpba
 bkBoeW7BaH8TJc+K47y+GOiQncB3rqNB+tuM1iVk6uezW8MUDzfmiKnScEvr6uOC0UwMNVP
 PnufDfoFk2bjgy2s0myfg==
UI-OutboundReport: notjunk:1;M01:P0:hKyuCjYBI5M=;F/yIEsps5KSIm0JL7ke3vh9+MHx
 LH4FkprnFkIoE/lCUjPQMNVdrqpKdZobg3lSHLFgW/nfTyHljGRDMT2P9DhxD7ruxLDhgeYJo
 U2fygasVoZpuXFXOtm8UWJ6rvAx5qbgIxwYsXeEebthyk79TKnj3ssKS4erjY8UZrR9f4fjge
 QVeRafE1bi3il98lfE76m6g7UAtxr+JzuMfbFLMqUZXQwgebkonZ2XPoWc/Dfuz+08cnuNyeD
 qnEtZ4nEQQEHrnKeyJ0tDr191q/32/iI6Fveh2f4o8OEXUA9eEfPdXxOYn4qv+Gpf1Kkrpkal
 K6h1ZvHUAomP7GBAj4NZaSvAEqhdAbl8+gwh5ByZ/GwevzUcdMXQV2spLycoFykkre3WyqRoo
 NiYMM8lopCkEJqFeyKqvWPB0v0m8HA3EgWIgRSOnCIKnObpEfe+LZY4mrByUULWvBCpg1uOKs
 Fl1AQCzm9l5TrwAt1mIEfBKf5YVm15LRtZ9j/XIAeirvCC6HOXT4K7xJ4XS8h9PCd+Udi6/uq
 F34Ws5C9eR1YRaflHXWU+SIHgYADgy1fyMM3274HVHJIjvocrG3pKDCZRBQTXgeP26QoeMU3l
 nJdwHfkCCm+/aQYGV91bZ+t+pdmcqC+qxrNQLkvcCutIC3efKjKdQbFXPFpFmvdBloh91foRN
 31K1J5He527eOv/W9unz7giwjIP5rc0mLUZcJbJzlg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stefan Wahren <stefan.wahren@chargebyte.com>

We need to enable some drivers in order to use the following peripherals
of Tarragon:
  * QCA7000/7005 Powerline chip
  * One-Wire Master DS2484 with external thermal sensors
  * external 4 pin PWM fan
  * ST IIS328DQ I2C accelerometer

Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 6dc6fed12af8..c854b03fabf2 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -128,6 +128,7 @@ CONFIG_CS89x0_PLATFORM=y
 # CONFIG_NET_VENDOR_MICREL is not set
 # CONFIG_NET_VENDOR_MICROCHIP is not set
 # CONFIG_NET_VENDOR_NATSEMI is not set
+CONFIG_QCA7000_SPI=m
 # CONFIG_NET_VENDOR_SEEQ is not set
 CONFIG_SMC91X=y
 CONFIG_SMC911X=y
@@ -215,6 +216,9 @@ CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCF857X=y
 CONFIG_GPIO_STMPE=y
 CONFIG_GPIO_74X164=y
+CONFIG_W1=m
+CONFIG_W1_MASTER_DS2482=m
+CONFIG_W1_SLAVE_THERM=m
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_SYSCON=y
 CONFIG_POWER_RESET_SYSCON_POWEROFF=y
@@ -223,6 +227,7 @@ CONFIG_RN5T618_POWER=m
 CONFIG_SENSORS_MC13783_ADC=y
 CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_SENSORS_IIO_HWMON=y
+CONFIG_SENSORS_PWM_FAN=y
 CONFIG_SENSORS_SY7636A=y
 CONFIG_THERMAL_STATISTICS=y
 CONFIG_THERMAL_WRITABLE_TRIPS=y
@@ -403,6 +408,7 @@ CONFIG_CLK_IMX8MQ=y
 CONFIG_SOC_IMX8M=y
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_IIO=y
+CONFIG_IIO_ST_ACCEL_3AXIS=m
 CONFIG_MMA8452=y
 CONFIG_IMX7D_ADC=y
 CONFIG_RN5T618_ADC=y
-- 
2.34.1

