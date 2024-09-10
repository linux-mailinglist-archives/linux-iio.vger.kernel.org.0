Return-Path: <linux-iio+bounces-9432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CB1973F90
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 19:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9121C1C20E87
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 17:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D1B1BBBE5;
	Tue, 10 Sep 2024 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4QdhDdz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5C51BBBDA;
	Tue, 10 Sep 2024 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988996; cv=none; b=V4e4oc1NIENhvQ7JRHnptm6GtNtwBD/3F3EE9olyO7/hBXbdQy/T/CIxqUya3Esyv1Td+2pkir1jr+iuAdU819dtX7VOWNzZYqkZaD+6bgfE0TScZ4JWNaJtKA+MIkXvAEh9mK9j1Y7WEc3vZQ5AMtzXenKRRHlYx9zrOAUzdFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988996; c=relaxed/simple;
	bh=Pz6ByEUAA2e7z7QMJPjcM7ls1ioJtV2pZRHzNjfD0Ds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pGZDjUjw+PDJD6rhyDFKB7UqpuN9VFWmSi6GUaKJl66EEBudInFY+nXaXIrXu03pvuV8B4ipHa4aidB+IvNTHNGJkoMDuGkCvry0VCudCNhUsw13h7H4l8AupLboJutRcZU7ex+Pq+ZqUE0TTAvcz9HISLwGfsvzleZT6amuktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4QdhDdz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E20FC4CECE;
	Tue, 10 Sep 2024 17:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988995;
	bh=Pz6ByEUAA2e7z7QMJPjcM7ls1ioJtV2pZRHzNjfD0Ds=;
	h=From:Date:Subject:To:Cc:From;
	b=O4QdhDdz7uqEpMUaqlA949WNPRzs+AS2KmaqsSEmnw1QywNm8VtXhQxGE0ilfKnEs
	 7RgA5e0OXMAnJHp7UGe4BQmSBb38amXc+uCQIOj1LsJyJ2okJiAOVHjJ98Gvd61D6y
	 Z4ZPscd5U9rjexfjmuQ8MLHww+R8PSEjKzb9jsovtqXO1j7xENdDLnF5UzG9teetlJ
	 RBQbWk3V2HDnJ7kHUEeMfzsbcIHRJqPT0ow4vU03pT1TKL0Dny7bdbmnNEiX5pXVc2
	 O0AXUKq73ckcPtHyujAhb07l4Unfg+ysifOxHrD0Ex0IE3N513CUImpXmCwhOmHmEw
	 NtbALF2SpznRw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 10 Sep 2024 10:22:54 -0700
Subject: [PATCH] iio: bmi323: Drop CONFIG_PM guards around runtime
 functions
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-iio-bmi323-remove-config_pm-guards-v1-1-0552249207af@kernel.org>
X-B4-Tracking: v=1; b=H4sIAG2A4GYC/x3NTQqDMBBA4avIrB2YxIo/V5FS0jims0giE5SCe
 PeGLr/NexcUVuECc3OB8ilFcqowbQP+41JglLUaLNkHTYZQJOM7Smc7VI75ZPQ5bRJee8RwOF0
 L9gMNUz8yOW+ghnblTb7/yfK87x8hETGDdAAAAA==
X-Change-ID: 20240910-iio-bmi323-remove-config_pm-guards-5707958e0ac1
To: Jagath Jog J <jagathjog1996@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Denis Benato <benato.denis96@gmail.com>
Cc: linux-iio@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2939; i=nathan@kernel.org;
 h=from:subject:message-id; bh=Pz6ByEUAA2e7z7QMJPjcM7ls1ioJtV2pZRHzNjfD0Ds=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGkPGpqTj903X8Z2hnfVmohXWgI3OxOYDpdaOwvGRi7MO
 z0psvFmRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZiIjzojw8TTj3v7/s7b4lOi
 O2fnB6acyB4nwYVF1x+td+179kxteggjwz7L8G4hYc81S7eryUyaIctgrJonxP9+msyT/5NuXAk
 T4QIA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building with clang and CONFIG_PM disabled (such as with s390), it
warns:

  drivers/iio/imu/bmi323/bmi323_core.c:121:27: warning: variable 'bmi323_reg_savestate' is not needed and will not be emitted [-Wunneeded-internal-declaration]
    121 | static const unsigned int bmi323_reg_savestate[] = {
        |                           ^~~~~~~~~~~~~~~~~~~~
  drivers/iio/imu/bmi323/bmi323_core.c:133:27: warning: variable 'bmi323_ext_reg_savestate' is not needed and will not be emitted [-Wunneeded-internal-declaration]
    133 | static const unsigned int bmi323_ext_reg_savestate[] = {
        |                           ^~~~~~~~~~~~~~~~~~~~~~~~

These arrays have no references outside of sizeof(), which will be
evaluated at compile time. To avoid these warnings, remove the CONFIG_PM
ifdef guard and use the RUNTIME_PM_OPS macro to ensure these functions
always appear used to the compiler, which allows the references to the
arrays to be visible as well. This results in no difference in runtime
behavior because bmi323_core_pm_ops is only used when CONFIG_PM is set
with the pm_ptr() macro.

Fixes: b09999ee1e86 ("iio: bmi323: suspend and resume triggering on relevant pm operations")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
NOTE: The second warning will still be visible without this change as
well:

https://lore.kernel.org/20240909-iio-bmi323-fix-array-ref-v1-1-51c220f22229@kernel.org/

Technically, the blamed change for that fix is somewhat responsible for
this issue as well but I believe the one I assigned was the real culprit
because this diff should have been in that change.
---
 drivers/iio/imu/bmi323/bmi323_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 671401ce80dcf947b7b64ea3af112d2a42ca5501..1d1405d37c5adb2717fc27d6b22540da50dea6d4 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -2172,7 +2172,6 @@ int bmi323_core_probe(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(bmi323_core_probe, IIO_BMI323);
 
-#if defined(CONFIG_PM)
 static int bmi323_core_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -2293,11 +2292,9 @@ static int bmi323_core_runtime_resume(struct device *dev)
 	return iio_device_resume_triggering(indio_dev);
 }
 
-#endif
-
 const struct dev_pm_ops bmi323_core_pm_ops = {
-	SET_RUNTIME_PM_OPS(bmi323_core_runtime_suspend,
-			   bmi323_core_runtime_resume, NULL)
+	RUNTIME_PM_OPS(bmi323_core_runtime_suspend,
+		       bmi323_core_runtime_resume, NULL)
 };
 EXPORT_SYMBOL_NS_GPL(bmi323_core_pm_ops, IIO_BMI323);
 

---
base-commit: 5ba0cb92584ba5e107c97001e09013c1da0772a8
change-id: 20240910-iio-bmi323-remove-config_pm-guards-5707958e0ac1

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


