Return-Path: <linux-iio+bounces-11749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA9E9B8CAB
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 09:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0854C1F2353D
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 08:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDAF156222;
	Fri,  1 Nov 2024 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFOuU8Tx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AAE84A5E;
	Fri,  1 Nov 2024 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730448733; cv=none; b=rvUKcuT4YZDjrDY/kDlfEf5wALqocLLmfuv67A325+siceA0jgPSWLXhSiESTx5YXiQYaLME8E6UILpi+RUSbnxVTVgSdrhZuuJYIU1PJLHvnPrbRYzvlyAB71uUSWivhhh1znlqSzGZC11WLHkDUyuHpu8X2m6uU2TLEj+Cbsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730448733; c=relaxed/simple;
	bh=bUbgtulJXvaTqG+30eBuPI5L/qE8hBcgJKfjcd+lLBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fiTLVyiU36P7AMxA8Ai1V0ZIYvDRk3h6jmXTwviLuPtHXy1oLLhhz/xIIAuil4IuSJF973Xap9KKDZPY/NACDx36EU1GRzohAxxUOkz5h4av18uL//MEaTDLCGQGwv/ghbaXMoqPiWeDfMibKwXSmjynaS2X+yXlwqjgblt/6cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFOuU8Tx; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730448731; x=1761984731;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bUbgtulJXvaTqG+30eBuPI5L/qE8hBcgJKfjcd+lLBo=;
  b=DFOuU8TxVVuQMF2Evo7Zce/QMUH2yaZAoF/yw/5LmcuzjrlEm7tSesbD
   M9bPvJcfGrYHafpMQVJhgHvFeJK5fOR3/PUoqKa3F5YaaM9/D5icBKZv7
   iOCcoISdvmLvYjRKdJrZFzoZzOWnPONOmpDV6NRNVd0r08L2/oZ2UT7nJ
   r1GwtG2PnUTDliK9+tALZ6TBHr0ec7eCqTrJ002ms7Uq7BYGJBmELKr5O
   Ci1AxI2QkuuYQ+fGYSGf7yImaJOcL061B6SZ7frNX9nK1CsTNi9OdnVIx
   rMvSnZTBN0wRkpvRXolwzkg9CYyrHXtNwGgcUHq1N3w9buGi0BRkoMl4K
   Q==;
X-CSE-ConnectionGUID: Ul2gTcUERGiJqwt/cdVRbg==
X-CSE-MsgGUID: RBTOvom+QEC6vc4kbDs//A==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="55614553"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="55614553"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 01:12:11 -0700
X-CSE-ConnectionGUID: D2BvxdBEQUmd/EXO+T5+JA==
X-CSE-MsgGUID: KKJZM+hITnmtuGj8GvrxBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="106234619"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 01 Nov 2024 01:12:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E6F452AF; Fri, 01 Nov 2024 10:12:07 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 0/4] iio: initialise ddata for iio_get_acpi_device_name_and_data()
Date: Fri,  1 Nov 2024 10:08:25 +0200
Message-ID: <20241101081203.3360421-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dan reported that ddata might be used uninitialised in some cases.
Let's initialise it to NULL (patches 1 - 3). With that, update one driver
to drop an unneeded anymore check (included in patch 3).

While at it, one more cleanup to kxcjk-1013 (patch 4) is added.

Jonathan, dunno if you want to rebase at this stage (probably not),
but if you do, feel free to fold the patches 1-3 to the initial code.

In v2:
- rewritten patches 1-3 to do the job on the caller side (Jonathan)

Andy Shevchenko (4):
  iio: light: ltr501: Assing ddata to NULL
  iio: light: isl29018: Assing ddata to NULL
  iio: accel: kxcjk-1013: Assing ddata to NULL instead of NULL check
  iio: accel: kxcjk-1013: Deduplicate ODR startup time array

 drivers/iio/accel/kxcjk-1013.c | 30 ++++++------------------------
 drivers/iio/light/isl29018.c   |  2 +-
 drivers/iio/light/ltr501.c     |  2 +-
 3 files changed, 8 insertions(+), 26 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


