Return-Path: <linux-iio+bounces-23026-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD83B2D0CA
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 02:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF063B1484
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 00:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604C818C91F;
	Wed, 20 Aug 2025 00:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFa+8X9k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EF7A945;
	Wed, 20 Aug 2025 00:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755650933; cv=none; b=bPMxF/KXoIutuZM42NfNRXiw0SXNwxSuxAdN793Yf6Br/BlMWa8dMhSs5xmNPAgOHlVoWojAzP/U7vmvqLhwD5HDPqkMVE1pF/p40H0zeNhlFqqzb9Xnrcq2bwHLV5240BrRZ1AKFnx2Auo9V0OurN7tSRrE7fyOiuIo755LAJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755650933; c=relaxed/simple;
	bh=eI9RekPteR9Uu/w6sEe2zM8O3JmSk36sEouzlpxRogc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SYRZrix+YhXhfP/JqKL/6/MAIblL86IYKWjdl7nnC5ZjDjzFYyyD2Eo5Fj+uFiEgYoeA8yUWGdpmdQb6tXUpa73rus6PQJwW00w9Mb2bIIE3NeoHTIRP98EPQSlFXnOwFGLulCXOCxHWTMH5tUO6i45pGJE3OSjcs6vUg9ufQuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nFa+8X9k; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755650931; x=1787186931;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eI9RekPteR9Uu/w6sEe2zM8O3JmSk36sEouzlpxRogc=;
  b=nFa+8X9krTbB3+yo0APgvN3epRzVRaEz+qwYtMfKerI9+LFwI7eqvDCw
   oGM4Ka+XVQ5YtESzEEgJmVpGc2FWsbPau8mvA7VNv3dsldq1YfUHakw+s
   p8oNPrAFwIll4NXWVMLwCvX0tWhnazqdbhpmtllVXgz5U/mvNYRo6o1WA
   s+6PlhDWDGk2Y8nbZoyaMRlulvWCLC9S6Ug7ZSRDAtPKiz7kL4XCecjGL
   BGbHCngtK6DSGVQDx7s+V45iSe7zHzS/yQfIb1aFZMnaoX7ZRrog5X3Yg
   iUxVgjUP09hUlGx/iITlEsblxBeTYhH4/JXGBlMorSvm6u5cuNpv4gYe/
   w==;
X-CSE-ConnectionGUID: kU0QAcmeQKGZ94HZVCfaRw==
X-CSE-MsgGUID: KLgQJj+jTMG3Q7P8hmapfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="75488203"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="75488203"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 17:48:51 -0700
X-CSE-ConnectionGUID: w/K6pqDXT2Ov6YKfASs8LA==
X-CSE-MsgGUID: d6iT+cm2S6qjH+BNh7m1rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167609252"
Received: from junjie-nuc.bj.intel.com ([10.238.156.159])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 17:48:48 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-kernel@vger.kernel.org,
	Junjie Cao <junjie.cao@intel.com>
Subject: [PATCH v2] iio: core: switch info_mask fields to unsigned long to match find_bit helpers
Date: Wed, 20 Aug 2025 08:47:55 +0800
Message-ID: <20250820004755.69627-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

for_each_set_bit()/find_*_bit() expect arrays of unsigned long (see
include/linux/find.h), but industrialio-core passed const long * into
iio_device_add_info_mask_type{,_avail}().

These masks are used purely as bit arrays and are populated via BIT()
(1UL << n). Switch the info_mask_* fields and the corresponding function
parameters to unsigned long so the types match the helpers. This removes
sparse warnings about signedness mismatches (seen with 'make C=1'
CF='-Wsparse-all') without changing behavior or struct layout.

No functional change intended.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
Hi Jonathan,

Thanks so much for the feedback and the clear fix suggestion.

Changes in v2:
- Implemented Jonathan's suggestion to change info_mask_* fields to unsigned long
- Updated commit message based on feedback

v1: https://lore.kernel.org/linux-iio/20250815022528.24705-1-junjie.cao@intel.com/

Regarding how I triggered the warning, I can reproduce it with:
  make M=drivers/iio clean
  make C=1 drivers/iio/industrialio-core.o CF='-Wsparse-all' 2>&1 | grep signedness

Environment details:
- Tree: linux-next (tag next-20250808)
- GCC: gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0
- Sparse: v0.5.0-8881-g2fb2b909

I completely agree that your approach is much better. The masks are indeed 
used purely as bit arrays, so making them unsigned long must be the right 
solution.

To double-check beyond industrialio-core, I (1) ran a subsystem-wide sparse 
pass and a clean build of drivers/iio, (2) audited usages of info_mask_*, 
and (3) reviewed other for_each_set_bit() sites. With the type change applied, 
there were no remaining signedness diagnostics, no new build warnings, and no 
sites relying on these fields being signed.

Here is the v2 patch implementing your suggestion. No functional change 
intended; the patch has been build- and sparse-tested.

Thanks,
Junjie

 drivers/iio/industrialio-core.c |  4 ++--
 include/linux/iio/iio.h         | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 159d6c5ca3ce..9125d466118d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1243,7 +1243,7 @@ static int iio_device_add_channel_label(struct iio_dev *indio_dev,
 static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
 					 struct iio_chan_spec const *chan,
 					 enum iio_shared_by shared_by,
-					 const long *infomask)
+					 const unsigned long *infomask)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	int i, ret, attrcount = 0;
@@ -1273,7 +1273,7 @@ static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
 static int iio_device_add_info_mask_type_avail(struct iio_dev *indio_dev,
 					       struct iio_chan_spec const *chan,
 					       enum iio_shared_by shared_by,
-					       const long *infomask)
+					       const unsigned long *infomask)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	int i, ret, attrcount = 0;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index d11668f14a3e..39c55116939e 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -271,14 +271,14 @@ struct iio_chan_spec {
 			unsigned int num_ext_scan_type;
 		};
 	};
-	long			info_mask_separate;
-	long			info_mask_separate_available;
-	long			info_mask_shared_by_type;
-	long			info_mask_shared_by_type_available;
-	long			info_mask_shared_by_dir;
-	long			info_mask_shared_by_dir_available;
-	long			info_mask_shared_by_all;
-	long			info_mask_shared_by_all_available;
+	unsigned long			info_mask_separate;
+	unsigned long			info_mask_separate_available;
+	unsigned long			info_mask_shared_by_type;
+	unsigned long			info_mask_shared_by_type_available;
+	unsigned long			info_mask_shared_by_dir;
+	unsigned long			info_mask_shared_by_dir_available;
+	unsigned long			info_mask_shared_by_all;
+	unsigned long			info_mask_shared_by_all_available;
 	const struct iio_event_spec *event_spec;
 	unsigned int		num_event_specs;
 	const struct iio_chan_spec_ext_info *ext_info;
-- 
2.43.0


