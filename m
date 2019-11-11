Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A980AF77D4
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 16:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfKKPfo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 10:35:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36364 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfKKPfo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 10:35:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so15142950wrx.3;
        Mon, 11 Nov 2019 07:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rD8E1HPF+kOqPGWZ3GSIUtW8sHwcCfuIMp81Lz9qagk=;
        b=olV39VV2bMicVYtgEJMOEP/I/sVYYRwQT2FNCGB1ptoPCUallX/tABIsl3iUdZvpYs
         eo/QGZPWAvkq/L9wgbTJDg7biGY0HXEG14HcW+5UA71IU1smWMNepR6dMMwWoPfH/UzZ
         xOBETnYiFv/Os1mE9BNgvFVafWye2Y5X8iccT2W+kLeeQBZ869cmiLcAt3cf+96URuM1
         iDjKSk0XkP1RJC8fkhkKhwRk5F8opKWauO9tYb+4zqi68vRfCMV5kz7e8BF2VS3GUZ3q
         1oW+v7ijQ+6L0dyQkKhM1LgSNZa4c+PJDY5DGsShaLCVcGhASWcsqzn5TLqN+GXfnQew
         H0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rD8E1HPF+kOqPGWZ3GSIUtW8sHwcCfuIMp81Lz9qagk=;
        b=jNvDW+NufJOeNQLuwvahwKJ6WaMAULmyAfm89FmNU10xXJgjdw4v6RwRQ4Wxxw+sUd
         DBn6srB57TwConNftabF4ClRBEyhggdGwuwnm2cm4+/Y4OfuSzWI3PRVqimc/kuJS8Lm
         kikUTZgEkQWE5SSz9ttCYTjhkD8K87okaKFJZneYVM0iHrakQzd7w2Owvh44q+Ju8OH0
         ftn5WQXysQTZ/TW8TWkubrXfQRRnSwyxT53/T0kwuQ5BMbbIUEJ1JiGLOmjUSr4Ledpg
         N4l5ubvcHOILzCWG3fsRadYTzCIzXEir3JUGkXhuLcWTpUYYNq86dR/cPLJC4wQ63pZx
         y4jg==
X-Gm-Message-State: APjAAAWedOd8/v66iKd8ik7+HbjvwTTRdEL10+u57b/n0Ns9f1K86PUv
        9qVhTJy7rg76x393mSrDTdQ=
X-Google-Smtp-Source: APXvYqzlisNq1rGjkud0bmNturkoWzuTDKeymsCfDn0F5kl3m+JUf4GWYBbqVaM75zrttJ2gk/2gzg==
X-Received: by 2002:adf:fd91:: with SMTP id d17mr21001670wrr.214.1573486541905;
        Mon, 11 Nov 2019 07:35:41 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id w81sm23965657wmg.5.2019.11.11.07.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 07:35:41 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [v2 9/9] dt-bindings: iio: maxim_thermocouple: document new 'compatible' strings
Date:   Mon, 11 Nov 2019 16:35:17 +0100
Message-Id: <20191111153517.13862-10-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111153517.13862-1-andrea.merello@gmail.com>
References: <20190923121714.13672-1-andrea.merello@gmail.com>
 <20191111153517.13862-1-andrea.merello@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Now the maxim_thermocouple has new, more specific, 'compatible' strings for
better distinguish the various supported chips.

This patch updates the DT bindings documentation accordingly

Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Cc: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Cc: Matt Weber <matthew.weber@rockwellcollins.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Chuhong Yuan <hslester96@gmail.com>
Cc: Daniel Gomez <dagmcr@gmail.com>
Cc: linux-iio@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 .../bindings/iio/temperature/maxim_thermocouple.txt        | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt b/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
index 28bc5c4d965b..bb85cd0e039c 100644
--- a/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
+++ b/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
@@ -5,7 +5,10 @@ Maxim thermocouple support
 
 Required properties:
 
-	- compatible: must be "maxim,max31855" or "maxim,max6675"
+	- compatible: must be "maxim,max6675" or one of the following:
+	   "maxim,max31855k", "maxim,max31855j", "maxim,max31855n",
+	   "maxim,max31855s", "maxim,max31855t", "maxim,max31855e",
+	   "maxim,max31855r"; the generic "max,max31855" is deprecated.
 	- reg: SPI chip select number for the device
 	- spi-max-frequency: must be 4300000
 	- spi-cpha: must be defined for max6675 to enable SPI mode 1
@@ -15,7 +18,7 @@ Required properties:
 Example:
 
 	max31855@0 {
-		compatible = "maxim,max31855";
+		compatible = "maxim,max31855k";
 		reg = <0>;
 		spi-max-frequency = <4300000>;
 	};
-- 
2.17.1

