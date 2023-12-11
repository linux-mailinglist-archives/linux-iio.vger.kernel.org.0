Return-Path: <linux-iio+bounces-810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4D980C415
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 10:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96733B20F2B
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 09:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD19621108;
	Mon, 11 Dec 2023 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XZBWTh9d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DBEF5
	for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 01:13:15 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ca00dffc23so51859081fa.2
        for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 01:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702285994; x=1702890794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMuq41y0q5sJqso/AUvyl7ZAzaKQVaVlE4PNh5IKGB8=;
        b=XZBWTh9dUsNLObywd7mGcxjZ7x3APuo1IaI+HZV3I+o6UdM+akYvit6amayZCW0JD1
         RyPNiHO2jFlNH1EWuYNjYEYWhLEkJ3vtK11mPcA4iwpULU3K1+kPd0PmznjWfzfbySLK
         Sl06ceN1xBbA2Xzj2++HFtEu1Ouhp1Kf4XK0kmqgai6XtitLMX+j0tfY6lJ/6D+zSRmz
         /fT+Pc0OXYYwIRr+b0svIj+JtssZoSh349qxKD4FSr1ZmtkczYaE+3kTIT28HwlYiPRv
         BnyQakvbN0B2G6+xNfbXaB67rKQm6+6VZyPqxLw/KWjvIU5Nd8GBmjJIQcg+lpmpekif
         bltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702285994; x=1702890794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMuq41y0q5sJqso/AUvyl7ZAzaKQVaVlE4PNh5IKGB8=;
        b=H3kD/lPLvakMf+ZHaQZQFsB7x6ZelTLnHiePFW5DaYYXAFEYRSeYbIJojuqqMTQO1o
         5O29gCKwQL30IU9qguedhM6G4uFys/jKJ9KQRLkMSMDeHaHJGNDzHOWfOPyLpkaPI4S4
         ILQMzzlHGR2bAI/llwwtGHsLa2dI44hm1jGebk8LtvtXkHJq77VWetJwUNByNv/tWRRB
         kL9E4dF46uWl5TeVe2GZUJiO/rvk5NS+SjgwJ5X7fEnvXPDXv+HXOc0b4IdWWaPVcJx+
         3BuliXk0lTNXZ+wq+p6KojKnR1dW27xvERm2zxos0tXseoV0cKf7UTgY3lbvok31cfdp
         HL+A==
X-Gm-Message-State: AOJu0YzKJNPJ26OLOoYbDCeRCUi5Z8KtdeKRyfHjUWw415fvUaNBkq56
	zkqf8HNXHNkFb8Yr/q/9FpcSivenlRf9GZiqb/WDGg==
X-Google-Smtp-Source: AGHT+IHB3c+HElrh1wEsgL0DN7SQaXufcgIjPdqncwltsjOSP9zDhyNRpPscij1xxvoK1/39kMXk/tTF2TS4wzKhROI=
X-Received: by 2002:a2e:a417:0:b0:2ca:3591:6667 with SMTP id
 p23-20020a2ea417000000b002ca35916667mr1391946ljn.82.1702285993598; Mon, 11
 Dec 2023 01:13:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208-ad7380-mainline-v1-0-2b33fe2f44ae@baylibre.com>
 <20231208-ad7380-mainline-v1-1-2b33fe2f44ae@baylibre.com> <20231210134932.0bb429f1@jic23-huawei>
In-Reply-To: <20231210134932.0bb429f1@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 11 Dec 2023 10:13:02 +0100
Message-ID: <CAMknhBFh+tMOjo86-_C2a8=Tp+=NgGEPDg9CZTsngrHeoXt1Fw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add binding for AD7380 ADCs
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Alexandru Ardelean <alexandru.ardelean@analog.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 2:49=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri,  8 Dec 2023 09:51:40 -0600
> David Lechner <dlechner@baylibre.com> wrote:
>
> > This adds a binding specification for the Analog Devices Inc. AD7380
> > family of ADCs.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> Hi David,
>
> Comments inline.  A question for Mark Brown on the 2-wire bit..
> Do we have existing DT bindings for devices with parallel spi data
> outputs?
>
> > ---
> >  .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 102 +++++++++++++=
++++++++
> >  MAINTAINERS                                        |   9 ++
> >  2 files changed, 111 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> > new file mode 100644
> > index 000000000000..e9a0b72cd9d3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> ...
>
>
> > +  * https://www.analog.com/en/products/ad7380.html
> > +  * https://www.analog.com/en/products/ad7381.html
> > +  * https://www.analog.com/en/products/ad7383.html
> > +  * https://www.analog.com/en/products/ad7384.html
>
> > +  adi,sdo-mode:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: [ 1-wire, 2-wire ]
> > +    description:
> > +      In 1-wire mode, the SDOA pin acts as the sole data line and the =
SDOB/ALERT
> > +      pin acts as the ALERT interrupt signal. In 2-wire mode, data for=
 input A
> > +      is read from SDOA and data for input B is read from SDOB/ALERT (=
and the
> > +      ALERT interrupt signal is not available).
>
> This is fun...  If I understand correctly 2-wire requires two SPI buses (=
or a complex
> spi controller that does parallel serial channels).

No, it wouldn't work with two separate SPI busses. Only a special
controller with parallel serial channels.

> What would description for that
> look like in DT and can we not establish what is wanted here from that bu=
s description
> rather than an adi specific property?
>
> Seems a bit like parallel-memories.

I don't think this is the same as parallel-memories. Looking at the
the patch [1] it looks like parallel memories requires multiple CS
lines to connect to multiple chips to make the multiple chips behave
as one chip but otherwise works like SPI_RX_DUAL.

This ADC, on the other hand, works as if two chips that share
everything except the MISO line. Each MISO line (SDOA and SDOB) shifts
out one bit of two different words in parallel on each line instead of
two bits of the same word like SPI_RX_DUAL busses.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit=
/?h=3Dfor-6.8&id=3D88a50c1663ffa9f6b31705c6bf7a887a2c8d9434

>
> Mark, any insights into what we should do to describe this?
>
> > +
> > +  vcc-supply:
> > +    description: A 3V to 3.6V supply that powers the chip.
> > +
> > +  vlogic-supply:
> > +    description:
> > +      A 1.65V to 3.6V supply for the logic pins.
> > +
> > +  refio-supply:
> > +    description:
> > +      A 2.5V to 3.3V supply for the external reference voltage. When o=
mitted,
> > +      the internal 2.5V reference is used.
> > +
> > +  interrupts:
> > +    description:
> > +      When the device is using 1-wire mode, this property is used to o=
ptionally
> > +      specify the ALERT interrupt.
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - adi,sdo-mode
>
> Could define a default of 1-wire?  Simplifies things a little in the bind=
ings.
>
> > +  - vcc-supply
> > +  - vlogic-supply
>
>

