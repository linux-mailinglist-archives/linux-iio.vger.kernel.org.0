Return-Path: <linux-iio+bounces-24506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC82BA6248
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 20:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C733BD688
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 18:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A497F22D4DE;
	Sat, 27 Sep 2025 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYug1uxJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCE520299B;
	Sat, 27 Sep 2025 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758996414; cv=none; b=jjjPZ7+HWFQyRMqggUIx7/IW0aFDhyZCL5LWVUFzclK7yWDholTKR3z8acvzr2RxbSSNh/ZVsL59ig+xBacNPMrNpRQJctFtNmd02fDdiFeahtiqkqgpX77ZpXHEdzrarGocP7uWVPYcKrhcqfWtfzUeaiI1jRD0Qmq/VEKkYMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758996414; c=relaxed/simple;
	bh=tvD5OtZcFkIwI6aWwtvtHLnO2K8nKOpik4/PZ+knzJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImcoMMb4TpB5ZjoZYeKyHBwADZQp6FpKvArhARwd5klUnBBBn6t7KndtXVKa6pQNwr3RXPwuBKnLQiQboC7YAWfwr07OqJfnXMa293eOz54cKKdNDJCYkmzrmdwkWKWnarLtDXD1egsmq9pm8CNj25gIb6RtLk6lUA1utkTmeGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYug1uxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7DEC4CEE7;
	Sat, 27 Sep 2025 18:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758996413;
	bh=tvD5OtZcFkIwI6aWwtvtHLnO2K8nKOpik4/PZ+knzJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VYug1uxJemtvCEHEoqbHblFAuh6e+j7qDLjCk4/dPv6J5DpzQ2qgdBGeNA1U/eHFl
	 HZ59MjL4asKFONfPQT81nXGESQ6q7jqxplA0qHngUCr5nLJQWOXyUhRvJ/VQ2XSfLP
	 LPRardUxExEY1SYaViWPcbLnTWJAvvRa3NhweZ0EB5ykifXXdN3lm2E8Ix6Xta5MTe
	 GeAFKnqV7e6Wf69zPax+AY9GKmwCQHSY1zBpSyTJ0i9XKdEjsNK7WmM2tv+jVLHNNX
	 o/67Zk3UBObb5HEAZwaUE2FuJyiz5nOqR2K4tjc6mpWCnoWLoLIm3CCx5hBaHWD1Kz
	 6f6eZBJOx2Sag==
Date: Sat, 27 Sep 2025 19:06:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 "magnus.damm" <magnus.damm@gmail.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"	
 <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"	
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] iio: adc: add RZ/T2H / RZ/N2H ADC driver
Message-ID: <20250927190643.61852030@jic23-huawei>
In-Reply-To: <3f93a0dad6ba5dea8db84973ae1518bbb98d3aed.camel@gmail.com>
References: <20250925224013.2146983-1-cosmin-gabriel.tanislav.xa@renesas.com>
	<20250925224013.2146983-4-cosmin-gabriel.tanislav.xa@renesas.com>
	<3550caed57f460a3d28ed585eda2d955bd846930.camel@gmail.com>
	<OSZPR01MB87987A7D3F418A6E7A24FC41851EA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
	<3f93a0dad6ba5dea8db84973ae1518bbb98d3aed.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Sep 2025 15:41:14 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2025-09-26 at 12:41 +0000, Cosmin-Gabriel Tanislav wrote:
