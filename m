Return-Path: <linux-iio+bounces-10398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D3E998EB0
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 19:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93871F211A3
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 17:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BBD1BDA90;
	Thu, 10 Oct 2024 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMDC4abn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28A019C55F;
	Thu, 10 Oct 2024 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582327; cv=none; b=IAI0+6iJBsodE1FIYBf9qlidGXbwpRFR0wXeZ/dxkZQfz/TZNEziRLFSMnTbqxtLgknVQ/Y40DPJvqhFSFB0lAraK32y3H68uX33NTBO6/Dp8IDCNaKgnXSfNdEWilv2BybiQP0BJ+UxzwqCNs3tifGWXwvBntHSDrbJtgJxAzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582327; c=relaxed/simple;
	bh=RsT2v/nQ06UoiZ1wTWD5mT5xjsc7b1twZLFJ8QkV0ig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nN9Og3hQ3++zqFskElJ+H1fcHFbQCXq9vyx7kESKUMm1aRUUTZddtej4fzkfEoxs8nUz4l1hGjDyf1fAKHrs6tJhpmjEZ2D3oSlUYFyCdpj/sM9BPJ93wJ81a15ZaIQtKOPuLNv5rOqV1VPMp35mYMR6cJXeiewsE6ITOZeUBUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMDC4abn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BA4C4CEC5;
	Thu, 10 Oct 2024 17:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728582326;
	bh=RsT2v/nQ06UoiZ1wTWD5mT5xjsc7b1twZLFJ8QkV0ig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SMDC4abn9tfAlDw2NocP1u5Nx6AOZXY6cKPdtCXViRneR4f0qL2j/bp3mKn1hUs2l
	 Z0H9Z82Oy3V+rMNPpIT8wxxPx5piTgdjhV2DcCbNMDxz+NySe+2r7oB6b9SsUr56bU
	 dEIo1qMRFrLjPxUCMQrC5yd+CtLaQ+8X9hZk7Uu4ZkSPs5HDeRDmJt6U8JVW49cgUp
	 zHQFz+wfNHF9u7vR4TrBgmfwapipQlvbgb6hQdivnLXjZGWxuIEHIimAlWLy9+9Cyl
	 SV6b8fwQWtfYOg2UNUmu2paXW0gVIDQAFoWaFMDEm5JgOW/ksgJsyGPK2bezTpHm0y
	 Qv7DVHC6wKvcA==
Date: Thu, 10 Oct 2024 18:45:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Nechita, Ramona" <Ramona.Nechita@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Dumitru Ceclan
 <mitrutzceclan@gmail.com>, Matteo Martelli <matteomartelli3@gmail.com>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] drivers: iio: adc: add support for ad777x family
Message-ID: <20241010184516.66826055@jic23-huawei>
In-Reply-To: <DM6PR03MB4315785FB25B980264748BCBF3782@DM6PR03MB4315.namprd03.prod.outlook.com>
References: <20240926135418.8342-1-ramona.nechita@analog.com>
	<20240926135418.8342-4-ramona.nechita@analog.com>
	<ZvV2mHkl4qxVVmBH@smile.fi.intel.com>
	<DM6PR03MB4315785FB25B980264748BCBF3782@DM6PR03MB4315.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 14:32:49 +0000
"Nechita, Ramona" <Ramona.Nechita@analog.com> wrote:

> Hello,
> 
> I have some questions inline before sending out a new patch.
> 
> 
> ....
> >> +struct ad7779_state {
> >> +	struct spi_device *spi;
> >> +	const struct ad7779_chip_info *chip_info;
> >> +	struct clk *mclk;
> >> +	struct iio_trigger *trig;
> >> +	struct completion completion;
> >> +	unsigned int sampling_freq;
> >> +	enum ad7779_filter filter_enabled;
> >> +	/*
> >> +	 * DMA (thus cache coherency maintenance) requires the
> >> +	 * transfer buffers to live in their own cache lines.
> >> +	 */
> >> +	struct {
> >> +		u32 chans[8];
> >> +		s64 timestamp;  
> >
> >	aligned_s64 timestamp;
> >
> >while it makes no difference in this case, this makes code aligned inside the IIO subsystem.  
> 
> I might be missing something but I can't find the aligned_s64 data type, should I define it myself
> in the driver?

Recent addition to the iio tree so it is in linux-next but not in mainline yet.
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=togreg&id=e4ca0e59c39442546866f3dd514a3a5956577daf
It just missed last cycle.

> 
> >  
> >> +	} data __aligned(IIO_DMA_MINALIGN);  
> >
> >Note, this is different alignment to the above. And isn't the buffer below should have it instead?

While I'm here:  No to this one.  The s64 alignment is about
performance of CPU access + consistency across CPU architectures.
This one (which happens to always be 8 or more) is about DMA safety.



> >  
> >> +	u32			spidata_tx[8];
> >> +	u8			reg_rx_buf[3];
> >> +	u8			reg_tx_buf[3];
> >> +	u8			reset_buf[8];
> >> +};  
> >
> >....
> >  
> >> +static int ad7779_write_raw(struct iio_dev *indio_dev,
> >> +			    struct iio_chan_spec const *chan, int val, int val2,
> >> +			    long mask)  
> >
> >long? Not unsigned long?  
> 
> I copied the function header directly from iio.h, shouldn't it be left as such?

Hmm. That's an ancient legacy that we should really cleanup at somepoint.
Leave this as long.


> 
> >  
> >> +{
> >> +	struct ad7779_state *st = iio_priv(indio_dev);
> >> +
> >> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> >> +		switch (mask) {
> >> +		case IIO_CHAN_INFO_CALIBSCALE:
> >> +			return ad7779_set_calibscale(st, chan->channel, val2);
> >> +		case IIO_CHAN_INFO_CALIBBIAS:
> >> +			return ad7779_set_calibbias(st, chan->channel, val);
> >> +		case IIO_CHAN_INFO_SAMP_FREQ:
> >> +			return ad7779_set_sampling_frequency(st, val);
> >> +		default:
> >> +			return -EINVAL;
> >> +		}
> >> +	}
> >> +	unreachable();
> >> +}  
> >
> >...
> >  
> >> +static irqreturn_t ad7779_trigger_handler(int irq, void *p) {
> >> +	struct iio_poll_func *pf = p;
> >> +	struct iio_dev *indio_dev = pf->indio_dev;
> >> +	struct ad7779_state *st = iio_priv(indio_dev);
> >> +	int ret;  
> >
> >...
> >  
> 
> Thank you!
> 
> Best Regards,
> Ramona
> 


