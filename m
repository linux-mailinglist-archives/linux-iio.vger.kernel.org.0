Return-Path: <linux-iio+bounces-23899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C5FB4A815
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 11:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DECA1738A0
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 09:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD4829BD90;
	Tue,  9 Sep 2025 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSvbfuuX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1AE29BD9B;
	Tue,  9 Sep 2025 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410142; cv=none; b=D8ZdJluBkcn5thmXsBk4Qi7QIpcZhmo9PbMMM+Y28MPJcOaUts9eB1T2BrhfADab0Ov5MY4Dop8A0JbV9KmsYMQ/PgdABhQ3Ez8TdLva7GnBcDDrDOBaRurhKQmugR882FZ7jERNHMAxOGAUscoKau2y3PVIyWia9nf57Lic7lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410142; c=relaxed/simple;
	bh=O2ib8gEHUxu7apw/BQPnJTenL3HamdgDD0ufDqWtBN0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sSNpu/G5uuE9pXWJZEXYdcm7kZIEaEGycCR10GW99S7L5rMaR2cqweHgIu7dszCM5h1U5hrmrFmPdKDPh/oWmB4Vtl9iOJZ4zMN/SrU8ywWE47ZxYdzOIs9jVNhTXWjCtqBOCXfwr7pWmJUhgwaOHz2Dxgkr+/2MKduvhe9dHl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSvbfuuX; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso9161286a12.0;
        Tue, 09 Sep 2025 02:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757410139; x=1758014939; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w83rncNEqDFPt9ulN4pgLStLD+df7eLviawv6mdeE5U=;
        b=aSvbfuuXEmhq3ob7qxYOY350XzVJSrV5HTHz0+FIrQM0w74oSpyCBoDSiPbiMIoaLS
         r6Mg0OZXcPP61I71zq53kXYlHwn9acHo6HRjmX7Se7UFR7WOJE3Jh0FQhGl+0H/GCuSY
         8FcjqdubBYY9HlRlg+vEZOdkWIKvpQ7vEi/Lt5C0tXJcbdQQp70rfzupiYt0ISQgmeoH
         FNg9mEbi2q0lzt1hhzV9f3MmJK2IgHgd+vnMF86AO1SAH0FeWpXSfA7lmc6xFxUL59zX
         hcUL6OgcprySThcUtxsZYcj0rfCWlBtsSm0vX0fSUpv/b+yqGiv8TF4CdqL3J8SI4vsf
         NaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757410139; x=1758014939;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w83rncNEqDFPt9ulN4pgLStLD+df7eLviawv6mdeE5U=;
        b=n7An6joBP61YGUUlvx+MWgC3U3JqKKi4/lXuLN6EoR3qE4d6SjDxV4HeVInXVBVGgB
         LhCmsb7KgEZvHlJf5dcQTYdE1hfUV1Vm7OmeEqcWeFXZWn8oYfQ2gV9TCf9j/77yoGfi
         19PVcsDg+JRftlykJjMrNZubG1DTNPAEbVfoafAGEEijyCPHTfO9XqJ7ZtyR1C4K79pH
         LhfZUx+aQtRfTs0VQpcOMfvNlZR1VyUvXh7hEZzgQwp2gdSFsRyRNuIEkLIpHzun8fDU
         8jS1JDTLNNJ9JivGcGsiJ0g0KKeuPa4Fj0KzAeNLF9hRrBtKC59q+OcCodXjd3HJ7g0q
         +VWg==
X-Forwarded-Encrypted: i=1; AJvYcCWWcmFNtf5beh+tU7B8aKmTtTGOkli0Lb95SNym19gM90XULG36Tagd/jc+DAe4GQkZHjWM3sF2lEAn@vger.kernel.org, AJvYcCXcNlVGI3dwac2xSt/YYjXBi7Dv0be6JCDrbeFRk9QmEFUFmOwto1WXwYxgjEvtF9JzO/HOIL0vgyEcbf2J@vger.kernel.org
X-Gm-Message-State: AOJu0YyG3JEQlNS09a1VJVz8wV7Lj8bsRHJkvQmkN9pxIOPCkBRbrNC4
	sD2V4HyblS8d93HWZ3c2mXEcZvTXSuZHGawsRytreIpi1Idm0GZlTkEAMlngZOtNNp4=
