Return-Path: <linux-iio+bounces-9916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D595989D1D
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 10:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF74281D88
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 08:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA7017E473;
	Mon, 30 Sep 2024 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wf3UqaKF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD817C219;
	Mon, 30 Sep 2024 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685913; cv=none; b=PHsjD4xVvFBK2maFBsSiKRIab019xv1eykqPqgvLQo7oMT3HLQSvOPKu55hhmJFTeMaZMU/yQJ3rcxljbbO/f+/163ieYSr2YEs/nalEuZJwg4IdirK13SZXfegwGL7/cIA/yimruuxB3uy6yFoKo4vFiXg3ofTJ4RS+y3euT1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685913; c=relaxed/simple;
	bh=8v2BFCQwEyRP/lKr7FZGb4mMbrvidJoepvthlT6jZPY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B56bYcbsq5tuHNZ5bASVvWcJbf659m/e1e9tFln5MeCpXMhPo4Av/XqIK8GOWzxrq8m9PhryLCBUteCWkstWPam/ExyCIlGZigRQZDAZrpENpedK1NU68jx0t0TdlQ6JstInJUGkbGp+Hh7Bf8EULZiFTgw6cZQ88Y1ChTaICvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wf3UqaKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B883C4CEC7;
	Mon, 30 Sep 2024 08:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727685912;
	bh=8v2BFCQwEyRP/lKr7FZGb4mMbrvidJoepvthlT6jZPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wf3UqaKFKfgVWRzrytnOMrjJiTuwRwT+MSptyH/2T0lnjx8yZTbD9bmrAFzE2JMYP
	 RnFMHg0W62U4a7iycm08jyhLtH8UT4sVPHtwypEBJfae9hQ54MfA3TN3Mpdh1LSqgQ
	 aeLdL9kcj0vfw3vC2HgSmNLBvgTt1PTsb1SrcZ/JIe0fz5EPurXjWIe7M99rywqh24
	 genwSGQPJAMqWfBsEvlMBhwVl3PP2w1PDStk3cNYtrGNImklx437r6KuvXyux+46UD
	 eqY0llwFf/smJLeP/c4MYaLARm+6aIy6tq+3oa9YY/iRQufk0WaDPK2MUC6eP5aAPH
	 zQMgDaX+FJLTQ==
Date: Mon, 30 Sep 2024 09:45:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 06/10] iio: light: veml6030: use read_avail() for
 available attributes
Message-ID: <20240930094503.459b4382@jic23-huawei>
In-Reply-To: <b4a72e65-b8b0-41da-ac6e-372371f3943a@gmail.com>
References: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
	<20240923-veml6035-v2-6-58c72a0df31c@gmail.com>
	<20240928171922.0caccaf3@jic23-huawei>
	<b4a72e65-b8b0-41da-ac6e-372371f3943a@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Sep 2024 20:45:40 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 28/09/2024 18:19, Jonathan Cameron wrote:
