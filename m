Return-Path: <linux-iio+bounces-23005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D42B2CB90
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 20:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B65E521CD4
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 18:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEFC30EF64;
	Tue, 19 Aug 2025 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpVyhAfA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DFC2FA0FF;
	Tue, 19 Aug 2025 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755626446; cv=none; b=buDT1QuDybc0i0d94n0/iEAlNeBOBT8N52+j+JGYdxi6RdGJ6eLONKx1/Pg66lHOXVuxj09olnoAil5+oSC5A56jIJL+E1m4IXaL29Q2FmdqgjbQ4zUizVkUI//NL1+I8JxiwOiBIfpBxoxIY1leUPNflpXDRDfuM1USwvieOUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755626446; c=relaxed/simple;
	bh=uggPgRTYqNjlmoaEi7wJCNeZIPbeRDwM2GTq7HQrLqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugv5by+01JdGT4nAimE3DtsYJTDptcOGZbS0Hq8vlRfTu3uT1Ck/tKVsBwYPNsrlpoWyI1li+ISeoMwehjz6rtUn/Cc6l4SBbrwFoqy20BHOOvil5gfOBDDiCdwUACwZFbxtbR7eqf4SObafz4AXoBwBYO68eLZpDb67HaLYXPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpVyhAfA; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b47174c8e45so5019655a12.2;
        Tue, 19 Aug 2025 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755626444; x=1756231244; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dlbE7qD4fBSNNkxix39Mi2yorN+MF+uyvTsDhoGqPO8=;
        b=RpVyhAfAZmZvOBiO+v9otE30r9UqNDHH4EZEvY7rMk1LdmzULEX3DopmYjZUqiS6Tu
         lbG8CoNIBMLq6/sIrqncacgbzHTtuHkCu3mse/ubnn0rFPvXHcV7lG4fdBflgexpbOj6
         q0Zs4jW65XfVtD/pOrdMXfqJRBkhqm5ufuZkAR+MKl6R8pWb399d73qzHlWBHXZlz+1L
         mDvyAImw3Btpt2sW8BGplTu14qJ2pdbNS8Qt0hHAQiXAKjPBda2NjYt2U4iM3sPgdeur
         mddOR5kraSrLWgSi62OTbAQkdN6jdzcMK/WF4yOdrps+TfKLtdM25O1pX5tzgr7/psce
         wysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755626444; x=1756231244;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dlbE7qD4fBSNNkxix39Mi2yorN+MF+uyvTsDhoGqPO8=;
        b=LZX5oSq57YeCJWJ52MkDN1pBcsRz3ZGXx8BPtfRILszKo0wBhXC5z90TcOIC4tYXyF
         Ulz8dhEyHAI1VSXPvevn83rAz8KHWpONrfPlW4iRc806DnWXE3EeWeFCXTPr9PB3bw3X
         lZ9DGhv9fRKbQN0idllHuFan5VbkAZvm50eCGUqId8MTD7paP14nKAEXG0cwOq45/faB
         afSBXET4QV8rfkvG/4ESzT9lYV/XELHMsjF+nBkEfxOHb3bxW7MfCsFWEPfE6e400yxN
         T7p40fc8cXCDisAX3u3+ANBXVBnwVuo0xZcUrOUn4hys3LmpFh/SGh0Owl3lwgbu0dud
         NX7A==
X-Forwarded-Encrypted: i=1; AJvYcCUxWcv4ISZxIJp27yJsVTU3DPc3A5ed/b0HGg23ZL3lWlCiPIzGrHaPoIimN2QWaLbo+80sJkZ36H8v@vger.kernel.org, AJvYcCWaCl9Y+LknNPqvYkZ0bDSCRAYteNOPm/ETJOB3uU8sqDt1l8COfhNAG3Y+sxeoMRC8kabTBalwI07wwmu4@vger.kernel.org, AJvYcCXrawDECcOdA8S+Fqc4iGAg1VLzQlnGhiHVJQxWwCYDQf2HDVO7fLJRLB2wzMqlOfqtP8S5EbgApYeM@vger.kernel.org
X-Gm-Message-State: AOJu0YxifH/Xzoy8ixU9R6DYH7yszVU82e87Tcsc2IYnS/+BxSLH056b
	2IliC+MzGynOSTvMElXtHVuHEYUIC+cOD0O9QxRkWJuqk6vJkUmHqqtJ2zAtK9Uv
X-Gm-Gg: ASbGncsUTd4oaMNLNL+EOl7HhZ1VOWKrlHbb/1lHvgMPjmNCeblHlU4hwxoPJw4PfLc
	AfUqkwQAS4xV1kbGfRu3wid7ZazgFbyFGrVhtJwYHt0Sy4YErQak2IU0p6O1QvYNV2JOkz/avd7
	EYmndsQYapka29Ciegf8/TzAMlcpNbIkGchtth1WfkyquSn1d6S40XUTxRaQmCeMKgvCgpQTDW0
	NByltQ1B1RyMm37ClJ+Ir9xWOe5YU0GRU6TbaCqBGUxAorc5+mZFXvUwTDDrU9VUhVAjFABUWDW
	YvD/EX0KqYWeftFb1uYcAUHrly6YVnhIQBFIJCQ3fDIU5OPIaLCm1wk6E5ReyUzr3ZRFK/Aq5v3
	EbS1EINyz2JLbFcvw5TvsJ4NBCOZS+u8/9ivD6wHUMQ==
