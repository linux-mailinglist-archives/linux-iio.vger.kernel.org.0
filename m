Return-Path: <linux-iio+bounces-198-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4297F19FA
	for <lists+linux-iio@lfdr.de>; Mon, 20 Nov 2023 18:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79758B21170
	for <lists+linux-iio@lfdr.de>; Mon, 20 Nov 2023 17:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE923210EE;
	Mon, 20 Nov 2023 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA981BE;
	Mon, 20 Nov 2023 09:31:34 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SYvfC4Wv5z67nNy;
	Tue, 21 Nov 2023 01:30:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 20 Nov
 2023 17:31:32 +0000
Date: Mon, 20 Nov 2023 17:31:31 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Sicelo <absicsz@gmail.com>, <linux-iio@vger.kernel.org>,
	<maemo-leste@lists.dyne.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	<linux-input@vger.kernel.org>
Subject: Re: supporting binary (near-far) proximity sensors over gpio
Message-ID: <20231120173131.000058a2@Huawei.com>
In-Reply-To: <CAMknhBE5A3w7ntdWC9cFDYSrPQNPoH7sQ5PVXKEy6MAJmZ93SA@mail.gmail.com>
References: <ZVevR_ajeB1jfDS9@tp440p.steeds.sam>
	<CAMknhBE5A3w7ntdWC9cFDYSrPQNPoH7sQ5PVXKEy6MAJmZ93SA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

On Sat, 18 Nov 2023 18:09:18 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On Fri, Nov 17, 2023 at 12:22=E2=80=AFPM Sicelo <absicsz@gmail.com> wrote:
> >
> > Hi
> >
> > Some phones have 1-bit proximity sensors, which simply toggle a GPIO
> > line to indicate that an object is near or far. Thresholds are set at
> > hardware level. One such sensor is OSRAM SFH 7741 [1], which is used on
> > the Nokia N900.
> >
> > It is currently exported over evdev, emitting the SW_FRONT_PROXIMITY key
> > code [2].
> >
> > So the question is: should a new, general purpose iio-gpio driver be
> > written, that would switch such a proximity sensor to the iio framework?
> > Or evdev is really the best place to support it?
> >
> > There are a couple of people who are willing to write such an iio
> > driver, if iio is the way to go.
> >
> > Regards,
> > Sicelo
> >
> > [1] https://media.digikey.com/pdf/Data%20Sheets/Osram%20PDFs/SFH_7741.p=
df
> > [2] https://elixir.bootlin.com/linux/v6.6.1/source/arch/arm/boot/dts/ti=
/omap/omap3-n900.dts#L111
> > =20
> Since this is really a proximity switch (it is either on or off)
> rather than measuring a proximity value over a continuous range, it
> doesn't seem like a good fit for the iio subsystem. If the sensor is
> on a phone, then it is likely to detect human presence so the input
> subsystem does seem like the right one for that application.
>=20
> More at https://www.kernel.org/doc/html/latest/driver-api/iio/intro.html
>=20
Agreed.  This one at least has a working distance of 30mm sensor, so
definitely switch type usecases where input tends to be the right choice.

If we wanted to use proximity range sensor for this usecase, we'd probably
bridge it to input (maybe in userspace, maybe in kernel) from the
underlying IIO driver.

Jonathan

