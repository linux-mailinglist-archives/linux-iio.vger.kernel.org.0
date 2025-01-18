Return-Path: <linux-iio+bounces-14480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F070DA15ED3
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 21:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0944B7A3050
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 20:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824A31B0433;
	Sat, 18 Jan 2025 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7YZPhgu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BCA1A725C;
	Sat, 18 Jan 2025 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737233437; cv=none; b=fmo5RtaeegYWZBpOOa2Z2cwfusM65m2S9G7run1pVU5SIC+YJkUIspq8CY4YZ1LTnumRRcuZt2lt97P7zvPfFCDFNeNe/wFBaIrBTkfFaBhQrXMkYYcK6mNaJ57LI684TJH9ka1RWuZxlkTj6MY5P4gp7BaWbr67OyrIcWVZDlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737233437; c=relaxed/simple;
	bh=Ny2eazBvBz+HD7V6Ej+FJ/fXnIZxW8SVRu5LidsR1lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRDFbVsFEeOaSeg1DG0ZSV6UBRpuTcOXmws4ve/9gxCZLCY39QIydmOZIDZQfRpQIvpCs4M1wRGcI2k6IyQ+abSMc+7rRSrbN9zdyKhK4TaOKE21++zK/xZV+tu2+r2YYHOV7sNzN965775RFXmqHJGZgpCM3R7EWHxX+FeWAow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7YZPhgu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-219f8263ae0so59593725ad.0;
        Sat, 18 Jan 2025 12:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737233435; x=1737838235; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ploq2WKRqVnusvM3GXcyWAVIZOA0Hrn71AsZtOmPJGI=;
        b=O7YZPhgu2tPUmQpzDpFXo850msmjEPvDqqYsm4oKmqyGY9/bmT5OarIH0YteK+K9o+
         DOL/tX1Qt8frrkJPEPRX/XiVRlVj40pLMHZRaPFYzVOiMyP5ILPuxppEUU9f0SPj5j/t
         /CP1LUmTerJ1wTl0MZ6h4fq9BGYmIIFzk0AUWEc3YKHS+hlt89OIdgkiBqMMSTu7CVnh
         y+/POfCPMuJEr1QCeVznvQF1eFi9iQ0RfU4p3PC/IXOj15pmsmVNsb3pY4OR4bnLcV05
         nzYkUixwBmuhgOa0nLx+qcVIiZm+tOgSMpF0+16jSISJr5TfJnYe0nHENtwHFmGb2deR
         6p6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737233435; x=1737838235;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ploq2WKRqVnusvM3GXcyWAVIZOA0Hrn71AsZtOmPJGI=;
        b=I1hXwD77otEPRWTnxxA3aeXuLQCwFhMQUfKznmxgMKwOjHY9MQTUxRh9lCBi+MywO5
         0+hpDgUbxvf9YnkGZtoQ6RdKrJBukKtEEbNCaVcXXwNezE/uoM9hU6UdFxmTC0waikJc
         lBJOEo4G3Q/h6yFGg2HDZIjUkfBtQHRd208t/a8YettnI2xPjCaTNA5mF1KHHPgTmevt
         tsNlSUxzDMuTRkouwk+Qeag59IzP9l6Gqu4fLeC7eWHtV5w8yVtFaAdMxyWyo9lI4J4T
         gUyVZYUXsXAls20cbAwFmw+1b7fjK7Kkcqh5uAj7waSf0LbSr6ryA8eNH282I3DZCF64
         ZpAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAh0CUswBwh6AZf3nTLa0fPKlQT2FQVuvTPcRri1EGmacDzT39Vr0xci5RO16RD2TTnO1yTgbDeE8=@vger.kernel.org, AJvYcCVTa5mh+RXpOohgBmlnX8ckURRgXpxgSs45fhbaRvLyZuPyHWd7a452Js+TxIK3IqvUlPCuvtVwPbpnjVnC@vger.kernel.org, AJvYcCVhqx42mYANcqL2tbJjoB9I5YfplQ5hNg0j+n96MFUxQ/RVcjmWCgchvjH7Z8Zj2tObkbXuMqTzJJ0l@vger.kernel.org
X-Gm-Message-State: AOJu0YznIdlsLMboP3b0wPjZ+GR1MxbRSFk+ErxcpOqfri+9MBAInJ03
	biblOoMtVqyvhV3ItAO3q/9MuheL+H5DtoMy8IOaHIEc5YQ0bbrg
X-Gm-Gg: ASbGncu9AYbpynkNqZuo4Vfl06s0Nzr4bUqjxZh/k2PlNH0aITFTUbpVbSaVihgA6uE
	gSep2bSuKPfSCZPpTVS2VeIwYqYIR8VqkrmDGauBqEEAnumyWDI9316ANZtP/HKysiM8unWYaN+
	jMfW3oqUSkIc4n+h+V0pdNEJrYRSic0VzIfRQ0b37BfpVyXWjoyZK+8tT2X9YNNn6501ocxE1RX
	rRoSnjfmfCFy+O4Y3dI/Pmkf0am6qLAUbl/CNgZXWGdUkdgJ2G+7ja4s5wwLXKOb31Rld2xlYtp
	xg==
