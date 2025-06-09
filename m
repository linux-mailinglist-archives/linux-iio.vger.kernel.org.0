Return-Path: <linux-iio+bounces-20324-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB4AAD18D4
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 09:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F103A8807
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 07:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE865280A56;
	Mon,  9 Jun 2025 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1YYZ+de"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF5611185
	for <linux-iio@vger.kernel.org>; Mon,  9 Jun 2025 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749452792; cv=none; b=T+997+rvZwhAYxdrFh+AHwRa3V1Vsv3s6hrcL/0ylgLwJcVpZWi6FzQEHJrDC8ZxsXKKDsxasJrHyfbiyocvDA/OmUEw2inUI18Pf6G+Mvj9vhXtPLK2kXPwg9mjrGm6fdM0cDQyiUOWe0apwnKaOwu8c6rQj1kUipsfHlNv4Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749452792; c=relaxed/simple;
	bh=Hk/4hRcHQl+lxznlXuO+o9YIowKUehse46TW/6xRtZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdKigErvYuQOzfWLKo8Z1lM4olVkQlCNfge+u2Ekfo6VV7kVo6AECkvt5iCZFGhu0LM9N5b9TsOEPYWGrkjww7jin6Ur+AD9E2a8au0OQZxPOsUeEuSvhAG9eKRFok48rin8EdF3u1fuvdk7tsQlOTWsHMUtxsDZglb8q8YH2yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1YYZ+de; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63703C4CEED;
	Mon,  9 Jun 2025 07:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749452792;
	bh=Hk/4hRcHQl+lxznlXuO+o9YIowKUehse46TW/6xRtZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S1YYZ+den/fNF5Rt7uG8IIt27HiEbFpAufbC13IAwJ8KOUQLEMrgQbVZQcRbcN57a
	 bfCG6WEn80MiGXop4PPpy2ri5kUUd3Yc3XlNTY3vk+C6yJ7WdkGQfB/Zo8FocQPdD5
	 U8T9kjgPprNAh21lLovOVEqDX8RUzUw7okDCUGj8P0yA7vZDwtUou5sBkpJERm0O6B
	 WEj3YCEXoxSICgRnrNrUqeSnAIdkTx9nova0kiwmR2grtUZu1bpWHklXA+3vRLuAgc
	 9THr1AODMd0x5i6glwqHW3ZuNhocmVEJocDWrOA9Nii0+ap/1t1xqMRnuZDHH/MHUq
	 KuHg6VjJVou6A==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/2] iio: dummy: Drop unused export.h include.
Date: Mon,  9 Jun 2025 08:06:16 +0100
Message-ID: <20250609070616.3923709-3-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609070616.3923709-1-jic23@kernel.org>
References: <20250609070616.3923709-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Resolves:
  warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h> is present

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dummy/iio_simple_dummy_buffer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index e35e0596cbfb..024f1135af63 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-- 
2.49.0


