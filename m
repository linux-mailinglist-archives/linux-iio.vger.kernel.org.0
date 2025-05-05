Return-Path: <linux-iio+bounces-19098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0973CAA9425
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 15:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB233AC2B7
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 13:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5772324EA9D;
	Mon,  5 May 2025 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErlmEeoQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A52A2441A7;
	Mon,  5 May 2025 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746450845; cv=none; b=nEeof6QjRGnUX34sIKegM3j1vXryQ6KrjC7slEF9K6oFUdiW9Ytx6mbmlPhFOyjU9QVqLEuZISM7InO4uC7U7ywnF8/5bHnflrHgc7XX8dd+51bx1J1XmK+KdTor46k+uPtemTLzsr5PM6rETvDcV9NTTg9vMOUSmSeW7sdZZqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746450845; c=relaxed/simple;
	bh=rh5r3++/cA66sANgpELESWc1a6Bz3LRTgNCDDH+oo78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WSnxrwofwbqvTU+KTsOJXX8QMWgBXXLOjqDZsVj2vbwLdiFdHZZ6J8smjcTT2x+ci5TrkvaZ4qq9sZvMmWI3Suj1EQU0iny+pB3TwTZru/Q6K2c+uXOPluA6hH1zqna1fBdmF4yzZTUxqCTVzBXeH4aNVEAVzPz5T8idBeKDmx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErlmEeoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9E9C4CEEF;
	Mon,  5 May 2025 13:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746450844;
	bh=rh5r3++/cA66sANgpELESWc1a6Bz3LRTgNCDDH+oo78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ErlmEeoQS4jRoMaKLfhNgYD6aSH4PLxk8/OSxa3ZfiRiwh7JSoen7nlZoJF64Co5F
	 zCKICpaqCMziHVxoxTmVXm/04lZ2KQEf2P8J6JvjgOtwYZqrEeAQsXHc5cRBrxu2j0
	 z2v+ZAy/v1Gh9AkEm9GnV1wroOqSU984Er3P7ZtJtFVT7QQupvJJ7L8QMefDydEdzK
	 xKdt80+RfT0/GJio1SJy5ubXyasdcaW3ZWxX/y0KfQburHe13LHfNwC/bpkkWN07X9
	 aBB7ICWkumiVsJzm/yt5cGaWL4OxfLD6L0i2fFATmKDse1cnKLN8CBJDWO1PkZld5a
	 mivzKzIzwYXjw==
Date: Mon, 5 May 2025 14:13:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: imu: bmi270: add channel for step counter
Message-ID: <20250505141357.4d1760bf@jic23-huawei>
In-Reply-To: <swswxbwejqyrekr2bvjf4p5lglodg3hlgl5ckiluxpazzl3chn@ga3uriqvmv7b>
References: <20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com>
	<20250424-bmi270-events-v1-1-a6c722673e5f@gmail.com>
	<20250426144020.2633f9cb@jic23-huawei>
	<swswxbwejqyrekr2bvjf4p5lglodg3hlgl5ckiluxpazzl3chn@ga3uriqvmv7b>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Apr 2025 21:19:13 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> On Sat, Apr 26, 2025 at 02:40:20PM +0100, Jonathan Cameron wrote:
> > On Thu, 24 Apr 2025 21:14:50 -0300
> > Gustavo Silva <gustavograzs@gmail.com> wrote:
> >   
> > > Add a channel for enabling/disabling the step counter, reading the
> > > number of steps and resetting the counter.
> > > 
> > > Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>  
> > Hi Gustavo,
> > 
> > This is tripping over the somewhat theoretical requirement for
> > regmap to be provided with DMA safe buffers for bulk accesses.
> > 
> > Jonathan
> >   
> 
> Hi Jonathan,
> 
> Thanks for the review. I've got a few questions inline.
> 
> > > ---
> > >  drivers/iio/imu/bmi270/bmi270_core.c | 127 +++++++++++++++++++++++++++++++++++
> > >  1 file changed, 127 insertions(+)
> > > 
> > > diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> > > index a86be5af5ccb1f010f2282ee31c47f284c1bcc86..f09d8dead9df63df5ae8550cf473b5573374955b 100644
> > > --- a/drivers/iio/imu/bmi270/bmi270_core.c
> > > +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> > > @@ -31,6 +31,8 @@  
> >   
> > >  /* See datasheet section 4.6.14, Temperature Sensor */
> > >  #define BMI270_TEMP_OFFSET				11776
> > >  #define BMI270_TEMP_SCALE				1953125
> > > @@ -111,6 +118,7 @@ struct bmi270_data {
> > >  	struct iio_trigger *trig;
> > >  	 /* Protect device's private data from concurrent access */
> > >  	struct mutex mutex;
> > > +	int steps_enabled;  
> > 
> > Seems a little odd to have a thing called _enabled as an integer.
> > Probably better as a bool even though that will require slightly more
> > code to handle read / write.
> >   
> I agree that a bool might be more appropriate in this case. I decided to
> use an int to keep consistency with other drivers, specifically bma400
> and the iio dummy driver.
> If you prefer, I'll use a bool here and after this series submit a patch
> updating those drivers as well.

Yes. I think that would be a nice little logical improvement here and in those
drivers.  Not particularly critical though!

> 
> >   
> > >  
> > >  	/*
> > >  	 * Where IIO_DMA_MINALIGN may be larger than 8 bytes, align to
> > > @@ -282,6 +290,99 @@ static const struct  bmi270_odr_item bmi270_odr_table[] = {
> > >  	},
> > >  };
> > >  
> > > +enum bmi270_feature_reg_id {
> > > +	BMI270_SC_26_REG,
> > > +};
> > > +
> > > +struct bmi270_feature_reg {
> > > +	u8 page;
> > > +	u8 addr;
> > > +};
> > > +
> > > +static const struct bmi270_feature_reg bmi270_feature_regs[] = {
> > > +	[BMI270_SC_26_REG] = {
> > > +		.page = 6,
> > > +		.addr = 0x32,
> > > +	},
> > > +};
> > > +
> > > +static int bmi270_write_feature_reg(struct bmi270_data *data,
> > > +				    enum bmi270_feature_reg_id id,
> > > +				    u16 val)
> > > +{
> > > +	const struct bmi270_feature_reg *reg = &bmi270_feature_regs[id];
> > > +	int ret;
> > > +
> > > +	ret = regmap_write(data->regmap, BMI270_FEAT_PAGE_REG, reg->page);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return regmap_bulk_write(data->regmap, reg->addr, &val, sizeof(val));  
> > 
> > For a regmap on top of an SPI bus. I think we are still requiring DMA safe
> > buffers until we can get confirmation that the API guarantees that isn't
> > needed.  (there is another thread going on where we are trying to get that
> > confirmation).
> > 
> > That is a pain here because this can run concurrently with buffered
> > capture and as such I think we can't just put a additional element after
> > data->data but instead need to mark that new element __aligned(IIO_DMA_MINALIGN)
> > as well (and add a comment that it can be used concurrently with data->data).
> >  
> Just to clarify, when you say data->data, are you referring to the
> bmi270_data::buffer variable? That used to be called 'data' but it was
> changed to 'buffer' in commit 16c94de2a.

Yes.  The one marked __aligned(IIO_DMA_MINALIGN)
I was looking at old code I guess!

Jonathan

