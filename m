Return-Path: <linux-iio+bounces-13079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1A89E3626
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 10:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FE9282583
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 09:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278341991CD;
	Wed,  4 Dec 2024 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msGhm73V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81D19068E;
	Wed,  4 Dec 2024 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733303159; cv=none; b=nJjmfsRPF5rsS+QgsfgUxCqUQ6A9hKV83LKbI8Eilg1PxHa7KncbmMJwAZiVrMI1sVRmAf8tkuzsYzF2HyhLG2CpShHHNNOsQNrquf2clZAdQjVzGHwQm+hpGZbYV02afohTd1oWbjLOYbSI2SHD6PK3SG8Lo2IqQ3dQ4mIjDKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733303159; c=relaxed/simple;
	bh=vKIZAwdN5uQfrZX7GrkPjbxXNa5LNSs5e9h8CEtHsXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuL27DkA54s8ChHSdJVdta++4hP9OGFpbFZBjw+8ve5ha6XMvqGtDn14CRsXvwUbkYvb1NuUJNqbJ64GoUgp9ACZ96pAZqqS81+ISugJLOqb3A2Pwa8SH5QK/u0W5NRTl2s0EzQj5L5AoRiTnlIHF6PV70ihiVA6JuW2O7M8v1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msGhm73V; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9e8522445dso912026066b.1;
        Wed, 04 Dec 2024 01:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733303156; x=1733907956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKIZAwdN5uQfrZX7GrkPjbxXNa5LNSs5e9h8CEtHsXU=;
        b=msGhm73V09XkWAFy+25vm/GbCF8MzehjwpgPkFaNbJKBuI4dIgkV4pkIZx2mDqezEe
         DSKYMQvPK7jKenxFdbX2njGJLVADRRfGNZMoLYgpJ0sRfVn9rFLJiWk48mIKUqwcMkjh
         kevTGLOfmsarRl+D2leWVwYCzNNvt/YsuyLo7/A8HJrRdgUPA1ge75IKVL0Y2uHG5rDz
         HLs12AoLtSUMQLkjHVGgDgzlNDAEIDLq6LtgM/ciwbyhCWiIHBOcHVUe/i0I5opOxNDX
         ZWXdXKTc7JxODDQC0zAyMckwooEvtFRGlmsLaZdbkULtWP3EDfE/r4pFVJ3s6zOLV5qU
         agiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733303156; x=1733907956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKIZAwdN5uQfrZX7GrkPjbxXNa5LNSs5e9h8CEtHsXU=;
        b=YFiGdX2EJIjn3tth+fBq1bWJxMlLTXFZfyMJWTVNEx3b/2sBDPe5T/t1NZCvK+y74c
         tn08SEP3gL2tkWlpclsk5Ygt/rKXfGYMmTdYZCxXMsTSarE1giD9jv6BZGWoeljAVG6X
         GJEI+JlykPtLptqO6iYLu7cCGm/r5R97By9LkJnjt8B7BfLnBUIpPWN4TZUbYMuVCFU7
         Q+DPIPx73lPqnPQw20frYKYcnDUC+Pj0aPD2gXEFnOoEiwtRxyaBFVsZWGGy8tLj2x0Q
         b88mm2IeDOniDh0HtPkPieOmtLYkJZlUuur/5CJvY99byAF9F3A1vXLWPv+RruZtQgBv
         H7Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUN8vPgKEOiqQVxo37R53SLp1kcwQa1Z6SY4Stubu/VA8Bop7tQr7EmvbYDThQUY5rsUdiYhtCFvNsK@vger.kernel.org, AJvYcCVrG/XLsPYsBSGob7m3taFY0hFgQ9oLF6jCWfAjc36AmKUtiC10HmvnE8FHsPIImnXi3FfQoEwCqy04@vger.kernel.org, AJvYcCXgjvnl2QKhn2uGWuf5K5IWxNuLx2Ymjel93rqkXcjIShPqOVh01AAoeNgoQbm5jp40AfMchRVN0pLZCwfd@vger.kernel.org
X-Gm-Message-State: AOJu0YzfUW5JgS9CT4aIaGjbd2FB3YVWoQjT7DLdm5WeC2PSSRcaaDFv
	nRh0StBzVc1NTxyg55/vGAAsQOaVykbHvFfFbMRZe6dvrpMRYoWBiRfN+6ZhykLHe2o1E2qg765
	qVfZ2GUZnOgcQo4ZzivVk7ru6Zdc=
