Return-Path: <linux-iio+bounces-26450-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4F6C84801
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 11:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CB444E8EF1
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 10:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E852FD1D5;
	Tue, 25 Nov 2025 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="NLwgKJhs";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="oxtcGT9p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3EF30F526;
	Tue, 25 Nov 2025 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066715; cv=pass; b=c7ktBIjvU7orjAumANiTY5jinII4tDHZ5oMgnPXjZM9e9DeVEl1FR6PFLDzTux4bC9pl1P8s+UxCDh+LWPPsVTwzdsyCQU1shireTHTcMMEXj/ycB+oO6cDsiK6wfXfNja4aeNfji4vGldwU+25ItqFL2lfVsa51VooKPBRiI5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066715; c=relaxed/simple;
	bh=ci29UazI1lhJ06hRQOi/pXDn1T/cUfvDF30uEVyO5pU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sRDMOzw8qh2GJph+mO8SOjH24D2dkPZZLbORwYfJjzHU60kFUYTUuISMgWuVs1q9OWkhRBqUGjQZzv0OV52kc9LpPFWWbXzu00Cn6lQx6bX3zWrQwj3Q8A3jY/gsMDyEBiYXd15L7VLRchfztRCD6uTg+FJAaDt65Q9N/Hgk2XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=NLwgKJhs; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=oxtcGT9p; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1764066342; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NzivWj6Wl1NM1bZP0RGHpGW+8z5YfYoZZQB6SZ7oE0K379GniDRgLThnVnrKx041yX
    Rrr7dL+XkCrKJTh0o60YvsuVoKT7Uh7n3rREe9+68nUQy9S5g+2OoiIb6iBTvfWW/ZDO
    fIEZcRanRPFsMd+6CojEwNrjLylNFN0dHXHaIiBVqJHuoG0erVM6d8EIrsjy/EXFO/3t
    Nk0/pIr7uEJD1574+egQP950fleFa45S+H9NqGn6FtSGl4H6uLndn49F68NbaDG1aUKY
    LnMvbnr9MTnxmYThtRMkwU7jN4b5xKAKMJfY2SKF72ThRmxjsOXKACM5i1yiTB21VllR
    YLjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764066342;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ci29UazI1lhJ06hRQOi/pXDn1T/cUfvDF30uEVyO5pU=;
    b=DUZS90uDQzuXhzfDxKl7aLKA3SD/9FN8JgYePxbDvXNBvInnO0EA0uK+I/U8JLJQ85
    QGEKw5QvyLAjwMjszBDxIeAxyuXmkqODeBIfy/2NDr2c0g2QyqkZr6Lj7TiTIWMbzwzh
    kfQ3TFtvhAShsRjZ9k1yiuRBeU9Q59M2W8mTDqtt674+elSuXvjyG/VJk2YLVoCUG9u7
    TDfy1FKCJDCCIIiXcOT4GoXjB/8gMv5ayEeqVp+A2iBGrZeN5zL2pom0xCBX+lDNq/w4
    E/IkIUuZiGUr55vimV0zmAdfPaS/4mDfPGWfW1DeVVRwj3G7uEGdRcqIbJxgMKM0Nurd
    U9Lw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764066342;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ci29UazI1lhJ06hRQOi/pXDn1T/cUfvDF30uEVyO5pU=;
    b=NLwgKJhseBcqf+qUCcNj2+koSRExJGn67iUNx8oZea86hMBXpgTWZDKq+hlNdeo/gV
    o7wD1yY5AWz/C3RsYz2hqQZZEEsYgy1uxQnCyebl0ji7Q4F7fGIaXOeCjEm2qvyrPs7/
    PFhRGgDV6t8TEwTjkxNxxpt/dGMRDHDe47Q5iHIgbERY7WPKTCRd3ZMPryIBgHQrQ0iy
    fh7TMnj8FjEOtPrf5G4DN8w3G6nUyrwAPjKRONUBk39q0C994tE2aWE7tL/lbxUsuD1K
    FALSXPW4eiXUxz4NbkQHZ0/GajNrgEAqMXAiU+VPN3N73rnqcMc+KkyPJ+5fU42FmEQ5
    M5fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764066342;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ci29UazI1lhJ06hRQOi/pXDn1T/cUfvDF30uEVyO5pU=;
    b=oxtcGT9pznqCf1GAkAo8NBELt2UFYQtp5VANAM5oSapF8U4k5ISG7tnH5rFudzvipf
    ykK//xuRAvGRwjHCB/BQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yfzsZ"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 54.0.0 DYNA|AUTH)
    with ESMTPSA id Qc14a81APAPZMQu
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 25 Nov 2025 11:25:35 +0100 (CET)
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
In-Reply-To: <3021060.e9J7NaK4W3@fw-rgant>
Date: Tue, 25 Nov 2025 11:25:24 +0100
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
Message-Id: <0E900830-E248-4F0F-A048-075EAF1D2440@goldelico.com>
References: <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
 <4053840.MHq7AAxBmi@fw-rgant>
 <732D3F12-0361-4800-8981-EF629B4C491F@goldelico.com>
 <3021060.e9J7NaK4W3@fw-rgant>
