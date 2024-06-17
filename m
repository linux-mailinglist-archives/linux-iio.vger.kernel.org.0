Return-Path: <linux-iio+bounces-6343-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC8890AA99
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 12:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635631F2121F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 10:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784751940AB;
	Mon, 17 Jun 2024 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TXfbg8gC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CA8194092;
	Mon, 17 Jun 2024 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618556; cv=none; b=s/UJ3ZNfMP9GqUj7TMFE/GtfaB3R67XZ1A0NPwoVCb2DYILAOGNBy3EdcDofOgYvicgv3ZmaenJ1d/0e02ioO8ACvu55aNchYP1FzZGpOOmZlohnlPk7qA60EJ5RHNxzvTJOik5zt7T6VDd204ENG6m4Cqf2KndZBwTnPimMsXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618556; c=relaxed/simple;
	bh=5ucFmytPGWUITdYIUNvYuJbY8zzIT+lAWia57YkFvQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ajq7kUaxZWEaQ2FpFfNYU9FdPATHRSB/u/RZcXrTTXkCHByrE80MBkmRRWpBe5YWi+1WrkSCPzCTK8gxNEWlczdRY9lbqSciBD94lcD/W3DnSPPsvAyl1X3jJePbQpO5v6LCvo43bbZ/rb1yY8AskxrSPiTwBTgWGi/A/eRvWs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TXfbg8gC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ABDC240E021A;
	Mon, 17 Jun 2024 10:02:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id p-SwtidTbXwT; Mon, 17 Jun 2024 10:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718618542; bh=hk8qAv1xkelStwfpGcnWoiVIdVGUKqufug9abuox7ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXfbg8gChJROKcS7Y/Q95/XP3hPTOGtUQG9RULQxSAPp/U31ELpExyR7R2eP6JvPv
	 GBo/JMTUPKJkzBmwfvqv3Aa/OHmtphGUF5ObrfG0KD6KN/uxUNCGaFKX/toaaPmocK
	 dUruAb5F/VIBChTG3m2nmJRfiI+pJLYYTnNAVP86hIqUJQbLnIjXor7z6r8JsOWymw
	 +zP7yAp+bxNprgPOZYlLabLJOC+mA1IKIsZ15Ws2UtxL0uWgf/dYDonpJ+c9zA3MnI
	 KtB0BfSYZgSXDdgBumPTd69RR6BEC07BGeujoaoetOGsO6aXSDtqfUqgJ8IZdx3VXK
	 bE/EAEhvtfRiy1hhkwI5VkZhHfhA88mlCAjWL3OWlao+ZQceZvRnrDiOpvPskzytIl
	 dR/2Ttih6SHsZR7ZY6qU2rBTgc2cFyl1BJTz53XnjswrTPrIMv6d7MnlWZ/IWHN5rZ
	 JfviQAn9l4hwngIfPd6YcRZVzp6Y93p0TAmsxRtBobXqiWP0emeMZV6i1St+lKRzsO
	 FCl39wI/2EuMIbvWDVPxd49vkTXwgTLK5WYfUjDQPQN5bxDD5rYjIRdG0iFTXst0Y/
	 3/3ywFM9g6Vor4KD6CyKgeLMCuqNBLfro21rP6XXFx+k7Z4itqZLgT5WJ7Xm3KbrWM
	 jGWNxY3vqsz4yn0YbfBQH0I4=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 156CB40E01F9;
	Mon, 17 Jun 2024 10:01:56 +0000 (UTC)
Date: Mon, 17 Jun 2024 12:01:50 +0200
From: Borislav Petkov <bp@alien8.de>
To: Zack Rusin <zack.rusin@broadcom.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Alexey Makhalov <alexey.makhalov@broadcom.com>,
	linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
	lkp@intel.com, zack.rusin@broadcom.com,
	dri-devel@lists.freedesktop.org, daniel@ffwll.ch, airlied@gmail.com,
	tzimmermann@suse.de, mripard@kernel.org,
	maarten.lankhorst@linux.intel.com, linux-iio@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, nuno.sa@analog.com,
	dragos.bogdan@analog.com, anshulusr@gmail.com,
	andrea.collamati@gmail.com, oe-kbuild-all@lists.linux.dev,
	x86@kernel.org
Subject: Re: [PATCH 1/2] drm/vmwgfx: Fix missing HYPERVISOR_GUEST dependency
Message-ID: <20240617100150.GDZnAJjoH5wZKu2OAV@fat_crate.local>
References: <202406152104.FxakP1MB-lkp@intel.com>
 <20240616012511.198243-1-alexey.makhalov@broadcom.com>
 <20240617090709.GCZm_8vdnLzt048UH_@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240617090709.GCZm_8vdnLzt048UH_@fat_crate.local>

On Mon, Jun 17, 2024 at 11:07:09AM +0200, Borislav Petkov wrote:
> On Sat, Jun 15, 2024 at 06:25:10PM -0700, Alexey Makhalov wrote:
> > VMWARE_HYPERCALL alternative will not work as intended without
> > VMware guest code initialization.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202406152104.FxakP1MB-lkp@intel.com/
> > Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> > ---
> >  drivers/gpu/drm/vmwgfx/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/vmwgfx/Kconfig b/drivers/gpu/drm/vmwgfx/Kconfig
> > index faddae3d6ac2..6f1ac940cbae 100644
> > --- a/drivers/gpu/drm/vmwgfx/Kconfig
> > +++ b/drivers/gpu/drm/vmwgfx/Kconfig
> > @@ -2,7 +2,7 @@
> >  config DRM_VMWGFX
> >  	tristate "DRM driver for VMware Virtual GPU"
> >  	depends on DRM && PCI && MMU
> > -	depends on X86 || ARM64
> > +	depends on (X86 && HYPERVISOR_GUEST) || ARM64
> >  	select DRM_TTM
> >  	select DRM_TTM_HELPER
> >  	select MAPPING_DIRTY_HELPERS
> > -- 
> 
> Right, I'll queue this soon but it doesn't reproduce here with gcc-11 or gcc-13.
> This must be something gcc-9 specific or so...

Actually, that's a DRM patch.

Folks in To: ok to carry this though the tip tree?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

