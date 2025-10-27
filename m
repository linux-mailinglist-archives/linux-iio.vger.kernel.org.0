Return-Path: <linux-iio+bounces-25482-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2581DC0E9BF
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609B53A9B7B
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162F4308F18;
	Mon, 27 Oct 2025 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILwA7fWo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7915F1EEA49;
	Mon, 27 Oct 2025 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575939; cv=none; b=FJEe+9r672COeq26eXnoeyNYi6X2FgzqF2tASkCMndqKUu7AqYHV39jgeLl9f4GpnL1zqc/T33DGdW0VkK7k/l8BGQlBcWIn5QyQKjP4sqBThbMePMoyz1SS2re+9ty8kYdbq/iSrs/C2k39/Rpc1LH+S549nZlVUCJJSZ7uCkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575939; c=relaxed/simple;
	bh=oUfIDPQuCs+t9kq5MFosiEl5lenf5ewFglNhdf9s7dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APkgDZB9LyzK7PsvwlP10QO/O7QmNPsHtNSUasdjKZcnz+ntaXmbuNVvHIPI+0T+0WbKt0lSu1Mem0faY8hcc0K7I880r9vOUDnJ13F4vytageRoN1gMKmKGT7WiL/8VHSU8Sg8fcQv234KW66hMDAod3+6zVLc4XUbLh5cLh14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ILwA7fWo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761575938; x=1793111938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oUfIDPQuCs+t9kq5MFosiEl5lenf5ewFglNhdf9s7dU=;
  b=ILwA7fWohONxEHllCk98qxFS09E8jHA4ajX/fObxoke8U/lWMhuYevve
   OEcr8Trs3po8DSmKtpbvEiy6DV3mUpEpG4y6r/1Tz+362rWSJMuoaKjoh
   jG20YkUktSEcOmIzrrJVdSvLDq7C752SjrTJpP5/wJIKnZNi+PL17U31q
   4/iPISMHhGJEIzNNTFRgB4mEUmAmQssbeXajyBnAuFum8XpRHFVS86ZrN
   Cxvo8WCZGskfVksWWohhRF//iN8SaFRvi8POQIXNsJQwhGMVpsl2GgOnP
   g62Hr33Y3UJG8UdQ6rCCuBiJMf3FEUxkzsCevdkeB3c7CreLCoItgvP+g
   Q==;
X-CSE-ConnectionGUID: ilLLNH+IRTmqNrVj9RgQNQ==
X-CSE-MsgGUID: N2LC3F8FT0CXVMDjosf3UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63544484"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="63544484"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 07:38:58 -0700
X-CSE-ConnectionGUID: bwRtepJLTQmjXFhCZPBPEA==
X-CSE-MsgGUID: k/kDqoV8QJanoi+0cv9cEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="189095714"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 27 Oct 2025 07:38:54 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5114297; Mon, 27 Oct 2025 15:38:53 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Subject: [PATCH v1 2/6] =?UTF-8?q?units:=20Add=20value=20of=20=CF=80=20*?= =?UTF-8?q?=2010=E2=81=B9?=
Date: Mon, 27 Oct 2025 15:34:51 +0100
Message-ID: <20251027143850.2070427-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>
References: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There are a few drivers that want to have this value, and at least one
known to come soon. Let's define a value for them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/units.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/units.h b/include/linux/units.h
index f626e212d4ca..82bdc2041328 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -21,6 +21,9 @@
 #define PICO	1000000000000ULL
 #define FEMTO	1000000000000000ULL
 
+/* Value of π * 10⁹ */
+#define PI	3141592653LL
+
 /* Hz based multipliers */
 #define NANOHZ_PER_HZ		1000000000UL
 #define MICROHZ_PER_HZ		1000000UL
-- 
2.50.1