X-Google-Smtp-Source: AGHT+IFNpfUkFGhNrm0RwUIgH2sanQ7blYK5jdIGT9ysMpfnL146ECKSdQIvgwx3/fv0pIQvWD/uXA==
X-Received: by 2002:a05:6a00:3493:b0:725:9cc4:2354 with SMTP id d2e1a72fcca58-72daf950b6fmr11007153b3a.10.1737233434596;
        Sat, 18 Jan 2025 12:50:34 -0800 (PST)
Received: from localhost ([2804:30c:b30:a800:c057:a90:a425:2f39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f2a44sm4165911b3a.36.2025.01.18.12.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 12:50:33 -0800 (PST)
Date: Sat, 18 Jan 2025 17:51:10 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de, corbet@lwn.net
Subject: Re: [PATCH v2 1/1] Documentation: iio: Add ADC documentation
Message-ID: <Z4wUPtDfnmQ53L0k@debian-BULLSEYE-live-builder-AMD64>
References: <efa1dba23c38b207716883d6226ce9e9df5a51b8.1736862045.git.marcelo.schmitt@analog.com>
 <3bd58574-36c6-4102-ad7d-1aeff0e46a95@baylibre.com>
 <20250118155153.2574dbe5@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250118155153.2574dbe5@jic23-huawei>

Hi Jonathan,

Thanks for having another look at this.
I'll do the changes suggested.

Thanks,
Marcelo

On 01/18, Jonathan Cameron wrote:
> On Wed, 15 Jan 2025 11:23:24 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
...
> > > +1.1 Single-ended channels
> > > +-------------------------
> > > +
> > > +Single-ended channels digitize the analog input voltage relative to ground and
> > > +can be either unipolar or bipolar.
> > > +
> > > +1.1.1 Single-ended Unipolar Channels
> > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +
> > > +::
> > > +
> > > +  ---------- VREF -------------
> > > +      ´ `           ´ `                  _____________
> > > +    /     \       /     \               /             |
> > > +   /       \     /       \         --- <  IN    ADC   |
> > > +            \   /         \   /         \             |
> > > +             `-´           `-´           \       VREF |
> > > +  -------- GND (0V) -----------           +-----------+
> > > +                                                  ^
> > > +                                                  |
> > > +                                             External VREF
> > > +
> > > +The input voltage to a **single-ended unipolar** channel is allowed to swing
> > > +from GND to VREF (where VREF is a voltage reference with electrical potential
> > > +higher than system ground). The maximum input voltage is also called VFS
> > > +(full-scale input voltage), with VFS being determined by VREF. The voltage
> 
> Just to align with acronym perhaps
> Voltage input Full-Scale 
> 
Okay, will do.

> > > +reference may be provided from an external supply or derived from the chip power
> > > +source.
> > > +
> > > +A single-ended unipolar channel could be described in device tree like the
> > > +following example::  
> > 
> > We should probably mention somewhere that channel@ nodes are only needed for
> > chips that don't have uniform inputs.
> 
> They are allowed in all cases. For SoCs ADCs it's not unusual to have them even
> if nothing exciting going on because they want to hide channels that aren't
> wired to anything.  For stand along ADCs that is less common because people
> don't buy a device with lots of channels intending to only use a few.
> 
> But sure, mention they may not be provided.

Sure, will mention that. 

> 
> > 
> > > +
> > > +    adc@0 {
> > > +        ...
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        channel@0 {
> > > +            reg = <0>;  
> > 
> > If a chip has mixed differential and single-ended, single-channel could also
> > be needed here in the case where reg is an arbitrary number and doesn't match
> > the input pin number.
> 
> Indeed - that is a weird corner that would be good to highlight.

Ack, will add a word about that too.

> 
> > 
> > > +        };
> > > +    };
> > > +
> > > +See ``Documentation/devicetree/bindings/iio/adc/adc.yaml`` for the complete
> > > +documentation of ADC specific device tree properties.
> > > +
> > > +
...
> > > +1.2.2 Differential Unipolar Channels
> > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +
> > > +For **differential unipolar** channels, the analog voltage at the positive input
> > > +must also be higher than the voltage at the negative input. Thus, the actual
> > > +input range allowed to a differential unipolar channel is IN- to +VREF. Because
> > > +IN+ is allowed to swing with the measured analog signal and the input setup must
> > > +guarantee IN+ will not go below IN- (nor IN- will raise above IN+), most
> > > +differential unipolar channel setups have IN- fixed to a known voltage that does
> > > +not fall within the voltage range expected for the measured signal. This leads
> > > +to a setup that is equivalent to a pseudo-differential channel. Thus,
> > > +differential unipolar channels are actually pseudo-differential unipolar
> > > +channels.  
> > 
> > I don't think this is equevent to pseudo-differential unipolar. That one has
> > a common mode voltage supply on the negative input. This one has a full range
> > signal on the negative input. This is the diagram I was expecting here.
> > 
> > ::
> > 
> >   -------- VREF -------
> >     ´ `       ´ `               +-------------------+
> >   /     \   /     \   /        /                    |
> >          `-´       `-´    --- <  IN+                |
> >   ------ GND (0V) -----        |                    |
> >                                |            ADC     |
> >   -------- VREF -------        |                    |
> >         ´ `       ´ `     --- <  IN-                |
> >   \   /     \   /     \        \       VREF         |
> >    `-´       `-´                +-------------------+
> >   ------ GND (0V) -----                  ^        
> >                                          |       
> >                                   External VREF
> 
> If it's unipolar, output must be positive which isn't true here.
> Do we actually see differential unipolar except for the pseudo case with
> common mode voltage?   Seems like a weird device.

I don't think we have differential unipolar with IN- allowed to float (i.e. not
set to a constant voltage). Haven't seen any of those. Can't think of how we
would support such thing either. See my reply to David for more thoughts on this.

> 
> > 
> > > +
> > > +1.3 Pseudo-differential Channels
> > > +--------------------------------
> > > +
> > > +There is a third ADC input type which is called pseudo-differential or
> > > +single-ended to differential configuration. A pseudo-differential channel is
> > > +similar to a differential channel in that it also measures IN+ relative to IN-.
> > > +However, unlike differential channels, the negative input is limited to a narrow
> > > +(taken as constant) voltage range while only IN+ is allowed to swing. A
> > > +pseudo-differential channel can be made out from a differential pair of inputs
> > > +by restricting the negative input to a known voltage while allowing only the
> > > +positive input to swing. Aside from that, some parts have a COM pin that allows
> > > +single-ended inputs to be referenced to a common-mode voltage, making them
> > > +pseudo-differential channels. Often, the common mode input voltage
> > > +can be nicely described in the device tree as a voltage regulator (e.g.
> > > +``com-supply``) since it is basically a constant voltage source.
> > > +
> > > +1.3.1 Pseudo-differential Unipolar Channels
> > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +
> > > +::
> > > +
> > > +  -------- +VREF ------          +-------------------+
> > > +    ´ `       ´ `               /                    |
> > > +  /     \   /     \   /    --- <  IN+                |
> > > +         `-´       `-´          |                    |
> > > +  --------- IN- -------         |            ADC     |  
> > 
> > The bottom rail should be GND (or -VREF), not IN-. Making it GND in the diagram
> > would be consistent with the other unipolar diagrams and reflect most typical
> > cases. I think the counterexample you gave of AD4170-4 is the unusual case
> > rather than the typical case.
> > 
> > FWIW, when I was first learning this stuff, I didn't really understand bipolar
> > vs. unipolar until I saw diagrams that showed 0V as the bottom rail for unipolar
> > and negative VREF as the bottom rail for bipolar. Even if it isn't strictly
> > true in all cases, seeing the pattern was more helpful. Hard to say if most
> > other people think like me though. :-)
> 
> Maybe IN- (typically GND) is appropriate?
Sounds good to me.
Can also add a typical case (with IN- at GND) example if desired.

