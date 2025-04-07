Return-Path: <linux-iio+bounces-17782-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF672A7EC6F
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 21:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221573AFDEA
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 19:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A045B23A9B6;
	Mon,  7 Apr 2025 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/S7fgZq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571852236FC;
	Mon,  7 Apr 2025 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051480; cv=none; b=o3lbufi/CcBNY3E29Oz+bVANl5gNJt3B94IaxB0JCS1bdqP/wxxxNd39aZLjkxCjasH6POJjrnPPtRA79WTT/WPoRa6oMfs8WkEKpkMf2hkLb/5LAboEf14b92/axLlvPiAPVAs0xzTJqw0/HguZeHedp5nRd4vBIGypqmwiBT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051480; c=relaxed/simple;
	bh=RqSC3Srh3U89lKqqWS+lHg9U3+jo4ZP+CbHYE7BdyKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJLw1ptgNl4/dbj6urMBNb+3ebWkLpr3UrQ7idjDfy1KD+lU87A40oorsu0B1NKVxlW9ETuxTWs0Lx01hO27S2JldDqekn+jIX3ohynO+c967BOSJQ1U8Kape1gT0WX9WgeejJ5WRDl+m7miSmG1dFd5JH6OdGLzXZ9WA5OL/Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/S7fgZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E64C4CEDD;
	Mon,  7 Apr 2025 18:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744051479;
	bh=RqSC3Srh3U89lKqqWS+lHg9U3+jo4ZP+CbHYE7BdyKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n/S7fgZqKKuR9mnct7HEK/26N+EKZzoPoPB80PH2Cs9Fk+i/WyY8uHyR3gHuWO/zM
	 mXjjay9eDCstWsPcyaIrwoMnWXO1sEJkD9znKBxZFjUpzsFAqHwGfSbkGYkGBj+JdP
	 LJC16/Gl/7Wd+ZzyipXzgGF6tXMrMKwUJC0lFMpMzOVCvkbXsXNBRxwDK4cq3X4xfW
	 0LKoF7gIxNh0RTfG0K1iMw61TWhrAPjBTPuBUIlQWghoZl+qg5SgrIn7PrQyKfXAUP
	 UC5Uj+9+aUlf3csIY9Yo8Olw0kKLtLFe3KKg+nfv9K/3lxW6hSEihFiEWOAOtl7Q60
	 4M0d8ASqeheGg==
Date: Mon, 7 Apr 2025 19:44:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: adc: ti-adc128s052: Support ROHM BD79104
Message-ID: <20250407194431.44b03a77@jic23-huawei>
In-Reply-To: <99d1d972-d9a5-4ca3-811a-b22083bea4e6@gmail.com>
References: <cover.1742474322.git.mazziesaccount@gmail.com>
	<8e10f2d82362ca7c207324a5a97bb1759581acea.1742474322.git.mazziesaccount@gmail.com>
	<20250331122247.05c6b09d@jic23-huawei>
	<a35ab4b1-4d6a-4b95-963a-96b2ab4c05e9@gmail.com>
	<20250405184346.3c4b1234@jic23-huawei>
	<99d1d972-d9a5-4ca3-811a-b22083bea4e6@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Apr 2025 09:10:05 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 05/04/2025 20:43, Jonathan Cameron wrote:
