Return-Path: <linux-iio+bounces-25219-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A1EBED009
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 15:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E4419A3C28
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 13:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A642D27A130;
	Sat, 18 Oct 2025 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iY6Y0lvO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D197354AFD;
	Sat, 18 Oct 2025 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760792553; cv=none; b=rHn796kZv9oaS1pQWRLICbrT/HQUVDa+s2pE5szmC4Jrjc8+U9rg2tTTAXDOkqVgN3lqgczLEvZhowA7mms0+s+xG/9YGJAogNrHlFUcgb2CKmmFkszbEkq0JX2tKH2I3G3iJMZHWiAhsrSNaAGHbCPOzYJOLcPuZzUCbV1i5xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760792553; c=relaxed/simple;
	bh=fbWlRvRugAkgLL9tHIqyKSEKl02xBJdfjeCqsGoi/sE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTYLy7Fe2obzSGqa/HQOtSjs3YLTsvZp+xTBYA1yIru8gCPffBGmx+TIB/zn8OH18MT6++RYugUprEXy+E/aD2AeviAlvCXAcdmSX+CdrMS0TjMW7/JB2ertE6w1QHV2B1ZHmuwccETijHboy1b2zCcfVATNie0as1oeR1woQrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iY6Y0lvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E81C4CEF8;
	Sat, 18 Oct 2025 13:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760792552;
	bh=fbWlRvRugAkgLL9tHIqyKSEKl02xBJdfjeCqsGoi/sE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iY6Y0lvOY5JuRu9P0OgsP3oqRZbIjzNH3nt+O+GkehHLKkU8OY+wBGTMtmkXku/DZ
	 f4WelwD/JqqxCsvfu7uXhiS8yVEUGMyT1npP0gyQRhpwo2FjNYRxXAksWmfF0bDCB9
	 XX8Hn6lnRoPqr+UKGGTdRaS004jRK2KnA8WHf+NUE6UJaI2k58C0eYoS1krHbjbxgS
	 6eF6NoFcus5AwWjVt0mYNNOacySYOwxxk/mDKd5vsdK98cXFFLN+STfKqg5KJ4E4fd
	 6pCZLLsD1LxoURBDk9pUWoRTyLsTihY+ave4AiUZ0ev3CgJVrLEK4ct8I8zjKaknVz
	 14rZOusJtvnPQ==
Date: Sat, 18 Oct 2025 14:02:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
Subject: Re: [PATCH v4 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
Message-ID: <20251018140225.014d858d@jic23-huawei>
In-Reply-To: <1bfa9a86-0a80-416a-b653-8d14f5ebd891@linaro.org>
References: <20250919135618.3065608-1-daniel.lezcano@linaro.org>
	<20250919135618.3065608-3-daniel.lezcano@linaro.org>
	<20250920102742.4cadb734@jic23-huawei>
	<1bfa9a86-0a80-416a-b653-8d14f5ebd891@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 11:01:43 +0200
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> On 9/20/25 11:27, Jonathan Cameron wrote:
> 
> [ ... ]
> 
> >> +static void nxp_sar_adc_remove(struct platform_device *pdev)
> >> +{
> >> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> >> +	struct nxp_sar_adc *info = iio_priv(indio_dev);
> >> +
> >> +	nxp_sar_adc_stop_conversion(info);  
> > 
> > I assume this is safe even if no start has happened and is here so
> > that the driver remove can run whilst buffered capture is still going on?
> > That should be done by the core as part of unwinding the register().
> > So I'd not expect a need for it here. This may be a side effect of the
> > ordering issue mixing devm and not causes.  The same is true of some
> > of these other calls - I haven't checked them all.
> >   
> >> +	nxp_sar_adc_channels_disable(info, NXP_SAR_ADC_CH_MASK);
> >> +	nxp_sar_adc_dma_channels_disable(info, NXP_SAR_ADC_CH_MASK);
> >> +	nxp_sar_adc_dma_cfg(info, false);
> >> +	nxp_sar_adc_disable(info);
> >> +	dmaengine_terminate_sync(info->dma_chan);  
> > 
> > Mixing devm and non devm is a never a good idea. Here one possible issue is that
> > the userspace interfaces are only torn down when devm unwind gets to unwind
> > devm_iio_device_register();  That happens well after this code has ripped down the
> > dma engine that a channel read will try to use.  It might be safe to do that
> > but it certainly makes the driver harder to reason about.
> > 
> > A simple 'rule' is once you first call a non devm function in probe that needs unwinding
> > in remove, you cannot call any more devm functions.   Whilst there are lots of cases
> > that are safe, this approach ensures none of the cases that aren't sneak in and makes
> > review straight forward.
> > 
> > devm_add_action_or_reset() can often be used to keep the chain of devm calls running,
> > sometimes covering everything such that we don't need a remove callback.
> >   
> >> +}  
> 
> Actually I think these calls are not relevant. If we remove the 
> nxp_sar_adc_remove() function, the iio core code will unregister the device.
> 
> All operations are doing on/off in the different callbacks (raw_read, 
> postenable, predisable). When the device is unregistered it is not 
> possible to have an ongoing conversion, a channel enabled or the adc 
> enabled, as well as the DMA. IINW, we can just remove this block of code.

Great.

> 
> [ ... ]
> 
> 
> 


