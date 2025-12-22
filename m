Return-Path: <linux-iio+bounces-27311-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 693F0CD58BD
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 11:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72FE73009C2C
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 10:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B3425F78F;
	Mon, 22 Dec 2025 10:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL48gxBd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9460E26056E
	for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766398907; cv=none; b=ryprhj81XeQU31c4TDSrqrJ6haK3JgF6KC5IRzkV2Of/1BaBURSywQMlGzgijJf6DWPs85TBq9kucffD43RWN61jS2YFhkjfugQIDnryg02rT/zxP/o92+mwMoEbxweYg7KvxEOi4sNpjP0kC3QHU8bDyEU6Lj2BUu1j9r1MeLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766398907; c=relaxed/simple;
	bh=fiu+7IDZg7iGHWuMWejacCouV4YQDEBOd326O/hrIX8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCICItrgycAOk5awEjRj5wScEWpWWKE1HkPBn9hMeAV0262gC2omTjXO1ceqpPtHSWWSCJfW51uHjuPzc8yVa1hAooDb8WseuT6LVIwk6bQAMOqXO6w9HTOOXw8UJON7qHW5cmv/YzEq7zHxNbEm+ddmfKYzKnyFmHyHL/BbQCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GL48gxBd; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c0f13e4424so165189085a.1
        for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 02:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766398902; x=1767003702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iSVxw9ZmIdQgXSzndsIC58cZVndwux1ConW+UpHN898=;
        b=GL48gxBdXZCGyrlGuWsIte5fkUaFwCdD9cjI3PSxCNkUuG5nmnSfMlqtUHmNoxsv69
         vEBO1qCXSmbGpXV+5wpXfo+TeMWQgpDbwkfd+aXNlQLuCh01gEwMMbCT6jN6juqRCckr
         IPy5tJmaNXfpiAVCpTKwSeicN/JpXlve0xKWIG/mEFjS/P7PBRgegFMK9S55UVfV5bjm
         tnVntLGIe4rGBjj0U02UPGkWjlQCFv2woLwNSUW8LjP3IQBj3Rye2IMaKQQog0QdeMbt
         +Z11OowUyw2kR8i5fsqfVqxqOaNTa1IFbL9UNSvRGcBx3KS+mdqfTVJ2HWENoAT+Kgy0
         hXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766398902; x=1767003702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSVxw9ZmIdQgXSzndsIC58cZVndwux1ConW+UpHN898=;
        b=N0sZRDtiDQjWGgfUI0MM5oLw59jNxIW2RFPH6HUjbpCjXUiFlpLGuqlcvMntfa+PBW
         81/fDvgDfLJYY86ulCPWIQDIxSjXbmZSBY9JydmoDmPXBTe/HWD0L+W+k5DwleKl9GH2
         zd2Eb+F9ihwTD0Tc0UxgjMzC9OGXF7wFiQbzTB77dU4U1CqppkwffpgYCPkEtDwTytQW
         XuY96MqtjUq1Sa6ewVverQF7pn468kEK5SPCP5o8XgAtsh9nTfkFiRarViQUCBSldGeV
         8OTaexhXC/n1SEfIoWSuEk0MGBIiwhcAnFdtnBZ/wbTmHd5wK6dXOsRWATXl6/bk0qBT
         LmKw==
X-Forwarded-Encrypted: i=1; AJvYcCXpwD8L+TCLu/YoAD6KylGbzFPgYdqmIdTtaC8DioPgeCNdTd1wU4hrlsTsP4re5VDHpkA5HmWj49k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEcRmbAVQCeebWOflG7oamT1SuSSAMWn8w2PB1uUC2v/+d/M0+
	4gjQVT8df11QIjsQpqoDN3ScVewV5F+ykJkkGwtynOqbNolQC/aa1JxT
X-Gm-Gg: AY/fxX7gx7r6LsPD2EPpgY0X7aukIv5VYryc3aPxa3j6E17vieNCBANJd0Zv/NGvdUA
	igxWdn4JCQsIF/2v1gftrZk0xJyuYlzx07xhMS5qSPv34ykI4zBY+CCGQ0IySdrl0yZ1w6TfH1B
	ijkfNWI/Z8YV23tdPJsW7ttMIUhkYLpqHHm8ECN3tQJFKHGLkl5jWY1NIKZqr+jo/Gc4IT16tAZ
	ykcM+6SD2oH0KzalfOe5EFLGAQOaIa6atl0+r6px/QO9SaMrJPt/KFFfkrVgX62m6eVjrF/rcTy
	0g4id79Z/yqc0nU4iVeOnqMRY4KY2CJi67tQhOHMo6sh5RJBZL5JnnMP1/uGeKTfszK6E+nYHIE
	yFd7UBm0MWhTLZt3DoIh0u0zFL3Zaf8PJgep0AQPrT2ckGYC2ntthuhUijq1VPtvOL4Jpf+rCop
	27MhoK5YCmJc9YYEeOKr32d9X15fjBe8qk68aemkbuJ2E9q/QtCZ44Yry26Hwl5eC4hV/RhK3mJ
	QUb
