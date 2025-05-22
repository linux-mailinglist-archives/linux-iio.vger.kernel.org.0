Return-Path: <linux-iio+bounces-19806-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9577AC0F69
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 17:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE6BA22CE4
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 15:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038C728C86F;
	Thu, 22 May 2025 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMpC8U7w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371D835977;
	Thu, 22 May 2025 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747926375; cv=none; b=X3j4SsrCwsy58R18XFHJRm7/1VIVb0XMNjTdtLeo4XfOVQ41f4GPjqGDdFTw0d3eJbnAXp/DwTkBENlpaFJaIHD0/lu2eX6YMnwhksiglrYXN5uqU78K6p9a2Ylm5nEUkKJoxJRSfJMa96J3Muubv7hBAgAukiZOj6AM2kQji+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747926375; c=relaxed/simple;
	bh=JELcEZ/TME5qKjvZHCLNOg6aOGWhfNkmlW2l4alWeGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5af6MsjGu11r5QeYjkVT7rAVM8E6PRVxatvMvYOq7Y9EV+zY/Kcr90sly9hZtptBdz8WKKOoDdR0NTNk1VbChVSzfBnw9fH/0lLmoO2q6WAkT9f+fTXJPt2YBvQ88xLqaMO3sbrNbSRMkh+7rvMQHxAH8ZuE1DMFEALxj/izXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMpC8U7w; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-525b44b7720so2401361e0c.0;
        Thu, 22 May 2025 08:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747926373; x=1748531173; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MhO/6L47DHlWm2lUAbO+SfxVgyXO64vz/MUsE8Thqlk=;
        b=ZMpC8U7wT5wa2bNl4Hp+f9SrNgX6v8VBCenU7W7MfoghHvJBTnDiCVB+3by0ck5kn4
         H8/GcdwD7lTE/wnPk1PFxJ4cSzJ7BWnV1MZ2bDti8ZQVRaPfP1lH+NpnijNBs0qoSfRE
         A31VdrnivqgctxhVEJSgnY+IWMEtx6sud6t3Y6YJGsz1h9UvKzgqQLKpsBSEeOR72ZMU
         KpF8gvq319jCsvhrK7K/UsdUUjs6fj40f9JH+Guei/jA00j5gxWNfABHXr9CRQIAPqY6
         4P+6jbRA3YobNOfOYwl+Nd769VyXQ4VNNfVb6Fl2CqFc8mS7+lIrASjBAHGw0/S0cYES
         mKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747926373; x=1748531173;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhO/6L47DHlWm2lUAbO+SfxVgyXO64vz/MUsE8Thqlk=;
        b=cMoKJqCJHxh9qIlrCgMBL2XQNWqIrKwID+NMCYm6TsFvHYzPOvbuNqdCgq2EhZK5+v
         50j/SJ6ryCJXrf460MB5yXZTEhE8KO/piQxSAmFvhN33ivw2jHZB57QQRJmGcDjzBDJE
         p6oZzn3aZJSoeV25CH41/vF9jJmH9o/m/yRxg/UYitJghrQnKleXOIqPqfnqyFZRJbAs
         m3oCQlovLZOgv01SeJSCX/ipNKbNC1ohtMICBW3NAZPondyny43m1A8KoRt2mb0zm3Kt
         64fZ/sbixst4CA/pCKuVJV3SkWLjenGm8d/lZaozuy79HQIPLJ99n+wNCYVJ4QVH5rai
         /ZfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwSi+jUamO0yEmJmJuDo7iQ6UCBjANf0123HKX7Yxk1mz5Dr3Q3p2ImyAj1gq0YZLRkjc5iAX2O+r+@vger.kernel.org, AJvYcCWVrgBPNwx5j69nA1k6aWwokIowByk7yyaHXpZaV8lEZ7L0f8uL71Uzqroi9XisexlWigyTMHemxKlzF74z@vger.kernel.org, AJvYcCXZ+7126Ub0W5+lZiYV7v4DqQn3qIvqL+0mkgT0Af/OZnat0QhLqXP8Fag5FRgHIjSuDvfYXkHSFjQ0@vger.kernel.org, AJvYcCXhU6t5HKvW7S5xtIlDaR3YdyZ5UQMFDN/MXL6Xe7/zG6Sf1vHbzuFqD11nBN9Wsi8q/VoroaMTwj/iwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy90yhmNlLcklUDP1FWN2Gre455O4+hRnu0dtxlkGmS/zn6Mw4L
	wSgIBB3FyjVVn/eP09AeSFyPYrjyKjehlDLraAo2HTPFerEj9T5xvKN5
X-Gm-Gg: ASbGnctQVhDgQwPJJH+xFpRRp5b6SXY1g355dtWKMy118o0mW9DZ5DRRwIqb4YNlXSx
	4vxP4+o3SMqheGRdh53MyWA8lHPERbDXQdRJu5HGaeD3wZ3dCfjypcdDjmLDH0jB1QWBTZRkgW8
	S5f4ng2Gli4a3s9gKIOdztG0NirR5vbogitKP/OmIpU0XNPL0xFB3T8Jg/Da9NlpSEtFxKkd+HP
	/zijljVFCDutHRQ2EraSmqrJDukFFl0zo7FpDMZIA0T56Y2f66tC2thJ6APJBjEmrV7cVozDFIO
	7emJ0W8/fCLXOCionsD+2vmMdpi1RKGdBPT6knxRoJhSiWYLPCcnWZHkbxil
