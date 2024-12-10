Return-Path: <linux-iio+bounces-13297-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 155729EA7D6
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 06:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC6D2847B9
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 05:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EE8227592;
	Tue, 10 Dec 2024 05:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDh7vTsr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA4E4F8A0;
	Tue, 10 Dec 2024 05:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733808500; cv=none; b=BrlbZAM/B+ACg+Pmi2cCbzwIvyu0//fS+IcytqTZvRLXkNy0dJH8xPMCZuzgoYtSrIxe7MraH6C2ie4NYVZEgcTTxit4Em5vFQWPjtjpnSGHgZouuhY3JzfTl3FTfQc4T/ej9ipC9nQeqLQT5Iq7BBgp+pY68ddjW7evOD9u164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733808500; c=relaxed/simple;
	bh=/CHRIAmokQKSuvyPcFbygTSnD2QhhmisB3/mhhq+btA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlW0d+ch3oRX/NY9ddTBlm2ZwaBro24ri7rEdHIexGkEOIDD0fXGgmqI/yWaet8Ypb/VfhtsXjxYrVFNrc7SFU0Q8cr/AIKbSDsYnLsSsIuVQs/kDMBBisJqHi4AMBuExcX7l9POWdhkxlRsTmYiN6xPVsjvfFzJH/Ah4FSmEwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDh7vTsr; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so328647366b.2;
        Mon, 09 Dec 2024 21:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733808497; x=1734413297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iahb3Sc0n+N6aK3kht+20K6wy2Ru9xprYtQWnbXt+98=;
        b=DDh7vTsrUeRKYAnP/MOeL7MLPz6QeMMg9iNIMThUghwJ1ULb2GvNjFGgu4pGsBxq7U
         pyxnN4oRvgGTNjbBd1OiK87Fsrpod0OILuz3tNrQgPQ9zfFbYaY2WXDsXm9jusge0SN2
         Qvhgp9iVv2dGE/ptQ92vjTvxSowHJ70k4ro6BZEzakCFxggs4GJbNP8L6eo5SKjqjcxR
         CtckvYxuyPaTZJQv8UmWdBT2j0SjsymUx0uL6Qulz+KrIYo7Sn+cPYWM34GYyhKRSETT
         8Dxceu3bom1fORsewIagEXGm84y3JW0oOyKuzUAOtNjc+ApwRmLmzPkzoVIgcRCQo9MI
         +6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733808497; x=1734413297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iahb3Sc0n+N6aK3kht+20K6wy2Ru9xprYtQWnbXt+98=;
        b=TJL3fq/7q1dBbQuzh+HEaFUoYbYDcw8fv+vlzjJ9TMp0/HZfBweRorVdlKWcOOpJ08
         WXLIcjVlN/E4V/WIltUQsC3y/iUKerZnQkKoMU/ePQLN29cpM6bSGVUPTISQ2VkC2NX6
         DxUdPLUaSLD6cT8EuQSv+oD84ziQd3m5VTI2N12rzuWFHg196lwvj/bQZyT+R0RmfPsP
         eNQRYBiJMUap9NH2xSiVaZCRGPU4Q2GwuL+Siz94/aIKLuypriziYfAMOG4Bv3aZwA5j
         K6JgYHZSGUAH3sA58dOriOjTfbwTRoVzvBbxunzx9GZ5umIc+Wx51f2iwlZCUyohu9rm
         uxgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/ye2SugO1jgaUicatsHo5gWOxUrUwiMINiIxK63XNWyCP06/2KgqJ+8ZbY3txlchvrA9M8DhqLNl9NbVp@vger.kernel.org, AJvYcCWOPR4lXwX3TN0fJBT/KyLMFtxo0muVlrY1ew5HkAhUC8ZlPQ5EULbalxRnsxz2KEySofWZNqjQbRlw@vger.kernel.org, AJvYcCXTUJLUf49lx/+JFQ6tUZ7gXIGGAjhxrTamkOxb0JpOIJWtdgT1JMkYE7Q+ii+CJibV2AMHotN+ThZf@vger.kernel.org
X-Gm-Message-State: AOJu0YzuIGUemCyE8j5Hs/4b8enrVR3W8GV3BfWDZmvhyswxYEKpOgMu
	BA2Pn3TUpI3E7taTNCLaqc3SW77Y0l9VVl8T0/1Vt2x9je3ADEajWmAwlh6JBq4OmUBsVBT0wIi
	xG38Tlq105vauFRX6F5mzkILh4nI=
