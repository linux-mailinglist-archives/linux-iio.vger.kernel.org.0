Return-Path: <linux-iio+bounces-7445-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769F392A6C6
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 18:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF8ABB21945
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 16:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E91D143C47;
	Mon,  8 Jul 2024 16:05:11 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68005EC7;
	Mon,  8 Jul 2024 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454711; cv=none; b=u20ztfDPwkPTxFi7TBQ1lu7hsklydEC3Ry0wpOf9ebG9gyPCltmXiXdnECsU++EKv3SEgtIQtvrE2lq2UV12lh2/ROykBVErfWHbK+Yh1aFgFMi2xg8gUYmHvgeOhua8u+liVEVXVxyFyvEjFh0KjLwkQesqLUQDQsdLqiMa1Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454711; c=relaxed/simple;
	bh=b5IS1Acq/tg8kBzqe5Bf3up//5U7YHtHFF4sdNaYvdY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KocZRniZ7+4O1wr66BdIPU0Y/N+aj40hHcRHS9/SwQmvk/yX/IvFAdEK6mdF4La8sptaamKjczXRmFLpWXFCmA0pH8YrMpkrhaByYF/fa/Px0qAFk7a5bHT5hKMIg+BqZXZoKezWyU8RTeZipsZzHjh0mguQN5a7Kf+rNqx72WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WHpn4646fz6K9Y3;
	Tue,  9 Jul 2024 00:03:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id F3DF31400D9;
	Tue,  9 Jul 2024 00:05:05 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 8 Jul
 2024 17:05:05 +0100
Date: Mon, 8 Jul 2024 17:05:04 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>
CC: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Mark
 Brown" <broonie@kernel.org>, "Hennerich, Michael"
	<Michael.Hennerich@analog.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Dimitri Fedrau <dima.fedrau@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
	Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
Message-ID: <20240708170504.00006c9d@Huawei.com>
In-Reply-To: <SJ0PR03MB62246270CC24E70732D0288F91DA2@SJ0PR03MB6224.namprd03.prod.outlook.com>
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
	<20240510064053.278257-3-Mariel.Tinaco@analog.com>
	<20240511174405.10d7fce8@jic23-huawei>
	<SJ0PR03MB62241801F72B21EEC9CDCCBD91D42@SJ0PR03MB6224.namprd03.prod.outlook.com>
	<20240628194546.2f608365@jic23-huawei>
	<SJ0PR03MB62246270CC24E70732D0288F91DA2@SJ0PR03MB6224.namprd03.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 8 Jul 2024 05:17:55 +0000
"Tinaco, Mariel" <Mariel.Tinaco@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, June 29, 2024 2:46 AM
> > To: Tinaco, Mariel <Mariel.Tinaco@analog.com>
> > Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Lars-Peter Clausen <lars@metafoo.de>; Rob Herring
> > <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> > <conor+dt@kernel.org>; Liam Girdwood <lgirdwood@gmail.com>; Mark Brown
> > <broonie@kernel.org>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> > Marcelo Schmitt <marcelo.schmitt1@gmail.com>; Dimitri Fedrau
> > <dima.fedrau@gmail.com>; Guenter Roeck <linux@roeck-us.net>
> > Subject: Re: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
> > 
> > [External]
> >   
> > > > > +};
> > > > > +
> > > > > +static int ad8460_get_powerdown_mode(struct iio_dev *indio_dev,
> > > > > +				     const struct iio_chan_spec *chan) {
> > > > > +	return 0;  
> > > >
> > > > Why have the stubs in here?  
> > >
> > > Should I move the stubs to a different place in the code or remove
> > > them altogether since there is only a single powerdown mode available  
> > Ah. I'd not really understood what was going on here.  This is fine as is.
> >   
> > > > AD8460_HVDAC_DATA_WORD_HIGH(index),  
> > > > > +			    ((val >> 8) & 0xFF));  
> > > >
> > > > bulk write? or do these need to be ordered?  
> > >
> > > For this I used bulk read/write this way.
> > >
> > > static int ad8460_set_hvdac_word(struct ad8460_state *state,
> > > 				 int index,
> > > 				 int val)
> > > {
> > > 	u8 regvals[AD8460_DATA_BYTE_WORD_LENGTH];  
> > regmap bulk accesses (when spi anyway) should be provided with DMA safe
> > buffers.
> > Easiest way to do that is add one with __aligned(IIO_DMA_MINALIGN) to the
> > end of the ad8460_state structure.  Possibly you'll need a lock to protect it - I
> > haven't checked.  
> > >
> > > 	regvals[0] = val & 0xFF;
> > > 	regvals[1] = (val >> 8) & 0xFF;  
> > 
> > That is an endian conversion so use appropriate endian function to fill it
> > efficiently and document clearly what is going on.
> > 
> > 
> > 	put_unaligned_le16()
> >   
> > >
> > > 	return regmap_bulk_write(state->regmap,  
> > AD8460_HVDAC_DATA_WORD_LOW(index),  
> > > 				 regvals,  
> > AD8460_DATA_BYTE_WORD_LENGTH); }  
> > >
> > >  
> > > > > +}  
> >   
> > > > > +	state->regmap = devm_regmap_init_spi(spi, &ad8460_regmap_config);
> > > > > +	if (IS_ERR(state->regmap))
> > > > > +		return dev_err_probe(&spi->dev, PTR_ERR(state->regmap),
> > > > > +				     "Failed to initialize regmap");
> > > > > +
> > > > > +	ret = devm_iio_dmaengine_buffer_setup_ext(&spi->dev, indio_dev,
> > > > > +"tx",
> > > > > +  
> > > > IIO_BUFFER_DIRECTION_OUT);
> > > >
> > > > Ah. I take back my binding comment. I assume this is mapping some
> > > > non standard interface for the parallel data flow?  
> > >
> > > Yes, the HDL side doesn't follow yet the standard IIO backend from
> > > which this driver was tested  
> > 
> > Hmm. I'd like to see this brought inline with the other iio backend drivers if
> > possible.  
> 
> Does this mean that we would need to implement an AXI IP core on the
> FPGA side to be able to test this?

Don't think so.  That framework is meant to support any equivalent IP.
So whatever you have should be supportable. Maybe it's somewhat of a stub
driver though if there isn't anything controllable.

It's Nuno's area of expertise though +CC.

> 
> > 
> > Jonathan
> >   
> 
> 


