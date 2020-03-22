Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 532CE18EAC3
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCVRXx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:23:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40999 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgCVRXx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 13:23:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id b1so5914693pgm.8;
        Sun, 22 Mar 2020 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dzqTOr/Ct0ew4Gio7wT8ChawKW/oH3zTwumYAtCINQ0=;
        b=mc8mwqJb2tph04UnQuNmIi0xUe4aSfZZdRsIl93kigK0ytTr8nWtm6atNVmlhUEZZk
         s8GYyH4rxj1IiV2Z2LXsl9LHVfzxbGqDQWjuctTFTEqULoVe8oLJryuCeNGYnL1xyuk/
         bxu0xd1hStFFwutqyHEh4NfxXkH4bRp3SUcZqikiAonpPKKs8I75qXunFo9GDQETTERt
         ePhHVfCpNZBVjVLFp4XNL6VCGeIL3GBIfjDgZ0FLFNs6fjX6G3IMzxisCJ+R0dhA0MWH
         3j57UXC8T1TzQnHIivIThCrxxxayQ7t9GHkIW9UogByzu3eVtdlun19CE6vcLg7QeLpw
         NHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dzqTOr/Ct0ew4Gio7wT8ChawKW/oH3zTwumYAtCINQ0=;
        b=fecmxBD6PhCtLt/NGY1llscU8X12CqEfeyB0HGTDitbyvEB3ZnoGMvPVmLGF6012gg
         kTuc+OQ6BITqlLQPVlxIe9OtNHGhCLBXQZ/rdRD7yz4ze0jmUv3rGI2exW+lEJgX0v+3
         N7jmimShB2IB3tezr9pg/JytyNHy+ULWgj632JGVS+yAxZL5eTfjbX3GbCuCVafdGuad
         cfYrzK0SKjqzXEsCOuEtYNd371jQLuWzjgW2K93PMbbphvHcLYvqaarmIc143uBnY4b5
         3IB8WpStV+ywzPRc4ewqU+bM87HkdISU8Zc6aW4q7Ku1tMmnadC8luUhSKw4Ont9UEL0
         fy1Q==
X-Gm-Message-State: ANhLgQ0w09aO5+jl3y67LNnGoC8tvitTJI4tzQdmRCZLYfpREJ5oNyJC
        +vyVMFJ35wavRF5hEjNZXmZSV2aw8nQ=
X-Google-Smtp-Source: ADFU+vt/tKO9GaS+ii8hHVtciw/r02L0CC3VXZY06TFWTcEUl69vfrk8Gtp2PIbXs0dzzE+WetvJ4Q==
X-Received: by 2002:a62:8342:: with SMTP id h63mr20064246pfe.24.1584897831394;
        Sun, 22 Mar 2020 10:23:51 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:992:9f95:b1e5:4cbf:6219:65ee])
        by smtp.gmail.com with ESMTPSA id 1sm9945022pjo.10.2020.03.22.10.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 10:23:51 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/13] iio: gyro: bmg160_spi: Use vsprintf extension %pe for symbolic error name
Date:   Sun, 22 Mar 2020 22:53:07 +0530
Message-Id: <5f2c696ab083108b18898bcead8489f46d000114.1584897364.git.nish.malpani25@gmail.com>
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
 drivers/iio/gyro/bmg160_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_spi.c b/drivers/iio/gyro/bmg160_spi.c
index 182a59c42507..6f82bbe0ae92 100644
--- a/drivers/iio/gyro/bmg160_spi.c
+++ b/drivers/iio/gyro/bmg160_spi.c
@@ -19,8 +19,8 @@ static int bmg160_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &bmg160_regmap_spi_conf);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap: %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.20.1