X-Google-Smtp-Source: AGHT+IElhBkWJr2Owy7kS2H7e5EkrIkHXV9GSmGV4saFfOnNmCFz9qEFMfmL8CLkpnT41AF4gm0Big==
X-Received: by 2002:a05:620a:31a8:b0:8b2:6b9e:5396 with SMTP id af79cd13be357-8c0906fc8bcmr1532358385a.83.1766398902393;
        Mon, 22 Dec 2025 02:21:42 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.103])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096783662sm828237685a.5.2025.12.22.02.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 02:21:41 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 22 Dec 2025 10:21:32 +0000
To: Krzysztof Kozlowski <krzk@kernel.org>, 
	Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 1/6] dt-bindings: iio: frequency: add adf41513
Message-ID: <3mmzedwjwraepmhams5w3navb3cyga3wr7fvkrdgls2zkzdqwb@vogpd527ovgr>
References: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
 <20251219-adf41513-iio-driver-v2-1-be29a83d5793@analog.com>
 <20251220-bouncy-perky-tarantula-d9b3be@quoll>
 <gz36kmewv4bhwqz6d3xqatcx65uzukqcgsvfbwhr7c3yhw225z@edeggfhjws2h>
 <326c3e83-059e-4e96-ab99-d4a33eb3b56f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <326c3e83-059e-4e96-ab99-d4a33eb3b56f@kernel.org>

On 25/12/21 02:02PM, Krzysztof Kozlowski wrote:
> On 20/12/2025 19:05, 455.rodrigo.alencar@gmail.com wrote:
> > Hi Krzystof,
> > 
> > thanks for taking a look into this again. It was my first patch it didn't want
> > to draw more attention or discussion to the V1 patch as it was declared not ready
> > at its very first review.
> > 
> > On 25/12/20 10:21AM, Krzysztof Kozlowski wrote:
> >> On Fri, Dec 19, 2025 at 12:34:48PM +0000, Rodrigo Alencar wrote:
> >>> dt-bindings for ADF41513, an ultralow noise PLL frequency synthesizer that
> >>> can be used to implement local oscillators (LOs) as high as 26.5 GHz.
> >>> Most properties refer to existing PLL driver properties (e.g. ADF4350).
> >>
> >> What is "existing PLL driver"? I know about motor drivers, but can you
> >> drive PLL?
> >>
> >> And how is ADF4350 related to this binding. I do not see ADF4350
> >> compatible here at all. Describe hardware, a real one.
> > 
> > ADF4350 is an older one, and its bindings can be found at:
> > Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml
> > It is a similar part, but yet very different.
> > 
> >>
> >> Nothing improved.
> >>
> >> You ignored comments, did not bother to respond to them and then sent
> >> the same.
> > 
> > Sorry for not responding on the V1 thread, but the previous patch had to be reviewed internally
> > first. It is not true that nothing is improved, in fact, it has changed a lot, here are some notes:
> 
> Process is not like that. You first review internally, then you send.
> After you sent and receive comments, you respond to these comments.

ack.
 
> > * adi,power-up-frequency is not carrying the -hz postfix because it forces to be a uint32 by
> > the dt-bindings check. For that variable it needs to be uint64 as the part supports up to 26.5 GHz > 2^32
> 
> And what granularity do you need? Why mhz does not work?

~Hz granularity is needed to adjust frequency offsets spotted by calibration,
but I suppose that is a whim that can be dropped indeed, as the important
thing about this property is to populate frequency configs for the initialization
sequence, which requires all registers to be written.

> > * The properties related to the reference input signal path: reference-div-factor, reference-doubler-enable
> > reference-div2-enable are declared here because they are constraints for the PFD frequency definition,
> > which is the frequency that the output signal is updated, important for the loop-filter and VCO design.
> > * added support for all different power supply regulators.
> 
> Sorry, but I cannot respond that way. We discuss inline, so I have
> entire picture, not some parts of message semi-quoted here. I don't
> remember what was there and I am not going to keep looking for that.
> 
> You need to adjust to mailing list discussion style, not introduce the
> others. I have just way too many other patches to deal with, so
> implement the feedback or respond properly.

ack. Will adjust to the requested style. Already deviating from it again,
but those were the comments from the V1 review:
(https://lore.kernel.org/all/20251111-feathered-winged-bloodhound-b7e1a3@kuoka/)

> 
> Please organize the patch documenting compatible (DT bindings) before their user.
> See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46

done.

> > +
> > +  chip-enable-gpios:
> 
> enable-gpios

done.

> > +  adi,power-up-frequency:
> > +    $ref: /schemas/types.yaml#/definitions/uint64
> 
> Use standard unit suffixes. Frequency is in Hz for example.

sorry, this was the problem, will use -mhz as suggested.

> > +  adi,reference-div-factor:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 1
> > +    maximum: 32
> > +    description:
> > +      Reference division factor (R Counter). If not specified, the driver
> > +      will calculate the optimal value automatically.
> 
> Then why do you need this property? If driver calculates the optimal,
> why anyone would put wrong or sub-optimal value to DT?
> 
> Drop.

The description was bad so I rewrote this. The value is hardware constraint
for the output frequency of the Phase-Frequency Detector (PFD),
which is important for the external loop-filter/VCO design. The driver may
only change the R counter if the PFD frequency goes off limits. In that case,
some designs can acomodate different PFD frequencies, but that is not usual
and likely not recommended.

> > +
> > +        /* Example with advanced features enabled */
> > +        pll_advanced@0 {
> 
> pll@

done

thanks for the patience.

kind regards,

Rodrigo Alencar

