Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E13D1DBF07
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2019 09:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbfJRHyf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Oct 2019 03:54:35 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37752 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbfJRHye (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Oct 2019 03:54:34 -0400
Received: by mail-lf1-f65.google.com with SMTP id g21so2841296lfh.4
        for <linux-iio@vger.kernel.org>; Fri, 18 Oct 2019 00:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MWxw1SlnNZbR+8Mgm7ZqnTNHYROTyKAYgDPCnbCu1Oo=;
        b=aqPmswy5qz0iQtCA8i8rJoiOLMW5eabWw46xJZDjYdqlmWxszUJEdOra8VPz7mFYyf
         WUzX87mUjKOt9/wBMjFSomDKI/0XoS++K6SdMKmBFxxDqhKDykQXcp6gKE/B+h1Yanp8
         4DqPbi4MwlsMC3tFg07eCb0s20VahHHCM5eJ5L3EVuSglcNH1MCAlV8fXKEZnOGIyTb/
         OPrYaGdHhtvjbsEUDfN1dvR0FHq8W52jAtNGrH2yia8iAFpCDAHwtFzuUMCT7cCl4CPi
         tqO7+xSo1xv3z/KL2lNTIrsi4XndQv5GbHEIjkecIYpnYaTD4MtEpMR5+xQ3StjIz878
         wFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MWxw1SlnNZbR+8Mgm7ZqnTNHYROTyKAYgDPCnbCu1Oo=;
        b=A1NZul2Cumzxcs2iTBnVHX4mMvwuX0VWBDuAPLk4RBmt/9T5h8SkiaCJalq4+c0/lr
         jCLYNWj8956r4fj9OFzH+2/pm2OhQDfjmX92qB/HN8FRt8ctKNvC0pGCJIv01DHuziy8
         wrxl6YS/ifSmc9Ycq9AxOlZcaNTvxyDmS/rnu9jyS6ZDQsg9DAAV74OakIbZMe+vvAK5
         AkB/PGBzue2WFfzLop4aeg1q+NXZAmJLJKANaK3JhpnormrNOe9njlJxyHY8kiADQDKU
         c6psKa+huNqxigBa5SQsIRvbG/qy7pweOESW1/N8tG3umskg3ylt6nCiHj7NCQzUY5AJ
         WYGg==
X-Gm-Message-State: APjAAAXpAjP8oybMXPinJ59o+k79i1IKRUuJKmb9Aen2vDyCUkTU1KXd
        ODu9HUjr15BZb7SwrAIC8lfpUw==
X-Google-Smtp-Source: APXvYqw00/P5X46mUg3Z+q2E/IR8HgHa7XyK9Mr6k8NLj66Nz7+f/rSWLkamH1G8E1uD2DplyQOZRA==
X-Received: by 2002:a19:ad0a:: with SMTP id t10mr5083459lfc.113.1571385272800;
        Fri, 18 Oct 2019 00:54:32 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id z14sm2061855lfh.30.2019.10.18.00.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 00:54:31 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] mfd: ab8500: Fix up the GPADC binding example
Date:   Fri, 18 Oct 2019 09:54:29 +0200
Message-Id: <20191018075429.5544-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This fixes up the missed device node examples from using
underscores to using dashes as pointed out by Rob.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Jonathan, you can either apply this standalone or
squash it into the previous DT binding patch while fixing
up the Capitalization Of First Word After Dash in the
Subject.
---
 Documentation/devicetree/bindings/mfd/ab8500.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ab8500.txt b/Documentation/devicetree/bindings/mfd/ab8500.txt
index b6bc30d7777e..a4f70f0d653f 100644
--- a/Documentation/devicetree/bindings/mfd/ab8500.txt
+++ b/Documentation/devicetree/bindings/mfd/ab8500.txt
@@ -181,26 +181,26 @@ ab8500 {
 		};
         };
 
-	ab8500_temp {
+	ab8500-temp {
 		compatible = "stericsson,abx500-temp";
 		io-channels = <&gpadc 0x06>,
 			      <&gpadc 0x07>;
 		io-channel-name = "aux1", "aux2";
 	};
 
-	ab8500_battery: ab8500_battery {
+	ab8500_battery: ab8500-battery {
 		stericsson,battery-type = "LIPO";
 		thermistor-on-batctrl;
 	};
 
-	ab8500_fg {
+	ab8500-fg {
 		compatible = "stericsson,ab8500-fg";
 		battery	   = <&ab8500_battery>;
 		io-channels = <&gpadc 0x08>;
 		io-channel-name = "main_bat_v";
 	};
 
-	ab8500_btemp {
+	ab8500-btemp {
 		compatible = "stericsson,ab8500-btemp";
 		battery	   = <&ab8500_battery>;
 		io-channels = <&gpadc 0x02>,
@@ -209,7 +209,7 @@ ab8500 {
 				"bat_ctrl";
 	};
 
-	ab8500_charger {
+	ab8500-charger {
 		compatible	= "stericsson,ab8500-charger";
 		battery		= <&ab8500_battery>;
 		vddadc-supply	= <&ab8500_ldo_tvout_reg>;
-- 
2.21.0

