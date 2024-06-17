Return-Path: <linux-iio+bounces-6430-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF98490BCCE
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 23:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4C91C21BEC
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 21:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE82199381;
	Mon, 17 Jun 2024 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UM8T/G+l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2559199250;
	Mon, 17 Jun 2024 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718659112; cv=none; b=DbnEJFhNDDmjEa6F0DtBacrQZ3nPcrpuqg+tyUvqUGnRFpJhs/d2JSuQSfbvZVEucbgoYlx+3IEW1Lxw0jRSDtt15JZGBlpWRxxFD5JFcPbumpa0At5LWGeqNLpNmJaOwE+L3I2AQS/izfp8hG7L1FLd21vG8A8ePCiEvpHLfcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718659112; c=relaxed/simple;
	bh=W5rBoTuXPRCST+ZPRx9kVTvjgC7klXt/2ifotpzvINY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHuUMzPHUX7dJViRMehbjoVt2tNcVH9VPRkrIULkuO63jmYUBx+oc2diBLPcFIOWelFsT5jkeRfbMKfUTBBpIaeE1AElOgSUcH3+iyriO3L9Y7Igx8/lvKEYKEEwkJos8lM8UgAnUaIU/D6b6Roh285LcjRAC+LHtNuLWQrJLp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UM8T/G+l; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 73A3D40E01F9;
	Mon, 17 Jun 2024 21:18:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tde_eHHVuoG1; Mon, 17 Jun 2024 21:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718659105; bh=yK+oTJoi5DGuEHt6jESCPtqmrBbsMm4vga3QYTDWOxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UM8T/G+lPTeB4SuRGoE9vf9I0FOvyUQYpL1yVCD9HjVhLj3m6C9Px/9ZAaCG3oD9r
	 7GNAh0JUIAYea7bhql07cHV4dy7cg4qq1KsW+KGO3fkl41zA+tu3W+AyfTL8EkS865
	 Geg/Tl0Uoy5Uru/g1xSLXiHlZ7wKhnjK5kXtfeE4Xt8xmDG3qn9uX96v0Zvc0jKdj8
	 nQZ0omgR81Zf4qk9Jc/q4x9DOuPCoj+Y+OiLyCk95I8JTQ1g2b7zQ7uE0A7nTRFdAw
	 xdHSIhxRABsU5W5jPbFXRk++KLT3cysJwxZj8Npn1S1kPtEnzrqMMsPD7ilEFMF6Pj
	 uL212OxyfMOFSX8pnLYfuSWIB3NLrASeQBTTN5/+SUF0fMP/NZUsfWc6f7I3rOZ9hA
	 dGwTvdoT4jHyq/hJ5HxV97DYtJI/hxvXvFTv8g3XhDl63gqx3Rbdz52juifyYrycjN
	 V3Tr6oX9GkotHVirBjsLg8XZgA6nOWUOWovabnqKFpSWBJI1GOlgEkfeQuIaO0vwK2
	 qAQUwBnGHKYEb9CZYXJfTi95JVErV6fUHDHj911kk9KF68/TdALRWEGR5XXGsV5FxI
	 gOmnUB/5NcsdYd4qKHxKveeHHSSZNZUG1j8hAymip8/kS+5pXjo2KrJsh9No6ALasN
	 2wfhgOcsSqKNmIrzdJN9Hz0w=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EAB3E40E0185;
	Mon, 17 Jun 2024 21:18:04 +0000 (UTC)
Date: Mon, 17 Jun 2024 23:17:58 +0200
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
Message-ID: <20240617211758.GKZnCoBvT2enGx5p5r@fat_crate.local>
References: <202406152104.FxakP1MB-lkp@intel.com>
 <20240616012511.198243-1-alexey.makhalov@broadcom.com>
 <20240617090709.GCZm_8vdnLzt048UH_@fat_crate.local>
 <0a29389e-8ba2-48c5-bb26-381de58a62fb@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a29389e-8ba2-48c5-bb26-381de58a62fb@broadcom.com>

On Mon, Jun 17, 2024 at 01:51:23PM -0700, Alexey Makhalov wrote:
> Not really a gcc related, but the matter of a config file. It is
> reproducible if CONFIG_HYPERVISOR_GUEST not set, but CONFIG_DRM_VMWGFX=y.
> And this combination was allowed before the fix.

Using their config:

$ grep -E "(CONFIG_DRM_VMWGFX|CONFIG_HYPERVISOR_GUEST)" .config
# CONFIG_HYPERVISOR_GUEST is not set
CONFIG_DRM_VMWGFX=y
CONFIG_DRM_VMWGFX_MKSSTATS=y

$ make ...

  OBJCOPY arch/x86/boot/setup.bin
  BUILD   arch/x86/boot/bzImage
Kernel: arch/x86/boot/bzImage is ready  (#2)
$ gcc --version
gcc (Debian 13.2.0-25) 13.2.0
$

So no, I can't reproduce with my compiler.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