X-Google-Smtp-Source: AGHT+IGVSYQaIrfc6pltnx1rK27FglZF+ks/le0K2Fg4I+5tBWSoi/sZ5ic22CKtQlDD8kJDWEJXRg==
X-Received: by 2002:a05:6122:4b86:b0:526:1ddd:7603 with SMTP id 71dfb90a1353d-52dbcad485dmr19053355e0c.0.1747926372853;
        Thu, 22 May 2025 08:06:12 -0700 (PDT)
Received: from localhost ([2804:30c:1623:d000:b599:2ab9:58bc:e4e3])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-52dba9408f5sm11914596e0c.15.2025.05.22.08.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 08:06:11 -0700 (PDT)
Date: Thu, 22 May 2025 12:07:41 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl
Subject: Re: [PATCH v3 01/10] dt-bindings: iio: adc: Add AD4170
Message-ID: <aC89ve8FgIK4gej4@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
 <5fa867cff437c0c6d3f0122af823e1677a12d189.1747083143.git.marcelo.schmitt@analog.com>
 <20250521-colorful-paper-coot-ce9ffb@kuoka>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521-colorful-paper-coot-ce9ffb@kuoka>

...
> 
> > +  sensor-node:
> > +    type: object
> > +    $ref: '#/$defs/ad4170-channel'
> 
> I do not understand this binding. channel@ node is a channel and sensors
> like rtd@ is also channel but also sensor. What is the point of channel@
> which is not a sensor?
> 
The sensor node is meant to describe a channel that has extra setup
configuration. For example, a common ADC channel could look like this

  -------- +VREF ------         +-------------------+
    ´ `       ´ `              /                    |
  /     \   /     \   /   --- <  IN+                |
         `-´       `-´         |                    |
  -------- -VREF ------        |                    |
                               |            ADC     |
  -------- +VREF ------        |                    |
        ´ `       ´ `          |                    |
  \   /     \   /     \   --- <  IN-                |
   `-´       `-´               \       +VREF  -VREF |
  -------- -VREF ------         +-------------------+
                                         ^       ^
                                         |       +---- External -VREF
                                  External +VREF

The the channel@ node for that would look like
    adc@0 {
        ...
        channel@0 {
            reg = <0>;
            bipolar;
            diff-channels = <0 1>;
        };
    };

Though, some sigma-delta ADCs (including AD4170) are fancy and have features
that relate to what is connected to the ADC inputs. For example, an RTD would
be connected like

                                     External +VREF
                                          |
       +----------------------------------|-------+---- External -VREF
       |           +----------------------+       |
       +---Rref----+                +-----v-------v----+
       |           |               /    REFIN+  REFIN- |
   +---+-----------|------------> <  IN+               |
   |               |              |                    |
3-wire RTD         |              |            ADC     |
   |               |              |                    |
   +--------------------+-------> <  IN-               |
   |               |    |          \      GPIO2 GPIO3  |
   v               |    |           +-------v-----v----+
  GND              |    +-------------------+     |
                   |       <--- IOUT1             |
                   +------------------------------+
                           <--- IOUT0

A better drawing can be found in AD4170 datasheet Figure 115. 3-Wire RTD Application.
https://www.analog.com/media/en/technical-documentation/data-sheets/ad4170-4.pdf#unique_151_Connect_42_ID10430

Since the RTD sensor requires additional hardware connections, the proposed
dt-binding describes those differently, e.g. 

    adc@0 {
        ...
        rtd@0 {
            reg = <0>;
            bipolar;
            diff-channels = <0 1>;
            adi,sensor-type = /bits/ 8 <1>;
            adi,reference-select = <0>;
            adi,excitation-pins = <19 20>;
            adi,excitation-current-microamp = <500>;
        };

That allows the ADC chip to be configured to provide the excitation signals to
properly handle the RTD sensor. Because the hardware connections and
operation requirements vary among those external sensor types (RTDs,
thermocouples, load cell weigh scales), some properties are only applicable to
specific sensor types. Also, because those are extra connections, the related
properties are not meaningful to typical ADC channels.

Though, the supported features are not different from those described in
Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml.
In that binding, the properties related to external sensor support are set
on the device node (not related to any channel). The binding proposed on AD4170
RFC patch was more similar to adi,ad4130.yaml and somehow avoiding to introduce
custom/new properties, but that lead to a lot of duplication.

The currently proposed dt-binding for ad4170 avoids repetition and, to some
degree, tries to provide better description of connected bridge sensors and
their related properties as that seemed to be one of Jonathan's suggestions
to the RFC version.
https://lore.kernel.org/linux-iio/20241219140353.787ffccc@jic23-huawei/

Even though I'm naturally biased in favor of my own code, I see this is fairly
different from bindings describing the exact same features and that can lead
to confusion. I'll use the same types for properties that describe the same
things/features. Would it also be preferred to drop the defs and just have 
channel nodes?

Thanks,
Marcelo

