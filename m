Return-Path: <linux-iio+bounces-18277-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5046BA93ACC
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 18:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA5C3BB6DD
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 16:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741F121A44D;
	Fri, 18 Apr 2025 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOWds5lT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE64142659;
	Fri, 18 Apr 2025 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744993152; cv=none; b=NqTpxJYKIyXy3DO5bpUGg7xYz92eO+ueaPoEYswHmwiJFZPOv3pP8+aD7BM+iCUTuOViU0IEs8Kznajps6+OZq7bb+60/mK/02CEo+yh7JxXS37Heqg3ikQjbgxSGLebQeyvMbxrMHNPJ+JINerTqPs4vISjFGSoWYapa1GDCvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744993152; c=relaxed/simple;
	bh=I9rqPEmih+WGjr4eCnBNMkrmqHo+NChbgbYmv45VSAg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cn7DtBnYyBfTQSy+BW2DnwjqgN+8pFQJn+17WvEPdYA7iSSCGeau7f2keG891JmGoAVd4k5q7fYnD9ZRx0L+2wzNXGKCY5hvkv3YW4B7LjkBwVYM58URj3cqa7RhtWrnGJ6s7CT9NH+m00OfJabooTXG8vCywkhDzOEEluFonB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOWds5lT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C157C4CEE2;
	Fri, 18 Apr 2025 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744993151;
	bh=I9rqPEmih+WGjr4eCnBNMkrmqHo+NChbgbYmv45VSAg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=MOWds5lTvvOmL4g4jDpH9FCWpCyvBRWel2v60kh/7U71kLxP72zNRU5100wIjk55l
	 oYKYSemWHDuwrJmv/ry0xmxGYbfAHlmnyhaS/AW1rlfTzdKP32ct8FP2Nd13AJd9+l
	 MlXuY/UXIyoMMVTId8RkaUhvrrF5fIoevca7/SAaQy13osySOY5tMCXD/nWr/m4IPu
	 iejHIzBpn/Pl6AGJoRd4UQwbNE3CpnTL7W+9Eu87eyrmBAjJ08h9t9vaU6kzVDrM7D
	 9sm43nd8rU6VaJXQeitkqoXPW6fJoFiXXLxXfuSWUevfHu1WXS35f/pC2FNPOPg5+u
	 kDJHwc6Im+rJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88232C369AB;
	Fri, 18 Apr 2025 16:19:11 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Subject: [PATCH v3 0/2] Add support for WoM (Wake-on-Motion) feature
Date: Fri, 18 Apr 2025 18:19:01 +0200
Message-Id: <20250418-losd-3-inv-icm42600-add-wom-support-v3-0-7a180af02bfe@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHV7AmgC/5XNsQ6CMBSF4Vcxnb2m3BawTr6HcQB6K41CSYtVQ
 3h3Cwurjv8ZvjOxQN5SYKfdxDxFG6zrU4j9jjVt1d8IrE7NkGPOETk8XNAgwPYRbNNJLDiHSmt
 4uQ7CcxicH4EXyA0ZpWsULEmDJ2Pf68vlmrq1YXT+s57GbFn/82MGHFStRGnUsVC5PI/6fmhcx
 xY94ibKLP9NxCRqUlKbWmFd0ibO8/wF2XyP9CYBAAA=
X-Change-ID: 20250220-losd-3-inv-icm42600-add-wom-support-0620fef9db23
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744993145; l=1697;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=I9rqPEmih+WGjr4eCnBNMkrmqHo+NChbgbYmv45VSAg=;
 b=GPV7ryHOqM2AW7JlcGoNgdjFCjP9uDm5KlQVMxRi2Rwd+w5C4E+i+zmbW1/w4Y48icXzoiA2O
 gtEEOcCI2sACA0LYHGV/Gm6+P9PtDhjiS1zA14vH97bKhXEXHkWTnzl
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
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 282 ++++++++++++++++++++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  97 ++++++-
 4 files changed, 423 insertions(+), 14 deletions(-)
---
base-commit: 3159d40a2ca0ae14e69e1cae8b12f04c933d0445
change-id: 20250220-losd-3-inv-icm42600-add-wom-support-0620fef9db23

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



