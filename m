Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3807318EACD
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCVRYR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:24:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41019 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVRYQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 13:24:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id b1so5914999pgm.8;
        Sun, 22 Mar 2020 10:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jqDwAwDGYi3NjtIZPjj59FRaeNL8mMNiw+rFwyMaw8M=;
        b=eQv8Vxi5OCtu4KAToedqOkuDXWQiXchP3R10tDzmOjvd9NTfj5VaYfYVYESJdWNJjI
         QIkQn92i+rpHA289Hf5BB7aP78ABuCKG3tgaL1pI7pFJUeSfN+IKHsFvewpocu6wv4k8
         2LO/x+JXCGK/QGhayGciV3nuOp5xbOxNY3/vs8bZmkO+LCts5e2KYqdtO/Ecuhq3fWaQ
         DXM/Is5ONijFveR+lZ903Rw/VTWmfwDCB523u06dUGv4GvLxtLi1WwwsmQ1X/lKedleH
         45cnooWX645BgzSb4cAHefustE2bbdM3Sx2boVwfnyvfeaaoRM4N5807HSXK2zK/wYJE
         VQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jqDwAwDGYi3NjtIZPjj59FRaeNL8mMNiw+rFwyMaw8M=;
        b=UCmG3jwg6CH0zn+Bpa969+WBIkWq/jY0UZ5bTjlbcXwEplni6GP900wcvEldZbek2S
         owFtrBj0YLq+sAO+AOqg9fZdIBjGY4YboIDaQwUZYsm82G5IgST3hNmAIpoJkLaLZzTG
         VoKdlaXeMHZAOk60GWpaAAQbRNP4Bwp0qmNFwc/uoP+PYF2xV/8HaII/IDa6AbLe2Hmm
         798P1ey3wgONTH9fI7lrviQzZFdGlY+qD+JvNsp62TtVWzsi/Kmcn2rnBTre8030YyJ2
         87TEI0LcHhCiHTDoGCdeyRcnIUrSmD1/ve93YpmoI7gF+UxJy4oDwJbS6ar3Zxo4/+cs
         HWhQ==
X-Gm-Message-State: ANhLgQ1AcN6lvTUNSU/60u61eBksUDWHfO3mPlhsGWu4PHnj73eecH1K
        AkJ2l6ESw9G2hZRMwzfAlR5OzBe+Lkk=
X-Google-Smtp-Source: ADFU+vsVQSOLM3hwr9igAdfIqoczKO9VGnvOhPOd3BRgd98WflVLEYRd3f27umnu9InNXNeqU8xvKw==
X-Received: by 2002:a63:6ac1:: with SMTP id f184mr18713650pgc.212.1584897854957;
        Sun, 22 Mar 2020 10:24:14 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:992:9f95:b1e5:4cbf:6219:65ee])
        by smtp.gmail.com with ESMTPSA id g2sm3766422pfh.193.2020.03.22.10.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 10:24:14 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/13] iio: imu: inv_mpu6050_spi: Use vsprintf extension %pe for symbolic error name
Date:   Sun, 22 Mar 2020 22:53:12 +0530
Message-Id: <99e93b0103a6af19d8c7b85cfefb3055e5d0b06a.1584897364.git.nish.malpani25@gmail.com>
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
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 673b198e6368..6f968ce687e1 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -53,8 +53,8 @@ static int inv_mpu_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &inv_mpu_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap: %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.20.1

