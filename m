Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B891AFB8E
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 17:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgDSPEZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 11:04:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgDSPEZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Apr 2020 11:04:25 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D439A22244;
        Sun, 19 Apr 2020 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587308664;
        bh=c4OOX+MlMg3a3k5zozzpEG/zYoq5T5knl4dtMqcFH14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VyVjK1SoDwCpQTtjc2dp7cSfHtYor5iHtk3VHW80hbSKd+xEaHGVKhav7xM+L3kHx
         noOMzvLklOVTjMFJtizTA2IcxPFYnoiG4s3uJ/pbqkFoHasNhZ7Rl4aknNr3+Po3q3
         F71tjNQ0jaX8eeR7J8VCqmYyTLYaRNAjeRrICndM=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6/7] iio: light: st_uvis25: Add mod_devicetable.h and drop of_match_ptr
Date:   Sun, 19 Apr 2020 16:02:05 +0100
Message-Id: <20200419150206.43033-7-jic23@kernel.org>
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

Enables probing via ACPI PRP0001 and removes an example that we don't
want people to cut and paste into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/st_uvis25_i2c.c | 3 ++-
 drivers/iio/light/st_uvis25_spi.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/st_uvis25_i2c.c b/drivers/iio/light/st_uvis25_i2c.c
index 400724069d19..98cd49eefe45 100644
--- a/drivers/iio/light/st_uvis25_i2c.c
+++ b/drivers/iio/light/st_uvis25_i2c.c
@@ -9,6 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/regmap.h>
@@ -55,7 +56,7 @@ static struct i2c_driver st_uvis25_driver = {
 	.driver = {
 		.name = "st_uvis25_i2c",
 		.pm = &st_uvis25_pm_ops,
-		.of_match_table = of_match_ptr(st_uvis25_i2c_of_match),
+		.of_match_table = st_uvis25_i2c_of_match,
 	},
 	.probe = st_uvis25_i2c_probe,
 	.id_table = st_uvis25_i2c_id_table,
diff --git a/drivers/iio/light/st_uvis25_spi.c b/drivers/iio/light/st_uvis25_spi.c
index cd3761a3ee3f..af9d94d12787 100644
--- a/drivers/iio/light/st_uvis25_spi.c
+++ b/drivers/iio/light/st_uvis25_spi.c
@@ -9,6 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/regmap.h>
@@ -55,7 +56,7 @@ static struct spi_driver st_uvis25_driver = {
 	.driver = {
 		.name = "st_uvis25_spi",
 		.pm = &st_uvis25_pm_ops,
-		.of_match_table = of_match_ptr(st_uvis25_spi_of_match),
+		.of_match_table = st_uvis25_spi_of_match,
 	},
 	.probe = st_uvis25_spi_probe,
 	.id_table = st_uvis25_spi_id_table,
-- 
2.26.1

