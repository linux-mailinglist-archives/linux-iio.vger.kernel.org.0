Return-Path: <linux-iio+bounces-12895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAB79DF31A
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 21:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218B3280A11
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 20:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A2B1AAE18;
	Sat, 30 Nov 2024 20:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEnQexRr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1E417BD3;
	Sat, 30 Nov 2024 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732999401; cv=none; b=ER86NGpnjYHA8pkJSsRHwueC1GXXgpwmhxmPSnlKgbfaQDAiGLDSkLzqIOk6k+8f2I5sJ/7ZWx7TFUfQnZRIcJ9yR0dTWcD4oIXl+1i9FPsL8NYFwdBbMsuOn8KkTIF3+Dex4wQNGZ8Q1xaenItquQA5CDD2biLbJxGCQXqfNBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732999401; c=relaxed/simple;
	bh=1/d2lkJxTt325fHu/Rfo+74878k4UztsbL+VWXx4dFw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejzv1aa8Q3aQMRCEU2zZrXU/AUHvzW2ymJhe4plCxM6N8sT8UV8CQyNPXwqMs/H6IrNGUwWEXLKS8vs8FtheFCPEdLmBfCBgwhuV/VBXe7NOtm+QlmTwxo2hRX60dNVHhqdm8N81P3oRWs8pYF61tdMDyE2Bj1g6V9E2hjvCLOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEnQexRr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22B8C4CECC;
	Sat, 30 Nov 2024 20:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732999400;
	bh=1/d2lkJxTt325fHu/Rfo+74878k4UztsbL+VWXx4dFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mEnQexRr3I5IKuO1rsl75XrEFENKi8IQdMyDIo918iEFBlB3SxTR3Y5l3JbFRrCZF
	 UoU1uL2YJ+Sn8JsxSGl9uaK1p7j/gHtGDgev/PmL/OIMC2Q5QGEMYGIneUvYdiqKf0
	 3OvFUAgUxfucvwp7iXRzxuexJtN8IoNFvt1I3JVV/p4XC7KEcA+25Guw+W6NEkTDf1
	 2YlhjBTD0L0mk97mtp33vsZGWxAVbyHIN6TdvQFoEJuBEcvBYfvbhL/oAoA8C2xHMk
	 S119rCjWJCkz+RPAC6/Q+8qiDifYfqDdcUEr3J9MId+aV1FGZsUeVustaEc3yVbnbu
	 fIMfI98MQFbkg==
Date: Sat, 30 Nov 2024 20:43:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Lars-Peter Clausen
 <lars@metafoo.de>, Antoni Pokusinski <apokusinski01@gmail.com>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>, Gregor Boirie
 <gregor.boirie@parrot.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?B?Sm8=?=
 =?UTF-8?B?w6Nv?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, stable@vger.kernel.org
Subject: Re: [PATCH 02/11] iio: adc: ti-ads1119: fix information leak in
 triggered buffer
Message-ID: <20241130204312.434d84ad@jic23-huawei>
In-Reply-To: <98feceae-2146-478b-8296-d3a41401dbf9@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
	<20241125-iio_memset_scan_holes-v1-2-0cb6e98d895c@gmail.com>
	<20241126085958.GA13577@francesco-nb>
	<59a4b096-101b-419d-8a19-1063d759b4e2@gmail.com>
	<20241126185211.385f82c4@jic23-huawei>
	<D5WG58I3QIEL.7Y7EGKOC7AS8@gmail.com>
	<98feceae-2146-478b-8296-d3a41401dbf9@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Nov 2024 01:30:36 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 26/11/2024 23:00, Javier Carrasco wrote:
> > On Tue Nov 26, 2024 at 7:52 PM CET, Jonathan Cameron wrote:  
> >> On Tue, 26 Nov 2024 10:46:37 +0100
> >> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> >>  
> >>> On 26/11/2024 09:59, Francesco Dolcini wrote:  
> >>>> On Mon, Nov 25, 2024 at 10:16:10PM +0100, Javier Carrasco wrote:  
> >>>>> The 'scan' local struct is used to push data to user space from a
> >>>>> triggered buffer, but it has a hole between the sample (unsigned int)
> >>>>> and the timestamp. This hole is never initialized.
> >>>>>
> >>>>> Initialize the struct to zero before using it to avoid pushing
> >>>>> uninitialized information to userspace.
> >>>>>
> >>>>> Cc: stable@vger.kernel.org
> >>>>> Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
> >>>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >>>>> ---
> >>>>>  drivers/iio/adc/ti-ads1119.c | 2 ++
> >>>>>  1 file changed, 2 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
> >>>>> index e9d9d4d46d38..2615a275acb3 100644
> >>>>> --- a/drivers/iio/adc/ti-ads1119.c
> >>>>> +++ b/drivers/iio/adc/ti-ads1119.c
> >>>>> @@ -506,6 +506,8 @@ static irqreturn_t ads1119_trigger_handler(int irq, void *private)
> >>>>>  	unsigned int index;
> >>>>>  	int ret;
> >>>>>
> >>>>> +	memset(&scan, 0, sizeof(scan));  
> >>>>
> >>>> Did you consider adding a reserved field after sample and just
> >>>> initializing that one to zero?
> >>>>
> >>>> It seems a trivial optimization not adding much value, but I thought about
> >>>> it, so I'd like to be sure you considered it.
> >>>>
> >>>> In any case, the change is fine.
> >>>>
> >>>> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> >>>>
> >>>> Thanks,
> >>>> Francesco
> >>>>  
> >>>
> >>> Hi Francesco, thanks for your review.
> >>>
> >>> In this particular case where unsigned int is used for the sample, the
> >>> padding would _in theory_ depend on the architecture. The size of the
> >>> unsigned int is usually 4 bytes, but the standard only specifies that it
> >>> must be able to contain values in the [0, 65535] range i.e. 2 bytes.
> >>> That is indeed theory, and I don't know if there is a real case where a
> >>> new version of Linux is able to run on an architecture that uses 2 bytes
> >>> for an int. I guess there is not, but better safe than sorry.  
> >> Using an unsigned int here is a bug as well as we should present consistent
> >> formatted data whatever the architecture.  
> > 
> > Would you prefer that in the same patch as they are related issues? I
> > could switch to u32 in v2 along with anything else that might arise in
> > the reviews of the rest of the series.
> > If you prefer a separate patch, that's fine too.
> >   
> 
> Although now that I am looking into it, and according to the datasheet
> and defined scan_type, the right size should be s16.
> 
Separate patch would be great!

Thanks

Jonathan

> >>>
> >>> We could be more specific with u32 for the sample and then add the
> >>> reserved field, but I would still prefer a memset() for this small
> >>> struct. Adding and initializing a reserved field looks a bit artificial
> >>> to me, especially for such marginal gains.  
> >> Issue with reserved fields is we would have to be very very careful to spot them
> >> all.  A memset avoids that care being needed.
> >>
> >> Jonathan
> >>  
> >>>
> >>> Moreover, the common practice (at least in IIO)is a plain memset() to
> >>> initialize struct holes, and such common patterns are easier to maintain :)
> >>>
> >>> Best regards,
> >>> Javier Carrasco  
> >   
> 


