Return-Path: <linux-iio+bounces-13524-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B68F59F255B
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5278B18854A6
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E941B6D17;
	Sun, 15 Dec 2024 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRsK+Ayr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A2B2629C
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287421; cv=none; b=aVHkiyWPw4JCsCHPXdEjqAOImwwfFxc3NMzh0Lwfq5aa8EpbZ5NSt0fkzFmvstp5Vk96Kt67eKvkyacuD1qGYoJNbYg8nyWSq6dorl/pcepNZqGT1uH8IrjY4qx37a4dExZuqmaTsa1wgEqeXiEoep+5W8h5jgUC/eF3tFz/VTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287421; c=relaxed/simple;
	bh=rX1K0B1JDmjVDAy1ocrzCx+iLyeaOJo5Nz8j4sblZxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwQAiskluv5WNYa75Hj6j59hNDXFL9WKYXa2TUIqpTCw5Xk/flr93R1Qzd4HPLO2wv2YM4ADf5Dn1CoKjP+yK3hoWuAD6icbY6RQ4dP6nKKYOZrPAzZFOpSdmjIW/8gouExnNPKj68c9z3BMEspltixNCzAavngP+mTTkHtSq+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRsK+Ayr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF3BC4CECE;
	Sun, 15 Dec 2024 18:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287421;
	bh=rX1K0B1JDmjVDAy1ocrzCx+iLyeaOJo5Nz8j4sblZxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vRsK+AyrKCyPW8rjEmw464eg98mlj9TSuHzm7TOda+4Yl0QU+mip/kl21gdD8U8bb
	 GB+T4OAle0Erj2cGSqpJ/RDPeJSTY4loSJRIc6YtJmlFnpfygVzmbWaf9dOUvAayBr
	 UXFfC81n9LpJ1uUo/xKXiQwrGtXazQkHMZa1LzfsOqGZa3ce/nWTdjkWVmRYK7JUT9
	 bMMcVUHh0ztnzYoBGxeLQaIFoM9cmKUE0bbU+VlIeLdduPWxP+fO6LwxhaJUbNrowY
	 OrKqWV4Mjnw9gyZG5qg+//hBXeV1f5V6m0M1UVn0M4iCkFfEdDBoiTy9EJUu7JqVm6
	 g17yZ2HGmk/ZQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 19/20] iio: adc: mt6360: Correct marking of timestamp alignment.
Date: Sun, 15 Dec 2024 18:29:10 +0000
Message-ID: <20241215182912.481706-20-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215182912.481706-1-jic23@kernel.org>
References: <20241215182912.481706-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This is sort of a fix as I assume this device only exists on
architectures that do 8 byte alignment of 8 byte types.  However,
drivers should not be written with that assumption and should allow
for the 4 byte alignment of these types as seen for example on
x86_32.  As such, we need to force the alignment of the timestamp
field itself not the containing structure, which will also be aligned
appropriate given C structure alignment guarantees alignment to at least
the alignment of structure member that needs highest alignment.

This is even more in the 'sort of' category because if we did
have insufficient alignment of the timestamp, then marking the structure
__aligned(8) would result in padding after the timestamp field.
iio_push_to_buffers_with_timestamp() doesn't actually use the field, but
instead where it is expected to be so will place the timestamp
in the last 8 bytes, whether or not the structure definition puts it there.
Hence it all works before the change. The reasoning is too subtle,
just mark the right element aligned and use the new aligned_s64 to do so
also clearing up the inconsistency of an int64_t timestamp relative
to most other IIO drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/mt6360-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
index 4eb2455d6ffa..f8e98b6fa7e9 100644
--- a/drivers/iio/adc/mt6360-adc.c
+++ b/drivers/iio/adc/mt6360-adc.c
@@ -263,8 +263,8 @@ static irqreturn_t mt6360_adc_trigger_handler(int irq, void *p)
 	struct mt6360_adc_data *mad = iio_priv(indio_dev);
 	struct {
 		u16 values[MT6360_CHAN_MAX];
-		int64_t timestamp;
-	} data __aligned(8);
+		aligned_s64 timestamp;
+	} data;
 	int i = 0, bit, val, ret;
 
 	memset(&data, 0, sizeof(data));
-- 
2.47.1


