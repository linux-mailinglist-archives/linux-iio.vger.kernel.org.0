Return-Path: <linux-iio+bounces-4246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6524E8A3DAE
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 18:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3DF281F29
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 16:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883B54D106;
	Sat, 13 Apr 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0EI+W7EK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2C44CB41
	for <linux-iio@vger.kernel.org>; Sat, 13 Apr 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713025331; cv=none; b=UPIcqD8EPHhV1RCmhDD95T6+7A8JfoAmzc5G0wicsX9r55mM0Pf64vgFFGCpYyqwaKE2evPBL3chA9IvLIRo6UPWL2YwZ6YlI9J3Lf7lyKvp8K91uD/+PFi8dQSlGsDtNnp3u6KUDp2IoklxpIe8+JGKwGYLMonwpkO47CWJ+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713025331; c=relaxed/simple;
	bh=nbGy+ywMlYZDeVQzLzbUm56CmdghV/bErN6nIoXGelw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+5l/CFRve1rT99KiR/8r6ZeSRzcGWYgZIPOttmlK/agbmnqB7LvUo2l6esNAm8vayTdM996VoXfCCRcg28Y9PqJSN4AHhtzJIe/dZLbGxgv2XXLH1M9WARBm/8NgwJ3eNZME5WvNI7BqjEAoqTLutA0OyBQlFUW9KtKvygSXyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0EI+W7EK; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d8b194341eso16928151fa.3
        for <linux-iio@vger.kernel.org>; Sat, 13 Apr 2024 09:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713025327; x=1713630127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXOXrGDd5z9PLa2ziUwG/oevPNYw+NSWjiKaJx5XAcA=;
        b=0EI+W7EK3HSbLArLFx3euvX/W2rYk9M2GFxAGUJpl64UniQwQSqXDcBkqM6e1K/Abn
         4Wo32QENUO798GWP7rC0Mtv+u4zs9HTtMLwjWcZjLcqrBqDuaw29I0iBW6W+ckwWohiG
         ayUwyDtzHUXmNOk4H1JWDrFpXoi0JBqSu9nKorNFjAvuJEJN4LRJX1mT7loCt8y2cUjj
         NH9K75HBTJninLGH6yrdSwnXC2etEjwDo9D3I6AtfUmCV1uLVrkE4oULWcupVqsYMwyp
         j44vVbTnUFbNX2e6d+IyKTsZZZhDegaH6Md0+3syHkC0wOzEX06suaTrl89mijO1cAlG
         SZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713025327; x=1713630127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXOXrGDd5z9PLa2ziUwG/oevPNYw+NSWjiKaJx5XAcA=;
        b=FJjeyGjs/njzn+nfAh8M5L6Q61rI25pJvD+I5Rj/1WabwiZ5ESnur5HP0OfpZvvRcF
         n9j7eyj21UElNDc2sNLffoISZatBTWy3PFBMEQMk77YQHBSIK+vxooXWzu8oaBanTH0E
         Abfmk64j+eDd5FGg19Jc5RftMfY+xME0NcpPJNYOR9cG41safBkBgMZALQhGXh5OPPuk
         ImCnyYGW6zgO+X7WtFVAQX8pHcnXESnJcNtHwsncNbtTj/aBKaTgDDk1zcZ/+U5VrEAe
         M1jEOL7kypMUSSTbqDcm0KUdHG/MFU6WzZlW0lp8jvSz4dV+dyz4xHJ7X2YkU2iYa7on
         25wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhOfsjkRX3yaVEtH3/VRuVQJqQP+4YWDfkzMoBuyypFSj62KEfj/VJKk2NLEjYLuJOxo4EMRAPywCm+B+7ak2x60F8tzxZMtoI
X-Gm-Message-State: AOJu0YwGvMv6LXcIb40dMMeNNzFR7UIaAremdfB9Yun2y6imXKK7NGrL
	JaVec2uleR65QU2jsD6SgNBtElBz9qd1tG1/9fzZX7VRJSNrZJKD6NxkeJxef0VRcNCkaHqmoKK
	TEvXPOGnXyPnpJYV+KO/NoDhV2ZY7kPnRHt6/TQ==
