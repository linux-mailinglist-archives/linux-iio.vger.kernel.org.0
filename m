Return-Path: <linux-iio+bounces-12933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FC29DFD19
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 10:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D37B281E92
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 09:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D761FA829;
	Mon,  2 Dec 2024 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDAYzJSe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F1E1FA252;
	Mon,  2 Dec 2024 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131641; cv=none; b=ZsRcW2HSC5+S2vbkCZmwiLErfK3bsfzfv4F0/p0CSHY2Anx/Z7498HmIJr3aFuBnIIbe9AA7AQyaL5Qtk3mVA/T+y2f3ZKUM1tup7jGq5UHR4wgSLR2PqksbsyJyMxpUn3Fgc5MdSzm5K2o66lONkhKI/X+243gYyfPNhCIBVp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131641; c=relaxed/simple;
	bh=2HdQ79P7tEMpX4iY+ZlkpDA9tIbAwPcdYuX+GFXpRys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PW/QokP6G1gwo1FMhrF54o6ee+ILEwHL/fW0s4ZrhR8dPlunb9lreb/+S9nGqH0dvKi5x14QnXuGZn5vT9Yit8XRK2G2i1W0WP/3q5sCi1ul0u9MBQe1mjyGu/9HTuCCsyGG8MO2mvqAk075aMRoNQFpXOL8RUa/fpRfxFFsD0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDAYzJSe; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6eeb31b10ceso32591697b3.1;
        Mon, 02 Dec 2024 01:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733131639; x=1733736439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GD/Z51a6lchMwVYFjuhQ3sJcF0heDeQ5X8C8r2Z+aFw=;
        b=QDAYzJSeiBIJkoCUZza9SjrHB4OTAfEIFwkZLog2kqIruKm1TnQFUXuPldJAGBPNti
         dpV0r3l/El5tZLfQT3vdWL7TJsDXn4vN81GyaX2Wjy7udwubOfn537rKzUybuDxF4a7U
         v3E9G8CZL4JSIRzDj2NKuB7UwzmQOiTRrL/pxACPiw5jPxyEH1a/RfEtvOabNMHvIWXv
         425Yl9J0PYqLe8uChhsgg79tIpYeh5LBWaNlnjYC6/xPliiSismuEaVLKJCpoOpISgUx
         1iBek0ra07wTUs7/YDVYM7C02d+wpiB2A/mLhb/q/PRWZTai3hJ43xnW3Cn0Cg0fImlI
         IFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733131639; x=1733736439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GD/Z51a6lchMwVYFjuhQ3sJcF0heDeQ5X8C8r2Z+aFw=;
        b=YrYICI4mPwWsSypLydRwG65oUsD8Cvhf5Rm4eFHQaVB4iQ3O5vnx0Ndt7hhYsgFiGc
         j5zmnHb1yPLnKVTxI+3d624GY+afvjdIypVvxd0OLNkiXM6waGejIf7hu97v3Hk4f/lR
         +baUXoBXFzua5ASn88CjOOabwlZ0iY1JprARw1J41M7Z8Huv7bi9e5Jt7eovP0MFw7Di
         RKWTmlWx5e2RhFj0WcBpcuz8tIAir1KcWdVWAb+Q4M7ARkGyyCcTy+4B4++mqNajljLb
         RXeXjRXHF4/52/Ktdnep1ACzLMv9u8ggL7Cjsn7R77d+u/62kCVarO/7QrVD2FhBnd7R
         aMEw==
X-Forwarded-Encrypted: i=1; AJvYcCUXhC32RxoPyGY6l4l4PXp2M0KK+qpYLzdxvivHzpO5FSumQtcxzSl4R48wnis93F3lC3ggn8M1E8qw@vger.kernel.org, AJvYcCUaGyl3TX4iMRgTmH31wnGFreMVaxua7SXo7iKsSJNerMauJD+JSgiatfu2RiUIj9pievhqkJKJIsjS@vger.kernel.org, AJvYcCUsYcREIu2f//bdCsQwuq5tnceZgP6oIzr0FtzlD7iezMFnH+UOa04dZcuvKIIws34UsvzL9kOXgC+T+/SB@vger.kernel.org
X-Gm-Message-State: AOJu0YwW97aczciXhZHd2KJj/x/gbgyYHP7XHXRQDCVo76iquxB2lXXg
	z1oX/vtQl2uILNWCA4pFSenUMw+c522yD4BMtItxFxcgHKcL6lj895a77rvnoWxwCuNAhW58NaB
	n3fRWuXDPnBT/RhyJnMi2mxSNtH5rdA==
