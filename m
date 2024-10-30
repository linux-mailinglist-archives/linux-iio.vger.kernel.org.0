Return-Path: <linux-iio+bounces-11593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9999B5D20
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 08:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67AC62845B0
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 07:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0976A1E009D;
	Wed, 30 Oct 2024 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJc0+u+d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A530C54BD4;
	Wed, 30 Oct 2024 07:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730274145; cv=none; b=Zvc5Z30WYK5kPD5qAFCY05QkUuP5SUXJYHEhDl2t/TfX0YhZnaEh++tWFkS9kiySi62Z8fCXEg1yjrocXVGxVxyNLZwJwRK8zEiDyJbbZ16YvuCvtkysB9t0o87klAGDO9IGRa5miKdih5j4tjho7Q+pYr6fi3AqYZKztF2vZGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730274145; c=relaxed/simple;
	bh=M8z5hdbn3Ka8QgQTdv5JIS7S/Ed/ldsVvtl6z5TvSpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abGDKtzaXqmIfiUrp+Llw+XiCXmoiC+V9lbcppWJHwAwI19GpZCCdveLufNPvT6KFAh9IN3eLo5JCdfPGdSs+SUiNfw83eBIZSIQD5efc2T2/53O+OglqgX8UpvJxlYVY/HZE0sjA49cIXOyNVRGpWLdW1E6vaDE+YNXSH0iDXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJc0+u+d; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so899321966b.0;
        Wed, 30 Oct 2024 00:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730274142; x=1730878942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4EebOx+/e8mI1SCUD1S2Qk0Ovrk0A6p43GTOE5dek2s=;
        b=dJc0+u+dXdz/KxYDtl6hWv2Y2lYSKcE86r2POVQkWEzNAdLjXAoZKvGiwv/m/nLi/S
         8YinF2cBMDgxllBtsweKI79PgNEPVyW15nYSI7UoXU2/5vKZZIzzxleUnyWsd8YOLvrr
         U+7yWYmqGDHkkKIJEwae6O4Z3VZZTPtCcFeiRBLGJG4P248F4fei/GDFdYH65j5LATmP
         HfYvnASGisGk09opTWFUpfoWxdvS9TDv/NMYJQnboFwh8EHnIyKdvHqdXqiExiAqbFyb
         WlL/oK7L4FopcKUiDEnoF88Yfk86HLNaPt74m1Xt7rFBtvbEGLBEmW2+R2foSHEOgzPc
         d+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730274142; x=1730878942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EebOx+/e8mI1SCUD1S2Qk0Ovrk0A6p43GTOE5dek2s=;
        b=VS0iZpZkre6ocuqmRYs9dG9SYVaeNlMbBpGq6U8p0oevYkFtEnNkOhv2/qeBooXOgE
         hlr4XVdJspDLCejw2WKf/ZXt02YmEoYaxHmn0G1vypBt9Du+Lwar7GvEuY0hkD4o92G5
         u1nwppungkWmWfCO+oy8i0AQ9cT3lCau6sud2bQcjE6VjPKOIr4cQ7fzpu5kshsmZuIW
         z4vizrfszX8Dl1/JFljmfdCwM+YYEkJR1kInXdDDONqno4YI137gQ4NDO1+NP590c5ND
         0Xyylpj4u8xYcoVjnXpsELWVlgjpZxLpnwgJ8vrXT2o4ZT/LigcrMA/CWP/4RF79maw+
         39ig==
X-Forwarded-Encrypted: i=1; AJvYcCUfCqV8edMhwil69NeJHgxIebMVIlMg4ybeQr10bMys2K4Q9E4ndla6LFzJusClfgjAYWx+RfU5qDI=@vger.kernel.org, AJvYcCUz/HQrwupzeFNJ/QirMv8bpl7rb6zahlUwsI0M3kB/6YKzwJivGYxUGYT3s+xu3kkHLKYDrKa/1h6Q@vger.kernel.org, AJvYcCVvlhXo4pUG6rgKTg6PEtiJZYhWGSjZ41kExlXETI1gtbzcu8p5gAI1PtMAONWqIB4Wy4XT18OaBZmH@vger.kernel.org, AJvYcCWaG6/tOME7CVjRziMU4q1tKIArIIy/nq986C7eUI+Psv7qNsXs93IZhhOT8YNrfMnvy9uhX7bz4V3n@vger.kernel.org, AJvYcCWd8Dvv9daYYL2jT0Q4ByEl8vYxkb9qs/IhZIC26YB4FJuSWCK0VqXGUyPcQNRMiclj/PnMs1Ammhy34vEO@vger.kernel.org, AJvYcCX5OxsJvOujhfzGSr6e0GgejQrHSZIaOZg7oHsYyH/+RSu0SrzQRXOX7NZX/DH1QUvhrXDfLvq5v8pmKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5CGGNZFZuyH+B3xKswzIjd9Ky3DmK3Z3Ew9Iyhs7/MutUM+48
	PeoZjn2ZtrAAqv8mLeVse2OeMjZsjhmh3Lmr7W17LYO2q93lO/3F
