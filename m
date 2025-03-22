Return-Path: <linux-iio+bounces-17199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08C5A6C80B
	for <lists+linux-iio@lfdr.de>; Sat, 22 Mar 2025 08:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D45417C225
	for <lists+linux-iio@lfdr.de>; Sat, 22 Mar 2025 07:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925891ADC86;
	Sat, 22 Mar 2025 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENEYF2Rn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503D018A6D3;
	Sat, 22 Mar 2025 07:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742628542; cv=none; b=gxHrF4oUHj9wRrJVKw9Av7rqR107Tokhdrjwp0tJRkVf8bkzB/oIkGrUpHC793rxLFuV2GQXjmGNMRfUE2il/6/a1/jdbOQVhyL1TAgtoQ2zsgjRbhyIryYdBvaGm+HcaYTuYHsiLypVdb8C+0sUwy1GGxHtZlKwA2pk0iP9gfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742628542; c=relaxed/simple;
	bh=8KQ5iiw5zSx3Kwqm+V4tw6kGTtVvzAUfJdYNkPur63U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6PRIGtSWwZhgsF886/BQcaOJfKGwbIu2st9n76DQkrwapUrhYxw9eieyuapCgobvbrYICaDtgrx+82Yn28exUZJlh4pf+n+z/NW1w9CqwoYKPi7vFqdKCcWN1BxPO3KqMDCt1cPL9Ca2MOD/XBMXZtAlNrkqg9XCrOilxdCYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENEYF2Rn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19CFC4CEDD;
	Sat, 22 Mar 2025 07:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742628541;
	bh=8KQ5iiw5zSx3Kwqm+V4tw6kGTtVvzAUfJdYNkPur63U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ENEYF2RnjC0899xY0ZxDknuq9ZI6OnXM81cqCkB5cHhSrsVIk1KfN/YWQHRdUAz/c
	 aBqSSBOCvDrDATIyeBt1+BAQU1QCHan++4s5fgXzmezlhLkO6tjxUW2VIJMhzt807r
	 aJmD/qMvmewclfkIxjSmOAGf9ooDM/LFTmJI/PV0pAWonsfSd7cEUVnDPUZyMzhMyw
	 FbclhttqkSa/fgXZtTGaVi6tcwgH/ul5FY+xFbdXpjMooV60GVfmotaEs3ud3Y8kUV
	 WOwvddZStGvM+SQOU7NlgNOWQhS0nJ1Xtj0wCO9/EwZCn0+ATkCO9zs1TXvprWbvEN
	 AmmXnxC7vcbYg==
Date: Sat, 22 Mar 2025 08:28:54 +0100
From: Ingo Molnar <mingo@kernel.org>
To: david@ixit.cz
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 7/7] x86/Kconfig: Document release year of glibc 2.3.3
Message-ID: <Z95mtpOJTaQIl969@gmail.com>
References: <20250321-x86_x2apic-v3-0-b0cbaa6fa338@ixit.cz>
 <20250321-x86_x2apic-v3-7-b0cbaa6fa338@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321-x86_x2apic-v3-7-b0cbaa6fa338@ixit.cz>


* David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org> wrote:

> From: Mateusz Jończyk <mat.jonczyk@o2.pl>
> 
> I wonder how many people were checking their glibc version when
> considering whether to enable this option.
> 
> Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index ba6ba3a7011554d9cb58fb0acf48d541da8ed69b..22dd962f8e5c86741a512e12596bd940cd1dae97 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2225,7 +2225,7 @@ config HOTPLUG_CPU
>  
>  config COMPAT_VDSO
>  	def_bool n
> -	prompt "Disable the 32-bit vDSO (needed for glibc 2.3.3)"
> +	prompt "Workaround for glibc 2.3.2 / 2.3.3 (released in year 2003/2004)"
>  	depends on COMPAT_32
>  	help
>  	  Certain buggy versions of glibc will crash if they are

So I applied this patch, because it's an obvious improvement over the
status quo - but I think we should finally remove COMPAT_VDSO...

Thanks,

	Ingo

