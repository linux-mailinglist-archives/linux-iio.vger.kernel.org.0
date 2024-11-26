Return-Path: <linux-iio+bounces-12696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C959D9D09
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 19:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25B25B2AE7C
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 17:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E74D1DD543;
	Tue, 26 Nov 2024 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exa62MBC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6A61DC1A7;
	Tue, 26 Nov 2024 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732643981; cv=none; b=hVwUPXlHbqXGn/AZYC4iWcb1mNYbKrr/IaHjz5y353t/2Me0JvhHUzcjl53k7rr8+j8zNIsH/hlp4r6Xi2T5+kAcOeQq8chREEN9/F3IdAiGt4lPuCuLJwGgNKdqRtONePnSZT8kK2EQuxELgNk698N+O9hscD0JfpvljNB1AFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732643981; c=relaxed/simple;
	bh=BsSU6WljrzcxRmnvGoq3yIGvUt1SZPuGg17fO0jlTrE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtKiZG2T72NOhSV6ZdQtRE1dWR2EZxMnHdWK/t7LqTO1AztR5zaqR2kQzp2efcbXZFdJiSkc3MY/M0L4k59vHzT/i2X7ND+DFDjEl89kzoyTjfDrhF/5s77CTB1X6TgtPp+tIJ85uTUdTTKTdr2b5b8Rb7+n89W3e/b2rYKBFfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exa62MBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2643FC4CECF;
	Tue, 26 Nov 2024 17:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732643980;
	bh=BsSU6WljrzcxRmnvGoq3yIGvUt1SZPuGg17fO0jlTrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=exa62MBCsYosaN1yejVJbAYazUVyjJe0WX2Dp7GmCyau3Uwk5O3/vcPW5dseqi7Ov
	 IDKIgDiQvJwEMS16KoFxir8AJqwBrISLwJ6Z+uhFyxTAkHtxsR0ASEIn+9+OO5yRZT
	 Hpd3tRsGbkIU4Spwrvs58+8GHt8EwuAgoGuWFj3GeM+72poKGdBAYnnxet23rCIlaS
	 2J8O+DmQ1eMTYkPer2zUX3gyxSms/ftFcrEMdQZGr0S8eDvjwPqZAwTB7gJSICB0WT
	 5fdSQ02l5AuoNbdgnKYSSjU1Q8NkXsrdzyOWjBJXxSkyr82pye+L9RpfdqnX6JKDI1
	 F4dMq0Cd6Y6iQ==
Date: Tue, 26 Nov 2024 17:59:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Guillaume Stols
 <gstols@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 jstephan@baylibre.com, aardelean@baylibre.com, adureghello@baylibre.com
Subject: Re: [PATCH 2/9] dt-bindings: iio: dac: adi-axi-adc: Add ad7606
 variant
Message-ID: <20241126175931.4645dbe3@jic23-huawei>
In-Reply-To: <20241121-wackiness-threaten-b53d2a27fbd9@spud>
References: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
	<20241121-ad7606_add_iio_backend_software_mode-v1-2-8a693a5e3fa9@baylibre.com>
	<49bc9ec4-f252-4903-b5be-1d35ee8d48be@baylibre.com>
	<20241121-wackiness-threaten-b53d2a27fbd9@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Nov 2024 19:53:53 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Thu, Nov 21, 2024 at 10:57:44AM -0600, David Lechner wrote:
> > On 11/21/24 4:18 AM, Guillaume Stols wrote:  
> > > A new compatible is added to reflect the specialized version of the HDL
> > > that is not covered by the IIO backend paradigm: We use the parallel  
> > 
> > It still is being used as an IIO backend, so I would leave out the
> > phrase "that is not covered by the IIO backend paradigm".
> >   
> > > interface to write the ADC's registers, and accessing this interface
> > > requires to use ADI_AXI_REG_CONFIG_RD,ADI_AXI_REG_CONFIG_WR and
> > > ADI_AXI_REG_CONFIG_CTRL in a custom fashion.
> > > 
> > > Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> > > ---
> > >  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> > > index e1f450b80db2..43bc0440c678 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> > > @@ -17,13 +17,20 @@ description: |
> > >    interface for the actual ADC, while this IP core will interface
> > >    to the data-lines of the ADC and handle the streaming of data into
> > >    memory via DMA.
> > > +  In some cases, the AXI ADC interface is used to perform specialized
> > > +  operation to a particular ADC, e.g access the physical bus through
> > > +  some special register to write ADC registers.
> > > +  In this case, a different compatible is used, and the driver behaves  
> > 
> > Quick, delete the word "driver" before Krzysztof sees it. :-p  
> 
> And also perhaps worth mentioning under the --- line that the x in the
> compatible is not a wildcard, for similar reasons ;)
Well it is, just one that is used for the IP naming to cover all
the different ADCs it works with.

"The AXI AD7606x IP core can be used to interface the AD7606B, AD7606C-16,
AD7606C-18, AD7605-4, AD7606, AD7606-6, AD7606-4, AD7607, AD7608 and AD7609 devices using an FPGA."

Given that's what ADI calls the IP though we are stuck with it - however
'wrong' they may be :)

But agreed, something to call out to keep me away from the x as well!

Jonathan


