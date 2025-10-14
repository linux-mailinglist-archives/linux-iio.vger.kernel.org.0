Return-Path: <linux-iio+bounces-25047-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FDEBDA303
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 16:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB91718A378A
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 15:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807A93002A9;
	Tue, 14 Oct 2025 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cuwboClK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F38D2FFFB9;
	Tue, 14 Oct 2025 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453957; cv=none; b=nSHFsuV7gX6DsvY/FGdtBgH3OHR7FT+V4cPsH8mI+FFtd5xSe/vheDcgnVR3AzI4+Q1whPSuKPXc80Jk5uMWtm4Z1TGvmP7gjmaM4iXdeSBK4Ro2Rz5hWMufd++ESuU+uHpkv2I3bHgaDbJh6wIJbj0R9h6G9RO8U948VVMqTTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453957; c=relaxed/simple;
	bh=vUTHM+SWkI/RV5I02QaaIF2/tUM7KgdwTICyd2lXCaI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qEdfqUBT/akwgt+68SEay+nUTWcla/Y32+nHMBqepc6lqj0Sd+6aOXfLpeqq4PTb0aCk70n3U17mh+Ntb3YT3z5Ylp86d39RB/3XyjJs2Z6Aa/ZKvQXDHxGqU6hvhp/c505pqIvrSX6eTk+7x4vs/0Upc6euVncE//fy6CYxI/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cuwboClK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760453955; x=1791989955;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vUTHM+SWkI/RV5I02QaaIF2/tUM7KgdwTICyd2lXCaI=;
  b=cuwboClKzOvf06beVeeg42gXXLyZ39jjO0RGaDUf1PmF730MIeJ4lVuq
   q8VkNEGHYudYEpJH22+9xhXq3KBzxJJF072H2qxzoVTk+dFbzU/i7R93x
   HwgIEm5TQfB+VW7rzrbadEq9j3jA8ZzUXLLwmEAg6CziSGhrLx+8SHf9N
   AprvP1IESwApNn++6pjtdX2HYCZauScRPqaNNoyG1ghwQT10NmzLmPrgI
   E40AAC+LNtrDQkGbilCEy07mFgkTVLAsHtvXJzIjjEwgWFvP1rCfaZMYf
   EWS6uYaL/w2OBwrrrFB9aGyws0ZRlnquyQLsiJpf8wkch11ElVCNTM9x3
   w==;
X-CSE-ConnectionGUID: ZdyG4dAsTdegMZstqUV9qA==
X-CSE-MsgGUID: tRVP7JR1TKGmzWhiz7T6JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="66473195"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="66473195"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 07:59:14 -0700
X-CSE-ConnectionGUID: gCXVd/D9QH6QXFLAtnwRYg==
X-CSE-MsgGUID: 9ZKEbwLcR5GDfuCSuWUNOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="182344421"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.195])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 07:59:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-iio@vger.kernel.org,
	William Breathitt Gray <wbg@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH v2 1/1] MAINTAINERS: Update Intel Quadrature Encoder Peripheral maintainer
Date: Tue, 14 Oct 2025 17:59:05 +0300
Message-Id: <20251014145905.4862-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Jarkko's address is going to bounce soon and I agreed to be the new
maintainer.

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v2: Add S: Supported

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968..393a475fbd1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12822,8 +12822,9 @@ S:	Orphan
 F:	drivers/ptp/ptp_dfl_tod.c
 
 INTEL QUADRATURE ENCODER PERIPHERAL DRIVER
-M:	Jarkko Nikula <jarkko.nikula@linux.intel.com>
+M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
 L:	linux-iio@vger.kernel.org
+S:	Supported
 F:	drivers/counter/intel-qep.c
 
 INTEL SCU DRIVERS

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.39.5


