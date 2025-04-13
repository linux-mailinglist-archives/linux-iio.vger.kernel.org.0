Return-Path: <linux-iio+bounces-18046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C93A87189
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C75F16EA01
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8F5191F66;
	Sun, 13 Apr 2025 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPRdqdrT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFEF2AD3E
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540501; cv=none; b=R52fHbjFJRs2eVVZmZm66cPeC7juD2s44u9JwdmPr553+nThjd9bdNWX4OCmPBhInvV2ZaLKeq17qyFSh3FnNAH1a8++SBt2J93EXG6B5nabEB6ekPl5UFhUkMgQg38ub6d3fS8QUWn+yz4/GWpv9x68Q/Cj5z/VcOT+iG2tFKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540501; c=relaxed/simple;
	bh=m2uSxOCpL7j4XeB9IwdsCSvOtRV0abSUwlbpxi5idwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cr4eCYK5Bjdy72TVjUTsba4F9I5jo2GsJMjKC1VLvFZSJYPtGSHmi2EHWYgNmA721Qh+jfEEuWAF4pUUnAwZykI0rKFq/T6u+8Vh/w2OohztpHqGdLHf6E43TbJ2aBwZPX1UoUM0ODJcRm2C2GEfo1bjkpmdEq5DYNrgHcdJgLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPRdqdrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13463C4CEDD;
	Sun, 13 Apr 2025 10:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744540500;
	bh=m2uSxOCpL7j4XeB9IwdsCSvOtRV0abSUwlbpxi5idwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tPRdqdrTNa3cqQat+1tnLxucGuI9UZdlXipZ5incIs6LlqoUhE1/QF0PlOYVii/J/
	 xLzpDpwZl4/6CvJvleF8/b8ZTqVkAG+h0FBxBjW0Fb0ISPIYCrknvTT/HVi5bgzJyl
	 /JAAvA8B7IfUGdi47HJs+nCzxtrHqKvN9f2VGGGNIqeY0Udgx9T3OcYYTunailqQS3
	 I0loa+VZbSZtAed6+MwhLNTLPs7mc3GJFNyr+5gOtWkcB6LyO3zgj7JjbLAGiFdNSJ
	 p2b5OTKImI/LtKU+uK/Lr1ig8ld9pDRrSYYnVQorCGWtskf0j4KbIR7rRp7w98Kesr
	 lcOwKgTZan//A==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 02/20] iio: adc: ad7768-1: Fix insufficient alignment of timestamp.
Date: Sun, 13 Apr 2025 11:34:25 +0100
Message-ID: <20250413103443.2420727-3-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413103443.2420727-1-jic23@kernel.org>
References: <20250413103443.2420727-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

On architectures where an s64 is not 64-bit aligned, this may result
insufficient alignment of the timestamp and the structure being too small.
Use aligned_s64 to force the alignment.

Fixes: a1caeebab07e ("iio: adc: ad7768-1: Fix too small buffer passed to iio_push_to_buffers_with_timestamp()") # aligned_s64 newer
Reported-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v3: 64-bit in commit message (Andy)
---
 drivers/iio/adc/ad7768-1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 09e4ab76e2b6..50dee37d4b08 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -172,7 +172,7 @@ struct ad7768_state {
 	union {
 		struct {
 			__be32 chan;
-			s64 timestamp;
+			aligned_s64 timestamp;
 		} scan;
 		__be32 d32;
 		u8 d8[2];
-- 
2.49.0


