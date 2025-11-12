Return-Path: <linux-iio+bounces-26183-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 960E1C52F06
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 16:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC05356510B
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 15:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0096A347FED;
	Wed, 12 Nov 2025 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TrbPf3Og"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDD7346FAB;
	Wed, 12 Nov 2025 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959464; cv=none; b=NvQuchHTlXOH+FWWArq5H6mQ+pu5pRidsl5Ib4y40Syo/d4me6+UYqlJ0hhNK5Is/wFTaqF54PSNKUz3OsdqCQgWqkBpOB0PhkQXBSvLJnDY3syz5gRwYXK8vPDOZlpmjQih0kSc8uz3S7OataxkrqoXB2jy38tEsEtAhMWxNCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959464; c=relaxed/simple;
	bh=gC5uVc2nDHrl/dFTyqnlyGHiCt8hcDtXsBez+wE+sBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUcKLtEGhf1c5tpXLQyhFSn4Ywb4OOqAR6345tEBwz9lpce3wQbaJsXrOckY9qi2gvZ42SdJtZfUQg4l/eCAes8Yvcu+nLRqHWiNOn5qHtjJT9NbFRN+u92roWCc5hlalEJX3YoC3dopZNhsfvMBf/AWJKgKCSt1Gf6waQhtw9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TrbPf3Og; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762959463; x=1794495463;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gC5uVc2nDHrl/dFTyqnlyGHiCt8hcDtXsBez+wE+sBg=;
  b=TrbPf3OgRmSR228isbQG/kAmx6+1vebUkx5rLMoSdqV+dvq/k2SDtdbd
   k6DS1N0FLx3W29cZr2hCEy/BTFJJE9tUDWDJ7Jzb/qLLdv9h+Z6/EwDyb
   Md5bboMPsMJAq/bWGydI4UsqquYPA1YKPv0ZFniuQ1/5yeOOFCxdJVId/
   ZzIKWh/H1J4JTi1g8WX8RsHgH6Ruzqip2KQFC6FrGIV8Zz+54jpmIxBST
   S3/TN5FtALasXkcIi2xjPSw2H0piulKZ9MWApQLULuzJeiFWbn54fi6BE
   9P0daZzyLtgMkX4gc9aJ22H2Wg46Ii646rW+fslx1vsa0TtqdB8Mki0Gz
   A==;
X-CSE-ConnectionGUID: 86CTEMJCSyOLMNN2hrGv+g==
X-CSE-MsgGUID: RIKFW66gTtWJClLjPl9mDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64728036"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="64728036"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 06:57:38 -0800
X-CSE-ConnectionGUID: GevwlwVCS8+qxBmJipjDfA==
X-CSE-MsgGUID: q8UovTbXSBWqk7wqAHRfVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="188874873"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 12 Nov 2025 06:57:37 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 2263C95; Wed, 12 Nov 2025 15:57:36 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/3] iio: core: fix error path in iio_device_alloc()
Date: Wed, 12 Nov 2025 15:55:07 +0100
Message-ID: <20251112145735.2075527-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series is induced by the similar fixes in viio_trigger_alloc().
Basically two things happen here: 1) add missed mutex_destroy()
calls, and 2) refactor to make sure we clean resources with put_device()
when appropriate.

Andy Shevchenko (3):
  iio: core: add missing mutex_destroy in iio_dev_release()
  iio: core: Clean up device correctly on iio_device_alloc() failure
  iio: core: Replace lockdep_set_class() + mutex_init() by combined call

 drivers/iio/industrialio-core.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

-- 
2.50.1