X-Google-Smtp-Source: AGHT+IFJy5JckZxpt90aMohFioubuWk8E0gpbYob5TFHcas8o5j9rpydHf1Y9T1yNSQsI6RoBUXcMA==
X-Received: by 2002:a17:902:f606:b0:240:b075:577f with SMTP id d9443c01a7336-245e04926e5mr47416425ad.37.1755626444145;
        Tue, 19 Aug 2025 11:00:44 -0700 (PDT)
Received: from localhost ([2804:30c:2767:3c00:70b9:40f2:fa7f:19cd])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-245ed4e9bd2sm3117445ad.106.2025.08.19.11.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:00:43 -0700 (PDT)
Date: Tue, 19 Aug 2025 15:01:04 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: 20250816141220.0dd8d68f@jic23-huawei.smtp.subspace.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: ad7768-1: add new supported
 parts
Message-ID: <aKS74OjRSCYhq8Es@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1754617360.git.Jonathan.Santos@analog.com>
 <ecb7406f54938658b51b4469034d87a57086bd1e.1754617360.git.Jonathan.Santos@analog.com>
 <c3cf9b97-3883-4ebb-a2ed-0033adebda87@kernel.org>
 <aJ0UEUVmIH94Nuwi@JSANTO12-L01.ad.analog.com>
 <8c27b00c-5b80-400f-8538-b9ad96fd5feb@kernel.org>
 <20250816141220.0dd8d68f@jic23-huawei>
 <aKOVY+F8JfOFr0O4@JSANTO12-L01.ad.analog.com>
 <41ad5dc8-0179-49b7-a660-2c55b5048db6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41ad5dc8-0179-49b7-a660-2c55b5048db6@kernel.org>

Hi,

On 08/19, Krzysztof Kozlowski wrote:
> On 18/08/2025 23:04, Jonathan Santos wrote:
> > On 08/16, Jonathan Cameron wrote:
> >> On Thu, 14 Aug 2025 08:03:23 +0200
> >> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>
> >>> On 14/08/2025 00:39, Jonathan Santos wrote:
> >>>>>>  
> >>>>>> +  adi,aaf-gain:
> >>>>>> +    description: |
> >>>>>> +      Specifies the gain of the Analog Anti-Aliasing Filter (AAF) applied to the
> >>>>>> +      ADC input, measured in milli-units. The AAF provides additional signal  
> >>>>>
> >>>>> What is milli unit? Isn't gain in dB, so maybe you want mB? Quite
> >>>>> unpopular to see mB, but we cannot use 1/100 of dB, so I could
> >>>>> understand it.
> >>>>>  
> >>>>
> >>>> Actually, the gain is expressed in V/V, not in dB. I may have phrased it poorly, but since
> >>>> there are fractional values like 0.364 and 0.143, I chose to represent it
> >>>> in milli-units.  
> >>>
> >>> Why your reply to is corrupted:
> >>> "c3cf9b97-3883-4ebb-a2ed-0033adebda87@kernel.org"?
> >>>
> >>>
> >>> What sort of unit is milli-unit? Isn't this 1/1000 of some BASE unit,
> >>> but you do not have here a base?
> >>>
> >>> I think you want just basis point if this is V/V (already in common
> >>> property suffixes)
> >> Nice. I didn't know about -bp.   That does sound like a good choice for ratio
> >> stuff and here would be 100x larger actual values which is fine.
> >>
> > 
> > Yes, it would be, but the here it is 1000x larger than the
> > actual value (1/1000 V/V). I don't see another unit in
> 
> Huh? How? 1000x larger would be = 1... This makes no sense...
> 
> 
> > property-units.yaml for this specifc case. Maybe using -milli suffix
> > like in 'adi,ad4000.yaml' and 'adi,ad7380.yaml'?
> 
After having a look at the data sheets for these parts (AD7768-1, ADAQ7767-1,
ADAQ7768-1, ADAQ7769-1), I think this indeed has similar semantics to
adi,gain-milli. The data sheet says the AAF selection has an impact on the -3dB
cutoff frequency but, for a given ODR, there is no difference between the
reported −3 dB Bandwidth (kHz) in Table 12, Table 32, and Table 35 from
AD7768-1, ADAQ7767-1, and ADAQ7769-1, respectively. So, looks like this is just 
about signal amplification/attenuation and so the use of adi,gain-milli sounds
appropriate to me.

Considering the AAF doesn't really impact the -3dB cutoff frequency, maybe the
property could be documented like:

  adi,gain-milli:
    description: |
	  Specifies the gain applied by the Analog Anti-Aliasing Filter (AAF) to the
	  ADC input (in milli units). The hardware gain is determined by which input
      pin(s) the signal goes through into the AAF. The possible connections are:
      * For the ADAQ7767-1: input signal connected to IN1±, IN2± or IN3±.
      * For the ADAQ7769-1: OUT_PGA pin connected to IN1_AAF+, IN2_AAF+, or
        IN3_AAF+.
      If not present, default to 1000 (no actual gain applied).
    $ref: /schemas/types.yaml#/definitions/uint16
    enum: [143, 364, 1000]
    default: 1000

Would something along those lines make sense for these devices?

Best regards,
Marcelo

