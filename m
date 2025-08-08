Return-Path: <linux-iio+bounces-22471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2531BB1EC9D
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 17:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14B53B7A40
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 15:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022D3285CB5;
	Fri,  8 Aug 2025 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Nbe9If4D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3AE276038
	for <linux-iio@vger.kernel.org>; Fri,  8 Aug 2025 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668680; cv=none; b=tZc7/FxLO2SFFEFoL5pCVzY7jgGWF/kssuyKWjsSWz1kHY9dFmu6LpkKsgK+gcyr7gAEEZLxYpR5dR6fxucQdM1KxSdcF6sAGM2hDFniWk51mupbiX+aObQtITxnKvNJ+Eg1aXGmtngrgUIu+di6vi2SWLjKM5yCLWoz1FlaG8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668680; c=relaxed/simple;
	bh=YqJf+D7zh2ZgUcnVHKG1CPnMxnO/S4QDOIsnUiVXEOo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UQKA9RhQqTzPC1Ai5zDYOaufajon3fmb6nqAutnhhzzhAsEBKG36Bx4Hr6N4K7zcgCTfJxvdeUU/HrPRaMv/A9O+JRSU3GG8AjvuLAS59BwTI8MyK8V1vSkT3QyqNlb9IolRukLW096sdSh7ZrZl1UKZzliB1dVHqmpX+AqFbkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Nbe9If4D; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1754668666; x=1754927866;
	bh=Qqt2kcXtzxHB8ciKgDyv4c7Y9FiCu8CN9TBAfFgrK4g=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Nbe9If4DHY7K7wUquWTMGX1KKIcfFn4ObTFM8D1EyhTKJ7jGyPJxSsZmCbcR7znyK
	 bf7gABmNEfMuQK+o1vjUGkBiX3CX2u8cF6Jvy3n1GJMxT1+ngUZlADHoOhol+peJ/f
	 t0v8m/u5JjN20Ka153PNDgwOVnsnGuYRxefUOJtsoDFmMnhu/Lf4FG7VtKD5xHJPlZ
	 NEzN8T1wywhp4SHUkIk4N3EELSGFdMIrfOVb4r9rb9GBBLuIivDLFfsPhr889i3FIG
	 u2QEhZjjYmGrLAr/i3ObZBHOV3dY0omUw3AZfPwdgMWXQRzZWjJww13LcAni8TzbP/
	 TuUHUjX+3qVRg==
X-Pm-Submission-Id: 4bz7w76p9Pz1DDBg
From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v2 0/5] iio: imu: inv_icm42600: pm_runtime fixes + various
 changes
Date: Fri, 08 Aug 2025 17:57:40 +0200
Message-Id: <20250808-icm42pmreg-v2-0-a480279e7721@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHUelmgC/03MQQrDIBCF4auEWddijEXtqvcoWaQ6NbPQBC2SE
 rx7baDQxSz+gfftkDERZrh2OyQslGmJLcSpAztP0SMj1xoEFxeuuGZkgxRrSOiZkE63M0pbCW2
 wJnzSdmD3sfVM+bWk92GX/vv9MeafKT3jbHAclRmsMQ9x8zhF2s52CTDWWj/RVgpOpQAAAA==
X-Change-ID: 20250708-icm42pmreg-24d824d978c4
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

This series was triggered by "Runtime PM usage count underflow!" when
unloading the module(s).
By testing the driver in various use cases and reading code it was
obvious that it could need some tiding up.

I'm still not 100% satisfied with suspend/resume is calling directly to
vddio_enable/disable. In my mind it should be managed by pm_runtime.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes in v2:
- Removed patch iio: imu: inv_icm42600: Use inv_icm42600_disable_vddio_reg()
- Moved changes from patch iio: imu: inv_icm42600: Remove redundant
  error msg on regulator_disable() into iio: imu: inv_icm42600: Simplify
  pm_runtime setup.
- Move associated sleep close to enabling of vdd
- Pass regulator as the parameter to inv_icm42600_disable_vddio_reg()
- Use devm_pm_runtime_set_active_enabled() to simplify even more
- Added a new commit that uses guard() to release mutexes
- Link to v1: https://lore.kernel.org/r/20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com

---
Sean Nyekjaer (5):
      iio: imu: inv_icm42600: Simplify pm_runtime setup
      iio: imu: inv_icm42600: Drop redundant pm_runtime reinitialization in resume
      iio: imu: inv_icm42600: Avoid configuring if already pm_runtime suspended
      iio: imu: inv_icm42600: Use devm_regulator_get_enable() for vdd regulator
      iio: imu: inv_icm42600: use guard() to release mutexes

 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |   1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |  11 +--
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |  27 +++---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   | 105 +++++++--------------
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |  11 +--
 5 files changed, 51 insertions(+), 104 deletions(-)
---
base-commit: a5651af7f531ca57b9fc3114de77d9050012eb8d
change-id: 20250708-icm42pmreg-24d824d978c4

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


