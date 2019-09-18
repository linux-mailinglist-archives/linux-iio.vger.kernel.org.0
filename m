Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB3D6B689A
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 19:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387764AbfIRRDR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 13:03:17 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39923 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387709AbfIRRDQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 13:03:16 -0400
Received: by mail-io1-f66.google.com with SMTP id a1so894397ioc.6;
        Wed, 18 Sep 2019 10:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5fl8PGJoyUyvTGUG9rw2at0SOKHlYdtFyvgpSZSiOb0=;
        b=PPN71l8IN2TIkiGb4dNWQ0YbpislVMVGUaV0LmDcRshLuuqupsUP5z0hRGF093XaJP
         wVj4hv71aPBghD2POsiM/aNzAN0VcAvcv6LWg19qwJteBCfpd5mmbdLi7k8uhJx+5uOK
         S/ApsxUy9ZwGVAAIpxoqSmiHuNvbDswJ3ajOXKDUdfDcA+A7KkoiuY8Bzf7L5EA2+Jak
         L+n5tT4jdIxWmYSLOQBgIqzVOSfXB/JbbOougq3495oOCiVcAHYmwTnU23gyrFjVNd8x
         anvoXDlDLqCiSaoDLJkb5387Yzh+s179IVZoX06Q7fzetVA3qIX7ar5YX+pYRe+21a15
         riAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5fl8PGJoyUyvTGUG9rw2at0SOKHlYdtFyvgpSZSiOb0=;
        b=Jk1BZaGidfnCZcZBUywk4F4W12s6FUjd6hXw5YBCQRtlRz8Iyp2VEMKuSqEsVehPzq
         GwDyH1ChqyJZS08iJdbdblGUYXLxuFUV8wc2dWvCP7aWxqWKTi5zcNE0GpGvS3cD+BAu
         GNLhfPgoY7PAe20T+5VbW+Z0nrqxh6FEb5mQUBqJnIarVv7kQ6PWjuxJMjPRkuAcAtfE
         TDxmracNZcVqS6D5Wgha/VsyncDDm0L1RDbMaDP8FoN9bw4g1E9dKmw4khBo/l5gpWle
         BxOYRsGv+X5BO5mCiSEVA34opIqKJEi8SBgOfx5d2vxNITMlZ73wyNuR75Uzi6S0FqPH
         WbgQ==
X-Gm-Message-State: APjAAAWL2zYEBL1m/8PN1hX/tXnH4bcEKsaKKd9L+QAdszB/hXfnrRqO
        0nafRUP/vyuoNEiZhytg5Gw=
X-Google-Smtp-Source: APXvYqxhy4lBz8iZUuSyXOSiLKXK2bwYX8Cz7ZBJiFcYWm0cAQXv1yWsATfghU0RlquLAP+FyS9wfw==
X-Received: by 2002:a05:6638:350:: with SMTP id x16mr6092343jap.29.1568826193772;
        Wed, 18 Sep 2019 10:03:13 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id p26sm1294512iob.50.2019.09.18.10.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 10:03:13 -0700 (PDT)
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
Subject: [PATCH] iio: imu: adis16400: fix memory leak
Date:   Wed, 18 Sep 2019 12:03:05 -0500
Message-Id: <20190918170306.4779-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In adis_update_scan_mode_burst, if adis->buffer allocation fails release
the adis->xfer.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/iio/imu/adis_buffer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index 9ac8356d9a95..1dbe25572a39 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -35,8 +35,10 @@ static int adis_update_scan_mode_burst(struct iio_dev *indio_dev,
 		return -ENOMEM;
 
 	adis->buffer = kzalloc(burst_length + sizeof(u16), GFP_KERNEL);
-	if (!adis->buffer)
+	if (!adis->buffer) {
+		kfree(adis->xfer);
 		return -ENOMEM;
+	}
 
 	tx = adis->buffer + burst_length;
 	tx[0] = ADIS_READ_REG(adis->burst->reg_cmd);
-- 
2.17.1

