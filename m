Return-Path: <linux-iio+bounces-1354-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608EE820C92
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 19:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D26C281EE5
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 18:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591EEAD54;
	Sun, 31 Dec 2023 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aje/du5X"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2558D946F
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1F3C433C8;
	Sun, 31 Dec 2023 18:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047752;
	bh=Jl5ePVqEDcvKIvolKW52LBt61KYC/GPdlCvoEoStObc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aje/du5XL2vKnTJiANA+ymJYTX3q9fkgnwEfu6Y+pWHAIGCLQ6co5aPC8FSKhkT4Y
	 g2LyACQD9yr80Pt/g4UikpWFFe9jQUQeqzmWJguPCdyWLab5cQ7NEkZ2sMABXmjP/a
	 pmkLswAwJ9thg2YNOVRkYyeYJLOXJ6fX8KWcDwd+x8qdE5kUvc8MRHUA8K57RpsySW
	 uqk3ha2zaozEIne2KQJPvh3DFkh6a/klENzOy90fqIV+ph1yJs2oaBIzxb17gnLinb
	 g0t3BFt3XdA9DP0ywiG2XcU3ApVtxtAUz2KPzs1k7dIq47l6RUQqbShgElmPxy67W1
	 FwGuaWKqP5ezw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 17/24] iio: light: us5182d: Drop ACPI_PTR() usage
Date: Sun, 31 Dec 2023 18:35:07 +0000
Message-ID: <20231231183514.566609-18-jic23@kernel.org>
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

Switch include from acpi.h to mod_devicetable.h which includes the
definition of struct acpi_device_id.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311190738.gldzuIXo-lkp@intel.com/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/us5182d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index 61b3b2aea626..9189a1d4d7e1 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -9,7 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/acpi.h>
+#include <linux/mod_devicetable.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/iio/events.h>
@@ -972,7 +972,7 @@ static struct i2c_driver us5182d_driver = {
 		.name = US5182D_DRV_NAME,
 		.pm = pm_ptr(&us5182d_pm_ops),
 		.of_match_table = us5182d_of_match,
-		.acpi_match_table = ACPI_PTR(us5182d_acpi_match),
+		.acpi_match_table = us5182d_acpi_match,
 	},
 	.probe = us5182d_probe,
 	.remove = us5182d_remove,
-- 
2.43.0


