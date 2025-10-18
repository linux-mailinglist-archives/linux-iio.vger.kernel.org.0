Return-Path: <linux-iio+bounces-25218-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8DABECFEB
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 15:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD92189F5EA
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 13:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D481C5D46;
	Sat, 18 Oct 2025 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTHrvA6X"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF572629F;
	Sat, 18 Oct 2025 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760792487; cv=none; b=Yyd+FzpXOEsrcRrniVr2D37qMa28IEwkoE9tD9cdcYXF+5kV4I2AlhyF5yvvxbX2oE/36KPpzJdUZk4yWWGIRtSQHCd1jpWqQ/I10eEOtvhXemBB5iuReX6AU8mnQij08XC9YemjMv47fOkalq9XIufEPh0IR/OTfm0HnbYP+a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760792487; c=relaxed/simple;
	bh=783LtfgNMc5nKir4bVhfU1gejI7YUBKrlMTWPWtqf/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxVjJibzMbx0HGhxWZoppWlk4M3Ckb48w4/IN7WC+mEepE54/kNLM7wClUA9z4IqFHNODHJq7uKkX8qF026F6HoLvaxGRdfGtQp+yVMHmGrWJP3ncRpabvTnjaxzAnAvJ8Si80W+YvumcjFD96mdoy+k4k+E99A73hPlhWOCLUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTHrvA6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06158C4CEF8;
	Sat, 18 Oct 2025 13:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760792487;
	bh=783LtfgNMc5nKir4bVhfU1gejI7YUBKrlMTWPWtqf/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lTHrvA6XkVq9N+FMwmL9tI+WW5arQfK4XtN12eO07OQhhO0nwi6aGxhYYpalfnOav
	 jeklVLJEnyD5cx385lytsypFTDQ/I+MJgE07KBQbZ2veow/EQWAwTORfRCuk6yvhKm
	 pycvme3csnU3mLMC0miz7BzSeg0RnKcChLl/i+6FqqKF+Oyvk5Zg3oesaFz58mUy/W
	 yOU7WmW6kvXeQdgwgMMCfNqXyg1DKTQkYsFDAvW9QtttziorKHhYzz0nc87CqWxlA4
	 ubx2OCq4KVLGrbE0ZfTl8dX/P4o64tO0of579Z5GbNnG78unKxQhiB5dml2hHvttY8
	 hBU1+bUsDRXOw==
