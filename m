Return-Path: <linux-iio+bounces-6602-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DC390F68E
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 20:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0865F1C238D7
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 18:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63501158865;
	Wed, 19 Jun 2024 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwUtKpw5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7485524C4;
	Wed, 19 Jun 2024 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718823400; cv=none; b=AxQ8g8zcVPWz7jnRUygj7QLp/XNwURgl3AF2kWMBCifSV907r9Ygrv+4/K92kbsfq6dUKSGxHX755Iwmlf3xoJTMGrr2Z3sf4zTsdaa7VGg/SDFzb2/gsEA9y9BF26IQGa5hM8K0hysHLmtlRz0wDiMQiMPKDg+ybhr9U5w/c34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718823400; c=relaxed/simple;
	bh=T7Ciu3qNiR5Icl6XemypPAeb5qL3BwqYVV6dNqVCi/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPyjHIMqmZ65mVbTLAxbHTOfAEJ1s9BGhJ5FGPveq0759w1OPkH5eaSE7+eUlZWUe+Hw4vxsQqqjNxv8YvhTx0PZde9BJvSmClQjy5R2hWH+Rt40re24xlmeZX7tMrwjHKHNE7zhaQjIj/vsDIhVtdezlQzPSflb8tbb6psR64U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwUtKpw5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-706264e1692so138024b3a.1;
        Wed, 19 Jun 2024 11:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718823398; x=1719428198; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ScMXAGmkvjxsewPcBmGJ0WhcoL5/MBR16fEttQQynUM=;
        b=cwUtKpw5MlUOJBOzOmhRyoQGC1TbXPDAqJIWSPdyhqGBKeCk447G1Rk+ciLNHhjNba
         5/IuZ5SehOj8Wodfd19wHaeqpLsyw4NsiX5o4zBUj7SNkauJ9jOUumtd+yYmWGzOpTYw
         0KhsEdD44PCXDR4dzllpB3WbHUK4g68oKfN2VFHtiOMKJDYJacxP//HnEBbZCl2AiIWJ
         jx+TV+4DemCPjZk84g8SW+GMp1KWq+r1DKmoPmLW4V7cxPl4d5mGuP19KKJjy0vkM0G5
         b/0U88bJy1LOmCGJF8rRPRgbjHJ7Jj5X2MVUjP4uX7e5fJ40aw7vVhoCV+ytETGqOUzD
         lkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718823398; x=1719428198;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScMXAGmkvjxsewPcBmGJ0WhcoL5/MBR16fEttQQynUM=;
        b=I7lujwx1TxuRzNbZr75fUCYZPcEFxCWH52liomJ2ALt87bs/CjIs+q3NDOOiU9687/
         VvvUh76RqjclTPx0YXVbknq2/bi7hzd34420myMTfYusOwpZaqMaTFtnBnYLFIdVT55S
         RxfZmYTvZQD6jbFXXiG7Y6lP4rxYdRw7fkJ4m58w4I5G2v7cyB42L4q1weUis5/5MO2P
         kFY8gIpGCtAe1EQv1/mBvUNoBuappt3rSbCIjN9tmRU5AWqq/ce3AxppxWq8LkhigNrL
         uGdvhg72bYAk2Bofz7W11pW/hfKVkOKObt9arg2IaijNRCZGbEfRT8nUJd/ferNw29PS
         8OpA==
X-Forwarded-Encrypted: i=1; AJvYcCXMrF3R5nz1qWsDpeV/H6PdmGzrzwbXbVH/XUrh+lMPvj0djmixQXg5O+3KXVdF6QUCuDe10Z9jfUqheW3lkzBvoPZ2Ve/cUsCXGLhS6LhcnSVPNhXipHN0NdrieO1CTHeUT7b7eM2GFr+RE+aTQ3YT8+fQ73OyCDl2ZyFqMJ9+88tU2XSKjfKxAaTWKhnDMe7ENE5qc9DC/tFtk+sMcA==
X-Gm-Message-State: AOJu0YyNd8+i+IpsTAmNtLgYPxd2yRzXEullug0WkLcdKsLWNwnubWb6
	lg09NvDam7WEjhbamT1BuXFjX6mYaAlgavLv2XSsLcrfzYoMSRqL
