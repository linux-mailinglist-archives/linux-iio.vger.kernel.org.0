Return-Path: <linux-iio+bounces-1020-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F9881613D
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 18:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BACA1F21431
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 17:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896AA4642B;
	Sun, 17 Dec 2023 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImsZgoQ4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C0A1DFD8
	for <linux-iio@vger.kernel.org>; Sun, 17 Dec 2023 17:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C754C433C7;
	Sun, 17 Dec 2023 17:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702834566;
	bh=wfJJHB7Of9B/1EFXwXkuQS/KTK0P7pUkiV9KlWOEM5w=;
	h=From:To:Cc:Subject:Date:From;
	b=ImsZgoQ4rWRF0aWzaQqbxWdFygF+GmJbbulxuGLVuvgp1FMPFyVv/QthJ0gjMyagJ
	 WW2gVXoSVITcfyCEJhmSxxwVfSvZzRRUL77FNGpwMSr3wrk7v5Ip1Rto9EJAXuybCh
	 V1T0QYh/qbjEupXkEFZmsqkrmm14J2Gx2yiub7X7OozIr7CxMxHQT2djIXTuy0b0MT
	 9p/GAxKs1J3ITGiNRYMmRlEF95aXoGnN2d2H8Y9M8dqu+4RUbGWekXrIqKYHu+xow/
	 g2kwSFswZiRsWSy54KJ31DuSkUXzuzV8DkdL22RzHE4oOIl1c8GpdyTbQjha3dJVEh
	 bZDLxGIud3vew==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH V2 00/10] IIO: Use the new cleanup.h magic
Date: Sun, 17 Dec 2023 17:35:38 +0000
Message-ID: <20231217173548.112701-1-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A lot of the advantages of the automated cleanup added for locks and similar
are not that useful in IIO unless we also deal with the
iio_device_claim_direct_mode() / iio_device_release_direct_mode()
calls that prevent IIO device drivers from transitioning into buffered
mode whilst calls are in flight + prevent sysfs reads and writes from
interfering with buffered capture if it is enabled.

Relies on Peter Zilstra's conditional cleanup handling which is queued
up for the merge window in the tip tree. This series is based on
a merge of tip/master into iio/togreg.

All comments welcome. If this looks positive I'll make use of it in a
lot more drivers, but hopefully these give an idea of how it will work.

The need to always handle what happens after
iio_device_claim_direct_scoped() {} is a little irritating but the
compiler will warn if you don't do it and it's not obvious how to
let the compiler know the magic loop (hidden in the cleanup.h macros)
always runs once.  Example:

	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
		return 42;
	}
	/* Can't actually get here, but compiler moans if no return val */
	return -EINVAL;
}
Assuming no show stoppers, I'll post a non RFC version next cycle and
if I get sufficiently bored over the holidays it may include a few more
users.

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

 drivers/iio/accel/adxl367.c          | 261 +++++++++++----------------
 drivers/iio/adc/ad4130.c             | 128 ++++++-------
 drivers/iio/adc/ad7091r-base.c       |  25 +--
 drivers/iio/adc/max1363.c            | 149 +++++++--------
 drivers/iio/dummy/iio_simple_dummy.c | 189 ++++++++++---------
 drivers/iio/imu/bmi323/bmi323_core.c |  53 ++----
 drivers/iio/industrialio-core.c      |   4 +
 drivers/iio/proximity/sx9310.c       | 114 ++++--------
 drivers/iio/proximity/sx9324.c       | 107 ++++-------
 drivers/iio/proximity/sx9360.c       | 111 ++++--------
 include/linux/iio/iio.h              |  22 +++
 11 files changed, 481 insertions(+), 682 deletions(-)

-- 
2.43.0


