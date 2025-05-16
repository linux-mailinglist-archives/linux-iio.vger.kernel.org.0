Return-Path: <linux-iio+bounces-19599-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B813ABA027
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 17:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92914A04295
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 15:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4611C1C5D4E;
	Fri, 16 May 2025 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5Hi6IPW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BCB1B4F09;
	Fri, 16 May 2025 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410223; cv=none; b=XyZak3PmhFnVqKpA8NIC1jb7IP51I6Vv5l/tU4vwa2BPdECOT4usmUXtNdiRSS7O1rtbGAU+rllj0WOvsneIwqv5GNrW19BjieWiXq0Kh2RnyJFNcjdJDX4eWEEmldxBfvVd3fC6piY3+/tjodN686VU9A5zklwEUyv0GwTKwt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410223; c=relaxed/simple;
	bh=JdE1zOENuVbx36wBTnd2zRX98IwRHuPeDvGz6NXdT70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYG/bRXEk7s7yTmdAvC/eQJZLxuQD3n/BglqKBk0nMhdfZrdYspayyfTIr4FXJuqjNB29peCMncGWKBPli11JtaiRi73zrOPD3D0KxTYxQuGxWf5YFziPSimamhKzXYhd/l1EY/Qv0e8G7SCjG0bmr0vYHfJxGvOX6ZTDZiObfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5Hi6IPW; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86dc3482b3dso2205716241.0;
        Fri, 16 May 2025 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747410220; x=1748015020; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wjNmcOXLLQSabYEk9is/iDidcy39077ZDWkUH1PgLhI=;
        b=l5Hi6IPW6CiB9lpBsSy5LnXUb+gDnHBbwDaJyn8zGx9wOBTwBrqP2LVyEX9qXvmA1R
         HmKuak60HFcfXIZbh5FrQXxvsFuMaUU9BXAAtfZUnhGT7orLSoIDQyCv1BiDsWSNXcwz
         teMfmYyMIc32xCM3DiMnNp4LkcaBut9y+TQdmFNh/6YZqUAQI1Pha71cDsm/hlKsAk6t
         Hueb/0bpWzlkPgzAQBmop2H+H4f9KRXChmWQomXIOKSjovyWSEeREreK9rOv1GzpH5vv
         G9RpckkRIB6vYYD+jsPvwqOmADlxfjQqqBD0/ht91q7Rh2aLANQfoa+KYiss24dqPTQi
         oB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747410220; x=1748015020;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wjNmcOXLLQSabYEk9is/iDidcy39077ZDWkUH1PgLhI=;
        b=nKTb/HUjuQ/Jql2tzs/SAgQywn9l+ggk1l9CdBHz3frFnzeUTGmMC9c/uOvH0dPkwh
         lZv87xsFT8hDvaia/+hgsFYRatw0YRCE4Ha/qGNidXdRi9QtrkpgTvjWf11wlqy96/O+
         Y6JKJsqOBAsLEdRT2SlHfd6Vc+QSfhwwk6WTN5WAANJ4vNdfKkdGN2VEAqgE3z3vfsvu
         me1ocDcm8BQwCt9LJ2aHj1TiHqWEBVXabEsAU8hm9EBfDCTvmIKuYz2Kp1OzzBbQkk+E
         tcbbLlXY1NSlThRESWvVZL7jGLJgCU4YAFETucdnDVVXeM6+VIxHkpmLDuA1rzBeDq5T
         8/9w==
X-Forwarded-Encrypted: i=1; AJvYcCU+4V12OUPhc2sPD26MnpMF/tbLdEqMvaryuXJxP02KdLrG6wK4/IYNeP1HiM8ebQDFZiylIyr9zq7G@vger.kernel.org, AJvYcCWKhq5HiQUBQNFAcBMmJKraP3bEBzMHm36uL2T9V5ftNyUUsmGFRed23dRnMwxxGBiKfEcwCp3laaY9aw==@vger.kernel.org, AJvYcCX29B+he6tacCIUvUmMrVNu2BD1gPHKYYqSqn/0jwb9MLj9urkmdqPXZPDRaR4bEbKyTtNqiMmLzc9C0xVX@vger.kernel.org, AJvYcCXdSazYyECbPZFUqf9PKxwLHJ+S0dPo17+wX+tzBMhatcSoGS7Qfra74KwGK/iWdpkNU7UZZSqs39pe@vger.kernel.org
X-Gm-Message-State: AOJu0YzXeG/sbLmdLHUXWOTfaiSO84blOLXLocQnRVCDb38AfYG25ghs
	RUOr5tphy8hFj/KwBvUtblXZ3Tqkr72vnzsqEF15+PUbwOEZ8qucaCYj37lgD3vuRYo=
