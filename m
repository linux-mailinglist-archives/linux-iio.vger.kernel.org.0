Return-Path: <linux-iio+bounces-2002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B68E983FFBC
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 09:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F31281118
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 08:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6827524D8;
	Mon, 29 Jan 2024 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwCzIkUa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43AA524CE;
	Mon, 29 Jan 2024 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515925; cv=none; b=sbS7X+fP7+Sx1iClXT0+44v8C1U1ms5fS+ttsqACfcy8pDtFbg98q9ENbT9tVQk6SNhIVzOeaO1HPMraGxSZW/UEsVl/2cBJh2oSKQBra2UcpZX/A6HOx5VwlLZpTe4pjII7Q9mmBNljQ0+lZ/vWKnxujTmy7koX1B4dqk4RvwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515925; c=relaxed/simple;
	bh=rohruWC3yMAwC9kgOtefEbUfGSazWdYcX3nFkVdv9Hg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZsyMerit6dsm5BwOazf6ThDSOXQiICrHvtPLS44DBhOxAB8Bj0SBJFDfyvR8o+eXu+aW7T/zafYB50SdAJEU8saMeQZCUFz2kTgiRGtff4RU0CED0OvbYGo7FX1YnBX9GaJxT+Q+hugpSr4Uw6q91anFP+t+52Kf7fLjMQ+qyss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwCzIkUa; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a35e65df2d8so20763366b.0;
        Mon, 29 Jan 2024 00:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706515922; x=1707120722; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rohruWC3yMAwC9kgOtefEbUfGSazWdYcX3nFkVdv9Hg=;
        b=cwCzIkUazQ/iV9HcVzHEJQx06Npj6ymFR+dKH6nQrvjpOgmvlf8rErgRSZtJBAh2gX
         YOejJ6t1Ve/9WCOIK8f3sKOnjLYgP/1z+1NeFPSG2v89I5bFFO2wirbHaxzZTBSCkX0/
         HlAiiC2yIZhzr/Ftpv1FIglFmb7Ocws5uXTWuZgqUJgevf+PDUJbmn6ubRTDRQneJ4F8
         dT6Yd3hgVBGiUN7NKOGahRYSIhb6kUBBk67ArTL0L8MwaGraU6TIyxj7Kz63Xivzvvj4
         xMYGiWOHwbltHw/3cow9GINVtdNH2KlKBV8lFWzmt7CTLfHSP+xZyIZZHutCNN/LM4tW
         WuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706515922; x=1707120722;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rohruWC3yMAwC9kgOtefEbUfGSazWdYcX3nFkVdv9Hg=;
        b=TjoQVgSIboyIkJAW/0wySNp02J6qbnJefSxEeA+cMJLGWztFHpfiZlb4RPpDbv0pLL
         hYEP0BHpQnD+dCY0NvyTrhGL0QW0OhZ0w7vVKgs4Xdwy9uQFMmQ2tVPgG1dSa//X58Gk
         8gCGKfFJXEgMIjmYVAFWky06KLrzb+i620ZyTVhwb0DsU0givU1O95kLVJpr8hNeM7Le
         vFnUJ9ypG9JkXyILWAUaAdcyQP/NahuiC63L2DevnI1qYJ0gAZEtdTX/C+dghTZ552AS
         qN/j28T4aYmKPd+oPv32WaLMMnajMXSV2ZuUHYSkysn2JEdhBCOWImx67TqnGVllOU9D
         Go8w==
X-Gm-Message-State: AOJu0YygUBiorlHOaoUjvLDdHzdTkh0iY1aJ/GPhiWVHumWrySSFj4CA
	m8yNoJ8y2KdmKKf84dQ9vZ52SZKy+FI8oceQA9ksv9ntlagZ4cmD
X-Google-Smtp-Source: AGHT+IGfF2ejOF9KXczeeK0NgMnBGAtbLEpPV9WBhrPuNaXKISiJYowfqHX/a73Byv8XkJQO5hjk0g==
X-Received: by 2002:a17:906:fb8f:b0:a35:695e:4507 with SMTP id lr15-20020a170906fb8f00b00a35695e4507mr2733130ejb.41.1706515921867;
        Mon, 29 Jan 2024 00:12:01 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id my28-20020a1709065a5c00b00a28fa7838a1sm3692928ejc.172.2024.01.29.00.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 00:12:01 -0800 (PST)
Message-ID: <8d23b01963fce3271e61e82cd52362a7fb5bfce1.camel@gmail.com>
Subject: Re: [PATCH v7 9/9] iio: adc: adi-axi-adc: move to backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>, 
 nuno.sa@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Saravana Kannan <saravanak@google.com>
Date: Mon, 29 Jan 2024 09:15:18 +0100
In-Reply-To: <CAMknhBF6QNUf2zX9sQ+09nt2ZapTShwv3-HbmehFgvHnMfNo5Q@mail.gmail.com>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
	 <20240123-iio-backend-v7-9-1bff236b8693@analog.com>
	 <20240127152049.22a8ce74@jic23-huawei>
	 <CAMknhBF6QNUf2zX9sQ+09nt2ZapTShwv3-HbmehFgvHnMfNo5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-01-28 at 15:27 -0600, David Lechner wrote:
> On Sat, Jan 27, 2024 at 9:21=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >=20
> > On Tue, 23 Jan 2024 16:14:30 +0100
> > Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >=20
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > Move to the IIO backend framework. Devices supported by adi-axi-adc n=
ow
> > > register themselves as backend devices.
> > >=20
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > I'm still not getting the %d vs %c change..
> >=20
> > Otherwise LGTM
> >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (cl->info->version > ver) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (*expected_ver > ver) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 dev_err(&pdev->dev,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "IP core version is =
too old. Expected %d.%.2d.%c,
> > > Reported %d.%.2d.%c\n",
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADI_AXI_PCORE_VER_MA=
JOR(cl->info->version),
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADI_AXI_PCORE_VER_MI=
NOR(cl->info->version),
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADI_AXI_PCORE_VER_PA=
TCH(cl->info->version),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "IP core version is =
too old. Expected %d.%.2d.%d,
> > > Reported %d.%.2d.%c\n",
> >=20
> > If it's a valid change fine, but then I'd expect both %c to change.
> > I'd also expect it to be in a separate patch with an explanation of why=
.
>=20
> I was noticing this same pattern in other "AXI" drivers. I think the
> reason for the %c is to match the version format in the devicetree
> compatible string which looks like "1.00.a". So to fix this we should
> probably keep %c and change the value line to
> `ADI_AXI_PCORE_VER_PATCH(cl->info->version) + 'a'` to convert it to
> the appropriate ascii value.
>=20
> (But agree that this should be done in a separate patch/)

Yeah, I'm also realizing that with the axi-dac support I'm working on. In t=
here,
the %c actually does it's job and prints the last character nicely. I will
double check but in this series it might just be that I have a subtle issue=
 in
my hdl design.=C2=A0

So the plan for now is to just drop these changes and keep %c.

- Nuno S=C3=A1 =20



