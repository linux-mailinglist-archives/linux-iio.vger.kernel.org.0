Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDEF618E490
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 22:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgCUVCX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 17:02:23 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42384 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgCUVCX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 17:02:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id t3so4064391plz.9;
        Sat, 21 Mar 2020 14:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kub2Immkly+v0+a50bHcYDmH6E3zS101ZhdlILuqunE=;
        b=D9hWL3zkh0AJQPnHGYZmvkSqSduBQc7IcB6sceLjk5iRaeUfDOSD3Rgf8vybJ22EGi
         mXe5XOKCTmc1r/Lhu5KlgGtxwxHcPacH4243C7O1buCAj/SjWHKFtCXyQCBVxxtMBY+b
         3CLL/cnKpeYNRiV6fzpTZFEFxN8jT2WuzQlIMeijn6Zkf2vfsQlIaqQRAGOUCjQqzz2G
         3Y8bsAhQBOoKTHGVgFGF4EZgLjgMx294CnlraS5vxXRKevaHF4yyQIKtdtNGS30KzWBP
         cJ5ABn+ZH/VrG0AJ4qwYQ4JZdCGqB+X+dssXcCSBI8z900NDAqIYKDGOJzT23FFvkpQ6
         VEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kub2Immkly+v0+a50bHcYDmH6E3zS101ZhdlILuqunE=;
        b=qC0Jfb4QvEDjZ1y7/vAtNY5zfmuM+Iyzvl2mL6eAVGtCzsfQCn+sfyiTdSGtYcM9az
         HNqhkev5ooO+ggf0y8NglxPLydGWXngCmuzkEiGyqIk56GGwUTlB1HDDY75epKOm+1yY
         w0f6kCCrSCpf4JJznEJO3Xb7bUq4AtQRb4tO/UGUoBYRpzbOENmM1ncLODwFa2NQr++M
         s2/ZCBbwixO2891yGRnF1T9FUZKepaqs2nuVXPmQsfm/ER3EnHS01B7jaFEvKjTrGizG
         sTiRoEqGKMb4t0QR4bol9QZRTqn3IvT8GzoVKKYp1Wd9o28SPhyAdYGSvDqAjJNiTaLi
         HRxA==
X-Gm-Message-State: ANhLgQ0epvZdCGtG47CaNbgZRSPbBh6xjpbj7rLQkOI4zW8e/SeqoMwG
        VzW6fwPy1jFt3wJNKFmWH7QVHB3w
X-Google-Smtp-Source: ADFU+vvF5kTEqWE9dOsJ42A61jUlldEtS4m5hwYhJ562Ov4VD2Vr0TaqGBzKdP+ujUdw0Z5jBMH5Tg==
X-Received: by 2002:a17:902:b497:: with SMTP id y23mr14780086plr.81.1584824542492;
        Sat, 21 Mar 2020 14:02:22 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:488:8b8b:892d:8d8:1a6c:acda])
        by smtp.gmail.com with ESMTPSA id a10sm2206947pfi.16.2020.03.21.14.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 14:02:22 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] iio: accel: kxsd9: Use suitable format specifier
Date:   Sun, 22 Mar 2020 02:31:52 +0530
Message-Id: <20200321210204.18106-2-nish.malpani25@gmail.com>
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
 drivers/iio/accel/kxsd9-i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
index 38411e1c155b..39a9daa7566f 100644
--- a/drivers/iio/accel/kxsd9-i2c.c
+++ b/drivers/iio/accel/kxsd9-i2c.c
@@ -21,8 +21,8 @@ static int kxsd9_i2c_probe(struct i2c_client *i2c,
 
 	regmap = devm_regmap_init_i2c(i2c, &config);
 	if (IS_ERR(regmap)) {
-		dev_err(&i2c->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&i2c->dev, "Failed to register i2c regmap %pe\n",
+			regmap;
 		return PTR_ERR(regmap);
 	}
 
-- 
2.20.1

