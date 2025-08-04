Return-Path: <linux-iio+bounces-22263-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF525B19E2B
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 11:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD73179714
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 09:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57798242D6F;
	Mon,  4 Aug 2025 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGHDWdQK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EDA17D346;
	Mon,  4 Aug 2025 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298225; cv=none; b=BO96iDWv5jZFskBRjk699+8peKnMwi+Z5Sv+PpdtUZe4SpQiMq9RM6eg5SJPb1O0iKEW+NSh0C8LEOog5EC0iD6+RlNhxNknjZDgCjToVbYs5CD9aHOERcdmcIpYdfn8NcTR0CM3hDvyH1LSUBmG/31XH/Pt0ldTrW3VvJJGZGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298225; c=relaxed/simple;
	bh=rAkT4G3+AqyG3hnCZhmDDpt6Y2bVYGkJsG5BnYmLvoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCM3Kz1R2rPsJbVBGi2bSWIWf6NihbID2FHopRNfLOwrY/Ajd/QNZb8uXxDGkIUI5CrfwtUOvp5cXs9BBdlEUcTxD8C8GfYigqnz6zTLdeMl62My1CFbHshNrMn5bmmtjwivdORRYg1b26mEi0I/HgnKhJPM6bRccqvSdiuaTOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGHDWdQK; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61557997574so6255969a12.3;
        Mon, 04 Aug 2025 02:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754298222; x=1754903022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAOqCNKvLaFqqXnTtW0ZhVTY5ltZEpsuEguzQwUg0Fc=;
        b=ZGHDWdQK4SQ9K18EU2+bDahNfRIbdbRZfYDz4maCGGKvtnw1oCrClvKFQMLcgESbmq
         DvSWu2SlgyaRdMlkg/Q47OAY4et1fzw+zd26lgaotVjY0Hk1wr0pfribjyqhAJYIeyCU
         9oGoXu1k0sW/U7cJtexbxNUYoDNmrSoPC8KHYgCJ4juy8LQJ8BYguS2q80+fwGFuB4z5
         YktinGEf12eSsjKIe8HpV0ZmZXIIPGZmPhLkIMBGrDjwLSrqjtDc3Ohw2tmPpUdk359P
         EVt7K7RqhoevuBW0ihbcA+CqcA2I4xXUlIfYF7BPppslRieIkVnPOYFFaUn095YHxE35
         vGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298222; x=1754903022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAOqCNKvLaFqqXnTtW0ZhVTY5ltZEpsuEguzQwUg0Fc=;
        b=T7O0QlusWPNaEceo+18ZtXFxzTrfRD17f17nNgY93WqyriP38RgjpM3A7YSnay6PIt
         a87Po85l4NnuvcMfHGA49tZCuETpjN8V8P8E+Xi7g6ZfRzyf78Hr4KCPgPBbYr5IVq1Z
         wuBnU6b89QNW/NJqYYi3Kj7UQ90N0yB3FTu1xjfwrkTJFajTgktoYLImrfOX7YAK48ik
         +IBuTeytqMeF03oi1sYsaOL/u4v27rRVFlDbZb6BPFNx8N6qlNwflFFYF/uTKrtZhJ2D
         ClDB+qw+Qb1UL2bKxfRTMIEryQdLB3saighZSiwb7VGyVhrR2LmwhDB/zwG1OzE2iL4o
         gD4g==
X-Forwarded-Encrypted: i=1; AJvYcCUoazKf1M53rjZMTOgPNKDr8MfgipyXdDqymm4UVEMp0rM8f7R2mV87T9EEUloDWYUFS0NECBp7XwRXuW6f@vger.kernel.org, AJvYcCWGaT+0f8iIY6dfWQIGNzH+QzvOmnaGa7Ao4MwIqb6jdpdsttuY/28WYHU93gbCJwe4qEcakUdm2ofX@vger.kernel.org, AJvYcCXZNVB4PRmXCrD7DQJ4WQoQXnc2AFyl4r4/Z7fRKvBSDYDiu4RTLG8dMJMNioAGtP8tFCj16iUl7RPy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8k+vHDLlPCtepEmygUxN0thvKBcu54IRfSZt1Wg6PRRFDxgMd
	4jRuIFR44yvHossZ8RqByaoLU+JVYRCXVg09jcKAVXWCHk0YZYvpxTGhSiO5Igf1dVMBHVVVCrJ
	h7X2laFs1zOngqDEea2WGgqXX94XZ3wI=