X-Gm-Gg: ASbGnctd/jpWTyXXzDieZlNiIaV3O826sxzUpqpsfIyVykg6ZOw6Rp/xOUIxwKHmgv/
	HU93OyQHc2yK5ycOlSoKC8FGysGYRD/yYsf69TRR5/11gLt13pFUYmhiAceh1qYfUpKBtmPgSco
	VLFYRABV90ILyqOHh3vIb16c2p0ol73QmBqN0cOt+puatFA23Q6OnAIRYTevTrl/QDbir2VPKu0
	IngouXFoGQyQ3C3qP300zzSABAyZVTvX5kcZyOkVDo+AzgIaCbyavicUnOveBG/LK1PYU1H1LJT
	aZ7jzaDvvAoI2+XD5qG+oy25diyxRHKhsBagZe2cw7mdeIkASlGOrRsiQ/0SV0QgBqwCIZ6lJuo
	/LoEEkstwDG5KpawDUekv0qo=
X-Google-Smtp-Source: AGHT+IEoxHcy4qUWzMVLKfVYxjk5ZG5WfMXOSzVDwfIfNWMjdAigcLQqBwurEu+XHwtPNDn7Z9jRfw==
X-Received: by 2002:a05:6402:520e:b0:617:9bff:be16 with SMTP id 4fb4d7f45d1cf-6237fa3d018mr9335751a12.22.1757410139093;
        Tue, 09 Sep 2025 02:28:59 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.162])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c6a264285sm414950a12.2.2025.09.09.02.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:28:58 -0700 (PDT)
Message-ID: <c30bb4b6328d15a9c213c0fa64b909035dc7bf40.camel@gmail.com>
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Daniel Lezcano
	 <daniel.lezcano@linaro.org>, jic23@kernel.org, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com, 
	ghennadi.procopciuc@oss.nxp.com
Date: Tue, 09 Sep 2025 10:29:23 +0100
In-Reply-To: <c23ed0cf-8188-49ac-b310-57bbfb54f337@baylibre.com>
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
	 <20250903102756.1748596-3-daniel.lezcano@linaro.org>
	 <eedbfbfd1ba625b6750eb3ae20a69301b8bc3ef9.camel@gmail.com>
	 <0bfce1eb-69f1-4dae-b461-234eb98ffce1@linaro.org>
	 <a3373804-08a4-4526-a432-c21a74ea3d6b@baylibre.com>
	 <edc8e024-e425-49de-bfa2-44218fe72e26@linaro.org>
	 <6b8cd005-b04c-4dd7-abf7-5a51319a5f0a@baylibre.com>
	 <23b80d52-6149-483b-a159-276dd00d12cd@linaro.org>
	 <e5e76789-c8d9-463c-aa01-f2c6ae718f74@baylibre.com>
	 <fd4c81a5-3b99-448c-92d4-9465f0e76db3@linaro.org>
	 <c23ed0cf-8188-49ac-b310-57bbfb54f337@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi *Daniel* (sorry for that :)),

On Mon, 2025-09-08 at 08:58 -0500, David Lechner wrote:
> On 9/8/25 7:16 AM, Daniel Lezcano wrote:
> > On 05/09/2025 23:54, David Lechner wrote:
> > > On 9/5/25 3:58 PM, Daniel Lezcano wrote:
> > > > On 05/09/2025 17:25, David Lechner wrote:
> > > > > On 9/5/25 4:44 AM, Daniel Lezcano wrote:
> > > > > > On 04/09/2025 19:49, David Lechner wrote:
> > > > > > > On 9/4/25 12:40 PM, Daniel Lezcano wrote:
> > > >=20
> > > > [ ... ]
> > > >=20
> > > > > Taking a step back, what sort of real-world uses cases do you nee=
d to
> > > > > support?
> > > > > Or are you just trying to implement everything that the ADC can d=
o?
> > > > > The latter
> > > > > can be a bit risky because you might end making something where y=
ou
> > > > > can't do
> > > > > a buffered read and a single channel read at the same time, but l=
ater
> > > > > find out
> > > > > you have a real-world application that needs to do this.
> > > > >=20
> > > > > It looks like it would be possible to implement buffered reads in=
 lots
