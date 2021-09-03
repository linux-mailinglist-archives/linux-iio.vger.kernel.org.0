Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5CF400504
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 20:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348738AbhICSo0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 14:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348816AbhICSo0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 14:44:26 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01629C061760;
        Fri,  3 Sep 2021 11:43:25 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d17so60811plr.12;
        Fri, 03 Sep 2021 11:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fYmqh25kodAvkfKVf+rCoALbIA6chWCJ7IIRiFQD7RU=;
        b=Ug/zTBT+GDEgrt9JqqTyBos99G81PwQ3g/XmFrfvBNE+G/O4e9iXEZ5nsf6Aby8GqQ
         57ukRXUL3ohVeXXNwDJeH9ovQOTKQPbGeyIldGFnMLjkKjhYZEoptSrnnysPlobakqJy
         c2oprttSWJfh/VWE7DX82ZxOrbOO9TSj0mjWjQHqPAXXPea7pFGMt8GxYHcaPbnjuKEQ
         MDfaGumIs0uhLyjmhoksq7wGCeTAsNGtHwcT36AuJS861mLx4hCTcjaZuaRiGlxLJmHz
         enriQMLv7HKsLqAGyyoshytLUDHlH4l3o9zdV3I4Or0139MfNTiAWBK+62jCoMqdFHZZ
         ErQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fYmqh25kodAvkfKVf+rCoALbIA6chWCJ7IIRiFQD7RU=;
        b=rXjL+J3H+o/hAazaGBatEgKuzSuFkC5ywQ8yf8rbiQRdUvgm4DtHp8DQttjnkdeA4d
         KQpxvS6BGs2v3dzZ9v7to4u/QEoKWwHbwlNZXPZrDGSqlL9YeRBHDePIGSpotG+zzlUr
         I9WSNMod7nj93KPTHvLuPyZGZuMJCC0dC96I46bgkEaunc0khMXQP1GxSC9zeEdQlVJS
         46Vrh2hDhT9N14Krm4Y2JgqyLEFh47ZGDJHWQ6GQhLuZg9BiCEVxJqF1w6HKXluHfkcn
         aFiygm0Fw8UFq71PAvqtJwJv7ktEfH/1CBjwZD7mHT0UMPz9ckQFheG+pAuojVpeQjBQ
         eMcA==
X-Gm-Message-State: AOAM5327qOx2uu7YvyV9dA6Qr4K8HxKPDbOjLuXuTZ2ArgerujmyXDuc
        Il4kjM2i559D6jSTj+dkais=
X-Google-Smtp-Source: ABdhPJwxCOpDRwwUH82DzVZJv8sx+4EGfJFKXRZM40JGvgT5v4AQGQKAM9+te4s4B+elNmFoFzAVtA==
X-Received: by 2002:a17:90a:1957:: with SMTP id 23mr328597pjh.141.1630694605427;
        Fri, 03 Sep 2021 11:43:25 -0700 (PDT)
Received: from localhost.localdomain ([49.156.122.119])
        by smtp.googlemail.com with ESMTPSA id h4sm128186pjs.2.2021.09.03.11.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 11:43:25 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     jic23@kernel.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com,
        Darius.Berghe@analog.com, andy.shevchenko@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v2 1/2] iio: accel: adxl355: use if(ret) in place of ret < 0
Date:   Sat,  4 Sep 2021 00:13:11 +0530
Message-Id: <20210903184312.21009-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210903184312.21009-1-puranjay12@gmail.com>
References: <20210903184312.21009-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace if(ret < 0) with if(ret) for consistency.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 drivers/iio/accel/adxl355_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index c91d2254c..0b9996c17 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -570,7 +570,7 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->num_channels = ARRAY_SIZE(adxl355_channels);
 
 	ret = adxl355_setup(data);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(dev, "ADXL355 setup failed\n");
 		return ret;
 	}
-- 
2.30.1

