Return-Path: <linux-iio+bounces-14143-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CA3A0A63F
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 23:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812EB1687B9
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 22:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA2D1B9831;
	Sat, 11 Jan 2025 22:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUMyk82W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A18415383C;
	Sat, 11 Jan 2025 22:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736634862; cv=none; b=Cm3d75JYWZtOkHY+TKUHwkF2MgxalOUF7eMRudxQw4iyjkBWoClVaUQY718wq0cX8h/tIycSHD6YkVImjoLpq2efgI5vFqhjlN8LZyyPbBMLDprujPduG1GPwd3YuDdc7y9V/U1V3zENEGa+PUiIvcu97IPI4OiteJfA1sqdIzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736634862; c=relaxed/simple;
	bh=uKFRvKB3Z6IX4NPkJr6trhGulT6JeHkAM8Dz562NcjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqYQSwQt8EUVDxODUT8MeJ9mm5hPhJZpFhdFkFyR5pDmoON0dWzRy7JLChDNldzLnyoJPVZJ6NAtNcp54MyOtfTSWmc1jLAd4Hv9zmsGymc3aZlGeWsQ9ybhwG+ZOTPbkKW9kVhGChowfonQaasYEqlBfopf4vch6T5ZJ6mU4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUMyk82W; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71e327ffbafso396008a34.2;
        Sat, 11 Jan 2025 14:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736634859; x=1737239659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KO5Nh/wm6Ek4qtIcencBavl3r9HWIoiPqvgOtXk6wLY=;
        b=JUMyk82WQAWRhIEJ/618tYDnDKso3Vird3jlSrZYS5zwwzuV0+8fLnyORSK8TSUGLh
         yOJKk+3mJ/Q/RXngeDozsWj2FTJvWhTPxhgVJNfw0OCswIuQz8QDgWD90kKZMRgdgiWT
         VZ4esSClPtE3PGUxLRNtM+gjvJMcUHlhZkqvD71jD9pFuGwjNnWQW4Hm8onU3JDW3iDB
         2DSiAtt0tacPm5ZbtcBEFJpq8riON08+OMBg292f3vTM8YM8KarrFtRSwwecGUh2qi8l
         7FnQAY8p6UlaaaJG3RV9whYQ32HKdD2haawg9lRuucyWHR1ozye7Nsu9UjW1AARCyS28
         jA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736634859; x=1737239659;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KO5Nh/wm6Ek4qtIcencBavl3r9HWIoiPqvgOtXk6wLY=;
        b=mWMsEfe/z8INilJ/yLzOPFrWecsw8xOxhgZst9Da57TGEqxE9XaxV+QZWZfZ475qy5
         pWAGohTe1IWCr+n+XZrYySR5AVlHtr33ZBzbLGxUZaV4BTLfP4EXhNOOckovIIPGI7/R
         PnZccWkmJlMMGok5BqhY7hkM1Shx8nVEPck165XuDvWIhvLYH9gWcRN2fL8qXbxarUG2
         q8c7hC90XNSCl3Ai1p6cTGY+bovja7YOUO/8q9dzat8Ef53CNfqNqa+WsAUbtUUBEY48
         u2U0QTW4LQRsbUYs3XEo64AeUpIRiICAE+1CwysfMZCkVC+p3iwqDC/J5hlDAHoEokR3
         rV2A==
X-Forwarded-Encrypted: i=1; AJvYcCUFifLog0Ues9gAZTaFaX9u5ZvUklGYYEj1qY9BSOIEdY3fodc/mMRYEmtStCjrhoM17L1ZP48UkPL3@vger.kernel.org, AJvYcCWnEVy7on14RclQvhh7YgGhsYvCbwGL7ITWivqqfaYiYTinu3bRsAjx1ISZKfiDt3LsfsCgQSZR8+vk@vger.kernel.org, AJvYcCXEIZ3N3kmhoyws2McKlvOTkF3ubBGf3umgnv0N5FgFRWnfjJ8ZZ+DORxymUl9FCFIqweyZxscT1yNxaYIB@vger.kernel.org
X-Gm-Message-State: AOJu0YwpPU2Qo5U18ybg55qDhrr+uxk4nXu37nF/nHJxvsGPhUGRPEOH
	TIiie+PuJlFBORqCy88yYaARDIPrPMxtLz52A243T1+AlXu2vmFC
X-Gm-Gg: ASbGnctwbNYR4dZZdHINfqXd8uOh7LligcImdvB1PZGoG6L3A31UPmQKvRLo3FyKH8J
	meZXyz/0L0P2i19FA839UO5mv2Qc+vYgycpKq7LFVMeMvQFAfS+k4Hui2fpCYSgN2s9xJmju7Q9
	JfOFahYF3PivLNbs87JpxytT+Iot5wx5g7Long8RV5MgbYZsZeJ8LYAEKId8H2K89ehcgoBq3h0
	H9BT2fgLwJf1GOq+8AvPYjjh+NtuJLFIM15/l7dv7/58knpK50nTcdAPf98Rzsqwkrtmyc5HGNY
	gQ==