> > On Tue, 1 Apr 2025 15:33:15 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> On 31/03/2025 14:22, Jonathan Cameron wrote:  
> >>> On Mon, 31 Mar 2025 11:03:58 +0300
> >>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >>>      
> >>>> The ROHM BD79104 ADC has identical SPI communication logic as the
> >>>> ti-adc128s052. Eg, SPI transfer should be 16 clk cycles, conversion is
> >>>> started when the CS is pulled low, and channel selection is done by
> >>>> writing the channel ID after two zero bits. Data is contained in
> >>>> big-endian format in the last 12 bits.  
> >>>
> >>> Nicely found match.  Sometimes these are tricky to spot.
> >>>      
> >>>>
> >>>> The BD79104 has two input voltage pins. Data sheet uses terms "vdd" and
> >>>> "iovdd". The "vdd" is used also as an analog reference voltage. Hence
> >>>> the driver expects finding these from the device-tree, instead of having
> >>>> the "vref" only as TI's driver.
> >>>>
> >>>> NOTE: The TI's data sheet[1] does show that the TI's IC does actually
> >>>> have two voltage inputs as well. Pins are called Va (analog reference)
> >>>> and Vd (digital supply pin) - but I keep the existing driver behaviour
> >>>> for the TI's IC "as is", because I have no HW to test changes, and
> >>>> because I have no real need to touch it.
> >>>>
> >>>> NOTE II: The BD79104 requires SPI MODE 3.
> >>>>
> >>>> NOTE III: I used evaluation board "BD79104FV-EVK-001" made by ROHM. With
> >>>> this board I had to drop the SPI speed below the 20M which is mentioned
> >>>> in the data-sheet [2]. This, however, may be a limitation of the EVK
> >>>> board, not the component itself.
> >>>>
> >>>> [1]: https://www.ti.com/lit/ds/symlink/adc128s052.pdf
> >>>>
> >>>> [2]:
> >>>> https://fscdn.rohm.com/en/products/databook/datasheet/ic/data_converter/dac/bd79104fv-la-e.pdf
> >>>>     
> >>> Prefer Datasheet tags with # [1]
> >>> after them for the cross references.
> >>>
> >>> Those belong here in the tag block (no blank lines)  
> >>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>  
> >>>
> >>> One request for an additional cleanup precursor patch given you are
> >>> touching the relevant code anyway.   It's a small one that you can
> >>> test so hope you don't mind doing that whilst here.
> >>>
> >>> I'm relying on the incredibly small chance anyone has a variable
> >>> regulator wired up to the reference that they are modifying at runtime.
> >>> I have seen that done (once long ago on a crazy dev board for a really
> >>> noisy humidity sensor) when the reference was VDD but not on a separate
> >>> reference pin.  That means we almost certainly won't break the existing
> >>> parts and can't have a regression on your new one so we should be fine
> >>> to make the change.  
> >>
> >> The change you ask for is indeed small. I have no real objections
> >> against implementing it (and I actually wrote it already) - but I am
> >> still somewhat hesitant. As you say, (it seems like) the idea of the
> >> original code is to allow changing the vref at runtime. It looks to me
> >> this might've been intentional choice. I am not terribly happy about
> >> dropping the working functionality, when the gained simplification isn't
> >> particularly massive.  
> > 
> > Hmm. I suspect this was added at my request (or copied from where I requested
> > it)  Back when we did this there was no advantage in doing it at probe
> > as it was just a question of store a value or store a pointer we had
> > to get anyway.  So I tended to advocate what I now think was a bit silly,
> > that someone elses board might have it changing...
> > 
> > User space wise, what code checks for random scaling changes?  So it
> > was best effort at best anyway!  
> 
> Ah, right. I suppose this should've been accompanied with scale setting 
> which could've changed the regulator voltage - and I have no idea if 
> such hardware would make any sense.

In theory possible but I suspect expensive as a controllable precision
reference would be needed (a DAC probably wouldn't have enough current?)

> 
> The slim chance I can imagine is that the reference voltage can't be 
> set/known at probe time.

Agreed. It can in theory happen and did on one ancient board I had
where the reference voltage was wired to a pair of devices and one
had a higher minimum voltage than the other. That was pre DT times though
and I suspect now we'd just put the voltage that works for both in DT.

> 
> >> Because of this, I am thinking of adding the patch dropping the
> >> functionality as an RFC. Leaving that floating on the list for a while
> >> would at least have my ass partially covered ;)
> >>
> >> I'd rather not delayed the support for the BD79104 though. So - would it
> >> be okay if I didn't implement the clean-up as a precursory patch, but
> >> did it as a last patch of the series? That will make it a tad more
> >> complex to review, but it'd allow taking the BD79104 changes in while
> >> leaving the RFC to float on a list. (Also, I'm not sure if you can push
> >> an RFC in next without taking it in for the cycle?)  
> > 
> > I'll probably just merge it even as an RFC :)  That way it's my
> > fault if we break someone and they shout!  
> 
> That's fine for me. Well, doing it this way around (as a last patch) 
> should ease reverting, should it be needed.
Absolutely.

> 
> Yours
> 	-- Matti


