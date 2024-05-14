Return-Path: <linux-iio+bounces-5054-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4408C5DF1
	for <lists+linux-iio@lfdr.de>; Wed, 15 May 2024 00:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172CF1F21BE8
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 22:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA6C182C8A;
	Tue, 14 May 2024 22:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="avs8WKp1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F4D181D1F
	for <linux-iio@vger.kernel.org>; Tue, 14 May 2024 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715727424; cv=none; b=ZaBGT+psriXxGnVTny8nQrLtHH8kdSHP8w+TGFLuo5YrdE6GPX4m4XfNbMzXeROamX8m/6IdWGb2ksUif1N3Gk3JljUMaWHEfLFCWbuzYAnUT3QdgzYU2mZTw4JWO4p0hxgS23bPudbRM6aTRI6NE8uBRwkFkjlvpFP7j8tUcrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715727424; c=relaxed/simple;
	bh=Hd9zh3GQb03nolRVD6eAo6YdGGY8ykcGDc5hIXbH0ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcPvB7egotwiAbah/ByDU6Nn8+kEUEFM6He9P9wuoU1NapdDr0zuXBnkrenPg8HF33jMtmieGMiNuJ8lvN9gqcsiy8Kl0M9QJiNNMFJ30U4kUUa0DUnNvpqrDI6FYhddXX79Nt4SMGmRAmaBDoWOeswM/NqsIP6yk+mRDDzMF7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=avs8WKp1; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e4b90b03a9so68564931fa.1
        for <linux-iio@vger.kernel.org>; Tue, 14 May 2024 15:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715727419; x=1716332219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqDfErsAIvXNpJiwt5/s5c8lzY4lySTjmGzhns7KzDs=;
        b=avs8WKp1kk2smbuxT070hb9HOrbYfy45qrOlbN75ZV7DxF320v9fSYpYWKE2QbxR6A
         TlHfuOKqFsQi46x30vtfIpwxXlwlr+cEG5aZe7rBvuMw6yVkV8azuD8qBFc8vLDg9cYP
         u9ZtuIsb78W/GfSHBo+A/LuJgruwtozFsGka6cCqhzRf5GAhH6YTC/nkL/OnnCejOtAJ
         5Qpd3deUpgYXVatviJ2i8nU984RhErizHoQt8PHIi2xdflTRYNKRX77bPn4e61eF7hw6
         QHsVqKn7MVXkMQRC9W/XJLNexRbbckcm0FoJjmj21gEEH1m8E7NGf0EMEXMnnbSiRS2a
         mEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715727419; x=1716332219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqDfErsAIvXNpJiwt5/s5c8lzY4lySTjmGzhns7KzDs=;
        b=cHZP+BKSC2Iytx/93ViXCeolKhhOWUR/OCyIM7i1V+IkYYLWRyLr972ZozU/0zayWS
         1nZIUA2Gg5AhXli1ESnLueZmD0gIzWOWGye50AkhDzHQi2cmfFoI4tAi6TXSQAzsJOu4
         gpJ9+W8uvXr2Bd6Ce1XIfyr4dNmvOTn78CQ/JS4imezfgAstdexikoR1nKnk+CoLL+vq
         +XcMnQgKa6isxXpUgkSvtmyKOMkbL1Hdw4uWJP7Y28JfNQRE/IyzuNNq5WIWjtkxRFpn
         ef5XWY9e+PqLe47NtUn7Me8IcA24vF4C36BUxOai0p2G42iNW6pqNxsj653PSOYEg6/p
         pipg==
X-Forwarded-Encrypted: i=1; AJvYcCXlIAow3H9j95tnaFqE+wxVhVjN8nlZfRSoNfnBLWsdeNcmtFm5wAAup3uOqEih0Sv9A1f0xgqSv16VUwXDQw7uPjuTkysSeZax
X-Gm-Message-State: AOJu0YwgHIjOoEVz/fql2otzGeVw2gr3vgQSD2wmj9dNV14cBDq95tvG
	PjSOZUZS3Y4i3nFUExCk8MuREuQxaNUnyiD0FZar9Yl4NtDR1jj1TRE26l/FaVp/Y5PdJupBq9c
	c1G1CHCG6EIJyGYXANX4Zd2srnIDr+SyRBWOm+A==
