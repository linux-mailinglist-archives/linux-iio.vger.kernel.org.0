Return-Path: <linux-iio+bounces-17393-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D46A75EA1
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 07:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143EC3A8C28
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 05:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BF11531DB;
	Mon, 31 Mar 2025 05:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhhS738x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1393C30;
	Mon, 31 Mar 2025 05:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743400112; cv=none; b=XRI/NknC2Z8eOK9LrdXxpQqENS4YX+TFcxPZSF1lQ/QAx8GmXBpQc/Y7HejzMmMfj3MQJD4XxLDJHyAMNqFlB7DA7vGv1tNG1lmEWINXtMKSZ7vAlR8yXj8jldWJke9T6bZNL7Ld3j4A/q3M5k/K/dW937zcySF6rzK599cncxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743400112; c=relaxed/simple;
	bh=+z6BKO0KrNVrb888EypYc7qFtlG1de0BKd3iM66kRgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hH1ynIcUGTijwEHUODuvZwBGvgljPtNcrrth8KkHPqbvb3qMUicK7LHMx26xnDblrFzMTs8ZvM+8OXdoiuV+gu0R4Y/IKjWoH88ixqMxdNYLPjQo89YHlcIFM/v8igFFppK9xb+BzWM1HXRwglp5Q/4yLfckL9MUNpkW3rRgW60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhhS738x; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743400110; x=1774936110;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+z6BKO0KrNVrb888EypYc7qFtlG1de0BKd3iM66kRgk=;
  b=FhhS738x5SwFpOkkVEIXOaxdBdvjeU6Nyu0KUm1dTwRMT2BA/uxZroLL
   sG7F8bUkefDVJuo1boqv4rf2lD747sYw38NKOQh+iK51cSX3GmAxyW0Fd
   yhL6dImsQGLTE1QwN0S6q2d+xjB8ItS+GDdaOt+Sa/voRO8Hk+Wxwt99d
   JyILXBnDT6PSGUWC/yUzM7nZGfypoxGrqHiQ9I1biFkDBJEU85rd99PHn
   KZeOutzBBiyjtidl0NazOGFCe8GorGhjGvrTMs3rrf9fkjIHewWAmW8NI
   4+pJPH2X5mAud1qM6LMvlzcHxlKw8/ngLmKizg+LrjJVEf+AWIDnvUub5
   g==;
X-CSE-ConnectionGUID: XDPBJeDsSQaWxpF/vM2Kiw==
X-CSE-MsgGUID: 24Qklf9qRimkaQYJhaJ1jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="70037935"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="70037935"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2025 22:48:29 -0700
X-CSE-ConnectionGUID: JI4Kpp3uTbCfE85+xH0+0g==
X-CSE-MsgGUID: mIj2hkOlQhOq4uFEVj3I8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="131210200"
Received: from iscp-l-lixuzha.sh.intel.com ([10.239.153.157])
  by orviesa005.jf.intel.com with ESMTP; 30 Mar 2025 22:48:27 -0700
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
Subject: [PATCH 0/3] iio: hid-sensor-prox: fix SCALE and OFFSET calculation
Date: Mon, 31 Mar 2025 13:50:19 +0800
Message-ID: <20250331055022.1149736-1-lixu.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses issues in the hid-sensor-prox driver related to
SCALE and OFFSET calculations. The changes include restoring lost scale
assignments, supporting multi-channel SCALE calculation, and fixing incorrect
OFFSET calculation.


Zhang Lixu (3):
  iio: hid-sensor-prox: Restore lost scale assignments
  iio: hid-sensor-prox: support multi-channel SCALE calculation
  iio: hid-sensor-prox: Fix incorrect OFFSET calculation

 .../hid-sensors/hid-sensor-attributes.c       |  4 ++++
 drivers/iio/light/hid-sensor-prox.c           | 22 ++++++++++++-------
 2 files changed, 18 insertions(+), 8 deletions(-)


base-commit: e21edb1638e82460f126a6e49bcdd958d452929c
-- 
2.43.0