X-Google-Smtp-Source: AGHT+IGeruaa+Etxr3n220Oj1wJ6MN9OOELByR395klkY1ApI9Xn7SOJaTIASjNfY1AyfiM5tjGYjg==
X-Received: by 2002:a05:6a20:249e:b0:1b7:d72e:9e5e with SMTP id adf61e73a8af0-1bcbb58ba3fmr3204568637.37.1718823397733;
        Wed, 19 Jun 2024 11:56:37 -0700 (PDT)
Received: from localhost ([2804:30c:96b:f700:cc1d:c0ae:96c9:c934])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6af7fsm11026144b3a.159.2024.06.19.11.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 11:56:37 -0700 (PDT)
Date: Wed, 19 Jun 2024 15:58:00 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] spi: Enable controllers to extend the SPI
 protocol with MOSI idle configuration
Message-ID: <ZnMqOAPc3IXP-eHC@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
 <36eefb860f660e2cadb13b00aca04b5a65498993.1718749981.git.marcelo.schmitt@analog.com>
 <63db9349-f453-4a5b-aa09-d1857ddd8b03@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63db9349-f453-4a5b-aa09-d1857ddd8b03@baylibre.com>

On 06/19, David Lechner wrote:
> On 6/18/24 6:10 PM, Marcelo Schmitt wrote:
> 
> 
> > +
> > +MOSI idle state configuration
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +Common SPI protocol implementations don't specify any state or behavior for the
> > +MOSI line when the controller is not clocking out data. However, there do exist
> > +peripherals that require specific MOSI line state when data is not being clocked
> > +out. For example, if the peripheral expects the MOSI line to be high when the
> > +controller is not clocking out data (SPI_MOSI_IDLE_HIGH), then a transfer in SPI
> > +mode 0 would look like the following:
> > +
> > +::
> > +
> > +  nCSx ___                                                                   ___
> > +          \_________________________________________________________________/
> > +          •                                                                 •
> > +          •                                                                 •
> > +  SCLK         ___     ___     ___     ___     ___     ___     ___     ___
> > +       _______/   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \_____
> > +          •   :   ;   :   ;   :   ;   :   ;   :   ;   :   ;   :   ;   :   ; •
> > +          •   :   ;   :   ;   :   ;   :   ;   :   ;   :   ;   :   ;   :   ; •
> > +  MOSI _____         _______         _______         _______________         ___
> > +  0x56      \_0_____/ 1     \_0_____/ 1     \_0_____/ 1       1     \_0_____/
> > +          •       ;       ;       ;       ;       ;       ;       ;       ; •
> > +          •       ;       ;       ;       ;       ;       ;       ;       ; •
> > +  MISO XXX__________         _______________________          _______        XXX
> > +  0xBA XXX__/     1 \_____0_/     1       1       1 \_____0__/    1  \____0__XXX
> > +
> > +Legend::
> > +
> > +  • marks the start/end of transmission;
> > +  : marks when data is clocked into the peripheral;
> > +  ; marks when data is clocked into the controller;
> > +  X marks when line states are not specified.
> > +
> > +In this extension to the usual SPI protocol, the MOSI line state is specified to
> > +be kept high when CS is active but the controller is not clocking out data to
> 
> I think it would be less ambiguous to say "asserted" instead of "active".

I'm not sure. IMHO, it looks less ambiguous to say a CS is active.
I think the most common for CS lines is to have a CS that is active low (i.e.
the line is at a low voltage level when the controller is selecting the device).
To me, "assert" sounds closer to the idea o setting something (like a bit to 1),
which is the opposite of active low CS.
Though, no strong opinion about it.
I go with what the maintainers prefer.

> 
> > +the peripheral and also when CS is inactive.
> 
> As I mentioned in a previous review, I think the key detail here is that the
> MOSI line has to be in the required state during the CS line assertion
> (falling edge). I didn't really get that from the current wording. The current
> wording makes it sound like MOSI needs to be high indefinitely longer.

It may be that we only need MOSI high just before bringing CS low. Though,
I don't see that info in the datasheets. How much time would MOSI be required
to be high prior to bringing CS low? The timing diagrams for register access and
ADC sampling in "3-wire" mode all start and end with MOSI at logical 1 (high).
I think reg access work if MOSI is brought low after CS gets low, but sample
read definitely don't work.

