Return-Path: <linux-iio+bounces-12244-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFC29C87E4
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 11:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF2C286B00
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 10:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5531F80CB;
	Thu, 14 Nov 2024 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Evpnd0XO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757191EBFEC;
	Thu, 14 Nov 2024 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580939; cv=none; b=FL4eyAhwEssvwm1R4IbvYcN5P4kZS2ul0HiOy3xLLeOPxfBHx/TihnDOc/GA7zT/7qjjIEB/MeOZgJ9X059NGLtXzNjTHKBZSIPUcVFiHNcgqN1wJhRafrWsmyfEOxqLerXcfPxAXRv05UDPBAPVj8GL07+xnH0CtceIqg1ZjAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580939; c=relaxed/simple;
	bh=PGEcZZfgDPTJH8mmsQtanqM1GY+462KeUc9qNJMT5ko=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YLlclg33NVPMT6ARr6JVz85Gt8KRRstUKwf5T0WpRE1Ee4+mhUQPVHAwTxxTJF+yM4iqLbmtoqW1eEbR4Mc4sN7asg6q1exD/AM2z4SAF+CB5vvTHxM1nFlj2/XetPDjCcxIU0fFtP1TlugVGvs2UneoUPlEwFPNKsoH9lj+udA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Evpnd0XO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43152b79d25so4311035e9.1;
        Thu, 14 Nov 2024 02:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731580936; x=1732185736; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+nPHoBUR45jMLntczbv6mDIM+cn4690kH2G9qI3WE9E=;
        b=Evpnd0XO7UrOkY11BJmZmFE7WFLoCwiwVKiY/qpo3OShHV0mQPJ7QZb36965LGfhdw
         6WIIPRSYZFUU3Lbxy/BqCWUsmgWJGKQRTz53NH+1zB7XruS9APT8Qkoyoc49lUAgNY8p
         /tputXUPzIJFNm17yEEUyU7S7Ms2GlwnuHZMSPalzHrYz+rAHqF23y4L8WRmiz0Z/f5t
         aR1cmIo+dN7F6DeRW4Lymmw2jJ/WHwGaif5vGMkabNzKQRBgeqypdVqBwRFbPLj2+55l
         iRZ7ni80HcmSvV0bK4Sh8hQwHSoIte8kJFeB6+TU5qgGhnbjkD4QFQK2SxekmTTbdGXg
         zSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731580936; x=1732185736;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+nPHoBUR45jMLntczbv6mDIM+cn4690kH2G9qI3WE9E=;
        b=J8r60EKNdC/JgHYXYwnSGJljmkcrS87dhW618A05sIUyZP+nhDV4uMBG/9aV7LfKJE
         W8UQlUv1RiPoowxqyUBdl/jK2T4TA7fgYmCoVJ0o+y6/PhC0p2wkNY8v//3SRUN6/KR5
         shqfuU/QEr7hpWKodd6wbSkS2/WgLbNC8Qt/Jy2EG8tbOlvs3X1oGvooI2xFs8WY1Xej
         6gNTUdMrxQ6+6osOvkOVj4wh5BcdHzZYTcVWu4zdiHbgU7fN3tcLMUyQpxXvmxCKfuta
         Cb+sOZ6TPG07+Uj8ZkEL3ow+UwahreD1tEa4KMySYHh0c/C5n2xSmoO+jFnxW1/FIdHf
         voTA==
X-Forwarded-Encrypted: i=1; AJvYcCW8B5BYwZmVPOPryLC4Ak7ktjOoBqGmCzmlFCNURkHzWGK8Tv9p1Z/23lUs+DTRFvavo02bLkBvDHg=@vger.kernel.org, AJvYcCXSLBufrcTpNnCrPGE4gJyzknZB++SO6KzyYQvGXLAKN8Oz7yQa+Vdwc2AXZoZcfGOCCx7N42azvoJSzwBa@vger.kernel.org
X-Gm-Message-State: AOJu0YwuT2yjMIcbwI5KiIKR0Aq9kBiB4idIqcqC+YhnlMnpW6FWICT8
	Rzi7LVqS9JsAf2MYPmjU5C/et5ymsQAmcXavCKTvvd7PjjjYlum4
X-Google-Smtp-Source: AGHT+IESM8pd5qb983b1HFGZX+rwbhfIuXObXDAfrT6t6+LTqqSbG/iVNWBUoVajq463Gi4v0GY2bw==
X-Received: by 2002:a05:600c:1e0f:b0:42c:acb0:ddbd with SMTP id 5b1f17b1804b1-432d4a98359mr54680785e9.7.1731580935574;
        Thu, 14 Nov 2024 02:42:15 -0800 (PST)
