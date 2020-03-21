Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49A1818E4A8
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 22:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgCUVDT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 17:03:19 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36333 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgCUVDT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 17:03:19 -0400
Received: by mail-pj1-f67.google.com with SMTP id nu11so4117427pjb.1;
        Sat, 21 Mar 2020 14:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K3U7fmyEYyX+IvwOON45NT/bPxq4zbojKTs/T1zDlgg=;
        b=gu51XIlaeq0ktKV5u7yzkquaxiXzZ1nQbRVsc+akrH1yhj1m0DU/m6cFbFmqkYz3hC
         XbrWIGTYM6q55GcsYea7Nn3c8hFH3UAG7xx5f75+//ygXm6iPJwMkGyGOeiyhAEG7zZ+
         lyMEaUdY7e2K/XXnlUP3yxwH9NJKNHK4IqOPoXa4dyFRgQaFd9rxdYWNvtjb6bfMS+UT
         whQe7dL5NxDq881giaAc80mIvJam6Q9Llro9QqnsnkhrL/0UEhXYNtM+enSLyDlNHdLL
         ZY1J+nH8PKAfaQykCtaWPTgWGzWVL56H7LrwlOOAg1n2hOIn10gB7f2UriAzvUxftgm/
         aFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K3U7fmyEYyX+IvwOON45NT/bPxq4zbojKTs/T1zDlgg=;
        b=i02QiyFUguFwfVVvzyxe64wimQzleqd4V+fTts/jCUPF/N7HczoS/q3D8ArHnHhM2W
         25Wd20GH+oaeN4E/V0eiORpo630CjJSO4G45nOOYf/6rvjCUOF6dvLDHthgU/iuV2Taf
         yWk2NmT9xhJfgIzooNW9WE5vRmqXGPCgWyLp+3K617+T2xNLDNZYC7lHESulN53fP80T
         +y7IjA+Fq8ZCVzYVbDIOsT6o5Zc9h+RgJ46aXyfArlGMtv0Y8GV9pPQ04Uwkk/psrwcI
         cnFHwhSGzuoPUPB8YcOyZiB/Nl1qraRm9pU1x+dwdsD8Bs6iv5i4UiOOl3/CiH5ymhkW
         g6lg==
X-Gm-Message-State: ANhLgQ1bIla4lEW3xXn/ByD2VhDDzgJz8fjeEWsWSM7m9ufsaBa83Suw
        GbAIFRrBk5EOm5j9FIckD0ntT5iKw/0=
X-Google-Smtp-Source: ADFU+vuS4wys7i7R2wiGzBkzJy4En0numHwANHdN+Gh7xxWoTQQZwAN91VMb6luKPZVEgJCJntAG9Q==
X-Received: by 2002:a17:90a:7105:: with SMTP id h5mr16772757pjk.54.1584824598265;
        Sat, 21 Mar 2020 14:03:18 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:488:8b8b:892d:8d8:1a6c:acda])
        by smtp.gmail.com with ESMTPSA id l7sm8798436pff.204.2020.03.21.14.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 14:03:17 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] iio: st_sensors_i2c: Use suitable format specifier
Date:   Sun, 22 Mar 2020 02:32:03 +0530
Message-Id: <20200321210204.18106-13-nish.malpani25@gmail.com>
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
 drivers/iio/common/st_sensors/st_sensors_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index 286830fb5d35..6f2f6915107d 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -49,8 +49,8 @@ int st_sensors_i2c_configure(struct iio_dev *indio_dev,
 
 	sdata->regmap = devm_regmap_init_i2c(client, config);
 	if (IS_ERR(sdata->regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap (%d)\n",
-			(int)PTR_ERR(sdata->regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap (%pe)\n",
+			sdata->regmap);
 		return PTR_ERR(sdata->regmap);
 	}
 
-- 
2.20.1

