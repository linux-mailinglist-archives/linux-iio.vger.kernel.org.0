Return-Path: <linux-iio+bounces-130-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B7B7EE779
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 20:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFFE281037
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 19:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9742134CD1;
	Thu, 16 Nov 2023 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcbcqXm4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C81F328A2
	for <linux-iio@vger.kernel.org>; Thu, 16 Nov 2023 19:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B3EC433B8;
	Thu, 16 Nov 2023 19:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700162840;
	bh=IexTtOqhXMQViyDYGPFdYR2bfh/fxkuSdm2724R8ObQ=;
	h=From:To:Cc:Subject:Date:From;
	b=tcbcqXm4rq+2OijBB4rqytIqAjLkyO/HZyLO2M4gDlv/ZUnHD+gi3k2gCEQQ4z2Xd
	 i/3DWRyfFU8w7h3FyHMl3mn0swwqKR1Gx8oXMXqX+ZKUPr3q4fey/Afd98ekoQ87bl
	 GwSr79x6rgC/796KA7LE4uwM6WUU8BjBxN8wCUhfdDP7leZrDLLEkCMpBJrGlzqPIW
	 dnkODv1Ekr2DPNjKY3xkpfWXnx8neDF88yKJTrn9qmjmReZRyRQ8Vo7bXHUWpFx/8T
	 Df4UR1UDiwf0azwBcI1e0sGVAPF+IajH0rvitBXUbgMMg8c26x4qzrJAv5xL7OYLEB
	 SZ6XK0A1qxqGA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] iio: light: pa1203001: Drop ACPI_PTR() protection.
Date: Thu, 16 Nov 2023 19:27:11 +0000
Message-ID: <20231116192711.366441-1-jic23@kernel.org>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The extra cost of always including the acpi_device_id table is trivial
vs the complexity of adding guards or __maybe_unused markings so
just stop using the ACPI_PTR() macro.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311160851.FDA4CDVE-lkp@intel.com/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/pa12203001.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
index ed241598aefb..636432c45651 100644
--- a/drivers/iio/light/pa12203001.c
+++ b/drivers/iio/light/pa12203001.c
@@ -472,7 +472,7 @@ static struct i2c_driver pa12203001_driver = {
 	.driver = {
 		.name = PA12203001_DRIVER_NAME,
 		.pm = &pa12203001_pm_ops,
-		.acpi_match_table = ACPI_PTR(pa12203001_acpi_match),
+		.acpi_match_table = pa12203001_acpi_match,
 	},
 	.probe = pa12203001_probe,
 	.remove = pa12203001_remove,
-- 
2.42.1


