Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE0EB7EA4
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2019 17:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391513AbfISP4t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Sep 2019 11:56:49 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37827 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391497AbfISP4t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Sep 2019 11:56:49 -0400
Received: by mail-io1-f66.google.com with SMTP id b19so8963104iob.4;
        Thu, 19 Sep 2019 08:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xCZU3ZuGDFmyKvSHiIjw6ozCsgcZDsXDyKFpwiyTyY0=;
        b=n/02eVYQoElD5Gs42q5VHvsODAgwkQY/wIOOftJZdGoPLqcm1rMTemcsfYzbgaj7ne
         SE5sJ75dmR5fIVOOO6k6PM4ZJeI1BVGcVI3BIW0G8ZH1SuLYaY5CFkJaXslvwdDCmjTe
         saPoeXP2qrSuKrkD8UCkbQreeQoRWkFMVMeN4G5mczImDX+5BEcRQ3sk5P3OEj0WGfIf
         oD0k65ng7+8smTyRPTZGzgXfA7NvLUlmZWy9yX+zstcfU49MgDm21RUVXPColcm9t2Hj
         gzjgwi9gsBxqxW63hOOavGhN78cL0HQN65f89WxugRtwRHLRw7H8h6BgEjMyoITX0u5a
         Ql4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xCZU3ZuGDFmyKvSHiIjw6ozCsgcZDsXDyKFpwiyTyY0=;
        b=Roav8gxsTA66CKS6waH51PY4Tnx50nKZAC7vZcLXmZMKaZNTKvz7jADaolnfnkXkIt
         kY3GKrSuvBY3BEf9+Ka36SMLgxNbXeEHYRLW5bsuOjDzCrcrpifiUqm/eKj2EXb7FYOG
         PGCrpq7BcUQZCzfOGEpFjYvY7boBxPyhq75M+H6G13i6f1zFXJM3/+Pbkuwg9CDrSORU
         89o1XyYzr7vidqcUlRU/MVhtOzfOAqp3bnxTJMYXNqyp9CGPZryrI4btuH0GDg1pnWTP
         LfjITRQwBsqLcvj/Vv3fHec05kNtVhRy3WMktmuTXOFv60qyLI0Cu1CLrWdsrLA0GsH5
         a5dA==
X-Gm-Message-State: APjAAAXGTEwHP85IWbYaM4cKI6TX32J0hH1zlPH297+cnw3VI/Ih9WUv
        a16tmCazLsy8GkbgZ2vnCLA=
X-Google-Smtp-Source: APXvYqwwgeeYhL6iBLquX4X/HQvDP9CavDcgzxnpZxJl+JsRLMmrQwu2M1HQlCfxZt3L+ymkGRGs1g==
X-Received: by 2002:a6b:ec0c:: with SMTP id c12mr10949354ioh.138.1568908606751;
        Thu, 19 Sep 2019 08:56:46 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id n17sm1625774ioj.73.2019.09.19.08.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 08:56:45 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     alexandru.Ardelean@analog.com
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: imu: adis16400: fix memory leak
Date:   Thu, 19 Sep 2019 10:56:35 -0500
Message-Id: <20190919155636.3241-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <76a7c8d43f8c03a0549d157bbf278b515cfbc047.camel@analog.com>
References: <76a7c8d43f8c03a0549d157bbf278b515cfbc047.camel@analog.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In adis_update_scan_mode_burst, if adis->buffer allocation fails release
the adis->xfer.

v2: set adis->xfer = NULL to avoid any potential double free.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/iio/imu/adis_buffer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index 9ac8356d9a95..78fe83c1f4fe 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -35,8 +35,11 @@ static int adis_update_scan_mode_burst(struct iio_dev *indio_dev,
 		return -ENOMEM;
 
 	adis->buffer = kzalloc(burst_length + sizeof(u16), GFP_KERNEL);
-	if (!adis->buffer)
+	if (!adis->buffer) {
+		kfree(adis->xfer);
+		adis->xfer = NULL;
 		return -ENOMEM;
+	}
 
 	tx = adis->buffer + burst_length;
 	tx[0] = ADIS_READ_REG(adis->burst->reg_cmd);
-- 
2.17.1