X-Gm-Gg: ASbGncspH82c7LGIj91SWK+dl8C2cYiExvGDPstgt7oEcRU0NyvhyRe+meDmewASVDI
	lJowWmlU5axSui3wo88kakRbIHcsS9P5S6ji64wOlK0ffT1y1EUWEof5YEINMZOkb
X-Google-Smtp-Source: AGHT+IEtxUVrNr5CD0x73k1QiBveCl8DG1RU5r3OTxhTUiUZMGNDcN5DybBQsyn/Z4eeB3jYqCrSdv6PcKXin0vphA0=
X-Received: by 2002:a05:6902:dc9:b0:e30:7c38:668b with SMTP id
 3f1490d57ef6-e395b94b0b1mr17381590276.37.1733131639101; Mon, 02 Dec 2024
 01:27:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126074005.546447-1-tmyu0@nuvoton.com> <20241130202849.13eedb04@jic23-huawei>
 <9174d169-6037-400e-8ec5-6e2653c07a1b@roeck-us.net>
In-Reply-To: <9174d169-6037-400e-8ec5-6e2653c07a1b@roeck-us.net>
From: Ming Yu <a0282524688@gmail.com>
Date: Mon, 2 Dec 2024 17:27:08 +0800
Message-ID: <CAOoeyxVJr8p2RtxKOBGPW8J-DhOQUzHOC-05EDkh0UQ6+Pu_4w@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add Nuvoton NCT7718W IIO driver
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Cameron <jic23@kernel.org>, tmyu0@nuvoton.com, lars@metafoo.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, cmo@melexis.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Guenter,

Thank you for your reply. I will add a patch to the LM90 driver to
support NCT7718W.

Best regards,
Ming

Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2024=E5=B9=B412=E6=9C=881=E6=
=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=884:50=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 11/30/24 12:28, Jonathan Cameron wrote:
> > On Tue, 26 Nov 2024 15:40:03 +0800
> > Ming Yu <a0282524688@gmail.com> wrote:
> >
> >> NCT7718W is an I2C based thermal sensor chip from Nuvoton.
> > Hi Ming Yu,
> >
> > +CC Jean and Guenter,
> >
> > Why an IIO driver rather than a HWMON one?  Superficially this looks li=
ke a hwmon
> > chip.  We do have the means to put a generic driver in IIO and bridge t=
o hwmon, but
> > when a device is very much intended for monitoring of hardware temperat=
ures etc
> > the IIO driver rarely has any purpose and a simpler hwmon only solution=
 makes sense.
> >
> > For temperature sensors IIO normally makes sense if:
> > 1) They are part of a series of devices some of which have more functio=
nality than temp
> > 2) Fast devices where hwmon sysfs interfaces become a bottleneck - note=
 you have to have
> > a usecase for reading them fast, not simply a device that is capable of=
 it.
> > 3) 'Unusual' temperature sensors such as infrared thermometers or very =
high precision
> >     thermocouple interfaces.
> >
> > Any of those apply here?
> >
>
> Also, it looks like this chip is compatible to LM90. It isn't entirely cl=
ear to me
> why this would require a new driver.
>
> Guenter
>
> > Note that hwmon has better threshold and critical temperature handling =
than we can do
> > in IIO and it seems your part has those as well.
> >
> > Thanks,
> >
> > Jonathan
> >
> >
> >>
> >> Ming Yu (2):
> >>    dt-bindings: iio: temperature: Add support for NCT7718W
> >>    iio: temperature: Add Nuvoton NCT7718W support
> >>
> >>   .../iio/temperature/nuvoton,nct7718.yaml      |  44 ++
> >>   MAINTAINERS                                   |   7 +
> >>   drivers/iio/temperature/Kconfig               |  10 +
> >>   drivers/iio/temperature/Makefile              |   1 +
> >>   drivers/iio/temperature/nct7718.c             | 505 ++++++++++++++++=
++
> >>   5 files changed, 567 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/iio/temperature=
/nuvoton,nct7718.yaml
> >>   create mode 100644 drivers/iio/temperature/nct7718.c
> >>
> >
>

