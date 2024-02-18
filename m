Return-Path: <linux-iio+bounces-2740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247F1859833
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 18:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84E05B20E95
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 17:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006E36EB7A;
	Sun, 18 Feb 2024 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psb7LKAC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60381E898
	for <linux-iio@vger.kernel.org>; Sun, 18 Feb 2024 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277621; cv=none; b=EgBOu7drlqrhbX8lFOo8u5W1pmqPQS2EZDBPb+XRgd1R6BC6O7h6wT2L0ow8eRB38k9VqLtZNvc8qG9LL3pTOgG2A7Gv4LIK8eq7MiEPcDXETpRutrjTsbZ5AG6aZbVe6V6Ai2ljKDEZoxyYfR2h/M+okQbGJA921A9ynB/DYog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277621; c=relaxed/simple;
	bh=ewNobQG+B+aKF3dx2iFKgyrjWgZF9HmTA/nGruhzuz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSILDNSJ2kOZGskbfyxUmr0kcub6Egv1/gV35malMH0OzxEUwFef5B8ada7jZEDJld0eMswqTSPRuRcQV5GdpV4B7iEYrzqT4pV6MS4Xqysqk15di9TydsvizjykK4xV3lzINY4+qhKgQ/0TXqiPOebxTWmjWdcmDXFcHyBuz6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psb7LKAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B686C433C7;
	Sun, 18 Feb 2024 17:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708277621;
	bh=ewNobQG+B+aKF3dx2iFKgyrjWgZF9HmTA/nGruhzuz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=psb7LKACHfvJYkdHxSlS6YDd1Cc8D8p7mJCV/A3YUeqy1IWQBdFN48Wfd/O6e4VLt
	 Yjy1HZASCdOH5IeMInrXJSiGLZvqXJ/YdqCIPb2h2RiRWGftUDbvIYPzUInJoikeuK
	 FQWlo1aOl30s1CYtabtnL55K1G64TzZfjV5eIoQtYZ8OOOylF75Eba9MgTnHOgmjoU
	 hAQYC9Tve06cNd4qA1mjfwc5TgDpoIDQbz1DqSZRc8ta2IdzOVDCF+1X109TfkOSA6
	 3JX73kuPzqBGLBn6fN/8vs+cRhpyntZOg7C3hJWqrFlgGDbtItM2/VjMdF3L6S6hJR
	 inUyQOt1t4f8g==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/8] iio: adc: ads8688: Switch to mod_devicetable.h for struct of_device_id definition
Date: Sun, 18 Feb 2024 17:33:19 +0000
Message-ID: <20240218173323.1023703-5-jic23@kernel.org>
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

of.h was only included to get access to this structure, so include the
correct header directly instead.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-ads8688.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index ef06a897421a..9440a268a78c 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -11,7 +11,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
-- 
2.43.2


