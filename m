Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD8A18EACF
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgCVRYU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:24:20 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39458 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVRYU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 13:24:20 -0400
Received: by mail-pj1-f66.google.com with SMTP id ck23so4929114pjb.4;
        Sun, 22 Mar 2020 10:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zi/SimNCLHsM6Lyl/4wIByF9nvsrSbfsw/JTVRXPkk8=;
        b=sXZArKyx42yNHqiaaXlaEd/SVBJzNETjGFgFOgPgYMEbiB0DV8HnGx3YCUsySEbEyi
         2MkD/ZzABiiqd5kjHPwsmw4AMFvTJbhy4TUD9D43mLxshBzF5stwkW0X9Sb6ubN0HB+a
         Vfv3H2Lt3wlr35f4pCJndRBDvTNu+2ulQgTXnTTlYcTjPsMG8bb1RUwjvNK4MrR/ICOv
         xhrnp3/R5uz12YI/8Rd60ssmEZv1oTNHuqnpTb+OAJmbjo0V3pnAyZypZgs9p378jzqN
         flg3J5TTbhkNZa2JK7hS7pTQEGzpe14kp22MS8pboKs0Et/NL/CRYxefd4HLeuXmSNfY
         oxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zi/SimNCLHsM6Lyl/4wIByF9nvsrSbfsw/JTVRXPkk8=;
        b=EFvPsvdUufn9dTpBYfk01FwLsOyk9XVlCNZ8iWYGXJVIWaFVjdbJpFVcvEU6HOYdz1
         mQV5HurKU4jUz7MRDFBytJL1OOp/4Q2oemzAxDIxnlWrxyUbc1TMDByS2WNfh+zkCeE6
         9GhEJSLD+mOGcDPbtLi3PQlCg09pvNhLS26IAGKDLt+xBNYnBJ1N16ulpDWK4LMibwIN
         9msFdgLs6x3frxLtEDTX8tGeYL8VSRzI1rcpQGQdQSRhFIkIOJkMJL5ecdUyk3uFmmPj
         6rr9Cj65m/fYOad2v8y/KXk83+TO+eVI2gpRRixj0ijxuXOaGAaNDkkvUnVRf6rq09rP
         Tb5w==
X-Gm-Message-State: ANhLgQ0y5PfFYZXHRHzdkrDc1abStiksWFKOrH8aCX4u5EHdcyx+pizN
        hTXjgvl3X5jvwxm5jtRV1GOaYaF4feU=
X-Google-Smtp-Source: ADFU+vsyP223QwlrvW+Fl5bVftT8aVDmuxSaeBBLYq3SWugUTTnOK1HnO1mESTJQl6dn80VYkpBIHw==
X-Received: by 2002:a17:902:342:: with SMTP id 60mr17358224pld.206.1584897858747;
        Sun, 22 Mar 2020 10:24:18 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:992:9f95:b1e5:4cbf:6219:65ee])
        by smtp.gmail.com with ESMTPSA id z30sm10926569pfq.84.2020.03.22.10.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 10:24:18 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/13] iio: light: st_uvis25_i2c: Use vsprintf extension %pe for symbolic error name
Date:   Sun, 22 Mar 2020 22:53:13 +0530
Message-Id: <b48e846ee7f1fff6f05cd78cd7648f8b4228520d.1584897364.git.nish.malpani25@gmail.com>
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
 drivers/iio/light/st_uvis25_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/st_uvis25_i2c.c b/drivers/iio/light/st_uvis25_i2c.c
index 4889bbeb0c73..801f754bc1a5 100644
--- a/drivers/iio/light/st_uvis25_i2c.c
+++ b/drivers/iio/light/st_uvis25_i2c.c
@@ -31,8 +31,8 @@ static int st_uvis25_i2c_probe(struct i2c_client *client,
 
 	regmap = devm_regmap_init_i2c(client, &st_uvis25_i2c_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap: %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.20.1

