Return-Path: <linux-iio+bounces-586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13B2803772
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 15:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 593C0B20B85
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 14:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C464E28364;
	Mon,  4 Dec 2023 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mP1NKR8W"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8678F288D7;
	Mon,  4 Dec 2023 14:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD35C433C7;
	Mon,  4 Dec 2023 14:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701376;
	bh=+rfhQvthjBio9vKPuOuZeZLKHbgV1eAS2Q4KP5aiGdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mP1NKR8WcwA+hcZQ6uKxxCQEnsh3wuXEAjUr52iqagkAxstbdi8MnYIviiDX0Y+tN
	 FAPnWwLPDVJE6/0x0dRz9DUEl35GqLq3/BvMWTQVFeh5qzzKYvLbxBF1R3JMlUe3PU
	 2nsB5bDfcVu21DcHS+eV/VKlsW8o0uV1iBc/aGRlav7o8NTlluBw0MSsCZ74fa77KM
	 jKEZtDLPH05I7H0Ftn58M5hS95djYVZyJDt2jHdD9ys8e/JZKNf9iruGYWzWGKItg2
	 UwGjVHVbq8TkFWccMc1HBnxtFvIjF8+yWhL4VHfjn7w2d/XNpAv+2Uq6QSFtYlBOZZ
	 AQ5/hYhWUpxiQ==
Date: Mon, 4 Dec 2023 14:49:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, Olivier MOYSAN <olivier.moysan@foss.st.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 00/12] iio: add new backend framework
Message-ID: <20231204144925.4fe9922f@jic23-huawei>
In-Reply-To: <CAMknhBEg+cFrm9kQh1G+8nxGPCFsBaca3rnLEnXZ1h=XDS1aeQ@mail.gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
	<CAMknhBH0pF_+z_JqWGscELBmAEDyxLAtgQ-j3=6P2MeFXnzhWQ@mail.gmail.com>
	<CAMknhBEcEJ01nO0p5_vy4jVBVTL_rhEk+pvBpXdMtaDurc-05A@mail.gmail.com>
	<369a72dd34c0bc457620b88594a975d96aa85a22.camel@gmail.com>
	<CAMknhBEg+cFrm9kQh1G+8nxGPCFsBaca3rnLEnXZ1h=XDS1aeQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 2 Dec 2023 10:16:52 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On Sat, Dec 2, 2023 at 3:37=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
> >
> > On Fri, 2023-12-01 at 21:53 -0600, David Lechner wrote: =20
> > > On Thu, Nov 30, 2023 at 5:54=E2=80=AFPM David Lechner <dlechner@bayli=
bre.com> wrote: =20
> > > >
> > > > On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> > > > <devnull+nuno.sa.analog.com@kernel.org> wrote: =20
> > > > >
> > > > > Hi all,
> > > > >
> > > > > This is a Framework to handle complex IIO aggregate devices.
> > > > >
> > > > > The typical architecture is to have one device as the frontend de=
vice which
> > > > > can be "linked" against one or multiple backend devices. All the =
IIO and
> > > > > userspace interface is expected to be registers/managed by the fr=
ontend
> > > > > device which will callback into the backends when needed (to get/=
set
> > > > > some configuration that it does not directly control).
> > > > >
> > > > > The basic framework interface is pretty simple:
> > > > >  - Backends should register themselves with @devm_iio_backend_reg=
ister()
> > > > >  - Frontend devices should get backends with @devm_iio_backend_ge=
t()
> > > > >
> > > > > (typical provider - consumer stuff)
> > > > > =20
> > > >
> > > > The "typical provider - consumer stuff" seems pretty straight forwa=
rd
> > > > for finding and connecting two different devices, but the definition
> > > > of what is a frontend and what is a backend seems a bit nebulous. It
> > > > would be nice to seem some example devicetree to be able to get a
> > > > better picture of how this will be used in practices (links to the =
the
> > > > hardware docs for those examples would be nice too).
> > > > =20
> > >
> > > Fulfilling my own request here...
> > >
> > > Since AD9467 is being use as the example first user of the IIO offloa=
d framework
> > > I did a deep dive into how it is actually being used. It looks like t=
his:
> > > =20
> >
> > This is not an offload framework... I think somehow you're connecting t=
his to the
> > spi_engine offload and these are two completely different things. Maybe=
 they can
> > intersect at some point but as of now, I don't see any benefit in doing=
 it. The goal
> > of this patchseries is to have a simple and generic framework so we can=
 connect IIO
> > devices (frontends) to a backend device having kind of an IIO aggregate=
 device so to
> > say. Moreover, we just want to have the ad9467 driver in the same state=
 it was before
> > to keep things simple. I'm already fixing some things but I don't want =
extend that
> > too much as the primary goal is to have the framework in. Cleanups can =
come
> > afterwards.
> >
> > That said, is fine to have this kind of discussion but I honestly think=
 you're over
> > engineering the whole thing. Maybe you're already too ahead of me :), b=
ut where we
> > stand right now, I don't see any reason for anything so complicated as =
the below.
> > Also note this should be simple and generic. As I already said, this is=
 not supposed
> > to be an ADI only thing and STM also wants to make use of this infrastr=
ucture. But
> > see below some of my comments on why I think it's too much... =20
>=20
> This is a very fair point. I do have a tendency to overthink things. :-)
>=20
> At the very least, being able to see the schematic of how it all fits
> together filled in the holes of my understanding and now everything
> you are doing in this series makes sense to me. And I totally agree
> with keeping it simpler is better.

Interesting discussion. One key thing it has highlighted for me is that
even the simpler proposal that Nuno has put forward deserves some
more documentation!  Preferably with some asci art - though maybe not as co=
mplex
as David's pretty picture.  I keep forgetting which is the backend and which
is the front end for this discussion which isn't helping me get my head
around it.

Jonathan




