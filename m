Return-Path: <linux-iio+bounces-26434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD05C81A4D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 17:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D553A380F
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECED2BCF4A;
	Mon, 24 Nov 2025 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="FDRRuZGD";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="UpfJCvMr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F7628D8DB;
	Mon, 24 Nov 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764002647; cv=pass; b=LIvhh7cImkQQ5/bf8RxC68gggmKorMmYcwRaWdGOlTYpgaKFMRXPTIMOnL+8chVnT++P4Hk6GuOGNDMXslz5r9A1MIvzbgjSA9dFYVUL0qQ88EywUj3k+kX74bFFIn9Ajd68qIEml/J0sawUH/7BwZH8sDCzOd3Hu3+OtPQHW18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764002647; c=relaxed/simple;
	bh=YAUaPVN/LGE+6Tp5hwdCL/oWm3I9gZiHnGqVnZITlYs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jm3Wx8Ej+cRfg2PsgVJjPTZq0WrMWWcv/IHA99XkxyacY9l6KRiXgiY2+/6Elun7dRduyhM4dR5m+k1IIq50EO5JyhkRtLG0fa/w0k++6M5WVGteq1GZy0rwcRK51zTVO/XyvEmHHZ6ODLn9UCxMfCo+5jzQxWrBy015SJcVSUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=FDRRuZGD; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=UpfJCvMr; arc=pass smtp.client-ip=85.215.255.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1764001204; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Mi6ffgTzeLDd6by16LVPA9WBGsA3fZVxfsWD+cc37oI6ulg6dD65T95bJgc6HltKK7
    N4uWDZgtyOZZdYje8gbuVu9T95X4b6tGrirbXguEMFuLjxnmBeIEHwAlx2PfiDgOUf0X
    Y5unUlSKON44f9TwafsNmg1XK3HCWLwKQQjfA0arXHoDi0VhL9qaRszysZeC26RBdtLK
    YO6XinkyNSO/eRv4GXglIu2zaNXRdLUGDJVxoPF+Ebn7lEWzAKhSqULCVuldOiLIotTx
    q8gu653gQC85578icQWFyQi2iHeAZ1lQr+Y9ej1sK6GmFp8zfbiANYXvd+0sRoKehivg
    eixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764001204;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=YAUaPVN/LGE+6Tp5hwdCL/oWm3I9gZiHnGqVnZITlYs=;
    b=cUCmeEBRlYbwM5vOtKFOqHLCauD/E9W7U80NSRAFCB7CoOMD6R2e9+FINz97vTBUxa
    EaSR9ryKUBDxRXQpAuCFmDrC0Vlz24ODRPRgx20QLtw0CMv6m9nQcIyaVoFA8Hxfe7Ns
    oRovNaPokz6MeFJr6evXGsdP1dQAe4qrW7Rhh8UKE+mmCQQTJhJXqs0jPA9JE2TMH1EX
    +yD6kiySzwCuyWvVMLnxzmucLJJrS/5Vb+Y87JuqTctbDFAEVk5grUxKLv8SBccG9mq+
    b+y8Oj/N/tdmVhKCQxdC+mP4Lcd2i8XJLq1ejg/w9WMfARWVbl5i+FddPbgbqtCDfNeR
    mgPQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764001204;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=YAUaPVN/LGE+6Tp5hwdCL/oWm3I9gZiHnGqVnZITlYs=;
    b=FDRRuZGDOWIr7PVjsgzCEoc3WjvlYfn5g1ULeDbZRLMYz5CmpY7CZr3cK7UpgYkx0e
    MJeOyEuhc+s50fia250GETWkb2KyfPR/uu4luJS0hYtGHVYWjj1C0gj4wgXUQbE8ASZY
    8cbYgmpw+KOk576zSdy2+AnnWs2yoLYgND53GmUAS0eQCYLLfmWBhCTk49aW9cvhkbHv
    HX6d1mkeNCVs9FwkkOx2Oz+apKUpgSQwGiZb+KHXhrCBW37hjEaBQ2sr0RL/5DH+ejQ7
    vB8wAa9r1qfbx9RWiahdkadBDaB5zU34WX42srJQJlf0ZoT8+a2k/5Sm1R8szDOOpyRd
    RIQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764001204;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=YAUaPVN/LGE+6Tp5hwdCL/oWm3I9gZiHnGqVnZITlYs=;
    b=UpfJCvMrspS72WrTrjWL4jgwZQ8Vv8hqUUkLNHFb0/XXkbAeu7OKuXDGtFnCaVbnqc
    2w8c+jlmQ0tQ0RvKt+AA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yeT0Z"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 54.0.0 DYNA|AUTH)
    with ESMTPSA id Qc14a81AOGJvF96
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 24 Nov 2025 17:19:57 +0100 (CET)
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
In-Reply-To: <4053840.MHq7AAxBmi@fw-rgant>
Date: Mon, 24 Nov 2025 17:19:45 +0100
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
Message-Id: <732D3F12-0361-4800-8981-EF629B4C491F@goldelico.com>
References: <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
 <23111366.EfDdHjke4D@fw-rgant>
 <563331EB-2460-4CF5-87B3-5FE60B18BB70@goldelico.com>
 <4053840.MHq7AAxBmi@fw-rgant>
