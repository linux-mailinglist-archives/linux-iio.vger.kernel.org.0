Return-Path: <linux-iio+bounces-23566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F9BB3DB76
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 09:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97681892DC2
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 07:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F272EF641;
	Mon,  1 Sep 2025 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="KGepfKR8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33582ED868;
	Mon,  1 Sep 2025 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712981; cv=none; b=XBJq5mY+31oHw6jIj3sykjTDYt3Q7YcfG+XzmJe6GUw9JKB6ai7COdc+Uq2ra2dklEkJqh5L32nqQAoRNYiNukWaZNgfg2EgI0sbfC32/HMXwdH1WYVSXr7X8B7declSVspvXdXpVGrjhQYLtRxFo5ESA/nYWUdKJti+2hWuJWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712981; c=relaxed/simple;
	bh=ckswT7WvNXDa0dxPs+Xa4V9wybPv1JkK4ISQKyqpDf4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X3/F4+IY9dq/U1HccPgaz69cWFdNYOQWVQBTHegCxDhY2gkiqcmFwf2CIhVbgfeo3MDUH21g0QVKEid8QgS4uvacbATvm4vylejCC15BbIA80C3aMAp8MVNxMBIYyyaswE+SY3lH0CPjAhktwpOD2Cxupe7IR6Gmb8fcH2YeWzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=KGepfKR8; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1756712969; x=1756972169;
	bh=pBWhhUuZsW1wCrcE3zlawXKxQZz9uOBaHWsIB7cQ3YM=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=KGepfKR8fyzh0xN7LfYLo9tattgzL7MzfvW8fCyPOH/o30fDDwZHlsImyCNI8mtMC
	 ozmA84kBFXwjSbzqHPq7PrbS9aCXB0EU+jhiM7UBjMs30zE+tzqGCA9AyU9Oa9IAPJ
	 bpjP5uaJwpiFI/Dq0gDnZGkwrcScUG0/RcnurCn6gM1SLGgdO5gO9HePJSzdlCJzJ6
	 xkE3Mlp/WgR7wODtPUQSneTSfBZXl7mXfId/tf+deHLqGLbrEkxIy9Y6TIqe65PVjn
	 a8h+EJBHQbMMCs5//KNLVmPnXf3WrPMQqaWYm/+hrXEfKx+vVRkDJCRPRsNbiF69EF
	 QQsUMQdDtJ9gQ==
X-Pm-Submission-Id: 4cFgxg04Sgz1DDBx
From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v3 0/5] iio: imu: inv_icm42600: pm_runtime fixes + various
 changes
Date: Mon, 01 Sep 2025 09:49:12 +0200
Message-Id: <20250901-icm42pmreg-v3-0-ef1336246960@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPhPtWgC/1WOzQqDMBAGX0X23JS4SUnSk+9RerBxq3vwh6QEi
 /jujUJpPexhPphhF4gUmCJciwUCJY48DhnUqQDf1UNLgpvMgBIv0kgr2Pcapz5QK1A3Np8z1mv
 IwhToyfMeu90zdxxfY3jv7VRu6zfj/jOpFFKoRpJxyjv3wKqleuD57Mcetk7Cn2uPLyTMbq2tR
 OPIGCwP7rquH1sTuu7hAAAA
X-Change-ID: 20250708-icm42pmreg-24d824d978c4
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 rafael@kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

This series was triggered by "Runtime PM usage count underflow!" when
unloading the module(s).
By testing the driver in various use cases and reading code it was
obvious that it could need some tiding up.

@Rafael:
Is checking pm_runtime_status_suspended() is a viable option?
To avoid calling regulator_disable 2x during remove()?

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes in v3:
- Return early if pm_runtime_status_suspended() is set.
- Fixed various comments from Andy in "use guard() to release mutexes" 
- Link to v2: https://lore.kernel.org/r/20250808-icm42pmreg-v2-0-a480279e7721@geanix.com

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
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |  25 ++---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |  27 +++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   | 119 +++++++--------------
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |  20 ++--
 5 files changed, 67 insertions(+), 125 deletions(-)
---
base-commit: dfbbee0907fb30a1dd31ff1a84e1bd34bd824369
change-id: 20250708-icm42pmreg-24d824d978c4

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


