Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 970D234ACA
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2019 16:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfFDOrV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Jun 2019 10:47:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36083 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfFDOrU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jun 2019 10:47:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so13104094wrs.3
        for <linux-iio@vger.kernel.org>; Tue, 04 Jun 2019 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bLDsai7BCDJ9/WAFUmOmDJ4D/4W6/bXgG+qdhNwcZhk=;
        b=iNBvPjb5Qy21/12AvtkoRo4IHAm41Wg4Vk0nBhVKAQXzW/FfWktrlAJB1cx60YTjZN
         pYT8vqd6X/6JxxL9Q2aDSrZhJTO8FGCMZjYSJ5YlrT0gcbOLrUoxbTCpOJhoo0WVj4uS
         qaihsQHl5/DKak5ZC4VFsTKtIgy1bcly73SbJxXYkhpOuPjvu72uV4TFbFhLE4u3db1x
         XBPLS2/aV/kZr/v/fqELn48ZEdCAlNPLQJ879P7p7ggyomOArRwgIWvmJZa1MtjT8tc2
         kZ2WrTjGxBjbXU7Ioqw6JIRq/dfUL+mD1M9xuYkST96HZDAcr4mgLkbPuWKE5Xr5iIM5
         KumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bLDsai7BCDJ9/WAFUmOmDJ4D/4W6/bXgG+qdhNwcZhk=;
        b=MZc68nyMu/n/D0HLYmzIKZvwY1TAwbi1PX/pHaGxM5efLwuYQXthDQ+w2YcGHXXYNf
         j3GnSKm1Fpjx5fQCZOA69vgQq3m7td9dicVYxyEdu8iQ+HuxJmy7zasIpUj14eLjCALP
         Wn3XGGu+R77v9j3vNMWZlQC6MXWKCAwjqoT2Jv4+933w5wrNuH1KS/VEJyptvLfN8Usj
         iI1eAxfy5xEfjph3SVo7tQsT0BNVClP/M9l6sXHK2YhnjNl+R8UkMP880wffnMjxUn0t
         7m6U74unUkFMqaNlrRq/zFS7LnB/aQqf9oGN3ABNmmvYtLXYydZEoXr44KbGt3vyZHWs
         qhrQ==
X-Gm-Message-State: APjAAAWJedDZ1/MyX3afOBkqBeXCZ0+EHRV9fhEDLCuuECdyiFojs/vc
        Rci9BudAeUnPzZnuztV6Ns0n9Q==
X-Google-Smtp-Source: APXvYqw4x2gWBkZ94JwAp/u/xenQcH6trywYc6ypCThQKgduCn+6apBhkSU1BFXr5dezDKoFoQcCDw==
X-Received: by 2002:a5d:62c9:: with SMTP id o9mr19704199wrv.186.1559659638823;
        Tue, 04 Jun 2019 07:47:18 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v184sm3649639wme.10.2019.06.04.07.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 07:47:18 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     jic23@kernel.org, khilman@baylibre.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: meson: g12a: add temperature sensor node
Date:   Tue,  4 Jun 2019 16:47:13 +0200
Message-Id: <20190604144714.2009-3-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604144714.2009-1-glaroque@baylibre.com>
References: <20190604144714.2009-1-glaroque@baylibre.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add two temperature sensor
the first near CPU and GPU, second near DDR

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 22 +++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 840dab606110..37f17087bdb1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -1360,6 +1360,28 @@
 				};
 			};
 
+			cpu_temp: temperature-sensor@34800 {
+				compatible = "amlogic,meson-g12a-cpu-tsensor",
+					     "amlogic,meson-g12a-tsensor";
+				reg = <0x0 0x34800 0x0 0x50>;
+				interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_TS>;
+				status = "okay";
+				#io-channel-cells = <1>;
+				amlogic,ao-secure = <&sec_AO>;
+			};
+
+			ddr_temp: temperature-sensor@34c00 {
+				compatible = "amlogic,meson-g12a-ddr-tsensor",
+					     "amlogic,meson-g12a-tsensor";
+				reg = <0x0 0x34c00 0x0 0x50>;
+				interrupts = <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_TS>;
+				status = "okay";
+				#io-channel-cells = <1>;
+				amlogic,ao-secure = <&sec_AO>;
+			};
+
 			usb2_phy0: phy@36000 {
 				compatible = "amlogic,g12a-usb2-phy";
 				reg = <0x0 0x36000 0x0 0x2000>;
-- 
2.17.1

