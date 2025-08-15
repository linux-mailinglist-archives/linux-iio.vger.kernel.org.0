Return-Path: <linux-iio+bounces-22745-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2C9B275A8
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 04:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81F11CC1065
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 02:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809CC298CA1;
	Fri, 15 Aug 2025 02:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KuMjuvN1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA4D183CC3;
	Fri, 15 Aug 2025 02:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224745; cv=none; b=LwgW5/x5sgElK7g/fSa7FwoPdNq30ss62ao1PoSSEcnHuVqD+RL3xMbQ+wSG6Z3bKls60NX7qYyX349Fqb+lrxv00tspyPlZ76iRlfFnTMZge82xRo9I9JWexPgEh7BsqGpv6UbYIPk85DG/a0Iy7MQF9Pf9cnPGoKrOqxn5QNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224745; c=relaxed/simple;
	bh=fcSlilEjhFWzXs4KREd60ump1nNHUpZ5VYrJzcyzmOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fOH2CyXQbWEOZyylrR42FKFpoYQ1nvqLV8B3zQMdC9U303/PolYL/soCnsLaBadFoQ9FGhCJrH4po/5Yvqv/GVWk63i6Aru64VKIZb1lPYwEKcJ/8bTZMPYy4KFQ42VEYKYqu4O6NdXAmWuSRrl07xRnY3XM7fytgxa6l9N5VGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KuMjuvN1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755224744; x=1786760744;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fcSlilEjhFWzXs4KREd60ump1nNHUpZ5VYrJzcyzmOc=;
  b=KuMjuvN1P6OO6Pp0qxc2S9tYsbWNf5p4Zf+PnD8d8ruVq8u1p9FKAjcz
   NQ9BJJA9OKeXtXSlhOSZaVxWj9s4KNxv2B48N1AcJRcb1A/otNJ4a2cFf
   vyAAgyPMAJA/UFeNdg0qMj0L2j5cvQwW9sAQZXuhWwvOW8YBoc7obnRuh
   TQHDrOV5GVtS8AQAUqJrGlgl+zCSpdgKnopexznuu8OteMXjPk9Gqv/Lj
   yf1DIdKGn67svQo52Ugbt0LpHnmyGX1JJfa9A7vr4QsyLcruQOOs3P7Wi
   x9VgQ3IV2hcyZqLoKkYBmPGwtb8sBRoff1uDDzA+XQ5bJNx19OSch3BqZ
   g==;
X-CSE-ConnectionGUID: qDQ93xsqTRyGUNqs3zwSsA==
X-CSE-MsgGUID: /ikdP53/T1iZ/Yh/YKLW3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57479294"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57479294"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 19:25:43 -0700
X-CSE-ConnectionGUID: EGYDt9sXS3edLAM/qNKWuQ==
X-CSE-MsgGUID: eKa1GTUbSVCUSaIs5Emiiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="197756015"
Received: from junjie-nuc.bj.intel.com ([10.238.156.159])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 19:25:41 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-kernel@vger.kernel.org,
	Junjie Cao <junjie.cao@intel.com>
Subject: [PATCH] iio: core: Cast info mask to 'unsigned long *' in bit-ops
Date: Fri, 15 Aug 2025 10:25:28 +0800
Message-ID: <20250815022528.24705-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

for_each_set_bit()/find_*_bit() expect 'const unsigned long *' (see
include/linux/find.h), but industrialio-core.c passes 'const long *'
in iio_device_add_info_mask_type{,_avail}(). Sparse flags a signedness
mismatch.

The masks are used purely as bit arrays. Cast them to 'const unsigned
long *' at the call sites to match the helpers' prototypes, without
changing memory layout or behavior. Changing the field types would cause
unnecessary churn across IIO.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 drivers/iio/industrialio-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 159d6c5ca3ce..e9491a999ac0 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1248,7 +1248,7 @@ static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	int i, ret, attrcount = 0;
 
-	for_each_set_bit(i, infomask, sizeof(*infomask)*8) {
+	for_each_set_bit(i, (const unsigned long *)infomask, sizeof(*infomask) * 8) {
 		if (i >= ARRAY_SIZE(iio_chan_info_postfix))
 			return -EINVAL;
 		ret = __iio_add_chan_devattr(iio_chan_info_postfix[i],
@@ -1279,7 +1279,7 @@ static int iio_device_add_info_mask_type_avail(struct iio_dev *indio_dev,
 	int i, ret, attrcount = 0;
 	char *avail_postfix;
 
-	for_each_set_bit(i, infomask, sizeof(*infomask) * 8) {
+	for_each_set_bit(i, (const unsigned long *)infomask, sizeof(*infomask) * 8) {
 		if (i >= ARRAY_SIZE(iio_chan_info_postfix))
 			return -EINVAL;
 		avail_postfix = kasprintf(GFP_KERNEL,
-- 
2.43.0


