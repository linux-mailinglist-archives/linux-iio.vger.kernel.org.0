Return-Path: <linux-iio+bounces-26431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 662D0C81679
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 16:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 759BD4E64A7
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 15:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CED3148DA;
	Mon, 24 Nov 2025 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="R6UBGPa9";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="HQSxeqBI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECAE313E0B;
	Mon, 24 Nov 2025 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763998928; cv=pass; b=giu474W7ctapkADlpAwFV0FfWOcAKLmF18FgQx/thid61s1NSBjFlhBoeZ5W5Pq3kGr4PHYAgaSCrJcfXUtXzz3ONYDDkrgG+J814cVN2eYFeWi3yj1ltyr/bnUdzP4rx6a7zrapCtpl61TDOWQZxMneZ9R02GWkA8a+KtDITwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763998928; c=relaxed/simple;
	bh=yPYGC7e0wXw9NN6inGU21PEF5T5OMUPZWftkiDy78vU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jCB1Fwv5qmFErmguqaGzfi1p2HBcSK/2j78ymwqB6nSZwx/NKXD52qZVXPu9a0LOpRzRRW3/saNOCCFu+VlpV4GdXgs5+NlpvQopbYWSZt1hcCCvz90Gxy/5bgc1ajAFPYUuixUm/l4N5McTNK9HjIQfV7vtKIi/2az7re+5jgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=R6UBGPa9; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=HQSxeqBI; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1763998549; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AxXhNaq2QSyA+TQ9sGyx3P1gVziPvOzC1mocipgLLabpjohSRkDqjI1cne9HVoSeh3
    EnrZNfSgjP1fkjDF02BI/GRQ+Dlt1UWmyCY0qQ2MyBtqFwIIJx7w8W3Hv9PI+vFItyN8
    lQJlxl2pC+nRrzjnJisQJprAOdJymmXgqo4lZVCF56TWUG1wrdzbOcBydhf5OjtDCqCc
    GKlA9q6otJ2L09VDsY1gMenvZ5+Z7YS++VHUZPHSwADBwX0nY6DZH1elLMkgIFSulBES
    aYSdlKDtU7dfJjQW6amzkhmjz9NEgevJ8Paccr89T+PUxgclv5gvcqOZABUIWm+b7PTb
    UUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763998549;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=yPYGC7e0wXw9NN6inGU21PEF5T5OMUPZWftkiDy78vU=;
    b=RVybWi/SxEwGc/kwktk+ZNBGkZLxnSHUuQKrkvughpmcdO5PS7F0FfveC2RpmVLt8S
    gCR0u/iCYTUC1CiggbIAS4NRyprEfO6AjwcSU1DudI8/UrEa4XLaJgCW84cWcWUNdo5J
    cBhEiLi/W3LSA+q6vh0R+GojuDDDgivJ78pcpOtmsUjewwQsm7i72J6etvGtNQx0yJ7T
    ufVHuqCZMuEE5Cn40YOANqv51dmGjChS+88KLUHyXziSqzSFF6hI2SjwassLh1PrAaqw
    TPKrNSr45cm7mipuHPs4Qx4YnuOzOHK5qhXh+FGWXK/y0l3xYHF6+fYm2MGTB7mM+PuV
    2aQg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763998549;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=yPYGC7e0wXw9NN6inGU21PEF5T5OMUPZWftkiDy78vU=;
    b=R6UBGPa9x9MkdRHjS/IuikyqOUXWv1KBdDySoPmgYx+4NTPgZ7/smXUpAL6Q2zb8ZY
    jAwqnurxeH0ajazUQ9Ivv1jYO+7IwhXEsrVy27OFuOSGnCGGWS7yqizHJJKh/EfscUM7
    5PsPhD8c361yNsXZpX1N5b1zPKrbVAyjmzoUZxzvRKdwaTCxgiwoezFo78QfANE61+W6
    v0wWNL7t0sHGhxvAvbyYVYDuR/kGlVXFWkG+Ojo2SwJ86YKMSKCVHkueqy8hw2TbEoqg
    omaZDp2y0x3ICYlaD+BB+gs7H7AofF9BpShEil2sYdfsWSgUy/CtaVYDhLeu0dcRHemo
    75nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763998549;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=yPYGC7e0wXw9NN6inGU21PEF5T5OMUPZWftkiDy78vU=;
    b=HQSxeqBIVWTYHstF0sD6f0h9eEWFTR1YJ5u10+ub9jcIb6fZ+1a65aG5BegC1mk/ut
    xL4jvvIrjso43H/cy3Dg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yeT0Z"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 54.0.0 DYNA|AUTH)
    with ESMTPSA id Qc14a81AOFZeEjB
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 24 Nov 2025 16:35:40 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.3\))
Subject: Re: [PATCH v4 0/6] Add support for the LTM8054 voltage regulator
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <23111366.EfDdHjke4D@fw-rgant>
Date: Mon, 24 Nov 2025 16:35:28 +0100
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Peter Rosin <peda@axentia.se>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Kevin Tsai <ktsai@capellamicro.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Sebastian Reichel <sre@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,
 Support Opensource <support.opensource@diasemi.com>,
 Paul Cercueil <paul@crapouillou.net>,
 Iskren Chernev <me@iskren.info>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matheus Castello <matheus@castello.eng.br>,
 Saravanan Sekar <sravanhome@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>,
 Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Dixit Parmar <dixitparmar19@gmail.com>,
 linux-hwmon@vger.kernel.org,
 linux-input@vger.kernel.org,
 linux-phy@lists.infradead.org,
 linux-pm@vger.kernel.org,
 linux-mips@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <563331EB-2460-4CF5-87B3-5FE60B18BB70@goldelico.com>