X-Google-Smtp-Source: AGHT+IHplXBZPqVYw4OK9JhnYypr1UVJCflKVTdVxeyuNswLkMckc7sJorRBZiRnxghVCGT0lb29z5yRPNPHjzJpTr4=
X-Received: by 2002:a2e:8255:0:b0:2db:4f3f:55a7 with SMTP id
 38308e7fff4ca-2e5204cc8d2mr84960101fa.45.1715727418897; Tue, 14 May 2024
 15:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
 <20240510-dlech-mainline-spi-engine-offload-2-v2-1-8707a870c435@baylibre.com>
 <20240513-headsman-hacking-d51fcc811695@spud> <CAMknhBE5XJzhdJ=PQUXiubw_CiCLcn1jihiscnQZUzDWMASPKw@mail.gmail.com>
 <20240514-aspire-ascension-449556da3615@spud>
In-Reply-To: <20240514-aspire-ascension-449556da3615@spud>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 14 May 2024 17:56:47 -0500
Message-ID: <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/8] spi: dt-bindings: spi-peripheral-props: add
 spi-offloads property
To: Conor Dooley <conor@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	David Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 1:46=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, May 13, 2024 at 12:06:17PM -0500, David Lechner wrote:
> > On Mon, May 13, 2024 at 11:46=E2=80=AFAM Conor Dooley <conor@kernel.org=
> wrote:
> > >
> > > On Fri, May 10, 2024 at 07:44:24PM -0500, David Lechner wrote:
> > > > This adds a new property to the spi-peripheral-props binding for us=
e
> > > > with peripherals connected to controllers that support offloading.
> > > >
> > > > Here, offloading means that the controller has the ability to perfo=
rm
> > > > complex SPI transactions without CPU intervention in some shape or =
form.
> > > >
> > > > This property will be used to assign controller offload resources t=
o
> > > > each peripheral that needs them. What these resources are will be
> > > > defined by each specific controller binding.
> > > >
> > > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > > ---
> > > >
> > > > v2 changes:
> > > >
> > > > In v1, instead of generic SPI bindings, there were only controller-
> > > > specific bindings, so this is a new patch.
> > > >
> > > > In the previous version I also had an offloads object node that des=
cribed
> > > > what the offload capabilities were but it was suggested that this w=
as
> > > > not necessary/overcomplicated. So I've gone to the other extreme an=
d
> > > > made it perhaps over-simplified now by requiring all information ab=
out
> > > > how each offload is used to be encoded in a single u32.
> > >
> > > The property is a u32-array, so I guess, not a single u32?
> >
> > It is an array to handle cases where a peripheral might need more than
> > one offload. But the idea was it put everything about each individual
> > offload in a single u32. e.g. 0x0101 could be offload 1 with hardware
> > trigger 1 and 0x0201 could be offload 1 with hardware trigger 2. Then
> > a peripheral could have spi-offloads =3D <0x0101>, <0x0201>; if it
> > needed to select between both triggers at runtime.
> >
> > >
> > > > We could of course consider using #spi-offload-cells instead for
> > > > allowing encoding multiple parameters for each offload instance if =
that
> > > > would be preferable.
> > >
> > > A -cells property was my gut reaction to what you'd written here and
> > > seems especially appropriate if there's any likelihood of some future
> > > device using some external resources for spi-offloading.
> > > However, -cells properties go in providers, not consumers, so it woul=
dn't
> > > end up in spi-periph-props.yaml, but rather in the controller binding=
,
> > > and instead there'd be a cell array type property in here. I think yo=
u
> > > know that though and I'm interpreting what's been written rather than
> > > what you meant.
> >
> > Indeed you guess correctly. So the next question is if it should be
> > the kind of #-cells that implies a phandle like most providers or
> > without phandles like #address-cells?
>
> I'm trying to understand if the offload could ever refer to something
> beyond the controller that you'd need the phandle for. I think it would
> be really helpful to see an example dt of a non-trivial example for how
> this would work. The example in the ad7944 patch has a stub controller
> node & the clocks/dmas in the peripheral node so it is difficult to
> reason about the spi-offloads property there.

The fully implemented and tested version of the .dts corresponding to
the hardware pictured in the cover letter can be found at [1].

[1]: https://github.com/dlech/linux/blob/axi-spi-engine-offload-v2/arch/arm=
/boot/dts/xilinx/zynq-zed-adv7511-ad7986.dts

