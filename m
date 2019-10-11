Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC5AD39E9
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2019 09:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfJKHS0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Oct 2019 03:18:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44733 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfJKHS0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Oct 2019 03:18:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id m13so8716610ljj.11
        for <linux-iio@vger.kernel.org>; Fri, 11 Oct 2019 00:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JFu7rCKuD+ByHBCarGh0KMIFzVZ6GvSz+ZNE3JQEoM4=;
        b=uAJbXliDW65FifKvUEo3maLLsHPCHYQiINWJD814XdG5Va9WTJ2a1DBfuFUdDswxBW
         detrSQGihH4ttGZBak/2xbIZsPAm3oasA+clpO0nePhN9COMEEC+NidMmIlLDylpy/Oq
         1iFI/dTgTnNzhTFtRRSHq37caEKkKNkyVemTKFoj0DE/w33w1gQzhEbYPO70HPDgr1Ee
         8I+E+ZOw3mj6sOWQq+NAB2+FKq2HvRTM/YnAtqVtJJeq7Bbl6mSbT3S0mskVcoNEk0EP
         sdo7PqZyiKbjb9jhp3giTTQVlgCuFTNHVdWUFulF8wLfd/RKHrz1ZLSmRjaS0cCQlNn4
         pBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JFu7rCKuD+ByHBCarGh0KMIFzVZ6GvSz+ZNE3JQEoM4=;
        b=e+3KP1QDsKoVIO8LKU9WITOkJTwQklVMs/j2YBGilinW+anK82NoSGpkWylEX0AqgM
         J0mY9DmoXKI9Oan2L8dHRrZaDdctSWJq1nAP+HC8EaATY51vsdexI0VXz+tCdmgExhup
         ye+/qMx2iDMif+mVieL1dM2hN+/67m/Q+6OLLR5jSGEEJ4ewj76FzGPyzHVPBPLrQg+k
         ZOXjnfKnCYBLKLdM3vft5WO6kuz29lxWxeDPZa1Gv5HREYHWuOKRhlVCQEcrmw6d8+dg
         zDDeQDKYIYCxTEsGOCI3a5lEE8G+cXunwAtOmgGxpbqf0z0eW15P2INg/phqFMB2vyWP
         fu1A==
X-Gm-Message-State: APjAAAWi0KbL0ByrkxHaVQZYQd474Zsy5g48mR2+t8Pp2WI7M1oeRbgD
        I8psayngdgQ67Nn0CLkB1HQocw==
X-Google-Smtp-Source: APXvYqzcse/E5+76d3oqqcLCnw366VmaaL7jP8oVePL2ywb3cCGBUExaYUsXP37vnr3EPpm94F5iZQ==
X-Received: by 2002:a05:651c:1ad:: with SMTP id c13mr8663314ljn.131.1570778303208;
        Fri, 11 Oct 2019 00:18:23 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v26sm2047343lfg.27.2019.10.11.00.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 00:18:22 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 5/7 v4] mfd: ab8500: augment DT bindings
Date:   Fri, 11 Oct 2019 09:18:03 +0200
Message-Id: <20191011071805.5554-6-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011071805.5554-1-linus.walleij@linaro.org>
References: <20191011071805.5554-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As we migrate the AB8500 GPADC driver to use IIO, we need to augment
the bindings to account for defining the ADC channels in the device
tree.

Cc: devicetree@vger.kernel.org
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Fix the nodenames from "foo_node" to "foo-node"
- Remove 0 prefix from @0n to @n
ChangeLog v2->v3:
- Change "adc-channel@" to "channel@" as per preferred notation.
- Add some full stops to the end of sentences.
- Reference the new ADC-specific documentation for channel specifier
  etc.
- Collect Lee's ACK.
- Rebased on v5.4-rc1
ChangeLog v1->v2:
- Rebased on v5.3-rc5
---
 .../devicetree/bindings/mfd/ab8500.txt        | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ab8500.txt b/Documentation/devicetree/bindings/mfd/ab8500.txt
index cd9e90c5d171..b6bc30d7777e 100644
--- a/Documentation/devicetree/bindings/mfd/ab8500.txt
+++ b/Documentation/devicetree/bindings/mfd/ab8500.txt
@@ -69,6 +69,18 @@ Required child device properties:
 - compatible             : "stericsson,ab8500-[bm|btemp|charger|fg|gpadc|gpio|ponkey|
                                                pwm|regulator|rtc|sysctrl|usb]";
 
+  A few child devices require ADC channels from the GPADC node. Those follow the
+  standard bindings from iio/iio-bindings.txt and iio/adc/adc.txt
+
+  abx500-temp		 : io-channels "aux1" and "aux2" for measuring external
+			   temperatures.
+  ab8500-fg		 : io-channel "main_bat_v" for measuring main battery voltage,
+  ab8500-btemp		 : io-channels "btemp_ball" and "bat_ctrl" for measuring the
+			   battery voltage.
+  ab8500-charger	 : io-channels "main_charger_v", "main_charger_c", "vbus_v",
+			   "usb_charger_c" for measuring voltage and current of the
+			   different charging supplies.
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
+		bat_ctrl: channel@1 {
+			reg = <0x01>;
+		};
+		btemp_ball: channel@2 {
+			reg = <0x02>;
+		};
+		main_charger_v: channel@3 {
+			reg = <0x03>;
+		};
+		acc_detect1: channel@4 {
+			reg = <0x04>;
+		};
+		acc_detect2: channel@5 {
+			reg = <0x05>;
+		};
+		adc_aux1: channel@6 {
+			reg = <0x06>;
+		};
+		adc_aux2: channel@7 {
+			reg = <0x07>;
+		};
+		main_batt_v: channel@8 {
+			reg = <0x08>;
+		};
+		vbus_v: channel@9 {
+			reg = <0x09>;
+		};
+		main_charger_c: channel@a {
+			reg = <0x0a>;
+		};
+		usb_charger_c: channel@b {
+			reg = <0x0b>;
+		};
+		bk_bat_v: channel@c {
+			reg = <0x0c>;
+		};
+		die_temp: channel@d {
+			reg = <0x0d>;
+		};
+		usb_id: channel@e {
+			reg = <0x0e>;
+		};
+		xtal_temp: channel@12 {
+			reg = <0x12>;
+		};
+		vbat_true_meas: channel@13 {
+			reg = <0x13>;
+		};
+		bat_ctrl_and_ibat: channel@1c {
+			reg = <0x1c>;
+		};
+		vbat_meas_and_ibat: channel@1d {
+			reg = <0x1d>;
+		};
+		vbat_true_meas_and_ibat: channel@1e {
+			reg = <0x1e>;
+		};
+		bat_temp_and_ibat: channel@1f {
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

