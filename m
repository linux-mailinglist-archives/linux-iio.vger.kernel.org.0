Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9497718EABB
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgCVRXe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:23:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35960 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgCVRXe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 13:23:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id i13so6270727pfe.3;
        Sun, 22 Mar 2020 10:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yk81mErZFCEgDMsuaSaTdhcTiK3cd7/BpAVh8FBcQdI=;
        b=qZ2nehnjv+2gCtyyn9gCzXpY0kEwRKvLdO1lGZS20r1Kizc/kGTmx63fu3vkp3LbSW
         a/QW1NAbozM6qZs40S75WgGmHQpfU57U3m+UPis8QuJ2lH8M4PwvzUhtH3iGQXSeMN5u
         qpidVeN8Z6d/x4ZtdIxE1yxAbSLVKzYeE4yTmh9dYfY0d4CMyBkRuDnxasiMHWWjGXW5
         +uArhV1EgXL3OR+LIw7HIdo7TZrjSyLyDRtB/cDo+Pe67cykRwq69xwZ9CrQVPytAN7T
         iG1TwBMYnhHfouge5DgdBsslMUNZOamgP0mdt14fBI2WOhQ5KL5SW83DMghUKWinpLvH
         eENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yk81mErZFCEgDMsuaSaTdhcTiK3cd7/BpAVh8FBcQdI=;
        b=PYe7LKxj7C6eNnDirm6lEzoz29yllKOatQDKviEyexQsgKPcIqgMV1gnA5JS8VEZS1
         mF0QrGcSvo8/nxJxw3hdSllymUKmSXw59dMvtuYI9RoAKtg49JgJeKMUd5Pk1IsFGohU
         jy9I/urGm4GzYh/rhSDmOMs3M8D1qblTWFOSgVVVPq1CwNQNg8xZpv/fLShWHw0LYlq4
         2YlEbmI5dyNntYIijGhwBUt3jJMKo0V7XclpCVX2UCWdj/Wc9ux6pTAYcnUVvn4lpooT
         +ux3wIiiCArETVVn3ASPEmHWZXx5gyOCuzpKyQbA6hi6R43Dio/3UikuZ/Fd8x5Cf4lK
         hKDw==
X-Gm-Message-State: ANhLgQ2S85/2eyZmAtq9VfG+DFvLsn8s3jWilPv5gspEkdBqj9qDp3W/
        O2i3Xtck/6WaiS6g6vujZn9tLU7r0TY=
X-Google-Smtp-Source: ADFU+vuecAdf9WbLOP2y4B7fzlEFGqZXDooDGiyEesPGMxX3AwZ3d/PphdRY3HsiBCTdhE2V9fwCtA==
X-Received: by 2002:a63:ce42:: with SMTP id r2mr19145525pgi.106.1584897812737;
        Sun, 22 Mar 2020 10:23:32 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:992:9f95:b1e5:4cbf:6219:65ee])
        by smtp.gmail.com with ESMTPSA id 8sm11196331pfv.65.2020.03.22.10.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 10:23:32 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/13] iio: accel: kxsd9: Use vsprintf extension %pe for symbolic error name
Date:   Sun, 22 Mar 2020 22:53:03 +0530
Message-Id: <9fcebba578c1fe0b02bd1053e5b4d0ba4299452d.1584897364.git.nish.malpani25@gmail.com>
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
 drivers/iio/accel/kxsd9-i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
index 38411e1c155b..b6f3de7ef8ea 100644
--- a/drivers/iio/accel/kxsd9-i2c.c
+++ b/drivers/iio/accel/kxsd9-i2c.c
@@ -21,8 +21,8 @@ static int kxsd9_i2c_probe(struct i2c_client *i2c,
 
 	regmap = devm_regmap_init_i2c(i2c, &config);
 	if (IS_ERR(regmap)) {
-		dev_err(&i2c->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&i2c->dev, "Failed to register i2c regmap: %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.20.1

