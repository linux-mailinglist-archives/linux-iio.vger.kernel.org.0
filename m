Return-Path: <linux-iio+bounces-9091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6151296A72F
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 21:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D9E286BE0
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 19:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DDE16C453;
	Tue,  3 Sep 2024 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cP21XLzJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B161D5CF8;
	Tue,  3 Sep 2024 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390983; cv=none; b=NEkXZPcsVvaZmdlX1D+9E8KLZfOnovPaPXfVCq4j90tYRLA+/sP5Ng3u6riTFfUQgCOyEqYUhBX5wJ59tFpblMu+745F6TVF5wzGNayuTZruXJWgXg0A8BL2Rg7JIR7EbcpvwyN9HuKATEs13JtJEcxnbs1T1oDsjpFLyoJ7Y4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390983; c=relaxed/simple;
	bh=IvxVPNWe8n3Tv9B5xV600I+GCPLmdK0PoRL9GpCKJp8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=reyvANVUvYWTLquAt8OCi19J+bbksIsRnjq9nDlAaUXOhtNE4YZjSUDzc50soUteRVLOkxlIIRecHgprWaUdsNom4MRtg+wb/RbxF29IIw0fZsl+3fleGyXzpLc6g40Ok3xk+E3+zjmq4F08ZHh27XIJNjI2dgFejaypz/iI19o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cP21XLzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3E9C4CEC4;
	Tue,  3 Sep 2024 19:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725390982;
	bh=IvxVPNWe8n3Tv9B5xV600I+GCPLmdK0PoRL9GpCKJp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cP21XLzJJcbrKoDjJ//t2xk0LLwgYSRHUIfX8N4EO/ImOIaFnr0hQMLtAkF5aEKdg
	 OCh0S/xU6IkpSKQ/Z0VeqbkXTqPMrzgh99jQUS5MJkZbvCNkDj8iFuTh8VAl/qauMH
	 6JDoJTROdEHbjLWvu0fE3iGywfVZ9wfOXEZTUBgwE8wUCUqtIrJhQZ4Q2TpcaBZYKj
	 wv+5Ixtm59XNPxJ2eycbka5WeFHC37L1BWC2Tru6LUk/2VubaTOm9aJDxlqYNR+Jk1
	 MNYaUMjmHiYgEmzoO5aYBjABkv6wACVpFGJ6F4dHLdMm8nqUnpu9mKpY2bdNiy9kgI
	 B8pNeznSsZuXw==
Date: Tue, 3 Sep 2024 20:16:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com
Subject: Re: [PATCH RFC 3/8] iio: backend adi-axi-dac: backend features
Message-ID: <20240903201614.08722f59@jic23-huawei>
In-Reply-To: <fd68cda2-f523-49fd-943b-c07dbb461799@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	<20240829-wip-bl-ad3552r-axi-v0-v1-3-b6da6015327a@baylibre.com>
	<20240831123418.6bef6039@jic23-huawei>
	<fd68cda2-f523-49fd-943b-c07dbb461799@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Sep 2024 18:04:51 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> On 31/08/24 1:34 PM, Jonathan Cameron wrote:
> > On Thu, 29 Aug 2024 14:32:01 +0200
> > Angelo Dureghello <adureghello@baylibre.com> wrote:
> >  
> >> From: Angelo Dureghello <adureghello@baylibre.com>
> >>
> >> Extend DAC backend with new features required for the AXI driver
> >> version for the a3552r DAC.
> >>
> >> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>  
> > Hi Angelo
> > Minor comments inline.  
> >>   
> >>   static int axi_dac_enable(struct iio_backend *back)
> >> @@ -460,7 +493,13 @@ static int axi_dac_data_source_set(struct iio_backend *back, unsigned int chan,
> >>   	case IIO_BACKEND_EXTERNAL:
> >>   		return regmap_update_bits(st->regmap,
> >>   					  AXI_DAC_REG_CHAN_CNTRL_7(chan),
> >> -					  AXI_DAC_DATA_SEL, AXI_DAC_DATA_DMA);
> >> +					  AXI_DAC_DATA_SEL,
> >> +					  AXI_DAC_DATA_DMA);  
> > Unrelated change.   If you want to change this, separate patch.  
> Thanks, fixed.
> >  
> >> +	case IIO_BACKEND_INTERNAL_RAMP_16:
> >> +		return regmap_update_bits(st->regmap,
> >> +					  AXI_DAC_REG_CHAN_CNTRL_7(chan),
> >> +					  AXI_DAC_DATA_SEL,
> >> +					  AXI_DAC_DATA_INTERNAL_RAMP_16);
> >>   	default:
> >>   		return -EINVAL;
> >>   	}
> >> @@ -518,9 +557,204 @@ static int axi_dac_reg_access(struct iio_backend *back, unsigned int reg,
> >>   	return regmap_write(st->regmap, reg, writeval);
> >>   }
> >>   
> >> +
> >> +static int axi_dac_bus_reg_write(struct iio_backend *back,
> >> +				 u32 reg, void *val, size_t size)  
> > Maybe just pass an unsigned int for val?
> > So follow what regmap does? You will still need the size, but it
> > will just be configuration related rather than affecting the type
> > of val.
> >  
> void * was used since data size in the future may vary depending
> on the bus physical interface.
> 
I doubt it will get bigger than u64.  Passing void * is always
nasty if we can do something else and this is a register writing
operation.  I'm yet to meet an ADC or similar with > 64 bit registers
(or even one with 64 bit ones!)

