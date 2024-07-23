Return-Path: <linux-iio+bounces-7813-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B257D939BC5
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 09:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2624DB21239
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 07:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5B414AD17;
	Tue, 23 Jul 2024 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii6p1hZz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03E313C9A3;
	Tue, 23 Jul 2024 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721719914; cv=none; b=Vy7DJ8pbzgGHERU05+d71AQjJtpQiscSiXS5t74r1rOtzo/YNomweEbRG7mgB5bHi66fmP26fgoos5PrQLnZVnqMKL5fbchgeE50pz0jM5YA1b9IF9CWJNiAwXXF1DJMz16hPcQKSXoA8g1j1m9HSnP1MFrYIIZUwR22kddaCW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721719914; c=relaxed/simple;
	bh=UohvSeBwyrr5yKLCUk8rF8JhQ/M2MmDBOhyLHQ/KLOQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vEebcW7ET7FDaPSjV5bBdB2Y8U6YYZdXyY3jClRNAgzrS7kGECQAPIlPxU2x8Qg+6A1iQBeCPOP5hzrTnESsVZCK8NBQfzzVK0EvBu4Vde4MJwmXBGGrk7Gl06af0/5LdFA5obkV1e4L28Exjorf9wN6yPskJuSQjGTNxE/woWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ii6p1hZz; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef248ab2aeso39765851fa.0;
        Tue, 23 Jul 2024 00:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721719910; x=1722324710; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S8OpMIM8zPG8UTttbR7UeAoGfnG3+0y+abp6BXVUgH0=;
        b=ii6p1hZz0uNaCbvDXzCj5yI+UaHa4g4AUQFdv1UsxRGGqG6OP3mhrooJcM+/OCK9lN
         vce+qjTSs9Kne1TxsSQhQUlCMAJVEimq8PISxLh6c/joZ9cspp0qtWARYO+uM9RfTKvc
         j2PcuYHWBItP+dKlUJsbfd+WnfoERZ3VcjGHh8PWSGCGXblQyxu26x6ogon6u0/rCwhm
         PvcF1/L+75e9n5+QpD5+RlhBNXRysAgpn5MO1PLx9IDAWemj1ZfR/BgDXyHoruG6ht5T
         Fu830x/noJ1hEv2bCENnFbXfqseW5mGCm3FZQ5Q5UdoczXza4fkt9IuRK01MoMUK2Ss/
         Bd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721719910; x=1722324710;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S8OpMIM8zPG8UTttbR7UeAoGfnG3+0y+abp6BXVUgH0=;
        b=u4R6Ba5ybNdi9G62chXghCKCAtI0VIg0BveJnAHOhMn8iSKyWlmTZXcZxdhHjWOkZ+
         4pOi0+n80fhyfpw0FICnlhX5lnxwqEwEdnZZCBCsj3TFrwUe6OsGtZPCjrU8fp1UfjjC
         lBWDSQp/K3xcfvi7eNyEIknXrMTZylg7NfNSd+XTuLPhzhwbqIp1+ENI/kefpfsCObJK
         fhbHZnKCWNX813lSdYqyZXMpgf0vP5zoy/swN/VVZ/wN2nIoSbtssZfU9AQ87BMHHwZu
         w6bNpH+zgw7BKjmF5EdcXbZX70DVHtnOCOyUeIvvMtUYPTUF9WVFHew8P2Dzcjc3IF1U
         25SA==
X-Forwarded-Encrypted: i=1; AJvYcCVEPg1DCVg+zCCKzn/dTKn8CmbGyAvIyrs7x5rHGAA0J/u+wJSe99embQzXPe/1ssXMJoHZ2E+3wx1qNswmh+3AD0D3Xbtvqut2vvnToGjZ8jeYLNWnX76nsurjs44BAdrucwSPlli0c/QosBgejGQZ7uJJY3HKV5hu7Ftp+14MZIxjAKDO101T0DunGm8JcAw/0r3XjkeH9OlvYYm7kg==
X-Gm-Message-State: AOJu0YzDIdaPdou2cvG9uxW4QOwSpRheeEiS3szKhDmZ6PbEY9WiOFqW
	J3ikerWdUzkQy6Xj+SJd9YEyyFQHopjtwl2uu6Rp/FfKFSrW8zqu
X-Google-Smtp-Source: AGHT+IGcozbYkl92FBIC7Hg0sePjuRwqr2c3Fwc8sA30LZiKQKPH8Ap7+SyPt29k59IDgOcL1icaTQ==
X-Received: by 2002:a2e:a406:0:b0:2ef:2012:eecf with SMTP id 38308e7fff4ca-2ef2012efd6mr65768641fa.26.1721719909441;
        Tue, 23 Jul 2024 00:31:49 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30aaa2d48sm7109526a12.32.2024.07.23.00.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 00:31:49 -0700 (PDT)
