Return-Path: <linux-iio+bounces-1349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8161A820C8D
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 19:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47C51C216BA
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 18:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3D4947A;
	Sun, 31 Dec 2023 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHBNeW7Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6579F9471
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2391FC433C8;
	Sun, 31 Dec 2023 18:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047742;
	bh=D3aPnMEHrmQx31mzfIDVLYetS7lHL6csyTayGeo/+QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tHBNeW7ZvfB8AMnlWtqpDpL6XxUfQZj+TEfXWWkDQmVN4u1sxDp2UD4LHYSkDznd7
	 5UIUpCEhAgoqgNs++eKvJchpQWXG4rd+dJjyTm4AtJ2AOKJ5tA0+HnEGLWELl5cIew
	 L4tsVAvFq5DaoQ8piU2Mqxt0Pg+hQy1uf4cHHAcQ+GnAMJGiL64euMVo7z7gbYr82M
	 nSY3LRM7Rtts/2sDHkBsAD14d2D1nmQWA+maz2UW38M6JxEM6hsr5bjJwAULkRwdNh
	 Tz0ZINXTOwS4duaBWrLYk48yqbmuk2De5NH7wp17PqTTRt75fv0KjRq7U700OWBxwT
	 hRcV8FaZ2EX0A==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 12/24] iio: imu: kmx61: Drop ACPI_PTR() usage
Date: Sun, 31 Dec 2023 18:35:02 +0000
Message-ID: <20231231183514.566609-13-jic23@kernel.org>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/kmx61.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 958167b31241..7d3e061f3046 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1514,7 +1514,7 @@ MODULE_DEVICE_TABLE(i2c, kmx61_id);
 static struct i2c_driver kmx61_driver = {
 	.driver = {
 		.name = KMX61_DRV_NAME,
-		.acpi_match_table = ACPI_PTR(kmx61_acpi_match),
+		.acpi_match_table = kmx61_acpi_match,
 		.pm = pm_ptr(&kmx61_pm_ops),
 	},
 	.probe		= kmx61_probe,
-- 
2.43.0


