Return-Path: <linux-iio+bounces-20579-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2BEAD8413
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 09:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE713A0E32
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 07:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BEE2C3770;
	Fri, 13 Jun 2025 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0cnVtUt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDC8238C26;
	Fri, 13 Jun 2025 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800072; cv=none; b=kaWiwQjaVnLpA4rfvZUzmfMfmEZjqIgN4TtHREBG2MAOzXfcWEquBi6zSYC6MOEKpfvQJSWhmJXDBwud+OlumPUzQXBx6l+YnxQL27qcCHVoAXoTeODdDliG7GpBhXKe+V8n4cB9JMJ7vkGLGIGgKgW4iVgIZTtvM8xZ4NVi+SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800072; c=relaxed/simple;
	bh=TwO64dudIgSMsHCJyLSriUaJU7jxFNj2lwY1rcJ4tMI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kLPCP58aIIoDza3pjrdAD2eNS0tN5ExxIzlNaVIC+RkrUaNWDAfSDrhZryF46p7ZQc39zDmmBSWTOVeM8mmDevKxvUn4mUvHAoA6QtAhZjYXpaCIqZxgT8Guwc/XmccCAzLtQpvEK13k+sgFMSUZPjKRufeROOLK/9PqL23C3PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0cnVtUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CECAC4CEE3;
	Fri, 13 Jun 2025 07:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749800072;
	bh=TwO64dudIgSMsHCJyLSriUaJU7jxFNj2lwY1rcJ4tMI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=j0cnVtUti3K+VmYaVL8loJotzc2iwSugPx8Lpms2yx8Q22sTLU03+2xeMvPSxgBBC
	 2bO8H0kp+p12c6Ckvkw7ot1sLl8fUCGNxoZfgl66YZdO76erPF0xkIO0VocQk1Gg0t
	 fkWVKADCt05PyfPMTMawdwKcXiqGCZxxgDtxVSsnIV2Yz2m7GOOmOi2sHwkSACaFe4
	 p4Fn4aHjTVPJBZJR7It0CHlvEyEqNbb7bi34Lqz/GySEufTspBx0C58gCKNwYdAr2u
	 EDpGubrbkTvnaS8y/brewhPiXlEL9Th7CSL4AEJKDUwu1CEYiNFfAY+gf5V8bXZ+yn
	 5YGYMAxD70RAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBB6C61DB2;
	Fri, 13 Jun 2025 07:34:32 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Subject: [PATCH v4 0/2] Add support for WoM (Wake-on-Motion) feature
Date: Fri, 13 Jun 2025 09:34:25 +0200
Message-Id: <20250613-losd-3-inv-icm42600-add-wom-support-v4-0-7e5f554201bf@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIHUS2gC/5XNvQ7CIBSG4VsxzB5zeqA/OHkfxqEUUKItDVTUm
 N676KJuOr7f8Hx3Fk1wJrL14s6CSS46P+QQywXrDu2wN+B0bkZIJRIhnHzUwMENCVzXC6oQodU
 aLr6HeB5HHybAitAaK7UizrI0BmPd9fWy3eU+uDj5cHudpuK5/uenAhCkkry2sqlkKTaTPq463
 7OnnugtiqL8TaQsaiOFtkqSqs23yD/F5jeRZ7FuiwZbi6TshzjP8wO80NbpeAEAAA==
X-Change-ID: 20250220-losd-3-inv-icm42600-add-wom-support-0620fef9db23
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749800071; l=2005;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=TwO64dudIgSMsHCJyLSriUaJU7jxFNj2lwY1rcJ4tMI=;
 b=Pmoj3isAVCMsHd+CoUSknvOHXDcqng1pbj168wEOv4VwC4WH0CffPaQ+h59eUfroh23ux1DkL
 MTpT4/X8u6vA8XkIbHdpWLAUCoP2m50YmEL+gnHUMcvaUysmaZLS0FV
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
Jean-Baptiste Maneyrol (2):
      iio: imu: inv_icm42600: add WoM support
      iio: imu: inv_icm42600: add wakeup functionality for Wake-on-Motion

 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |  56 +++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 292 ++++++++++++++++++++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  97 ++++++-
 4 files changed, 433 insertions(+), 14 deletions(-)
---
base-commit: 4c6073fec2fee4827fa0dd8a4ab4e6f7bbc05ee6
change-id: 20250220-losd-3-inv-icm42600-add-wom-support-0620fef9db23

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