> >=20
> >  =20
> > > -----Original Message-----
> > > From: Nuno S=C3=A1 <noname.nuno@gmail.com>
> > > Sent: Friday, September 26, 2025 3:11 PM
> > > To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > > Cc: Jonathan Cameron <jic23@kernel.org>; David Lechner
> > > <dlechner@baylibre.com>; Nuno S=C3=A1
> > > <nuno.sa@analog.com>; Andy Shevchenko <andy@kernel.org>; Rob Herring
> > > <robh@kernel.org>; Krzysztof
> > > Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; G=
eert
> > > Uytterhoeven
> > > <geert+renesas@glider.be>; magnus.damm <magnus.damm@gmail.com>;
> > > linux-iio@vger.kernel.org; linux-
> > > renesas-soc@vger.kernel.org; devicetree@vger.kernel.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH v2 3/7] iio: adc: add RZ/T2H / RZ/N2H ADC driver
> > >=20
> > > On Fri, 2025-09-26 at 01:40 +0300, Cosmin Tanislav wrote: =20
> > > > Add support for the A/D 12-Bit successive approximation converters =
found
> > > > in the Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
> > > >=20
> > > > RZ/T2H has two ADCs with 4 channels and one with 6.
> > > > RZ/N2H has two ADCs with 4 channels and one with 15.
> > > >=20
> > > > Conversions can be performed in single or continuous mode. Result o=
f the
> > > > conversion is stored in a 16-bit data register corresponding to each
> > > > channel.
> > > >=20
> > > > The conversions can be started by a software trigger, a synchronous
> > > > trigger (from MTU or from ELC) or an asynchronous external trigger =
(from
> > > > ADTRGn# pin).
> > > >=20
> > > > Only single mode with software trigger is supported for now.
> > > >=20
> > > > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.=
com>
> > > > --- =20
> > >=20
> > > Just one small nit from me. With it:
> > >=20
> > > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > >  =20
> > > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > > =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 ++
> > > > =C2=A0drivers/iio/adc/Makefile=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > > =C2=A0drivers/iio/adc/rzt2h_adc.c | 306 +++++++++++++++++++++++++++=
+++++++++
> > > > =C2=A04 files changed, 318 insertions(+)
> > > > =C2=A0create mode 100644 drivers/iio/adc/rzt2h_adc.c
> > > >=20
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index eed08d25cb7a..220d17039084 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -21837,6 +21837,7 @@ L:=C2=A0 linux-iio@vger.kernel.org
> > > > =C2=A0L: linux-renesas-soc@vger.kernel.org
> > > > =C2=A0S: Supported
> > > > =C2=A0F: Documentation/devicetree/bindings/iio/adc/renesas,r9a09g07=
7-adc.yaml
> > > > +F: drivers/iio/adc/rzt2h_adc.c
> > > >=20
> > > > =C2=A0RENESAS RTCA-3 RTC DRIVER
> > > > =C2=A0M: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > > index 58a14e6833f6..cab5eeba48fe 100644
> > > > --- a/drivers/iio/adc/Kconfig
> > > > +++ b/drivers/iio/adc/Kconfig
> > > > @@ -1403,6 +1403,16 @@ config RZG2L_ADC
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To compile this driver as a module, =
choose M here: the
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 module will be called rzg2l_adc.
> > > >=20
> > > > +config RZT2H_ADC
> > > > +=C2=A0=C2=A0 tristate "Renesas RZ/T2H / RZ/N2H ADC driver"
> > > > +=C2=A0=C2=A0 select IIO_ADC_HELPER
> > > > +=C2=A0=C2=A0 help
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 Say yes here to build support for the ADC=
 found in Renesas
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 RZ/T2H / RZ/N2H SoCs.
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 To compile this driver as a module, choos=
e M here: the
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 module will be called rzt2h_adc.
> > > > +
> > > > =C2=A0config SC27XX_ADC
> > > > =C2=A0=C2=A0=C2=A0 tristate "Spreadtrum SC27xx series PMICs ADC"
> > > > =C2=A0=C2=A0=C2=A0 depends on MFD_SC27XX_PMIC || COMPILE_TEST
> > > > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > > > index d008f78dc010..ed647a734c51 100644
> > > > --- a/drivers/iio/adc/Makefile
> > > > +++ b/drivers/iio/adc/Makefile
> > > > @@ -123,6 +123,7 @@ obj-$(CONFIG_ROHM_BD79112) +=3D rohm-bd79112.o
> > > > =C2=A0obj-$(CONFIG_ROHM_BD79124) +=3D rohm-bd79124.o
> > > > =C2=A0obj-$(CONFIG_ROCKCHIP_SARADC) +=3D rockchip_saradc.o
> > > > =C2=A0obj-$(CONFIG_RZG2L_ADC) +=3D rzg2l_adc.o
> > > > +obj-$(CONFIG_RZT2H_ADC) +=3D rzt2h_adc.o
> > > > =C2=A0obj-$(CONFIG_SC27XX_ADC) +=3D sc27xx_adc.o
> > > > =C2=A0obj-$(CONFIG_SD_ADC_MODULATOR) +=3D sd_adc_modulator.o
> > > > =C2=A0obj-$(CONFIG_SOPHGO_CV1800B_ADC) +=3D sophgo-cv1800b-adc.o
> > > > diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_ad=
c.c
> > > > new file mode 100644
> > > > index 000000000000..6a49788a5c67
> > > > --- /dev/null
> > > > +++ b/drivers/iio/adc/rzt2h_adc.c
> > > > @@ -0,0 +1,306 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +#include <linux/bitfield.h>
> > > > +#include <linux/cleanup.h>
> > > > +#include <linux/completion.h>
> > > > +#include <linux/delay.h>
> > > > +#include <linux/iio/adc-helpers.h>
> > > > +#include <linux/iio/iio.h>
> > > > +#include <linux/interrupt.h>
> > > > +#include <linux/io.h>
> > > > +#include <linux/iopoll.h>
> > > > +#include <linux/mod_devicetable.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/pm_runtime.h>
> > > > +#include <linux/property.h>
> > > > + =20
> > >=20
> > > ...
> > >  =20
> > > >=20
> > > > +
> > > > +static int rzt2h_adc_pm_runtime_resume(struct device *dev)
> > > > +{
> > > > +=C2=A0=C2=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> > > > +=C2=A0=C2=A0 struct rzt2h_adc *adc =3D iio_priv(indio_dev); =20
> > >=20
> > > Not seeing the point of the pointer arithmetic. You can pass your dev=
ice
> > > pointer
> > > (adc) directly in platform_set_drvdata()
> > >  =20
> >=20
> > Thanks Nuno, I'll do that. I also have another change to make to the dr=
iver so
> > I will have to send a new version and you'll have to give your Reviewed=
-by
> > again.
> >=20
> > Here's the change I'm planning to make, maybe I could keep the Reviewed=
-by
> > if you agree.
> >=20
> > Without this change, pm_runtime_resume_and_get() is inside the mutex,
> > while pm_runtime_put_autosuspend() is outside of it. This is mostly for=
 =20
>=20
> I guess you meant the other way around.
>=20
> > symmetry, although it's not excluded for some subtle bugs to be able to
> > occur without it.
> >  =20
>=20
> Fell free to keep my tag.
>=20
> - Nuno S=C3=A1
>=20
> > diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
> > index 708029dc8949..79053bbc71c9 100644
> > --- a/drivers/iio/adc/rzt2h_adc.c
> > +++ b/drivers/iio/adc/rzt2h_adc.c
> > @@ -81,9 +81,9 @@ static int rzt2h_adc_read_single(struct rzt2h_adc *ad=
c,
> > unsigned int ch, int *va
> > =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pm_runtime_resume_and_get(adc->dev);
> > =C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> >=20
> > -=C2=A0=C2=A0=C2=A0 guard(mutex)(&adc->lock);
> > +=C2=A0=C2=A0=C2=A0 mutex_lock(&adc->lock);
> >=20
As you've highlighted this bit of code, I'll observe here that mixing goto =
and
cleanup.h magic is a bad idea.  There is a bunch of text about this in clea=
nup.h

Rafael has posted a series that will provide cleanup.h magic for runtime PM=
, but
that still doesn't get you around the mix of goto and not.

> > =C2=A0=C2=A0=C2=A0=C2=A0 reinit_completion(&adc->completion);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 /* Enable a single channel */
> > @@ -106,8 +106,10 @@ static int rzt2h_adc_read_single(struct rzt2h_adc =
*adc,
> > unsigned int ch, int *va
> >=20
> > =C2=A0disable:
> > =C2=A0=C2=A0=C2=A0=C2=A0 rzt2h_adc_start_stop(adc, false, 0);
> >=20
> > +=C2=A0=C2=A0=C2=A0 mutex_unlock(&adc->lock);
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_put_autosuspend(adc->dev);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > =C2=A0}
> >  =20
> > > - Nuno S=C3=A1 =20
> >=20
> > ________________________________
> >=20
> > Renesas Electronics Europe GmbH
> > Registered Office: Arcadiastrasse 10
> > DE-40472 Duesseldorf
> > Commercial Registry: Duesseldorf, HRB 3708
> > Managing Director: Carsten Jauch
> > VAT-No.: DE 14978647
> > Tax-ID-No: 105/5839/1793
> >=20
> > Legal Disclaimer: This e-mail communication (and any attachment/s) is
> > confidential and contains proprietary information, some or all of which=
 may be
> > legally privileged. It is intended solely for the use of the individual=
 or
> > entity to which it is addressed. Access to this email by anyone else is
> > unauthorized. If you are not the intended recipient, any disclosure, co=
pying,
> > distribution or any action taken or omitted to be taken in reliance on =
it, is
> > prohibited and may be unlawful. =20


