Return-Path: <linux-iio+bounces-9914-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DFC989C9E
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 10:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F5D1F21A8A
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 08:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BEB17B421;
	Mon, 30 Sep 2024 08:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/XoQkHx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724A417B402;
	Mon, 30 Sep 2024 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684413; cv=none; b=ZPCsXir/jzVZzU82vDsJKPBEpJ+OukfcAl/otiH2rf0C5+JJz9AGcfxJHI1jAQg8GzQQ8yuRIvbTjad4YulbDfEoJLSVXN02xh6nBmDuEgJtnRJxvHD0fp7nqKsMRe7J3BKEuAn+Wh3elBBehYJyrXIFgzEkn4ZBW7yo/E9kD4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684413; c=relaxed/simple;
	bh=/j+e9G06TpvOBf6/dTyeNzSmpW7RbKJxFq0O98eQpDo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NLk0iOYDTbsWfrMOATX43BZO8kDs0OXSJiSZ1D0thqHHfVieInmWE7mCcmR5l0ZO3P+nkfzmzBrxpc/p2m/Y1ny0Jpfv3Heqpktusj+LJ3BwaB1iK4q4apUt+Gfnf6UnnWiaukJeY3ZtHqHo9/nhVpKxJQRcWa5onuXSBc9X+eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/XoQkHx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cbc22e1c4so29299345e9.2;
        Mon, 30 Sep 2024 01:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727684410; x=1728289210; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/j+e9G06TpvOBf6/dTyeNzSmpW7RbKJxFq0O98eQpDo=;
        b=R/XoQkHxvLazuyACYvgVsuJ2Ro7mTIvqoRKbociQVYFZy4XycJBFE2nl6slpjivEZS
         6MFFdB6VntzrD9khaPrdmpxCB9CQfoArcWQgfal0IfIdXuKhddA/8UlqrNdWSR0qDg00
         pqvgPg0YujJjfIxESoDYnWfi+vd1LNyiNnVysR/NTRygVo0LqqL38FQ4JJWMQLanfITP
         Z5myvy6q/YLlhCzK0IKF6FXNalX/0cwv2xaUbizbHWu60D6i7E74NLAQQ6fhB9TrBU3x
         sI396BKphccVc3rXUW/oDjURV5mEamnB5Vh09sotiS4RtI7n/JuqWIxW1idxbAX5/PsE
         yMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727684410; x=1728289210;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/j+e9G06TpvOBf6/dTyeNzSmpW7RbKJxFq0O98eQpDo=;
        b=wr+7dyiC8yInCmB2fl0UX9WvAkVr3D52W6nwOra/8W8u0RTxcD3ww6qiyQB9eVws2a
         uKNCCaDeR56bo8UJtbnulP+BI1Q6fAjbdtJlu4jwxSQ2pCiILR/IOUY3Jfa0nqVfgxsy
         Et4MrgHTeH1/FLwxbC79l53VA2SltHOZ3RBF5Zzq1YMnf2+VleWT2JidPHQapm8rtWzA
         FEBF55eQxkvsOdLDnP84NGaZCqNHABI2z4fhyAoinqnAwNIOtbfH3SUMXn9miNUqxlQg
         4P3WxJls7jxLJWJoKgWL6/z+c33ojRUZft1ryw6qX2nBIl5JFpoZvG9Q9bNQ8WAQNzGi
         hlSA==
X-Forwarded-Encrypted: i=1; AJvYcCU2HdqqI8jQRkh0k2g+BrCBSRKgjChOAbNrGOWQwVA9qbA/8P9fzr1w9dgmW6ekCBcXjH5rBHQsU/HZ@vger.kernel.org, AJvYcCUylUmpZ3EPIJkEqjmY2/W2rWFXJM3MrAfIZepITVev1QqpwL2sStee4RjEsf77Trs2hHmJpwX6LfRa@vger.kernel.org, AJvYcCWZj9C/W7G0SoriSj37lXmvXOaxeLwzdcKmHucBRsSXV+y9BRvvpWZxae6BKpuJyJtlD4p1ljPJR6wGO/cZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwCLkOMg1hvBvJMZeshPqYldbfP+pjgybFk5Ky1HK4251meVc13
	xoeobKVtPJb6Tl202aeEwkTIRsx6uGuryR0pcukOKcCp4inW4wdu
X-Google-Smtp-Source: AGHT+IEmcJ25tTePsKjcDujU1i2eWACH9Ke0Q/0TgZPgGIaOn/G86UxauRQT7toG4eT/b794avl+YA==
X-Received: by 2002:a05:600c:3b87:b0:42c:a7cc:cb6d with SMTP id 5b1f17b1804b1-42f5840a093mr84360605e9.1.1727684409493;
        Mon, 30 Sep 2024 01:20:09 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef02:2700:7684:3ff1:6790:3866? (p200300f6ef02270076843ff167903866.dip0.t-ipconnect.de. [2003:f6:ef02:2700:7684:3ff1:6790:3866])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57e1392fsm96902745e9.31.2024.09.30.01.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 01:20:09 -0700 (PDT)
Message-ID: <7db42c1b080ea98c0b02ad91ffb1436c9b9218ff.camel@gmail.com>
Subject: Re: [PATCH v3 04/10] dt-bindings: iio: dac: ad3552r: add io-backend
 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa	 <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan	 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dlechner@baylibre.com
