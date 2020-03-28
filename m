Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 622DE1963FC
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 07:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgC1Gfp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 02:35:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36449 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgC1Gfp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 02:35:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id j29so5782349pgl.3;
        Fri, 27 Mar 2020 23:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=60675Fy89t5YSbOpSIZQJUWWdV3kYFwCwc2rpXZtyqw=;
        b=cYi8EAPy9wIMw1Sj+J4ABrX4A+oCvGCUfQ0Fd3sHxYVH59WXqBasDJyuBWVR1/tcwc
         NZC9NJWBpYUWt2acELJe28QWZjkF21ME4V0lygNUd0xWGe0IrBodKxSOOuCfJ1q9rMvp
         ZW2IY1YQT7Y6MeK+9G5qYGkHP+fe/NNr4cE4TCn5VXBicDZWZMDTLKVFrp2u76Wu3czk
         oBdSOWt3XVJkbNOai58C5yXNceY9QCouIr8qWXQ/Jr/aF7Fl9mrfRby3XhbQ7jM/8gBE
         FeceT/xik/oUuJJXH7QI3bocs1JbHXFFscOynJIbFri0gBywLT44laod24fXXJM6UxoJ
         8ORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=60675Fy89t5YSbOpSIZQJUWWdV3kYFwCwc2rpXZtyqw=;
        b=i4LXU3DX/rQFld4rI60lqx3UqKVedE/J8l2DCN4wRLr7sQHdOePXZ+ZHZGievaaVTK
         ys4r6wTVab2m350aIUzOeckdHC3POlhQ3CatCOT9Dn2TGH4edEebZj2yo0weCU7FMtUq
         0XVr5qagDqVHsocLIFLIAQjKRzjohRyaAgMui0T6ZR+N5NB/yjTPs/gdFia4yPB3VEmD
         UDWdwsFi1p8uehq/lBbJcLz2tTt3esb1n8KG/fHMzD9iXX1J+gHlFi4z4gmu48r+1aVk
         1a5IRjpmsiZT/gX9hFM4ETqYEztO/f5GBxdJw8mEgpjp/SDumsHXQReHiWLxD5dEoDgA
         jauw==
X-Gm-Message-State: ANhLgQ2xwOeewfi5PpZ+jT0g3q7NCxTtsPqH7vZE3Mc2XRjpvDxnFLAq
        3piY98BjOqkZTgcybPVlm3FvD4fOThQ=
X-Google-Smtp-Source: ADFU+vvpLjeAxhgBujE5b8gViO3ZUdXpFGyO40UXrbr/RlH/jQ0D/S+fZSxEKMUp0Uz4GrgQs9fnIg==
X-Received: by 2002:a63:6e06:: with SMTP id j6mr3067405pgc.167.1585377343270;
        Fri, 27 Mar 2020 23:35:43 -0700 (PDT)
Received: from localhost.localdomain ([106.51.108.92])
        by smtp.gmail.com with ESMTPSA id l13sm4989976pjq.42.2020.03.27.23.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 23:35:42 -0700 (PDT)
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
Subject: [PATCH 2/2] iio: imu: adis16460: use DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_SIMPLE_ATTRIBUTE
Date:   Sat, 28 Mar 2020 12:04:55 +0530
Message-Id: <20200328063456.24012-3-rohitsarkar5398@gmail.com>
X-Mailer: git-send-email 2.23.0.385.gbc12974a89
In-Reply-To: <20200328063456.24012-1-rohitsarkar5398@gmail.com>
References: <20200328063456.24012-1-rohitsarkar5398@gmail.com>
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
 drivers/iio/imu/adis16460.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
index 9539cfe4a259..ef22de5c0211 100644
--- a/drivers/iio/imu/adis16460.c
+++ b/drivers/iio/imu/adis16460.c
@@ -87,7 +87,7 @@ static int adis16460_show_serial_number(void *arg, u64 *val)
 
 	return 0;
 }
-DEFINE_SIMPLE_ATTRIBUTE(adis16460_serial_number_fops,
+DEFINE_DEBUGFS_ATTRIBUTE(adis16460_serial_number_fops,
 	adis16460_show_serial_number, NULL, "0x%.4llx\n");
 
 static int adis16460_show_product_id(void *arg, u64 *val)
@@ -105,7 +105,7 @@ static int adis16460_show_product_id(void *arg, u64 *val)
 
 	return 0;
 }
-DEFINE_SIMPLE_ATTRIBUTE(adis16460_product_id_fops,
+DEFINE_DEBUGFS_ATTRIBUTE(adis16460_product_id_fops,
 	adis16460_show_product_id, NULL, "%llu\n");
 
 static int adis16460_show_flash_count(void *arg, u64 *val)
@@ -123,7 +123,7 @@ static int adis16460_show_flash_count(void *arg, u64 *val)
 
 	return 0;
 }
-DEFINE_SIMPLE_ATTRIBUTE(adis16460_flash_count_fops,
+DEFINE_DEBUGFS_ATTRIBUTE(adis16460_flash_count_fops,
 	adis16460_show_flash_count, NULL, "%lld\n");
 
 static int adis16460_debugfs_init(struct iio_dev *indio_dev)
-- 
2.23.0.385.gbc12974a89

