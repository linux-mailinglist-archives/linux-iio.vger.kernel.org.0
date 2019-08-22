Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDF49976A
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2019 16:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388080AbfHVOxA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Aug 2019 10:53:00 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39938 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388063AbfHVOw7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Aug 2019 10:52:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id e27so5835014ljb.7
        for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2019 07:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X3giqqvdL73X1HohTTao8OWEGjQFJPkRF3R7ZLoQMag=;
        b=F3yjKQcs3I0L/4MbrKRzepnc7ib5XiN+ckAPZqRzDSzO1RD9WjA1Tp4evUD7/HHXkX
         dpMJby6BpKARM2dkCVZkG5jc9kgBNPePBSkJO0I38+YHeXWdU5Vo/ydk6F8O9WxhF699
         ki19weB6OjtSnioo2s2RjmL4Xs/d5Cw/ZrfYEPzXaxU7BkvMC1pPcBe9pkXesNEr9K1d
         52ra7bJnaE1kER7m2JYv5Gk+pgdxxk+H5M7m4yBlrpSAOu9qAXbdefxbGDPuBSHdqQSa
         1H3RzDacnSvtJlrvPS9ANnQOQxJ5RokG7BqA5baw4UTPezKugzBiSGCF8hMaEpgoMsJ4
         Lk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3giqqvdL73X1HohTTao8OWEGjQFJPkRF3R7ZLoQMag=;
        b=JrE4Z24PVKkQBhjzLvykSUbvqGJhal0GJ9bLUs4UrxRijWWLUGUIUwC+K4iDKFimwW
         6u5zioeGSokwUYZ7FhhS2IiwhJTyQmp9vpMgcrm8SZB0cctPulgC9NqOL4+7+3CrGJco
         4euKfQ0EaI/1MDod4ssRvlVul+WEyYktLxl6lJgICYvpkdruG6eKgQZAGbaxSwUQ/N25
         O9W8KksWdl5PEutqLdEQoxMRRcYhhSFC6l57FJqamzEHS87hyy6En+peh/r8hVP9rH4p
         Gm6PcJdkgb5DJOc31nPrLMPO4QYPjS7Rjx/znS1U/Dt2FADDR4A5Mg4p8diuoP+dTBRT
         wwFQ==
X-Gm-Message-State: APjAAAXA9DxH/eKhpd6VFeZ6X4QX3XEsXZpSvRnEWWpEvWgET7KBQNzT
        LYCl6Kf85Dn2QXOX5qVLJQEOuQ==
X-Google-Smtp-Source: APXvYqxYHOQNmGzGvc+bSROtGHXUoyo8jbN24AJG8T8/0Zl3TSG3A1uVFK3yFrInurmpt7GsDlolQw==
X-Received: by 2002:a2e:b042:: with SMTP id d2mr21393562ljl.202.1566485576834;
        Thu, 22 Aug 2019 07:52:56 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id s3sm3959374ljj.85.2019.08.22.07.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 07:52:54 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 8/8 v2] ARM: dts: ux500: declare GPADC IIO ADC channels
Date:   Thu, 22 Aug 2019 16:52:33 +0200
Message-Id: <20190822145233.18222-9-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822145233.18222-1-linus.walleij@linaro.org>
References: <20190822145233.18222-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds the IIO channels for the GPADC after converting it
to using the standard IIO ADC bindings and moving the driver
over to the IIO subsystem. We also add IIO hwmon standard
driver node to support reading channels in a standard manner.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebased on v5.3-rc5
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 102 +++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index b1a31134f860..80016521333b 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -52,6 +52,20 @@
 		};
 	};
 
+	/* Essential housekeeping hardware monitors */
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&gpadc 0x02>, /* Battery temperature */
+			    <&gpadc 0x03>, /* Main charger voltage */
+			    <&gpadc 0x08>, /* Main battery voltage */
+			    <&gpadc 0x09>, /* VBUS */
+			    <&gpadc 0x0a>, /* Main charger current */
+			    <&gpadc 0x0b>, /* USB charger current *
+			    <&gpadc 0x0c>, /* Backup battery voltage */
+			    <&gpadc 0x0d>, /* Die temperature */
+			    <&gpadc 0x12>; /* Crystal temperature */
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -623,12 +637,84 @@
 					interrupt-names = "60S", "ALARM";
 				};
 