X-Gm-Gg: ASbGnct38EqnhERQ3sLFwZuw5QchyoPgp0Vq8OHkDvLol6ZwZeBzv/nQTpIoSZJi8DW
	yC9dkMXrh++i8t0L+A8MS39MSJ94GF5XTIJOciOzVGXXQfaLFtxguKzGhFOPVH7iDv0JqzCT/OP
	BkBKtYuH6d5tdqwmzwjaR44j06S9YsL38GC/YqvrErZZeNNZOYjT0q60HIdpVZzK5CipQsXsn/C
	Hf98eMptDw4szwWd0Da5ZtH0C2+XRYB48QyhnCIJXLc6NDm0m/+4grpNMRwOTILdN/PJ/loH682
	GdMng3IR2FnGh90lxazHcUSrHm2wQjEURGIkIwodO84LERwbcQZXB0phXOPI
X-Google-Smtp-Source: AGHT+IHvG4FVQp4e/eKHXTxDq3Vg3QnZP1emTn7spybnjDSiEjB5GDXmM4vdwyTK0anMEzFD4tfLog==
X-Received: by 2002:a05:6122:2c2f:b0:52d:bcd1:ab55 with SMTP id 71dfb90a1353d-52dbcd1aba9mr2892034e0c.2.1747410219998;
        Fri, 16 May 2025 08:43:39 -0700 (PDT)
Received: from localhost ([2804:30c:1623:d000:b599:2ab9:58bc:e4e3])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-52dba94090dsm2053529e0c.16.2025.05.16.08.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 08:43:38 -0700 (PDT)
Date: Fri, 16 May 2025 12:45:05 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linus.walleij@linaro.org, brgl@bgdev.pl
Subject: Re: [PATCH v3 01/10] dt-bindings: iio: adc: Add AD4170
Message-ID: <aCddgYRWrLPlGeuR@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
 <5fa867cff437c0c6d3f0122af823e1677a12d189.1747083143.git.marcelo.schmitt@analog.com>
 <2ab9a6e2-a331-4995-8d42-00290bc825e7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ab9a6e2-a331-4995-8d42-00290bc825e7@baylibre.com>

...
> > +
> > +    properties:
> > +      adi,reference-select:
> > +        description: |
> > +          Selects the reference source to use when converting on the specific
> > +          channel. Valid values are:
> > +          0: Differential reference voltage REFIN+ - REFIN−.
> > +          1: Differential reference voltage REFIN2+ - REFIN2−.
> > +          2: Internal 2.5V referece (REFOUT) relative to AVSS.
> > +          3: Analog supply voltage (AVDD) relative AVSS.
> > +        $ref: /schemas/types.yaml#/definitions/uint8
> > +        enum: [0, 1, 2, 3]
> Using strings instead of int for this and most of the other custom enums here
> would make them self-documenting and easier to use.

The numbers match the values that are documented in the datasheet for each
option of voltage reference available to use with a channel. So we would be
using numbers mostly to define values of some unit and pin numbers (e.g. 100 for
the microamp property)? Not really excited about doing this change because I
think it will make the dtb a bit larger and the driver code a bit more lengthy,
but can do that for v4.

...
> > +      adi,sensor-type:
> > +        description: |
> > +          Type of sensor connected to the device. Depending on the sensor type
> > +          (weigh scale, RTD, or thermocouple) the values of sensor-node
> > +          properties have slightly different constraints. This property
> > +          specifies which particular external sensor is connected to the ADC so
> > +          the sensor-node properties can be properly parsed and verified. The
> > +          possible sensor types are:
> > +          0: weigh scale;
> > +          1: RTD;
> > +          2: thermocouple.
> > +        $ref: /schemas/types.yaml#/definitions/uint8
> This property seems reduandant since it has to match the node name.
> 
> i.e. weighscale@... is is always adi,sensor-type = <0>; and so on.

Yes, can we rely on node names I'll do that for v4.

...
> > +
> > +      adi,power-down-switch-pin:
> > +        description:
> > +          Number of the GPIO used as power-down switch for the bridge circuit.
> > +        $ref: /schemas/types.yaml#/definitions/uint8
> > +        enum: [0, 1]
> This isn't required, so what is the default if omitted?

