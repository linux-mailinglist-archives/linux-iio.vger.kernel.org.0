Return-Path: <linux-iio+bounces-535-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C19E3801257
	for <lists+linux-iio@lfdr.de>; Fri,  1 Dec 2023 19:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A201C20D7A
	for <lists+linux-iio@lfdr.de>; Fri,  1 Dec 2023 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7144F1EA;
	Fri,  1 Dec 2023 18:14:39 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED0C106;
	Fri,  1 Dec 2023 10:14:35 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Shh0t1H5Wz6813Y;
	Sat,  2 Dec 2023 02:09:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 56646140135;
	Sat,  2 Dec 2023 02:14:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Dec
 2023 18:14:31 +0000
Date: Fri, 1 Dec 2023 18:14:30 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <579lpy@gmail.com>,
	<lars@metafoo.de>, <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iio: humidity: Add driver for ti HDC302x
 humidity sensors
Message-ID: <20231201181430.00002634@Huawei.com>
In-Reply-To: <570ea978-4ffc-48fa-92df-463f84610a5f@gmail.com>
References: <20231125102221.2795-1-579lpy@gmail.com>
	<20231125145208.01194d91@jic23-huawei>
	<570ea978-4ffc-48fa-92df-463f84610a5f@gmail.com>
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

On Thu, 30 Nov 2023 19:59:03 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> Hi,
> 
> On 25.11.23 15:52, Jonathan Cameron wrote:
> >> +
> >> +static const struct iio_chan_spec hdc3020_channels[] = {
> >> +	{
> >> +		.type = IIO_TEMP,  
> > 
> > There is only one temp channel so I'd like to see the peaks added to this
> > one as well.  Can be done if we add a new bit of ABI for the min value
> > seen.
> > 
> > Whilst naming .index = 0, .channel = 0 is different from this case
> > the ABI and all userspace software should treat them the same hence this
> > is an ambiguous channel specification.
> >   
> >> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >> +		BIT(IIO_CHAN_INFO_SCALE),
> >> +	},
> >> +	{
> >> +		/* For minimum value during measurement */  
> > 
> > Please add some docs for this - preferably in patch description
> > or cover letter if it is too long for there. You are using the ABI in a fashion
> > not previously considered.
> > 
> > I don't think it is a good solution.  Perhaps keeping IIO_CHAN_INFO_PEAK
> > as assumed to be maximum, we could add a new IIO_CHAN_INFO_TROUGH
> > perhaps?  Hopefully the scale applies to both peak and trough so we
> > don't need separate attributes.
> >   
> If only IIO_CHAN_INFO_TROUGH is added without an additional _SCALE, in
> this particular case you end up having the following sysfs entries:
> 
> in_humidityrelative_peak_raw
> in_humidityrelative_peak_scale
> in_temp_peak_raw
> in_temp_peak_scale
> in_humidityrelative_trough_raw
> in_temp_trough_raw
> 
> I just would like to know if documenting the trough attribute in a way
> that it is clear that the peak_scale applies for it as well is better
> than adding a TROUGH_SCALE. We would save the additional attribute, but
> at first sight it is not that obvious (it makes sense that the scale is
> the same for both peaks, but the names are not so consistent anymore).

Agreed this isn't that intuitive. 

> 
> I suppose that often the raw and peak scales are also the same, but
> there are indeed two separate attributes. On the other hand I don't know
> if the additional attribute would imply bigger issues (maintenance,
> documentation, etc) than just adding the line, so I leave the question open.

I wonder if we should have the ABI state that peak_scale is only applicable
it it overrides the _scale value.  Here I think they are the same anyway
thus not providing peak_scale would leave us with a single attribute reflecting
scale of _raw, _peak_raw and _trough_raw

I think this is already the case in reality.  We have two users of the peak interface
and only one of them provides peak_scale.  Hopefully hdc2010 is
assuming _scale applies to it.

So maybe this is just a documentation update and drop peak_scale from this
driver.

Jonathan
> 
> Thank you and best regards,
> Javier Carrasco
> 


