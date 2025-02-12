Return-Path: <linux-iio+bounces-15394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D20BA31EB4
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106873A626F
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 06:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234F01FC7FD;
	Wed, 12 Feb 2025 06:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CM4BJDpj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD6C1FC102;
	Wed, 12 Feb 2025 06:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341525; cv=none; b=V9dYxIRNX3EsjeVEZ2s/ruZBx8snzJntnxv12twF05Ad4VQgnk+joagITvhPIa9QxknO9H6bOvO9Z0MinGDx3hgsCladNWgqQmytVcA3RUGM4AuNd8MKcmRj7tXFNYB2xW6O2APrfI9+NiV0R18wPE/OjXyi52TRfKTKEj+jRtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341525; c=relaxed/simple;
	bh=CqUvbDifXD/ucYfzA400zsDG3CgGw3zeBPPdgNHOUDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V3nabzFbI+OH2ryNeTv6jMcaQE+E47tH+pejt5T0LSp9UzRYHJUKz8pbFZ6EMUWm7cQ9G+1z7gIRTYYdF9vynRAog1q58Vaz5k9zuUJ+VQ/xDfUsXKs04FG1XfW65hn3uzQ9k6siihRCnJhOWp8PWja3HtKqp6mztvUE+njBIoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CM4BJDpj; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739341524; x=1770877524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CqUvbDifXD/ucYfzA400zsDG3CgGw3zeBPPdgNHOUDA=;
  b=CM4BJDpjjo/CZACWkyn+NZklRMjlVvemPoqo8bwGgKaGpqJb0gRrAH9u
   XmTU0i2lX9JE8AGScE/LXndUSvvx8VI+40uZzsu+IzSfFs1udjZ7KIKUb
   O/3HsVeAb48zsIXZN5pnAfPo3PEuBHSt2iVt+D0Rj9FW9XFjMbiMKFkYc
   ugb1vKEAl6wwIoNtXonNdy2CBUqGleG9ufXjRsCOqTf28Ig+CIZzUC5h6
   cPs29VPxPRVLrxa/d6y69VDxK1GFcA4hivBUR1DV2FulespOMiP1vGA+K
   /JO9maktkP6DiUbL7z+XPhVNffnM9amFk4vndIfvY8Uzo9SjdQWegrPAU
   w==;
X-CSE-ConnectionGUID: CqMve8XVRni5ZJYqXocpUQ==
X-CSE-MsgGUID: pV4sqS7UR8aW42VHgfVz+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40005152"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="40005152"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:25:24 -0800
X-CSE-ConnectionGUID: M+WdjWQGTiyJRhxF4v7kZw==
X-CSE-MsgGUID: sHXsn5zARjS8h6YiZD8jnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="117811953"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa004.fm.intel.com with ESMTP; 11 Feb 2025 22:25:20 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	dmitry.torokhov@gmail.com,
	jic23@kernel.org,
	przemyslaw.kitszel@intel.com
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v5 01/12] err.h: move IOMEM_ERR_PTR() to err.h
Date: Wed, 12 Feb 2025 11:55:02 +0530
Message-Id: <20250212062513.2254767-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212062513.2254767-1-raag.jadav@intel.com>
References: <20250212062513.2254767-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since IOMEM_ERR_PTR() macro deals with an error pointer, a better place
for it is err.h. This helps avoid dependency on io.h for the users that
don't need it.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 include/linux/err.h | 3 +++
 include/linux/io.h  | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/err.h b/include/linux/err.h
index a4dacd745fcf..1d60aa86db53 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -44,6 +44,9 @@ static inline void * __must_check ERR_PTR(long error)
 /* Return the pointer in the percpu address space. */
 #define ERR_PTR_PCPU(error) ((void __percpu *)(unsigned long)ERR_PTR(error))
 
+/* Cast an error pointer to __iomem. */
+#define IOMEM_ERR_PTR(error) (__force void __iomem *)ERR_PTR(error)
+
 /**
  * PTR_ERR - Extract the error code from an error pointer.
  * @ptr: An error pointer.
diff --git a/include/linux/io.h b/include/linux/io.h
index 59ec5eea696c..40cb2de73f5e 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -65,8 +65,6 @@ static inline void devm_ioport_unmap(struct device *dev, void __iomem *addr)
 }
 #endif
 
-#define IOMEM_ERR_PTR(err) (__force void __iomem *)ERR_PTR(err)
-
 void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
 			   resource_size_t size);
 void __iomem *devm_ioremap_uc(struct device *dev, resource_size_t offset,
-- 
2.34.1


