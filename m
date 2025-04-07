Return-Path: <linux-iio+bounces-17784-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B0DA7EC7E
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 21:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B734429E4
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 19:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C272571D5;
	Mon,  7 Apr 2025 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMgoJ5ut"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54AB2561B9;
	Mon,  7 Apr 2025 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051785; cv=none; b=OIFhV4kQSrVxZr3Mz5CTs7toWcF9TDLdqN2OtXs5Yi5bA5C7Ic7+nMndMRUB4xkDMv1J8YNVftIlfjbBI1Pv0i546chCmOlt6KprrUvDHd7Lw0QPxw3St+E3kZtJs5G8+ioT12EQoR01WLWff0mtbf3t+uCrn0uKJx0MvVzyvz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051785; c=relaxed/simple;
	bh=DBR6tIZcX9SUviEcWkcmXfotauokDmL7FEuYM/rfV74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qa2zoyvptegJCOKKA06lw+3mJ93bAXi1YeLw5RNKfBxdcS7qRW73GoB8HSN1Qf8XDMKZlXr4yfB4AbW1ODMJz8YzQINyYifQX6XVi6DiMCjEV2E/BqCt87dN2hod13HqqhW8Zj1azl1ltMLmtMamWB3AsrE97hFAOMW+ZPalEEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMgoJ5ut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6291C4CEDD;
	Mon,  7 Apr 2025 18:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744051785;
	bh=DBR6tIZcX9SUviEcWkcmXfotauokDmL7FEuYM/rfV74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TMgoJ5utj/EVTXZU/G6ORYKhsQn7vjf8a9p+cAMJQRzSAoautoqPv9lMChKUpjZiM
	 nJf0pygyhAMNxjkdk46joUqQFhBco2V3KvHN/38kwRyKmkvbEN/5usNbi9Z3jLPUAL
	 fpCpfv6NZ1Xz7yYAaAZPUPGDQq9Or0FC9tpuuvZT8kUzJ803cQ4hgLqIYS3QIFESER
	 Aw4uRz3I0VO7TTwM5TqTvJQweyVFGmMGMMulfdQullwOJhs6vPa1ZHYRKRIiHOVezk
	 NjXsdV/qlDronbZnSC81sGGNpj0nFhq3GXpoks1qlbZRb/+ljOS1JdTDEV6dFck5Cd
	 Qm24Q+X1vmpow==
Date: Mon, 7 Apr 2025 19:49:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] iio: adc: ti-adc128s052: Simplify using
 be16_to_cpu()
Message-ID: <20250407194937.097b7709@jic23-huawei>
In-Reply-To: <4f099833-5aa6-47cc-917c-7a466cb644b9@gmail.com>
References: <cover.1743573284.git.mazziesaccount@gmail.com>
	<feeabbfd3d3916c7497dfd94423ff83ef5f654f1.1743573284.git.mazziesaccount@gmail.com>
	<4c3e0d23-2582-4acf-8e90-542c8f8c385f@baylibre.com>
	<1189b539-adb4-46f9-9783-c6577b57a304@gmail.com>
	<20250405182947.06d5e67f@jic23-huawei>
	<4f099833-5aa6-47cc-917c-7a466cb644b9@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Apr 2025 08:23:07 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 05/04/2025 20:29, Jonathan Cameron wrote:
