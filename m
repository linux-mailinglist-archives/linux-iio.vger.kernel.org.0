Return-Path: <linux-iio+bounces-20910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6D2AE4139
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 14:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39CE216576D
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 12:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257AC24BBEB;
	Mon, 23 Jun 2025 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnr1jsmg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23F0248F46;
	Mon, 23 Jun 2025 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750683360; cv=none; b=joYffXTJvAoEoXot5e+E4eWoilS232+HRc113lvrhB1wBrXIO2vlOaQMkCPTdAOdDAkXqtCaTtcgXJZLBEJKHVdzGXkgvRXFaWx6mPCIzSZ7tO6ggxm19AULQnCHUkTnopr/Df0j91aLANMN094VxSm83kuXuiaMJIPNta9k1Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750683360; c=relaxed/simple;
	bh=GBV2qWzAZqKcjRCN2BdJiqj86LQYUfioaIFvJYlsEh8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IgnR5eAm+GUJ3M02QMzG7XLznoi/sz91a5Z/1LI+oPSz2ZjlMSHEYF6hYUl5Ycju/hV/TbtmEf9EbrS2npZAbaSsElFAWSPD57Ov9tgIFz+tVTSgXWs0/Khalk9vnzpOTI3T1MX6OU8uc06jS2GvgZQhqeQmmOsA8X+Q/B/zDdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnr1jsmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52CA6C4CEF1;
	Mon, 23 Jun 2025 12:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750683360;
	bh=GBV2qWzAZqKcjRCN2BdJiqj86LQYUfioaIFvJYlsEh8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=hnr1jsmgbmfKbpr1ln8zOT57q7qyKNKhQ53dpB4mC0dDaruTX46KSk/OnjJKbljS8
	 5Odttl07Ttk+7mKwVqezX2VF5s7xBtQO8wd/T/8xlWb269mnrrcbsv6N0Pn8rNQ8RP
	 sYCjxvgCq+Qi1t+PB4U8NxB+JHKv7o1mG4q0LwE3gAzsiFhRv5Jd/saCJ28HvU/R2E
	 1ZaDcgoLZP/fRLoI47qL23cxUswauraISPdP3vNYwKVSQdiGXvr+ioXAr3iXysDZg3
	 rAzRkucj/6fzBoKNpQ9wHL539O9SPJPRLCKoe9D5H7puHRXfa+CiNlzN//4I1i4Fuu
	 mZHXfoOqlYKzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F289C7EE2A;
	Mon, 23 Jun 2025 12:56:00 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Subject: [PATCH v5 0/3] Add support for WoM (Wake-on-Motion) feature
Date: Mon, 23 Jun 2025 14:55:51 +0200
Message-Id: <20250623-losd-3-inv-icm42600-add-wom-support-v5-0-4b3b33e028fe@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANdOWWgC/5XNsVLEIBSF4VfZofY6lwskwcr3cLYIAVxGEzIQW
 Z2dvLtkm6hVLP9TfOfGskvBZfZ0urHkSsghTjXUw4kNl356dRBsbUZICokQ3mO2ICBMBcIwSmo
 QobcWrnGE/DHPMS2ADaF3XltDglVpTs6Hz/vLy7n2JeQlpq/7aeHb+j+/cEDQRovW667RSj4v9
 u1xiCPb9EK7KLk6JlIVrdPSeqPJtO63KH6K3TFRVLHteYe9RzL+jyh3seHimCg30SmvlCTkxu/
 iuq7frFYfIsoBAAA=
X-Change-ID: 20250220-losd-3-inv-icm42600-add-wom-support-0620fef9db23
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750683359; l=2368;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=GBV2qWzAZqKcjRCN2BdJiqj86LQYUfioaIFvJYlsEh8=;
 b=mTJkw36Z40Py6pxEwzAIWTCqZzU9opJo1o8b3zv1vdjo9+uw4TUv2tDEBjWxUOFbsGyk5P6fK
 SPJWKwmeFB6Aqxr/D/Rs3FLd3YRXyFmj8kDHFHeEuJaG2FSoiHseHrY
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
Changes in v5:
- Add preliminary patch to move DMA buffers at end of structure.
- Check return code of devm_device_init_wakeup()
- Rebase and rework series to use kernel types
- Link to v4: https://lore.kernel.org/r/20250613-losd-3-inv-icm42600-add-wom-support-v4-0-7e5f554201bf@tdk.com

Changes in v4:
- Avoid mix of gotos and scoped_guard()
- Invert conditionals for better code readability
- Switch to use devm_device_init_wakeup()
- Several code readabilities improvements
- Link to v3: https://lore.kernel.org/r/20250418-losd-3-inv-icm42600-add-wom-support-v3-0-7a180af02bfe@tdk.com

Changes in v3:
- Rewrites following code review
- Link to v2: https://lore.kernel.org/r/20250415-losd-3-inv-icm42600-add-wom-support-v2-0-de94dfb92b7e@tdk.com

Changes in v2:
- change struct order to avoir DMA overflow
- separate wom enable/disable in 2 functions
- delete mutex rework
- Link to v1: https://lore.kernel.org/r/20250220-losd-3-inv-icm42600-add-wom-support-v1-0-9b937f986954@tdk.com

---
Jean-Baptiste Maneyrol (3):
      iio: imu: inv_icm42600: move structure DMA buffers at the end
      iio: imu: inv_icm42600: add WoM support
      iio: imu: inv_icm42600: add wakeup functionality for Wake-on-Motion

 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |  56 +++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 294 ++++++++++++++++++++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  97 ++++++-
 4 files changed, 435 insertions(+), 14 deletions(-)
---
base-commit: b57cb7c47e31244bef6612f271c5dc390f761e17
change-id: 20250220-losd-3-inv-icm42600-add-wom-support-0620fef9db23

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



