Return-Path: <linux-iio+bounces-8909-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DFE967150
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 13:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1FA11C20F50
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 11:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6304817DFEC;
	Sat, 31 Aug 2024 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rL/Mtpnf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187E819BB7;
	Sat, 31 Aug 2024 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725104064; cv=none; b=Z9JSNX9JY0O6sVfgncVnKM4tIgRNwFnd1ahWtEpaDSAhcoOGgedXLjEKTDOGtP04STO8q5LmvWNY76Xy/Siw+loous1avl8k43yNyKeT3iEUGsSkazqZ1Gg34YQw+oQPN2e2uXdHgkY/ovO2rkjNCOpRd7rrKgqmBgeKWQ03zXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725104064; c=relaxed/simple;
	bh=pTuBiz0aBmLlXkooQ8sY+Trgbzt3HvaZXF0VH5ok2+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPEffnViuGCPxgAPbMTUBJeR/Mct7gLHbYba18DfY+5VgXu8ucv9+VWB4R0sdIl56dkM64dLHzUYrysi7LVHsh2rqbycKYJACUIqfNYBUcfCVskCJZtilfvCIwalxo7kZcf14cRcXbIemLbkEJUaLAu370pB1UjkdG7IVE5ekAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rL/Mtpnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4FEC4CEC0;
	Sat, 31 Aug 2024 11:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725104063;
	bh=pTuBiz0aBmLlXkooQ8sY+Trgbzt3HvaZXF0VH5ok2+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rL/Mtpnfrnwj+i0+5owDZ0wnjNAxb9lcQgLrxWDKmtJAyXsMc82TkhwEnFD9h828y
	 7RP3SX2fqLAlTIEwdHWD5rzv0GNy5LEVVKPVNaRTIh2UmQ2y86xAIU8UIyyt7yAm4R
	 3eAtLyB5bhTyUm/hesD8sJ3JmTlZQ6I13mLCXnsuMMBgotGZUD5lCX/7qNiYyzAvd/
	 7RgP+KpzCcDqkKFz5v0QVxW+rq4yqg5xGRM088fcwmY5C3knjascOPEBCmVRqguM6o
	 54Xnj4IK7RpIgcd3I7/1c/e3DTmvGEsEnjIUHJdog7LXUrUoMsIMiePKZmTEJGlhcP
	 FSpjnrw3Jw4jw==
Date: Sat, 31 Aug 2024 12:34:18 +0100
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
Message-ID: <20240831123418.6bef6039@jic23-huawei>
In-Reply-To: <20240829-wip-bl-ad3552r-axi-v0-v1-3-b6da6015327a@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	<20240829-wip-bl-ad3552r-axi-v0-v1-3-b6da6015327a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 14:32:01 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Extend DAC backend with new features required for the AXI driver
> version for the a3552r DAC.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Hi Angelo
Minor comments inline.
>  
>  static int axi_dac_enable(struct iio_backend *back)
> @@ -460,7 +493,13 @@ static int axi_dac_data_source_set(struct iio_backend *back, unsigned int chan,
>  	case IIO_BACKEND_EXTERNAL:
>  		return regmap_update_bits(st->regmap,
>  					  AXI_DAC_REG_CHAN_CNTRL_7(chan),
> -					  AXI_DAC_DATA_SEL, AXI_DAC_DATA_DMA);
> +					  AXI_DAC_DATA_SEL,
> +					  AXI_DAC_DATA_DMA);

Unrelated change.   If you want to change this, separate patch.

> +	case IIO_BACKEND_INTERNAL_RAMP_16:
> +		return regmap_update_bits(st->regmap,
> +					  AXI_DAC_REG_CHAN_CNTRL_7(chan),
> +					  AXI_DAC_DATA_SEL,
> +					  AXI_DAC_DATA_INTERNAL_RAMP_16);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -518,9 +557,204 @@ static int axi_dac_reg_access(struct iio_backend *back, unsigned int reg,
>  	return regmap_write(st->regmap, reg, writeval);
>  }
>  

