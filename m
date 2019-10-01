Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C886C439A
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 00:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfJAWQU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Oct 2019 18:16:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41913 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbfJAWQU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2019 18:16:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id f5so15047681ljg.8
        for <linux-iio@vger.kernel.org>; Tue, 01 Oct 2019 15:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bRYrFv5LZzF+y6Uvi9sIrsU6F6g13QS5FI1FTdfRPWc=;
        b=Puu13s0EoBqxFd3F6BoMEMsqLJAsUUzrJPu045lbJBGBnAc5LZx6riz5oEyJDJgfkF
         pWe9bW0qc4bGnN2t4AfS6fqPcNJyI8+0JjJxsUdpkhH9wyiLpDyTXcPyrcYn78TG/+rC
         0JdH0782dyLblL/nrOIyImLcLMXLIb8WvMkP2/lfurAFoAafU4jpPqRASqhmkhoAuwFU
         ABUq5ofp5OkrW/j1raG5oex8HpNTOYu6yzc5sotMS4jg+D0HbbFFyDaRa2fMiTaMQlU+
         jkEgSNiDRMnF/Y6NXww+cXftvzJlFaxljk5CMlXIUNICW6JcoSsvz5MzA1rejZtRf+yI
         mbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bRYrFv5LZzF+y6Uvi9sIrsU6F6g13QS5FI1FTdfRPWc=;
        b=jxLqKgTdJERorlMXqaLTl6VN9zEZUpnZCdDtCvsxZMwvU4eu5dgZPBxjtpys/HfqLH
         LAJ8PH3yJAtyWc2+OVp3qh4wB9TP0Nwo9EgH5oXGYc7hFs+v1+kLcPpo8Zd3bQTEtzI9
         JOTXNNeDlzIGPYMI5GIUtEfcLzT5KCcRdBeIj8v1Kvs/aVpgKtLlgYN/U0pTomGcolvK
         Fj+L9zOCz1qoRF2TAYfxv51dnNgHbgrYW1vUfpM2pbsbj1/G8+UW+kbYpX6vxX7ot3ss
         rwbUUEMe692zV0chjYr+1uvXuKZBphBXIn4kJuQJjC5ZrXJD2LfuPr6QvTmm5vVf8vvh
         5P5Q==
X-Gm-Message-State: APjAAAXoGvxsocRPTw7m2Md9RyU7AyCZoFj4cxFc0P6iV1bLYbyLAysc
        tkHoGIKlejmYteXrmPx0SvZSfg==
X-Google-Smtp-Source: APXvYqwBspGY6wtZq30zLAF4lpyjnP61MYQof3i1TNF1KCJyftPGw07TkCtAtmrzVFgDZkJP/U2eKA==
X-Received: by 2002:a2e:9a03:: with SMTP id o3mr104527lji.51.1569968177606;
        Tue, 01 Oct 2019 15:16:17 -0700 (PDT)
Received: from localhost.localdomain (c-79c8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.200.121])
        by smtp.gmail.com with ESMTPSA id z14sm4287855ljz.10.2019.10.01.15.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 15:16:16 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 5/7 v3] mfd: ab8500: augment DT bindings
Date:   Wed,  2 Oct 2019 00:13:54 +0200
Message-Id: <20191001221356.19317-6-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001221356.19317-1-linus.walleij@linaro.org>
References: <20191001221356.19317-1-linus.walleij@linaro.org>
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
index cd9e90c5d171..ff517e5d7ee0 100644
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
+  ab8500_fg		 : io-channel "main_bat_v" for measuring main battery voltage,
+  ab8500_btemp		 : io-channels "btemp_ball" and "bat_ctrl" for measuring the
+			   battery voltage.
+  ab8500_charger	 : io-channels "main_charger_v", "main_charger_c", "vbus_v",
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
+		bat_ctrl: channel@01 {
+			reg = <0x01>;
+		};
+		btemp_ball: channel@02 {
+			reg = <0x02>;
+		};
+		main_charger_v: channel@03 {
+			reg = <0x03>;
+		};
+		acc_detect1: channel@04 {
+			reg = <0x04>;
+		};
+		acc_detect2: channel@05 {
+			reg = <0x05>;
+		};
+		adc_aux1: channel@06 {
+			reg = <0x06>;
+		};
+		adc_aux2: channel@07 {
+			reg = <0x07>;
+		};
+		main_batt_v: channel@08 {
+			reg = <0x08>;
+		};
+		vbus_v: channel@09 {
+			reg = <0x09>;
+		};
+		main_charger_c: channel@0a {
+			reg = <0x0a>;
+		};
+		usb_charger_c: channel@0b {
+			reg = <0x0b>;
+		};
+		bk_bat_v: channel@0c {
+			reg = <0x0c>;
+		};
+		die_temp: channel@0d {
+			reg = <0x0d>;
+		};
+		usb_id: channel@0e {
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

