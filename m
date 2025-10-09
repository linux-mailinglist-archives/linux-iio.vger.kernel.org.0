Return-Path: <linux-iio+bounces-24888-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7ABBCB012
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 00:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F46E425746
	for <lists+linux-iio@lfdr.de>; Thu,  9 Oct 2025 22:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65B7283FD4;
	Thu,  9 Oct 2025 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jj5cjvUP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7AB225791
	for <linux-iio@vger.kernel.org>; Thu,  9 Oct 2025 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760047295; cv=none; b=RJoHbPk+laMCA3IlJeDFMEhSnBiuI8OQP3z1o5MvPnMv46YDhEW8mQPnGACIcVaJOUXakJdSwknxADSHYisYLh95p0KVovDe1/xNjSX1AcahpFgxkybr8dRWNhEp/BjTNnekgS/R6GBU8nSj2fSjZuLMNM9SMREsbW7YyKa4AvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760047295; c=relaxed/simple;
	bh=MvovQ2CZf7lZ5aK0Hw+3F1huuAcGmwy9QQE0CmWBCP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlZEmxjagUkikH4gQyKKGjrkS0sb+zAv1dIGsjwqQT85NLuLYwTntUGxbo1GJnoBLxGuuUUGc3mUkUbCtO4Un5PQqVXL+Q0/SQPuNPrKGD/5PFtW8mgpu2pCuoomI/LA3t31eRoDk2eXfWolc4qfxDlUo77f9slBIrRtAkQ9qAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jj5cjvUP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-28832ad6f64so16487545ad.1
        for <linux-iio@vger.kernel.org>; Thu, 09 Oct 2025 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760047293; x=1760652093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ubabA3xLcERhUMalMqnUfMw3y+TLyOaAiUf3iO6bq8Y=;
        b=Jj5cjvUPyfAoNL3J8Js7Ik3znJz5K1AtIIREP6dCabCmGXVEfw7bTw2/fElmG9H5l/
         lFKH45HTsJAN5qxeMorrJttxdyDKeowJxfh6ysvkXXNEbcZJFWzcEx3lu+gT2Un6KR8o
         u1WWvcCgd3Ef9lE2bySDhAWq/bnYfXM654AZKoNSNKLLB1WHtepVDYGnG1qdpx4KBoNj
         jkSoAowRCnAZif0MhLYtP/9SIluj76u0uVn0UK1AQsIDuVzD71c5kzLTBNQTcjY70B9r
         TUDS/AueCN+z1o7lMpYAiP3qM5PyHmO6bqeS2z+df7arA7eMwxTgBJvJczbS6kYNOoFA
         Nikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760047293; x=1760652093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubabA3xLcERhUMalMqnUfMw3y+TLyOaAiUf3iO6bq8Y=;
        b=oBDghXr4+1kKbFdUPe+GKrTrOkEDkFMUAHd+cP0AUTPdpRXYoWQg6cL4OeL9hCVn8m
         rmB76LmwaxI/9wX0YzRx6fPQa86j7LPLu2nBehOfQVmOqvAJV/33L8eMCe5MD/bkZAYP
         jyFnsBF/nT3OdSU7ReL5SL37FkOzVLHkTueDd7351B43o/J8tJBtzZQs3vTsEgH2Lx5c
         XAw8GzHR5yfMnlPlbXzEq1EzfwJwLbnDQyJDqpU4kHdhpBamHA2J+egMX0C2eUrOAnba
         AftrD4bTFGvdo/V1CXs5DDDMmLFicecNqxxxNmwO5sWd+3aOen1wXuax3+CLFVVnJ1Nn
         72xw==
X-Forwarded-Encrypted: i=1; AJvYcCWUV3nE5eBQCdw6v26ixeS4jg4Aox+IK7GrPD8LQX5L2HiqO5/sHt9BpFbSwlGWGqQz3Bz7KmYKQN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGyheCfYSxSit8imZ0iXDd1cywMrKYtELmTg3o9buDuXZrWuqp
	D7ycNKg7U6+sUIrIoLKmz5yLz6cvKrkMwAco1SEZnlaMuFgOtWInjaCe
X-Gm-Gg: ASbGncs3kRptZN1P3NliLskZrRxr0Vodf07Wie2FNYHmEjUAWOT+cgD7Y2OxgzfxXYf
	a8oNDOqTchxi/WqNPl8/iOJfBCtCVCb7VuKfMAnAx/UW+3Espx9YGs6XlohgINEntUDmTtrhu13
	WGkE40AIaG9E6XMh/iwEqGoJOaFddqLo+48IpyIPfMVunUrFtl85n8BsncXnWGJW3JdFbGO4qpD
	LNaOBZdITsz6PhznKUu1e20pP8lYPWT8Dm7sUCXW03X75izZh91telFcbFvklkbtT+KFmO4ti+L
	oubJDs9gvtTxDQo+xYblx8/aJHOyUu67QQlNwGek2/jLqazoyXok3nqOPC0e45rmLQ+ny9oXfa4
	41qMmXsjMB0bSe6XWGyatD9OPnajpXWkUxWCGTPVP28QywVqmZJ8gQzeD6aX8/xxqHw==
X-Google-Smtp-Source: AGHT+IFiwrkXymykwZ3hVNOaThAi1ayt2BMjy61kTS/daz3gz7dkmJAAWVsfMj9rSf6GmAkBMMmekQ==
X-Received: by 2002:a17:902:ce02:b0:25c:d4b6:f111 with SMTP id d9443c01a7336-290272e4666mr119076335ad.47.1760047292794;
        Thu, 09 Oct 2025 15:01:32 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33b61a1d3dbsm937614a91.4.2025.10.09.15.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 15:01:31 -0700 (PDT)
