Return-Path: <linux-iio+bounces-16718-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F15E1A5A716
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 23:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA9B16AE23
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 22:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADD82206A4;
	Mon, 10 Mar 2025 22:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oluzkh+7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932AE1F09B5;
	Mon, 10 Mar 2025 22:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645430; cv=none; b=QM/ygyK0kTQ/HlPhrWi4tT8bkoh8alCk08mhW1Cjw4/Nm0dlkoQk7HRJNAUDd83M2yYrZHMDvVqDPSrrJMwt2wcMcv/TL7VsbNHLk4gOdtTPkXgy0iWaiixml+cV3t2UQdWcaERNZYIUtlcTAmjG7PbO6/OJ3tG5ITMXnpuaJI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645430; c=relaxed/simple;
	bh=kdUCSqpuasqowRfAXURMX8w3Qjxb4lGeKUORyMRWdKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c/YoN5d9tsv64VUUMXReS7alHq1qyXOzL7/rdIdvKmG8Mv/7jCV6n+pFh23hKqcV3abVjGPDEwHLSa2QncexwOlAf50l6cqOVc5Qz+rg8+WGGSOvuyju5MuZq/Fxk5YGplyt+DRK9/RpXYDPLZWJSoBLUJXeXuPp8Sb5aitIyQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oluzkh+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D58AC4CEE5;
	Mon, 10 Mar 2025 22:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741645430;
	bh=kdUCSqpuasqowRfAXURMX8w3Qjxb4lGeKUORyMRWdKU=;
	h=From:To:Cc:Subject:Date:From;
	b=oluzkh+772UtuIkObeJ5fMfMlTc2tTUhswd04G6ShiTvTE80i6rLI/tcDHNIo0bfI
	 PdlT4vL4veTeqD1X1rI6wyGTSagpnAS/veT+Id0it9hv3GORfGK4ZBH71r1Pzs0FIr
	 nRRcZAOQFMS6yVPLkWX3NEmT0EePEaUobAu/Cs3EV322jfRrydu01I+CNTAIt0tGlZ
	 6D19ZQnEo6LyeTLJiOuHEoxSdKQiwfWpl1Lp73VzFGBPow324ELSnisYQvUqQ76YW8
	 VQmdFDNdtkiqEu8JCLXHd78xFo2OMbrwMIsVQKw+mxsxzd4DkyKhfeSL4cmarzPF2/
	 ndWYJ+f79b6AQ==
From: Kees Cook <kees@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kees Cook <kees@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] iio: magnetometer: ak8974: Add __nonstring annotations for unterminated strings
Date: Mon, 10 Mar 2025 15:23:47 -0700
Message-Id: <20250310222346.work.810-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415; i=kees@kernel.org; h=from:subject:message-id; bh=kdUCSqpuasqowRfAXURMX8w3Qjxb4lGeKUORyMRWdKU=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnn04pKn8xfm5Qw8Z1KiXGX3OKp0741VmX08Hcc3Ri6k c/nxJ8pHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABNZdYvhv9f8I5d3uJ37mJhz +UGmoE7tpBufg3gi/D8LBV7gyQ7g4mFkmJhqvbXl4sWVJQ8aA1Ts4k4uP66rojLj62FbRXtJFp8 cNgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
with __nonstring to and correctly identify the char array as "not a C
string" and thereby eliminate the warning.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
---
 drivers/iio/magnetometer/ak8974.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index 08975c60e325..44d8428a69b0 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -535,8 +535,8 @@ static int ak8974_detect(struct ak8974 *ak8974)
 				       fab_data2, sizeof(fab_data2));
 
 		for (i = 0; i < 3; ++i) {
-			static const char axis[3] = "XYZ";
-			static const char pgaxis[6] = "ZYZXYX";
+			static const char axis[3] __nonstring = "XYZ";
+			static const char pgaxis[6] __nonstring = "ZYZXYX";
 			unsigned offz = le16_to_cpu(fab_data2[i]) & 0x7F;
 			unsigned fine = le16_to_cpu(fab_data1[i]);
 			unsigned sens = le16_to_cpu(fab_data1[i + 3]);
-- 
2.34.1


