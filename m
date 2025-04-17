Return-Path: <linux-iio+bounces-18181-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6992A90FF8
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 02:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB8D07AAE4C
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 00:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7715979C4;
	Thu, 17 Apr 2025 00:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHmqfsng"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E4B23C9;
	Thu, 17 Apr 2025 00:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744848519; cv=none; b=O+9M1aOe9KWqQGXozw6pyax8K55Qu2Xt7q4l0AIGaRUySFHPBUy2pC1jvCRpi0PBdJ6arDvDMz5EkMJ6nDURJlHwWGRlRl/4YksIVK73NsNTVSW87RkGIRUWoYQ32d78PtW4vdTGPaTlrx5g5bAUqWpnnR5oSTFULoy04Nrli44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744848519; c=relaxed/simple;
	bh=hGr79s50hbOArFrIr7J2c9YKbRUTXQLJEWlC9VOUCM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKoEyxjNNDfddFSyabW16kmWjabyPhO0YhkQE+4aSUpVnB7oOl+myu+FsayWDPErfv4CcW1omYPWpzW47MIBs4RVQ2QSmpSlYF7HZ/BnIohRKTNU5mX+y/I/GDxHKTvscGqxXu+zaewja4oz6F0ZrfnFn2/Ujbzi94bc4G9k9Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHmqfsng; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8fa1f99a6so382826d6.3;
        Wed, 16 Apr 2025 17:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744848516; x=1745453316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJqOv8o36TMLKjrK4zXvLAIpyGUhPRv2sP67Kw4EUAY=;
        b=QHmqfsngc02NTZUUbY02r3j+8FYJDDgaxurqJkkaIcbR+QnzAjWhFfyb580uaOshqB
         R/K9CpQ9P7yPp2e5gxL8jRQMdyzKCjADMjDFTQr9pmBD3vOcd1pIFmCP8vD+G9OB0E2J
         bkYcVV+XqbVk0AP6rkdRd5LlFup1kECzfFkIarShXpSZHyluUZOjHV7ZFn9Jb0hdbN5Y
         9uqXXatpWB9/iUn7qmYtK0tte39ngw1+EmlZQEUPbKEfvQr78bmHW+thAszQATaKT7yr
         fRs6Yqo0Lt06wm/ZH7IpBpzra1SfWXGNQx9bv8NU1URMDEqy96wxS5WccXcOiiLraurb
         jSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744848516; x=1745453316;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJqOv8o36TMLKjrK4zXvLAIpyGUhPRv2sP67Kw4EUAY=;
        b=Yln/ozDHkUqA5aAD9mqexvTFctrh2bxRu1d+dpSzGKuuoTcPPCUxTX/+Scsu10k8Fn
         qzkaB1uJTE713Oh1epKjZlWjst5prDbVPa5JKLEZQfFu+yIj2IqNv1SbCnyWDpSqcOq3
         Y8rbPCsx0O3HdVedSxdYEgAe3uMPLkE1mBIEpiivv8k3luyQA6V2ccsQDTlG8xjU8Wuc
         bkZuXqslADQ4Mbgq6DYucZcerYVDJqP909MZ7mslWXq7vJR6iKsm2vrt3NB7nU1MC/Af
         sdVJOXVJfxdwWEvjpCJumwDUZiutEs+QbZV6EsuLqEn2bXNa7DrccGJLTcRa6g8J6RHW
         rP8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUL+9IizsFA4UYAzxq3gu/C98ZjIJWeWhccc6qQq4AhFF1EvtI9AzD9TIPSLdyUhY3qS8Gk+Hmp8BTu@vger.kernel.org, AJvYcCUejfPDVytu8KqvI2m3AP73OLJItNz0tj6eUqIwItvR1me3KxozNGBSvai7F23n5Alszw8nCy9ka27/@vger.kernel.org, AJvYcCV2chR7y4T50eW03xNs+Df+9boyylu8LC2rIk8utHhCP58BqmL0vei2t0PFGq74WcCTJUpe6Lp4htJOMk/S@vger.kernel.org, AJvYcCXy3LBeuKtesXXeRvGjM8ZOhgdgZc9Jt1tycmdkJeunjGIMvYbBN0bnIF3YgFyv9MrWdGq/XrT6S6Gfeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRTLiC0tghdd8VHTjP4G5aNHHwVb+LcqtBjRX6AcieBr7Xi1Dh
	UTpcOGG3qFo3gOLDN8e+rqoCfItGDgtTv7ZBruo3JIANJcOTBoVf
