Return-Path: <linux-iio+bounces-1347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CFA820C8B
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 19:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141B91C217EE
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 18:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629509471;
	Sun, 31 Dec 2023 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXrwQUoN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C51C9449
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75564C433C8;
	Sun, 31 Dec 2023 18:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047738;
	bh=hTeQeEUNwCvuIMH13pvMttdlmqibt20Bw3vIpd6HuaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LXrwQUoNSAWlDofgDX0i6cbhyiysqFcBLOGQqQgrsoXpUxmvGXSu9D98D3bgWsjaN
	 geHtc3ykFJyTGHk+LCVnt2qkWkbbo2q2rSwtPalVMA9YlDx+inace6kHtwOu/FeDt3
	 vh8oTKW+q/tWa/63V9JgpveNrZwBauFGotyazF/1mDJkv/9YrtvjxSEPUOLKS5cVPQ
	 aH4pnoZEDPOb4V6ZMpehQHqp2eH0epaUFofwAyFqeJevIawYd0r4HeOxXucL+V9ebw
	 ybS0YSH/g9h3QkWknIBDH0NDNMFEiQS1VIx5JNrYBdhylzfrjLh3T8bfo3zA3n72PW
	 EuueaIHgYhp+Q==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 10/24] iio: humidity: hts221: Drop ACPI_PTR() usage
Date: Sun, 31 Dec 2023 18:35:00 +0000
Message-ID: <20231231183514.566609-11-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231183514.566609-1-jic23@kernel.org>
References: <20231231183514.566609-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Avoiding unused variable warnings when using this macro adds
complexity that in simple cases like this one is not justified
for the small saving in data.

Switch include to mod_devicetable.h as that contains the only
ACPI specific definitions needed in this driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/humidity/hts221_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts221_i2c.c
index 30f2068ea156..5cb263e0ef5a 100644
--- a/drivers/iio/humidity/hts221_i2c.c
+++ b/drivers/iio/humidity/hts221_i2c.c
@@ -9,7 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/acpi.h>
+#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/regmap.h>
@@ -63,7 +63,7 @@ static struct i2c_driver hts221_driver = {
 		.name = "hts221_i2c",
 		.pm = pm_sleep_ptr(&hts221_pm_ops),
 		.of_match_table = hts221_i2c_of_match,
-		.acpi_match_table = ACPI_PTR(hts221_acpi_match),
+		.acpi_match_table = hts221_acpi_match,
 	},
 	.probe = hts221_i2c_probe,
 	.id_table = hts221_i2c_id_table,
-- 
2.43.0


