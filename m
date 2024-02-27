Return-Path: <linux-iio+bounces-3140-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6003869FFD
	for <lists+linux-iio@lfdr.de>; Tue, 27 Feb 2024 20:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8291F244E9
	for <lists+linux-iio@lfdr.de>; Tue, 27 Feb 2024 19:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7A25102E;
	Tue, 27 Feb 2024 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekZwLbZi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA191E894
	for <linux-iio@vger.kernel.org>; Tue, 27 Feb 2024 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061423; cv=none; b=lsWx7pZIspPmXhiFWgUdmNUS5lnSFaHvyEIQviBsThBcOeLn5INepiufgPbNqECZ3m7yFazp5VlkfrGFKzE+Z6YD6sXRfuPW9KXn+yCPIT5PHIaNkFAgyiTukBefl6mF90/i49v7fTaDAJ3476GDrVKy1lM5gIt9UgOwLNKRAGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061423; c=relaxed/simple;
	bh=xCVxHIQYv/i11ntDVv+OJy/+DmsSqSkrARGQVgh0FW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6qiFgCP61iP5xPJcGNC6zDR3lykQ/C9gsGDv06IHm3LMpS+7GujxQZPoJlALPUvruRaoFavihdvtFUfgFMgYFwXLxfekAw1LtWoqjiOa6d48Ksq3KZRDiMCR697m05Zpyuaryo/7wyOH33YcMqPXxbdsfjFgoVJx8T+YLdvA8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekZwLbZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2044FC433C7;
	Tue, 27 Feb 2024 19:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709061423;
	bh=xCVxHIQYv/i11ntDVv+OJy/+DmsSqSkrARGQVgh0FW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ekZwLbZi+FBtOoN8hUBF1TObGKzK/nNId7AK7d7oIemPdzmntuOdGCh7l2d9EQ34v
	 4vumPV96ZxZS+EXvO9v0N0czhPNMRzzrrYwCtZQ42mAZsRU/RlYe4iZCL6GbRzLeF9
	 zYCl2m1lZAII0PGrL2mfkW7ctO9W0t/Tf0UmF1qfwa7hvZ07kUiRPHa7+jwoy4dsR8
	 KVMNM2KKgTFvJfTet6NsnAl+paLW5n2G57fEQjOKUZe3A1GAw2b+bN+JcXOmRC/kjw
	 aJ03GslBaaPgCeBnM6MxRwBlvcOJ7WPaZEGWk+RddLWQnhIqFehBTeByCrKPQoF9e+
	 QjOmij/2/51cg==
Date: Tue, 27 Feb 2024 19:16:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Mihail Chindris <mihail.chindris@analog.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Tomislav Denis
 <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Marijn Suijten
 <marijn.suijten@somainline.org>, Marius Cristea
 <marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 4/9] iio: adc: rzg2l_adc: Use
 device_for_each_child_node_scoped()
Message-ID: <20240227191649.1354500f@jic23-huawei>
In-Reply-To: <OSZPR01MB701960E650277C6390C0A722AA592@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20240224123215.161469-1-jic23@kernel.org>
	<20240224123215.161469-5-jic23@kernel.org>
	<OSZPR01MB701960E650277C6390C0A722AA592@OSZPR01MB7019.jpnprd01.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 09:52:28 +0000
Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Switching to the _scoped() version removes the need for manual calling of fwnode_handle_put() in the
> > paths where the code exits the loop early. In this case that's all in error paths.
> > 
> > Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/adc/rzg2l_adc.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> >   
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
I already picked up some of this series piecemeal so I'll keep going!

Applied to the togreg branch of iio.git and pushed out as testing for 0-day to take a look.

Thanks!

Jonathan

> Cheers,
> Prabhakar
> 
> > diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c index
> > 0921ff2d9b3a..cd3a7e46ea53 100644
> > --- a/drivers/iio/adc/rzg2l_adc.c
> > +++ b/drivers/iio/adc/rzg2l_adc.c
> > @@ -302,7 +302,6 @@ static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)  static int
> > rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l_adc *adc)  {
> >  	struct iio_chan_spec *chan_array;
> > -	struct fwnode_handle *fwnode;
> >  	struct rzg2l_adc_data *data;
> >  	unsigned int channel;
> >  	int num_channels;
> > @@ -330,17 +329,13 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
> >  		return -ENOMEM;
> > 
> >  	i = 0;
> > -	device_for_each_child_node(&pdev->dev, fwnode) {
> > +	device_for_each_child_node_scoped(&pdev->dev, fwnode) {
> >  		ret = fwnode_property_read_u32(fwnode, "reg", &channel);
> > -		if (ret) {
> > -			fwnode_handle_put(fwnode);
> > +		if (ret)
> >  			return ret;
> > -		}
> > 
> > -		if (channel >= RZG2L_ADC_MAX_CHANNELS) {
> > -			fwnode_handle_put(fwnode);
> > +		if (channel >= RZG2L_ADC_MAX_CHANNELS)
> >  			return -EINVAL;
> > -		}
> > 
> >  		chan_array[i].type = IIO_VOLTAGE;
> >  		chan_array[i].indexed = 1;
> > --
> > 2.44.0  
> 


