Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 070761995A9
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 13:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbgCaLsN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 07:48:13 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53723 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730424AbgCaLsM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 07:48:12 -0400
Received: by mail-pj1-f68.google.com with SMTP id l36so964720pjb.3;
        Tue, 31 Mar 2020 04:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6O0gMjSRqXI23LYvCLV0ocypchgJQJFmBiZQ3a3Giu4=;
        b=ca+J3yvo4W0T3ogR1fHJz8ZkjV8TeVcDN2yw0jVHdxZuficHrC3RPN1zyrjrh8mPhv
         vJ+2E5iTBwDCq/RAaUCeMswujQBQ6eePHlKPVUQvvIqA3zqbCyU88xypTbn1UmOZVDHP
         HL89ItRq6fJrm2RvQ5BFi2OHnrJvfU8tH0Me1GY0YPfufbqwD/KYxSfZIti0D5/+UALi
         WdO/ZDK87hOwvsST+NXh4NPqRj13hr+YzT78cdYge4IsvAZpMiF654qGNpEk4vbK3p8N
         FJpQ6pUTzlB4FNf283HQxtL+CRYWk7+OqQM284FbCUhn92rybGNm6QRQyLxz5k9E9rgT
         P1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6O0gMjSRqXI23LYvCLV0ocypchgJQJFmBiZQ3a3Giu4=;
        b=UoBivIzKr8Un0HMwYK2okixTKiCZAJwD4upRkaFjEVvHSfHf+5e63D6ubYm6VJzgil
         Ek2ACybKPhb/qU1TCH6F7uIZblbhX+D115hs7fEs+UmFBJNaqFZ1geqJCYle5aNddXNt
         1hLUbmIuHvqKpok/e7U70Sthd663Cp90Bwn5mEps1/jMzxYd8QRu0jVpg/tVrjIYxpb+
         eOq9Vs+rsv/ysLXf3Tl42TWpPhTrc5e+EmNybMxf4VDjCRbQ3gBk3yRarz9OxFRvNZ2c
         MqOlL06b6j84NQgovlzCwv9gYFOLICfKTEysDPsGTp0XBWR1vPof4f2Tl2u7jDXCoofh
         eLaA==
X-Gm-Message-State: AGi0PuYGO9jEZAHJkIa1NQ7hb9TC3IVEs+bHJqFbovnyeznDPIZz0l3S
        7gtYjoiGm5m92suijLkTkECmYdTW8EieJg==
X-Google-Smtp-Source: APiQypLaFIbNWxV2Rp8S+zw6UtzysQuM8vftpi6q/VbZSWzyrhdxbj4i3RaLdGhdgrnrTs7FRraLlQ==
X-Received: by 2002:a17:90a:1911:: with SMTP id 17mr3448899pjg.65.1585655291196;
        Tue, 31 Mar 2020 04:48:11 -0700 (PDT)
Received: from localhost.localdomain ([122.178.242.244])
        by smtp.gmail.com with ESMTPSA id i15sm11601220pgc.74.2020.03.31.04.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 04:48:10 -0700 (PDT)
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     dragos.bogdan@analog.com, Rohit Sarkar <rohitsarkar5398@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] iio: imu: adis16400: use DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_SIMPLE_ATTRIBUTE
Date:   Tue, 31 Mar 2020 17:17:30 +0530
Message-Id: <20200331114732.14739-2-rohitsarkar5398@gmail.com>
X-Mailer: git-send-email 2.23.0.385.gbc12974a89
In-Reply-To: <20200331114732.14739-1-rohitsarkar5398@gmail.com>
References: <20200328063456.24012-1-rohitsarkar5398@gmail.com>
 <20200331114732.14739-1-rohitsarkar5398@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

debugfs_create_file_unsafe does not protect the fops handed to it
against file removal. DEFINE_DEBUGFS_ATTRIBUTE makes the fops aware of
the file lifetime and thus protects it against removal.

Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
---
 drivers/iio/imu/adis16400.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index cfb1c19eb930..c8fcd40f58c0 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -258,7 +258,7 @@ static int adis16400_show_product_id(void *arg, u64 *val)
 
 	return 0;
 }
-DEFINE_SIMPLE_ATTRIBUTE(adis16400_product_id_fops,
+DEFINE_DEBUGFS_ATTRIBUTE(adis16400_product_id_fops,
 	adis16400_show_product_id, NULL, "%lld\n");
 
 static int adis16400_show_flash_count(void *arg, u64 *val)
@@ -275,7 +275,7 @@ static int adis16400_show_flash_count(void *arg, u64 *val)
 
 	return 0;
 }
-DEFINE_SIMPLE_ATTRIBUTE(adis16400_flash_count_fops,
+DEFINE_DEBUGFS_ATTRIBUTE(adis16400_flash_count_fops,
 	adis16400_show_flash_count, NULL, "%lld\n");
 
 static int adis16400_debugfs_init(struct iio_dev *indio_dev)
@@ -283,15 +283,16 @@ static int adis16400_debugfs_init(struct iio_dev *indio_dev)
 	struct adis16400_state *st = iio_priv(indio_dev);
 
 	if (st->variant->flags & ADIS16400_HAS_SERIAL_NUMBER)
-		debugfs_create_file("serial_number", 0400,
-			indio_dev->debugfs_dentry, st,
-			&adis16400_serial_number_fops);
+		debugfs_create_file_unsafe("serial_number", 0400,
+				indio_dev->debugfs_dentry, st,
+				&adis16400_serial_number_fops);
 	if (st->variant->flags & ADIS16400_HAS_PROD_ID)
-		debugfs_create_file("product_id", 0400,
+		debugfs_create_file_unsafe("product_id", 0400,
+				indio_dev->debugfs_dentry, st,
+				&adis16400_product_id_fops);
+	debugfs_create_file_unsafe("flash_count", 0400,
 			indio_dev->debugfs_dentry, st,
-			&adis16400_product_id_fops);
-	debugfs_create_file("flash_count", 0400, indio_dev->debugfs_dentry,
-		st, &adis16400_flash_count_fops);
+			&adis16400_flash_count_fops);
 
 	return 0;
 }
-- 
2.23.0.385.gbc12974a89