> Actually, a reg bus write involves several AXI regmap operations.
> >  
> >> +{
> >> +	struct axi_dac_state *st = iio_backend_get_priv(back);
> >> +
> >> +	if (!st->bus_type)
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	if (st->bus_type == AXI_DAC_BUS_TYPE_QSPI) {  
> > As below, I'd use a switch and factor out this block as a separate
> > bus specific function.  
> Ok, changed.
> >  
> >> +		int ret;
> >> +		u32 ival;
> >> +
> >> +		if (size != 1 && size != 2)
> >> +			return -EINVAL;
> >> +
> >> +		switch (size) {
> >> +		case 1:
> >> +			ival = FIELD_PREP(AXI_DAC_DATA_WR_8, *(u8 *)val);
> >> +			break;
> >> +		case 2:
> >> +			ival =  FIELD_PREP(AXI_DAC_DATA_WR_16, *(u16 *)val);
> >> +			break;
> >> +		default:
> >> +			return  -EINVAL;  
> > Hopefully compiler won't need this and the above. I'd drop the size != 1..
> > check in favour of just doing it in this switch.
> >  
> sure, done.
> 
> 
> >> +		}
> >> +
> >> +		ret = regmap_write(st->regmap, AXI_DAC_CNTRL_DATA_WR, ival);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		/*
> >> +		 * Both REG_CNTRL_2 and AXI_DAC_CNTRL_DATA_WR need to know
> >> +		 * the data size. So keeping data size control here only,
> >> +		 * since data size is mandatory for to the current transfer.
> >> +		 * DDR state handled separately by specific backend calls,
> >> +		 * generally all raw register writes are SDR.
> >> +		 */
> >> +		if (size == 1)
> >> +			ret = regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_2,
> >> +					      AXI_DAC_SYMB_8B);
> >> +		else
> >> +			ret = regmap_clear_bits(st->regmap, AXI_DAC_REG_CNTRL_2,
> >> +						AXI_DAC_SYMB_8B);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		ret = regmap_update_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
> >> +					 AXI_DAC_ADDRESS,
> >> +					 FIELD_PREP(AXI_DAC_ADDRESS, reg));
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		ret = regmap_update_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
> >> +					 AXI_DAC_TRANSFER_DATA,
> >> +					 AXI_DAC_TRANSFER_DATA);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		ret = regmap_read_poll_timeout(st->regmap,
> >> +					       AXI_DAC_REG_CUSTOM_CTRL, ival,
> >> +					       ival & AXI_DAC_TRANSFER_DATA,
> >> +					       10, 100 * KILO);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		return regmap_clear_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
> >> +					  AXI_DAC_TRANSFER_DATA);
> >> +	}
> >> +
> >> +	return -EINVAL;
> >> +}
> >> +
> >> +static int axi_dac_bus_reg_read(struct iio_backend *back,
> >> +				u32 reg, void *val, size_t size)  
> > As for write, I'd just use an unsigned int * for val like
> > regmap does.  
> 
> Ok, so initial choice was unsigned int, further thinking of
> possible future busses drive the choice to void *.
> 
> Let me know, i can switch to unsigned int in case.
I would just go with unsigned int or at a push u64 *

> 
> 
> >
> >  
> >> +{
> >> +	struct axi_dac_state *st = iio_backend_get_priv(back);
> >> +
> >> +	if (!st->bus_type)
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	if (st->bus_type == AXI_DAC_BUS_TYPE_QSPI) {  
> > It got mentioned in binding review but if this isn't QSPI, even
> > if similar don't call it that.  
> 
> It's a bit difficult to find a different name, physically,
> it is a QSPI, 4 lanes + clock + cs, and datasheet is naming it Quad SPI.
> But looking the data protocol, it's a bit different.

is QSPI actually defined anywhere? I assumed it would be like
SPI for which everything is so flexible you can build whatever you like.

> 
> QSPI has instruction, address and data.
> Here we have just ADDR and DATA.
> 
> What about ADI_QSPI ?

Sure, that is fine if we worry about differences from qspi
(which depends on there being a reference spec!)

Jonathan


