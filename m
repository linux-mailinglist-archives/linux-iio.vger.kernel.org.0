Return-Path: <linux-iio+bounces-6341-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5F090A913
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 11:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3277B288730
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 09:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAAB190682;
	Mon, 17 Jun 2024 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QYpkpTSL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B2018FC62;
	Mon, 17 Jun 2024 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615258; cv=none; b=APd4VNSTFImcm/LCuh1nKIcb0p8hKHYL5l1gUGDE0TmgLy29Yes9j+99A7R/S8PVu7dx3tKRkhiGUxfjJXDfXnZ1DCInnyzPkAXr3BccivT7nMxxAf/wYryRLYZNDtmx+zBAUlh1U6QBeTjWUUoMqtQ+wt+US96i7ZpIg3qFG8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615258; c=relaxed/simple;
	bh=Xx2pWqd6Wp8LkFDZOeC38gYVqhsf2QBGpDi7k0VBy0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuwdqO3khH8eBmM8Mv7h0gfAa4Zy/RV4Ap3c0NRG5y3uXvHcRdwX32UbV4lPkheNOFFMB1OjRsfO+N5Ri2QHqQcFs/tnr7wJe1gR2bmOyIOf3eQJjCbcUWSRlbwWvtGFSLfWAfENQ6fWZIkRqUc4TtIVB0HmRBeHa1o7eccsWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QYpkpTSL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9C66C40E021A;
	Mon, 17 Jun 2024 09:07:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1tYAHRnnhZSf; Mon, 17 Jun 2024 09:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718615250; bh=93xF8rs/wjUBEtgEpr7tQlOJPFf9+opilZV8ptie4Nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYpkpTSLgrvpPrAlswZow//AsuYEbjjinUWC6nd+33iSCUPXVBEK6Bm+ADDGt8SOr
	 9+KRcgxd98dvGPGZujaLX9P43PnI5sSmATt/vbrB1AT2Nf+UoDIhsaq1jFUn2DFh4G
	 gixf/Mi5guPsTEd0WOhByPMkXvSPq5dt+NrTiXXrQTXZFAJDfVKheIjeWiPW2fBDUz
	 F3qWxu1Jix4hqPCpDS6/KDXKCtAXNHA5A40knsMCmRe3FfdxRUnTXC4nLjKjdt1Fop
	 Ze6K1lG99XciHmbe3TlgCo5pVTggFz3+gv6zCmJtSJ8xbtIx2PDg6e8ioRurxuZe7G
	 y+2Gt6shUrTVKk/qLODYcvuHYFSZyrSz2yFmWgZVQ4ntDb1EW9sYjpSf4djUWZjYYf
	 Qqg9uARa6aSctTJnZRX9dwvA2Kl45w9U9xeJFrLoKVo36unxH6Zf9Svv+Ni4D5fReR
	 sD234aIcj4HDXg2HjFHiRozMncHHDCEQ++yrYANZh6CCoA0OszwUxM2G+/Ppjy8x52
	 zg7exTPy2qvSrkmmc28fW5DZ95qKngBfUUSKtAR6cJNCVPXSIp/dNOvjqFMnBlhouJ
	 FQi8Yras4bbiKF+s3UKeA5OKq/9XOKFp6Am+w6STS/vLJI3gYhJHB5of8NwOJg2zXM
	 6+Mkc7YxiePNigshZMmLeQjI=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A241040E01A5;
	Mon, 17 Jun 2024 09:07:10 +0000 (UTC)
Date: Mon, 17 Jun 2024 11:07:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
	lkp@intel.com, zack.rusin@broadcom.com,
	dri-devel@lists.freedesktop.org, daniel@ffwll.ch, airlied@gmail.com,
	tzimmermann@suse.de, mripard@kernel.org,
	maarten.lankhorst@linux.intel.com, linux-iio@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, nuno.sa@analog.com,
	dragos.bogdan@analog.com, anshulusr@gmail.com,
	andrea.collamati@gmail.com, oe-kbuild-all@lists.linux.dev,
	x86@kernel.org
Subject: Re: [PATCH 1/2] drm/vmwgfx: Fix missing HYPERVISOR_GUEST dependency
Message-ID: <20240617090709.GCZm_8vdnLzt048UH_@fat_crate.local>
References: <202406152104.FxakP1MB-lkp@intel.com>
 <20240616012511.198243-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240616012511.198243-1-alexey.makhalov@broadcom.com>

On Sat, Jun 15, 2024 at 06:25:10PM -0700, Alexey Makhalov wrote:
> VMWARE_HYPERCALL alternative will not work as intended without
> VMware guest code initialization.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406152104.FxakP1MB-lkp@intel.com/
> Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> ---
>  drivers/gpu/drm/vmwgfx/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/Kconfig b/drivers/gpu/drm/vmwgfx/Kconfig
> index faddae3d6ac2..6f1ac940cbae 100644
> --- a/drivers/gpu/drm/vmwgfx/Kconfig
> +++ b/drivers/gpu/drm/vmwgfx/Kconfig
> @@ -2,7 +2,7 @@
>  config DRM_VMWGFX
>  	tristate "DRM driver for VMware Virtual GPU"
>  	depends on DRM && PCI && MMU
> -	depends on X86 || ARM64
> +	depends on (X86 && HYPERVISOR_GUEST) || ARM64
>  	select DRM_TTM
>  	select DRM_TTM_HELPER
>  	select MAPPING_DIRTY_HELPERS
> -- 

Right, I'll queue this soon but it doesn't reproduce here with gcc-11 or gcc-13.
This must be something gcc-9 specific or so...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

