Return-Path: <linux-iio+bounces-4652-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8F08B6308
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 22:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DF6CB209F3
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 20:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C99B13F006;
	Mon, 29 Apr 2024 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC94438H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08A5128807
	for <linux-iio@vger.kernel.org>; Mon, 29 Apr 2024 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420867; cv=none; b=J34h4grxDeHBe5DOkecVj4Rz9d3IC46I5b3CDgajWp1mZ2Gq1om3AnxtD2FZCLfXU+26CoMuvqPqTvybAZZQpsD3vxP5rdQxxdJ5u2Hv/RflC6lJtDP7cce2tR4vxox1/BRytZv41CzvQOr2nWSHsPgwSAfu46dq83zXVg3+fDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420867; c=relaxed/simple;
	bh=rmhBbX6yZNFZ3tRjvoeq5Dc6SVHbmADEDajlg4YKIGA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7KEYZCjV87f61g7P4O1pIYLn9A9njmZECRV7OmyCuR/GocRcc45b+TvnjIuKlIMyxCGvrO318Vf+YLes6TcYk2/78qtZH7ZvEPHpiTCY810fGQD1vTaiNlhhp2BhvrKK7QbTn7qV1uSZxl2DqrkOwnQaUZinogirIFc0/TV64k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PC94438H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F4FC113CD;
	Mon, 29 Apr 2024 20:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714420866;
	bh=rmhBbX6yZNFZ3tRjvoeq5Dc6SVHbmADEDajlg4YKIGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PC94438H7rrkmOlGJqxQ4DX7rEn4vmabERpoITAGYQvQBYSwAZgIiJGAhmr0LafbK
	 yHfjg4/N1Ua5om5n88YjXm9A5lSP4bHhmnaxaH4DiprWBZgqRxZ3ar4cJwtmHJ7DbK
	 oL3TOBwGOmpBu/J8MDUdx0gVwBZVJJRsngwBIQ76hyClMRbqbNXYTNTncx6uebpMEQ
	 +iBKibAqx2GjEFbUWshcDJhoygQArzrR1J7eCiMq2u3R+e+QOED3xLWSuel88fmLju
	 2DzsVZHRmTvyQASGJ/7Sjqn0udace028MoW5pV5sjfgA14teXl4Plovd8upOcWONyv
	 1d3iKW+ScPXow==
Date: Mon, 29 Apr 2024 21:00:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: linux-iio@vger.kernel.org, Marius Cristea
 <marius.cristea@microchip.com>, Marek Vasut <marex@denx.de>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 1/2] iio: adc: mcp3564: Use
 device_for_each_child_node_scoped()
Message-ID: <20240429210055.11d0e644@jic23-huawei>
In-Reply-To: <20240429205623.7e725274@jic23-huawei>
References: <20240428174020.1832825-1-jic23@kernel.org>
	<20240428174020.1832825-2-jic23@kernel.org>
	<Zi6w1V9mBWZAMv-t@debian-BULLSEYE-live-builder-AMD64>
	<20240429205623.7e725274@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 20:56:23 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 28 Apr 2024 17:25:57 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > Hi Jonathan,
> > 
> > This also looks good to me.
> > 
> > Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>  
> Thanks,
> 
> Applied.
> 
> 1 to go. Someone must want to give the ads1015 patch the love
> it needs? :)
Ah. There was another patch for the same driver doing the same
thing. I picked that one up instead. Problem solved.

Jonathan

> 
> Jonathan
> 
> > 
> > On 04/28, Jonathan Cameron wrote:  
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > Switching to the _scoped() version removes the need for manual
> > > calling of fwnode_handle_put() in the paths where the code
> > > exits the loop early. In this case that's all in error paths.
> > > 
> > > Cc: Marius Cristea <marius.cristea@microchip.com>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  drivers/iio/adc/mcp3564.c | 16 +++++++---------
> > >  1 file changed, 7 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
> > > index 311b613b6057..e2ae13f1e842 100644
> > > --- a/drivers/iio/adc/mcp3564.c
> > > +++ b/drivers/iio/adc/mcp3564.c
> > > @@ -998,7 +998,6 @@ static int mcp3564_parse_fw_children(struct iio_dev *indio_dev)
> > >  	struct mcp3564_state *adc = iio_priv(indio_dev);
> > >  	struct device *dev = &adc->spi->dev;
> > >  	struct iio_chan_spec *channels;
> > > -	struct fwnode_handle *child;
> > >  	struct iio_chan_spec chanspec = mcp3564_channel_template;
> > >  	struct iio_chan_spec temp_chanspec = mcp3564_temp_channel_template;
> > >  	struct iio_chan_spec burnout_chanspec = mcp3564_burnout_channel_template;
> > > @@ -1025,7 +1024,7 @@ static int mcp3564_parse_fw_children(struct iio_dev *indio_dev)
> > >  	if (!channels)
> > >  		return dev_err_probe(dev, -ENOMEM, "Can't allocate memory\n");
> > >  
> > > -	device_for_each_child_node(dev, child) {
> > > +	device_for_each_child_node_scoped(dev, child) {
> > >  		node_name = fwnode_get_name(child);
> > >  
> > >  		if (fwnode_property_present(child, "diff-channels")) {
> > > @@ -1033,26 +1032,25 @@ static int mcp3564_parse_fw_children(struct iio_dev *indio_dev)
> > >  							     "diff-channels",
> > >  							     inputs,
> > >  							     ARRAY_SIZE(inputs));
> > > +			if (ret)
> > > +				return ret;
> > > +
> > >  			chanspec.differential = 1;
> > >  		} else {
> > >  			ret = fwnode_property_read_u32(child, "reg", &inputs[0]);
> > > +			if (ret)
> > > +				return ret;
> > >  
> > >  			chanspec.differential = 0;
> > >  			inputs[1] = MCP3564_AGND;
> > >  		}
> > > -		if (ret) {
> > > -			fwnode_handle_put(child);
> > > -			return ret;
> > > -		}
> > >  
> > >  		if (inputs[0] > MCP3564_INTERNAL_VCM ||
> > > -		    inputs[1] > MCP3564_INTERNAL_VCM) {
> > > -			fwnode_handle_put(child);
> > > +		    inputs[1] > MCP3564_INTERNAL_VCM)
> > >  			return dev_err_probe(&indio_dev->dev, -EINVAL,
> > >  					     "Channel index > %d, for %s\n",
> > >  					     MCP3564_INTERNAL_VCM + 1,
> > >  					     node_name);
> > > -		}
> > >  
> > >  		chanspec.address = (inputs[0] << 4) | inputs[1];
> > >  		chanspec.channel = inputs[0];
> > > -- 
> > > 2.44.0
> > > 
> > >     
> >   
> 


