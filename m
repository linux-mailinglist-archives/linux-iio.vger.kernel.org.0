Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0F371995AB
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 13:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbgCaLsT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 07:48:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38960 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730424AbgCaLsS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 07:48:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id k18so3230014pll.6;
        Tue, 31 Mar 2020 04:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=69MDAmNWecKpofdaJ8R37Cfmm+mjxxlz6kLovvC8eNM=;
        b=dWHtUzeQCNnlshkvkAJulWssXaZvdkcJj3QIsmvb2ivhQYYOtF3mFxUDGirxGAG3lz
         0BH69m+zRfU7bfVujzx8D23tApztMuqPR04mqXCTNgPuo6pwFMeimQURHig7LJOf1fUN
         evgeEkyeZyqMtQ4Ubn51zgP/jUmH6Q+hfpay50Xg9m+cj5BoRL1cUcNQDQKj/W84wbWE
         rgJvRrQZ/r8xU5J92YbJkWUqMy9HZQn3zyZJ96z8Mimi/NGQy16xF4D9Ieq2MHA8lEZq
         5QafwbeJ4HTOEZikO4nEIKpdiLTCa6uK3kqowAdThkgX6aRYWLYIn90H0OKbTf+AKVUi
         DMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=69MDAmNWecKpofdaJ8R37Cfmm+mjxxlz6kLovvC8eNM=;
        b=TOTdlzZnlu2mwTOJ+Pjj3qpYe5xtpf/6xHlQqxbXTKUsCWpZDDUZdjQTHNqCQPFZNO
         Vb4IFoZLNJUnWxjL7MKRIuIEdbBxBiQPVOCrwYb8FgMMmTqrg3QwsagCrmjbpgOCSonI
         C7xJRD/Z4xzCS8JgaYqsdznETHDaaiX2WlPwV+QlGkb2eyc860LvYZfPAxMTza7voENt
         8tYYjJDqrSbmKNu75cyQqZy2EazW/AWOzukhSiHQz3Up5CDr2jQQLaELM98ltdWoCN0T
         RnXoqAbk4JyM6vvRboq6J/0WNThJDHamNY7CYZUxcEdFZ/SuflckVGye9kbv+5afi4U+
         82sg==
X-Gm-Message-State: ANhLgQ0GtD7siwhnYiRamVXWECPXaVH3776qRNSt4wmSAgWguVeQf5KC
        OHec5871ATX05ZUE/OEexNDSjpH6lNyQwg==
X-Google-Smtp-Source: ADFU+vuiR2Bk1INOg84gy/3iKqeZ2AoX8LJDpwX5kaP1UsgkNGnECWyUnfi3mOEZIgqDG//wEmQbxA==
X-Received: by 2002:a17:902:7e05:: with SMTP id b5mr15613238plm.253.1585655296845;
        Tue, 31 Mar 2020 04:48:16 -0700 (PDT)
Received: from localhost.localdomain ([122.178.242.244])
        by smtp.gmail.com with ESMTPSA id i15sm11601220pgc.74.2020.03.31.04.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 04:48:16 -0700 (PDT)
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
Subject: [PATCH v2 2/2] iio: imu: adis16460: use DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_SIMPLE_ATTRIBUTE
Date:   Tue, 31 Mar 2020 17:17:31 +0530
Message-Id: <20200331114732.14739-3-rohitsarkar5398@gmail.com>
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
 drivers/iio/imu/adis16460.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
index 9539cfe4a259..f96cfd007957 100644
--- a/drivers/iio/imu/adis16460.c
+++ b/drivers/iio/imu/adis16460.c
@@ -87,8 +87,8 @@ static int adis16460_show_serial_number(void *arg, u64 *val)
 
 	return 0;
 }
-DEFINE_SIMPLE_ATTRIBUTE(adis16460_serial_number_fops,
-	adis16460_show_serial_number, NULL, "0x%.4llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(adis16460_serial_number_fops,
+		adis16460_show_serial_number, NULL, "0x%.4llx\n");
 
 static int adis16460_show_product_id(void *arg, u64 *val)
 {
@@ -105,8 +105,8 @@ static int adis16460_show_product_id(void *arg, u64 *val)
 
 	return 0;
 }
-DEFINE_SIMPLE_ATTRIBUTE(adis16460_product_id_fops,
-	adis16460_show_product_id, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(adis16460_product_id_fops,
+		adis16460_show_product_id, NULL, "%llu\n");
 
 static int adis16460_show_flash_count(void *arg, u64 *val)
 {
@@ -123,19 +123,22 @@ static int adis16460_show_flash_count(void *arg, u64 *val)
 
 	return 0;
 }
-DEFINE_SIMPLE_ATTRIBUTE(adis16460_flash_count_fops,
-	adis16460_show_flash_count, NULL, "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(adis16460_flash_count_fops,
+		adis16460_show_flash_count, NULL, "%lld\n");
 
 static int adis16460_debugfs_init(struct iio_dev *indio_dev)
 {
 	struct adis16460 *adis16460 = iio_priv(indio_dev);
 
-	debugfs_create_file("serial_number", 0400, indio_dev->debugfs_dentry,
-		adis16460, &adis16460_serial_number_fops);
-	debugfs_create_file("product_id", 0400, indio_dev->debugfs_dentry,
-		adis16460, &adis16460_product_id_fops);
-	debugfs_create_file("flash_count", 0400, indio_dev->debugfs_dentry,
-		adis16460, &adis16460_flash_count_fops);
+	debugfs_create_file_unsafe("serial_number", 0400,
+			indio_dev->debugfs_dentry, adis16460,
+			&adis16460_serial_number_fops);
+	debugfs_create_file_unsafe("product_id", 0400,
+			indio_dev->debugfs_dentry, adis16460,
+			&adis16460_product_id_fops);
+	debugfs_create_file_unsafe("flash_count", 0400,
+			indio_dev->debugfs_dentry, adis16460,
+			&adis16460_flash_count_fops);
 
 	return 0;
 }
-- 
2.23.0.385.gbc12974a89