Date: Thu, 9 Oct 2025 19:02:31 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, ukleinek@kernel.org,
	michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH v4 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224
Message-ID: <aOgw95ebGWWhahUx@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
 <7e51e036ba930284c74cf42afd53b17d49093654.1759929814.git.marcelo.schmitt@analog.com>
 <20251008-swooned-closable-fbc8b71601c0@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008-swooned-closable-fbc8b71601c0@spud>

On 10/08, Conor Dooley wrote:
> On Wed, Oct 08, 2025 at 10:51:37AM -0300, Marcelo Schmitt wrote:
> > ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices have a
> > PGA (programmable gain amplifier) that scales the input signal prior to it
> > reaching the ADC inputs. The PGA is controlled through a couple of pins (A0
> > and A1) that set one of four possible signal gain configurations.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > Change log v3 -> v4
> > - Now only documenting GPIO setup to control ADAQ PGA pins.
> > 
> > Pin strapped/hardwired connections to PGA pins may benefit from a "fixed-gpios"
> > driver which may (or may not?) use the shared GPIO abstraction layer [1]. I may
> > propose support for pin-strapped/hardwired connections when I get a working
> > fixed-gpios implementation.
> 
> What is a "fixed-gpio" as compared to a hog, from a dt point of view?
> Is it purely a software change?


Short answer:

I think "fixed-gpio" and gpio-hog would mean the same from dt point of view.
Yes, it's mainly related to software.


Long answer:

We would like to read the state of a pin from the GPIO client driver. Maybe we
are already able to read gpio-hog states from client drivers and just didn't
find out how.

The idea is to standardize and simplify the dt bindings when peripheral pins can
either be connected GPIOs or hard-wired to some logic level.

For the particular example of ADAQ4216, it can have PGA control pins connected
to GPIOs.

    +-------------+         +-------------+
    |     ADC     |         |     HOST    |
    |             |         |             |
    |   SPI lines |<=======>| SPI lines   |
    |             |         |             |
    |          A0 |<--------| GPIO_A      |
    |          A1 |<--------| GPIO_B      |
    +-------------+         +-------------+

But the pins might instead be hard-wired, like

    +-------------+         +-------------+
    |     ADC     |         |     HOST    |
    |             |         |             |
    |   SPI lines |<=======>| SPI lines   |
    |             |         +-------------+
    |          A0 |<-----+
    |          A1 |<-----+
    +-------------+      |
                        VIO

or

    +-------------+         +-------------+
    |     ADC     |         |     HOST    |
    |             |         |             |
    |   SPI lines |<=======>| SPI lines   |
    |             |         +-------------+
    |          A0 |<--------- VIO
    |          A1 |<-----+
    +-------------+      |
                        GND

Or even, possibly, a mix of GPIO and hard-wired.

    +-------------+         +-------------+
    |     ADC     |         |     HOST    |
    |             |         |             |
    |   SPI lines |<=======>| SPI lines   |
    |             |         |             |
    |          A0 |<--------| GPIO_A      |
    |             |         +-------------+
    |          A1 |<-----+
    +-------------+      |
                        GND

We have bindings (like adi,ad7191.yaml [1]) describing the hard-wired setups
with function specific properties. E.g.
  adi,pga-value:
    $ref: /schemas/types.yaml#/definitions/uint32
    description: |
      Should be present if PGA pins are pin-strapped. Possible values:
      Gain 1 (PGA1=0, PGA2=0)
      Gain 8 (PGA1=0, PGA2=1)
      Gain 64 (PGA1=1, PGA2=0)
      Gain 128 (PGA1=1, PGA2=1)
      If defined, pga-gpios must be absent.
    enum: [1, 8, 64, 128]

This approach works fine, but it requires documenting device-specific values
(e.g. gain 1, gain 8, ..., gain X) for each new series of ADCs because each
each series has different hardware properties.

Sometimes peripherals have pins with different functions that are also either
hard-wired or connected to GPIOs (like adi,ad7606.yaml [2] and adi,ad7625.yaml [3]).
Software wants to know about the state of those pins. When they are connected
to GPIOs, we can just read the GPIO value. But when the pins are hard-wired,
we have to set additional dt properties (e.g. adi,pga-value) and then software
figures out the state of the pins from the value read from dt.
What we wonder is whether it would be possible to have both the GPIO and
hard-wired cases described by gpio properties.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml#n77
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml#n127
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml#n70

For example, instead of having

/* All GPIOs case */
pga-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>, <&gpio 24 GPIO_ACTIVE_HIGH>;

and

/* All hard-wired (pin-strapped) case */
adi,pga-value = <1>;

maybe we could have something like

/* All gpios */
pga-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>,
            <&gpio0 1 GPIO_ACTIVE_HIGH>;
/* or all hard-wired */
pga-gpios = <&fixed_gpio GPIO_FIXED_LOW>,
            <&fixed_gpio GPIO_FIXED_LOW>;

as suggested by David [4].

Though, I'm also a bit worried about such way of describing the hard-wired
connections being potentially confusing as those "fixed-gpios" would not
necessarily mean any actual GPIO.

[4]: https://lore.kernel.org/linux-iio/CAMknhBHzXLjkbKAjkgRwEps=0YrOgUcdvRpuPRrcPkwfwWo88w@mail.gmail.com/


With best regards,
Marcelo

