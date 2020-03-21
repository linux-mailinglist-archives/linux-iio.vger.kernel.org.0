Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32ECC18E4A2
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 22:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgCUVDJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 17:03:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37763 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgCUVDI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 17:03:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id x1so51940plm.4;
        Sat, 21 Mar 2020 14:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ou1806hZf5a6/SMiX5rJwc8I8qad8Hu9TTDtljd6kFk=;
        b=Acd88lIXt4JBBB3qWa9Gttt9jpjepRhlj4xeChI7qgwVnpwg4DC1ZzwH8dgxlRQMSq
         cLZBLFDLf1LQ7bE/B9XFZ6oFQPLQzwVOp1ZPNmTiouVtbdc9BN3QL5AV/a/1kKJ433Z0
         Sgyxst6XS3ygjGCBbckWjebLKM1wtxsTseCYgprIbhyORQd5Lwj8o+cAzLFd95zAV8Zq
         8oM2PxiTy/zWL9uSQs72b2RNecue374D2oty0CQCZwJTVqSv1kNhBsR2R74Gl3lfCiO1
         YiEsZxZGaP/5tXMAZscnJ1uduISMzSaC2t1Zp7brugcRtieKk0ufUWiAkEjS+MKul4YA
         jNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ou1806hZf5a6/SMiX5rJwc8I8qad8Hu9TTDtljd6kFk=;
        b=GfN2Alv1lweQd8YvLmCjlU4DDbTQMkYa7HNnlIPUT3tc107bDedr++F6WJJgDzBjfk
         OXyhrPelRmpW+g76qGRaIYPYJsD0frkMNXaif8b1IBNBU8jJv0Q7SJ+fal1s3UJADSDc
         HP5h1cMSYdXk8RNKUjdHiirbUkUsjBnFZaRTG+FLNsckTNRtX7+cCXO91nxoq3YMmM9X
         nvU7I4zkuUBoq3fHgLUbQlh37wZGXEGyhnW0HQSip5FZNmhO5NKBzIDbMXguoWj+5eN0
         U2xGqbscfZEIXiY8XH9ZA4oFF76Tom5n5NG8D99fX51jTTJ/84co2yzHVwytnC0ZTxPl
         09ug==
X-Gm-Message-State: ANhLgQ07RozaVz55ApeHW1xnRjp4Pbz4a2h5R12x1milse+ll3hMWTak
        UX9QPVJv6s5QbjcTIbADI3OP2+Ltf5Y=
X-Google-Smtp-Source: ADFU+vtmQR3dybuZFcLjBToEkfSMA6oyJrDnsyNdNEclibBjfvJftnnifZAf+u+8oKLKAS1ygRRcmA==
X-Received: by 2002:a17:90a:9a90:: with SMTP id e16mr16580895pjp.164.1584824587664;
        Sat, 21 Mar 2020 14:03:07 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:488:8b8b:892d:8d8:1a6c:acda])
        by smtp.gmail.com with ESMTPSA id z26sm7424131pgc.5.2020.03.21.14.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 14:03:07 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] iio: light: st_uvis25_i2c: Use suitable format specifier
Date:   Sun, 22 Mar 2020 02:32:01 +0530
Message-Id: <20200321210204.18106-11-nish.malpani25@gmail.com>
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
 drivers/iio/light/st_uvis25_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/st_uvis25_i2c.c b/drivers/iio/light/st_uvis25_i2c.c
index 4889bbeb0c73..7a1185a874e0 100644
--- a/drivers/iio/light/st_uvis25_i2c.c
+++ b/drivers/iio/light/st_uvis25_i2c.c
@@ -31,8 +31,8 @@ static int st_uvis25_i2c_probe(struct i2c_client *client,
 
 	regmap = devm_regmap_init_i2c(client, &st_uvis25_i2c_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.20.1