X-Google-Smtp-Source: AGHT+IH0KCi9ViE98z9rjG/9J5QoWfEcBypXV6u/kyAK2QOc1v3oArj8ECG/6I2AJnY/LtLid0mf1w==
X-Received: by 2002:a17:907:9715:b0:a9a:522a:eddd with SMTP id a640c23a62f3a-a9de5c91c2bmr1459786066b.11.1730274141676;
        Wed, 30 Oct 2024 00:42:21 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f0298e7sm546512966b.75.2024.10.30.00.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 00:42:21 -0700 (PDT)
Date: Wed, 30 Oct 2024 08:42:19 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mfd: sprd,sc2731: convert to YAML
Message-ID: <ZyHjW86v9Y59-TJQ@standask-GA-A55M-S2HP>
References: <ZyExK01iprBHhGm6@standask-GA-A55M-S2HP>
 <ki4wvjslncrngwpz7qukknzgdsjkxvrhitem7i5lof6ggyhu4e@tviovrd2wi77>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ki4wvjslncrngwpz7qukknzgdsjkxvrhitem7i5lof6ggyhu4e@tviovrd2wi77>

On Wed, Oct 30, 2024 at 07:43:04AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Oct 29, 2024 at 08:02:03PM +0100, Stanislav Jakubek wrote:
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> > +  interrupt-controller: true
> > +  spi-max-frequency: true
> 
> This means:
> 1. You forgot to ref spi-peripheral-props
> 2. This is not needed and use use unevaluatedProperties: false.

Ack, will reference spi-peripheral-props.

> 
> Just like all SPI devices.
> 
> Unless this is not SPI?

As far as I understand it, it kind of is SPI and kind of isn't.
See /schemas/spi/sprd,spi-adi.yaml.

> 
> 
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#interrupt-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +  regulators:
> > +    type: object
> > +    $ref: /schemas/regulator/sprd,sc2731-regulator.yaml#
> > +
> > +patternProperties:
> > +  "^adc@[0-9a-f]+$":
> > +    type: object
> > +    $ref: /schemas/iio/adc/sprd,sc2720-adc.yaml#
> > +
> > +  "^charger@[0-9a-f]+$":
> > +    type: object
> > +    $ref: /schemas/power/supply/sc2731-charger.yaml#
> > +
> > +  "^efuse@[0-9a-f]+$":
> > +    type: object
> > +    $ref: /schemas/nvmem/sprd,sc2731-efuse.yaml#
> 
> I don't think this was merged. You still have dependency.

This is in next-20241029, which this patch is based on.

> 
> Try yourself - apply this patch on the maintainers tree and test it.
> 
> You can solve it by listing here compatibles and additionalProperties:
> true (see Qcom mdss bindings)
> 
> 
> 
> > +
> > +  "^fuel-gauge@[0-9a-f]+$":
> > +    type: object
> > +    $ref: /schemas/power/supply/sc27xx-fg.yaml#
> > +
> > +  "^gpio@[0-9a-f]+$":
> > +    type: object
> > +    $ref: /schemas/gpio/sprd,gpio-eic.yaml#
> > +
> > +  "^led-controller@[0-9a-f]+$":
> > +    type: object
> > +    $ref: /schemas/leds/sprd,sc2731-bltc.yaml#
> > +
> > +  "^rtc@[0-9a-f]+$":
> > +    type: object
> > +    $ref: /schemas/rtc/sprd,sc2731-rtc.yaml#
> > +
> > +  "^vibrator@[0-9a-f]+$":
> > +    type: object
> > +    $ref: /schemas/input/sprd,sc27xx-vibrator.yaml#
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-controller
> > +  - spi-max-frequency
> > +  - '#address-cells'
> 
> Keep consistent quotes, either ' or ".

Ack.

Thanks for the review,
Stanislav

> 
> > +  - '#interrupt-cells'
> > +  - '#size-cells'
> 
> Best regards,
> Krzysztof
> 

