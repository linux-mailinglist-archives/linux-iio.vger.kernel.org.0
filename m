Return-Path: <linux-iio+bounces-22557-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A39C8B2045C
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 11:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9746B4E2A8A
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 09:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19260230BDF;
	Mon, 11 Aug 2025 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5mBz5B7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5F229B16;
	Mon, 11 Aug 2025 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905791; cv=none; b=O3+Bbm3t9rGRttG+K/rpa8w8eN+ubBGSZbmRD9PgRF8aKJ6kbUQGH0S0KdOiWnmzrlbghgw2tb1YSp28KtVrlc2D3g6DbLpYC3dM7T+Q6yM6v/mYvCzHEcHO0b2w+PnIPQXwzZeUFivrAKxP6CfdjlLscyQWgB9koLeploS5jf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905791; c=relaxed/simple;
	bh=YcmcwVrntbpJUWvUkS8vL6G2StHtKJEcN6d3vVXoA2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMzHWk5ZIFFqo4Osk7nPqBthj8NfCkyWapUXvDUrwsefmb879SJ7ul0g3AS0Bna1Uj5BfBYH+O+98cHTM7Y0AQ+VYagx3lhkzbRJtvN03w5DE5GPK9ozIMc7jcBuC/LEpnIqmc6GX8MB5sSs7ITkBD2s6SP1mOUTxusslQdJlHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5mBz5B7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so28152345e9.1;
        Mon, 11 Aug 2025 02:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754905788; x=1755510588; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xnroKAEBQ+dZK/MQ1N+FPOoMHBUJeVwsvByY/1RrYzA=;
        b=R5mBz5B7PtdZBp2q4VR9AChPnvNJOg0BRKWIcqmnIadTBieq2CGRv1bD9dfBfdJwoj
         H5LfekqGy/G2xPC+DCFeR+ygapO2XFbfb85rgJuGEzpsf+nn0+/NrKLFSKde1iy/+uKv
         gfxPxc34XC6k+3C9I62xIzvZJIdVrLC/YLIZacTQ6wEjt7tFiyOoABm4txoYNJ9EoTLF
         9RysT+JAdc5TvSliksW4xYPMve6F1/WTIDwWjkRvWGFZPpz2m3Ae3fswtlWVcZVsWahY
         lJ/SggI/8AM1/Vk10VywJeHSQw0W0gZtZ/ONxMYFj+YMFzJP+rasJ+Ou0JPhrzJUutWz
         P5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754905788; x=1755510588;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xnroKAEBQ+dZK/MQ1N+FPOoMHBUJeVwsvByY/1RrYzA=;
        b=NWUs04oz4YBYXhlbe+og4l8VpWByLrO7PA0MKP2nzERBfACz4lLVQABh6yrQUoeDM5
         4fEi6/ih20C83k4nrV9+TtcQ8BQHPgUZE9Asb7svbKBL9gNdopw2Qm6SVdGOoRiEoGrr
         N604AjkohqgiSuQxfZO4YtmQKjNtveQI6JeUKRMSS51YmQRRCyV8xUGUF1ZBRah73taS
         H7Rf9A6VKwL2m99NFLUUOedFCh32g2TfoTlhpZEPMsb7yafR9H6jdzmHF54rIEvVlAZG
         /CyYQa5s1EQha+SqvAnoJBZSHTGy0sP9ojfRb2hQaBgjdGGGGziU6gk4XqGP4NEhRy6u
         pFLg==
X-Forwarded-Encrypted: i=1; AJvYcCU7TYZuZBiCFjGSoEcqqM3Is8eYY5JVeG0ahGWhcXL/14wSOGf4eFJG+48eLSftkCDl3OK6Xs9mUZBZy32a@vger.kernel.org, AJvYcCVwS79zVF7vmHteDKhIRX+Z5g8N+pdFLNgiiRe/LizVEekiTflOiUQrzZTAtFmR+Rw87xMWzDNKtp1u@vger.kernel.org, AJvYcCVy1zliCUuv5s6ox/fro7n+Tvtm5I70eiyYKZd8bBFWU6H2oAT57W4KuQWJYqPWax/MFsp6JfysYws6@vger.kernel.org
X-Gm-Message-State: AOJu0YxHAfw4/OTpXNfqoasJdmYjlyiJHilC+oyd5fqAIhkThIzXVa6z
	wz785muYSREqlP7fZsW4xptIUAw6j/063P2IW3dZcIMlCnAy0xWufYPQ
X-Gm-Gg: ASbGncuQDIphtWYhfBD9R/znG5CzmK6dKcB2y2iwu8PxoSB18+eW6hNRBkeoohP/u6+
	n7sEvbTmtVdGxqR53vmuQV7yDx7Wcu8VHjPAFAP6AmIHYfHvGUjyu22uSjYMnHZZW4XJbgOcjeB
	CofPoJv4iqie5F47OG2TigHXnQKSGi48aSjHMD96ltGsQahs0O178tSvNLu2X8LWeXdfEEw6ioU
	DDx5+bQEowT7lKv0hLiZNbpPyhzLbP5SpkqIDzgwqK6rnPARKOD5333elY/sCXq+I7FGFG5U30t
	RuzVz3VNjm3fzyxPEXNbgfDy0tWpgOzi0IrD3yZ8VdejL6wePeaVBLOuahlIhXBt3pdjTPJdimU
	Tdtsf2wSBKmc0gQ==
