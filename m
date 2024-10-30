Return-Path: <linux-iio+bounces-11633-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD629B6906
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 17:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611C0285791
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 16:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A26214415;
	Wed, 30 Oct 2024 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQPEzMQu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0935F1E8858;
	Wed, 30 Oct 2024 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305220; cv=none; b=V1Ec0Tutf6bAQzi7Pa6pSRgTBfflb0o7rt5GAm10g62U47qJPWa6wQso7nGiF9BGRbbPFE5oKQJITw0ytre385s5Rq8Pd5tNZJfPm6RoJ2Y30RK2Ljr5Thz7UrfBDNaZ4OI+FuZt+rJOnAxaRWqD6wB5vT6u06xcavJNjHhpXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305220; c=relaxed/simple;
	bh=g3c5mjdidyY5+z6Ykim+MllTe96golMtOVBRIlkKs9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TxaO5ezcltDWhSexJ3JrLAxWYRwfx4yZWa+VgCpDJ2TGR2PbS4UYyiiwWJIMh6VrRtCXPWb6iO5u9dM/t+aRqbMjRzNj1CZw6NT/LoKtkCVlWB98eq8QaoyBtKHTj6+d005wX4TH8zJm9BbjcID+bfVjsBFvNC20IIjx2eWASsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQPEzMQu; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730305219; x=1761841219;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g3c5mjdidyY5+z6Ykim+MllTe96golMtOVBRIlkKs9E=;
  b=dQPEzMQuX0EKTxGPwyhoh9RX4UKzUxfPAcsSkPvBbxKpzlmQK7tWiU2j
   Pe9ikbm0dcxhqyXb/bAuvzhiLIGxpHGL/2Qggje7nY/fQiwQhuWa+zJ6q
   xvesK7d0bOTCqptqW7G9w+iINdrGTt1a7dnoIhCLYm7TN2OW6HcIyAK9B
   Cin0N2f1SzsA0pvmi5x3xtcIxrNbAJUo2nbUVLiVwKmILNQaf2iIZS0O9
   5qqIBXttZrZMinTQJB47vxEe69DZJZ2v0RHJvGXVf8o4cp7tPpxBX0/kF
   QSfhZqQAAIPd4B8p/2/ObmyQd0nihCvap92DgGC56OiLsIrTR915uofal
   A==;
X-CSE-ConnectionGUID: kj4W5vapT9OSl4zk8UvIUg==
X-CSE-MsgGUID: cQNMadFCRNiyLehcY5TsJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40550670"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40550670"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:20:19 -0700
X-CSE-ConnectionGUID: XqFeaTnuSx2jyw9yqgRzrA==
X-CSE-MsgGUID: Ml2nXwI7Rk+fZGJoUEIsVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="86973260"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 30 Oct 2024 09:20:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E7D711FD; Wed, 30 Oct 2024 18:20:14 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v1 0/2] iio: adc: Check for error from devm_mutex_init()
Date: Wed, 30 Oct 2024 18:19:17 +0200
Message-ID: <20241030162013.2100253-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ignoring error checking from devm calls is a bad practice in general.
While not critical today, it may become a problem tomorrow.
Fix this for devm_mutex_init().

Andy Shevchenko (2):
  iio: adc: ad4000: Check for error code from devm_mutex_init() call
  iio: adc: pac1921: Check for error code from devm_mutex_init() call

 drivers/iio/adc/ad4000.c  | 4 +++-
 drivers/iio/adc/pac1921.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


