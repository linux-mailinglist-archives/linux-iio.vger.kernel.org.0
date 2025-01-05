Return-Path: <linux-iio+bounces-13899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB15A01AD5
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A293A2EE0
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F6715625A;
	Sun,  5 Jan 2025 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rm314fvC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CC28F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736097990; cv=none; b=nlWiHDfEqS8YqBbXxPS7SAX4vNBzP/7ZuN5wAuvkHBjstr5Ai7YbC321RbtPRUtlAhmzDfj4jAuREseA4WKvRAkAvzrnK7TkVGyDjbOMEgvDPolGJwdMckdJy8oM+jVm/zUIeyvM8ZnVi0w3tC2heA90t0uubRa8GPh3BAMq6R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736097990; c=relaxed/simple;
	bh=FDcPBaFhPvqjGwmR6X45JYimx4gLDmYLloYYBJHg0+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oQxrCsPRkCRqcTnN7zMDHJMtEYNYbv8U3aYVeJOrUU+E6sLkZ9/2lNa3fQQmYbvOQWLpCZzJovlv0QxufNtB3N+Z6shjebcz/o80Pz70Y789ynax29D1xaIa0WKZqBYY3UlAos/b/B9I0ZVjgDwCSR3y5K/74RUKCqvzab30g+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rm314fvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA4EC4CED0;
	Sun,  5 Jan 2025 17:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736097987;
	bh=FDcPBaFhPvqjGwmR6X45JYimx4gLDmYLloYYBJHg0+8=;
	h=From:To:Cc:Subject:Date:From;
	b=rm314fvCV5TqQv7hQEYvzrS9MOAv1uxjvEXF6pljggeZlSP992xoTCiWYac+PAwtR
	 uFAN/s9xkfFo4GyQP8xJqvnYnSNo1fh7hny+YbH40HmZnMh8K9US/PywnjwGzpwuA+
	 EAOuDRpmKRatu/1vNAaJRYiLE94NtyuCU0VmhABLD6UApc4NJBiwHAyA48HOsoIqAa
	 3PB6/794BKyYUcR1J7RmWNjopZWIpKmSFWBTLgfHo8yFuVVpkYAj50HD6DVH9TFZIE
	 iufPCOSTnnC9a6SV6Ww9ByQzYvw5rinOCBfNHqDXKBLPFGJmVt/kjGxU4oIVrSDmkr
	 AsfFZrS2Xc9pg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 00/27] iio: improve handling of direct mode claim and release
Date: Sun,  5 Jan 2025 17:25:45 +0000
Message-ID: <20250105172613.1204781-1-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Note I haven't attempted to CC relevant people for specific drivers.
I'll do that for a non RFC version if we move forwards.

Effectively two linked things in this series:

1) Ripping out iio_device_claim_direct_scoped()
2) Enabling use of sparse to check the claim is always released.

The iio_device_claim_direct_scoped() was an interesting experiment
built on conditional scoped guards, but it has been the source of
a range of esoteric build warnings and is awkward to use.

Several attempts have been made to improve the related handling but
in the end it looks like this is just too hard to use and too prone
to tripping up the compiler.  So time to rip it out.
Most recent discussion was around if_not_cond_guard()
https://lore.kernel.org/all/CAHk-=wi8C2yZF_y_T180-v+dSZAhps5QghS_2tKfn-+xAghYPQ@mail.gmail.com/
which looked like a promising avenue but ran into problems and
got reverted.

A large part of the advantage of scoped cleanup is that it
removes the possibility of failing to call the 'destructor' which here
released the claim on direct mode (implementation detail is that
corresponds to unlocking a mutex).  It's a shame to lose that but
we do have other infrastructure to prevent such common mistakes,
lock markings + sparse.  Hence I thought we could simply enable
those for existing iio_device_claim_direct_mode() /
iio_device_release_direct_mode() via similar magic to that used
for __cond_lock() that is rename existing iio_device_claim_direct_mode
to do_iio_device_claim_direct_mode and

#define iio_device_cliam_direct_mode(iio_dev) \
	do_iio_device_claim_direct_mode(iio_dev) ? : ({ __acquire(iio_dev); 0; })

Unfortunatley that gives a few false positives. Seems sparse is tripping
up on this magic in some more complex switch statements.

Rather than figure out how to fix sparse, this patch set currently proposes
some new handlers that can use __cond_acquires() and __releases() markings.

iio_device_claim_direct() and iio_device_claim_release().
Key is that iio_device_claim_direct() returns a boolean (true for the
claim succeeding, false for it not).  Naming is based on no
one seeming bothered that we dropped mode from the scoped case.
Long term plan would be to drop the _direct_mode() calls.

To test this out I've included converting some of the sources of
false positives with the first approach above and all but 1 of the
users of iio_device_claim_direct_scoped() (That 1 is being removed
in a another series). It's possible there will be false positives
when converting all the other drivers but I can't see why similar
would not have been seen for the trylock equivalent markings.

