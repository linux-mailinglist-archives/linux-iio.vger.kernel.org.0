Return-Path: <linux-iio+bounces-13068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3DA9E30D3
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 02:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43B96B240F8
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 01:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA115BE5E;
	Wed,  4 Dec 2024 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNoj/w7W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522A32B9B4;
	Wed,  4 Dec 2024 01:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733276190; cv=none; b=UeAHQToIiWZUxY0rtQcFOt6OEqz3Oj1KnkL8Tu/o65QrfJ45jlnFVXh+eLwZk+WV4gin47dDL2gkm2KFPzAQqQXyrpw+o2LPhaNh98kcudwkYjT00i4sP+NvMeL+tUxdDsVCcmUy6rK5ilfUu231im85hsB0BVUCJTjjwGgH5aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733276190; c=relaxed/simple;
	bh=sxpfgYRL87ZHH1NSsihdavadeHs1MoFRpkN5L2T6KpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5+b+RIp0hi+FSyt4eTaPmqA8zdqleRxoe3jr4n5WUz4CH3AZyBqrUJs6Ze6SWpV6jqtmq3DCU41UaqhodYKYQAJyjczR2KL4PyUOfkEM/k4GYHylPA/NhMqaaanOt88nzOu/jOB1F77GSymfBRT6GXKOwRRi9moCt6VwRHAezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNoj/w7W; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733276189; x=1764812189;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sxpfgYRL87ZHH1NSsihdavadeHs1MoFRpkN5L2T6KpU=;
  b=nNoj/w7WdqXhaVVyXmOgBfAyyRbtM/+SG3Iygrw/GKiIzWXxMG3VuTBk
   Zalk6dLHCLl9JrgBgwPOeubiElNK8KeQPF/5U+UzmNYzPtNs3pvjCVbGo
   uR8aFhypRQlG5wPZv0sXxp6lUuE5+ElrJPIs69XqmhZr/qTtbQKysIFK7
   aTggzIgJ0Zn3audKKGjXs5qA6RvCvR+1L8q8lX+F9AJoFUi4p7qxtC8ZB
   uYbC/kPB9Hp/WWRrNOGMOch1ukqWiDgjZ1GFNZc30UcmZ1STa1sTc7oms
   7PRkDPDFJDvwQQkkrG7DP9360jkxIANreSA+AnqDfjRfJmj/NiAs+ch/e
   A==;
X-CSE-ConnectionGUID: OKDw726YQYSP13UHsxAsYg==
X-CSE-MsgGUID: YHCZZd0GTyKjVqYuj0tHzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33655189"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33655189"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 17:36:25 -0800
X-CSE-ConnectionGUID: g32QDGLpQXehFhsB9Et4wA==
X-CSE-MsgGUID: x0FuIzJmRY63mAtgytDZbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="98600612"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 03 Dec 2024 17:36:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0BFF227C; Wed, 04 Dec 2024 03:36:21 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 0/4] iio: afe: rescale: A few cleanups
Date: Wed,  4 Dec 2024 03:33:15 +0200
Message-ID: <20241204013620.862943-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are cleanups to the code, most of the + LoCs due to missed inclusions.

The patch 3 is kinda interesting as in long term the idea to add multiplication
and division macros over the fract structures, which will simplify code that
uses rational numbers. Hence the mentioned patch is just a preparatory for making
next step easier.

Andy Shevchenko (4):
  iio: afe: rescale: Don't use ^ for booleans
  iio: afe: rescale: Don't use ULL(1) << x instead of BIT(x)
  iio: afe: rescale: Re-use generic struct s32_fract
  iio: afe: rescale: Don't use "proxy" headers

 drivers/iio/afe/iio-rescale.c   | 88 ++++++++++++++++++---------------
 include/linux/iio/afe/rescale.h |  5 +-
 2 files changed, 51 insertions(+), 42 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


