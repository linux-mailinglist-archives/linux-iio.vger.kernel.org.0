Return-Path: <linux-iio+bounces-5221-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525A28CD651
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 16:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB642858F6
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 14:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43526FC5;
	Thu, 23 May 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgIvIW6s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523086FB6;
	Thu, 23 May 2024 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476283; cv=none; b=fdwbFFDnAjnRbbpd6BM16iCiYvSZd858/4+K6kt+/7Umvvr0TF1BB94Y4voCCbh3pi5igQQllPeU+2+IIfBlIFxoUN3HiYJxTk4MxWaeNc0SWIdBO+dtKOWAUpjmwC/R3gWegHBlF4Zgz9BJDZzSTWCqE53KTkqw6TUQirJnbK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476283; c=relaxed/simple;
	bh=hbGfJo+AxTeveTHDOq5LN+3/vr7a/rMlMCqJix/mLqM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QK+O31QuNTNM480+KdvfbkSfZy2YbtrhL+/FRvfEiM3sefiWrCAe2r2H02txecaQE37O4I5KENjQJI25H+nLegClpB0u1CNqrfpSRZWPy3cc9Atbw0BIG9KcP23RlF1LFjFXAmsSEE6z7D+gmKoLhUIoepe7lj1XnHWCMYI4+AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgIvIW6s; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4202cea9a2fso19927225e9.3;
        Thu, 23 May 2024 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716476281; x=1717081081; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hbGfJo+AxTeveTHDOq5LN+3/vr7a/rMlMCqJix/mLqM=;
        b=mgIvIW6sE3v0W2+y8d/r7yb6qogg/0K0I11WuxaxURM7U/hkh+koo2pSQi04uGFZui
         XK4ZuPFlqnlz12a9ZLpkmuvSwm82GbFZuNgzr02MNS0cqJyBptWDT+u2+MKtWfm36svT
         vAYRBzbJ5P8wpF96PmipsSp6fBGSFwg3WzF40jafCjT7zqPUisvFJrpUoOYNh8FJ/PIU
         nYLdjD3WJhbLejmZyWPtuIbPu4vh71j4pwM/eDGNZ5/kfChV/O59UjYMom3xdYZudBmn
         V6PZHkCfJHmYiWH3MK+OqN5ETM6Ds8KPLOHi5WMqyiZUOiIiWD8Cwab7EBWoU1NFnONe
         quMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716476281; x=1717081081;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hbGfJo+AxTeveTHDOq5LN+3/vr7a/rMlMCqJix/mLqM=;
        b=P+PAHSlNCTpPSjiqmu1Xodhlm+/wqMNq42x2IO9nWeUhXlOLyPcYb1Lo3EAH/VLU49
         Jhby7HfGvHvIhDEqxqWuX/RkqoA8o1FTwiqloaWNvs82PMMaH6Dm3KT8lz0/j2jliTF4
         a+TiKAj+YCI0n/j8EbewpEYicbN6iYfgYNSm7LMdDnMkxOrGqGZGfIobWTZG1wkfWTnj
         sbZqQUtgty6No1O30+fsMx+H2zRNmUA1v1URPPfhLFxy11kS2LrIOQZuJS2ssx2Ae+rq
         xxV+sfe0nCV8yZvEj3/3eM+TpJTizRkZAgEVEt0qdaJ2WwPZKAGx9CH5DL0pK/LflPiA
         7F/w==
X-Forwarded-Encrypted: i=1; AJvYcCWOhXJKM+EOOJbDlQjWocy7qXoojxZrFWrsU31Dped1mAczuQXFW3UMcKc3sfmpnMs/v4Up3Zrvqs7wKojfeJ4Na4cR9so5BXvWL5ro+uasqpVGKOeWZB6sTEg/TIeGuPrOR0rLgSihbiv6LDB5hqQ1ccFQE0gic28IgoSY9rcn0wQ90kFW12m+8YbvF5U+TuoKS5S5NJuvsh6o0fgW0A==
X-Gm-Message-State: AOJu0Yx0hjh8COieoCYw4VdWSER95ceaqBvhLK548mcGA2FifZZty/05
	a3nGMDf9uW8j1NpuSpABBdAxztKj3ivBFSOObhuDyplcUCx5fVUK
X-Google-Smtp-Source: AGHT+IHcNoZ+PjSWCGtQUxuRZ6AN3mR7IHGxx1yMluFYcyeFb3Qnhu+znDHU5Q464mC3yopJMlZKJQ==
X-Received: by 2002:a05:600c:2047:b0:418:c2af:ab83 with SMTP id 5b1f17b1804b1-420fd363ab2mr46736345e9.36.1716476280511;
        Thu, 23 May 2024 07:58:00 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f598d7sm27242815e9.23.2024.05.23.07.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 07:58:00 -0700 (PDT)
Message-ID: <35de37c08331a8384aa9ebde3a9be5fec6fc418e.camel@gmail.com>
Subject: Re: [PATCH RFC v2 1/8] spi: dt-bindings: spi-peripheral-props: add
 spi-offloads property
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Conor Dooley <conor@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,  Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org
Date: Thu, 23 May 2024 16:57:54 +0200
In-Reply-To: <59df2cc3-5a62-45be-a0aa-5bbff13c2ae4@baylibre.com>
References: 
	<20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
	 <20240510-dlech-mainline-spi-engine-offload-2-v2-1-8707a870c435@baylibre.com>
	 <20240513-headsman-hacking-d51fcc811695@spud>
	 <CAMknhBE5XJzhdJ=PQUXiubw_CiCLcn1jihiscnQZUzDWMASPKw@mail.gmail.com>
	 <20240514-aspire-ascension-449556da3615@spud>
	 <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
	 <20240516-rudder-reburial-dcf300504c0a@spud>
	 <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
	 <20240519-abreast-haziness-096a57ef57d3@spud>
	 <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
	 <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
	 <59df2cc3-5a62-45be-a0aa-5bbff13c2ae4@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-23 at 09:28 -0500, David Lechner wrote:
> On 5/22/24 1:24 PM, Conor Dooley wrote:
> > On Tue, May 21, 2024 at 09:54:39AM -0500, David Lechner wrote:
> > > On Sun, May 19, 2024 at 7:53=E2=80=AFAM Conor Dooley <conor@kernel.or=
g> wrote:
> > > >=20
> > > > On Fri, May 17, 2024 at 11:51:58AM -0500, David Lechner wrote:
> > > > > On Thu, May 16, 2024 at 4:32=E2=80=AFPM Conor Dooley <conor@kerne=
l.org> wrote:
> > > > > > On Tue, May 14, 2024 at 05:56:47PM -0500, David Lechner wrote:
> > > >=20
>=20

...

>=20
> controller:
> #spi-offload-cells =3D <2>: /* 1st cell =3D offload instance
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * 2nd cell =3D trigger provider */
>=20

What about things like DMA? I'm mentioning it a lot because it's way more c=
omplex
having it on the controller (from a SW perspective). But from an HW point o=
f view,
it's always very similar (if not the same) as your case A.

- Nuno S=C3=A1
>=20