> > > > > of ways.
> > > > > IIO devices can have more than one buffer per device so we can ad=
d
> > > > > more in the
> > > > > future if we need to. So I would just drop the DMA part of the
> > > > > implementation
> > > > > for now and implement the basic triggered buffer using MCR[NSTART=
] and
> > > > > ECH
> > > > > (End of Chain) interrupt request and just reading data from the I=
CDR
> > > > > registers.
> > > > >=20
> > > > > I would wait to have a real-world application that requires DMA t=
o
> > > > > decide the
> > > > > best way to implement that. There are lots of possibilities, like=
 does
> > > > > it need
> > > > > an external trigger or is continuous mode good enough? Does it ne=
ed to
> > > > > be cyclic
> > > > > (something the IIO subsystem doesn't really support yet) or not. =
Is
> > > > > exact sample
> > > > > timing important or do we just need a big buffer? These questions=
 we
> > > > > can't
> > > > > really answer without a specific application to use it.
> > > >=20
> > > > In the case of this IP, the use cases are in the automotive context=
. The
> > > > system running on the APU is supposed to monitor at high rate (or n=
ot)
> > > > the different channels which can be connected to any device the
> > > > integrator choose to use.
> > > >=20
> > > > For this reason, the driver should be able to support the different
> > > > modes because the integrator of the car computer can decide to moni=
tor
> > > > the devices connected to the different channels differently.
> > > >=20
> > > > Said differently, we need these modes because the capture depends o=
n
> > > > what the integrator decide to connect to the different channels.
> > > ...
> > > > We just know all these use cases exist.
> >=20
> >=20
> > The submitted driver supports the three modes.
> >=20
> > Nuno asked to use the IIO dma engine API.
> >=20
> > However there is few information and examples with the API and I failed=
 to
> > use the devm_iio_dmaengine_buffer_setup_with_handle() function.
> >=20
> > AFAICT, devm_iio_dmaengine_buffer_setup_ext() can not be used because
> > dma_slave_config() is not called, thus the src_addr is not set.
> >=20
> > Is there any example somewhere, documentation or guidance to use the AP=
I?
> >=20
> > Thanks
> >=20
> > =C2=A0 -- Daniel
> >=20
> >=20
>=20
> Unfortunately, not really. Until the last few years, there wasn't really
> any users of these APIs. I added devm_iio_dmaengine_buffer_setup_with_han=
dle()
> for the SPI offloading work I did recently. The only reason it had to be
> added is because we needed to get the DMA handle from a different devicet=
ree
> node from the ADC's node. Since this device has dmas and dma-names in
> the devicetree, then if devm_iio_dmaengine_buffer_setup[_ext]() doesn't w=
ork
> with that, then it might have other problems (assumptions made for a spec=
ific
> use case) than just not calling dma_slave_config().
>=20
> I think maybe Nuno and certainly I are guilty of trying to offer you advi=
ce
> without looking deeply enough into what you already submitted. :-/
>=20

Yes, I pretty much just asked for (at least) some discussion about this and=
 see
if we could use what we already have in IIO.

> I see now that what you are doing with the DMA looks more like other SoC =
ADCs
> (AT91/STM32/AM335x) which is quite different from how the iio_dmaengine_b=
uffer
> stuff works, e.g. cyclic vs. not. So unless you are interested in evolvin=
g

Supporting cyclic should be fairly easy (Paul left it almost prepared for i=
t)
and do I have some patches already. I'm just waiting on having something
accepted on the ADI DMA IP driver (dmaengine) before sending the IIO patche=
s I
already have.

> the iio_dmaengine_buffer code to be more general to handle this case as w=
ell,
> it might not be the right tool for the job currently.

I think for the STM (IIRC) case they "open" coded it because the IIO DMA su=
pport
we had at the time (if any) was more "rudimentary" - (no real zero copy
interface with userspace for example). But yeah, it seems there are some ga=
ps
for your usecase so as David said, you would need to be interested in evolv=
ing
the IIO DMA API to accommodate your needs. Again, if nicely integrated you =
would
gain some nice "improvements" in performance (not having to use the fileio
interface for reading the buffers) for "free".   =20

As for dma_slave_config(), you're right and we have no usecase needing that
setup and TBH, I did not looked or have any idea (atm) on how to do it. Tha=
t
said, I'll be here to help and contribute if you decide to try and follow t=
he
IIO DMA buffer API.

- Nuno S=C3=A1

