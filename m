Return-Path: <linux-iio+bounces-2744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C95AE859835
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 18:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D9D1C20AA5
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 17:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C80F6EB7F;
	Sun, 18 Feb 2024 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1uK9ueN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D881E898
	for <linux-iio@vger.kernel.org>; Sun, 18 Feb 2024 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277627; cv=none; b=rLLKSB8B53yOpR1/BWkcNn0KKeL0iC2xtLOUzRCBz1jwyOwH0tVmO4Cxjt0Bq6xq5KsdqgQwhHfMORLgnb2GMXY7TdVtw9e9GlOkxiSsr8n5L/uEVhNnYXx1ZuM7gBE22dlsISRfdZ990bglri9FY1V5UpwjrAg2cFa7FVa//XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277627; c=relaxed/simple;
	bh=qfNZXMyCCL37gWI2Ud2pqs11Ci/LJRzKpsK2J45epoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBHHmte1fjBxSeySx+TnYHRmsntEMv42HTTLA6/7wmU4vSwyiY9wd6OnskRAxCas3cgWlaWpwgTljGlxcGlYEDWGsw/spoIK5Qewigvyw++26+yOWb2N723Kqednoe7lT9PjRO/2fyQVXSypWaHGxMt2I7zkMlYt+aXVok0vGF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1uK9ueN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CC3C433C7;
	Sun, 18 Feb 2024 17:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708277627;
	bh=qfNZXMyCCL37gWI2Ud2pqs11Ci/LJRzKpsK2J45epoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1uK9ueN/g3XuyjfzWhd0FYT9essnbvG0yUQBa6tFh3YTO8jf0KMOxSyIdlkoY7O8
	 /gsUcohKo1EWyYlAIiE1IRyBMyBQ3ujY6CqCKfjsT/THbMwFzHNFetkOBwG8Cb8HC1
	 Hyl4AIZEpv/FcjfCFuwvN+ErDyrY9OIMFpW6hXcCOcjKFtClDfIc2c7Yphtiv4LMNQ
	 P5jdSHpXwEoqmKUDrgx8bimvBOZdRosV2Js+VHDjUIuk3B0lrOal5zGCwdzRygMv1l
	 qi8/sOb47M64qr5hB+akP3Ip4VnU5zoLswIWDxJxQ0s+NzZPJs+KSJY69L58XcY05P
	 c44O5qFTYCKPQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 8/8] iio: dac: mcp4821: Switch to including mod_devicetable.h for struct of_device_id definition.
Date: Sun, 18 Feb 2024 17:33:23 +0000
Message-ID: <20240218173323.1023703-9-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218173323.1023703-1-jic23@kernel.org>
References: <20240218173323.1023703-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

of.h was only included for this definition, so include the correct header
instead.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/mcp4821.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
index 8a0480d33845..782e8f6b7782 100644
--- a/drivers/iio/dac/mcp4821.c
+++ b/drivers/iio/dac/mcp4821.c
@@ -17,7 +17,7 @@
  */
 
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
 
 #include <linux/iio/iio.h>
-- 
2.43.2


