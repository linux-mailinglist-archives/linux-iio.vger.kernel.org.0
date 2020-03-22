Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 290BF18EACB
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgCVRYL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:24:11 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35229 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgCVRYL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 13:24:11 -0400
Received: by mail-pj1-f65.google.com with SMTP id g9so851073pjp.0;
        Sun, 22 Mar 2020 10:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8skkcssSNgdjneuaiIJV/3MteoLzOQKPwqhS0PAJwH0=;
        b=bNO+ajqVMOKuNqyt8Ks0pRgH46mEaQYeDU3dglfqtaZSPF/GRKj8F+gFOHQRM4XvJc
         6kfTgouljG88qVHp16Dxe1Yu+n+Uf6QasnXbBGqnIB9Y5NnoL7RWwU7mXxt7W6YGguXC
         Dy6hmy56VOQsQCWjda8l22zj7y93zxACT0onI1A3257dLx/zhGmcMJCkCBdpSHrnBEnF
         KrmN0JSZygrvZwW8uhcIwEaQoIftnhHJCEXi4IueSGzAegJJBUTcT06ypXAssErsE3sm
         Po3UTbsOkuvKw0RaP7a7MYIa/flIisYfZIPpvqzJmBdHWAEg4Pj5uexhymgXgyrjfDXu
         br5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8skkcssSNgdjneuaiIJV/3MteoLzOQKPwqhS0PAJwH0=;
        b=Y4r3cnDZoI3Yysj7EV0nSYDpm58cYpnQRVm9fWgHHNUfqFwRm8yXODMHnqaWmfTUR8
         mdmcw9T/JH0UbbjtWyPyqiH+cgblzxvk9ShHQRdDR1k3CsBHtfHKsjlBRzXpjyyGzazC
         N3Odt5UI6vt8CiEQVVIly9xK3FTPJLaZ5mhfINv3+ESDdw5JImounTSOSNKyiJmmJ4GP
         u2JexdTf9MkSFENz49RXz1ZMc0B6/HTdVYIKVRsrH72sJnVFTG0nupkM8MQVDkakfRMH
         p+hgSBR2Z/v2CwQMRY5pZc7ulLWxSre5TN2pe9qO20gsbHpu7bWyDDoTqNL/ZYweyvgL
         MRMA==
X-Gm-Message-State: ANhLgQ2d7fu0CIadMuKnD5UNI4Vwp/OIPBrssSKnJkX4NzUyPHWa2sN0
        tY4fnFIwxD148iwSIDUan10tVEMP3Ds=
X-Google-Smtp-Source: ADFU+vtneQwBjY/P3GkO9+Nje89nzY0/DIhaFvTusi35I9wvusuuVFXYjy/0skykNeF7jmU/GvPcPg==
X-Received: by 2002:a17:90b:3789:: with SMTP id mz9mr20667515pjb.43.1584897849913;
        Sun, 22 Mar 2020 10:24:09 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:992:9f95:b1e5:4cbf:6219:65ee])
        by smtp.gmail.com with ESMTPSA id i6sm11304108pfe.62.2020.03.22.10.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 10:24:09 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/13] iio: imu: inv_mpu6050_i2c: Use vsprintf extension %pe for symbolic error name
Date:   Sun, 22 Mar 2020 22:53:11 +0530
Message-Id: <83719d41f051774c971f5ed87ca1289849092110.1584897364.git.nish.malpani25@gmail.com>
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
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 6993d3b87bb0..28cfae1e61cf 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -122,8 +122,8 @@ static int inv_mpu_probe(struct i2c_client *client,
 
 	regmap = devm_regmap_init_i2c(client, &inv_mpu_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap: %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.20.1