Message-ID: <75511e8371f7ffea1ed84a784231f3dc51363842.camel@gmail.com>
Subject: Re: [PATCH RFC v3 0/9] spi: axi-spi-engine: add offload support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
	 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Date: Tue, 23 Jul 2024 09:35:46 +0200
In-Reply-To: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
References: 
	<20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi David,

On Mon, 2024-07-22 at 16:57 -0500, David Lechner wrote:
> There is a recap at the end of this cover letter for those not familiar
> with the previous discussions. For those that are, we'll get right to
> the changes since the last version.
>=20
> In RFC v2, most of the discussion was around the DT bindings, so that
> is what has mostly changed since then. I think we mostly settled on
> what properties are needed and where they should go. There are probably
> still some details to work out (see PATCH 5/9 for more discussion) but
> I think we have the big-picture stuff figured out.
>=20
> Here is the actual devicetree used for testing to show how it all
> comes together:
>=20
> 	trigger_clk: adc-trigger-clock {
> 		compatible =3D "pwm-clock";
> 		#clock-cells =3D <0>;
> 		#trigger-source-cells =3D <0>;
> 		pwms =3D <&adc_trigger 0 10000>;
> 	};
>=20
> 	...
>=20
> 	axi_spi_engine_0: spi@44a00000 {
> 		compatible =3D "adi,axi-spi-engine-1.00.a";
> 		reg =3D <0x44a00000 0x1000>;
> 		interrupt-parent =3D <&intc>;
> 		interrupts =3D <0 56 IRQ_TYPE_LEVEL_HIGH>;
> 		clocks =3D <&clkc 15>, <&spi_clk>;
> 		clock-names =3D "s_axi_aclk", "spi_clk";
>=20
> 		/* offload-specific properties */
> 		#spi-offload-cells =3D <1>;
> 		dmas =3D <&rx_dma 0>;
> 		dma-names =3D "offload0-rx";
> 		trigger-sources =3D <&trigger_clk>;
>=20
> 		#address-cells =3D <1>;
> 		#size-cells =3D <0>;
>=20
> 		ad7986: adc@0 {
> 			compatible =3D "adi,ad7986";
> 			reg =3D <0>;
> 			spi-max-frequency =3D <111111111>; /* 9 ns period */
> 			adi,spi-mode =3D "single";
> 			avdd-supply =3D <&eval_u12>;
> 			dvdd-supply =3D <&eval_u12>;
> 			vio-supply =3D <&eval_u3>;
> 			bvdd-supply =3D <&eval_u10>;
> 			ref-supply =3D <&eval_u5>;
> 			turbo-gpios =3D <&gpio0 87 GPIO_ACTIVE_HIGH>;
>=20
> 			spi-offloads =3D <&axi_spi_engine_0 0>;
> 		};
> 	};
>=20
> A working branch complete with extra hacks can be found at [1].
>=20
> Also, I took a detour looking into what it would take to get Martin
> Sperl's Raspberry Pi DMA offload proof-of-concept [2] updated to work
> with this. This way we could have a second user to help guide the
> design process. Given all of the SPI hardware quirks on that platform
> and the unsolved technical issues, like how to get accurate time delays
> and how to work around the 32-bit DMA word limitation, it would be more
> work than I have time for (at least without someone sponsoring the work).
>=20
> [1]: https://github.com/dlech/linux/tree/axi-spi-engine-offload-v3
> [2]:
> https://github.com/msperl/spi-bcm2835/blob/refactor_dmachain_for_prepared=
_messages/spi-bcm2835dma.c
>=20
> ---
> Changes in v3:
> - See individual patches for more detailed changes.
> - Reworked DT bindings to have things physically connected to the SPI
> =C2=A0 controller be properties of the SPI controller and use more
> =C2=A0 conventional provider/consumer properties.
> - Added more SPI APIs for peripheral drivers to use to get auxillary
> =C2=A0 offload resources, like triggers.
> - Link to v2:
> https://lore.kernel.org/r/20240510-dlech-mainline-spi-engine-offload-2-v2=
-0-8707a870c435@baylibre.com
>=20
> ---
>=20
> As a recap, here is the background and end goal of this series:
>=20
> The AXI SPI Engine is a SPI controller that has the ability to record a
> series of SPI transactions and then play them back using a hardware
> trigger. This allows operations to be performed, repeating many times,
> without any CPU intervention. This is needed for achieving high data
> rates (millions of samples per second) from ADCs and DACs that are
> connected via a SPI bus.
>=20
> The offload hardware interface consists of a trigger input and a data
> output for the RX data. These are connected to other hardware external
> to the SPI controller.
>=20
> To record one or more transactions, commands and TX data are written
> to memories in the controller (RX buffer is not used since RX data gets
> streamed to an external sink). This sequence of transactions can then be
> played back when the trigger input is asserted.
>=20
> This series includes core SPI support along with the first SPI
> controller (AXI SPI Engine) and SPI peripheral (AD7944 ADC) that use
> them. This enables capturing analog data at 2 million samples per
> second.
>=20
> The hardware setup looks like this:
>=20
> +-------------------------------+=C2=A0=C2=A0 +------------------+
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |
> > =C2=A0SOC/FPGA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 |=C2=A0 AD7944 ADC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0+---------------------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0| AXI SPI Engine=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 SPI Bus =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SPI Bus=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0|=C2=A0 +---------------+=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0|=C2=A0 | Offload 0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 +------------------+
> > =C2=A0|=C2=A0 |=C2=A0=C2=A0 RX DATA OUT > > > >=C2=A0=C2=A0 |
> > =C2=A0|=C2=A0 |=C2=A0=C2=A0=C2=A0 TRIGGER IN < < <=C2=A0 v=C2=A0 |
> > =C2=A0|=C2=A0 +---------------+=C2=A0 | ^ v=C2=A0 |
> > =C2=A0+---------------------+ ^ v=C2=A0 |
> > =C2=A0| AXI PWM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | ^ v=C2=A0 |
> > =C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CH0 > ^ v=C2=A0 |
> > =C2=A0+---------------------+=C2=A0=C2=A0 v=C2=A0 |
> > =C2=A0| AXI DMA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 v=C2=A0 |
> > =C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CH0 < < <=C2=A0 |
> > =C2=A0+---------------------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> +-------------------------------+
>=20
> To: Mark Brown <broonie@kernel.org>
> To: Jonathan Cameron <jic23@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Nuno S=C3=A1 <nuno.sa@analog.com>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: David Jander <david@protonic.nl>
> Cc: Martin Sperl <kernel@martin.sperl.org>
> Cc:=C2=A0 <linux-spi@vger.kernel.org>
> Cc:=C2=A0 <devicetree@vger.kernel.org>
> Cc:=C2=A0 <linux-kernel@vger.kernel.org>
> Cc:=C2=A0 <linux-iio@vger.kernel.org>
>=20
> ---
>=20

