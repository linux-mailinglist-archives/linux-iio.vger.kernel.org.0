Return-Path: <linux-iio+bounces-17690-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6BCA7CF1B
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE626188D5A5
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18E817A2E6;
	Sun,  6 Apr 2025 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ikeis5Yz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30C51487F6
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743960023; cv=none; b=t/YhmX+AZVqfE/+2UtMrz6IGuPcjxxMNj1+VirVgMwJ5y42R1slvtNumQT2pEFLogRw79L90UcZUCYNUpRqaypthvYM1KSN4OOThAkS0PC8T/itJyyq4fLkZCgIFDLRuYcUT+VtUbgVeAQBCJLp7yLmbZTBSqT+XFPwcl3UrHmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743960023; c=relaxed/simple;
	bh=poRtUlqGEnmS/q2VwRMLFPMIvDU105ZgBO8Drq9gGpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgSJMUZtWQ9dsa1HH2z5G5FuRlSqO5+3nrRcS2Mb0tBcGOhy3c0g+nlV2MBoOz8trAdYy64UOT932NS5FRYEGHHWO3iKIS+J9nnikkZPPLuiJpIaD/Z5tRoSIH0oO1/HeU560d5uTvh7Ig8hyp5uuG1n9eHCh4HTqsCXEq8feJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ikeis5Yz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B159C4CEEB;
	Sun,  6 Apr 2025 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743960023;
	bh=poRtUlqGEnmS/q2VwRMLFPMIvDU105ZgBO8Drq9gGpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ikeis5Yzk4dQnmDbsSpXmXjjYat0MYgzq3FbAzfxNl+n2w6tkE7NVvCjWIh7myDIe
	 7ZnvjDg5IuE97mAMcqTy3EtZ4LghJXtuqW+5gjI5+tQg6ljL2Y9ZyYGY8dbA7CHDJW
	 4eF2hxXpQs96QXBss1hrqUsRct3eI/DSQkDVbA5tjNJNi3FCGB2HzBQEKCv5no37Tn
	 jcMFyGttBmr2udysmZo33KJWAKz9yD4ZmxWzBEl/+QWfpcdTx8mZFABbWmM1CY5huF
	 Gx8Jlbl0B4/Vi2V/E8qz/gXTjE0MfHja6Y/+TlZsEUsry2TcjNbpGIdst5oZ/chWCy
	 zo5ykkwQSjKNQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 02/20] iio: adc: ad7768-1: Fix insufficient alignment of timestamp.
Date: Sun,  6 Apr 2025 18:19:43 +0100
Message-ID: <20250406172001.2167607-3-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406172001.2167607-1-jic23@kernel.org>
References: <20250406172001.2167607-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

On architectures where an s64 is not 64 bit aligned, this may
result insufficient alignment of the timestamp and the structure
being too small. Use aligned_s64 to force the alignment.

Fixes: a1caeebab07e ("iio: adc: ad7768-1: Fix too small buffer passed to iio_push_to_buffers_with_timestamp()") # aligned_s64 newer
Reported-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7768-1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 5a863005aca6..5e0be36af0c5 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -168,7 +168,7 @@ struct ad7768_state {
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


