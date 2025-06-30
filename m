Return-Path: <linux-iio+bounces-21167-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 149EEAEE7BB
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 21:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0739F3B8BE3
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 19:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FBB2E62A8;
	Mon, 30 Jun 2025 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ebe9KAyG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCF021B8F8;
	Mon, 30 Jun 2025 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751312853; cv=none; b=eT9qADX9zUwLU2VtNRzSuYKkB5oH0QR0etf/6Z5AaJSdIHLFAulgoXtCmypIfWg8nCyXNlZnesPRWRA6TH2Z1goG720LGkPQHV+RFIQhfBiFZn1XuFXQ6wdA+zefVK4uaO+qrRPoOHYYKTub0nUeQ96Lh+soW3P7R7hE6g532f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751312853; c=relaxed/simple;
	bh=w0lZvF9KxA/TNRZul4tH4NkltW+6KAYH4QkTFfYS1Gk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=onkJeO+2Ht8gGil/TeH4FrdxZhusvJKbf+ensHIykL9PH4g2TgUb46oMZ1VaId2TupV2rypYBvFfqYc9S4k7aI7cq0IS/gwNiUVXYsMjAA5ROLGYQd/osJTZi2DC3j/DK8BW6IysFZexIJtaMQuPfJ1Oo3Rbb0RgoS66+osuWSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ebe9KAyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 314CFC4CEE3;
	Mon, 30 Jun 2025 19:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751312853;
	bh=w0lZvF9KxA/TNRZul4tH4NkltW+6KAYH4QkTFfYS1Gk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Ebe9KAyG3MZwWutWxpcd2G8wgXXz83ygVQadDtJtkdfDC2x+I2jG3F5+ZcsdieRuV
	 ljpGorNyAva0TU7+fqG0d7LRymAik7Q1tg/GhNAbu5rY6EOaNc+5ziDbF/SCzQfFVA
	 rJ9YCyWoxjuPkkNQHtGFM6ZWiuoWj/Kaltn19e80AmqEkBvGB5A7hzE5+rKbxfXxIp
	 TtFkIzgyEfXp9b2RbHjCEXGTGR+n+oscuM0PJ7AWlkN8JRpdSEvJc7LehKp6bT1ADW
	 3gojqMXICzpCcaMVgzfkvshL2uThZzGxjDZGMr+XsaILWMKL70mTbAOgT25Byo4FLH
	 S/5iVSVkadkIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA83C83033;
	Mon, 30 Jun 2025 19:47:33 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Subject: [PATCH v6 0/3] Add support for WoM (Wake-on-Motion) feature
Date: Mon, 30 Jun 2025 21:47:28 +0200
Message-Id: <20250630-losd-3-inv-icm42600-add-wom-support-v6-0-5bb0c84800d9@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANHpYmgC/5XOsVLEIBDG8Ve5oXadZYEkWPkejkUI4DGakIGIO
 jd5d8k1l7OK5X+L37cXll0KLrOn04UlV0IOcarRPJzYcO6nNwfB1maEpJAI4SNmCwLCVCAMo6Q
 GEXpr4SuOkD/nOaYFsCH0zmtrSLAqzcn58H1deXmtfQ55iennOlr4dv2fXzggaKNF63XXaCWfF
 /v+OMSRbXqhmyi5OiZSFa3T0nqjybTuXhR7sTsmiiq2Pe+w90jG/xHlTWy4OCbKTXTKKyUJufH
 3otqJdFBUVZRGGCEcUrf/cV3XXxxezcYcAgAA
X-Change-ID: 20250220-losd-3-inv-icm42600-add-wom-support-0620fef9db23
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751312852; l=2616;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=w0lZvF9KxA/TNRZul4tH4NkltW+6KAYH4QkTFfYS1Gk=;
 b=JX/V06k2AbCTxA6BAueIhaMhC8Ww/VSXusdB7hfdFQswBlUQUFAh3pqL2fyO+8L2r8+YknZQ7
 Z8r02Itce1fAXRoEpNOEePePf+dKPZlnAwURlsrPdMb1LJ3rF5Jhl2s
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
Changes in v6:
- Rework scoped_guard() for not using break
- Reword move DMA buffers initial patch to add better explanations
- Link to v5: https://lore.kernel.org/r/20250623-losd-3-inv-icm42600-add-wom-support-v5-0-4b3b33e028fe@tdk.com

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
      iio: imu: inv_icm42600: reorganize DMA aligned buffers in structure
      iio: imu: inv_icm42600: add WoM support
      iio: imu: inv_icm42600: add wakeup functionality for Wake-on-Motion

 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |  56 +++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 329 ++++++++++++++++++++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  97 +++++-
 4 files changed, 470 insertions(+), 14 deletions(-)
---
base-commit: 42498420746a4db923f03d048a0ebc9bd2371f56
change-id: 20250220-losd-3-inv-icm42600-add-wom-support-0620fef9db23

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



