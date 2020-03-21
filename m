Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7585518E494
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 22:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgCUVCd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 17:02:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44517 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbgCUVCd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 17:02:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id 37so4951979pgm.11;
        Sat, 21 Mar 2020 14:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vUR4vUI2H/op2Y/GeaRC3yK8z5DR9htwEZKJfMZkURo=;
        b=fZiFHy5m/uYRvrLNjXMZAHrmm5haL1wJZqUUYVS8TFNG8/NdiFbd3Y6lBjmvirjYwW
         yElptqFFX3x4QjtagMJ9sUCunoogB527OHQhQMOaWjL5oXV6DZJvc4+4x89vHMblK/Lr
         adNbi13AdiBjlXf1YH/UZ98u+DdH6O1MDZ+KWjuGf1ydaG01c0GbKomON/AnJarrRGET
         fCjVLp1Vg+qNLG6k+HJgcmrAzPzJJsYQQVgZSh6yW48OcL+RqXlCAP6qX/lgJ9FddIV3
         AFlwoaKt9XA+8bGSHDj4CLPg87EL8r4C5ObV6Ze7gNssuGPMVztSAzyyG/5cjoKoYnVG
         6hKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vUR4vUI2H/op2Y/GeaRC3yK8z5DR9htwEZKJfMZkURo=;
        b=lkxLe4dTaKhzbK3bAHmvmVHA8XqVsl0DitEnIOmUoVLhQvG3jY+5mbujFHVNmA8JvW
         7Oimw1lIsUpSY/JctQOv/osSMTbJdJmXWJh2IQnoS+LwjPZi/3eiNbBISUz6jRGOUbJT
         PR4QRKUljYZZ0+jcYpYFDQBP9Lx8Lnsm0BYpJs+Bc20Fi8AXlRl2Xp5A+AVCDb+4Nijy
         szRX50zVBt0mq6/o3l5wV4kjvCDtCaTPicVYYgD9xv06dqmoq4vQap6kGJJJadUHXPep
         VIyFYmDGAk6Pa/hAnt4rfNWXVpgo7db1emAXAV0SD4wEQwqMM9PPLZCma7TK33ZbzAQO
         5a/w==
X-Gm-Message-State: ANhLgQ2avJ6UAa+RhhVB9NcUxxLLWqKaJRtXarVG2Q7JxwxcF35sZqV7
        WII8zOPo3ROQHkFEcL4tvor38Z8bxco=
X-Google-Smtp-Source: ADFU+vtQ+PHTX+WAs9k6d4ukit5LYDG04hB6kGndxllRgV5Vb29xND6FBoSzeRr9O2/hgaPhudU12A==
X-Received: by 2002:aa7:94b9:: with SMTP id a25mr17083615pfl.193.1584824552520;
        Sat, 21 Mar 2020 14:02:32 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:488:8b8b:892d:8d8:1a6c:acda])
        by smtp.gmail.com with ESMTPSA id i187sm9008831pfg.33.2020.03.21.14.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 14:02:32 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] iio: gyro: bmg160_spi: Use suitable format specifier
Date:   Sun, 22 Mar 2020 02:31:54 +0530
Message-Id: <20200321210204.18106-4-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200321210204.18106-1-nish.malpani25@gmail.com>
References: <20200321210204.18106-1-nish.malpani25@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Provide more suitable format specifiers while printing error logs.
Discards the use of unnecessary explicit casting and prints symbolic
error name which might prove to be convenient during debugging.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---

Based on conversations in [1] & [2].

[1] https://marc.info/?l=linux-iio&m=158427554607223&w=2
[2] https://marc.info/?l=linux-iio&m=158481647605891&w=2
---
 drivers/iio/gyro/bmg160_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_spi.c b/drivers/iio/gyro/bmg160_spi.c
index 182a59c42507..75e63a9214d8 100644
--- a/drivers/iio/gyro/bmg160_spi.c
+++ b/drivers/iio/gyro/bmg160_spi.c
@@ -19,8 +19,8 @@ static int bmg160_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &bmg160_regmap_spi_conf);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.20.1

