Return-Path: <linux-iio+bounces-11629-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0FC9B68E0
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 17:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89E51F216B4
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 16:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E91214402;
	Wed, 30 Oct 2024 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CO9E9tDx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1015A433D5;
	Wed, 30 Oct 2024 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304484; cv=none; b=bCFXciWi+uXrhjNY6s8BKTSlCLZVsEzw6rtliH2i9Z6n49LhyxIr+9hX7AbfqsZK3XZdRheiEjAxpny1KD7wCi5VlqdX26MbJrO60tElLbrWL5CGfkK8zbcBjRJO+PX/FJxVdKUTt5q3acgX99K9hVwg0lyTNoMHGcoE2GMRhsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304484; c=relaxed/simple;
	bh=dN6/EfUjzLbl6wnJHhWh2GGFGEvnCDY56lOMQ6JTL3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bTTqwy4JkntrkpZGm4pY98BtSIJ6E7+jYgto5EUczXH4ITB8uBxl2xt0ZT8/60kZx2txJjg+jJXt3h53cuAnPIdg6QHhcf2L/F7EdgiAWyWQd9MZKWaUI2JmZ5OD/iP0kRhk+PBBYIEwPZjdJh35Tf+fbfmIpsdAtbI+PGh+sus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CO9E9tDx; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730304482; x=1761840482;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dN6/EfUjzLbl6wnJHhWh2GGFGEvnCDY56lOMQ6JTL3s=;
  b=CO9E9tDxKweZH5lssTGh51YM8k1Xh359WwAGaMQHYFgMKAzRTxiVt0+o
   cDDg5KTZZU5dNeVcTE6rWHZqUwdaTnmIdzuhuGD6y2Y3GyLPR7Z4eJkZ2
   LDI9iG+iuWMUVN95wKU2HjTNfS3Ri0MxTDe0BYKrYG5jRPcChhlhKbfmQ
   TlSk9sPKIyTzXb/3mr/KgxOVj4InZ8RdsijahgQogR3q9jzZ5rixE0TpQ
   x122T/Jp0or/CRj4FQ9qxnJKjieKw9uyk0MNMpNIjHFTaBFBPbpY8B3bt
   LlnD25sWFlTuR0b2FJiRUNpMp3+4BvP16WFe29qnpV4fQUtoIZcAdMF6H
   A==;
X-CSE-ConnectionGUID: OM+00Kl9TrWnbwDZwvdiXQ==
X-CSE-MsgGUID: 4YHa62i9Qlenp34ewp2XIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="29432032"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="29432032"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:08:01 -0700
X-CSE-ConnectionGUID: d+cMCHTzTOOwJ5xLAJBUhA==
X-CSE-MsgGUID: YHfdmT5GR/aKfrkSlwgl0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="82523845"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 30 Oct 2024 09:08:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3C21D1FD; Wed, 30 Oct 2024 18:07:58 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 0/4] iio: acpi: always initialise data in iio_get_acpi_device_name_and_data()
Date: Wed, 30 Oct 2024 18:02:16 +0200
Message-ID: <20241030160756.2099326-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dan reported that data might be used uninitialised in some cases.
Let's initialise it to NULL (patch 1). With that, update one driver
to drop an unneeded anymore check (patch 2). Another driver (patch 4)
gain almost a dead code — feel free to not apply it.

While at it, one more cleanup to kxcjk-1013 (patch 3) is added.

Jonathan, dunno if you want to rebase at this stage (probably not),
but if you do, feel free to fold the patches 1-2 to the initial code.
The rest seems to me like the independent patches.

Andy Shevchenko (4):
  iio: acpi: Fill data with NULL when
    iio_get_acpi_device_name_and_data() fails
  iio: accel: kxcjk-1013: Drop duplicate NULL check in kxcjk1013_probe()
  iio: accel: kxcjk-1013: Deduplicate ODR startup time array
  iio: light: isl29018: Check if name is valid in isl29018_probe()

 drivers/iio/accel/kxcjk-1013.c  | 28 +++++-----------------------
 drivers/iio/industrialio-acpi.c |  6 +++++-
 drivers/iio/light/isl29018.c    |  2 ++
 3 files changed, 12 insertions(+), 24 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


