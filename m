Return-Path: <linux-iio+bounces-27295-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE05CD44A2
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 20:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1F603006F4A
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBF51D6DB5;
	Sun, 21 Dec 2025 19:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq4PdKIp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8460378F2F;
	Sun, 21 Dec 2025 19:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766344660; cv=none; b=Sh3CQDgAg7TUbsqpYYqJ5cScROzNgRAY8bCQqmOWVSmp2Canxz78Fxnk8k2agI9OjfMgKSWlCY4TNPeC3P28Lu2ZzhgbR+0WYdSVDQBmpF/bIT0hbZ2WFP4RMg4kFw6aaH6ujrSC+9YXbDrNwBHQYBDtpR3ie/+60CPXHJ02HDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766344660; c=relaxed/simple;
	bh=To2FFFlJTSvmlOj9ibYPxtNXT4EUPuPX+Zq5Id20tm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tD4wHxp/iCiM8nCzubOofp/Gcp03qiEftRqvhEaPzjfuQhvQo/tf4GJlsaSnxXjH6XyI0JA0wfr2BLtWTWC9P0gZr9hpcb8W1o4EJMFNe9ig1j09zS37rwEz1slEB0/xeClG2SU8F8hOeLAOZEYFGR7CRtZpg1BkgOv7B6AGwu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oq4PdKIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E88C4CEFB;
	Sun, 21 Dec 2025 19:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766344660;
	bh=To2FFFlJTSvmlOj9ibYPxtNXT4EUPuPX+Zq5Id20tm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Oq4PdKIpZEm6FQHrAXhv8K0VysxM/hY9Oh85tPPDEYzrgpvNuohdkdbJ5uXcGBQW7
	 vbhbpDa7oWnXXbu9mjhQpmPdux/IuebDOxA3pTCZ37qVQ63rdtbuEVe4AhW3004bEf
	 DNxGKWTFngpjl7PUtE5Bis5z2e2pB6wFLHC5e8+NQlWqgg04msjRNxKFYrOO1tKMVQ
	 wshu/+14PIzZsWw7Pbcii/heUGzPWNhK87MRGMGCmOocDnsnBdNoZybRFPGpHCLyrY
	 fsQQKxSa5aQ1JsTsQyveQXE1VvVYahkTQakKxGYhEE9b+hF13EyEpracHDhkinH2YL
	 svJk9izgKMqZg==
Date: Sun, 21 Dec 2025 19:17:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Tomas Borquez <tomasborquez13@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/5] staging: iio: ad9832: clean up whitespace
Message-ID: <20251221191730.607eaf34@jic23-huawei>
In-Reply-To: <aUQPRsCbB-eXHSIx@debian-BULLSEYE-live-builder-AMD64>
References: <20251215190806.11003-1-tomasborquez13@gmail.com>
	<20251215190806.11003-2-tomasborquez13@gmail.com>
	<aUQPRsCbB-eXHSIx@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 11:27:18 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Hi Tomas,
> 
> LGTM.
> One minor suggestion.
> 
> On 12/15, Tomas Borquez wrote:
> > Remove unnecessary blank lines between comment sections to improve
> > readability.
> > 
> > Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
> > ---
> >  drivers/staging/iio/frequency/ad9832.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> > index e2ad3e5a7a..00813dab7c 100644
> > --- a/drivers/staging/iio/frequency/ad9832.c
> > +++ b/drivers/staging/iio/frequency/ad9832.c
> > @@ -26,7 +26,6 @@
> >  #include "dds.h"
> >  
> >  /* Registers */
> > -
> >  #define AD9832_FREQ0LL		0x0
> >  #define AD9832_FREQ0HL		0x1
> >  #define AD9832_FREQ0LM		0x2
> > @@ -50,7 +49,6 @@
> >  #define AD9832_OUTPUT_EN	0x13  
> 
> There is a blank line between AD9832_PHASE3H and AD9832_PHASE_SYM that could
> also be removed, IMO.
>  #define AD9832_PHASE3L		0xE
>  #define AD9832_PHASE3H		0xF
> -
>  #define AD9832_PHASE_SYM	0x10
>  #define AD9832_FREQ_SYM		0x11
> 
Agreed. In the interests of efficiency all round I applied this
tweak whilst picking up the patch.

For this sort of cleanup series I often to it piecemeal. So I've
applied this one (no idea if I'll apply the later ones yet!)

Jonathan

> >  
> >  /* Command Control Bits */
> > -
> >  #define AD9832_CMD_PHA8BITSW	0x1  