X-Gm-Gg: ASbGncvn1nfHKGuwTEFqtC2HbYawdBe7WB15KBBmUm68tUJP+AD1yB8TeDcIR4GGgiL
	GtNRiHN7MTK8lW9ziRLJCZeQkB8v4xyOgN4E=
X-Google-Smtp-Source: AGHT+IEl8ns+cPO0dh6oNxLl3Hy89Vyof1Yn6p4dY5lR+i3YkD30mfiis7m7alp59zPhWqLBAQWw4dOz/Y4XLwVMzMI=
X-Received: by 2002:a17:906:18aa:b0:aa6:8096:2043 with SMTP id
 a640c23a62f3a-aa6809621a9mr587539966b.8.1733808496899; Mon, 09 Dec 2024
 21:28:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203091540.3695650-1-j2anfernee@gmail.com>
 <20241203091540.3695650-3-j2anfernee@gmail.com> <8f5ca298-54ba-4274-a35d-83be868fcfc8@baylibre.com>
 <a4cd4d74-93bc-4c63-a9ee-aa25957b96d9@baylibre.com>
In-Reply-To: <a4cd4d74-93bc-4c63-a9ee-aa25957b96d9@baylibre.com>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Tue, 10 Dec 2024 13:27:40 +0800
Message-ID: <CA+4VgcKjK9N+Y=q5iAz2nJOtcyyuBdkSPvggSd+5KQ49F=+ttg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: add Nuvoton NCT720x ADC driver
To: David Lechner <dlechner@baylibre.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nuno.sa@analog.com, javier.carrasco.cruz@gmail.com, 
	andriy.shevchenko@linux.intel.com, marcelo.schmitt@analog.com, 
	olivier.moysan@foss.st.com, mitrutzceclan@gmail.com, tgamblin@baylibre.com, 
	matteomartelli3@gmail.com, alisadariana@gmail.com, gstols@baylibre.com, 
	thomas.bonnefille@bootlin.com, ramona.nechita@analog.com, 
	mike.looijmans@topic.nl, chanh@os.amperecomputing.com, KWLIU@nuvoton.com, 
	yhyang2@nuvoton.com, openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear David Lechner,

David Lechner <dlechner@baylibre.com> =E6=96=BC 2024=E5=B9=B412=E6=9C=886=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=883:01=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 12/5/24 12:22 PM, David Lechner wrote:
> > On 12/3/24 3:15 AM, Eason Yang wrote:
>
>
> >> +static int nct720x_read_raw(struct iio_dev *indio_dev,
> >> +                        struct iio_chan_spec const *chan,
> >> +                        int *val, int *val2, long mask)
> >> +{
> >> +    int index =3D nct720x_chan_to_index[chan->address];
> >> +    u16 volt;
> >> +    unsigned int value;
> >> +    int err;
> >> +    struct nct720x_chip_info *chip =3D iio_priv(indio_dev);
> >> +
> >> +    if (chan->type !=3D IIO_VOLTAGE)
> >> +            return -EOPNOTSUPP;
> >> +
> >> +    guard(mutex)(&chip->access_lock);
> >> +    switch (mask) {
> >> +    case IIO_CHAN_INFO_RAW:
> >> +            err =3D regmap_read(chip->regmap16, REG_VIN[index], &valu=
e);
> >> +            if (err < 0)
> >> +                    return err;
> >> +            volt =3D (u16)value;
> >> +            *val =3D volt >> 3;
> >
> > It seems strange that this is 13 bits when the chips are 8 and 12 bit.
> >
> >> +            return IIO_VAL_INT;
> >> +    case IIO_CHAN_INFO_SCALE:
> >> +            /* From the datasheet, we have to multiply by 0.0004995 *=
/
> >
> > The scale is the same for both 8 bit and 12 bit chips?
> >
> >> +            *val =3D 0;
> >> +            *val2 =3D 499500;
> >> +            return IIO_VAL_INT_PLUS_NANO;
> >> +    default:
> >> +            return -EINVAL;
> >> +    }
> >> +}
> >> +
>
> Sorry, I got confused. The difference between the two chips is the
> number of channels, not the number of bits. Please ignore these two
> comments.

Yes, The difference between nct7201 and nct7202 is the vin numbers.
And VOLTAGE SENSE DATA FORMAT is
Voltage(V) =3D13bitCountValue * 0.0004995

