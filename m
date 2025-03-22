Return-Path: <linux-iio+bounces-17198-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D69FA6C804
	for <lists+linux-iio@lfdr.de>; Sat, 22 Mar 2025 08:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86AA3B71F2
	for <lists+linux-iio@lfdr.de>; Sat, 22 Mar 2025 07:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADB018DF9D;
	Sat, 22 Mar 2025 07:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIifGzt+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554F326AF5;
	Sat, 22 Mar 2025 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742627489; cv=none; b=EyWKFEke58Mx+voC6fYTMWsLCvtMyKKkSwjB3cL6FkKFCnk7iK77+/auDAiwjNbqqwXco3fGZT0aVv4MFPYVrZhrVxq8UWZK47aTjNB6VpOojOUmEPNsP82dFTi+vQ0yRrx6ZANNHDflG+S8YgE6LNku3ck1ukmdpRF+nCX37Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742627489; c=relaxed/simple;
	bh=2ZExNTZl1qJyCZJBe95qp5K+HMTKoLjY8be7/+U4a+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NK2f3QXRm/tktC7lyzLdezFO04HZmss2fSgbi8xGnYRN2zbm8VG0wG7dfS9FuJ5Sme9qWkVAC3Zl7+2ecEHMAGeZ8pDr2zST1Evcm6rRrzyeSW9JnY8LF/zEAyMg9d4bL9lr8n41hNghPoSIhkVeKHB5vVWwJP5pVOVzwmz4/B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIifGzt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD459C4CEDD;
	Sat, 22 Mar 2025 07:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742627488;
	bh=2ZExNTZl1qJyCZJBe95qp5K+HMTKoLjY8be7/+U4a+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NIifGzt+DJxbRmn8nemrQWHVsnx/9GVd5zIHR/cyNEELYW2dIy73hen+2ljsj5mTW
	 aVNGFkE6+HrIIBwB9PV5UCJsz169+0/516OMbL2rXMpgYbBh61VEJfsPVS9zafOkDU
	 +oXYYrY085vorSi7HORVasTAMJx/bfICyVhPiIQYevtwO3LprBX6LfliW0+ue4plCT
	 eklC1eTQbdwguNiXXosNhLfH8HdkWg0qb4hDDl1hZfPjtLvbvgqCWbuZ1+ozQpNe4d
	 avSA8ar+fY2UocfJ4ys2m5fHlg51Er5hsCgKhbChTdaHIPGgGLmtk0KHdF57uQ0Tit
	 Tp+Z6bpP71sRw==
Date: Sat, 22 Mar 2025 08:11:23 +0100
From: Ingo Molnar <mingo@kernel.org>
To: david@ixit.cz
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Subject: Re: [PATCH v3 5/7] x86/Kconfig: Document CONFIG_PCI_MMCONFIG
Message-ID: <Z95im-uBoWJHmoX7@gmail.com>
References: <20250321-x86_x2apic-v3-0-b0cbaa6fa338@ixit.cz>
 <20250321-x86_x2apic-v3-5-b0cbaa6fa338@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321-x86_x2apic-v3-5-b0cbaa6fa338@ixit.cz>


* David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org> wrote:

> From: Mateusz Jończyk <mat.jonczyk@o2.pl>
> 
> This configuration option had no help text, so add it.
> 
> CONFIG_EXPERT is enabled on some distribution kernels, so people using a
> distribution kernel's configuration as a starting point will see this
> option.
> 
> Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
> Signed-off-by: David Heideberg <david@ixit.cz>
> ---
>  arch/x86/Kconfig | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index fbc9ba30fd1cbfb574399a0632b9f77876ba84a8..64a1e00619df95f559488e3004558a7b0f653df3 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2914,6 +2914,19 @@ config PCI_MMCONFIG
>  	default y
>  	depends on PCI && (ACPI || JAILHOUSE_GUEST)
>  	depends on X86_64 || (PCI_GOANY || PCI_GOMMCONFIG)
> +	help
> +	  Add support for accessing the PCI configuration space as a memory
> +	  mapped area. It is the recommended method if the system supports
> +	  this (it must have PCI Express and ACPI for it to be available).
> +
> +	  In the unlikely case that enabling this configuration option causes
> +	  problems, the mechanism can be switched off with the 'pci=nommconf'
> +	  command line parameter.
> +
> +	  Say 'n' only if you are sure that your platform does not support this
> +	  access method or you have problems caused by it.
> +
> +	  Say 'y' otherwise.

For future reference, the canonical incantantion in Kconfig lore is:

	  Say Y otherwise.

I have fixed it up in this commit.

Thanks,

	Ingo