X-Gm-Gg: ASbGncsW6E4J6Blk0aI2Zca12QjoV9Mcu7SnYjHKUN+xNe30VaRtdfqSFsv4p81k0g5
	i8iSuLJicoRtgSuN9MBw5OTqXksyrMOOM1iRRnVMGNwmEyvDPJhQ8VcZ3KfPWYmhpVpAHXkXHgD
	4kAFTcCNFDuxTnMQLt3va4gdxG/dKj4/iE3Ltr46NpH2TiYWFFG5OPDWetyADznHY9ME9y2uhbs
	6Vgp1tS4w==
X-Google-Smtp-Source: AGHT+IG37smr+oa/pNVI9r4qvVjRd0W8mfZh+jsrAalpKVF0WCTJA1uoS7ro2xYYBcvzgCrgyqbxIEbVxsv8OUxH/Dk=
X-Received: by 2002:a17:907:970a:b0:ae9:8dcb:4dac with SMTP id
 a640c23a62f3a-af940020412mr841012666b.14.1754298221551; Mon, 04 Aug 2025
 02:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802-tlv493d-sensor-v6_16-rc5-v2-0-e867df86ad93@gmail.com>
 <CAHp75Vdc7RB8MG+jYcSxkvD2EY2weZJMnvkbgmqibYGLkcUEBQ@mail.gmail.com> <aJAggwXNFsg0vA5H@dixit>
In-Reply-To: <aJAggwXNFsg0vA5H@dixit>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 Aug 2025 11:03:04 +0200
X-Gm-Features: Ac12FXzk_KoMT-5oqLv84qkTRSiIsruoY69DFy-LdW-WCbMTuYrlTvGQV5c_JWI
Message-ID: <CAHp75VdrJvPSmZHmoffSSqEcNWEidkW_n=B3wCR0_ybhRfBxhA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magnetic Sensor
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 4:53=E2=80=AFAM Dixit Parmar <dixitparmar19@gmail.co=
m> wrote:
> On Sat, Aug 02, 2025 at 10:53:30AM +0200, Andy Shevchenko wrote:
> > On Sat, Aug 2, 2025 at 8:44=E2=80=AFAM Dixit Parmar <dixitparmar19@gmai=
l.com> wrote:

...

> > > The Sensor's I2C register map and mode information is described in pr=
oduct
> > > User Manual[Link].
> >
> > Replace Link here with 1...
> >
> > > Datasheet: https://www.infineon.com/assets/row/public/documents/24/49=
/infineon-tlv493d-a1b6-datasheet-en.pdf
> > > Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic=
-UserManual-v01_03-EN.pdf
> >
> > ...and add space followed by [1] here.
> >
> Orginally it was with [1] only. But I thought I should use known standard=
 tag here
> so came up with link. For my understanding, what is the standard practice=
 for this?

The expected format is

Link: $URL [1]

where $URL is the above URL.

...

> > > Changes in v2:
> > > - Drop regmap implementation in favor of using direct i2c APIs to
> > >   have uniform communication APIs across the driver.
> >
> > This I don't understand. I mean the motivation behind this. Usually
> > direct I2C communication is used to do some initial checks and
> > configuration and rarely for the actuall run-time driver
> > functionality. Otherwise it means that the regmap may be used with a
> > customised read and write methods.
> >
> On addition to what Jonathan explained, reading from sensor also is not a=
ddressable.
> i.e. To read any sensor register the read op must be performed to read st=
arting from 0
> always, without specifying reg address.

Okay, if not yet commented in the code, please add that somewhere in
the top comment of the file.

--=20
With Best Regards,
Andy Shevchenko

