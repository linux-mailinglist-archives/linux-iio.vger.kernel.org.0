Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3A4118EAC1
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgCVRXr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:23:47 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50746 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgCVRXr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 13:23:47 -0400
Received: by mail-pj1-f67.google.com with SMTP id v13so4996939pjb.0;
        Sun, 22 Mar 2020 10:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PBNDYvC6Ev7OAYWK0OL9zj6qOnU1gEAJkfPXlmTSuiw=;
        b=FPdMitorrYAb+ZmiVorDTEnesTF0mnBB3k3Ist8wGUmcqhYrwgRIn/J6pQKORKkOoN
         cSx/bIXgm9K7AMD5yiSbOy8tbmmz3fWP3yjZeykXEK/DUAnV1g/ukjB7L1fLeOZb21l4
         zDZQrnCEJeFTACIyOUxEe5kXuRWjnDIJPoel4LTaM2g7xpp9L/gkZkrnWIvw6XkoOBMX
         igevwSqJaZvkwltILXpxVF8iAAHceEZXrVA6P0IyKRwbNCY/Q7U/JqL4NEgotbOZ/FIX
         oPRrC9pgfVrmzKD5BCiJVfUJXCLPGu7t2wxBWPIpgJmMBHweQaHO7xr0LS0xQtKChY3l
         fPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PBNDYvC6Ev7OAYWK0OL9zj6qOnU1gEAJkfPXlmTSuiw=;
        b=Qkcbz4ZcPhojb4fVTTX56mzjwJDvnaf7bjYPttjhEJ0TG6rfrorfqmSzfNoy4jK9IR
         TPAjyEVfSbk18d9puQOS5SG/eV1JIMnpgGCcfUYjlX7zm0cKbmpQtIaRc/OKhlYBvxFo
         gsTKo5uUw3LRaZ0d1L2d7s2IUfOShlTtdFWndv6p/KlJ7DCsdmfW2IldGuLSEQbt3Ac5
         9mrVt0giPW6+WrIuMAP6J7V0qrbdihNTw4AqjExvT82gGRM3tr8mE7QplGPeMLnPgmZd
         RwwJmm/Fy7Mn96Z88lZBgYYbgRVVcVURZ2gnXyArBBD1DeO1jIXaWLQ1nRKI3UEhC3aN
         im6A==
X-Gm-Message-State: ANhLgQ1yt/VrjKdgVLgutOrogGRz9cKdQLUFWDg2Qf3vLpool2iUoMP1
        n3XRIZrElhnZUv+Efh0DIQTio8acEgQ=
X-Google-Smtp-Source: ADFU+vuq5X8Yd0plpiI9zuabaDurqSWHxxEjAcJVCtBAqOBcv+8xGq4+U8uVJMqi3a/i8uUBTGLDWA==
X-Received: by 2002:a17:90a:25c6:: with SMTP id k64mr20638700pje.9.1584897826181;
        Sun, 22 Mar 2020 10:23:46 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:992:9f95:b1e5:4cbf:6219:65ee])
        by smtp.gmail.com with ESMTPSA id j17sm11035078pfd.175.2020.03.22.10.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 10:23:45 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/13] iio: gyro: bmg160_i2c: Use vsprintf extension %pe for symbolic error name
Date:   Sun, 22 Mar 2020 22:53:06 +0530
Message-Id: <5b9a92dee27f406556b4c945f773ef9b5eea825c.1584897364.git.nish.malpani25@gmail.com>
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
 drivers/iio/gyro/bmg160_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
index 4fc9c6a3321f..513473fb2055 100644
--- a/drivers/iio/gyro/bmg160_i2c.c
+++ b/drivers/iio/gyro/bmg160_i2c.c
@@ -21,8 +21,8 @@ static int bmg160_i2c_probe(struct i2c_client *client,
 
 	regmap = devm_regmap_init_i2c(client, &bmg160_regmap_i2c_conf);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap: %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.20.1