I'm not sure which way to go here:

1) Transition to this lock like scheme.  Advantage is that this code
   looks more 'standard' when it comes to new checks etc in future.
2) Figure out how to avoid the false positives from sparse
(see patch 1 for a little more information on that)
It is easy to surpress them but that's not a long term solution as
false positives will continue to annoy us from time to time.

Luc, if you have any suggestions on that it would be most welcome.
I don't have the patch to hand any more but I can easilly recreate it
to test out any theories on the reasons for the false positives.

Hence the RFC.

Note that replacing of _scoped() calls takes a mixture of different paths
and in some cases involves moving locks / direct_claims up or down
the call stack, and in others adding aditional utility functions with
the claim done around calls of those.  Which makes sense depends on the
complexity of the particular code being called.

Jonathan



Jonathan Cameron (27):
  iio: core: Rework claim and release of direct mode to work with
    sparse.
  iio: chemical: scd30: Switch to sparse friendly claim/release_direct()
  iio: temperature: tmp006: Stop using iio_device_claim_direct_scoped()
  iio: imu: st_lsm6dsx: Switch to sparse friendly claim/release_direct()
  iio: proximity: sx9310: Stop using iio_device_claim_direct_scoped()
  iio: proximity: sx9324: Stop using iio_device_claim_direct_scoped()
  iio: proximity: sx9360: Stop using iio_device_claim_direct_scoped()
  iio: accel: adxl367: Stop using iio_device_claim_direct_scoped()
  iio: adc: ad4000: Stop using iio_device_claim_direct_scoped()
  iio: adc: ad4130: Stop using iio_device_claim_direct_scoped()
  iio: adc: ad4130: Stop using iio_device_claim_direct_scoped()
  iio: adc: ad4695: Stop using iio_device_claim_direct_scoped()
  iio: adc: ad7606: Stop using iio_device_claim_direct_scoped()
  iio: adc: ad7625: Stop using iio_device_claim_direct_scoped()
  iio: adc: ad7779: Stop using iio_device_claim_direct_scoped()
  iio: adc: ad9467: Stop using iio_device_claim_direct_scoped()
  iio: adc: max1363: Stop using iio_device_claim_direct_scoped()
  iio: adc: rtq6056: Stop using iio_device_claim_direct_scoped()
  iio: adc: ti-adc161s626: Stop using iio_device_claim_direct_scoped()
  iio: adc: ti-ads1119: Stop using iio_device_claim_direct_scoped()
  iio: addac: ad74413r: Stop using iio_device_claim_direct_scoped()
  iio: chemical: ens160: Stop using iio_device_claim_direct_scoped()
  iio: dac: ad3552r-hs: Stop using iio_device_claim_direct_scoped()
  iio: dac: ad8460: Stop using iio_device_claim_direct_scoped()
  iio: dummy: Stop using iio_device_claim_direct_scoped()
  iio: imu: bmi323: Stop using iio_device_claim_direct_scoped()
  iio: light: bh1745: Stop using iio_device_claim_direct_scoped()

 drivers/iio/accel/adxl367.c                  | 194 ++++++++-------
 drivers/iio/adc/ad4000.c                     |  61 +++--
 drivers/iio/adc/ad4130.c                     |  18 +-
 drivers/iio/adc/ad4695.c                     | 240 ++++++++++---------
 drivers/iio/adc/ad7606.c                     |  14 +-
 drivers/iio/adc/ad7625.c                     |   9 +-
 drivers/iio/adc/ad7779.c                     | 103 ++++----
 drivers/iio/adc/ad9467.c                     |  23 +-
 drivers/iio/adc/max1363.c                    | 165 +++++++------
 drivers/iio/adc/rtq6056.c                    |  39 +--
 drivers/iio/adc/ti-adc161s626.c              |  14 +-
 drivers/iio/adc/ti-ads1119.c                 |  17 +-
 drivers/iio/addac/ad74413r.c                 |  14 +-
 drivers/iio/chemical/ens160_core.c           |  32 ++-
 drivers/iio/chemical/scd30_core.c            |   9 +-
 drivers/iio/dac/ad3552r-hs.c                 |  15 +-
 drivers/iio/dac/ad8460.c                     |  18 +-
 drivers/iio/dummy/iio_simple_dummy.c         | 119 +++++----
 drivers/iio/imu/bmi323/bmi323_core.c         |  51 ++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c |  14 +-
 drivers/iio/light/bh1745.c                   |  18 +-
 drivers/iio/proximity/sx9310.c               |  19 +-
 drivers/iio/proximity/sx9324.c               |  19 +-
 drivers/iio/proximity/sx9360.c               |  19 +-
 drivers/iio/temperature/tmp006.c             |  33 +--
 include/linux/iio/iio.h                      |  22 ++
 26 files changed, 765 insertions(+), 534 deletions(-)

-- 
2.47.1


