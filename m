Return-Path: <linux-iio+bounces-22198-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB759B18F6B
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 18:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBBC189D44C
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 16:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067BF244667;
	Sat,  2 Aug 2025 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6upbNZJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB04522B8B0
	for <linux-iio@vger.kernel.org>; Sat,  2 Aug 2025 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754153098; cv=none; b=l5S/Tm/Kr/i7+TIjNF0uF2STJPrK7QyPnmW1mGvHAAmRMOILehyJfKWKImvyPDGnAtYXbuIOtZSk1a/6FK36wqJB9WeXxsrCieFrVJrNjLpBes5yRy6Ux1jTARJjN71KQsZnLHjpVYh5QPH/AZR1mRuVzyqFdWxgzbIaaY9JCIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754153098; c=relaxed/simple;
	bh=jRIJVfl+gtVrSAvnnwcSYN6fnOzhSObIrEiiWZ7vAGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=paVF4KM0anwxHFFfSX7Cp2Vbi+VQ086l6T0Xj0Yoytw/9YEXbUA8rMMBHr096np9+7CO142HC3/vK0oxTh5AVgmCIpCFxUqH6UIvGcHhy91sG/mHOlLjL6vUyvnfgiTRUd9P5ZS+4sIRPR21bAjKQR3/54dO5YF5KI6cMjCZdDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6upbNZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD72C4CEEF;
	Sat,  2 Aug 2025 16:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754153098;
	bh=jRIJVfl+gtVrSAvnnwcSYN6fnOzhSObIrEiiWZ7vAGU=;
	h=From:To:Cc:Subject:Date:From;
	b=Q6upbNZJ+v2l5oHnTIyrx7l6pXrNi+Fdk1FMNuYwUKrF+x1m4nuhQ2W2K7TBAVrrW
	 yb162yAj6UDBB8CxhxJZrOoNzRFbKwuOGJHHhAA9wZeFlqXGT1KWPwB9dVpR4BvwJD
	 +mrpu+mH46Avrz3XouUdeTUvFYUeSGhYqBPXRbql9JvEoStuieQcyI2cUamHkUsYKR
	 d/wU1FK4tSWBDBZizfn3tSI0caI8ow0UVogzkOFAYFRgETwo5xy7A4dd9tu1FpNjXP
	 0m8CKFpkgR1zaaci0qv+nnO8ZK1vfcEDst8K7HIMUmzuYHRfkNTJ1Jmfifyc79mpqT
	 DKJfYaAuP/bbA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	Astrid Rost <astrid.rost@axis.com>,
	=?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Christian Eggers <ChristianEggersceggers@arri.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/16] IIO: Enable runtime checks on buffers size and related.
Date: Sat,  2 Aug 2025 17:44:20 +0100
Message-ID: <20250802164436.515988-1-jic23@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Main aim here is to switch almost all of the light drivers over to
iio_push_to_buffers_with_ts() to provide runtime checking that we aren't
copying from beyond the provided buffers.

A couple of bugs showed up whilst doing these conversions that should be
back ported (patches 1 and 2).

Various other cases benefit from conversion from arrays to structures
and putting the temporary storage on the stack. Given these cases are
a little more complex, they are done as one or more patch per driver.

The cases that were just a simple change of function call from
iio_push_to_buffers_with_timestamp() are grouped together in the
final patch as not much to say about them and if we do a patch per
driver this and related sets will be unnecessarily long!

If people would prefer I split that up that would be fine.

Jonathan


Jonathan Cameron (16):
  iio: light: as73211: Ensure buffer holes are zeroed
  iio: light: vcnl4035: Fix endianness vs data placement in buffer
    issue.
  iio: light: as73211: Use iio_push_to_buffers_with_ts() to allow source
    size runtime check
  iio: light: vcnl4035: Use a structure to make buffer arrangement
    explicit.
  iio: light: vcnl4035: Use iio_push_to_buffers_with_ts() to allow
    runtime source buffer size check.
  iio: light: acpi-als: Use a structure for layout of data to push to
    buffer.
  iio: light: acpi-als: Use iio_push_to_buffers_with_ts() to allow
    runtime source size check
  iio: light: adjd_s311: Use iio_push_to_buffers_with_ts() to allow
    source size runtime check
  iio: light: isl29125: Use iio_push_to_buffers_with_ts() to allow
    source size runtime check
  iio: light: max44000: Use iio_push_to_buffers_with_ts() to allow
    source size runtime check
  iio: light: st_uvis25: Use iio_push_to_buffers_with_ts() to allow
    source size runtime check
  iio: light: tcs3414: Use iio_push_to_buffers_with_ts() to allow source
    size runtime check
  iio: light: tcs3472: Use iio_push_to_buffers_with_ts() to allow source
    size runtime check
  iio: light: vcnl4000: Use a structure to make buffer arrangement
    explicit.
  iio: light: vl6180: Use iio_push_to_buffers_with_ts() to allow source
    size runtime check
  iio: light: Simple conversions to iio_push_to_buffers_with_ts()

 drivers/iio/light/acpi-als.c       | 19 ++++++-------------
 drivers/iio/light/adjd_s311.c      | 12 ++++++------
 drivers/iio/light/as73211.c        |  5 +++--
 drivers/iio/light/bh1745.c         |  4 ++--
 drivers/iio/light/hid-sensor-als.c |  5 +++--
 drivers/iio/light/isl29125.c       | 14 +++++++-------
 drivers/iio/light/ltr501.c         |  4 ++--
 drivers/iio/light/max44000.c       | 18 +++++++++---------
 drivers/iio/light/opt4060.c        |  2 +-
 drivers/iio/light/rohm-bu27034.c   |  3 ++-
 drivers/iio/light/rpr0521.c        |  4 ++--
 drivers/iio/light/si1145.c         |  5 +++--
 drivers/iio/light/st_uvis25.h      |  5 -----
 drivers/iio/light/st_uvis25_core.c | 12 +++++++++---
 drivers/iio/light/tcs3414.c        | 15 ++++++++-------
 drivers/iio/light/tcs3472.c        | 14 +++++++-------
 drivers/iio/light/vcnl4000.c       | 11 +++++++----
 drivers/iio/light/vcnl4035.c       | 13 +++++++++----
 drivers/iio/light/veml6030.c       |  2 +-
 drivers/iio/light/vl6180.c         | 14 +++++++-------
 20 files changed, 94 insertions(+), 87 deletions(-)

-- 
2.50.1