Received: from ?IPv6:2003:f6:ef02:f400:a23c:697f:16fb:11c5? (p200300f6ef02f400a23c697f16fb11c5.dip0.t-ipconnect.de. [2003:f6:ef02:f400:a23c:697f:16fb:11c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab80582sm15877405e9.19.2024.11.14.02.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 02:42:14 -0800 (PST)
Message-ID: <1f315c2f3eea86fe4db48f0168660ab4b0b020f1.camel@gmail.com>
Subject: Re: [PATCH] iio: accel: kx022a: Improve reset delay
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
	 <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, 	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 14 Nov 2024 11:46:38 +0100
In-Reply-To: <f4cf3437-87ea-4d0f-8dab-890d89f85605@gmail.com>
References: <ZzWfXbjaDkFnu_Jg@mva-rohm>
	 <be375e24f74997743743fadf68125e176c23e2df.camel@gmail.com>
	 <f4cf3437-87ea-4d0f-8dab-890d89f85605@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-14 at 11:54 +0200, Matti Vaittinen wrote:
> On 14/11/2024 11:43, Nuno S=C3=A1 wrote:
> > On Thu, 2024-11-14 at 08:57 +0200, Matti Vaittinen wrote:
> > > All the sensors supported by kx022a driver seemed to require some del=
ay
> > > after software reset to be operational again. More or less a random
> > > msleep(1) was added to cause the driver to go to sleep so the sensor =
has
> > > time to become operational again.
> > >=20
> > > Now we have official docuumentation available:
> > > https://fscdn.rohm.com/kionix/en/document/AN010_KX022ACR-Z_Power-on_P=
rocedure_E.pdf
> > > https://fscdn.rohm.com/kionix/en/document/TN027-Power-On-Procedure.pd=
f
> > > https://fscdn.rohm.com/kionix/en/document/AN011_KX134ACR-LBZ_Power-on=
_Procedure_E.pdf
> > >=20
> > > stating the required time is 2 ms.
> > >=20
> > > Due to the nature of the current msleep implementation, the msleep(1)=
 is
> > > likely to be sleeping more than 2ms already - but the value "1" is
> > > misleading in case someone needs to optimize the start time and chang=
e
> > > the msleep to a more accurate delay. Hence it is better for
> > > "documentation" purposes to use value which actually reflects the
> > > specified 2ms wait time.
> > >=20
> > > Change the value of delay after software reset to match the
> > > specifications and add links to the power-on procedure specifications=
.
> > >=20
> > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > > ---
> > > Sorry for not including this to the KX134ACR-LBZ series I sent
> > > yesterday. It was only half an hour after I had sent the KX134ACR-LBZ
> > > support when I was notified about the existence of the KX022ACR-Z
> > > start-up procedure specification... Hence this lone patch to code whi=
ch
> > > I just sent a miscallaneous series for before.
> > >=20
> > > =C2=A0=C2=A0drivers/iio/accel/kionix-kx022a.c | 11 ++++++++---
> > > =C2=A0=C2=A01 file changed, 8 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/ki=
onix-
> > > kx022a.c
> > > index 32387819995d..ccabe2e3b130 100644
> > > --- a/drivers/iio/accel/kionix-kx022a.c
> > > +++ b/drivers/iio/accel/kionix-kx022a.c
> > > @@ -1121,10 +1121,15 @@ static int kx022a_chip_init(struct kx022a_dat=
a
> > > *data)
> > > =C2=A0=C2=A0		return ret;
> > > =C2=A0=20
> > > =C2=A0=C2=A0	/*
> > > -	 * I've seen I2C read failures if we poll too fast after the
> > > sensor
> > > -	 * reset. Slight delay gives I2C block the time to recover.
> > > +	 * According to the power-on procedure documents, there is (at
> > > least)
> > > +	 * 2ms delay required after the software reset. This should be
> > > same
> > > for
> > > +	 * all, KX022ACR-Z, KX132-1211, KX132ACR-LBZ and KX134ACR-LBZ.
> > > +	 *
> > > +	 *
> > > https://fscdn.rohm.com/kionix/en/document/AN010_KX022ACR-Z_Power-on_P=
rocedure_E.pdf
> > > +	 *
> > > https://fscdn.rohm.com/kionix/en/document/TN027-Power-On-Procedure.pd=
f
> > > +	 *
> > > https://fscdn.rohm.com/kionix/en/document/AN011_KX134ACR-LBZ_Power-on=
_Procedure_E.pdf
> > > =C2=A0=C2=A0	 */
> > > -	msleep(1);
> > > +	msleep(2);
> >=20
> > msleep() is not advisable for something lower than 20ms. Maybe take the
> > opportunity and change it to fsleep()?
>=20
> Thank you for the suggestion Nuno. I did originally consider using the=
=20
> usleep_range() since the checkpatch knows to warn about msleep with=20
> small times.
>=20
> However, there should be no rush to power-on the sensor at startup. It=
=20
> usually does not matter if the sleep is 2 or 20 milli seconds, as long=
=20
> as it is long enough. I wonder if interrupting the system with hrtimers=
=20
> for _all_ smallish delays (when the longer delay would not really hurt)

That's why you have ranges of about 20% (I think) in usleep() so you minimi=
ze
hrtimers interrupts.

Other thing is boot time... Sleeping 20ms instead of 2ms is a huge differen=
ce.
Imagine if everyone thought like this for small sleeps :)?

> is a the best design choice. Hence I'd rather keep the msleep when we=20
> don't need to guarantee delay to be short instead of defaulting to=20
> hrtimers or even busy-loop when it is not required.
>=20
> Do you think I am mistaken?
>=20

To me this is more about correctness and do what the docs tell us to do :).
Sure, here you know what you're doing and you don't care if you end up slee=
ping
more than 2ms but that's not always the case and code like this allows for =
legit
mistakes (if someone just copy paste this for example).

Not a big deal anyways...

- Nuno S=C3=A1


