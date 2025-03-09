Return-Path: <linux-iio+bounces-16606-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C201A585FA
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7466188BECC
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C6C1DE88C;
	Sun,  9 Mar 2025 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQcsAlJ3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6456D1DE4CA
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741540006; cv=none; b=QUIrx6nF/+15n48Gj9InzyWrq6Mg3GWg0ChZn7tboqjZ5r7HcUIwYCUwy4Lxq2U5awQgH9l80VIJupzWPM3qj9fmlb+R8oMrHDR9j/zAUgmSTrTryBes3vHXHSqhL+8ufPmuyXGTa3NOTOirY361zHw9F9SIc6k4GrxLrwrQHXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741540006; c=relaxed/simple;
	bh=eTnYGbbsH0t0cu5vikmTpukusfYWGyxdOWhUP7qs6FY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GvhXwiHwbA+hYx7OIGKY5iyP7YxXsSgx9koNhRUfnN+zWVQl8Zj4ElhEUyay2ZCkpug99ozn5KHOHpoJsztJ765M1gCXgSaQ8P9rhbsfmNkgOATUnR3KjVJa1UA+Wy4Wu1wjx+LNJXL2Uml9oDtSZYdhi4ekJnZkDnQ4zWBGH3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQcsAlJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C5DC4CEE3;
	Sun,  9 Mar 2025 17:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741540005;
	bh=eTnYGbbsH0t0cu5vikmTpukusfYWGyxdOWhUP7qs6FY=;
	h=From:To:Cc:Subject:Date:From;
	b=FQcsAlJ32AQ2SwG2DskUBlNqnM87tx0NP02+c4HCrWTcbU4vqnn7PUZ5jKNA1XO/X
	 n21TYtyV5uvKOm75w5ro3p4hU2as3qBC7WCNHgQv4CAd+Ov1NGd1nNzNx6iFswHs58
	 OuuqY0TFA29cQ7D6uJW124dKgn5AZU+OJnxWCFQz/wOUVOD9l9ZwEzh61Arc/Xv/rd
	 DXfqFIpojisjFEdYpA2YXtNPWSj6dGr5gYJ9a7QfMx83583OBhtN3ipkL8s/HGr1lP
	 D7S+KWP5pkR0CK2RJJ3hEeRtUKqeDyZDpwoYEYkDxXnyhqLzujF+0KPbK+/81FPXpd
	 qNohCRLD5kxRQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Astrid Rost <astrid.rost@axis.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/18] iio: light: Sparse friendly claim of direct mode
Date: Sun,  9 Mar 2025 17:06:15 +0000
Message-ID: <20250309170633.1347476-1-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Note that a number of the drivers touched in this series have no
obvious active maintainer, so it would be much appreciated if anyone
has time to take a look! It is a large series so feel free to review
any you have time to look at rather than feeling you need to look
at the whole thing!

This is effectively part 4 of what will probably be around 7 series
focused on moving from iio_device_claim/release_direct_mode() to
iio_device_claim/release_direct(). The new form is more consistent
with conditional locking semantics and sparse markings have been
added that let us detect miss-balance between claim and release.

More details can be found in the cover letter of the first series:
https://lore.kernel.org/all/20250209180624.701140-1-jic23@kernel.org/

This series focuses on the light sensor drivers.

Jonathan Cameron (18):
  iio: light: apds9306: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: light: gp2ap020a00f: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: light: isl29125: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: light: as73211: Use guard() and move mode switch into inner
    write_raw fucntion
  iio: light: as73211: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: light: ltr501: Factor out IIO_INFO_RAW leg of read_raw()
    callback.
  iio: light: ltr501: Factor out core of write_raw() where direct mode
    claim is held.
  iio: light: ltr501: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: light: opt4060: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: light: rohm-bu27034: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: light: rpr0521: Factor out handling of IIO_INFO_RAW and use
    guard()
  iio: light: rpr0521: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: light: si1145: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: light: st_uvis25: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: light: tcs3414: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: light: tcs3472: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: light: vcnl4000: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: light: vcnl4035: Switch to sparse friendly
    iio_device_claim/release_direct()

 drivers/iio/light/apds9306.c       |   7 +-
 drivers/iio/light/as73211.c        |  42 ++++----
 drivers/iio/light/gp2ap020a00f.c   |   7 +-
 drivers/iio/light/isl29125.c       |   7 +-
 drivers/iio/light/ltr501.c         | 164 +++++++++++++++--------------
 drivers/iio/light/opt4060.c        |   5 +-
 drivers/iio/light/rohm-bu27034.c   |  14 ++-
 drivers/iio/light/rpr0521.c        |  63 ++++++-----
 drivers/iio/light/si1145.c         |  25 ++---
 drivers/iio/light/st_uvis25_core.c |   7 +-
 drivers/iio/light/tcs3414.c        |   9 +-
 drivers/iio/light/tcs3472.c        |   9 +-
 drivers/iio/light/vcnl4000.c       |  78 +++++++-------
 drivers/iio/light/vcnl4035.c       |  42 +++++---
 14 files changed, 245 insertions(+), 234 deletions(-)

-- 
2.48.1


