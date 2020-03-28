Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 400581963FA
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 07:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgC1Gff (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 02:35:35 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52739 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgC1Gff (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 02:35:35 -0400
Received: by mail-pj1-f68.google.com with SMTP id ng8so4866104pjb.2;
        Fri, 27 Mar 2020 23:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y5jRiliTP1odCqMCzp/TxFT4UkMSNXFuQPuyIcWrqbQ=;
        b=pJJ34XBLUMRlelBTpFs5uzHyTLfRbPZ1roamcPfvs9Q79ItrkB5tzhTTzQsapvPvu4
         eitHRogB/SfPP1UQdZspe3ZoKQGeofEo0uUVcao/Taqh8O0W7QIwGCk2SEBomgRW4sw1
         bdrj9pfcLelC92VCRnGtWA5QeR4r467VjV67LpKqiB+fa0MJ4p2APmM5CwKslmFPGkPQ
         /WM3Pmy8bTANhtHBDDwEg0j+2eccK95cRqmuht/c9u7Rr26c1KLeHUb8QxlsxTrJtYda
         eZ0bPgFYXfN/YWPl7qvWB6rtEKrN+3phqIZn+ROu1oUpwi8gckBMjdbiquNIInatOxrA
         zehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5jRiliTP1odCqMCzp/TxFT4UkMSNXFuQPuyIcWrqbQ=;
        b=CzVhxn8NhvK00SULKGJz5WuXMOjhztzYqHU7YaYRfrSEgDVbMovBxyum2EO1iS1+jj
         9Cax6bR65iVkrEVXl2VpmtQPV1/1H75ZfEyllNwqrFHS5WHPVoP4N3QOF+SE40FaI3KA
         eTx21/EORSs1ltD3CiwH69AWKroEN7q7ZGzKn6rJ7XVVCroWsfjravGRwNzdMrGYdKZE
         2+wRO3KMjEXCtdiYOcdam9RV5CDnUJO8rUCKGKzIZjCeWL5eiJiaTIptAmSI9yl8CZci
         8UZsCZRjgr9Wp1+7F3LcLZ87RQ3SWuZj9kvJ3JZSBVafIhQtDx91nx88x5EbL9qdS2xe
         kLEw==
X-Gm-Message-State: ANhLgQ2pXKIciZnGh5E6NPQYcgAZ2L9Ep1SHFW9Ajh8wgJMLn/3xljro
        4B3p+ZKUN5U383DMhhpHQV5+98ilGuo=
X-Google-Smtp-Source: ADFU+vtCckRcXihAbhwWPbL08Pub0omo2SoFC4vIMhHB3gP9bFWcdZD3FPEWV0nvvvBCk1ilfPqzOg==
X-Received: by 2002:a17:90a:3606:: with SMTP id s6mr3447319pjb.195.1585377333561;
        Fri, 27 Mar 2020 23:35:33 -0700 (PDT)
Received: from localhost.localdomain ([106.51.108.92])
        by smtp.gmail.com with ESMTPSA id l13sm4989976pjq.42.2020.03.27.23.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 23:35:33 -0700 (PDT)
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
Subject: [PATCH 1/2] iio: imu: adis16400: use DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_SIMPLE_ATTRIBUTE
Date:   Sat, 28 Mar 2020 12:04:54 +0530
Message-Id: <20200328063456.24012-2-rohitsarkar5398@gmail.com>
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
 drivers/iio/imu/adis16400.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index cfb1c19eb930..19a35967f385 100644
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
-- 
2.23.0.385.gbc12974a89