To: Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: Apple Mail (2.3826.700.81.1.3)

Hi,

> Am 24.11.2025 um 16:57 schrieb Romain Gantois =
<romain.gantois@bootlin.com>:
>=20
> Hi Nikolaus,
>=20
> On Monday, 24 November 2025 16:35:28 CET H. Nikolaus Schaller wrote:
> ...
> > > Sorry, I don't quite understand your remark. To integrate this =
voltage
> > > regulator component into the Linux regulator abstraction, I'm =
providing a
> > > current limit control function. To provide such a function, the =
voltage
> > > level on a pin has to be controlled. AFAIK, the kernel abstraction =
used
> > > to set precise voltages on lines is an IO channel.
> >=20
> > I was curious to learn about this topic and looked into the data =
sheet:
> >=20
> > =
https://www.analog.com/media/en/technical-documentation/data-sheets/8054fa=
.p
> > df
> >=20
> > As far as I see the LTM8054 does not even have a programming =
interface.
> > So is it reasonable to provide a dedicated driver at all?
> >=20
> > The figure on page 20 seems to suggest that there is an external DAC
> > which drives the regulator. And the regulator drives for example a =
fan.
> >=20
> > So I would think of a driver for the specific DAC and ignore the =
specific
> > LTM chip at all.
> >=20
>=20
> In my use case, the LTM8054 feeds a DC output port on which various =
devices=20
> may be plugged. Dynamic output current limitation and output voltage =
level=20
> control for these devices is a requirement, as well as stepped voltage=20=

> transitions, thus the need for a proper regulator device.
>=20
> The LTM8054's feedback pin can be driven by a different DAC, which =
allows for=20
> dynamic output voltage control. This is a more complex upstreaming =
topic=20
> however, so I've left it out of this initial series. There are other =
component=20
> functions which fit in squarely into the regulator framework, such as=20=

> input current limit control and soft-start. But I understand that the =
current=20
> driver might look a bit "bare".

So you just want to have some user-space mechanism to control voltage
and current limits? Can't this be done by directly controlling them =
through
the iio API?

Is this for a device that is already in kernel or planned to be =
supported?
Or is it "application support" for some SBC?

Are you looking for a virtual "glue" driver to logically combine several =
low
level functions?

>=20
> > What could be necessary is if you really want to be able to =
"regulate"
> > the current going to Vout, some bridge between regulator API and =
some
> > IIO DAC.
> >=20
> > And enabling/disabling the regulator by some GPIO can be described =
in
> > the DT already through a "regulator-fixed".
> >=20
>=20
> This is a possibility, but when you bring in all of these other =
hardware=20
> functions that I mentionned e.g. output voltage control and stepping, =
you'll=20
> end up with several different devices which look unrelated from =
userspace, but=20
> actually control the same chip.

That is quite usual... I have often heard: user space must fix this as =
kernel
just provides basic functions in a harmonized way and integration has to
be tailored to the device anyways :)

> Userspace will also have to know about some hardware details to =
properly=20
> control the DACs, such as the values of the sense and feedback =
resistors. In=20
> my opinion, this bypasses the kernel's abstraction of hardware.

I came up with this argument several times in the part and got a lot of =
contrary :)

What I still wonder: does your hardware warrant an upstream driver for a
non-programable chip if a different solution (with help of user-space) =
already
exist?

Another question: is your scheme generic enough so that it can be =
expected
that other devices are using it in the same way?

Or could the power controller framework (/sys/class/power_supply) fit =
better?

There is an API to ask chargers etc. for battery voltage and current =
limits or
even write them.

There is also "generic-adc-battery" which allows to hook up with =
arbitrary
iio-adcs for measurements - although you need a DAC in your setup. Maybe =
an
extension here is a better strategy than a dedicated ltm8054 driver?

BR,
Nikolaus


