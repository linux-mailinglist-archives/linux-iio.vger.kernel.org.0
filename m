Return-Path: <linux-iio+bounces-13519-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A681A9F2558
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7CAD7A06EA
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3090F1B81DC;
	Sun, 15 Dec 2024 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5r1TWiG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B471B87C9
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287408; cv=none; b=XyI2JgUbC9wHCETtqno04VMcYMPtqh4gTbD57WvKlCqHDd7AYy/BGFjvF4dElpWEjd7o7yJonDrKDX/R6EDZPb/1gL2lASjdQtUZUr9ZtgTWg+lwxZSDvsuf1uGczoJsBbaxHJbYtnGP6WPloW6AX6NCNFwGF+caFgCVxNNpizw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287408; c=relaxed/simple;
	bh=lHp0QJc48vtV03JO4iJTHOaa4JdkmrAuMvy+bWJyd/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPYn4NYXI/U+Odbq5IfUPn3Elz+IFbg5fxeQqPspbxr7bJxgq2bRS4rc5PKC32jI3bD85jaBc2CcP7qXUOMWfgUIhyRT9Ct5qEIMp/LS0DExdjz2EQO5FPbf88xJtuvdLLqSf44aZXlunYv/hUmc2lamKNSGyafwO6uOxmfyyN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5r1TWiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E074C4CECE;
	Sun, 15 Dec 2024 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287407;
	bh=lHp0QJc48vtV03JO4iJTHOaa4JdkmrAuMvy+bWJyd/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h5r1TWiGFE0kzoe+X7Tk8yA2q+OqroPOLUFvYtlvDmLY4hvTmoZjArZezGdA9NGjp
	 lt5APqd7X8+1aIyeoiu7gyv0vUQuM+3vFzocYswTty6auPOMZpxi5I1eKvrI4cbJT9
	 xvr3iKUUbfJMnNbDwd3qPVirzR4yTMb0QFdWSnPCnEm92PVdCU+bPnAVnMK3DCHMdA
	 F8W+DmlEkhpYSTxtXt1evRlWcFBb8LJd776xxsHH+S3YKpvzjy8A2d33dfnsWnwO/b
	 i6UjtprWTdtlhs/N316daQzkikOzUDuYz2weG6DQ4cBa2RFLffDC/cwCAjYWtdsLzn
	 jJph6iwTfR0XA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 14/20] iio: accel: bma220: Use aligned_s64 instead of open coding alignment.
Date: Sun, 15 Dec 2024 18:29:05 +0000
Message-ID: <20241215182912.481706-15-jic23@kernel.org>
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

Use this new type to both slightly simplify the code and avoid
confusing static analysis tools. Mostly this series is about consistency
to avoid this code pattern getting copied into more drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/bma220_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 009e6243c6cb..96ba028157ee 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -66,7 +66,7 @@ struct bma220_data {
 	struct {
 		s8 chans[3];
 		/* Ensure timestamp is naturally aligned. */
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	u8 tx_buf[2] __aligned(IIO_DMA_MINALIGN);
 };
-- 
2.47.1


