Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B806B688B
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 18:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbfIRQ5f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 12:57:35 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34507 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731251AbfIRQ5f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 12:57:35 -0400
Received: by mail-io1-f68.google.com with SMTP id q1so933038ion.1;
        Wed, 18 Sep 2019 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vt0ylMbOHCZnBNswP1adbnaG01l5yqsJyQnU8ZzdrtM=;
        b=pS6kzUsSABU0wWdE/8hAYpTDdDEHmtzLiNOOmAAqM+HBtSxuqbmi5+iQCO1SE56TdR
         OcxRfWj0OkYKDI7i1CcH9xanjEs4I3M64L/xVrbiJyO5upLrth/V9WjEXhbDhM1xe3hq
         DpusZLMhe08NTdu8LHtG7Pb3UoCpata0nvyCq5dQBfg338EdDVhQU0MegkzyqUmM+hnd
         dJ9I0Hbygz2UHBozw+EgQ6IfEQ60LQwumSQF/+RCUbUDgAz1ZNpsZc3MXac9Qm1Q+tfr
         /3cabA5BQnDz9t+KV4mBs/CTw2BezpWrlciOAtNG7ettmP3vGTK8zYqGfQSQf53Z38Pn
         Rh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vt0ylMbOHCZnBNswP1adbnaG01l5yqsJyQnU8ZzdrtM=;
        b=YWBQl592xb5Csbj1IFepegqDmR2l0/qym5LgmkfACrLH5MJ7hIrSwgXRE8GklaXaFF
         3mFZKvnja5H007ELjBMBGns4Jhr8UutQkvihJKerVQUAdeNQSalBK2ApRjdQyHDDRV9C
         hRzzKTENWvYdA3urKUEmUOiD+5s8F7sl9kF/Xx1do4h/EGh5hGOMuqLRVgPR7JPkoCht
         lnucYWKqiC+z/kj2auF0rMX6HW+LIXqzLUu9ROGJhQXVuu0yyPlQTfPoZTIfIV3NeA50
         HOhW/ueWM0t+J6290VmP3r87TbkRq3x/S7uZZRsKQUQp4OZkcKuRhS969Dc584hEjvFH
         S/1w==
X-Gm-Message-State: APjAAAVWqhrQjrhuuEMQ7SIGF5AopS7Hn1TBpZJ4C9WG/Cp01JmbwEYm
        H4y9s/m6VGsx83G5a5157FM=
X-Google-Smtp-Source: APXvYqz5jqKfargpeMxBeQGkSO24qaIY1Qqsc5ZzIGYHkB6YheR0ua6d2swLqQEHe4frMgT6nHjhEA==
X-Received: by 2002:a6b:6c06:: with SMTP id a6mr5917503ioh.306.1568825854324;
        Wed, 18 Sep 2019 09:57:34 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id i20sm4551476ioh.77.2019.09.18.09.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 09:57:33 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: imu: adis16400: release allocated memory on failure
Date:   Wed, 18 Sep 2019 11:57:23 -0500
Message-Id: <20190918165724.3758-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In adis_update_scan_mode, if allocation for adis->buffer fails,
previously allocated adis->xfer needs to be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/iio/imu/adis_buffer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index 9ac8356d9a95..c5d7e368a636 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -78,8 +78,10 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
 		return -ENOMEM;
 
 	adis->buffer = kcalloc(indio_dev->scan_bytes, 2, GFP_KERNEL);
-	if (!adis->buffer)
+	if (!adis->buffer) {
+		kfree(adis->xfer);
 		return -ENOMEM;
+	}
 
 	rx = adis->buffer;
 	tx = rx + scan_count;
-- 
2.17.1