X-Google-Smtp-Source: AGHT+IEUpPVdVZXBXMBEhfzBxlqZ+DN5TmixP2mTWjoecPSJshPgfQGFdMg4wAuFO7wqJLEKLCcOBw==
X-Received: by 2002:a05:6830:6206:b0:71f:c1df:7b5 with SMTP id 46e09a7af769-721e2f2cbbbmr3987101a34.7.1736634859033;
        Sat, 11 Jan 2025 14:34:19 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-723185484d5sm2054456a34.26.2025.01.11.14.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 14:34:18 -0800 (PST)
Date: Sat, 11 Jan 2025 19:34:14 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 01/15] dt-bindings: iio: adc: ad7768-1: add
 synchronization over SPI property
Message-ID: <Z4Lx5myE2OPDie6n@JSANTO12-L01.ad.analog.com>
Reply-To: dc7f6461-6fce-4dbd-9be4-f7814053e7dc@baylibre.com
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <bde43579b41199f0c17f07dfacefcb137028e66e.1736201898.git.Jonathan.Santos@analog.com>
 <dc7f6461-6fce-4dbd-9be4-f7814053e7dc@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc7f6461-6fce-4dbd-9be4-f7814053e7dc@baylibre.com>

On 01/07, David Lechner wrote:
> On 1/7/25 9:24 AM, Jonathan Santos wrote:
> > Add adi,sync-in-spi property to enable synchronization over SPI.
> > This should be used in the case when the GPIO cannot provide a
> > pulse synchronous with the base MCLK signal.
> > 
> > User can choose between SPI, GPIO synchronization or neither of them,
> > but only if a external pulse can be provided, for example, by another
> > device in a multidevice setup.
> > 
> 
> While we are fixing up these bindings, we could add some more trivial things,
> like power supplies.
> 
> Also, the interrupt property could use a description since the chip has multiple
> output pins. I assume it means the /DRDY pin?
> 

Right! Yes, the interrupt pin refers to the /DRDY.

> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> >  .../bindings/iio/adc/adi,ad7768-1.yaml        | 24 ++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > index 3ce59d4d065f..55cec27bfe60 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > @@ -47,6 +47,15 @@ properties:
> >        in any way, for example if the filter decimation rate changes.
> >        As the line is active low, it should be marked GPIO_ACTIVE_LOW.
> >  
> > +  adi,sync-in-spi:
> 
> If this is saying that SYNC_OUT is connected to SYNC_IN, then I think the name
> should be something like adi,sync-in-sync-out. SPI seems irrelevant here since
> we should just be describing how things are wired up, not how it is being used.
> 
> But if we also need to consider the case where SYNC_OUT of one chip is connected
> to SYNC_IN of another chip, we might want to consider using trigger-source
> bindings instead (recently standardized in dtschema).
> 

Do you mean the trigger-sources used for LEDs? I can try to see if it works, but would it
handle the non-GPIO case? While testing a multidevice setup, I found it simpler to 
have a single device to manage everything. It lets us toggle the GPIO or /SYNC_OUT
without referencing another device and makes simultaneous buffered reads easier.

Maybe we could stick to synchronization within the chip for now.

> > +    description:
> > +      Enables synchronization of multiple devices over SPI. This property is
> > +      used when a signal synchronous to the base MCLK signal cannot be provided
> > +      via GPIO. It requires the SYNC_OUT pin to be connected to the SYNC_IN pin
> > +      on the ADC. In the case of multiple devices, the SYNC_OUT pin of one device
> > +      should be routed to the SYNC_IN pins of the other devices.
> > +    type: boolean
> > +
> >    reset-gpios:
> >      maxItems: 1
> >  
> > @@ -65,7 +74,6 @@ required:
> >    - vref-supply
> >    - spi-cpol
> >    - spi-cpha
> > -  - adi,sync-in-gpios
> >  
> >  patternProperties:
> >    "^channel@([0-9]|1[0-5])$":
> > @@ -89,6 +97,20 @@ patternProperties:
> >  allOf:
> >    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> >  
> > +  # adi,sync-in-gpios and adi,sync-in-spi are mutually exclusive (neither is also valid)
> > +  - if:
> > +      required:
> > +        - adi,sync-in-gpios
> > +    then:
> > +      properties:
> > +        adi,sync-in-spi: false
> > +  - if:
> > +      required:
> > +        - adi,sync-in-spi
> > +    then:
> > +      properties:
> > +        adi,sync-in-gpios: false
> 
> I think this can be simplified to using oneOf: to provide XOR validation
> 

Right!

> > +
> >  unevaluatedProperties: false
> >  
> >  examples:
> 

