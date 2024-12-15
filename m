Return-Path: <linux-iio+bounces-13509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 767289F254C
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F98E188547E
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DD21B4F09;
	Sun, 15 Dec 2024 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLbvwmzj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C3013C8FF
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287382; cv=none; b=YNJ0UI80lcIxDqPd1mT3RRw4sbm4QZAAW0vBmHK5036woXT3lf8u2dt29eKgNjlrqXBsdByY+kiPUI0JUNEthBKvW+1cEOd6+QQlOSwlXpiUxOfQt9pdflFyd6AfzcFAWCp8stCXWHRYX/Ys0WMpShh2dBG/t2kRm76Uo5GIIPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287382; c=relaxed/simple;
	bh=30scRPRz18cDGbxdI/s9w8GHcmSgayjwpuO7o5JozZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNqh2fC3hX3LttDru9+3KUe2LiqNIAqBXVnHTKEFmaemYeBfAYR0k3ozt8j5Yedn+smlDN985u3XsH0QruTSuB9EuxECNT9sIkR6vsdWzDlVnkWqxmdb2APKuQI3tG2F524yUzEsYw+KvpuTdRkXV1dGqAx3tDH+JoIu/gDIEcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLbvwmzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B88EC4CECE;
	Sun, 15 Dec 2024 18:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287382;
	bh=30scRPRz18cDGbxdI/s9w8GHcmSgayjwpuO7o5JozZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OLbvwmzjMv0qnP0oh429dc8QFdKWAEBXNJdtK+2ZBNXl7m9++t/qcKKYSBGn6VHgw
	 cYUcZ3YFF0IW4kxKa80Gm5vYvWlZtsJpBqwu413eJ/InuGCy7fMu4pHRwXQB+q1tHx
	 CxxJiInkm4AECe24maYRsNQ6SAuRNgAx+7Y4Nbu3zyYJ3hL/33yxqw5CIit0yn4/jf
	 v7V7/5RJfMljnIJY4S9QKWPaql6jiWCMVXCxXhvIyHwiJLSnEA8AfG2ZWxJPgFsuOu
	 NrlQXKEgtgxShJ2WKmY1sad9liHuADYyCK1xUOT8zCWh9b1gH8rbSnKvN0kyIq23oN
	 n6AYb/sfRmbvg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 04/20] iio: resolver: ad2s1210: Use aligned_s64 instead of open coding alignment.
Date: Sun, 15 Dec 2024 18:28:55 +0000
Message-ID: <20241215182912.481706-5-jic23@kernel.org>
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
 drivers/iio/resolver/ad2s1210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
index a414eef12e5e..b681129a99b6 100644
--- a/drivers/iio/resolver/ad2s1210.c
+++ b/drivers/iio/resolver/ad2s1210.c
@@ -164,7 +164,7 @@ struct ad2s1210_state {
 	struct {
 		__be16 chan[2];
 		/* Ensure timestamp is naturally aligned. */
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	/** SPI transmit buffer. */
 	u8 rx[2];
-- 
2.47.1