Date: Mon, 30 Sep 2024 10:24:21 +0200
In-Reply-To: <69e61fb9-b162-4574-927a-170b45fb3394@kernel.org>
References: 
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-4-a17b9b3d05d9@baylibre.com>
	 <gojq6ardhvt6vcs2kawdhdn2cj6qbpzp4p5mjjgwsypuatm5eo@3u6k4q7le46s>
	 <418a8a9b-3bcf-4b8f-92a0-619a3bf26ab5@baylibre.com>
	 <e8af0f3f-a09c-42d7-b8ca-dd633539af73@kernel.org>
	 <0279203b6cd9f1312d9c03654c262c04ac12fbd9.camel@gmail.com>
	 <fa27dc74-7b1f-4ef5-81dc-cc434da4ff89@kernel.org>
	 <c721861809c17776c0fe89ead331b6e2e6b9d4b4.camel@gmail.com>
	 <28834db1-3e9e-47f4-b00e-a548589d77e9@kernel.org>
	 <20240929115919.0318034c@jic23-huawei>
	 <ae4cfdfb9880e0a833c105fcb9e9442ef04f461b.camel@gmail.com>
	 <69e61fb9-b162-4574-927a-170b45fb3394@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-30 at 09:31 +0200, Krzysztof Kozlowski wrote:
> On 30/09/2024 09:20, Nuno S=C3=A1 wrote:
> > > > > >=20
> > > > > > You described the driver, so how does it matter? Driver can cal=
l
> > > > > > get_backend_from_parent(), right? Or
> > > > > > get_backend_from_fwnode(parent)?=C2=A0=20
> > > > >=20
> > > > > Well yes, just stating what the framework (also in terms of bindi=
ngs)
> > > > > is
> > > > > expecting. Of course that on the driver side we can paper around =
it
> > > > > the
> > > > > way we
> > > > > want. But my main point was that we can only paper around it if w=
e use
> > > > > code that
> > > > > is meant not to be used.
> > > > >=20
> > > > > And, FWIW, I was (trying) replying to your comment
> > > > >=20
> > > > > "You can take it from the child-parent relationship"
> > > > >=20
> > > > > Again, we can only do that by introducing new code or use code th=
at's
> > > > > not
> > > > > meant
> > > > > to be used. The way we're supposed to reference backends is by
> > > > > explicitly
> > > > > using
> > > > > the proper FW property.
> > > > >=20
> > > > > Put it in another way and a completely hypothetical case. If we h=
ave a
> > > > > spi
> > > > > controller which happens to export some clock and one of it's
> > > > > peripherals
> > > > > ends
> > > > > up using that clock, wouldn't we still use 'clocks' to reference =
that
> > > > > clock?=C2=A0=20
> > > >=20
> > > > I asked how coupled are these devices. Never got the answer and you=
 are
> > > > reflecting with question. Depends. Please do not create hypothetica=
l,
> > > > generic scenarios and then apply them to your one particular opposi=
te
> > > > case.
> > >=20
> > > I'll throw a possible clarifying question in here.=C2=A0 Could we use=
 this
> > > device with a multimaster SPI setup such that the control is on a
> > > conventional
> > > SPI controller (maybe a qspi capable one), and the data plane only go=
es
> > > through
> > > a specific purpose backend?=C2=A0 If so, then they are not tightly co=
upled and
> > > the reference makes sense.=C2=A0 Putting it another way, the differen=
ce between
> > > this case and all the prior iio-backend bindings is the control and
> > > dataplanes
> > > use the same pins.=C2=A0 Does that have to be the case at the host en=
d?=C2=A0 If it
> > > does,
> > > then the reference isn't strictly needed and this becomes a bit like
> > > registering a single device on an spi bus or an i2c bus depending on =
who
> > > does the registering (which is down to the parent in DT).
> > >=20
> >=20
> > So, we currently have two drivers (with a new one being added in this
> > series)
> > for the same device:
> >=20
> > 1) A SPI one tied to a typical spi controller. This is the "low speed"
> > implementation and does not use backends;
> > 2) The new platform device that is connected like this to the backend.
>=20
> Drivers, platform devices are Linux specifics. These were not our
> questions here. You are responding with description matching current
> Linux code.
>=20
> >=20
> > So yes, my understanding (but Angelo should know better :)) is that the=
y are
> > tightly coupled. Putting it in another way, the new platform device is =
very
> > much
> > specific to this parent (and yeah, this is a very special usecase where
> > control
>=20
> Again, Linux stuff.
>=20
> > and data planes are controlled by the IIO backend) and should not exist=
 with
> > it.
>=20
> I pointed this issue already in this thread. You keep describing
> drivers, so of course they will be coupled as much as you write them.
>=20

Well, because this is how it's being used and it's easy for me to fall into=
 the
implementation but ok, I get your point. Directly then replying in terms of=
 HW,
this could be used in a way where we have a typical spi controller handling=
 the
device and the data plane only going through the backend. In fact, the HW f=
olks
first tried the SPI ENGINE IP (which is a typically controller) but could n=
ot
get the maximum sampling rate out of the device so they came up with this c=
ustom
design. So, in theory is possible, in practise will likely never happen but=
 I
guess that does not matter for the bindings?

- Nuno S=C3=A1