We don't care about it when the property is omitted.
Do we need a default even when the property is not required and we don't care
when it's not set?

...
> > +      diff-channels:
> > +        description: |
> > +          This property is used for defining the inputs of a differential
> > +          voltage channel. The first value is the positive input and the second
> > +          value is the negative input of the channel.
> > +
> > +          Besides the analog input pins AIN0 to AIN8, there are special inputs
> > +          that can be selected with the following values:
> > +          17: Internal temperature sensor
> > +          18: (AVDD-AVSS)/5
> > +          19: (IOVDD-DGND)/5
> > +          20: DAC output
> > +          21: ALDO
> > +          22: DLDO
> > +          23: AVSS
> > +          24: DGND
> > +          25: REFIN+
> > +          26: REFIN-
> > +          27: REFIN2+
> > +          28: REFIN2-
> > +          29: REFOUT
> > +          For the internal temperature sensor, use the input number for both
> > +          inputs (i.e. diff-channels = <17 17>).
> > +        items:
> > +          enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 17, 18, 19, 20, 21, 22, 23, 24, 25,
> > +                 26, 27, 28, 29]
> 
> A Header file with macros for these would be nice since it seems like we
> have to use the higher-numbered ones a lot with the common-mode-channel
> properties in the examples.

The RFC set had a header with macros for those numbers, but making dt properties
"look nice" was said to no be a reason to have binding headers. 

https://lore.kernel.org/linux-iio/ikq55kcfu2lmxzeeobu4zwf67xypyikadnpycw2m4d7o6gvmi2@tkepvcvzqzoh/

Also, no other binding would use those values. So, we would have a header
specific for adi,ad4170?

> 
> > +
> > +      single-channel: true
> > +
> > +      common-mode-channel: true
> > +
> > +      bipolar: true
> > +
> > +      adi,buffered-positive:
> > +        description: |
> > +          Enable precharge buffer, full buffer, or skip reference buffering of
> > +          the positive voltage reference. Because the output impedance of the
> > +          source driving the voltage reference inputs may be dynamic, RC
> > +          combinations of those inputs can cause DC gain errors if the reference
> > +          inputs go unbuffered into the ADC. Enable reference buffering if the
> > +          provided reference source has dynamic high impedance output. Note the
> > +          absolute voltage allowed on positive reference inputs (REFIN+,
> > +          REFIN2+) is from AVSS − 50 mV to AVDD + 50 mV when the reference
> > +          buffers are disabled but narrows to AVSS to AVDD when reference
> > +          buffering is enabled or in precharge mode.
> > +          0: Reference precharge buffer.
> > +          1: Full Buffer.
> > +          2: Bypass reference buffers (buffering disabled).
> > +        $ref: /schemas/types.yaml#/definitions/uint8
> > +        enum: [0, 1, 2]
> > +        default: 1
> > +
> > +      adi,buffered-negative:
> > +        description: |
> > +          Enable precharge buffer, full buffer, or skip reference buffering of
> > +          the negative voltage reference. Because the output impedance of the
> > +          source driving the voltage reference inputs may be dynamic, RC
> > +          combinations of those inputs can cause DC gain errors if the reference
> > +          inputs go unbuffered into the ADC. Enable reference buffering if the
> > +          provided reference source has dynamic high impedance output. Note the
> > +          absolute voltage allowed on negative reference inputs (REFIN-,
> > +          REFIN2-) is from AVSS − 50 mV to AVDD + 50 mV when the reference
> > +          buffers are disabled but narrows to AVSS to AVDD when reference
> > +          buffering is enabled or in precharge mode.
> > +          0: Reference precharge buffer.
> > +          1: Full Buffer.
> > +          2: Bypass reference buffers (buffering disabled).
> > +        $ref: /schemas/types.yaml#/definitions/uint8
> > +        enum: [0, 1, 2]
> > +        default: 1
> Could make a $def for these too to reduce duplication.

I think so, but how? They are only documented here. I can merge them into a
single adi,buffered property. That will also reduce duplication.

> 
> Also another case where string type would make more sense.
> 
> > +
> > +    required:
> > +      - reg
> 
> reg is already required by adc.yaml
> 
> > +
> > +    oneOf:
> > +      - required: [single-channel]
> 
> Is there a default for common-mode-channel if it isn't required in this case?

It should be required. Will make common-mode-channel required in this case. 


Thanks,
Marcelo