References: <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
 <24527d76-4f6a-4008-a369-23510d492a94@roeck-us.net>
 <23111366.EfDdHjke4D@fw-rgant>
To: Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: Apple Mail (2.3826.700.81.1.3)

Hi

> Am 24.11.2025 um 16:13 schrieb Romain Gantois =
<romain.gantois@bootlin.com>:
>=20
> Hello Guenter,
>=20
> On Monday, 24 November 2025 15:57:41 CET Guenter Roeck wrote:
> > On 11/24/25 06:48, Romain Gantois wrote:
> > > Hello everyone,
> > >=20
> > > This is version four of my series which adds initial support of =
the Linear
> > > Technology LTM8054 voltage regulator. The driver supports a fixed =
voltage
> > > and a tunable output current limit using a DAC-controlled pin.
> > >=20
> > > I'd say that the most unusual part of this series is the usage of =
the IIO
> > > consumer API in a regulator driver. I think this makes sense here, =
since
> > > the regulator driver has to access a DAC to read/set the output =
current
> > > limit.
> >=20
> > I don't think that is a valid reason. Literally every driver =
measuring
> > voltages or current uses a DAC to do it. How else would one convert =
an
> > analog value into a digital value ?
>=20
> Sorry, I don't quite understand your remark. To integrate this voltage=20=

> regulator component into the Linux regulator abstraction, I'm =
providing a=20
> current limit control function. To provide such a function, the =
voltage level=20
> on a pin has to be controlled. AFAIK, the kernel abstraction used to =
set=20
> precise voltages on lines is an IO channel.

I was curious to learn about this topic and looked into the data sheet:

=
https://www.analog.com/media/en/technical-documentation/data-sheets/8054fa=
.pdf

As far as I see the LTM8054 does not even have a programming interface.
So is it reasonable to provide a dedicated driver at all?

The figure on page 20 seems to suggest that there is an external DAC
which drives the regulator. And the regulator drives for example a fan.

So I would think of a driver for the specific DAC and ignore the =
specific
LTM chip at all.

What could be necessary is if you really want to be able to "regulate"
the current going to Vout, some bridge between regulator API and some
IIO DAC.

And enabling/disabling the regulator by some GPIO can be described in
the DT already through a "regulator-fixed".

But this are just my first thoughts as I have not been following this
topic before. Hope it helps.

BR,
Nikolaus


