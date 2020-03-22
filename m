Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF61218EAC7
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgCVRYC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:24:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40823 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgCVRYC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 13:24:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id t24so5915190pgj.7;
        Sun, 22 Mar 2020 10:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w5hNnGvnpIBPboxkt9ohs0mcZDvHErpE9oOT4gKmgcE=;
        b=ZWMFjAh/4kLC7XCS7Ew6ChOYVy2XgDxAwWjvNusQbb3+BwebchYdp9EMij2VRDn0E5
         Jrjy7zyDChfmvzcsmPXrv1ug7ACiH2y5yG5aGh+8IKwBzYg9NTmn//tr5fjOXFNzt5T4
         DFbseBRult7wWSxn7Lndgh/rP2Z11kyVW2YCaqDpPl2rmKJCsmwb01slUqmQyp1GRx6p
         zTm/Koe2YCaFbckGdOGqopmgDPL4aCSXdcpN8E/CAE9zEg3PerPW2h+D+DZ7x90Iduwh
         ccKzVU9SEMuiPpoeiCzc4G1XR44hJ423ffFzlWUr8H542FyBW67cvuBLl11InL6UUtEF
         vQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w5hNnGvnpIBPboxkt9ohs0mcZDvHErpE9oOT4gKmgcE=;
        b=tgogaNOyLCnjpgvDmFAY4p6swGUIKeEog+0HUy/+LEzyRG3+bQfcDBO8qb1+vTPHZG
         OwxetSSpVodnIBUAm7pO+ZUtXCG0r1GMRRF0/jeV3Jzujr0y7yTVTZ8s4kpmCfjaLoAe
         WM4yRsw9SWcZxi+d0uxR7xG4Vyq87TySE0dYp9dn2ELsKe1JpL8ga+qoSm0ZCq9KOqHW
         /CFBRk0/bfOHMO5Zz8SOVeFoWrb1hv76vpVc48TAQieI3GtFSAeBO66PrPVD8/LV7c5F
         JedKQnb3+iHQ9eTIOAWgLeCYV7/jqJSUHRpolEKTY+Z13ay/Uj8yJ0Y99ZuUipUvgtWx
         iLVA==
X-Gm-Message-State: ANhLgQ3iZX3kFo9iKdmu591NHwWXnFOpJcg7QxYBCzebrHX1ecBTwQT6
        KeV3CFl2Y5VsygOjKt8z6QzESbNBHig=
X-Google-Smtp-Source: ADFU+vsMIK9dhHMXlazDn+Qwea8VtOReSZ81jim9/nzPxPRTG/1k81p5Wtjp6J62GCqSw1hOewQpug==
X-Received: by 2002:a62:7bca:: with SMTP id w193mr7312858pfc.319.1584897840880;
        Sun, 22 Mar 2020 10:24:00 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:992:9f95:b1e5:4cbf:6219:65ee])
        by smtp.gmail.com with ESMTPSA id g7sm9721173pjl.17.2020.03.22.10.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 10:24:00 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/13] iio: imu: bmi160_i2c: Use vsprintf extension %pe for symbolic error name
Date:   Sun, 22 Mar 2020 22:53:09 +0530
Message-Id: <a43b1f26a000665712039733dfb2b4e0134cac35.1584897364.git.nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1584897364.git.nish.malpani25@gmail.com>
References: <cover.1584897364.git.nish.malpani25@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Utilize %pe format specifier from vsprintf while printing error logs
with dev_err(). Discards the use of unnecessary explicit casting and
prints symbolic error name which might prove to be convenient during
debugging.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---

Changes in v2:
  - Rewrite commit subject line outlining the usage of %pe.
  - Add a separator between regmap and its error name.

Based on conversations in [1] & [2].

[1] https://marc.info/?l=linux-iio&m=158427554607223&w=2
[2] https://marc.info/?l=linux-iio&m=158481647605891&w=2
---
 drivers/iio/imu/bmi160/bmi160_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
index e36f5e82d400..26398614eddf 100644
--- a/drivers/iio/imu/bmi160/bmi160_i2c.c
+++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
@@ -24,8 +24,8 @@ static int bmi160_i2c_probe(struct i2c_client *client,
 
 	regmap = devm_regmap_init_i2c(client, &bmi160_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap: %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.20.1

