Return-Path: <linux-iio+bounces-9427-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53496972BDE
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 10:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73BC1F2360D
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 08:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DE9186E4C;
	Tue, 10 Sep 2024 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVqqBhY1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186DA1779B1;
	Tue, 10 Sep 2024 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955940; cv=none; b=jCBkhTjdCu25MWCFLQ3Wg3xrr3b/FlUFSMKrNk2C+zTeCWh/WVYpjwT2jdkxHJu219GJzGH0Mev4Bk5xRJb0bBOUCSAq1IOAZshIonxEgCaY40lNNAuxLLol5H7lrBbZuz70pwJvDCTBUsO0qq3gNPd/JIAsEouOFHXWOQq4N2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955940; c=relaxed/simple;
	bh=ICmXMQVNTQSGLwkBI9Kz495M/fzfpwDQOaaynb3AG9Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SGncG83ga9vo2IZUx9zzh2ly+ymcFgdc4Q91PvQKdrsHRCr7Jptr7k49vjXwmcGIJ5e0bGv0aU5asJmhZbyKladddyAto98/KFaJalwzK4XpHCQo2tfpf8Nj8CYs/XPi06Rp2TZ8qbSQAwl/CBdypf4IfwEyq3b9yMhWHa5WJaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVqqBhY1; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5365cf5de24so3693522e87.1;
        Tue, 10 Sep 2024 01:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725955937; x=1726560737; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ICmXMQVNTQSGLwkBI9Kz495M/fzfpwDQOaaynb3AG9Y=;
        b=KVqqBhY1zzrnDnAVK17hzby7a8gkrG/E6oQAvio5dAR1DEz8azTl8SFWsslBW7Q1GX
         HdmU8Vbu6cHLQuuXhFGTN7vCgsSWBguGzOA5OU+pSiriJTA9PSz0BbNXUyruKauLavZ3
         SENVm2tIKJ/Oh6zvZ1F29XXyxXeStrn2JOCxOxQ5ZPI+rR0PiVzGIyEEBtyd3QlrSEsf
         4am3x+PHCBk1TSP7GPIRjQ6ugqOvrdQRgwE/u27iyF4lH+ErZIZVuaennKfV/z6qNjEW
         WfQxL5z7YRwI8XU20Kk9bc61vKN/JwFEMT5ZqEG69K0F3lVsNe6i7UsmeZjKVriE8MN8
         S2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725955937; x=1726560737;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ICmXMQVNTQSGLwkBI9Kz495M/fzfpwDQOaaynb3AG9Y=;
        b=R3xDa/EhLdstHmzon1/jQAMKUktfRejuTAbeLDbn+NKKJ+QmKxyL2Bsnt+oMFDZIG5
         HxWNzwGL0Gb/0BQWNFK+4UD2JIsVzjf2a0mP3NjYGWNTqsn4EITcegUEPmrRrT4D+UT7
         JYrcU8gk26ULQ4aniYfEvyjBW624ZgsG30/In6E6CQbLapCvO/KIHQSdKlS6lJdUHRGF
         7qZoSObkBG5wiiLkjPE9EtO0IfP39AY5kqFdQcOe74+HyoSej0m4YIWKlc1PAo33+DBQ
         py0oyU4qkVApjaHhmKDH1/h+BgzSFG+bDk728PXHbZgNzA6D1QAfrONaCbOOSDGei3b8
         Auow==
X-Forwarded-Encrypted: i=1; AJvYcCUrJK5hGM3AnggnrAm/fsa2k2jtKp1eXWyi/MOE5xKIZEpwa5drXR/nwdZrfdXjsf5EHJ368pRUzKc+@vger.kernel.org, AJvYcCWpUWkNsAtZHS5yZ3GoxP02Guw5YDmK7pk/NklPeRAxjBZQrgeJdQw0nR03UjV3ZhnRk3Q+MK3UJr71@vger.kernel.org, AJvYcCXL1HOvim/wHEPo6b5tF0x4o2Zg/cNG4ma/xOaj2K5CHhzM4beJW11AiLSerGDRxgpzdnl26ODiLQGpoLlL@vger.kernel.org
X-Gm-Message-State: AOJu0YyBcyL3Pc9HTWCuA5IdVnhqbJhdDyizYYtNfUwl7AazVANuHd70
	lDktxhUTVFkyazlJ6ZP0huphl4wGLIaRBMeFfrwYYJiVqRt/QiCz
X-Google-Smtp-Source: AGHT+IEPSZR/B2iQPdEVIl5qX+G2Mx8/14rU6SDBkYShlvn6DwXf+lVjVjGygSCAvoCHvxf2VAF5/Q==
X-Received: by 2002:a05:6512:2313:b0:535:3ca5:daa with SMTP id 2adb3069b0e04-536587a54a5mr7735801e87.7.1725955936173;
        Tue, 10 Sep 2024 01:12:16 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cae4ed007sm103220555e9.11.2024.09.10.01.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 01:12:15 -0700 (PDT)