Date: Sat, 18 Oct 2025 14:01:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
Subject: Re: [PATCH v4 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
Message-ID: <20251018140120.0e6132e6@jic23-huawei>
In-Reply-To: <0ac22118-fd0f-49c0-9aa8-5739925587d2@linaro.org>
References: <20250919135618.3065608-1-daniel.lezcano@linaro.org>
	<20250919135618.3065608-3-daniel.lezcano@linaro.org>
	<20250920102742.4cadb734@jic23-huawei>
	<0ac22118-fd0f-49c0-9aa8-5739925587d2@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Oct 2025 09:17:40 +0200
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> Hi Jonathan,
> 
> back to this driver after the merge window ...
> 
> On 9/20/25 11:27, Jonathan Cameron wrote:
> > On Fri, 19 Sep 2025 15:56:18 +0200
> > Daniel Lezcano <daniel.lezcano@linaro.org> wrote:  
> 
> [ ... ]
> 
> >> +static int nxp_sar_adc_start_conversion(struct nxp_sar_adc *info, bool raw)
> >> +{
> >> +	u32 mcr;
> >> +
> >> +	mcr = readl(NXP_SAR_ADC_MCR(info->regs));
> >> +	mcr |= NXP_SAR_ADC_MCR_NSTART;
> >> +
> >> +	if (raw)
> >> +		mcr &= ~NXP_SAR_ADC_MCR_MODE;
> >> +	else
> >> +		mcr |= NXP_SAR_ADC_MCR_MODE;  
> > 
> > Could use FIELD_MODIFY() for this though saving is minor.
> > Same applies in various other places in this driver (and
> > many others!)  
> 
> [ ... ]
> 
> I gave a try to use the macro FIELD_MODIFY(). Logically, FIELD_GET() 
> should be used too for consistency. From my POV, the result looks less 
> readable than the usual annotation but may be I not used to the FIELD_ 
> usage. Here is a snippet of the changes, do you really want to convert 
> all the driver ?

I'm not against mixing FIELD_GET/PREP etc with single bit booleans where
it make sense.  However this was definitely a 'maybe' type of review
comment for exactly the reasons of inconsistency you've identified.

> 
>          mcr = readl(NXP_SAR_ADC_MCR(info->regs));
> 
>          /* Return the current state. */
> -       pwdn = mcr & NXP_SAR_ADC_MCR_PWDN;
> +       pwdn = FIELD_GET(NXP_SAR_ADC_MCR_PWDN, mcr);

When it's effectively a boolean I'm not fussed if people use FIELD_GET()
or not. 

> 
> -       if (enable)
> -               mcr &= ~NXP_SAR_ADC_MCR_PWDN;
> -       else
> -               mcr |= NXP_SAR_ADC_MCR_PWDN;
> +       /* When the enabled flag is not set, we set the power down bit */
> +       FIELD_MODIFY(NXP_SAR_ADC_MCR_PWDN, &mcr, !enable);
If the comment is more necessary than before (I'm not sure it is but
then I'm more comfortable with these macros than many!) then the modification
probably doesn't make sense.
> 
>          writel(mcr, NXP_SAR_ADC_MCR(info->regs));
> 
> This looks ok but then:
> 
>   {
>          u32 msr, ret;
> 
> -       ret = readl_poll_timeout(NXP_SAR_ADC_MSR(base), msr, !(msr & 
> NXP_SAR_ADC_MSR_CALBUSY),
> +       ret = readl_poll_timeout(NXP_SAR_ADC_MSR(base), msr,
> +                                !FIELD_GET(NXP_SAR_ADC_MSR_CALBUSY, msr)),

Similar to above, For a simple boolean we don't need to extract
the value, a shifted bit is fine.  The compiler might sort that out. I've
never checked.

>                                   NXP_SAR_ADC_WAIT_US,
>                                   NXP_SAR_ADC_CAL_TIMEOUT_US);
>          if (ret)
>                  return ret;
> 
> -       if (msr & NXP_SAR_ADC_MSR_CALFAIL) {
> +       if (FIELD_GET(NXP_SAR_ADC_MSR_CALFAIL, msr)) {
>                  /*
>                   * If the calibration fails, the status register bit
>                   * must be cleared.
>                   */
> -               msr &= ~NXP_SAR_ADC_MSR_CALFAIL;
> +               FIELD_MODIFY(NXP_SAR_ADC_MSR_CALFAIL, &msr, 0x0);
>                  writel(msr, NXP_SAR_ADC_MSR(base));
> 
>                  return -EAGAIN;
> 
> [ ... ]
> 
>          ceocfr = readl(NXP_SAR_ADC_CEOCFR0(info->regs));
> -       if (!(ceocfr & NXP_SAR_ADC_EOC_CH(chan)))
> +
> +       /* FIELD_GET() can not be used here because EOC_CH is not 
> constant */
> +       if (!(NXP_SAR_ADC_EOC_CH(chan) & ceocfr))
>                  return -EIO;
> 
>          cdr = readl(NXP_SAR_ADC_CDR(info->regs, chan));
> -       if (!(cdr & NXP_SAR_ADC_CDR_VALID))
> +       if (!(FIELD_GET(NXP_SAR_ADC_CDR_VALID, cdr)))
>                  return -EIO;
> 
> -       return cdr & NXP_SAR_ADC_CDR_CDATA_MASK;
> +       return FIELD_GET(NXP_SAR_ADC_CDR_CDATA_MASK, cdr);
>   }
> 
> 
> 


