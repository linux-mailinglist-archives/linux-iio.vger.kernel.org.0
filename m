Return-Path: <linux-iio+bounces-14994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339F0A27C53
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4989A7A1F2C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257221C07C3;
	Tue,  4 Feb 2025 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UY/ikGex"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56C925A625
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699383; cv=none; b=Q+qikgbWz9sMHFm2INdP0hIkvghGwZkSmDJd8hTzW0zSiIAVodHr+ePOicHR2H5MgZB+C1HRzkLkYv3UMVO2WMdfyJruWuzR7eXQo2Ev4OWvFm7o4qdPqfkPuQ8CmD6mJa0z8ghir4VkNo7SEWOtY+2/PIl0D0f16z1qZXlF6zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699383; c=relaxed/simple;
	bh=yDf264xbV0g7+W/Zglob8hrhzpjbvIS0ROcn3kxdErs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=owP3YOaO0uFQcbn+tzYYohaMZvO7CgaVfQXoYaxdQULWMdbz/uBAZtTvovvuotPrFIr+gFexriNSlsZfbiYX2BQPOMfVbiyN8EWkuTVBz3HlPEQUmtlxVvbqdqZcIrForiDm49cgMI0LizNC10e+C3nqreLqWzlURrmFh11nBFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UY/ikGex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F23AC4CEDF;
	Tue,  4 Feb 2025 20:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699383;
	bh=yDf264xbV0g7+W/Zglob8hrhzpjbvIS0ROcn3kxdErs=;
	h=From:To:Cc:Subject:Date:From;
	b=UY/ikGexGJzaZFzz77VDYmSNqTHnnCIBwWkuwhY9pIvdHxj84dza0odEACZfSQAKQ
	 Tat8KYWoSvsMmZ/R0hyzgaNiupbxX1sApib+Zq5We2gX2EgC75VlAiNp4eFKdSYlAr
	 GgQ5993avuQp0aeva/fJLBY/+mK7kPIWpfUY06ZaagLu4XDv4ihDrJhhpQxOUW/QL0
	 fnzVSOyWaJai7NEmUyKm3GvOpgC2DtoUaYkYhjRUiBEKFeNA98qkMTIRt3uiEAXv1V
	 oqHxp/PFm9PjogB7IFiFdZ9goBLRUNZU9JqODMSReFe68nJPMaR9wXhGclNGvAb9Av
	 eLewfKRGI5k3Q==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Guillaume Stols <gstols@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/27] iio: improve handling of direct mode claim and release
Date: Tue,  4 Feb 2025 20:02:22 +0000
Message-ID: <20250204200250.636721-1-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This is the first of perhaps 4 related series, broken up mostly to keep
them bite sized enough for people to review.

Difference from RFC.
- Some refactoring etc
- Patch to drop the _scoped infrastructure.

Effectively two linked things in this series:

1) Ripping out iio_device_claim_direct_scoped()
2) Enabling use of sparse to check the claim is always released.

The iio_device_claim_direct_scoped() was an interesting experiment built
on conditional scoped guards, but it has been the source of a range of
esoteric build warnings and is awkward to use.

Several attempts have been made to improve the related handling but in the
end it looks like this is just too hard to use and too prone to tripping up
the compiler.  So time to rip it out.

Most recent discussion was around if_not_cond_guard()
https://lore.kernel.org/all/CAHk-=wi8C2yZF_y_T180-v+dSZAhps5QghS_2tKfn-+xAghYPQ@mail.gmail.com/
which looked like a promising avenue but ran into problems and
got reverted.

A large part of the advantage of scoped cleanup is that it removes the
possibility of failing to call the 'destructor' which here released the
claim on direct mode (implementation detail is that corresponds to
unlocking a mutex).  It's a shame to lose that but we do have other
infrastructure to prevent such common mistakes, lock markings + sparse.
Hence I thought we could simply enable those for existing
iio_device_claim_direct_mode() / iio_device_release_direct_mode() via
similar magic to that used for __cond_lock() that is rename existing
iio_device_claim_direct_mode to do_iio_device_claim_direct_mode and

