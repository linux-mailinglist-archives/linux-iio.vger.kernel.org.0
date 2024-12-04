Return-Path: <linux-iio+bounces-13069-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2869E30EA
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 02:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B96D3B28021
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 01:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E905134D4;
	Wed,  4 Dec 2024 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0v+auKG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8494C7D;
	Wed,  4 Dec 2024 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733277034; cv=none; b=e3S/0N0FUI8t+U+ESWX+qbzblBpzpRZ/pYSdnuBc1+hkJxiulKn071hXTj+bmNoVda2w2iBGI97jMFIpbnKOce7mRB7xIWZyH4xFQGYZmnFVjMEI0uLsaohHHB0OhCNfu35uO1bRXVanSnrDRqMClsLxIYjG+pRwJfsZMOx4DxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733277034; c=relaxed/simple;
	bh=lR+efRJP8qpHPwJBFvy8mo1CkDs6ptk2s7Q6VJKImog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbYn0p/mQ/sVckKTn4T51nBLn11+Sj+LSfbB4Km1ZZLaNKvFAgv+3Wf/AEeA2wGC+cVzeEMzJDiUQgyZyAHK+XnOwsGsPN+01vt++z9s2htZvMDuube+21U7Wf+SdhBOyd5FECwNehq70Nuvz9jN0TyiV4AZANxZ7boHB8/mbPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0v+auKG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso4239038f8f.1;
        Tue, 03 Dec 2024 17:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733277030; x=1733881830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lN201ByzpfUAhxwhR4UdOa7zJC44kIZT0kSYye3sxJk=;
        b=U0v+auKGJvTFLJcl0bCX9QmhUpot0RgSbkLerRCxBzioCmNyqVcZvwFbaYHk4aryjI
         /XP0iG2dBJq1ttkFTp3Ip8rm+UWcXHT9GeTfzn+e6+n+aQCWlY4FRJuaiqI4y0SltNr/
         wbyvG2yWS1sb8oVptjQJw4EfSFtfinpVDz0Fl6yOFDxDmTYoagD4EYzDrnU3vLfm0rB+
         qyyB5WkTpfHXVuZvmpd5exVVxaHwPIb5jyw0PjVQvKMm3oTcNaGi/UmwdTOpdmn5XqCF
         NIaJbLVgqZvcYny2VpqNJWjN1KKOjBvgIMhicBEfiF5w6/9q+CoP+mTT/cbGZI2QrC6V
         BI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733277030; x=1733881830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lN201ByzpfUAhxwhR4UdOa7zJC44kIZT0kSYye3sxJk=;
        b=MIHFANjl86GCHTKcxfDjhYSW7JMFVstjUrAkHgBv3aCZ1VBiB7rIEyjVPqVpD1Lyrv
         ta3E2qLKDAYx9MWBAGCwGkGMkf+8liBV+F38r93C11ZaITsOIc42fQYiV79HxbevoeZJ
         Kvp9516f9353zmZDynf8fFPUxVltXsbalEzqRqKyySs2msFMOyTQF3ghu55TdzZHhTbE
         Bzr5r50f4oiTSMAynOQbWZAP1nD7o8g3B0zJDQ2UWerJzuslh4fjvPiNwAwLqTtphfXX
         LBiNIH5tLhVaySZXu5jJeZ05rBEetXc+vDSx09Zi3bU/IAQaBQU5MxSL3qyJ4MWXye4b
         Pz8w==
X-Forwarded-Encrypted: i=1; AJvYcCU7Ut8F8ZqOLzMS0Ks6bxFgn5B3uQBzMzq+Rho/mppYjL5/QzNfMh8URXTiWm8qRdv2agnujbZwX0JF@vger.kernel.org, AJvYcCV3yTXEyCw1ZmON83wSO52d/2UiEcGyhuGMxN1ECuB6dchCytAPJy/ptcJWbaoJxVsCbILKI2M8zVRiR22w@vger.kernel.org, AJvYcCW2OXmI/u2H25zn9UKHzQyjfB+maP7xeeTPv/L9TpE1neQ5iwWVG/cnAPsdB19zNURLlkIQu5oY6Kxk@vger.kernel.org
X-Gm-Message-State: AOJu0YzqniauoDWXJFQLUU/gS5iXb4mcctGzUEmnxzCjDw9K//saOogx
	jrF2+kfUZUVtbj14PAfo/vLEkuZgdAJ7uzJf7sGPR5an7PVMzztbT2rxTdPNCkDlnBNvTWxO8Ca
	Ii0dt8sR6e3PucCroJFaMXhWdBVI=
X-Gm-Gg: ASbGncsAz4l7yVcxI0nXM5NfENp4OjMi3LiWx1htaCMyXFOTDDnTq2n4JFiBkc+hxbR
	VXDzi5hv9Lfu6xoyZK5LTepuH34n40eQ=
X-Google-Smtp-Source: AGHT+IHt9Rwm6Nd4suIuWugkJHbvZnTpYJfiKM9I4W2YblEGY0ueUGw7HgR+ojWzcmeKMRQIpKOnzXiSEBUQLBxHqpA=
X-Received: by 2002:a5d:64e4:0:b0:385:f47b:1508 with SMTP id
 ffacd0b85a97d-385fd3f35efmr4593054f8f.35.1733277030274; Tue, 03 Dec 2024
 17:50:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106023916.440767-1-j2anfernee@gmail.com> <20241106023916.440767-3-j2anfernee@gmail.com>
 <fd4db31d-4e55-4f0e-a96d-d193c28fd784@kernel.org> <CA+4VgcJSt-LUNtH6TMpk7om+PbO1aQvmt1WHi-cYMxa8p+Um5A@mail.gmail.com>
 <20241109134538.6f09971d@jic23-huawei>