I think there are things that we need to better figure but things are impro=
ving
IMO :)

I'm only doing a very superficial review since I need to better look at the
patches...

But one thing that I do want to mention is a scenario (another funny one...=
)
that I've discussing and that might be a reality. Something like:

+-------------------------------+    +------------------+
|                               |    |                  |
|  SOC/FPGA            =C2=A0        |    |   ADC            |
|                               |    |                  |
|	+---------------+       |    |                  |
|       |  SPI PS Zynq  |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SPI Bus=
         |
|	+---------------+	|    |	                |
|                               |    |                  |
|  +---------------------+      |    |                  |
|  | AXI SPI Engine      |      |    |                  |
|  |                 v=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D DATA=
 Bus         |
|  | =C2=A0               v   |      |    |                  |
|  |   +---------------+ |      |    |                  |
|  |  | Offload 0     |  |      |    +------------------+
|  |  |   RX DATA OUT |  |      |
|  |  |    TRIGGER IN |  |      |
|  |  +---------------+  |      |
|                               |
+-------------------------------+

From the above, the spi controller for typical register access/configuratio=
n is
not the spi_enigine and the offload core is pretty much only used for strea=
ming
data. So I think your current approach would not work with this usecase. In=
 your
first RFC you had something overly complicated (IMHO) but you already had a
concept that maybe it's worth looking at again. I mean having a spi_offload
object that could describe it and more importantly have a provider/consumer
logic where a spi consumer (or maybe even something else?) can get()/put() =
an
offload object to stream data.

I know, I did said that I did not liked for spi consumers to have to explic=
itly
call something like spi_offload_get() but I guess I have been proved wrong =
:).
We can also try to be smart about it as an explicit get is only needed (lik=
ely)
in the above scenario (or maybe we can even do it directly in the spi core
during spi_probe()). Or maybe it's not worth it to play smart and just let
consumers do it (that's the typical pattern anyways).

Having said the above, I still think your current proposal for triggers and
getting DMA streams is valid for the above usecase.

FWIW, I'm also trying to understand with the HW guys why the hell can't we =
just
use the spi_engine controller for everything. But the whole discussion is
already showing us that we may need more flexibility.

Thanks!
- Nuno S=C3=A1

