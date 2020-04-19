Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B831AFB8A
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 17:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgDSPEV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 11:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgDSPEU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Apr 2020 11:04:20 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E677821974;
        Sun, 19 Apr 2020 15:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587308660;
        bh=/gYylPr2EpMW+lrY68r3C3qP+lUnSEGMSMOJGZvgXIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zDx6OCutuo0xMx4illwE9XQ/3j2fdtfyRP65mNR5TIj1Z98ugiukrebCucdhmZ81S
         Q0D+aaiu4vG47vKBInC1HQ3oZeHxsYL6DoLDpy9YUutGIiIA+EzDt8bydT9UafGvt4
         M3JaoeMzGuWxmEcQIipruYBdgOnv9W0QwwsVyJH8=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/7] iio: light: cm32181: Add mod_devicetable.h and remove of_match_ptr
Date:   Sun, 19 Apr 2020 16:02:01 +0100
Message-Id: <20200419150206.43033-3-jic23@kernel.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200419150206.43033-1-jic23@kernel.org>
References: <20200419150206.43033-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Enables probing via the ACPI PRP0001 route but more is mosty about
removing examples of this that might get copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/cm32181.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 5f4fb5674fa0..73c48f46220c 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -9,6 +9,7 @@
 #include <linux/i2c.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
 #include <linux/regulator/consumer.h>
 #include <linux/iio/iio.h>
@@ -354,7 +355,7 @@ MODULE_DEVICE_TABLE(of, cm32181_of_match);
 static struct i2c_driver cm32181_driver = {
 	.driver = {
 		.name	= "cm32181",
-		.of_match_table = of_match_ptr(cm32181_of_match),
+		.of_match_table = cm32181_of_match,
 	},
 	.id_table       = cm32181_id,
 	.probe		= cm32181_probe,
-- 
2.26.1