In-Reply-To: <20241109134538.6f09971d@jic23-huawei>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Wed, 4 Dec 2024 09:49:53 +0800
Message-ID: <CA+4VgcKaL+B1yDG+X7HLGam5T5njgccp9ebCnQJwiv3V5w07ow@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: adc: add Nuvoton NCT720x ADC driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, avifishman70@gmail.com, tmaimon77@gmail.com, 
	tali.perry1@gmail.com, venture@google.com, yuenn@google.com, 
	benjaminfair@google.com, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com, 
	javier.carrasco.cruz@gmail.com, andy@kernel.org, marcelo.schmitt@analog.com, 
	olivier.moysan@foss.st.com, mitrutzceclan@gmail.com, 
	matteomartelli3@gmail.com, alisadariana@gmail.com, joao.goncalves@toradex.com, 
	marius.cristea@microchip.com, mike.looijmans@topic.nl, 
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com, yhyang2@nuvoton.com, 
	openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your comment.

Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2024=E5=B9=B411=E6=9C=889=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=889:45=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, 7 Nov 2024 08:41:21 +0800
> Yu-Hsian Yang <j2anfernee@gmail.com> wrote:
>
> > Dear Krzysztof Kozlowski,
> >
> > Thank you for your response.
> >
> > Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2024=E5=B9=B411=E6=9C=
=886=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:41=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > >
> > > On 06/11/2024 03:39, Eason Yang wrote:
> > > > Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC drive=
r
> > > >
> > > > NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and=
 up to
> > > > 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pin=
s for
> > > > independent alarm signals, and the all threshold values could be se=
t for
> > > > system protection without any timing delay. It also supports reset =
input
> > > > RSTIN# to recover system from a fault condition.
> > > >
> > > > Currently, only single-edge mode conversion and threshold events su=
pport.
> > > >
> > > > Signed-off-by: Eason Yang <j2anfernee@gmail.com>
> > >
> > > ...
> > >
> > > > +
> > > > +static int nct720x_probe(struct i2c_client *client)
> > > > +{
> > > > +     const struct i2c_device_id *id =3D i2c_client_get_device_id(c=
lient);
> > > > +     struct nct720x_chip_info *chip;
> > > > +     struct iio_dev *indio_dev;
> > > > +     int ret;
> > > > +     u32 tmp;
> > > > +
> > > > +     indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*chi=
p));
> > > > +     if (!indio_dev)
> > > > +             return -ENOMEM;
> > > > +     chip =3D iio_priv(indio_dev);
> > > > +
> > > > +     if (client->dev.of_node)
> > > > +             chip->type =3D (enum nct720x_chips)device_get_match_d=
ata(&client->dev);
> > > > +     else
> > > > +             chip->type =3D i2c_match_id(nct720x_id, client)->driv=
er_data;
> > >
> > > I believe there is a I2C wrapper for above.
> > >
> >
> > Got it.
>
> Don't pass an enum value as data.  Pass a pointer to a structure that des=
cribes the particular
> variant.  The 0 value which tends to end up in enums is an error for devi=
ce_get_match_data.
>

I would pass a pointer to the data structure not id to describe the
particular variant.
I would rewrite the code as below,

static const struct nct720x_adc_model_data nct7201_model_data =3D {
.model_name =3D "nct7201",
.channels =3D nct7201_channels,
.num_channels =3D ARRAY_SIZE(nct7201_channels),
.vin_max =3D 8,
};

static const struct nct720x_adc_model_data nct7202_model_data =3D {
.model_name =3D "nct7202",
.channels =3D nct7202_channels,
.num_channels =3D ARRAY_SIZE(nct7202_channels),
.vin_max =3D 12,
};

static const struct i2c_device_id nct720x_id[] =3D {
{ "nct7201", (kernel_ulong_t)&nct7201_model_data },
{ "nct7202", (kernel_ulong_t)&nct7202_model_data },
{ }
};
MODULE_DEVICE_TABLE(i2c, nct720x_id);

static const struct of_device_id nct720x_of_match[] =3D {
{
.compatible =3D "nuvoton,nct7201",
.data =3D &nct7201_model_data,
},
{
.compatible =3D "nuvoton,nct7202",
.data =3D &nct7202_model_data,
},
{ }
};
MODULE_DEVICE_TABLE(of, nct720x_of_match);

> >
> > > > +
> > > > +     chip->vin_max =3D (chip->type =3D=3D nct7201) ? NCT7201_VIN_M=
AX : NCT7202_VIN_MAX;
> > > > +
> > > > +     ret =3D of_property_read_u32(client->dev.of_node, "read-vin-d=
ata-size", &tmp);
> > > > +     if (ret < 0) {
> > > > +             pr_err("read-vin-data-size property not found\n");
> > >
> > > Please use dev_xxx in your driver code.
> >
> > Got it.
> >
> > >
> > >
> > > Best regards,
> > > Krzysztof
> > >
>

