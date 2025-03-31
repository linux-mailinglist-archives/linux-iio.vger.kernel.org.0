Return-Path: <linux-iio+bounces-17394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C76A75EA4
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 07:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F741681DF
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 05:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34F318CBE1;
	Mon, 31 Mar 2025 05:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f59VyTBK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CE6186284;
	Mon, 31 Mar 2025 05:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743400114; cv=none; b=fUaTT4FacV1tmCHmKD5XTeviV7cUj/pulYaXkJzy8QfLldutUZbsJRCIX/0uTLS1Go1xYlFfyBZEYpvx7rSdKDSLRdcnXGGYHgeF6L0hF6k5J3ImTV9lUJGxXHE+2DnFTtGQNS1zG42dZLB/wZ8e542/DOJCGc46X2ByMsSmLII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743400114; c=relaxed/simple;
	bh=Z4Jw/pv1pRWCpbj5lwRFsIAALyMbcVpCdb4nKmUUlnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlcG9hxB0Z1EvPeMMR6qkLz0dYBti6GbfaQ9xkOvylEBnYQP4mpLHLoHmVeT5W6BB1/tCtBNQx7bFIp1m9bLP9jaEGI6+nIRM+J41M3yDQ5MExToaZgfHcIDPsIARmjM2EgdSlB9Ut9c8jloUi43C0JK6pZIqxgGYC/k9fq8k4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f59VyTBK; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743400113; x=1774936113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z4Jw/pv1pRWCpbj5lwRFsIAALyMbcVpCdb4nKmUUlnM=;
  b=f59VyTBKDrJx//uPPdpASZn9FGF6ZvxCmJNk6GTALi3wXNwfYPUSKjeD
   EybEva84afEaIc50lZ0RIDXrCj1a2+FR0Usms+kXe3M8fkvQRQ0GMFjzD
   kIFWVoqhJqhURKLFJC24RFwqD55YtTDM+zZdlseqXdFhFjZNY80UUCwOS
   XQB/2LRn3Ir0jwMDlkt3YPlwgcFE6RbDgHYaXku1RMhNwvq1EN+JVRdfG
   SlCgjNXnggI+1N1gNFOJDbMD4qiHzT4OFHHoPbyhtGVWyR96cBAUNX762
   amKIs5WqapTrLzgLpISAnd3uEBhrQPSk+YcRCfcTP0HJ7X9seS67A45tL
   A==;
X-CSE-ConnectionGUID: +n+lnO6iQrK++rw3nuZUNg==
X-CSE-MsgGUID: dxqZHC2qTteQBYk6SE+lWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="70037942"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="70037942"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2025 22:48:32 -0700
X-CSE-ConnectionGUID: 386q7bDJSA+tKXs8UlM5HA==
X-CSE-MsgGUID: 6+3zoWTSSHqfFzqkPjlCEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="131210224"
Received: from iscp-l-lixuzha.sh.intel.com ([10.239.153.157])
  by orviesa005.jf.intel.com with ESMTP; 30 Mar 2025 22:48:30 -0700
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
Subject: [PATCH 1/3] iio: hid-sensor-prox: Restore lost scale assignments
Date: Mon, 31 Mar 2025 13:50:20 +0800
Message-ID: <20250331055022.1149736-2-lixu.zhang@intel.com>
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

The variables `scale_pre_decml`, `scale_post_decml`, and `scale_precision`
were assigned in commit d68c592e02f6 ("iio: hid-sensor-prox: Fix scale not
correct issue"), but due to a merge conflict in
commit 9c15db92a8e5 ("Merge tag 'iio-for-5.13a' of
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next"),
these assignments were lost.

Add back lost assignments and replace `st->prox_attr` with
`st->prox_attr[0]` because commit 596ef5cf654b ("iio: hid-sensor-prox: Add
support for more channels") changed `prox_attr` to an array.

Cc: stable@vger.kernel.org # 5.13+
Fixes: 9c15db92a8e5 ("Merge tag 'iio-for-5.13a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next")
Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/light/hid-sensor-prox.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 76b76d12b388..1dc6fb7cf614 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -257,6 +257,11 @@ static int prox_parse_report(struct platform_device *pdev,
 
 	st->num_channels = index;
 
+	st->scale_precision = hid_sensor_format_scale(hsdev->usage,
+						      &st->prox_attr[0],
+						      &st->scale_pre_decml,
+						      &st->scale_post_decml);
+
 	return 0;
 }
 
-- 
2.43.0