X-Google-Smtp-Source: AGHT+IGd0A/3HGvlzm42aeigaZGW8IWcsYrCcr1/VFCrAJo8sseeU3JaSPP6i3EQFcqD1YiPx+SDQg==
X-Received: by 2002:a05:600c:474f:b0:456:1d61:b0f2 with SMTP id 5b1f17b1804b1-459f4fc32fbmr122103575e9.30.1754905787471;
        Mon, 11 Aug 2025 02:49:47 -0700 (PDT)
Received: from nsa ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bc12csm40819109f8f.28.2025.08.11.02.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:49:47 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:50:04 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: Replace bouncing Analog emails
Message-ID: <d6n24lux6pv47mb3z2bfdbtn5olsm46rdbnkwhjurkwh4a27kl@hkcedsvni4il>
References: <20250724113826.61998-2-krzysztof.kozlowski@linaro.org>
 <20250728144901.3f646a4c@jic23-huawei>
 <20250809210438.23fb5fd0@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250809210438.23fb5fd0@jic23-huawei>

On Sat, Aug 09, 2025 at 09:04:38PM +0100, Jonathan Cameron wrote:
> On Mon, 28 Jul 2025 14:49:01 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Thu, 24 Jul 2025 13:38:27 +0200
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> > 
> > > Emails to stefan.popa@analog.com and alexandru.tachici@analog.com bounce
> > > permanently:
> > > 
> > >   Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipient not found by SMTP address lookup'
> > > 
> > > so replace them with Marcelo Schmitt from Analog where appropriate.
> > > 
> > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > 
> > > ---
> > > 
> > > I don't know who from Analog should maintain these devices, so I chosen
> > > author from Analog of one of last commits.
> > > 
> > > Marcelo Schmitt, could you confirm that you are okay (or not) with this?  
> > 
> > Nuno, Michael, other ADI folk.  Can someone confirm if we are making these Marcelo's
> > problem?
> > 
> 
> As amusing as it would be for me, I definitely can't pick this up without
> some tags from ADI folk and Marcelo in particular!!

Normally in situations like this, it defaults to me but I'm happy if
Marcelo is comfortable in assuming maintainership for these.

That said, I do think that for the adis* drivers it makes sense to be me.

- Nuno Sá
> 
> Jonathan
> 
> > Jonathan
> > 
> > > ---
> > >  Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml | 2 +-
> > >  Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml   | 2 +-
> > >  Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml      | 2 +-
> > >  Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml    | 1 -
> > >  Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml     | 2 +-
> > >  Documentation/devicetree/bindings/iio/frequency/adf4371.yaml   | 2 +-
> > >  Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml   | 2 +-
> > >  7 files changed, 6 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> > > index 3dc973b98f81..40e9a40a7a60 100644
> > > --- a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> > > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> > >  title: ADIS16240 Programmable Impact Sensor and Recorder driver
> > >  
> > >  maintainers:
> > > -  - Alexandru Tachici <alexandru.tachici@analog.com>
> > > +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> > >  
> > >  description: |
> > >    ADIS16240 Programmable Impact Sensor and Recorder driver that supports
> > > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> > > index 88aa67bf2280..55e44c9292cf 100644
> > > --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> > > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> > >  title: Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
> > >  
> > >  maintainers:
> > > -  - Stefan Popa <stefan.popa@analog.com>
> > > +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> > >  
> > >  description: |
> > >    Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer that supports
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> > > index 7146a654ae38..958a37def56c 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> > > @@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> > >  title: Analog Devices AD7124 ADC device driver
> > >  
> > >  maintainers:
> > > -  - Stefan Popa <stefan.popa@analog.com>
> > > +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> > >  
> > >  description: |
> > >    Bindings for the Analog Devices AD7124 ADC device. Datasheet can be
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> > > index 5207c919abe0..eac48166fe72 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> > > @@ -9,7 +9,6 @@ title: Linear Technology / Analog Devices LTC2496 ADC
> > >  maintainers:
> > >    - Lars-Peter Clausen <lars@metafoo.de>
> > >    - Michael Hennerich <Michael.Hennerich@analog.com>
> > > -  - Stefan Popa <stefan.popa@analog.com>
> > >  
> > >  properties:
> > >    compatible:
> > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> > > index 82b0eed6a7b7..058df4c8ddf8 100644
> > > --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> > > @@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> > >  title: Analog Devices AD5770R DAC device driver
> > >  
> > >  maintainers:
> > > -  - Alexandru Tachici <alexandru.tachici@analog.com>
> > > +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> > >  
> > >  description: |
> > >    Bindings for the Analog Devices AD5770R current DAC device. Datasheet can be
> > > diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> > > index 53d607441612..031b1657cde1 100644
> > > --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> > > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> > >  title: Analog Devices ADF4371/ADF4372 Wideband Synthesizers
> > >  
> > >  maintainers:
> > > -  - Popa Stefan <stefan.popa@analog.com>
> > > +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> > >  
> > >  description: |
> > >    Analog Devices ADF4371/ADF4372 SPI Wideband Synthesizers
> > > diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
> > > index 7a1a74fec281..e49d5e6fab61 100644
> > > --- a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
> > > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> > >  title: Analog Devices ADIS16480 and similar IMUs
> > >  
> > >  maintainers:
> > > -  - Alexandru Tachici <alexandru.tachici@analog.com>
> > > +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> > >  
> > >  properties:
> > >    compatible:  
> > 
> > 
> 