#define iio_device_claim_direct_mode(iio_dev) \
	do_iio_device_claim_direct_mode(iio_dev) ? : ({ __acquire(iio_dev); 0; })

Unfortunatley that gives a few false positives. Seems sparse is tripping
up on this magic in some more complex switch statements.
Instead this series makes the iio specific infrastructure look more like
a normal conditional lock.  Given that a failure to claim direect mode only
ever resulted in -EBUSY, we can make it a boolean return instead.
Note the sense is switched so true now means successfully claimed the mode.

Ideally we'd use the sparse markings __cond_acquires() and __releases()
but appropriate support has not yet landed in upstream sparse. It
can be found in this thread.
https://lore.kernel.org/all/CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com/

As David pointed out on the RFC the reason this series worked at all
was because we had __acquire() in the static inline wrapper. Given that
works, it will do for now. Added some docs to stop us accidentally hiding
that wrapper in a .c file and breaking everything.

These new wrappers are called iio_device_claim_direct() and
iio_device_claim_release().  Naming is based on no one seeming bothered
that we dropped mode from the scoped case. Long term plan would be to
drop the _direct_mode() calls at the end of all these series.
That will cause some rebase complexity for drivers that race with this.
I'll handle those whilst merging.

In this first set we have a false positive that showed up with one of my
earlier attempts + dropping of all uses and the infrastructure for
iio_device_claim_direct_scoped().

I've tried to +CC people on individual patches, but in some cases there
is no active maintainer.  Hence if you are looking at all, please take
a look at a few of them!

Jonathan


Jonathan Cameron (27):
  iio: core: Rework claim and release of direct mode to work with
    sparse.
  iio: chemical: scd30: Use guard(mutex) to allow early returns
  iio: chemical: scd30: Switch to sparse friendly claim/release_direct()
  iio: temperature: tmp006: Stop using iio_device_claim_direct_scoped()
  iio: proximity: sx9310: Stop using iio_device_claim_direct_scoped()
  iio: proximity: sx9324: Stop using iio_device_claim_direct_scoped()
  iio: proximity: sx9360: Stop using iio_device_claim_direct_scoped()
  iio: accel: adxl367: Stop using iio_device_claim_direct_scoped()
  iio: adc: ad4000: Stop using iio_device_claim_direct_scoped()
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
  iio: Drop iio_device_claim_direct_scoped() and related infrastructure

 drivers/iio/accel/adxl367.c          | 194 ++++++++++++----------
 drivers/iio/adc/ad4000.c             |  60 ++++---
 drivers/iio/adc/ad4130.c             |  18 +-
 drivers/iio/adc/ad4695.c             | 240 +++++++++++++++------------
 drivers/iio/adc/ad7606.c             |  14 +-
 drivers/iio/adc/ad7625.c             |   9 +-
 drivers/iio/adc/ad7779.c             | 101 ++++++-----
 drivers/iio/adc/ad9467.c             |  23 ++-
 drivers/iio/adc/max1363.c            | 165 +++++++++---------
 drivers/iio/adc/rtq6056.c            |  46 +++--
 drivers/iio/adc/ti-adc161s626.c      |  14 +-
 drivers/iio/adc/ti-ads1119.c         |  17 +-
 drivers/iio/addac/ad74413r.c         |  14 +-
 drivers/iio/chemical/ens160_core.c   |  32 ++--
 drivers/iio/chemical/scd30_core.c    |  70 ++++----
 drivers/iio/dac/ad3552r-hs.c         |  15 +-
 drivers/iio/dac/ad8460.c             |  18 +-
 drivers/iio/dummy/iio_simple_dummy.c | 119 +++++++------
 drivers/iio/imu/bmi323/bmi323_core.c |  44 ++---
 drivers/iio/light/bh1745.c           |  18 +-
 drivers/iio/proximity/sx9310.c       |  19 ++-
 drivers/iio/proximity/sx9324.c       |  19 ++-
 drivers/iio/proximity/sx9360.c       |  19 ++-
 drivers/iio/temperature/tmp006.c     |  33 ++--
 include/linux/iio/iio.h              |  40 +++--
 25 files changed, 776 insertions(+), 585 deletions(-)

-- 
2.48.1


