Return-Path: <linux-iio+bounces-18138-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F870A8A17F
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 16:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D2B17F07D
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 14:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653971FDE0E;
	Tue, 15 Apr 2025 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zk1CgVzY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1017A317;
	Tue, 15 Apr 2025 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728456; cv=none; b=jPLdLQc5EM8XU/7gtTRaM/IOsexqnC2GYujnK7+nM8/HUX+XBJ4OUjTPRl0UxRU6EMvNepBhv+Ufm4BouX3wvIqF0kVLDDAuKVXGdlTI3u3AI2A89qHrmhdDsdu1GRmcQVsHrlI8WLJQC/rNaFruh7sFnfXtqV51xLanKat05Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728456; c=relaxed/simple;
	bh=GW6rmLEB+/jR0gzntBZE6oCSjXW/0GJVVJVpvKoCtfc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LUQclM/BKQ3GefStw+qQvBPe4kAgaHQ5UPeVy6Rk8PwQXgmM7I3GAT4iIuid3D4G5HmEN91p2c4LIeI9nsLCo3l67zybIQv307VoCSwtWGcgmALiu739ZEkO8VgGbkaQ5A7QUJH/Bgfzc791Ja24N6oIBXc7ngcH8CU/hJqJLlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zk1CgVzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 878D9C4CEE5;
	Tue, 15 Apr 2025 14:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744728455;
	bh=GW6rmLEB+/jR0gzntBZE6oCSjXW/0GJVVJVpvKoCtfc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Zk1CgVzYnx7oMucamAHdVdoOfUm3MSz3BoP5sXAOgTjqF5vv7Fwm3JObOowYPkYPJ
	 Q5zstOHUGiOwTXgIZZMXB0Crb+6S4FSWMhncbcpo3xoDFggqaix4kk7rnc6v9lxJS5
	 UJqmhdh3z5pcL8aHmFaYT3c5kryybotKAgziWSZLjLM0CWotnALbvuU0Pxv3QAqcwO
	 gxtSCPsjoqr2Uo+ZgmvdHC7CdSFlsAU4pN8zc1S/iJCaKiQ00QZMAf+OUQcdljc1bo
	 DfoRWaHhXmvkyA2akaw3QO7OtRqHMz0VZciqCv6pzBM0k9PUUYaCfmslZwulyZ8q/j
	 lWuDZP+D7GumA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D767C369AB;
	Tue, 15 Apr 2025 14:47:35 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Subject: [PATCH v2 0/2] Add support for WoM (Wake-on-Motion) feature
Date: Tue, 15 Apr 2025 16:47:30 +0200
Message-Id: <20250415-losd-3-inv-icm42600-add-wom-support-v2-0-de94dfb92b7e@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIJx/mcC/5WNSw6CMBBAr0Jm7Zhx+GhdeQ/DAmgrE4WSFquGc
 HcrN3D53uK9BYLxYgKcswW8iRLEjQl4l0HXN+PNoOjEwMQlMRM+XNCYo4wRpRsKroiw0RpfbsD
 wnCbnZ6SKyRqrdMs5pNLkjZX3drnWiXsJs/OfbRoPP/tfPx6QULUqP1p1qlRZXGZ933dugHpd1
 y/W0xKX1AAAAA==
X-Change-ID: 20250220-losd-3-inv-icm42600-add-wom-support-0620fef9db23
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744728454; l=1534;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=GW6rmLEB+/jR0gzntBZE6oCSjXW/0GJVVJVpvKoCtfc=;
 b=Yb4lqMPuRKStcCXktJRLJOTaN8pYqhSL6Bbwgc6KcEZO3aE2jCejFsr5xle77v3m3Eir8k3ht
 sua8y/RfdJ3D12NX37dIHDPeN8OUOWzEix/l2R1JqJpgNHX8XstWl2x
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

Similar to feature present in older chip, it compares the magnitude of
the last 2 accel samples against a threshold and returns an interrupt
even if the value is higher.

WoM maps best to accel x|y|z ROC event. This series add system wakeup
functionality if WoM is on and wakeup is enabled when system suspends.

This series also prepare the driver for supporting further APEX
features like pedometer, tilt, ... It introduces an apex structure that
will hold all APEX settings and track the enable state.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
Changes in v2:
- change struct order to avoir DMA overflow
- separate wom enable/disable in 2 functions
- delete mutex rework
- Link to v1: https://lore.kernel.org/r/20250220-losd-3-inv-icm42600-add-wom-support-v1-0-9b937f986954@tdk.com

---
Jean-Baptiste Maneyrol (2):
      iio: imu: inv_icm42600: add WoM support
      iio: imu: inv_icm42600: add wakeup functionality for Wake-on-Motion

 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |  56 +++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 283 ++++++++++++++++++++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   | 103 +++++++-
 4 files changed, 430 insertions(+), 14 deletions(-)
---
base-commit: d3d6cb27a945c6fc7ddd3e7423c4303b4b6bad36
change-id: 20250220-losd-3-inv-icm42600-add-wom-support-0620fef9db23

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



