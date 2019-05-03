Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F206E128CF
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2019 09:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfECH2g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 03:28:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33018 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfECH2f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 03:28:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id k19so2323768pgh.0;
        Fri, 03 May 2019 00:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BG5vJhn6fxD2HS6uv5WOnrZXuoNwm2WEGnxC4AxOH3M=;
        b=jUoDZV+DCWUU3EUgYBvFKoREV8sJ6B/1Q75rQ5H9tc3KxBOWSt8/3gr1dnh4TFhdfQ
         ga2rbPD5nLju7YKiMQBEfRtUhF/oTwweozr78id4TLzAgpq+ngGV2y7R0vohC0bP7bCj
         zPR9I82nRFHCHKWtgxWam4lgKNnAoao2Tz1rdB0PD2MLrbzgara2d4o7nEcDumCc37AU
         dydBTDKK+loQH0eBRU7X4Iwz9vuolfYjqjDBzfJzTg1TJf11O5mSODS3OvZiYt8KHzpk
         DkK5NN+OTuuCunHlSWR7t4dha6OgAa9lDxf4OGTU6iGZjgN3ywf0L7p9YVaNpOmu982K
         xQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BG5vJhn6fxD2HS6uv5WOnrZXuoNwm2WEGnxC4AxOH3M=;
        b=VQz2A24a+TJuGclQCpB0+CxnZTbw/fVCh/lYdoZFwXv3j1CmuhCEWYTWItpA5Ph5kQ
         ANpGWrUNpw/tww426G07rz1Y8ZGVfUzBktkI6crEystdc1NBfW6ThB4QAMMrN0hxlOb+
         C+zm3pEV0+hc9UMVFIDWYD9eOxiroFTjErLjBAQKAPvJkGYGI2kUDCfMUYT/10oJEWYT
         edv0hgrUTnKpvaKZcXGm7K+CeiPzM+CFWyRLhWNoAK9pQUXcxwh/EhEHiohMEgj4a/g/
         FU1fuhWJV7+m70lySe4ob5p1ZYtTXBUnGutWrIy+076+D8p6zNDEhoEWrd5Yz2S3vFwf
         rn6g==
X-Gm-Message-State: APjAAAULPbCZLPX7bGhgJfoe3XhFBkxJxZhD9YkiBFyJ+kk6kLcpvbzH
        Jxsg46+5xLK8rslaMvPkFbE=
X-Google-Smtp-Source: APXvYqyu8pnDxJZ7NAaHywwAUuyZaCgE1lEL2nntTbOQXneI+4QAq5jkWw32noMF6A8h1uKl77+3Bw==
X-Received: by 2002:a62:5a42:: with SMTP id o63mr9308857pfb.170.1556868514630;
        Fri, 03 May 2019 00:28:34 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id x128sm1892707pfx.103.2019.05.03.00.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 00:28:34 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 5/7] dt-bindings: mfd: Add H6 GPADC binding
Date:   Fri,  3 May 2019 03:28:11 -0400
Message-Id: <20190503072813.2719-6-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190503072813.2719-1-tiny.windzz@gmail.com>
References: <20190503072813.2719-1-tiny.windzz@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds documentation for the H6 GPADC binding.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 .../devicetree/bindings/mfd/sun4i-gpadc.txt   | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
index 86dd8191b04c..eeaf27eb8abd 100644
--- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
+++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
@@ -5,11 +5,22 @@ and sometimes as a touchscreen controller.
 
 Required properties:
   - compatible: "allwinner,sun8i-a33-ths",
+		"allwinner,sun50i-h6-ths",
   - reg: mmio address range of the chip,
-  - #thermal-sensor-cells: shall be 0,
+  - #thermal-sensor-cells: shall be 0 for sun8i-a33-ths,
+			   shall be 1 for sun50i-h6-ths,
   - #io-channel-cells: shall be 0,
 
-Example:
+Optional properties:
+  - clocks: Must contain an entry for each entry in clock-names.
+	    See common clock-bindings.txt for details.
+  - clock-names: A list of clock names. For sun50i-h6-ths, it must contain
+		 "bus".
+  - resets: Must contain an entry for each entry in reset-names.
+	    See ../reset/reset.txt for details.
+  - reset-names: For sun50i-h6-ths, it must contain "bus".
+
+Example1:
 	ths: ths@1c25000 {
 		compatible = "allwinner,sun8i-a33-ths";
 		reg = <0x01c25000 0x100>;
@@ -17,6 +28,18 @@ Example:
 		#io-channel-cells = <0>;
 	};
 
+Example2:
+	ths: ths@1c25000 {
+		compatible = "allwinner,sun50i-h6-ths";
+		reg = <0x05070400 0x100>;
+		clocks = <&ccu CLK_BUS_THS>;
+		clock-names = "bus";
+		resets = <&ccu RST_BUS_THS>;
+		reset-names = "bus";
+		#thermal-sensor-cells = <1>;
+		#io-channel-cells = <0>;
+       };
+
 sun4i, sun5i and sun6i SoCs are also supported via the older binding:
 
 sun4i resistive touchscreen controller
-- 
2.17.1

