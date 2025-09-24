Return-Path: <linux-iio+bounces-24408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A51CB9A035
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 15:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2832A47E7
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 13:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC50302153;
	Wed, 24 Sep 2025 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IN/T1Fuv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE83B2FB976;
	Wed, 24 Sep 2025 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719997; cv=none; b=UJq+pAX7K0cFmXaqlSZBPVC+ayycz0p0XN6rCim21NIQhRSjjI/XjcFHa9sZC6lIbn6IDbuN6AWtPdBcKtA59PGzHYFWWPKQSccMR02b82tU6WcnhDRQjQgtEfPIYCL1aPrztM1IQtPPGr51srijVs1rzznq3Z9+uFfPvhj2DqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719997; c=relaxed/simple;
	bh=4tyzjkkw4VLzSKpJnniVzxtV/ocVmSSMp3uH5d2aTO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OTB6ScQsF6R1nlm0f3X05C7uOJVD+ibo4ZCTuc1efm3nAz8WmjlNXhGTr+oc0T72qt9XQaUXBVkwX14Mb7Fz4eHNJDyDs4P4sG3P4+wL/dq7HzyGtElntIIQKcmv4jvvSTf7EcRgx/pYCADGnFmmDE7UKB/egPzoonwnWf1q5uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IN/T1Fuv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758719996; x=1790255996;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4tyzjkkw4VLzSKpJnniVzxtV/ocVmSSMp3uH5d2aTO8=;
  b=IN/T1FuvR29Lsj4B3pu6tjvfZw1jXrlBV/T/lVdy8KKJUt2jMmV6Vkyz
   7zYdOCufZHePF3VhptywCcnop+/IFmY1TLX0pfRoIStVVa3abUqI07/Zx
   8E1p4Ze0xkyOPquQC6sxoPvpbmCtCU8SSYyTfuMhbX4T5gMwnkigrJ42E
   vRdmQFMSKo13JNc8e+fXUpKfq+E458uz2zymi+8FG3tnIWkAfoAsmeNxq
   6FrgmIvWESrFA6gfXj+GfoXJk0cWO8hplQLU9aLP7XsGiHCv2CPPx3xh2
   nnx4gq2sQ9ay5FtD38kL4WMFepsl9u3RYMbBL9tEls5LXYzo+EM81FIXN
   Q==;
X-CSE-ConnectionGUID: JdBxy+U6TJ2gIrpw+ai3mw==
X-CSE-MsgGUID: xIYu8SqrTIG/MZxXfIC1bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="86458327"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="86458327"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 06:19:55 -0700
X-CSE-ConnectionGUID: lfbMvfWAQZiEu5mZOo9mOA==
X-CSE-MsgGUID: zHKk1UOxS2qKapZxL7aC4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="176154780"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.151])
  by orviesa006.jf.intel.com with ESMTP; 24 Sep 2025 06:19:52 -0700
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
To: linux-iio@vger.kernel.org
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH] MAINTAINERS: Update Intel Quadrature Encoder Peripheral maintainer
Date: Wed, 24 Sep 2025 16:19:47 +0300
Message-ID: <20250924131947.70898-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

My address is going to bounce soon and Ilpo agreed to be a new
maintainer.

Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b9fc91b4ce4f..8fc8426d88c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12609,7 +12609,7 @@ S:	Orphan
 F:	drivers/ptp/ptp_dfl_tod.c
 
 INTEL QUADRATURE ENCODER PERIPHERAL DRIVER
-M:	Jarkko Nikula <jarkko.nikula@linux.intel.com>
+M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
 L:	linux-iio@vger.kernel.org
 F:	drivers/counter/intel-qep.c
 
-- 
2.47.3


