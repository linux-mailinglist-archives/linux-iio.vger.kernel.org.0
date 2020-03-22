Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF3E18EAC5
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCVRX5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:23:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33477 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgCVRX5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 13:23:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id j1so3563224pfe.0;
        Sun, 22 Mar 2020 10:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1XoxW2Qz/sPmq4hkeA1eCu1we+XWlGoqcKYyelXiH0E=;
        b=jZaatfz3o6jPeyPpY5w98ezu2H1KszAkM6VlMeW1RpFLBVmlZTU3Em2iyL74M5QrDW
         lDGwuCA3e1nH4El72kpAPOLRMJkPoI04zKucF8BDfe8ut/eLd4K1jog5aU7YTZJz+0sH
         vgV2sfZ7WEXxzRzCffU0RclRWsZuR8aLD7K1IhX7/NJCS6UvXnJLH1D57lwhuNyg4W+K
         tV0xgQ9dnM0LJrOlVOFT7MGb0WTcC1Kkj1IwZ6eUgh/gaktV74y3HF+3WG57vRoIkyon
         ya1iXmq6U/mFmOlqmeerrWK7iWs8qp/HZ59h5fO/SHDeC9lmmUrzW69JltHcujHAjMOl
         xN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1XoxW2Qz/sPmq4hkeA1eCu1we+XWlGoqcKYyelXiH0E=;
        b=dnhMAQa7yHh1pbN01fhM/r62wuCfQzYdABP3wUe+96dPMUcd4OTZ+DbD3K7CgCJazH
         wlheTnkuHH7Wik4UtMdGH7lxRWdSrlWE+fogDID2r8dFJqY4bpapAXKbdCU1Gogyrb3r
         DWzIwg8mfD43ZrGWocoEPxAF+D9saS5AXUwRy20T++aWEDhVVWfJMoKsFTHMeHN9Y/i+
         g7Qkt8u1mTkkbpzDmKkZW3V3LBhNwx4B3k4zS2NgElGmlBgGkJXcHnn1V4u8TlGDUpRe
         BROCxiUUrURhzaBadPamcT5RnmCC/TmkOoesrdD/eKJG+Lbm6xWysOB8PAbAwluzTSse
         iu2A==
X-Gm-Message-State: ANhLgQ33TF5OEFEBoHmAEtUbtJaGdldxPgLuiUy6KSjHK2h6PQTIiB5z
        I3hWs5SsBRRYdD5UQ6kXCj+PNTs30Tc=
X-Google-Smtp-Source: ADFU+vsBKtlQ7hP0Py3i/H/FP4ZjfGPLa9ZQTvp0HXtEd+ZdadIOQtQAlUXmskgMZKTu00+v9pl9lA==
X-Received: by 2002:a62:b518:: with SMTP id y24mr19347104pfe.261.1584897835386;
        Sun, 22 Mar 2020 10:23:55 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:992:9f95:b1e5:4cbf:6219:65ee])
        by smtp.gmail.com with ESMTPSA id z63sm11018751pfb.20.2020.03.22.10.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 10:23:55 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/13] iio: gyro: mpu3050: Use vsprintf extension %pe for symbolic error name
Date:   Sun, 22 Mar 2020 22:53:08 +0530
Message-Id: <14680ac5ac651c53f050b3f6d2d9a6bd863d5e14.1584897364.git.nish.malpani25@gmail.com>
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
 drivers/iio/gyro/mpu3050-i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-i2c.c b/drivers/iio/gyro/mpu3050-i2c.c
index afa8018b9238..ef5bcbc4b45b 100644
--- a/drivers/iio/gyro/mpu3050-i2c.c
+++ b/drivers/iio/gyro/mpu3050-i2c.c
@@ -51,8 +51,8 @@ static int mpu3050_i2c_probe(struct i2c_client *client,
 
 	regmap = devm_regmap_init_i2c(client, &mpu3050_i2c_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap: %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.20.1

