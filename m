Return-Path: <linux-iio+bounces-7026-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E283C91C602
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 20:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2248E1C221E7
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 18:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F333C08A;
	Fri, 28 Jun 2024 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qELlGLO6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C6B3FD4;
	Fri, 28 Jun 2024 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600358; cv=none; b=sEttK9/LW1d4O5plJmYZR/NmrTej9IalOwLRqvbh7/ZtzoN/Arx/A4c6F4Suwa7YX1nCX79VnggsaVEfdfz9aQiMT5wnNIc8zmQT3BHUFpoihVm5BZStbWOIp5pPEnusX9raZXBk+xEjvGc5Arn+FpwuWaQTkyNoFPpuMsHyM7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600358; c=relaxed/simple;
	bh=/mwc2Nc8rtpwxZIhFIwLRHd1dQzbsiCmJJdqjFgkEg8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kj+VBNqTL95YlcefA4FeSZp/gp3N7jj+3pINvsBU4RJNP2aZAIsjwzl79zH8/LcSS1v16jyf6selA4PJgoh2zTSjtjChizNC4hJvnatKyAhdlAwfp35T1B2+qlzJdbnhnv6mxsr6ZNwVYCYyZhjCuAMvsOzn1Q+5n+gfOpRrE4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qELlGLO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EC5C116B1;
	Fri, 28 Jun 2024 18:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719600357;
	bh=/mwc2Nc8rtpwxZIhFIwLRHd1dQzbsiCmJJdqjFgkEg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qELlGLO6AiYwfACawIgVdT4RtXGZ0bUMCq0yJ6wUpJVau7UpUduunUqFnbpWbQqJw
	 /SkGEpt8mz7Qf/BmU/qRWJoACWAOzncg+H157H6sNR8523nmh+toMpluCDL3tUqNFq
	 cFsX5ChjxQ+QJy4pqzgjLoUFrNZd3T9kMQkZt+XOQ7Wocz5bZB/UUr2WCG0oqlJ1KE
	 3TVB40NnSOGiDicIGlg2guVsQRs+VT+mLCxtz4hXZI5t85jHOaLFRjXF5UJ3kjMryW
	 j4aYUE0QWL40OEeCGvbZYup1BcPisK+0Cxjp822abLv73FAODZQ3HJqGk8Ufis5rxC
	 kF7ky+OFIdI/A==
Date: Fri, 28 Jun 2024 19:45:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
Message-ID: <20240628194546.2f608365@jic23-huawei>
In-Reply-To: <SJ0PR03MB62241801F72B21EEC9CDCCBD91D42@SJ0PR03MB6224.namprd03.prod.outlook.com>
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
	<20240510064053.278257-3-Mariel.Tinaco@analog.com>
	<20240511174405.10d7fce8@jic23-huawei>
	<SJ0PR03MB62241801F72B21EEC9CDCCBD91D42@SJ0PR03MB6224.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > > +};
> > > +
> > > +static int ad8460_get_powerdown_mode(struct iio_dev *indio_dev,
> > > +				     const struct iio_chan_spec *chan) {
> > > +	return 0;  
> > 
> > Why have the stubs in here?  
> 
> Should I move the stubs to a different place in the code or remove them
> altogether since there is only a single powerdown mode available
Ah. I'd not really understood what was going on here.  This is fine as
is.

> > AD8460_HVDAC_DATA_WORD_HIGH(index),  
> > > +			    ((val >> 8) & 0xFF));  
> > 
> > bulk write? or do these need to be ordered?  
> 
> For this I used bulk read/write this way.
> 
> static int ad8460_set_hvdac_word(struct ad8460_state *state,
> 				 int index,
> 				 int val)
> {
> 	u8 regvals[AD8460_DATA_BYTE_WORD_LENGTH];
regmap bulk accesses (when spi anyway) should be provided with DMA safe buffers.
Easiest way to do that is add one with __aligned(IIO_DMA_MINALIGN) to the end
of the ad8460_state structure.  Possibly you'll need a lock to protect it - I haven't
checked.
> 
> 	regvals[0] = val & 0xFF;
> 	regvals[1] = (val >> 8) & 0xFF;

That is an endian conversion so use appropriate endian function to fill it efficiently
and document clearly what is going on.


	put_unaligned_le16()

> 
> 	return regmap_bulk_write(state->regmap, AD8460_HVDAC_DATA_WORD_LOW(index),
> 				 regvals, AD8460_DATA_BYTE_WORD_LENGTH);
> }
> 
> 
> > > +}

> > > +	state->regmap = devm_regmap_init_spi(spi, &ad8460_regmap_config);
> > > +	if (IS_ERR(state->regmap))
> > > +		return dev_err_probe(&spi->dev, PTR_ERR(state->regmap),
> > > +				     "Failed to initialize regmap");
> > > +
> > > +	ret = devm_iio_dmaengine_buffer_setup_ext(&spi->dev, indio_dev, "tx",
> > > +  
> > IIO_BUFFER_DIRECTION_OUT);
> > 
> > Ah. I take back my binding comment. I assume this is mapping some non
> > standard interface for the parallel data flow?  
> 
> Yes, the HDL side doesn't follow yet the standard IIO backend from which this
> driver was tested

Hmm. I'd like to see this brought inline with the other iio backend
drivers if possible.

Jonathan



