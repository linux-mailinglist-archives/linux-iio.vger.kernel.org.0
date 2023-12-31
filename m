Return-Path: <linux-iio+bounces-1340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE15820C84
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 19:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F4451F21BB9
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 18:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D849470;
	Sun, 31 Dec 2023 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSJ/nJ72"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60324944D
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E75C433C9;
	Sun, 31 Dec 2023 18:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047726;
	bh=5DipDRJ9SjxNVEu8yeOLsiEkzWBhgemvmWE2TkWJW2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OSJ/nJ72d+7Wp540wXYSBRa93Suw5EKBFKaY71Ov/eoslzQIVwjO4ntV1XCtsNJ2c
	 zUDurevCZJ9NNsAZphHWjPNsqiAHha8tDN/Y31xn/ikzpNytQy74tz/TpiKm5wfqHM
	 qVCJlqxVo9e8d020lAK7pUPTRO25TB+7gj9w1VHrKHWtiqtwYYCYkKmOQyOnNA3547
	 SjWzhvHysu0Ouv1JLLg5fAP4cXQq2cUvXITeNMlcfVWQx/hWkkUXWLdhALE7JkN3In
	 JkDH8OFg5tisHfI4VlQdAFuUm4UA7yAUdOseh3+8CWuUS46Z6166fgdonkkMvu5FaZ
	 e0JvY22fCyR5Q==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 03/24] iio: accel: mma9551: Drop ACPI_PTR() usage
Date: Sun, 31 Dec 2023 18:34:53 +0000
Message-ID: <20231231183514.566609-4-jic23@kernel.org>
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
 drivers/iio/accel/mma9551.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index d823f2edc6d4..083c08f65baf 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -604,9 +604,9 @@ MODULE_DEVICE_TABLE(i2c, mma9551_id);
 static struct i2c_driver mma9551_driver = {
 	.driver = {
 		   .name = MMA9551_DRV_NAME,
-		   .acpi_match_table = ACPI_PTR(mma9551_acpi_match),
+		   .acpi_match_table = mma9551_acpi_match,
 		   .pm = pm_ptr(&mma9551_pm_ops),
-		   },
+	},
 	.probe = mma9551_probe,
 	.remove = mma9551_remove,
 	.id_table = mma9551_id,
-- 
2.43.0


