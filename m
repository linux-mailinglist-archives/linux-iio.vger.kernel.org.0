Return-Path: <linux-iio+bounces-1341-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89618820C85
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 19:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400C21F21758
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 18:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC9E8F6F;
	Sun, 31 Dec 2023 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXaGfS9X"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2DF944D
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DA7C433C7;
	Sun, 31 Dec 2023 18:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047728;
	bh=Y9YWQi2G0k8si42KNs+Kt8en+QdNvjfhjI67g/YvgAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sXaGfS9X9700chXVzhZqySeFCuKh4dg0n491ZqpfdruYK92PHpd0GQ9utvMGLPALx
	 wbOy1sru8DSHv76ddz0OV5QUxj3Rwu+CWWBETIjZh4CqdwqpNKoV1lbeBK+SxN+8Yi
	 LnTzKQfCRTVaWbDHTqs6zNyJS0KddMig7CMGbfu0U5efyhJf0e5yFmVOzDPiq0qrpF
	 3MEJ6yXgMAyLo8zbjtadqxf8KW7a4FMZ/WQrDBwD3q+ZRdK43FJvH1Y7xYa0cKhznZ
	 Rbaabp7KgOH/iFRuudI3xBezByfDj8f80oms8gjZbUSHYeulJhTj0ZrPdaFFCz/elK
	 9cTp4i0ZF9/5g==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 04/24] iio: accel: mma9553: Drop ACPI_PTR() usage
Date: Sun, 31 Dec 2023 18:34:54 +0000
Message-ID: <20231231183514.566609-5-jic23@kernel.org>
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

Whilst here tidy up a trivial bit of unusual indentation.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/mma9553.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index d01aba4aecba..3cbd0fd4e624 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1243,9 +1243,9 @@ MODULE_DEVICE_TABLE(i2c, mma9553_id);
 static struct i2c_driver mma9553_driver = {
 	.driver = {
 		   .name = MMA9553_DRV_NAME,
-		   .acpi_match_table = ACPI_PTR(mma9553_acpi_match),
+		   .acpi_match_table = mma9553_acpi_match,
 		   .pm = pm_ptr(&mma9553_pm_ops),
-		   },
+	},
 	.probe = mma9553_probe,
 	.remove = mma9553_remove,
 	.id_table = mma9553_id,
-- 
2.43.0


