Return-Path: <linux-iio+bounces-13037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DC09E2D72
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 21:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E48BB42497
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 19:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F408202F8C;
	Tue,  3 Dec 2024 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UH8bNw/0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8381EE039;
	Tue,  3 Dec 2024 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255627; cv=none; b=NavNm87v8Kdww79DGQzQWxUMKM9t5/SoJFEoQL1hbcvQMyv3/pdfpWgw0zeqrhy12bVtQ+h20Z4xblWpp7QwQ3GZ9BplH9f/Sfh47CVFLj2Xn0/QodRgKGt8r0qx4UsIQR7+ls+xtPPfeD87KIQi5KGxQfSaGYHffbZNh8wX3yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255627; c=relaxed/simple;
	bh=EAUHkU6gs6mYbwKOazECX7HnBU3CQ1VKP47z+wgsPzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EDDPYZASMzpY4ovdRwbMhnyr/IVUNux0xL9bLVvLjjLTYvNRe2pE16vhKyMGQhTXpT/O45c4riwyMhuR34yLA5pWyMunr+bKiI51TNUl2Qrhks/40s10GLhfNmHGv3xCKOt1V1ghLj36dxo3CtYk4GnxhdeW1WrmeCbIzMf7XbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UH8bNw/0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733255626; x=1764791626;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EAUHkU6gs6mYbwKOazECX7HnBU3CQ1VKP47z+wgsPzc=;
  b=UH8bNw/0GTD7yZvcgUpkjbEjQtLGiJw/ZIXIiluu3qbFSY0ik2QNIEtk
   vXN7odQjHEWrPL6zhlr9G4RmgikvItEmQ8FVOFO3fb2bjDz/heoxLtE5P
   KRhD7KNJOuHnSXW+b7lZqW2fcQM79SN8tWJM6MH8gKv0fxEiIT/tIIC5l
   lZvYfIFIDJd0T/ON1JL1SDI5IXfWo853X8NdsvzgZVeclzL66xGAnbcJa
   bI24IZBBd2TTIKwluWoMTfv7dEhJNJoNJ87MByTkv/cJwnBZShV4SwOc4
   i3Us8wrID05ZBHpTuz8w/6+wok/+wnA/vB9W5Dd4FoydnHsV5Sp7pF6+9
   g==;
X-CSE-ConnectionGUID: TEDrm7YQRVCswC36/rvHsw==
X-CSE-MsgGUID: neDOfCZKQOmm/gwm2YPQOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33238664"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33238664"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 11:53:45 -0800
X-CSE-ConnectionGUID: 6AFZZeUsRwuUWgKWI2rS+w==
X-CSE-MsgGUID: 2QSlDVi+Rj624gUs43pIJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="98621149"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 03 Dec 2024 11:53:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 13FE227C; Tue, 03 Dec 2024 21:53:41 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 0/2] driver core: move devres APIs to a separate header
Date: Tue,  3 Dec 2024 21:48:50 +0200
Message-ID: <20241203195340.855879-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a lot of devm_*() APIs defined in the device.h and sometimes either
the rest of the device.h is in use or only stuff from (new) devres.h.
Especially helpful to have it separated for the headers that want to use
devm_add_action_or_reset() or similar APIs in inline functions.

I don't mind any subsystem in question to take it (IIO or driver core), but
I would need an immutable branch/tag since there is a pending series that
adds yet another devm_*() into the device.h and supposed to go via one of
mine trees. Of course it would be possible to route that series via another
tree.

Andy Shevchenko (2):
  driver core: Split devres APIs to device/devres.h
  iio: imu: st_lsm9ds0: Replace device.h with what is needed

 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c |   2 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c |   2 +-
 include/linux/device.h                      | 122 +------------------
 include/linux/device/devres.h               | 124 ++++++++++++++++++++
 4 files changed, 129 insertions(+), 121 deletions(-)
 create mode 100644 include/linux/device/devres.h

-- 
2.43.0.rc1.1336.g36b5255a03ac