Message-ID: <f54646877c2a68d01e15db31ae21224053f87439.camel@gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: iio: dac: ad3552r: add io-backend
 property
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Conor Dooley
	 <conor.dooley@microchip.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
	 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Sep 2024 10:16:24 +0200
In-Reply-To: <66090d3e-bf6c-43ee-9dc8-7bca449d448f@baylibre.com>
References: 
	<20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
	 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-1-87d669674c00@baylibre.com>
	 <20240908132925.331c5175@jic23-huawei>
	 <20240909-dwelled-specimen-949f44c8d04d@wendy>
	 <1dca9ce52e7c701c7fb6cbbc723e9dff5d0ace8b.camel@gmail.com>
	 <66090d3e-bf6c-43ee-9dc8-7bca449d448f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-09 at 12:19 -0500, David Lechner wrote:
> On 9/9/24 9:03 AM, Nuno S=C3=A1 wrote:
> > On Mon, 2024-09-09 at 13:46 +0100, Conor Dooley wrote:
> > > On Sun, Sep 08, 2024 at 01:29:25PM +0100, Jonathan Cameron wrote:
> > > > On Thu, 05 Sep 2024 17:17:31 +0200
> > > > Angelo Dureghello <adureghello@baylibre.com> wrote:
> > > >=20
> > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > >=20
> > > > > There is a version AXI DAC IP block (for FPGAs) that provides
> > > > > a physical bus for AD3552R and similar chips. This can be used
> > > > > instead of a typical SPI controller to be able to use the chip
> > > > > in ways that typical SPI controllers are not capable of.
> > > > >=20
> > > > > The binding is modified so that either the device is a SPI
> > > > > peripheral or it uses an io-backend.
> > > > >=20
> > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > >=20
> > > > > =C2=A0
> > > > > =C2=A0required:
> > > > > =C2=A0=C2=A0 - compatible
> > > > > -=C2=A0 - reg
> > > > > -=C2=A0 - spi-max-frequency
> > > > Sort of feels like both reg and spi-max-frequency
> > > > are valid things to specify.=20
> > > >=20
> > > > Maybe we have an excellent IP and dodgy wiring so want
> > > > to clamp the frequency (long term - don't need to support
> > > > in the driver today).
> > > >=20
> > > > Maybe we have an axi_dac IP that supports multiple
> > > > front end devices?=C2=A0 So maybe just keep reg?
> > >=20
> > > I'd like to be convinced that this incarnation of the AXI DAC IP is n=
ot
> > > a spi controller and that a ref to spi-controller.yaml is not out of
> > > place here. It may not be something that you'd ever use generally, gi=
ven
> > > the "weird" interface to it, but it does seem to be one regardless.
> > >=20
> >=20
> > Agreed.. As weird as it get's, it's acting as a spi controller.
> >=20
> > > I'd also really like to know how this fits in with spi-offloads. It
> > > /feels/, and I'd like to reiterate the word feels, like a rather simi=
lar
> > > idea just applied to a DAC instead of an ADC.
> >=20
> > The offload main principle is to replay a spi transfer periodically giv=
en an
> > input trigger. I'm not so sure we have that same principle in here. In =
here
> > I
> > guess we stream data over the qspi interface based on SCLK which can lo=
ok
> > similar. The difference is that this IP does not need any trigger for a=
ny
> > spi
> > transfer replay (I think).=20
> >=20
>=20
> Looking at the AD3552R from a SPI offload perspective of triggered SPI
> messages, I think it still works.
>=20
> The trigger doesn't have to be a clock/PWM. In this case, the trigger wou=
ld
> be whenever the IIO buffer is full and ready to send a burst of data (not
> sure if this would be a hardware or software trigger - but it works eithe=
r
> way).
>=20

Right... That's what we already have for DACs with HW buffering.

> Also, the DAC_CUSTOM_CTRL::ADDRESS register field in the AXI DAC IP core
> acts as an offload to record and play back a SPI write transfer.
>=20
> If we were using the AXI SPI Engine, this would be one SPI message with
> two xfers, one for the address write followed by one for the data write.

Just a nipick comment. At least from the current implementation the address=
 is
only writen once before starting to stream. So I guess we would not want to
replay that xfer for every sample.

> The size of the data write would be the size of the IIO buffer - or in
> the case of a cyclic DMA, the size of the write data would be channel
> data size * num channels and the xfer would have a special cyclic offload
> flag set.
>=20
> So I think we could make a single binding that works for the the AXI DAC
> backend/offload and the AXI SPI Engine offload. (I don't think it would
> be so easy to integrate the AXI DAC into the SPI framework on the driver
> side - and hopefully we won't have to, but the DT still could use the
> proposed SPI offload bindings.)
>=20

Hopefully not...=20


- Nuno S=C3=A1

