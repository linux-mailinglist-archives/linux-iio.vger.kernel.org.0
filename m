Return-Path: <linux-iio+bounces-10480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442AE99B228
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 10:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0CEF2822AB
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 08:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D380F148832;
	Sat, 12 Oct 2024 08:37:38 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 049BF137750;
	Sat, 12 Oct 2024 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728722258; cv=none; b=f3UFeLgJ8aotptVMxuXTIOcNPQTYa/ZzU+wTnqJosXBh3Dv3jIf27fpXEQpW3NI25zRj8CGB7i8KTqwpAi05kmJh1a1K00XuHVAGHeYGwxHqq4H8VAr71L12Yrv8lpwHSNAVeMmLYt7dgBVBX0f8veXZ93e13EDTPz6zV0fyOAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728722258; c=relaxed/simple;
	bh=0Uyg5wEJVxDWuiR8R2PnrX3dVlJmYoSGbo2wB56uxxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e+Myrga2dXIpJcS5SrsRVhwesYWSbbSJJCU/B/sEBfj2oGsIkeEBEZqS8k1dUIsS3qLahfNh+nGaDpvqc/aFbQF1kWH2nZTFzDhJHMbtJRY++xcTWTIWHv5xP7EKlp4exdnDewPVf0WdlyU0dmBgTzcmYsPbtBxQfD8u4xIHqJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 33B7860A6F420;
	Sat, 12 Oct 2024 16:37:30 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: jagathjog1996@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: Su Hui <suhui@nfschina.com>,
	benato.denis96@gmail.com,
	Jonathan.Cameron@huawei.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: bmi323: mark bmi323_ext_reg_savestate as maybe unused
Date: Sat, 12 Oct 2024 16:37:02 +0800
Message-Id: <20241012083701.2189663-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running 'make CC=clang drivers/iio/imu/bmi323/bmi323_core.o', there
is a clang warning as follows:

drivers/iio/imu/bmi323/bmi323_core.c:133:27: error:
variable 'bmi323_ext_reg_savestate' is not needed and will not be emitted
[-Werror,-Wunneeded-internal-declaration]
  133 | static const unsigned int bmi323_ext_reg_savestate[] = {
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.

Mark bmi323_ext_reg_savestate as __maybe_unused to silent this warning.

Fixes: 16531118ba63 ("iio: bmi323: peripheral in lowest power state on suspend")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index beda8d2de53f..1167984809c5 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -130,7 +130,7 @@ static const unsigned int bmi323_reg_savestate[] = {
 	BMI323_FIFO_CONF_REG
 };
 
-static const unsigned int bmi323_ext_reg_savestate[] = {
+static const unsigned int bmi323_ext_reg_savestate[] __maybe_unused = {
 	BMI323_GEN_SET1_REG,
 	BMI323_TAP1_REG,
 	BMI323_TAP2_REG,
-- 
2.30.2


