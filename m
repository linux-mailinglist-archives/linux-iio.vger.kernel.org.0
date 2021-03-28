Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907E434BDDA
	for <lists+linux-iio@lfdr.de>; Sun, 28 Mar 2021 20:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhC1SCZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Mar 2021 14:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhC1SCW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Mar 2021 14:02:22 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36178C061756;
        Sun, 28 Mar 2021 11:02:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so4856398pjb.0;
        Sun, 28 Mar 2021 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLrPxpePKe+LtiSm7QDz7eMtAeP6QmwAE1sgXjH2QAw=;
        b=BaEC2EXljj1cxhwSXJWzOcg0C8k6B/ZuiEmxkwsyu/XF9K/nTj0HZ9NnUY2zHdQBTF
         ZnwA38OT6VTY10SBRqXZqidQ5ckt6t9moH0ulD2iGPAmhyyCDsxuKNnFC9q//gYsBXTa
         xXXtPhXGRaiFjPNbVzx5BiNOKicv9hPKNkxdabIeKQmCVP0r8N2ggtKm330UOhH9+LzU
         gtUw8hm7V/7GsV1zve2spd5ttuzLN+YAzdqCBCDwLDMrpCv5/guvWhg7Yb47AesD5Ms9
         GsVXxFkrxuOqzAvkOA4BBepsZpF9zEuGxbPcQXtNtTOvUP1MCd+iOinAZQizLqhileUP
         Jkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLrPxpePKe+LtiSm7QDz7eMtAeP6QmwAE1sgXjH2QAw=;
        b=d61pyoXKvjciNQ+I31Mfh8idEaiNat5TSHJPLM0IdhNu6yQ5jxK1TXxO174amsnY5O
         xS6IIMywYGb2lodJus401pGhyUm+cJh6eY3DAwwXH6Zf8qjuWrUpd0yX4xKsMwto2my7
         gFajOwtAFCWdzk0/OYE0iHR0ugQdNtW3Clgng3No9smIi3LY500qmkniPVQz2sQpYoEK
         wNrwN6uoqfDnSUNTlG87t/sUJ7TgDYsdhCxcPbZ6HhJUxvpEk+FC1+tFaOmAp4q83ExG
         zecnb58HPSvLtRt5ThgwmC5z2FWGiVC9Ep40wPM83Is0JjCp3xxf+Y42358JCRKwAggN
         4ZzQ==
X-Gm-Message-State: AOAM533huVQhjz0YAnWO88SMzbyOfANm0L5hQ3azWvepQqeBGWhhRA98
        R5uqCaYRHlvqxK3SDvcameY=
X-Google-Smtp-Source: ABdhPJzPuuhrDZq2vmxtq3Kd4ZCOil0iw2b8M6DVjcL7xUQMc7rYYPhi5bR8OikNOVNFbjwJ5N7w8A==
X-Received: by 2002:a17:90a:f28d:: with SMTP id fs13mr22756545pjb.220.1616954541639;
        Sun, 28 Mar 2021 11:02:21 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:21b:917d:6a69:e0c5:1507:d785])
        by smtp.googlemail.com with ESMTPSA id g10sm14046755pgh.36.2021.03.28.11.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 11:02:21 -0700 (PDT)
From:   Mugilraj Dhavachelvan <dmugil2000@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: da280: Drop unnecessarily used braces
Date:   Sun, 28 Mar 2021 23:31:23 +0530
Message-Id: <20210328180124.8762-1-dmugil2000@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As per linux kernel coding style braces are not needed for single
statement.
Checkpatch
warning: braces {} are not necessary for any arm of this statement
128: FILE: drivers/iio/accel/da280.c:128:

Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
---
 drivers/iio/accel/da280.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
index 227bea2d738b..31f290ae4386 100644
--- a/drivers/iio/accel/da280.c
+++ b/drivers/iio/accel/da280.c
@@ -125,11 +125,10 @@ static int da280_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = da280_channels;
 
-	if (ACPI_HANDLE(&client->dev)) {
+	if (ACPI_HANDLE(&client->dev))
 		chip = da280_match_acpi_device(&client->dev);
-	} else {
+	else
 		chip = id->driver_data;
-	}
 
 	if (chip == da226) {
 		indio_dev->name = "da226";
-- 
2.25.1

