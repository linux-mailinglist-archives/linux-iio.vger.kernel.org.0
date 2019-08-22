Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCE9999768
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2019 16:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388062AbfHVOww (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Aug 2019 10:52:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32781 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388028AbfHVOww (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Aug 2019 10:52:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id z17so5875741ljz.0
        for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2019 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HSC0kdqpBcc1nAgmhsaUwnIVJoswmjdtkg+yMfuK8Fs=;
        b=j+DOJYcNY2GOAq3/RWk5PSYNPZW5P4LgvDCTZoIj6T5hi0NflNtBCRctINiDswdzvD
         cJRVtDHeQLaLDMUp8K/4R4viUcEHBQQBlV3XWaW2LL69TFfru0c64uLdQiL1GhH1bXHZ
         wiIXblnIP7uiHE4QPYHVsV2mgX4ECre79v1pUmggQNkwJLzkDH1olFZGZFnbhp0aWXUI
         A+32GlFFdm10cS4hTeMMbDFMiLqDeoCgP2jp2sbpAHLk69T5cB45TwEmgCxKMjtXNwnY
         C1zyhd9yB+Uu83tx8nsgq6fdR4iMWOvLIqkUiLquvQJoVkPlMBYREPm3WhqUIbvRKyzO
         luaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HSC0kdqpBcc1nAgmhsaUwnIVJoswmjdtkg+yMfuK8Fs=;
        b=IaxPcc1YK/c4YwkxXvN2Vky7EHf8kC1ptVSaIO6OyHyvY+Z8FlTJS5lKa6Xy9RiDqH
         FswK+3ED8jj6br/CWoNBorMID6Qo5n1SBkGNRrMQPuoHeUGVVqXG/qGWxhWSakwx7ypB
         wyG9/4ioQ6FKTjaUGdWxFE2dTONcZfo7K7NiwLHqFFsAsImY/jE5Zl81Tsi1abTR9n74
         Xcfdvzp7B38BZJElBtAJc6HXBj+wI4J2mOBdQ2XsfqFR8ZWxh05VILZ4e5Zn2AncIijk
         R99KV7/kkmVFB5/6//Sk1pB7Cg6uFeWWTajt+YDevKR8UqdbHf/l3RxP43U+BtshqVqo
         xxZg==
X-Gm-Message-State: APjAAAXVV/oJfC9OQ7TwVaWDOaCJ3oCxGrmdNFIHXjZ/B3UzByh63tSM
        pZ3KAO6fzgxcat1xZwwwU193fA==
X-Google-Smtp-Source: APXvYqybCvfud69pQTRB/rQHdLIJO79hiFNl+horfgpkNudOQEis9IcRGTY3e20HJTqWK3XaLBFIfg==
X-Received: by 2002:a2e:9b02:: with SMTP id u2mr21078993lji.219.1566485569388;
        Thu, 22 Aug 2019 07:52:49 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id s3sm3959374ljj.85.2019.08.22.07.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 07:52:48 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/8 v2] mfd: ab8500: augment DT bindings
Date:   Thu, 22 Aug 2019 16:52:30 +0200
Message-Id: <20190822145233.18222-6-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822145233.18222-1-linus.walleij@linaro.org>
References: <20190822145233.18222-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As we migrate the AB8500 GPADC driver to use IIO, we need to augment
the bindings to account for defining the ADC channels in the device
tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebased on v5.3-rc5
---
 .../devicetree/bindings/mfd/ab8500.txt        | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ab8500.txt b/Documentation/devicetree/bindings/mfd/ab8500.txt
index cd9e90c5d171..05d4b473c7c8 100644
--- a/Documentation/devicetree/bindings/mfd/ab8500.txt
+++ b/Documentation/devicetree/bindings/mfd/ab8500.txt
@@ -69,6 +69,18 @@ Required child device properties:
 - compatible             : "stericsson,ab8500-[bm|btemp|charger|fg|gpadc|gpio|ponkey|
                                                pwm|regulator|rtc|sysctrl|usb]";
 
