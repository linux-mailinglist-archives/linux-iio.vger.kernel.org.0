Return-Path: <linux-iio+bounces-6312-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A54909B16
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 03:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517BA1C20F4F
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 01:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9144A154C19;
	Sun, 16 Jun 2024 01:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IpwdFEWc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D8713A3ED
	for <linux-iio@vger.kernel.org>; Sun, 16 Jun 2024 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718501139; cv=none; b=RJpJYznCDYTVr2CTV/hBkI8oXfxR4c7IjWHbnEvnTg5sjIRVk8z+XuWFVPu8u2aI1FHx3h097PUc0TwLF71OnH9mlYAZJQlfKz4Vc0JyrttE0UPltN5PbQtPwe29u2bphraV72xqHjyYQUg78Y9XAWwg1ll3LFMStzqwTVqiOxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718501139; c=relaxed/simple;
	bh=JHe8PmT8CAiOYlGo1cndu3zZ4OloPw3FeLHc2NnF29Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lxw55NrOMWvaJT3eNQXVYnDDhlEy5B8HPQ0uv7Hhtr5BNZGGjesprM79QZsswpOu88+FeOz+SwKO1BH+fnfdmETE3I5xmatitpZB6u/zieDCs0Xq60sIV+wDe0EgBeRYNy2Em/96t/eW82S9ue1y5nuO2+kMY2F7KwfjCUsszok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IpwdFEWc; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-797b24b8944so292179785a.0
        for <linux-iio@vger.kernel.org>; Sat, 15 Jun 2024 18:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718501137; x=1719105937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmh7B10VjitCXi5UnMX7IBHWWNFhALchrxl9IDbnSME=;
        b=IpwdFEWcmhtqCuDAJySqs0o61HabJmdtHdIP50TwjkjLmvdg2V4I1TWgElm/9QCJjV
         gdiAQSnwlz3g0y5dlFUctsolxw+Dz2G2zVTD5j5urms5iBosxPc9EY4lWFvp/u2tqBXh
         E38I51S1z2ZsMmy73JSNUjBJh95HDvZ2iyvbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718501137; x=1719105937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmh7B10VjitCXi5UnMX7IBHWWNFhALchrxl9IDbnSME=;
        b=rzKrYfI6D179mqsAGwvsJYwSzIiP5aT8/cigfWe6e2NKmX2Kxx8GjAxcP0En6N+URD
         aJUQfMePl0a4kGmkNTM+Z/y8qjWeqNNe4hJJ/W9rlcNfHVDJCEv4UH3v7Mrb5atpzlfo
         2c4CBnQNI2Km80xxsL+VJhSmuMzwuhv/1z+zo7cnWFuvoIevoTaogAJGovPbzSLl5E2k
         ekBZ1FHXHPQe0GCrOI6Zidz1ADfjqMXVmuyXpNE7ebd3ZAwwQA2isl+Xb02TDk7yxAL/
         JS+txZwgqD1C2elQtlVOEFVGXZp/Rlyk/cRAIG0my5Qe4XDKN4mTBkKQJDrmVnMIYsWo
         m4hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtxBUCAfCozux+VBMtbjtIJDZqyY9GZYm4PBRUcFQbkGd369cvrtayp3B+CSkFzhgL+t2he9DDYN07AluEMvzDmvzw2KkKcYge
X-Gm-Message-State: AOJu0YxGyOR1CRlqIKvdRdg8g1YsL56zhcXrMvTxbY/E73Y9PZwRVlBX
	KF4WJFnSjt8FiBHAxtjfWr9M2q6yHXBgL7pmjRMVHDFkOmdLK3j6M8Z0NLRYOA==
X-Google-Smtp-Source: AGHT+IF3o2n1vuAWzivHA2bQV4+Plh7YsZ6B36O+Td3GL1zNvsydHY+4muaeP2QpJFgYTbtdwi7YNA==
X-Received: by 2002:a05:622a:130a:b0:43a:b542:d1dd with SMTP id d75a77b69052e-44216af8850mr64153021cf.36.1718501136510;
        Sat, 15 Jun 2024 18:25:36 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f310dae0sm32256121cf.97.2024.06.15.18.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 18:25:35 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	bp@alien8.de,
	bcm-kernel-feedback-list@broadcom.com,
	lkp@intel.com
Cc: zack.rusin@broadcom.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	linux-iio@vger.kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	nuno.sa@analog.com,
	dragos.bogdan@analog.com,
	anshulusr@gmail.com,
	andrea.collamati@gmail.com,
	oe-kbuild-all@lists.linux.dev,
	x86@kernel.org,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH 1/2] drm/vmwgfx: Fix missing HYPERVISOR_GUEST dependency
Date: Sat, 15 Jun 2024 18:25:10 -0700
Message-Id: <20240616012511.198243-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <202406152104.FxakP1MB-lkp@intel.com>
References: <202406152104.FxakP1MB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMWARE_HYPERCALL alternative will not work as intended without
VMware guest code initialization.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406152104.FxakP1MB-lkp@intel.com/
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/Kconfig b/drivers/gpu/drm/vmwgfx/Kconfig
index faddae3d6ac2..6f1ac940cbae 100644
--- a/drivers/gpu/drm/vmwgfx/Kconfig
+++ b/drivers/gpu/drm/vmwgfx/Kconfig
@@ -2,7 +2,7 @@
 config DRM_VMWGFX
 	tristate "DRM driver for VMware Virtual GPU"
 	depends on DRM && PCI && MMU
-	depends on X86 || ARM64
+	depends on (X86 && HYPERVISOR_GUEST) || ARM64
 	select DRM_TTM
 	select DRM_TTM_HELPER
 	select MAPPING_DIRTY_HELPERS
-- 
2.39.4