To: Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: Apple Mail (2.3826.700.81.1.3)

Hi,


> Am 25.11.2025 um 09:41 schrieb Romain Gantois =
<romain.gantois@bootlin.com>:
>=20
>=20
> This is planned support for a voltage regulator chip.


Well, but one which is not by itself programmable. So IMHO, it does not =
support that chip,
but the circuit it is used in.

>=20
> > Are you looking for a virtual "glue" driver to logically combine =
several low
> > level functions?
> >=20
>=20
> I'm looking for a clean userspace abstraction for this component, the =
low-
> level functions in this case are those of a voltage regulator.

As far as I understood it has
- constant voltage
- current can be limited
- it can be turned on/off

That means it is a fixed-regulator (for constant voltage and turn =
on/off)
and a mechanism to program the current limit (iio-dac). Both have clean
userspace abstraction.

What am I missing?

> > What I still wonder: does your hardware warrant an upstream driver =
for a
> > non-programable chip if a different solution (with help of =
user-space)
> > already exist?
> >=20
>=20
> A different solution does not currently exist (although a =
userspace-based=20
> solution could be designed). I just think that a kernel-based solution =
is more=20
> desirable here.

I agree, but that is a common discussion :) For example, years ago I had =
a long
discussion if there should be touchscreen pre-calibration in kernel, =
which is
desirable to get it almost right after boot, or if it is user-space... =
In the
end it was rejected.

>=20
> > Another question: is your scheme generic enough so that it can be =
expected
> > that other devices are using it in the same way?
> >=20
>=20
> Yes, the LTM8054 has a fairly common design as far as buck-boost chips =
go.=20
> Things like feedback dividers on the output voltage pin are standard =
practice.

Yes, I know - but how is this related to the kernel or a driver? To my =
knowledge
feedback dividers are never relevant for kernel drivers for buck =
regulators,
especially if they are fixed and can not be programmed. They end up in a =
specification
of regulator-min-microvolt and regulator-max-microvolt.

So I still wonder why they must be made available to the kernel and =
user-space.

If you look for example into the schematics of a PocketBeagle 2=20
(https://docs.beagleboard.org/pocketbeagle-2.pdf).

Figure 3.23 on page 26 shows a 3.3V step-down converter with enable and =
feedback
resistors (560k/124k).

Still, this regulator is represented not by a dedicated TLV62595 driver =
but:

=
https://elixir.bootlin.com/linux/v6.18-rc7/source/arch/arm64/boot/dts/ti/k=
3-am62-pocketbeagle2.dts#L91

Well, it does not have a controllable current limit, just a builtin one.
(And a gpio-control could be added by using a regulator-gpio driver).

> And since the driver doesn't rely on a particular way of integrating =
the=20
> LTM8054 with other components, it can be reused wherever the same =
regulator=20
> chip is used.

That are my questions:
- what is so different with an LTM8054 to other buck regulators that it =
needs a dedicated driver
- is the feature to control current limit by a DAC to the LTM8054 or is =
it the DAC (in software perspective)
- does it need a conversion factor from mA to binary value? Why is this =
needed in kernel?
- are there similar designs planned for this chip or already in use =
which run Linux?

> > Or could the power controller framework (/sys/class/power_supply) =
fit
> > better?
> >=20
>=20
> I don't think the power supply abstraction is relevant here. The =
LTM8054 is a=20
> voltage regulator, it doesn't have charge, capacity, temperature =
monitoring,=20
> power limitation, or other power supply class features.

By current limitation you also have power limitation. Yes, it does not
need to provide charge, capacity, temperature but IMHO they are not all =
mandatory.
It is just a suggestion to look around if there are different =
abstractions
that already exist and can be used.

>=20
> > There is an API to ask chargers etc. for battery voltage and current =
limits
> > or even write them.
> >=20
> > There is also "generic-adc-battery" which allows to hook up with =
arbitrary
> > iio-adcs for measurements - although you need a DAC in your setup. =
Maybe an
> > extension here is a better strategy than a dedicated ltm8054 driver?
>=20
>=20
> What if the LTM8054 is not used to supply a battery?

The question remains if you want to solve something for a single board =
which
happens to have an LTM8054 or if you are solving a more general design =
pattern.

In summary my view is that the LTM8054 is just a "fixed-regulator" which
gets an additional current-limiter feature by adding a DAC chip (which =
needs a
driver of course). So software control is required not by the LTM8054 =
but by
adding a DAC chip.

Another suggestion: what extending the "regulator-fixed", =
"regulator-gpio",
"regulator-fixed-clock" pattern by some =
"regulator-gpio-iio-dac-current-limiter"
driver to make it independent of your specific chip?

By the way, are you aware of this feature of the regulator-gpio driver?

=
https://elixir.bootlin.com/linux/v6.18-rc7/source/drivers/regulator/gpio-r=
egulator.c#L97

Just to note: I am neither maintainer nor doing any decisions on this, =
just asking
questions for curiosity and from experience and giving hints for =
alternative approaches,
where I hope they help to find the really best solution.

Best regards,
Nikolaus


