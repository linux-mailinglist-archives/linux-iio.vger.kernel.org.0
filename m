Return-Path: <linux-iio+bounces-17396-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39A5A75EAB
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 07:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE13B7A31CB
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 05:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814E3189528;
	Mon, 31 Mar 2025 05:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kX6ffit7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C2E1A00E7;
	Mon, 31 Mar 2025 05:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743400121; cv=none; b=RruH7lbfy0DoXracc8M1e1TQIwipylXuu6AGbQ+ymxuXdW82xp9bgu1sgOBWrxbbv3rQItgcxwMW4aDCK++VL36Tr90RQGdQ++SMreFJuip+0TpuP8f5G05Z8Dqdy3kBsXCC8EyvulH0PdlUN1hS8IYLhJ6Vm5Ln3GWukVCVGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743400121; c=relaxed/simple;
	bh=XgMfHKb15BjN8xjXFDAZk+GAZXpYXAf6Qn+Hqx0Fzd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7uCf0pWgT2tlxRwF1Qrp0CfM2ZyXFYnojMKVql5KNM9GboDBBOqJXcyJjz5lEeoT/uziA6+BVpOfXQK9eZpQJ0f2np+O/2NfFliDFD/Cwfi6BSqfd9y0jUYFJpY7V/CSFPlNX/Fv3olXQGeaR6uKEemrLXV0p1Q7C8v1YuxmJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kX6ffit7; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743400119; x=1774936119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XgMfHKb15BjN8xjXFDAZk+GAZXpYXAf6Qn+Hqx0Fzd4=;
  b=kX6ffit73zcX0J5SPcxi/hY2eYJRF2coqrKFVjFkeqezKFB2Sj6yMtiV
   S01KYOjtpmgcy79wmVd9Hx+H97XpssX1xp+D6Cw7BsTm97JNyHi9Uqgo7
   qu2hcX02WV1rMInSHf+XvtXDHN2BRVBXELgjzD3n1GbNg0pg/tfBQ1Vfy
   ySiTzKJ1h4wqfUG7QzVagy5W4x/K3+K3mDpESe+7WwjzRXFjZXtW4ao7n
   9zmr8FJWE2RQj+zz/VrFYtVXw6uiKpJ0HE/clWSwv2ptUCw8E/j5GJyn0
   mHMTva2WHclGeGYlAoHmZDJ8Cj5N2ouJ3GUQjoqk3+/OZTJ1vvqK+vgBh
   g==;
X-CSE-ConnectionGUID: YKubzHABQES10DFDt720Bw==
X-CSE-MsgGUID: 36Qg38EbTO2Z3VRhWX+TIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="70037959"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="70037959"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2025 22:48:39 -0700
X-CSE-ConnectionGUID: Y70vaVOaTQmaogyEpLiArg==
X-CSE-MsgGUID: kCoz8YSkRSKPcWlBXWwDHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="131210258"
Received: from iscp-l-lixuzha.sh.intel.com ([10.239.153.157])
  by orviesa005.jf.intel.com with ESMTP; 30 Mar 2025 22:48:37 -0700
From: Zhang Lixu <lixu.zhang@intel.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	jikos@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	peterz@infradead.org,
	gregkh@linuxfoundation.org,
	ribalda@chromium.org,
	archana.patni@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: lixu.zhang@intel.com,
	even.xu@intel.com
Subject: [PATCH 3/3] iio: hid-sensor-prox: Fix incorrect OFFSET calculation
Date: Mon, 31 Mar 2025 13:50:22 +0800
Message-ID: <20250331055022.1149736-4-lixu.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331055022.1149736-1-lixu.zhang@intel.com>
References: <20250331055022.1149736-1-lixu.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OFFSET calculation in the prox_read_raw() was incorrectly using the
unit exponent, which is intended for SCALE calculations.

Remove the incorrect OFFSET calculation and set it to a fixed value of 0.

Cc: stable@vger.kernel.org
Fixes: 39a3a0138f61 ("iio: hid-sensors: Added Proximity Sensor Driver")
Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/light/hid-sensor-prox.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 941508e58286..4c65b32d34ce 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -124,8 +124,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 		ret_type = prox_state->scale_precision[chan->scan_index];
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = hid_sensor_convert_exponent(
-			prox_state->prox_attr[chan->scan_index].unit_expo);
+		*val = 0;
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-- 
2.43.0