> > On Mon, 23 Sep 2024 00:17:54 +0200
> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> >   
> >> Drop custom attributes by using the standard read_avail() callback to
> >> read scale and integration time. When at it, define these attributes as
> >> available by all channels, as they affect the values of both the ALS and
> >> the WHITE channel.
> >>
> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
> > Hi Javier
> > 
> > Some comments inline
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> >> ---
> >>  drivers/iio/light/veml6030.c | 64 +++++++++++++++++++++++++++++++-------------
> >>  1 file changed, 45 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> >> index 89c98bfc5191..a3190fab3add 100644
> >> --- a/drivers/iio/light/veml6030.c
> >> +++ b/drivers/iio/light/veml6030.c
> >> @@ -58,25 +58,24 @@ struct veml6030_data {
> >>  	int cur_integration_time;
> >>  };
> >>  
> >> -/* Integration time available in seconds */
> >> -static IIO_CONST_ATTR(in_illuminance_integration_time_available,
> >> -				"0.025 0.05 0.1 0.2 0.4 0.8");
> >> +static const int veml6030_it_times[][2] = {
> >> +	{0, 25000},  
> > Really minor but I'm trying to get IIO standardized on formatting for this
> > sort of array and I'd like not to introduce more instances of it
> > done without the extra spaces as it will just give more to clean up
> > at some point.
> > 
> > 	{ 0, 25000 },
> > etc please.  
> >> +	{0, 50000},
> >> +	{0, 100000},
> >> +	{0, 200000},
> >> +	{0, 400000},
> >> +	{0, 800000},
> >> +};
> >>  
> >>  /*
> >>   * Scale is 1/gain. Value 0.125 is ALS gain x (1/8), 0.25 is
> >>   * ALS gain x (1/4), 1.0 = ALS gain x 1 and 2.0 is ALS gain x 2.
> >>   */
> >> -static IIO_CONST_ATTR(in_illuminance_scale_available,
> >> -				"0.125 0.25 1.0 2.0");
> >> -
> >> -static struct attribute *veml6030_attributes[] = {
> >> -	&iio_const_attr_in_illuminance_integration_time_available.dev_attr.attr,
> >> -	&iio_const_attr_in_illuminance_scale_available.dev_attr.attr,
> >> -	NULL
> >> -};
> >> -
> >> -static const struct attribute_group veml6030_attr_group = {
> >> -	.attrs = veml6030_attributes,
> >> +static const int veml6030_scale_vals[][2] = {
> >> +	{0, 125000},
> >> +	{0, 250000},
> >> +	{1, 0},
> >> +	{2, 0},  
> > 
> > As above, add some spaces for minor readability improvement.
> >   
> >>  };
> >>  
> >>  /*
> >> @@ -197,9 +196,11 @@ static const struct iio_chan_spec veml6030_channels[] = {
> >>  		.type = IIO_LIGHT,
> >>  		.channel = CH_ALS,
> >>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >> -				BIT(IIO_CHAN_INFO_PROCESSED) |
> >> -				BIT(IIO_CHAN_INFO_INT_TIME) |
> >> -				BIT(IIO_CHAN_INFO_SCALE),
> >> +				BIT(IIO_CHAN_INFO_PROCESSED),
> >> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
> >> +					       BIT(IIO_CHAN_INFO_SCALE),  
> > This bit is an ABI change and technically old code wasn't a bug, so
> > we don't really have a good enough reason to change it.  So Please
> > leave these as separate.
> >   
> >> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> >> +						     BIT(IIO_CHAN_INFO_SCALE),  
> > That doesn't stop us sharing the available as that always was shared
> > in the attribute naming above.
> >   
> >>  		.event_spec = veml6030_event_spec,
> >>  		.num_event_specs = ARRAY_SIZE(veml6030_event_spec),
> >>  	},
> >> @@ -210,6 +211,10 @@ static const struct iio_chan_spec veml6030_channels[] = {
> >>  		.channel2 = IIO_MOD_LIGHT_BOTH,
> >>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >>  				BIT(IIO_CHAN_INFO_PROCESSED),
> >> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
> >> +					       BIT(IIO_CHAN_INFO_SCALE),  
> > This confuses me.  Is it fixing a bug by effectively adding attributes for this
> > channel that were previously missing? If so we'll have to go with searpte
> > even though they are shared to avoid breaking the ABI for other channel.
> >   
> >> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> >> +						     BIT(IIO_CHAN_INFO_SCALE),
> >>  	},
> >>  };
> >>    
> > 
> >   
> 
> This confused me as well, because even though the attributes where
> defined as separate for the ALS channel, modifying their values affected
> the values from the WHITE channel.
> 
> The integration time and the scale affect both channels, and therefore I
> thought they should be shared attributes. But in that case, and to avoid
> breaking the ABI for the other channel, I will make them separate even
> though writing to one of them will change the value of the other as well.
Yes.  The ABI fortunately always allows that sort of cross effect as we
have devices where similar controls affect some but not all channels on
a device, or different types of channel, but still not all channels.
Our fairly simple hierarchical sharing scheme never describes those.

Here we will have to take advantage of that being allowed even though
the driver should have had these shared in the first place :(

Jonathan

> 
> Thanks and best regards,
> Javier Carrasco
> 