From the info available in datasheets, it looks like MOSI is indeed expected 
to be high indefinitely amount of time. Except when the controller is clocking
out data to the peripheral.

Even if find out the amount of time MOSI would be required high prior to CS low,
then we would need some sort of MOSI high/low state set with a delay prior to
active CS. That might be enough to support the AD4000 series of devices but,
would it be worth the added complexity?

> 
> > +
> > +Peripherals that require this extension must request it by setting the
> > +SPI_MOSI_IDLE_HIGH bit into the mode attribute of their struct spi_device and
> 
> Could use inline code formatting for C code bits, e.g. ``struct spi_device``
> ``SPI_MOSI_IDLE_HIGH``, etc.
ok, updated those for v5.

> 
> > +call spi_setup(). Controllers that support this extension should indicate it by> +setting SPI_MOSI_IDLE_HIGH in the mode_bits attribute of their struct
> > +spi_controller. The configuration to idle MOSI low is analogous but uses the
> > +SPI_MOSI_IDLE_LOW mode bit.
> > +
> > +
> >  THANKS TO
> >  ---------
> >  Contributors to Linux-SPI discussions include (in alphabetical order,
> 
> ...
> 
> > index e8e1e798924f..8e50a8559225 100644
> > --- a/include/linux/spi/spi.h
> > +++ b/include/linux/spi/spi.h
> > @@ -599,6 +599,12 @@ struct spi_controller {
> >  	 * assert/de-assert more than one chip select at once.
> >  	 */
> >  #define SPI_CONTROLLER_MULTI_CS		BIT(7)
> > +	/*
> > +	 * The spi-controller is capable of keeping the MOSI line low or high
> > +	 * when not clocking out data.
> > +	 */
> > +#define SPI_CONTROLLER_MOSI_IDLE_LOW    BIT(8)  /* Can idle MOSI low */
> > +#define SPI_CONTROLLER_MOSI_IDLE_HIGH   BIT(9)  /* Can idle MOSI high */
> 
> I don't see where these are used anywhere else in the series. They
> seem redundant with SPI_MOSI_IDLE_LOW and SPI_MOSI_IDLE_HIGH.
> 
Good point.
They are currently not being used.
Comparing with what we have for SPI_CONTROLLER_MULTI_CS, I'm thinking it may be
handy to have dt properties to indicate controller MOSI idle capabilities.
Does that sound reasonable?

> >  
> >  	/* Flag indicating if the allocation of this struct is devres-managed */
> >  	bool			devm_allocated;
> > diff --git a/include/uapi/linux/spi/spi.h b/include/uapi/linux/spi/spi.h
> > index ca56e477d161..ee4ac812b8f8 100644
> > --- a/include/uapi/linux/spi/spi.h
> > +++ b/include/uapi/linux/spi/spi.h
> > @@ -28,7 +28,8 @@
> >  #define	SPI_RX_OCTAL		_BITUL(14)	/* receive with 8 wires */
> >  #define	SPI_3WIRE_HIZ		_BITUL(15)	/* high impedance turnaround */
> >  #define	SPI_RX_CPHA_FLIP	_BITUL(16)	/* flip CPHA on Rx only xfer */
> > -#define SPI_MOSI_IDLE_LOW	_BITUL(17)	/* leave mosi line low when idle */
> > +#define SPI_MOSI_IDLE_LOW	_BITUL(17)	/* leave MOSI line low when idle */
> > +#define SPI_MOSI_IDLE_HIGH	_BITUL(18)	/* leave MOSI line high when idle */
> >  
> >  /*
> >   * All the bits defined above should be covered by SPI_MODE_USER_MASK.
> > @@ -38,6 +39,6 @@
> >   * These bits must not overlap. A static assert check should make sure of that.
> >   * If adding extra bits, make sure to increase the bit index below as well.
> >   */
> > -#define SPI_MODE_USER_MASK	(_BITUL(18) - 1)
> > +#define SPI_MODE_USER_MASK	(_BITUL(19) - 1)
> >  
> >  #endif /* _UAPI_SPI_H */
> 