> > On Thu, 3 Apr 2025 08:16:43 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> On 03/04/2025 00:04, David Lechner wrote:  
> >>> On 4/2/25 1:09 AM, Matti Vaittinen wrote:  
> >>>> The register data is 12-bit big-endian data. Use be16_to_cpu() to do
> >>>> the conversion, and simple bitwise AND for masking to make it more
> >>>> obvious.
> >>>>
> >>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >>>> ---
> >>>> Revision history:
> >>>> v1 => v2:
> >>>>    - Fix commit msg to reflect the fact there was no bug
> >>>>    - Drop Fixes tag
> >>>>    - Use union for rx / tx buffer to avoid casting
> >>>>    - Keep the shared message protected by the mutex
> >>>> ---
> >>>>    drivers/iio/adc/ti-adc128s052.c | 18 ++++++++++--------
> >>>>    1 file changed, 10 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> >>>> index a456ea78462f..3e69a5fce010 100644
> >>>> --- a/drivers/iio/adc/ti-adc128s052.c
> >>>> +++ b/drivers/iio/adc/ti-adc128s052.c
> >>>> @@ -28,32 +28,34 @@ struct adc128 {
> >>>>    	struct regulator *reg;
> >>>>    	struct mutex lock;
> >>>>    
> >>>> -	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
> >>>> +	union {
> >>>> +		__be16 rx_buffer;
> >>>> +		u8 tx_buffer[2];  
> > As below. Maybe
> > 		__be16 buffer16;
> > 		u8 buffer[2];  
> 
> Ok.
> 
> >>>> +	} __aligned(IIO_DMA_MINALIGN);
> >>>>    };
> >>>>    
> >>>>    static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
> >>>>    {
> >>>>    	int ret;
> >>>> +	char *msg = &adc->tx_buffer[0];
> >>>>    
> >>>>    	mutex_lock(&adc->lock);
> >>>>    
> >>>> -	adc->buffer[0] = channel << 3;
> >>>> -	adc->buffer[1] = 0;
> >>>> +	msg[0] = channel << 3;
> >>>> +	msg[1] = 0;
> >>>>    
> >>>> -	ret = spi_write(adc->spi, &adc->buffer, 2);
> >>>> +	ret = spi_write(adc->spi, msg, sizeof(adc->tx_buffer));  
> > 
> > I'd get rid of msg as it's now just confusing given we are
> > using the sizeof() here.  
> 
> Ok.
> 
> >>>>    	if (ret < 0) {
> >>>>    		mutex_unlock(&adc->lock);
> >>>>    		return ret;
> >>>>    	}
> >>>>    
> >>>> -	ret = spi_read(adc->spi, &adc->buffer, 2);
> >>>> -
> >>>> +	ret = spi_read(adc->spi, &adc->rx_buffer, 2);  
> > 
> > sizeof(adc->rx_buffer)  
> 
> I was thinking of this but went with raw 2 - because we need to read 
> exactly 2 bytes from the device. Sizeof buffer is matter of software 
> where as the 2 bytes is dictated by the device. (Sure the size of buffer 
> needs to be large enough).
> 
> I don't care it that much though, so I can go with the sizeof() if 
> that's what you prefer. Just explaining that the '2' here was a 
> conscious choice :)

Hmm. If we have a case where we read less than 2 bytes into that buffer
then fair enough.  Otherwise it's correctly sized so having sizeof(buffer)
and having to check that size in only one place is a tiny bit preferable.


> 
> >>>>    	mutex_unlock(&adc->lock);
> >>>> -
> >>>>    	if (ret < 0)
> >>>>    		return ret;
> >>>>    
> >>>> -	return ((adc->buffer[0] << 8 | adc->buffer[1]) & 0xFFF);
> >>>> +	return be16_to_cpu(adc->rx_buffer) & 0xFFF;  
> >>>
> >>>
> >>> The cast isn't exactly beautiful, but this would save a lot of
> >>> lines of diff and a few lines of code by avoiding the need for
> >>> the union and the local msg variable.
> >>>
> >>> 	return be16_to_cpup((__be16 *)adc->buffer) & 0xFFF;  
> > 
> > The cast only works because we have forced the alignment for DMA safety.
> > That to me is a little fragile.
> > 
> > You could do get_unaligned_be16() which doesn't need the cast then carry
> > on using the original buffer.  
> >>
> >> Thanks again for the review David :)
> >>
> >> I am unsure which way to go. I kind of like having the __be16 in the
> >> struct, as it immediately yells "data from device is big-endian". OTOH,
> >> I've never loved unions (and, it silences the above "yelling" quite a
> >> bit). I still think this might be the first time I really see a valid
> >> use-case for an union :) And, you're right this adds more lines,
> >> besides, the cast doesn't look that ugly to me. Yet, I originally had a
> >> cast probably as simple as this (and I also had the __be16 in the
> >> struct), and Jonathan suggested using union to avoid it...
> >>
> >> At the end of the day, I suppose I am Okay with any of these 3
> >> approaches. Original cast, union or this cast you suggest. Jonathan, any
> >> preferences on your side?  
> > 
> > Majority of the diff is really about renaming buffer to tx_buffer.
> > Could just not bother doing that and instead have buffer and buffer16
> > as the two union elements. With msg gone as suggested above, then the diff
> > becomes only a few lines and you get to keep the nicety of it being either
> > a pair of u8s or a __be16.  
> 
> I was tempted to try using the spi_write_then_read() - but I suppose 
> this may be kind of a hot path.

Given it's small, I doubt it would make any noticeable difference in
performance.

> 
> I'll go with (not)renaming the buffer and dropping the msg, to squeeze 
> the diff.

Works for me.

J
> 
> Yours,
> 	-- Matti