> +
> +static int axi_dac_bus_reg_write(struct iio_backend *back,
> +				 u32 reg, void *val, size_t size)

Maybe just pass an unsigned int for val?
So follow what regmap does? You will still need the size, but it
will just be configuration related rather than affecting the type
of val.



> +{
> +	struct axi_dac_state *st = iio_backend_get_priv(back);
> +
> +	if (!st->bus_type)
> +		return -EOPNOTSUPP;
> +
> +	if (st->bus_type == AXI_DAC_BUS_TYPE_QSPI) {

As below, I'd use a switch and factor out this block as a separate
bus specific function.

> +		int ret;
> +		u32 ival;
> +
> +		if (size != 1 && size != 2)
> +			return -EINVAL;
> +
> +		switch (size) {
> +		case 1:
> +			ival = FIELD_PREP(AXI_DAC_DATA_WR_8, *(u8 *)val);
> +			break;
> +		case 2:
> +			ival =  FIELD_PREP(AXI_DAC_DATA_WR_16, *(u16 *)val);
> +			break;
> +		default:
> +			return  -EINVAL;

Hopefully compiler won't need this and the above. I'd drop the size != 1..
check in favour of just doing it in this switch.

> +		}
> +
> +		ret = regmap_write(st->regmap, AXI_DAC_CNTRL_DATA_WR, ival);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Both REG_CNTRL_2 and AXI_DAC_CNTRL_DATA_WR need to know
> +		 * the data size. So keeping data size control here only,
> +		 * since data size is mandatory for to the current transfer.
> +		 * DDR state handled separately by specific backend calls,
> +		 * generally all raw register writes are SDR.
> +		 */
> +		if (size == 1)
> +			ret = regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_2,
> +					      AXI_DAC_SYMB_8B);
> +		else
> +			ret = regmap_clear_bits(st->regmap, AXI_DAC_REG_CNTRL_2,
> +						AXI_DAC_SYMB_8B);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
> +					 AXI_DAC_ADDRESS,
> +					 FIELD_PREP(AXI_DAC_ADDRESS, reg));
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
> +					 AXI_DAC_TRANSFER_DATA,
> +					 AXI_DAC_TRANSFER_DATA);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_read_poll_timeout(st->regmap,
> +					       AXI_DAC_REG_CUSTOM_CTRL, ival,
> +					       ival & AXI_DAC_TRANSFER_DATA,
> +					       10, 100 * KILO);
> +		if (ret)
> +			return ret;
> +
> +		return regmap_clear_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
> +					  AXI_DAC_TRANSFER_DATA);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int axi_dac_bus_reg_read(struct iio_backend *back,
> +				u32 reg, void *val, size_t size)
As for write, I'd just use an unsigned int * for val like
regmap does.


> +{
> +	struct axi_dac_state *st = iio_backend_get_priv(back);
> +
> +	if (!st->bus_type)
> +		return -EOPNOTSUPP;
> +
> +	if (st->bus_type == AXI_DAC_BUS_TYPE_QSPI) {

It got mentioned in binding review but if this isn't QSPI, even
if similar don't call it that.
Maybe use a switch from the start give it will make sense
anyway the moment there is a second bus type.

I'd be tempted to factor the rest of this block out.
I guess expectation is we'll see more bus types so that factoring
out will be needed soon anyway.


> +		int ret;
> +		u32 bval;
		u32 bval = 0;
> +
> +		if (size != 1 && size != 2)
> +			return -EINVAL;
> +
> +		bval = 0;
> +		ret = axi_dac_bus_reg_write(back,
> +					    AXI_DAC_RD_ADDR(reg), &bval, size);

Ugly wrap.   Move more stuff on to first line.

> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_read_poll_timeout(st->regmap, AXI_DAC_UI_STATUS,
> +					       bval, bval != AXI_DAC_BUSY,
> +					       10, 100);
> +		if (ret)
> +			return ret;
> +
> +		return regmap_read(st->regmap, AXI_DAC_CNTRL_DATA_RD, val);
> +	}
> +
> +	return -EINVAL;
> +}