X-Gm-Gg: ASbGncuXG/ausKCs0jqQfVZLH9phK0+Du9t1IPWbBaMc32rdfOUmwG1yqyKZtMfYDBX
	dBRB4zTjOdYAcnDmNofZ/J54DlTnZ5v/Xj9X4TX/ZauhFer6oYV7Gtw5MOKce/39bXnbUddRqPq
	KFLA7KqY6qPceOvSlvLcg8r0Rj55U6Tps8any/+YZTtF/j3NAnFovuuVUn+ha9lZceYau/r2ZJj
	5zjcQPKnqeasjNxyGUzbMB+QZE0IjQq+EMv97+Dm3dmc0YgPsjC+NfCikTbaEErlnTyQDGd1gIH
	ZTNUooTpa3IxnWuoN3RjBsoI4/ZNmgKyj4YT4jEaBgIlPCr/kIz/doeIcSBc/A==
X-Google-Smtp-Source: AGHT+IEgt/xzdl4pyyhYr8Rve1iU9l/NmW8OKduLXW80EHNhcCRd4MzklhGlnNblENETHjaRR9goIw==
X-Received: by 2002:ad4:5fc8:0:b0:6e8:98ce:dd75 with SMTP id 6a1803df08f44-6f2b964e60cmr9426336d6.9.1744848516175;
        Wed, 16 Apr 2025 17:08:36 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de9734a8sm122800756d6.48.2025.04.16.17.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 17:08:35 -0700 (PDT)
Date: Wed, 16 Apr 2025 21:08:30 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org
Subject: Re: [PATCH v5 02/14] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
Message-ID: <aABGfv+9KxEt5sAq@JSANTO12-L01.ad.analog.com>
Reply-To: 938b950b-4215-4358-a888-6f6c9aab48e8@baylibre.com
References: <cover.1744325346.git.Jonathan.Santos@analog.com>
 <35481552e9ce39a24a0257ab001c0bcfea1a23be.1744325346.git.Jonathan.Santos@analog.com>
 <938b950b-4215-4358-a888-6f6c9aab48e8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <938b950b-4215-4358-a888-6f6c9aab48e8@baylibre.com>

On 04/11, David Lechner wrote:
> On 4/11/25 10:56 AM, Jonathan Santos wrote:
> > In addition to GPIO synchronization, The AD7768-1 also supports
> > synchronization over SPI, which use is recommended when the GPIO
> > cannot provide a pulse synchronous with the base MCLK signal. It
> > consists of looping back the SYNC_OUT to the SYNC_IN pin and send
> > a command via SPI to trigger the synchronization.
> > 
> > Introduce the 'trigger-sources' property to support SPI-based
> > synchronization, along with additional optional entries for the SPI
> > offload trigger and the START signal via GPIO3.
> > 
> > While at it, add description to the interrupts property.
> > 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> > v5 Changes:
> > * Include START pin and DRDY in the trigger-sources description.
> > * Fixed "#trigger-source-cells" value and description.
> > * sync-in-gpios is represented in the trigger-sources property.
> > 
> > v4 Changes:
> > * none
> > 
> > v3 Changes:
> > * Fixed dt-bindings errors.
> > * Trigger-source is set as an alternative to sync-in-gpios, so we
> >   don't break the previous ABI.
> > * increased maxItems from trigger-sources to 2.
> > 
> > v2 Changes:
> > * Patch added as replacement for adi,sync-in-spi patch.
> > * addressed the request for a description to interrupts property.
> > ---
> >  .../bindings/iio/adc/adi,ad7768-1.yaml        | 38 +++++++++++++++++--
> >  1 file changed, 35 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > index 3ce59d4d065f..4c58dbe8f749 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > @@ -26,7 +26,30 @@ properties:
> >    clock-names:
> >      const: mclk
> >  
> > +  trigger-sources:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    minItems: 1
> > +    maxItems: 3
> > +    description: |
> > +      A list of phandles referencing trigger source devices or GPIOs.
> 
> I don't think a gpio phandle should be directly allowed. Only a trigger
> source provider (something with #trigger-source-cells).
> 

Sorry, I meant gpio-trigger, but I phrased it incorrectly.

> > +      Supports up to three entries, each representing a different type of
> > +      trigger:
> > +
> > +        - First entry specifies the device responsible for driving the
> > +          synchronization (SYNC_IN) pin, as an alternative to adi,sync-in-gpios.
> > +          This can be a `gpio-trigger` or another `ad7768-1` device. If the
> > +          device's own SYNC_OUT pin is internally connected to its SYNC_IN pin,
> > +          reference the device itself or omit this property.
> > +        - Second entry optionally defines a GPIO3 pin used as a START signal trigger.
> > +        - Third entry specifies a GPIO line to act as a trigger for SPI offload.
> 
> SPI offload is part of the SPI controller, not the ADC chip, so doesn't
> make sense to have that binding here. In that case, the ADC is the
> trigger-source provider, not consumer.

Right! Maybe a silly question, but this means we would have then two trigger-sources 
defined, one in the spi controller node and other in the adc node, right? like
this:

spi_controller: spi@44a00000 {
	...
	trigger-sources = <&offload_trigger_source>;
	...
	adc0@ {
	...
		trigger-sources = <&sync_trigger_source>;
		#trigger-source-cells = <1>;
	...
	}
}

> 
> 
> 

