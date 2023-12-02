Return-Path: <linux-iio+bounces-552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F07DC801DB2
	for <lists+linux-iio@lfdr.de>; Sat,  2 Dec 2023 17:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA9B1C2093A
	for <lists+linux-iio@lfdr.de>; Sat,  2 Dec 2023 16:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAFD1C695;
	Sat,  2 Dec 2023 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0XjPTP4p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFE3A2
	for <linux-iio@vger.kernel.org>; Sat,  2 Dec 2023 08:17:05 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c9f84533beso1462671fa.1
        for <linux-iio@vger.kernel.org>; Sat, 02 Dec 2023 08:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701533824; x=1702138624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzfMNFR2RcSekMCUUDcS+18RzZyh3kK2Ah+a6XkE5FM=;
        b=0XjPTP4pd6+7E/av628bNSI4Gfb2LQZynyKQLfSrqt17roQJi+y1LY3Xe1+IEjtQ/U
         FEkEB7yyRDivxWzjBn61i9m5/giGeDJYGhkHx75RiUPFmrDOqNrmK6v6Y3/nsAFv8BQA
         5CnuXwm+Lkvddw05W2xRK23sMX4o/3WnpVtBFpEmSIyAe+qn6y4HSx9rU13WE+sB5tu/
         Ij8p3Mxu/aU54DNz/fL5G6WcRfwhO6HGaOsh+w+lBYECmskTtlhEE51P/DGiSeNZBcTD
         k884/3st1xlA/0yAgYc3SIMnJqaDLxZt6sS63rahIOLf4LIICIxJ+7gF0kprf2hOzYME
         YvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701533824; x=1702138624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzfMNFR2RcSekMCUUDcS+18RzZyh3kK2Ah+a6XkE5FM=;
        b=nKTKmbBdwh2Yp5pJFTvnVzvQeqsWtCH8jg4u0HSjOzVKbvM7nFjESC5RMyxZrJ2cme
         VbHZXTwPBWrTwB76NE0e2FoTfbd+ASqUHgYVf0/a1XTGYOUbEc5jaJGTq+PkZIsytlK9
         +4a8x3HUUiQyaA9KQzhb2MIwYDTmOU+bY0k/boR8xJi3thTwdsE1iL8zMx/gXhr1W5aq
         p2cLZQHprySKdRf5E3L0odVKmF8CRi6fCqSiW4bM3ZxrTMZ0d98COfNMZJtCHCSnzDWx
         +rKTGnq1z37rcOWm9jr+aIg97tktdXmyxqyOnzLbCjQIumEz3aeccSp3otgPLoJjmfIZ
         iYHQ==
X-Gm-Message-State: AOJu0YzeZ9jMtcREh45KpypwBXjlzRnjQjuzvAcL+YqL2Ys51HHqmHG+
	hp12BvgObUB5+n3prX9LzLwKBzHq9P7jKrJwozafkg==
X-Google-Smtp-Source: AGHT+IHGc/Y0RKfa/ls3Hcoi5FIbQXzLBBlP/80GqZ+xoMdLm0vsByPjMl928t2d7+fiT/tfo40b9KZE0xsq8VSY/Cc=
X-Received: by 2002:a2e:8ed4:0:b0:2c9:d874:6eec with SMTP id
 e20-20020a2e8ed4000000b002c9d8746eecmr1736546ljl.73.1701533823967; Sat, 02
 Dec 2023 08:17:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
 <CAMknhBH0pF_+z_JqWGscELBmAEDyxLAtgQ-j3=6P2MeFXnzhWQ@mail.gmail.com>
 <CAMknhBEcEJ01nO0p5_vy4jVBVTL_rhEk+pvBpXdMtaDurc-05A@mail.gmail.com> <369a72dd34c0bc457620b88594a975d96aa85a22.camel@gmail.com>
In-Reply-To: <369a72dd34c0bc457620b88594a975d96aa85a22.camel@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 2 Dec 2023 10:16:52 -0600
Message-ID: <CAMknhBEg+cFrm9kQh1G+8nxGPCFsBaca3rnLEnXZ1h=XDS1aeQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] iio: add new backend framework
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
	Olivier MOYSAN <olivier.moysan@foss.st.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 2, 2023 at 3:37=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com>=
 wrote:
>
> On Fri, 2023-12-01 at 21:53 -0600, David Lechner wrote:
> > On Thu, Nov 30, 2023 at 5:54=E2=80=AFPM David Lechner <dlechner@baylibr=
e.com> wrote:
> > >
> > > On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> > > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > This is a Framework to handle complex IIO aggregate devices.
> > > >
> > > > The typical architecture is to have one device as the frontend devi=
ce which
> > > > can be "linked" against one or multiple backend devices. All the II=
O and
> > > > userspace interface is expected to be registers/managed by the fron=
tend
> > > > device which will callback into the backends when needed (to get/se=
t
> > > > some configuration that it does not directly control).
> > > >
> > > > The basic framework interface is pretty simple:
> > > >  - Backends should register themselves with @devm_iio_backend_regis=
ter()
> > > >  - Frontend devices should get backends with @devm_iio_backend_get(=
)
> > > >
> > > > (typical provider - consumer stuff)
> > > >
> > >
> > > The "typical provider - consumer stuff" seems pretty straight forward
> > > for finding and connecting two different devices, but the definition
> > > of what is a frontend and what is a backend seems a bit nebulous. It
> > > would be nice to seem some example devicetree to be able to get a
> > > better picture of how this will be used in practices (links to the th=
e
> > > hardware docs for those examples would be nice too).
> > >
> >
> > Fulfilling my own request here...
> >
> > Since AD9467 is being use as the example first user of the IIO offload =
framework
> > I did a deep dive into how it is actually being used. It looks like thi=
s:
> >
>
> This is not an offload framework... I think somehow you're connecting thi=
s to the
> spi_engine offload and these are two completely different things. Maybe t=
hey can
> intersect at some point but as of now, I don't see any benefit in doing i=
t. The goal
> of this patchseries is to have a simple and generic framework so we can c=
onnect IIO
> devices (frontends) to a backend device having kind of an IIO aggregate d=
evice so to
> say. Moreover, we just want to have the ad9467 driver in the same state i=
t was before
> to keep things simple. I'm already fixing some things but I don't want ex=
tend that
> too much as the primary goal is to have the framework in. Cleanups can co=
me
> afterwards.
>
> That said, is fine to have this kind of discussion but I honestly think y=
ou're over
> engineering the whole thing. Maybe you're already too ahead of me :), but=
 where we
> stand right now, I don't see any reason for anything so complicated as th=
e below.
> Also note this should be simple and generic. As I already said, this is n=
ot supposed
> to be an ADI only thing and STM also wants to make use of this infrastruc=
ture. But
> see below some of my comments on why I think it's too much...

This is a very fair point. I do have a tendency to overthink things. :-)

At the very least, being able to see the schematic of how it all fits
together filled in the holes of my understanding and now everything
you are doing in this series makes sense to me. And I totally agree
with keeping it simpler is better.