X-Google-Smtp-Source: AGHT+IHuEs+Ug89vXvWX/+tZddISAesIXOCVXXp90n+3hTrdL0we6y2BUxjT33u7JDX77EDLE6F0m4gCGiTTAmXCxnI=
X-Received: by 2002:a2e:87ce:0:b0:2d9:ec13:3349 with SMTP id
 v14-20020a2e87ce000000b002d9ec133349mr3520729ljj.2.1713025326643; Sat, 13 Apr
 2024 09:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412032102.136071-1-kimseer.paller@analog.com>
 <20240412032102.136071-2-kimseer.paller@analog.com> <CAMknhBHgKK_OEcPz-5ktxj+YEkB7jHpw5owdh9HVj_qfwuVXkQ@mail.gmail.com>
 <20240413160610.4cec010b@jic23-huawei>
In-Reply-To: <20240413160610.4cec010b@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 13 Apr 2024 11:21:55 -0500
Message-ID: <CAMknhBHMd2mK3yVoH_XjW7BapX5BTRZjUJpF=ZQrF8Mctf-NJQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: iio: dac: Add adi,ltc2664.yaml
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 10:06=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Fri, 12 Apr 2024 16:23:00 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > On Thu, Apr 11, 2024 at 10:21=E2=80=AFPM Kim Seer Paller
> > <kimseer.paller@analog.com> wrote:
> > >

...

> >
> > And there is V~ on both which can be between -5.5V/-15.75V and GND, so
> > optional v-neg-supply seems appropriate.
>
> Only make it optional in the binding if the settings of the device change
> depending on whether it is there or not.  Looks like there is an internal
> reference, so maybe it really is optional.

I suggested optional with the thinking that if the pin is tied to GND,
then the property would be omitted.


...


> >
> > * (both) The MUX/MUXOUT pins look like we have an embedded pin mux, so
> > it could mean we need #pinctrl-cells. ltc2664 would also need
> > muxin-gpios for this.
> Not convinced that's the right approach - looks more like a channel
> selector than a conventional mux or pin control. Sure that's a mux, but
> we want a clean userspace control to let us choose a signal to measure
> at runtime
>
> If you wanted to support this I'd have the binding describe optional
> stuff to act as a consumer of an ADC channel on another device.
> The IIO driver would then provide a bunch of input channels to allow
> measurement of each of the signals.
>
> Look at io-channels etc in existing bindings for how to do that.
>

Right. I was thinking that this pin might be connected to something
else external rather than the signal coming back to the SoC (or
whatever has the SPI controller). But it makes more sense that we
would want it as extra channels being read back by the SoC for
diagnostics.

...

> >
> > > +
> > > +      patternProperties:
> > > +        "^channel@([0-3])$":
> > > +          $ref: '#/$defs/toggle-operation'
> > > +          unevaluatedProperties: false
> > > +
> > > +          description: Channel in toggle functionality.
> > > +
> > > +          properties:
> > > +            adi,output-range-microvolt:
> > > +              description: Specify the channel output full scale ran=
ge.
> >
> > How would someone writing a .dts know what values to select for this
> > property? Or is this something that should be configured at runtime
> > instead of in the devicetree? Or should this info come from the
> > missing voltage supplies I mentioned?
>
> Sometimes this one is a wiring related choice.  Sometimes to the extent
> that picking the wrong one from any userspace control can cause damage
> or is at least nonsense.
>
> You look to be right though that the possible values here aren' fine
> if the internal reference is used, but not the external.
>
> However, it's keyed off MPS pins so you can't control it if they aren't
> tied to all high.  So I'd imagine if the board can be damaged it will
> be hard wired.  Hence these could be controlled form userspace.
> It's a bit fiddly though as combines scale and offset controls and
> you can end trying to set things to an invalid combination.
> E.g. scale set to cover 20V range and offset set to 0V
> To get around that you have to clamp one parameter to nearest
> possible when the other is changed.
>

Thanks for the explanation. It sounds like I missed something in the
datasheet that would be helpful to call out in the description for
this property.

