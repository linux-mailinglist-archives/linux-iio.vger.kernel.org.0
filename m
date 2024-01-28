Return-Path: <linux-iio+bounces-1980-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D7783F604
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 16:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7FD31F21F70
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 15:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284271E50B;
	Sun, 28 Jan 2024 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L60SGwR2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E032375A
	for <linux-iio@vger.kernel.org>; Sun, 28 Jan 2024 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706454387; cv=none; b=nDeeX1VVOArV+Uxlb7wy5mtz/SU7FwIA3mu+i5lBHc5oIhnQFCJIVewWs7sHAIkl2t1wC6tir7pbCQG8pCLP+iWWvxfRh8ESzMAtd0NHIjh55ZH4lHYvxWOASNMb1MTnfP8/cJbhztbqw1dW6laeNEr8b/jS4XpmciS2z/1hSUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706454387; c=relaxed/simple;
	bh=kDzbD8/dMnya+yguOFsfYg0G0yrh4r3ZqbHAuPciH4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VpA59OAw2KxHa2B6f1hjisW+4exj6NAdmkvZkD009jrXrw9bsYtvQLt+CmU4DU1Qx35WDNEOQSjN2KEuQd7XUdLJvcRJOjJttFw9A2KXUfOA+7z8quYMbFh0Rykh588ORH7gSNXqigb757sNWr1AUQndMODTRb4JaOUYIhZAPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L60SGwR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB49C433C7;
	Sun, 28 Jan 2024 15:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706454387;
	bh=kDzbD8/dMnya+yguOFsfYg0G0yrh4r3ZqbHAuPciH4c=;
	h=From:To:Cc:Subject:Date:From;
	b=L60SGwR2oYsZwPaRnffRwmI79YStK1hCP4Ro0p9PIYpUyxEV1jD5Ggpn1DbfoqZ2T
	 j5nDFD1wAMgno8dly+EO/e/ZZmAOZ6uH4whbjEWOb/3hrna7h5qQYLbtl7sIYqhKzW
	 /BzmhwTW9fOXdNVxsH2Nr4lW/t4kHJyYnVHH1dDZqGByZNBldwjKyPzrUWI4RlakAt
	 LTxnzluVyEGzZ3Pdnrp7KeWS/U58j3X+BNG9VqwCxnkAJDcMUb1PqEA0C7aU90Onfj
	 RWWCTmxVB915HVBvaDGziFr8WlpMC1yiSwRhRJpkULy12LojtOMINk3ItwlISsB9Va
	 uOuxUzf2MqOvw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/10] IIO: Use the new cleanup.h magic
Date: Sun, 28 Jan 2024 15:05:27 +0000
Message-ID: <20240128150537.44592-1-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The prerequisites are now in place upstream, so this series can now
introduce the infrastructure and apply it to a few drivers.

Changes since RFC v2: Thanks to David Lechner for review
 - Use unreachable() instead of misleading returns in paths we can't reach.
 - Various minor tweaks and local variable scope reduction.
 
A lot of the advantages of the automated cleanup added for locks and similar
are not that useful in IIO unless we also deal with the
iio_device_claim_direct_mode() / iio_device_release_direct_mode()
calls that prevent IIO device drivers from transitioning into buffered
mode whilst calls are in flight + prevent sysfs reads and writes from
interfering with buffered capture if it is enabled.

This can now be neatly done using new scoped_cond_guard() to elegantly
return if the attempt to claim direct mode fails.

The need to always handle what happens after
iio_device_claim_direct_scoped() {} is a little irritating but the
compiler will warn if you don't do it and it's not obvious how to
let the compiler know the magic loop (hidden in the cleanup.h macros)
always runs once.  Example:

	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
		return 42;
	}
	/* Can't get here, but compiler about no return val without this */
	unreachable();
}

Jonathan Cameron (10):
  iio: locking: introduce __cleanup() based direct mode claiming
    infrastructure
  iio: dummy: Use automatic lock and direct mode cleanup.
  iio: accel: adxl367: Use automated cleanup for locks and iio direct
    mode.
  iio: imu: bmi323: Use cleanup handling for
    iio_device_claim_direct_mode()
  iio: adc: max1363: Use automatic cleanup for locks and iio mode
    claiming.
  iio: proximity: sx9360: Use automated cleanup for locks and IIO mode
    claiming.
  iio: proximity: sx9324: Use automated cleanup for locks and IIO mode
    claiming.
  iio: proximity: sx9310: Use automated cleanup for locks and IIO mode
    claiming.
  iio: adc: ad4130: Use automatic cleanup of locks and direct mode.
  iio: adc: ad7091r-base: Use auto cleanup of locks.

 drivers/iio/accel/adxl367.c          | 297 +++++++++++----------------
 drivers/iio/adc/ad4130.c             | 131 +++++-------
 drivers/iio/adc/ad7091r-base.c       |  25 +--
 drivers/iio/adc/max1363.c            | 171 +++++++--------
 drivers/iio/dummy/iio_simple_dummy.c | 182 ++++++++--------
 drivers/iio/imu/bmi323/bmi323_core.c |  78 +++----
 drivers/iio/proximity/sx9310.c       | 114 ++++------
 drivers/iio/proximity/sx9324.c       | 109 ++++------
 drivers/iio/proximity/sx9360.c       | 115 ++++-------
 include/linux/iio/iio.h              |  25 +++
 10 files changed, 518 insertions(+), 729 deletions(-)

-- 
2.43.0


