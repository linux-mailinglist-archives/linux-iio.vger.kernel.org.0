Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89E54B7E85
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2019 17:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390076AbfISPuN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Sep 2019 11:50:13 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42304 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390065AbfISPuN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Sep 2019 11:50:13 -0400
Received: by mail-io1-f66.google.com with SMTP id n197so8815194iod.9;
        Thu, 19 Sep 2019 08:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k1MqWf4hKWlYZ+LlrC3Tc0jf+R8FcYzsjJ6RHV2LGYk=;
        b=CUtE4JQpKmkzVHOxoWO7rotdcNW2FV34St0dMrMbNNJmfwbfgSeJ3aScixe0GuY6uq
         kjXeW92nd7a6lC00s0WvNsqj825ifFgewqBk85eGwD4+ta8XLnu8/2/NCHSMwcf3kEaS
         rB5fYAQLf/FNr2y42TjOHTh8etkZj3LOz5f6UAX7j1CU5jKH1EoldWwtyJyveBXnaaeH
         7VE1ynzW/zERraSWC22JxusIj42Ew/xO++7prwZy6lGqFJChmHyaeVG4lpxNSLr0XO3t
         PLSe9nWcCtGbaiOJbgYomT4LNaKR6X7P0NhJtfrsfbp4gnY5GyBdO5oY6r/YZMWta4wU
         yPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k1MqWf4hKWlYZ+LlrC3Tc0jf+R8FcYzsjJ6RHV2LGYk=;
        b=CKcbvmcxigkO+yxisl/7PbtgBqgw04Nu/9n6X9neDN8YZSsC73n1sI42N95UsgUPe0
         vufKiSBijEYWfYR4j0PTZ7Cq6TZHqGb45LaiWbBhemSBt2d7XNglVjjCMtHQJ2r2JTah
         1rm5uqlsDBlrJ+VZw+Zg795vGC/rYKvk4PZbMF3API6iaRZF3nxsPDZj7HsJtNR3VDFE
         uhmcd8FEIccmjhFUy3Z4NBGfPv2E6riBVH1UtByv35+NTzz54FiKKoyjTfL0ZF3LHG1W
         wy+s+JEZ3qmr16SQah76VDPUka9buMTD+/D4OATAWV+FxuwwT9G3u7FHy5ttOqVj+SMj
         4weg==
X-Gm-Message-State: APjAAAXNFi0XgBFIt2ebQVdaKfVZbj0aJPsH/s3a36p369duOuzX3BBT
        jaO6HIoxPhbXHhXyv/uxxfg=
X-Google-Smtp-Source: APXvYqyy/9r/FuSLWgcOgR0bgpTp4wHoEp8GC82y7jPCewVqqvbfOLEB54sa1pMnNStlvNY/qbJyzg==
X-Received: by 2002:a05:6638:777:: with SMTP id y23mr12904039jad.111.1568908212351;
        Thu, 19 Sep 2019 08:50:12 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id d9sm2094065ioq.9.2019.09.19.08.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 08:50:11 -0700 (PDT)
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
Subject: [PATCH v2] iio: imu: adis16400: release allocated memory on failure
Date:   Thu, 19 Sep 2019 10:50:02 -0500
Message-Id: <20190919155003.2207-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <84e2832b52cc88665ff071942c1545b83eeb5602.camel@analog.com>
References: <84e2832b52cc88665ff071942c1545b83eeb5602.camel@analog.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In adis_update_scan_mode, if allocation for adis->buffer fails,
previously allocated adis->xfer needs to be released.

v2: added adis->xfer = NULL to avoid any potential double free.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/iio/imu/adis_buffer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index 9ac8356d9a95..f446ff497809 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -78,8 +78,11 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
 		return -ENOMEM;
 
 	adis->buffer = kcalloc(indio_dev->scan_bytes, 2, GFP_KERNEL);
-	if (!adis->buffer)
+	if (!adis->buffer) {
+		kfree(adis->xfer);
+		adis->xfer = NULL;
 		return -ENOMEM;
+	}
 
 	rx = adis->buffer;
 	tx = rx + scan_count;
-- 
2.17.1