+  A few child devices require ADC channels from the GPADC node. Those follow the
+  standard bindings from iio/iio-bindings.txt
+
+  abx500-temp		 : io-channels "aux1" and "aux2" for measuring external
+			   temperatures
+  ab8500_fg		 : io-channel "main_bat_v" for measuring main battery voltage
+  ab8500_btemp		 : io-channels "btemp_ball" and "bat_ctrl" for measuring the
+			   battery voltage
+  ab8500_charger	 : io-channels "main_charger_v", "main_charger_c", "vbus_v",
+			   "usb_charger_c" for measuring voltage and current of the
+			   different charging supplies
+
 Optional child device properties:
 - interrupts             : contains the device IRQ(s) using the 2-cell format (see above)
 - interrupt-names        : contains names of IRQ resource in the order in which they were
@@ -102,8 +114,115 @@ ab8500 {
                               39 0x4>;
                 interrupt-names = "HW_CONV_END", "SW_CONV_END";
                 vddadc-supply = <&ab8500_ldo_tvout_reg>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#io-channel-cells = <1>;
+
+		/* GPADC channels */
+		bat_ctrl: adc-channel@01 {
+			reg = <0x01>;
+		};
+		btemp_ball: adc-channel@02 {
+			reg = <0x02>;
+		};
+		main_charger_v: adc-channel@03 {
+			reg = <0x03>;
+		};
+		acc_detect1: adc-channel@04 {
+			reg = <0x04>;
+		};
+		acc_detect2: adc-channel@05 {
+			reg = <0x05>;
+		};
+		adc_aux1: adc-channel@06 {
+			reg = <0x06>;
+		};
+		adc_aux2: adc-channel@07 {
+			reg = <0x07>;
+		};
+		main_batt_v: adc-channel@08 {
+			reg = <0x08>;
+		};
+		vbus_v: adc-channel@09 {
+			reg = <0x09>;
+		};
+		main_charger_c: adc-channel@0a {
+			reg = <0x0a>;
+		};
+		usb_charger_c: adc-channel@0b {
+			reg = <0x0b>;
+		};
+		bk_bat_v: adc-channel@0c {
+			reg = <0x0c>;
+		};
+		die_temp: adc-channel@0d {
+			reg = <0x0d>;
+		};
+		usb_id: adc-channel@0e {
+			reg = <0x0e>;
+		};
+		xtal_temp: adc-channel@12 {
+			reg = <0x12>;
+		};
+		vbat_true_meas: adc-channel@13 {
+			reg = <0x13>;
+		};
+		bat_ctrl_and_ibat: adc-channel@1c {
+			reg = <0x1c>;
+		};
+		vbat_meas_and_ibat: adc-channel@1d {
+			reg = <0x1d>;
+		};
+		vbat_true_meas_and_ibat: adc-channel@1e {
+			reg = <0x1e>;
+		};
+		bat_temp_and_ibat: adc-channel@1f {
+			reg = <0x1f>;
+		};
         };
 
+	ab8500_temp {
+		compatible = "stericsson,abx500-temp";
+		io-channels = <&gpadc 0x06>,
+			      <&gpadc 0x07>;
+		io-channel-name = "aux1", "aux2";
+	};
+
+	ab8500_battery: ab8500_battery {
+		stericsson,battery-type = "LIPO";
+		thermistor-on-batctrl;
+	};
+
+	ab8500_fg {
+		compatible = "stericsson,ab8500-fg";
+		battery	   = <&ab8500_battery>;
+		io-channels = <&gpadc 0x08>;
+		io-channel-name = "main_bat_v";
+	};
+
+	ab8500_btemp {
+		compatible = "stericsson,ab8500-btemp";
+		battery	   = <&ab8500_battery>;
+		io-channels = <&gpadc 0x02>,
+			      <&gpadc 0x01>;
+		io-channel-name = "btemp_ball",
+				"bat_ctrl";
+	};
+
+	ab8500_charger {
+		compatible	= "stericsson,ab8500-charger";
+		battery		= <&ab8500_battery>;
+		vddadc-supply	= <&ab8500_ldo_tvout_reg>;
+		io-channels = <&gpadc 0x03>,
+			      <&gpadc 0x0a>,
+			      <&gpadc 0x09>,
+			      <&gpadc 0x0b>;
+		io-channel-name = "main_charger_v",
+				"main_charger_c",
+				"vbus_v",
+				"usb_charger_c";
+	};
+
         ab8500-usb {
                 compatible = "stericsson,ab8500-usb";
                 interrupts = < 90 0x4
-- 
2.21.0

