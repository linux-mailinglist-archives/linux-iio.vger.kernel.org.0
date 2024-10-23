Return-Path: <linux-iio+bounces-10986-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 032229ACB29
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 15:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF18D1F228AC
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 13:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D891ADFF7;
	Wed, 23 Oct 2024 13:27:44 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCC31DFEF;
	Wed, 23 Oct 2024 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690064; cv=none; b=Y11nwtwbQ0Puy/7mu/gmuIimRYqEYx9PMI9tORnovpOID/oWF0Iqi67w5zG2f9gx1JgXG9WD6EDU0qINnvTFaUrB1eMWcQWIgSpFnrge8y52/NVhqrbtJUHdES6JRQjezUtx+a7SI+lErAKYpm3WYOWuIIdTixwTadSLORbVBmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690064; c=relaxed/simple;
	bh=F2ZxZPlaC9l+JfMZiw3EGc1lSCa3SkUfM7rIWrIRM4k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZwwXTImN9z+Hk11ZmY9QlmEIJ8XWuY31rQq97GPsN2N+/gVWSxcBq3En/S8ycDBoy+fdJr3YPX38qmK5uoaP0K9Cyq1xl57woOVZbVXUDnxb1reLyns+LGZJXFTqOVtExeQSDzKthinffd0jVQ3LaS4fLJmC7uZGH+D51BdZiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XYV8x6NhWz6LD2C;
	Wed, 23 Oct 2024 21:22:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E4291400F4;
	Wed, 23 Oct 2024 21:27:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 23 Oct
 2024 15:27:37 +0200
Date: Wed, 23 Oct 2024 14:27:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Per-Daniel Olsson <perdaniel.olsson@axis.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<rickard.andersson@axis.com>, <kernel@axis.com>
Subject: Re: [PATCH v4 2/2] iio: light: Add support for TI OPT4060 color
 sensor
Message-ID: <20241023142735.000018cb@Huawei.com>
In-Reply-To: <10d6bba4-4d25-4ee0-877e-48a27c622bde@axis.com>
References: <20241016213409.3823162-1-perdaniel.olsson@axis.com>
	<20241016213409.3823162-3-perdaniel.olsson@axis.com>
	<20241020135105.36b29fe8@jic23-huawei>
	<10d6bba4-4d25-4ee0-877e-48a27c622bde@axis.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 23 Oct 2024 09:29:08 +0200
Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:

> Hi Jonathan,
> 
> Thank you for your feedback, much appreciated. I have added questions and
> comments inline below regarding channels and triggers. I will address the other
> comments in the next patch.
> 
> Best regards / Per-Daniel
> 
> On 10/20/24 14:51, Jonathan Cameron wrote:
> > On Wed, 16 Oct 2024 23:34:09 +0200
> > Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:
> >   
> >> Add support for Texas Instruments OPT4060 RGBW Color sensor.
> >>
> >> Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>  
> > 
> > Hi Per-Daniel,
> > 
> > Comments inline.
> > 
> > Jonathan
> >   
> >> diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
> >> new file mode 100644
> >> index 000000000000..2c3761ec423a
> >> --- /dev/null
> >> +++ b/drivers/iio/light/opt4060.c
> >> @@ -0,0 +1,1259 @@  
> > 
> > ...
> >   
> >> +
> >> +struct opt4060_buffer {
> >> +	u32 chan[OPT4060_NUM_CHANS];
> >> +	s64 ts __aligned(8);  
> > 
> > aligned_s64 is now available in linux-next + the IIO tree.
> >   
> >> +};
> >> +
> >> +static const struct opt4060_channel_factor opt4060_channel_factors[] = {
> >> +	{
> >> +		/* RED 2.4 * 2.15e-3 */  
> > This needs more details on wrt to what standard etc.
> > 
> > The datasheet is a little vague, but it seems to me like TI invented their
> > own standard. To use this stuff in a consistent ABI we need to have
> > a common standard or at least an approximation of one.
> > The illuminance estimates from some devices are bad approximations, but they
> > are at least attempting to approximate a well defined standard.  
> 
> I have read the datasheet again to try to figure out what TI means. When I read
> it now with your remarks from this email and previous emails in mind, I think I'm
> starting to understand more.
> 
> I think we should expose the data from the sensor in the following way:
> - Four raw channels (R, G, B and Clear)
> - Three processed IIO_INTENSITY channels with normalized values (R, G, B)
>   to get the relative color components independent of light intensity.
> - One IIO_LIGHT channel giving the lux value.
> 
> This is basically what TI is stating in chapter 8.4.5.2. I know that you don't
> like how TI are calculating the lux value using the green channel. But after
> reading the description and detailed description parts of the datasheet again,
> I think it sort of makes sense. Looking at the spectral response curves on the
> first page, the green curve covers the whole visible spectrum. It seems like this
> is what the sensor is actually designed for, measuring light intensity in lux and
> color independent of the light intensity.
> 
> Does this sound like a way forward you think?
Not keen on the colour part.

As far as I can tell TI made up a colour standard.  If it were
CIE 1931 RGB or then 'maybe' we could consider presenting them as processed,
though as they are linear scales even then should present _raw and _scale, not
_input (processed).  We would still need to figure out if we needed to handle
multiple colour space definitions.
As it is, if we have two different colour sensors, there is no way to compare the
values.  In particular that Green is way too broad for the colour standards
I quickly compared this with.

The green curve does (based on eyeballing it rather than anything formal)
look much closer to the luminosity function (one used for illuminance)
than I was assuming (given it's called green!)

So not ideal but that one feels ok (with comments in the code explaining
this) to use for illuminance.


For the color channels maybe we could present with _scale provided
if we add suitable documentation to say that the scaling is to arbitrary
datasheet specified normalization and that the resulting _raw * _scale
values cannot be compared across different sensors. I don't like that
but it does seem silly to not present the scaling if it might be useful
to someone.  So if you want to do this, propose some additions
to Documentation/testing/ABI/sysfs-bus-iio
to cover this for in_intensity_red_scale
etc.

Jonathan



