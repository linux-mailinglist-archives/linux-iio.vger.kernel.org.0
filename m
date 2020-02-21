Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C56167A63
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 11:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgBUKP7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 05:15:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbgBUKP7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 05:15:59 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8322920722;
        Fri, 21 Feb 2020 10:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582280158;
        bh=ohR22iBcgKNOY/FiBH57yMmxgoMNvTO5PoEx/XwwAhw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vIuZa/IUYgI4YGz0xTrU1TTn3YMPU8zlWryV8sH/AKnOAfC9ouIYcP2FVv/HGD9UZ
         iuOjocq9/zW+qQfB+2FqF0zHySnQ7dGUF8G51ysHNM17Xtmut/ix82YpLCAVLwqr3l
         ebJiMv55X9t/tCjdtvqG6LaYCu44692FkkVHudEA=
Date:   Fri, 21 Feb 2020 10:15:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, kernel@pengutronix.de,
        Geert Uytterhoeven <geert@glider.be>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: enabling a regulator before doing an ADC measurement
Message-ID: <20200221101554.6b229991@archlinux>
In-Reply-To: <20200219103235.u2roy3uchlrxqgqw@pengutronix.de>
References: <20200219103235.u2roy3uchlrxqgqw@pengutronix.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Feb 2020 11:32:35 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> Hello,
>=20
> I have a hardware setup that looks as follows:
>=20
>                                 ,-------------------.
>  ,---------.       ,---/ -------| current-regulator |
>  |  ADC    |       |            `-------------------'
>  |      CH0--------+
>  |         |       |
>  `.........'    ,-----.
>                 |PT100|
> 		`-----'
> 		   |
> 		   =E2=8F=9A
>=20
> So the idea is that I enable the regulator and then measure the adc's
> input to determine the resistance of the PT100 and so its temperature.
>=20
> I wonder if/how I should represent that in my device's device tree. I
> discussed this already a bit with Geert on irc and he came up with
> something like:
>=20
> 	adc {
> 		...
> 		channel@0 {
> 			reg =3D <0>;
> 			supply =3D <&myregulator>;
> 		};
> 	};
>=20
> with the intention that the adc driver enables myregulator before
> starting a measurement on channel 0.
>=20
> Does this sound sensible? Does something like this maybe even already
> exist and I missed it?

>=20
> What is a bit special here is that usually a regulator is used to supply
> a device and it's just enabled at probe time (or when the device is
> started to be used) and disabled when done. Here the regulator is
> supposed to be enabled only during a measurement[1] to yield the reference
> current and doesn't supply a device. So maybe better use another
> property name instead of plain "supply", maybe "reference-supply"?


There are similar cases though they tend to be wrapped
up in runtime pm rather than enable and disable each time.
Note this tends not to be the case in 'first' posts of drivers, because
it's a bit fiddly to do.  Hence it gets added later if relevant.  Often
the regulator being disabled is the reference voltage rather than
the primary power supply.

For this particular case, I'd rather see the pt100 fully represented
(with a tiny driver).   That would be a consumer of the ADC channel
and present it's own temperature channel.  We do this for things
like analog accelerometers.   Then you can control the regulator
either every time.

That way it looks just like a normal device with simple bindings.
The oddity being the necessity to turn the power off after a reading
(and I guess keep it off for some minimum time?)

Thanks,

Jonathan

>=20
> Best regards
> Uwe
>=20
> [1] When the current measurement is done, the regulator must be swiched
> off again to not warm up the PT100 and so fudge future measurements.
>=20

