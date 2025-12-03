Return-Path: <linux-iio+bounces-26699-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08607C9FFDC
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 17:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB53E3031CD6
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 16:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028B73128CE;
	Wed,  3 Dec 2025 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkzx+MK9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80003612E4
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779318; cv=none; b=iN5ApvgMc9HO+z1nG9CTz/b8vWQ89KbZI+2S+6vq+xI7cIyv7Woi04QE54kP5TJogMSrxymBaDq0x5DoVu3AykmcZjSuz96GbBWxmqFy+Jc+aAzqfiYe1R7Figf5/B7WaNhpbG6oKLlSMvYiC7hhZ/3NWv3hOBmfQ4GWzozdSgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779318; c=relaxed/simple;
	bh=0IBYtpUvAe4CHpRNet5vi4B8ZC5k6fPjwLC7v4GaCyI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hB8FNOIlWfDYRk1XpypTaqcyBSSMidK/KbYUf/15OYBfeigw25LfVx856pLM4VrN48xgHkW1S7LyiEOsxLrjgFu/gbRnXMUPxP3NEcQ2honXKc34FMjBsDXyyX+0X2zV8aR+6wows1iOhvaylOBoO4jmHzDr1WYmpO+uHZKKa5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkzx+MK9; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37b999d0c81so57691821fa.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 08:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764779311; x=1765384111; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lZEaEf6zCWfznWFsYXIftbCsWzg6prmhaMiElS9+gMQ=;
        b=dkzx+MK9S/+Kkyf/Je2taoEqDDDIXYV/ogxMPTBw2cFCbAaTHD40p29dlImtiVO19d
         Be2vS6cdATmXZaFjQL2xba/lYG9c9g3FOcUSEaXVxKOJmdsx2RkbsOaMePKi2G1dx+EI
         qXJmSPKu9wkKQX0ccbXOjwkQZVSqSmmwFNi2ZH/T1fxB07/HRp+OUzFNVP7suoOoCPqs
         F9cm0wn3NHVKkCgNm3X88F8ebVhci9CdQ6ezeTTBD2kmzvVnP5FLwSceUat3zXigBFfm
         oZMUyX2HqPfBo0wQ5I9cm8RzDYla0WCfm0SNrIjWHsNl1SW169RjNQ43tO6QJwXf3aoN
         uYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779311; x=1765384111;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZEaEf6zCWfznWFsYXIftbCsWzg6prmhaMiElS9+gMQ=;
        b=UFbHvLd/DYvkpxqc7T7nkX88TI9PGXvNdTL96Q05AxNeu7JvjVMOpXoPQGwVQd361e
         c2JKqfdGJ+e9BnqAtnXGq9xpeHeeKGomLhvcZtkdzMukRQ+qf6qyTeHUlVdTEV1rgZpR
         Nx6Ca82kC4FvzAJmqCNTqjhfGQQ/I3CE03gcAV1Scd5jFoBYJm7TwITR0qRS7uHElvwM
         qYAxwYLo+LZpQGJGvLHXHcQZwkxYuc1duPwqh/Is497IZV7NCmwqdw0SHXbP44zk5YUi
         pxu+yG+Jq9Oihj/uZvbSgLx3S7qXrUQf59au3QILzMMStfl9wsdkxQmW1QU95Va/Zu68
         4pKg==
X-Forwarded-Encrypted: i=1; AJvYcCWoLBFJGpAzDwawRI2Mutcb4YLAEYHbpYRHH9pFU2cOm7hMPBd+PGwDnMJU8OobGVV9dHcXVo3Rs/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw59sQfoFwwdBD/B6cViJR+jFE1hFZYd8XgVdgAe9CzbAYwyF9H
	FLFLDPmlLxFJ1hCJXFIA2ard7akv6fgzUyLkd1URiym5pXIPhRZwRLa1
