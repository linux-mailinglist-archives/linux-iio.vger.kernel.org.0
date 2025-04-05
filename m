Return-Path: <linux-iio+bounces-17649-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1386A7CAFB
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 19:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9677F189302B
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 17:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6093019C54E;
	Sat,  5 Apr 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImfPRnbD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159E55695;
	Sat,  5 Apr 2025 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743874197; cv=none; b=VGZdBEGTGeAKdrBOA3KXuPEPSfTR7M7PRhuRNG6Es5U9EjVLOwqSnf1cI+nia0f+fCUZ/LyXUK2VOFXX/LBRyfAVvccPDhB3pebcoUHFfclqHCS7BKUuFSQL2bYGWMw8q40z2ojE2rJWXGz37sCuTbv4uLuAA1h2+x51w0o6b40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743874197; c=relaxed/simple;
	bh=tzXibo8LLKtevA8p4RlDqCPis5OweDdf/jmNMoHM7LI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2mmbdbhXDFv8VHPbOkUvrb/H5hPWqzJJUUnRIe3w8pfBPqKT8aifnPaRrxoGQF/YnO4A+amxQ4FXf00l07NEakYsKa224zFyIq/D1biwww711i0xOaS4Dt+a+TYTZL8MHBt+AR/PKjHuFDyIGbsVwzcPPtO6CyNsAydJRTmjNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImfPRnbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8DCC4CEE4;
	Sat,  5 Apr 2025 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743874196;
	bh=tzXibo8LLKtevA8p4RlDqCPis5OweDdf/jmNMoHM7LI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ImfPRnbDGl4DRxtqt4CsGc8D4PavM3/4rRJA1EPwTmLvhWNyTtpOgT88HnOLuukc0
	 59FuvV+7OfdyZ8A9cD/P6fAxKzSc2wYfh5HewKdjNWxjB4T21+wF8KpYrefUSCOR2B
	 /rcnTWkS6X1945uuLDZN31pZr/oxL/eSg22liQctWmDP6wM9NzEH6UZbHhdwyK2mo2
	 yi83Ab+tCzUEUvy1QHfCTSYAJbLIo0Q/4UYRczwda7CPJC1bbA0twKyFFzLkB2vU78
	 Hw3em3g6cy9xrPC5v8iFZb4DV9TxPyDVuN+4+E8rpPttQ8IbVXNmz97E2aaeskwo14
	 WazXAoYhuXigA==
Date: Sat, 5 Apr 2025 18:29:47 +0100
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
Message-ID: <20250405182947.06d5e67f@jic23-huawei>
In-Reply-To: <1189b539-adb4-46f9-9783-c6577b57a304@gmail.com>
References: <cover.1743573284.git.mazziesaccount@gmail.com>
	<feeabbfd3d3916c7497dfd94423ff83ef5f654f1.1743573284.git.mazziesaccount@gmail.com>
	<4c3e0d23-2582-4acf-8e90-542c8f8c385f@baylibre.com>
	<1189b539-adb4-46f9-9783-c6577b57a304@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Apr 2025 08:16:43 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 03/04/2025 00:04, David Lechner wrote:
> > On 4/2/25 1:09 AM, Matti Vaittinen wrote:  
> >> The register data is 12-bit big-endian data. Use be16_to_cpu() to do
> >> the conversion, and simple bitwise AND for masking to make it more
> >> obvious.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >> ---
> >> Revision history:
> >> v1 => v2:
> >>   - Fix commit msg to reflect the fact there was no bug
> >>   - Drop Fixes tag
> >>   - Use union for rx / tx buffer to avoid casting
> >>   - Keep the shared message protected by the mutex
> >> ---
> >>   drivers/iio/adc/ti-adc128s052.c | 18 ++++++++++--------
> >>   1 file changed, 10 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> >> index a456ea78462f..3e69a5fce010 100644
> >> --- a/drivers/iio/adc/ti-adc128s052.c
> >> +++ b/drivers/iio/adc/ti-adc128s052.c
> >> @@ -28,32 +28,34 @@ struct adc128 {
> >>   	struct regulator *reg;
> >>   	struct mutex lock;
> >>   
> >> -	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
> >> +	union {
> >> +		__be16 rx_buffer;
> >> +		u8 tx_buffer[2];
As below. Maybe
		__be16 buffer16;
		u8 buffer[2];

> >> +	} __aligned(IIO_DMA_MINALIGN);
> >>   };
> >>   
> >>   static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
> >>   {
> >>   	int ret;
> >> +	char *msg = &adc->tx_buffer[0];
> >>   
> >>   	mutex_lock(&adc->lock);
> >>   
> >> -	adc->buffer[0] = channel << 3;
> >> -	adc->buffer[1] = 0;
> >> +	msg[0] = channel << 3;
> >> +	msg[1] = 0;
> >>   
> >> -	ret = spi_write(adc->spi, &adc->buffer, 2);
> >> +	ret = spi_write(adc->spi, msg, sizeof(adc->tx_buffer));

I'd get rid of msg as it's now just confusing given we are
using the sizeof() here.

> >>   	if (ret < 0) {
> >>   		mutex_unlock(&adc->lock);
> >>   		return ret;
> >>   	}
> >>   
> >> -	ret = spi_read(adc->spi, &adc->buffer, 2);
> >> -
> >> +	ret = spi_read(adc->spi, &adc->rx_buffer, 2);

sizeof(adc->rx_buffer)

> >>   	mutex_unlock(&adc->lock);
> >> -
> >>   	if (ret < 0)
> >>   		return ret;
> >>   
> >> -	return ((adc->buffer[0] << 8 | adc->buffer[1]) & 0xFFF);
> >> +	return be16_to_cpu(adc->rx_buffer) & 0xFFF;  
> > 
> > 
> > The cast isn't exactly beautiful, but this would save a lot of
> > lines of diff and a few lines of code by avoiding the need for
> > the union and the local msg variable.
> > 
> > 	return be16_to_cpup((__be16 *)adc->buffer) & 0xFFF;  

The cast only works because we have forced the alignment for DMA safety.
That to me is a little fragile.

You could do get_unaligned_be16() which doesn't need the cast then carry
on using the original buffer.  

> 
> Thanks again for the review David :)
> 
> I am unsure which way to go. I kind of like having the __be16 in the 
> struct, as it immediately yells "data from device is big-endian". OTOH, 
> I've never loved unions (and, it silences the above "yelling" quite a 
> bit). I still think this might be the first time I really see a valid 
> use-case for an union :) And, you're right this adds more lines, 
> besides, the cast doesn't look that ugly to me. Yet, I originally had a 
> cast probably as simple as this (and I also had the __be16 in the 
> struct), and Jonathan suggested using union to avoid it...
> 
> At the end of the day, I suppose I am Okay with any of these 3 
> approaches. Original cast, union or this cast you suggest. Jonathan, any 
> preferences on your side?

Majority of the diff is really about renaming buffer to tx_buffer.
Could just not bother doing that and instead have buffer and buffer16
as the two union elements. With msg gone as suggested above, then the diff
becomes only a few lines and you get to keep the nicety of it being either
a pair of u8s or a __be16.

Jonathan

> 
> >   
> >>   }
> >>   
> >>   static int adc128_read_raw(struct iio_dev *indio_dev,  
> >   
> 
> Yours,
> 	-- Matti
> 