> > 
...
> > > +
> > > +1.3.2 Pseudo-differential Bipolar Channels
> > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +
> > > +::
> > > +
> > > +  -------- +VREF ------          +-------------------+
> > > +    ´ `       ´ `               /                    |
> > > +  /     \   /     \   /    --- <  IN+                |
> > > +         `-´       `-´          |                    |
> > > +  -------- -VREF ------         |            ADC     |
> > > +                                |                    |
> > > +  Common-mode voltage -->  --- <  IN-                |
> > > +                                \       +VREF  -VREF |
> > > +                                 +-------------------+
> > > +                                          ^       ^
> > > +                                          |       +---- External -VREF
> > > +                                   External +VREF
> > > +
> > > +A **pseudo-differential bipolar** input is not limited by the level at IN- but
> > > +it will be limited to -VREF or to GND on the lower end of the input range  
> > 
> > 
> > If it was limited to GND, then it would be uniploar. It is only bipolar if
> > -VREF is less than 0V.
> 
> I'm not sure on that.  See comment on your example above. That is
> what I think a Pseudo-differential bipolar channel is (and it matches the
> first thing google gave me).
> 
> Key here is that common mode voltage on IN- is between -VREF and +VREF so
> we can swing past it and get both positive an negative.

Yes, exactly.

> 
> > 
...
> > > --- a/Documentation/iio/index.rst
> > > +++ b/Documentation/iio/index.rst
> > > @@ -7,6 +7,7 @@ Industrial I/O
> > >  .. toctree::
> > >     :maxdepth: 1
> > >  
> > > +   iio_adc
> > >     iio_configfs
> > >     iio_devbuf
> > >     iio_dmabuf_api
> > > 
> > > base-commit: 9b75dd1b7d6b98699a104c6b1eec0c8817e5fd4b  
> > 
> 