X-Gm-Gg: ASbGncv7ige+BMu4tU8MC2ulQdq0d10+T7A8lP/WQ/dRyXrJY/tODiGHSVqKuQvc9cj
	piNJraGOrb5OXIoUGgmQWGLR6hQ0h3ow=
X-Google-Smtp-Source: AGHT+IG92f6axlzlrszI/yRsXKJ4lU2dyIgsaTErHrtiOWk15Vs+xYPsOPL+ONRvJUq/p+b46vmXcpUdxRklN1c9fPI=
X-Received: by 2002:a17:906:3183:b0:aa5:9303:1b96 with SMTP id
 a640c23a62f3a-aa5f7f11565mr419433766b.50.1733303156206; Wed, 04 Dec 2024
 01:05:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203091540.3695650-1-j2anfernee@gmail.com>
 <20241203091540.3695650-3-j2anfernee@gmail.com> <Z08MkR40fjfW3MXZ@smile.fi.intel.com>
 <CA+4VgcJW=9rtuqr3VZbfA8QxgYAR+KvfAHdf_0xv4XLQtVVQJw@mail.gmail.com> <Z0_aNIrNvLxqcRHv@smile.fi.intel.com>
In-Reply-To: <Z0_aNIrNvLxqcRHv@smile.fi.intel.com>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Wed, 4 Dec 2024 17:05:19 +0800
Message-ID: <CA+4Vgc+HUwbHUWHdCoLVgm7aSMdqOGQZZawU8L8z7hMFop_VxQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: add Nuvoton NCT720x ADC driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com, 
	javier.carrasco.cruz@gmail.com, marcelo.schmitt@analog.com, 
	olivier.moysan@foss.st.com, mitrutzceclan@gmail.com, tgamblin@baylibre.com, 
	matteomartelli3@gmail.com, alisadariana@gmail.com, gstols@baylibre.com, 
	thomas.bonnefille@bootlin.com, ramona.nechita@analog.com, 
	mike.looijmans@topic.nl, chanh@os.amperecomputing.com, KWLIU@nuvoton.com, 
	yhyang2@nuvoton.com, openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Andy Shevchenko,

Andy Shevchenko <andriy.shevchenko@linux.intel.com> =E6=96=BC 2024=E5=B9=B4=
12=E6=9C=884=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8812:27=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On Wed, Dec 04, 2024 at 11:20:20AM +0800, Yu-Hsian Yang wrote:
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> =E6=96=BC 2024=E5=
=B9=B412=E6=9C=883=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=889:50=E5=AF=
=AB=E9=81=93=EF=BC=9A
> > > On Tue, Dec 03, 2024 at 05:15:40PM +0800, Eason Yang wrote:
>
> ...
>
> > > Second, why do you need two regmaps? How debugfs is supposed to work =
on the
> > > registers that are 16-bit if you access them via 8-bit regmap and vic=
e versa?
> > >
> > > Can't you simply use bulk reads/writes when it makes sense and drop 1=
6-bit
> > > regmap completely?
> >
> > Read VIN info can use word read or byte read, and other registers
> > should use byte read.
> >
> > For a reviewer's comment, If the i2c controller allows word read then t=
he
> > right thing is to always use it.
>
> But how does this differ to bulk read of two sequential 8-bit offsets?
> And if there is a difference, shouldn't this be addressed on regmap level=
 for
> all? Like testing for the supported flags and access registers based on t=
he
> controller capability and user request.
>

We would explain why we use two regmaps.
In the beginning, we declare a property read-vin-data-size for user to
select byte read or word read.
After discuss with reviewers, we don't need this property.
So I get rid of this property and take word read vin data first.
We can't use regmap_bulk_read since the vin data is not sequential.

For Nuvoton NCT7201/NCT7202 chip,
Take an example as to Vin1:
The VIN reading supports Byte read (One Byte) and Word read (Two Byte)

For Byte read:
First read Index 00h to get VIN1 MSB, then read Index 0Fh Bit 3~7 to
get VIN1 LSB.
Index 0Fh is a shared LSB for all VINs.

For Word read:
Read Index 00h and get 2 Byte (VIN1 MSB and VIN1 LSB).

> --
> With Best Regards,
> Andy Shevchenko
>
>