X-Gm-Gg: ASbGncuG7xT7de2r+QatHpuh9mz/iIR9qAxVBQgkoNk/3NgvJAIxoiGRNHPwf0c9oyr
	iIdOcX33JKIuJvYP8ILnWLP2O9QZtnPIGGkoKFMsi6duELFnIsUEtvDkT+uFxQA1TLj2xUdglBI
	ee56OPuo7ntKB8hp0mEqwzpDYLiNlJsgs8HbYU7D7tuBByUdZvSi4yq8ZK1dTUmOJXC497wBgU5
	qpnHgc3FmT3kVtWDRficF+qo7d8ySCyMNbZSyJHSuUvUslfsqRALwpHM+as8c260+eK5r1aH2sy
	ZEJNSAm7MLCRizUhpfrWaqCYpfVaX+hkf/RWBmfvSYbDngioIbZPmqvp5FDRL4a6nNcMMbgItSL
	/jwpYm/pSHoD7XFY4e9DIMHhBcEFPnYVP7xBEPCvF6xTekOY+9mbtBR4OmXX4z5nTJWiCGtmI4i
	D+AHtCYJ67AV0=
X-Google-Smtp-Source: AGHT+IEiTHXvWrMiBrCOdya6kj6SNL6GbPBEpEYmYUwm6jslwyfYIaaBcoq4VYssRbLP5Lmxx3UAyQ==
X-Received: by 2002:a05:651c:20c5:b0:37b:aaf7:eff3 with SMTP id 38308e7fff4ca-37e638e67eamr8385761fa.28.1764779310836;
        Wed, 03 Dec 2025 08:28:30 -0800 (PST)
Received: from [10.5.0.2] ([185.128.9.168])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37d24113084sm42507771fa.46.2025.12.03.08.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 08:28:30 -0800 (PST)
Message-ID: <9bdbdb91ea6b8049658fd6015722c5e2beea183e.camel@gmail.com>
Subject: Re: [PATCH 1/2] iio: dac: adi-axi-dac: Make use of dev_err_probe()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, 
	linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
	 <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Date: Wed, 03 Dec 2025 16:29:10 +0000
In-Reply-To: <07439e95-47f5-434a-9f6d-d7740375a3d6@baylibre.com>
References: 
	<20251203-iio-axi-dac-minor-changes-v1-0-b54650cbeb33@analog.com>
	 <20251203-iio-axi-dac-minor-changes-v1-1-b54650cbeb33@analog.com>
	 <07439e95-47f5-434a-9f6d-d7740375a3d6@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-03 at 10:06 -0600, David Lechner wrote:
> On 12/3/25 9:53 AM, Nuno S=C3=A1 via B4 Relay wrote:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Be consistent and use dev_err_probe() as in all other places in the
> > .probe() path.
> >=20
> > While at it, remove the line break in the version condition. Yes, it
> > goes over the 80 column limit but I do think the line break hurts
> > readability in this case.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/dac/adi-axi-dac.c | 20 +++++++++-----------
> > =C2=A01 file changed, 9 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-da=
c.c
> > index 0d525272a8a8..0c7b62f5357d 100644
> > --- a/drivers/iio/dac/adi-axi-dac.c
> > +++ b/drivers/iio/dac/adi-axi-dac.c
> > @@ -942,17 +942,15 @@ static int axi_dac_probe(struct platform_device *=
pdev)
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > -	if (ADI_AXI_PCORE_VER_MAJOR(ver) !=3D
> > -		ADI_AXI_PCORE_VER_MAJOR(st->info->version)) {
> > -		dev_err(&pdev->dev,
> > -			"Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n=
",
> > -			ADI_AXI_PCORE_VER_MAJOR(st->info->version),
> > -			ADI_AXI_PCORE_VER_MINOR(st->info->version),
> > -			ADI_AXI_PCORE_VER_PATCH(st->info->version),
> > -			ADI_AXI_PCORE_VER_MAJOR(ver),
> > -			ADI_AXI_PCORE_VER_MINOR(ver),
> > -			ADI_AXI_PCORE_VER_PATCH(ver));
> > -		return -ENODEV;
> > +	if (ADI_AXI_PCORE_VER_MAJOR(ver) !=3D ADI_AXI_PCORE_VER_MAJOR(st->inf=
o->version)) {
>=20
> Can drop the braces now.

Yes, I thought about it but then kept the braces as we still have "multiple=
" lines (note checkpatch
does not complain in cases like this).=C2=A0

But I don't feel strong about it so can drop them if you do :)

- Nuno S=C3=A1
>=20
> >=20