-				ab8500-gpadc {
+				gpadc: ab8500-gpadc {
 					compatible = "stericsson,ab8500-gpadc";
 					interrupts = <32 IRQ_TYPE_LEVEL_HIGH
 						      39 IRQ_TYPE_LEVEL_HIGH>;
 					interrupt-names = "HW_CONV_END", "SW_CONV_END";
 					vddadc-supply = <&ab8500_ldo_tvout_reg>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#io-channel-cells = <1>;
+
+					/* GPADC channels */
+					bat_ctrl: adc-channel@01 {
+						reg = <0x01>;
+					};
+					btemp_ball: adc-channel@02 {
+						reg = <0x02>;
+					};
+					main_charger_v: adc-channel@03 {
+						reg = <0x03>;
+					};
+					acc_detect1: adc-channel@04 {
+						reg = <0x04>;
+					};
+					acc_detect2: adc-channel@05 {
+						reg = <0x05>;
+					};
+					adc_aux1: adc-channel@06 {
+						reg = <0x06>;
+					};
+					adc_aux2: adc-channel@07 {
+						reg = <0x07>;
+					};
+					main_batt_v: adc-channel@08 {
+						reg = <0x08>;
+					};
+					vbus_v: adc-channel@09 {
+						reg = <0x09>;
+					};
+					main_charger_c: adc-channel@0a {
+						reg = <0x0a>;
+					};
+					usb_charger_c: adc-channel@0b {
+						reg = <0x0b>;
+					};
+					bk_bat_v: adc-channel@0c {
+						reg = <0x0c>;
+					};
+					die_temp: adc-channel@0d {
+						reg = <0x0d>;
+					};
+					usb_id: adc-channel@0e {
+						reg = <0x0e>;
+					};
+					xtal_temp: adc-channel@12 {
+						reg = <0x12>;
+					};
+					vbat_true_meas: adc-channel@13 {
+						reg = <0x13>;
+					};
+					bat_ctrl_and_ibat: adc-channel@1c {
+						reg = <0x1c>;
+					};
+					vbat_meas_and_ibat: adc-channel@1d {
+						reg = <0x1d>;
+					};
+					vbat_true_meas_and_ibat: adc-channel@1e {
+						reg = <0x1e>;
+					};
+					bat_temp_and_ibat: adc-channel@1f {
+						reg = <0x1f>;
+					};
+				};
+
+				ab8500_temp {
+					compatible = "stericsson,abx500-temp";
+					io-channels = <&gpadc 0x06>,
+						      <&gpadc 0x07>;
+					io-channel-name = "aux1", "aux2";
 				};
 
 				ab8500_battery: ab8500_battery {
@@ -639,17 +725,31 @@
 				ab8500_fg {
 					compatible = "stericsson,ab8500-fg";
 					battery	   = <&ab8500_battery>;
+					io-channels = <&gpadc 0x08>;
+					io-channel-name = "main_bat_v";
 				};
 
 				ab8500_btemp {
 					compatible = "stericsson,ab8500-btemp";
 					battery	   = <&ab8500_battery>;
+					io-channels = <&gpadc 0x02>,
+						      <&gpadc 0x01>;
+					io-channel-name = "btemp_ball",
+							"bat_ctrl";
 				};
 
 				ab8500_charger {
 					compatible	= "stericsson,ab8500-charger";
 					battery		= <&ab8500_battery>;
 					vddadc-supply	= <&ab8500_ldo_tvout_reg>;
+					io-channels = <&gpadc 0x03>,
+						      <&gpadc 0x0a>,
+						      <&gpadc 0x09>,
+						      <&gpadc 0x0b>;
+					io-channel-name = "main_charger_v",
+							"main_charger_c",
+							"vbus_v",
+							"usb_charger_c";
 				};
 
 				ab8500_chargalg {
-- 
2.21.0