To be clear though, the idea that I am proposing here is that if there
is something beyond the SPI controller directly connected to the
offload, then we would add those things in the peripheral node along
with the spi-offloads property that specifies the offload those other
things are connected to.

Tangent on phandle vs. no phandle:

If we add #spi-offload-cells, I would expect that it would always be
in the SPI controller node. And the consumers would always be SPI
peripheral nodes. So having a phandle seems redundant since it would
always point to the controller which is the parent of the peripheral.

example_spi: spi {
    ...
    #spi-offload-cells =3D <1>;

    adc@0 {
        ...
        /* fine, but not sure phandle is needed since it always the parent =
*/
        spi-offloads =3D <&example_spi 0>;
    };
};

spi {
    ...
    #spi-offload-cells =3D <1>;

    adc@0 {
        ...
        /* simpler is better? */
        spi-offloads =3D <0>;
    };
};

Back to "something beyond the SPI controller":

Here are some examples of how I envision this would work.

Let's suppose we have a SPI controller that has some sort of offload
capability with a configurable trigger source. The trigger can either
be an internal software trigger (i.e. writing a register of the SPI
controller) or and external trigger (i.e. a input signal from a pin on
the SoC). The SPI controller has a lookup table with 8 slots where it
can store a series of SPI commands that can be played back by
asserting the trigger (this is what provides the "offloading").

So this SPI controller would have #spi-offload-cells =3D <2>; where the
first cell would be the index in the lookup table 0 to 7 and the
second cell would be the trigger source 0 for software or 1 for
hardware.

Application 1: a network controller

This could use two offloads, one for TX and one for RX. For TX, we use
the first slot with a software trigger because the data is coming from
Linux. For RX we use the second slot with a hardware trigger since
data is coming from the network controller (i.e. a data ready signal
that would normally be wired to a gpio for interrupt but wired to the
SPI offload trigger input pin instead). So the peripheral bindings
would be:

#define SOFTWARE_TRIGGER 0
#define HARDWARE_TRIGGER 1

can@0 {
    ...
    spi-offloads =3D <0 SOFTWARE_TRIGGER>, <1 HARDWARE_TRIGGER>;
    /* maybe we need names too? */
    spi-offload-names =3D "tx", "rx";
};

In this case, there is nothing extra beyond the SPI controller and the
network controller, so no extra bindings beyond this are needed.

Application 2: an advanced ADC + FPGA

This is basically the same as the ad7944 case seen already with one
extra feature. In this case, the sample data also contains a CRC byte
for error checking. So instead of SPI RX data going directly to DMA,
the FPGA removes the CRC byte from the data stream an only the sample
data goes to the DMA buffer. The CRC is checked and if bad, an
interrupt is asserted.

Since this is an FPGA, most everything is hardwired rather than having
any kind of mux selection so #spi-offload-cells =3D <1>; for this
controller.

By adding spi-offloads to the peripheral node, it also extends the
peripheral binding to include the additional properties needed for the
extra features provided by the FPGA. In other words, we are saying
this DT node now represents the ADC chip plus everything connected to
the offload instance used by the ADC chip.

adc@0 {
    ...
    spi-offloads =3D <0>;
    dmas =3D <&dma 0>; /* channel receiving split out sample data */
    dma-names =3D "rx";
    interrupts =3D <&intc 99>; /* interrupt for bad CRC */
    interrupt-names =3D "crc";
};

>
> > Asking because I got pushback on
> > v1 for using a phandle with offloads (although in that case, the
> > phandle was for the offload instance itself instead for the SPI
> > controller, so maybe this is different in this case?).
>
> Do you have a link to this v1 pushback?

Hmm... maybe that was from some internal review before v1 that I was
remembering and confusing with the resistance of different aspects you
mention below.

> I had looked at the v1's binding
> comments and didn't see that type of property being resisted - although
> I did see some resistance to the spi peripheral node containing any of
> the information about the offloads it had been assigned and instead
> doing that mapping in the controller so that the cs was sufficient. I
> don't think that'd work with the scenario you describe above though
> where there could be two different triggers per device tho.

I think most of the objection was to having an offloads object node
with offload@ subnodes in the SPI controller node along side the
peripheral nodes.

