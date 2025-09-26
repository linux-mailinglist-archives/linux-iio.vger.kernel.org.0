Return-Path: <linux-iio+bounces-24458-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5DABA4446
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 16:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A7F189E8AB
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 14:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4B1199E94;
	Fri, 26 Sep 2025 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QB2g4DE6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C85072605
	for <linux-iio@vger.kernel.org>; Fri, 26 Sep 2025 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897652; cv=none; b=d+Szar3Es6i91uISIJi/ftAKiHd4Wt7bQ7AjvesWCXa3jD/wwBxc6voatXCXEIsXLvkadoXgUp5Zr4+Fc9cW6B+1ja7NSAfmV/5LyDTaA1EaWYXjWusArkDUMuviaz6aJHwGL2s7/CLR5gfYUVaahrThfyp3JsJpVX8rhpNKa7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897652; c=relaxed/simple;
	bh=90tchflxcF4gE+p6ymbvvXCUFZ3J0tFjBD1ra+hcs/Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sv3sPTGE2VgZHWICsTHn5ZLM0BVwJYMtRNaTelpvoLUDS1UIc9/AT2xAfLuGpag/WGnt5g+LolMj44O2XmHiJw8tcq8WTqzdgh1Esr6xY4WFbWDfz/tvmAkQD53B0njxCgwcn73wwe6v/VNfwhXjVuqThFaC++IjpM2DqyWDdxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QB2g4DE6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e2e363118so22258325e9.0
        for <linux-iio@vger.kernel.org>; Fri, 26 Sep 2025 07:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758897648; x=1759502448; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=90tchflxcF4gE+p6ymbvvXCUFZ3J0tFjBD1ra+hcs/Q=;
        b=QB2g4DE6gY0BvVOrMTkdZ8ajAMb+ZtxwQi9HUQjnsouSPM94tn8zi9mudMH5POeN0g
         EZFu3Ajgaz7jspiMUCKIVQ+u/Jdw2oLves8iZeZrK8j3PrdVCU9TVi6zeUPzF5VktsZE
         h0x04M97oQkXa874xdVkYwqAV/cRlRzOx5fvohiR9VImkcCuShXAOwAnIUqZZ5x8mdbF
         TOR1Gwmhua8hH9OeEE2NJHmyYF6Km0UKKuVfL5sajLIVyJjjRlODG9Lf0LeAZuQFJbvk
         pW4/X0en16a2jXxHcH9KtIPgr5AvM4l/+TL0EdV4sj/W5KHQNk034re0hBepSlDZKoDg
         C5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758897648; x=1759502448;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=90tchflxcF4gE+p6ymbvvXCUFZ3J0tFjBD1ra+hcs/Q=;
        b=iT5P6GdA/ayrdAUgGMHPPXofsaDr6BRKelEQ7Sht5UKc3jzKlZv+Lw1Bjhr+lDXUIi
         3DmOiD9ITnn8YZ9iffdXwYdy5NWxTB1St1rQt6s+tkj7Ia9UeQQyWnxLfVBDotUtJhAZ
         jhuQEZK4umrSeCP97Rwx0PLnoDiNZLlmCsO7zRgJ8n86JFIBKEGwLgdOTD4DNuckGA0r
         po7wQMamGO7hDXnxOh9X5PzWljRkJ98q9uyb9MRRBOj+a0G3lQmeMK1eGtqQD8PBhRvf
         7d7QVGXRn5kbTN4sozrv1F8kDncU9105MJ+1ByZbJZkfij933h4n9D+GoaM6IXB5ZfP+
         3y4g==
X-Forwarded-Encrypted: i=1; AJvYcCWQ/OsHrGvC7mU0Kz0jkVvsIHUrLtgBw5X99N8qVlLfmYFqPqKzccb/NBQEl+JU3AlFt5ZDzpBkyEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn7RVuFfshzanVAU9iSVBMf+HMXKlgkaFc/gnlOzy9t60sS2N8
	v9ocNXy+hRw28cshI3m+f2/3B1wnwFKed9Bv41eaS44ksCjKFp62W+Ac
X-Gm-Gg: ASbGncteibMba0dIJ0VEOkEcwVnTrnrNNxhCZW0XHStEg9r4wn7+6VZzxxNz1fYcvJ9
	X48H9aruN1+VR0KQirOENP9/1bunkSaOukG7waZv9l/VyZ2540TMlQnpGaySkipqrnay2d0qGgo
	hF8dh9T2K7h2N6+c+u1LgHxSvAFvgmn1q/I+NVtvtgj0P9UCRVuT0yaq/qzJt5ag3iaEdXbX9Jp
	ONH0oM3KS5wBf87AUCtvPuQeLNlVlt5vN9lTjNOyOHSsw8XT25u+yrD2MwsGXIARxoxBl0sOGd1
	m6amr1nA/JTpzNOgyzz6O1RAN82TcsnFL+WsP3Q7Y57x1FyetFxgVSEGEQ1jBfhjMEhtM1Jbu73
	HBgl5vuhssDHZOg53GYR/lajS+4n54l8=
X-Google-Smtp-Source: AGHT+IF+GdI92TLRs9rHsVNgrebtIVMQHD15AS5sbB5Iv4MThr0TRQnHyapfTIMvahMIkANVWZB75Q==
X-Received: by 2002:a05:6000:2dc8:b0:3ec:42ad:591 with SMTP id ffacd0b85a97d-40e4a05c535mr7276947f8f.36.1758897648024;
        Fri, 26 Sep 2025 07:40:48 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb9e1b665sm7247453f8f.27.2025.09.26.07.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:40:47 -0700 (PDT)
Message-ID: <3f93a0dad6ba5dea8db84973ae1518bbb98d3aed.camel@gmail.com>
Subject: Re: [PATCH v2 3/7] iio: adc: add RZ/T2H / RZ/N2H ADC driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
 "magnus.damm" <magnus.damm@gmail.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>,  "linux-renesas-soc@vger.kernel.org"	
 <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"	
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>
Date: Fri, 26 Sep 2025 15:41:14 +0100
In-Reply-To: <OSZPR01MB87987A7D3F418A6E7A24FC41851EA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: 
	<20250925224013.2146983-1-cosmin-gabriel.tanislav.xa@renesas.com>
		 <20250925224013.2146983-4-cosmin-gabriel.tanislav.xa@renesas.com>
	 <3550caed57f460a3d28ed585eda2d955bd846930.camel@gmail.com>
	 <OSZPR01MB87987A7D3F418A6E7A24FC41851EA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-26 at 12:41 +0000, Cosmin-Gabriel Tanislav wrote:
>=20
>=20
> > -----Original Message-----
> > From: Nuno S=C3=A1 <noname.nuno@gmail.com>
> > Sent: Friday, September 26, 2025 3:11 PM
> > To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>; David Lechner
> > <dlechner@baylibre.com>; Nuno S=C3=A1
> > <nuno.sa@analog.com>; Andy Shevchenko <andy@kernel.org>; Rob Herring
> > <robh@kernel.org>; Krzysztof
> > Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Gee=
rt
> > Uytterhoeven
> > <geert+renesas@glider.be>; magnus.damm <magnus.damm@gmail.com>;
> > linux-iio@vger.kernel.org; linux-
> > renesas-soc@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2 3/7] iio: adc: add RZ/T2H / RZ/N2H ADC driver
> >=20
> > On Fri, 2025-09-26 at 01:40 +0300, Cosmin Tanislav wrote:
> > > Add support for the A/D 12-Bit successive approximation converters fo=
und
> > > in the Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
> > >=20
> > > RZ/T2H has two ADCs with 4 channels and one with 6.
> > > RZ/N2H has two ADCs with 4 channels and one with 15.
> > >=20
> > > Conversions can be performed in single or continuous mode. Result of =
the
> > > conversion is stored in a 16-bit data register corresponding to each
> > > channel.
> > >=20
> > > The conversions can be started by a software trigger, a synchronous
> > > trigger (from MTU or from ELC) or an asynchronous external trigger (f=
rom
> > > ADTRGn# pin).
> > >=20
> > > Only single mode with software trigger is supported for now.
> > >=20
> > > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.co=
m>
> > > ---
> >=20
> > Just one small nit from me. With it:
> >=20
> > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 ++
> > > =C2=A0drivers/iio/adc/Makefile=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0drivers/iio/adc/rzt2h_adc.c | 306 +++++++++++++++++++++++++++++=
+++++++
> > > =C2=A04 files changed, 318 insertions(+)
> > > =C2=A0create mode 100644 drivers/iio/adc/rzt2h_adc.c
> > >=20
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index eed08d25cb7a..220d17039084 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -21837,6 +21837,7 @@ L:=C2=A0 linux-iio@vger.kernel.org
> > > =C2=A0L: linux-renesas-soc@vger.kernel.org
> > > =C2=A0S: Supported
> > > =C2=A0F: Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-=
adc.yaml
> > > +F: drivers/iio/adc/rzt2h_adc.c
> > >=20
> > > =C2=A0RENESAS RTCA-3 RTC DRIVER
> > > =C2=A0M: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > index 58a14e6833f6..cab5eeba48fe 100644
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -1403,6 +1403,16 @@ config RZG2L_ADC
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To compile this driver as a module, ch=
oose M here: the
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 module will be called rzg2l_adc.
> > >=20
> > > +config RZT2H_ADC
> > > +=C2=A0=C2=A0 tristate "Renesas RZ/T2H / RZ/N2H ADC driver"
> > > +=C2=A0=C2=A0 select IIO_ADC_HELPER
> > > +=C2=A0=C2=A0 help
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 Say yes here to build support for the ADC f=
ound in Renesas
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 RZ/T2H / RZ/N2H SoCs.
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 To compile this driver as a module, choose =
M here: the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 module will be called rzt2h_adc.
> > > +
> > > =C2=A0config SC27XX_ADC
> > > =C2=A0=C2=A0=C2=A0 tristate "Spreadtrum SC27xx series PMICs ADC"
> > > =C2=A0=C2=A0=C2=A0 depends on MFD_SC27XX_PMIC || COMPILE_TEST
> > > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > > index d008f78dc010..ed647a734c51 100644
> > > --- a/drivers/iio/adc/Makefile
> > > +++ b/drivers/iio/adc/Makefile
> > > @@ -123,6 +123,7 @@ obj-$(CONFIG_ROHM_BD79112) +=3D rohm-bd79112.o
> > > =C2=A0obj-$(CONFIG_ROHM_BD79124) +=3D rohm-bd79124.o
> > > =C2=A0obj-$(CONFIG_ROCKCHIP_SARADC) +=3D rockchip_saradc.o
> > > =C2=A0obj-$(CONFIG_RZG2L_ADC) +=3D rzg2l_adc.o
> > > +obj-$(CONFIG_RZT2H_ADC) +=3D rzt2h_adc.o
> > > =C2=A0obj-$(CONFIG_SC27XX_ADC) +=3D sc27xx_adc.o
> > > =C2=A0obj-$(CONFIG_SD_ADC_MODULATOR) +=3D sd_adc_modulator.o
> > > =C2=A0obj-$(CONFIG_SOPHGO_CV1800B_ADC) +=3D sophgo-cv1800b-adc.o
> > > diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.=
c
> > > new file mode 100644
> > > index 000000000000..6a49788a5c67
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/rzt2h_adc.c
> > > @@ -0,0 +1,306 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/cleanup.h>
> > > +#include <linux/completion.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/iio/adc-helpers.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/io.h>
> > > +#include <linux/iopoll.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/property.h>
> > > +
> >=20
> > ...
> >=20
> > >=20
> > > +
> > > +static int rzt2h_adc_pm_runtime_resume(struct device *dev)
> > > +{
> > > +=C2=A0=C2=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> > > +=C2=A0=C2=A0 struct rzt2h_adc *adc =3D iio_priv(indio_dev);
> >=20
> > Not seeing the point of the pointer arithmetic. You can pass your devic=
e
> > pointer
> > (adc) directly in platform_set_drvdata()
> >=20
>=20
> Thanks Nuno, I'll do that. I also have another change to make to the driv=
er so
> I will have to send a new version and you'll have to give your Reviewed-b=
y
> again.
>=20
> Here's the change I'm planning to make, maybe I could keep the Reviewed-b=
y
> if you agree.
>=20
> Without this change, pm_runtime_resume_and_get() is inside the mutex,
> while pm_runtime_put_autosuspend() is outside of it. This is mostly for

I guess you meant the other way around.

> symmetry, although it's not excluded for some subtle bugs to be able to
> occur without it.
>=20

Fell free to keep my tag.

- Nuno S=C3=A1

> diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
> index 708029dc8949..79053bbc71c9 100644
> --- a/drivers/iio/adc/rzt2h_adc.c
> +++ b/drivers/iio/adc/rzt2h_adc.c
> @@ -81,9 +81,9 @@ static int rzt2h_adc_read_single(struct rzt2h_adc *adc,
> unsigned int ch, int *va
> =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pm_runtime_resume_and_get(adc->dev);
> =C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>=20
> -=C2=A0=C2=A0=C2=A0 guard(mutex)(&adc->lock);
> +=C2=A0=C2=A0=C2=A0 mutex_lock(&adc->lock);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 reinit_completion(&adc->completion);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Enable a single channel */
> @@ -106,8 +106,10 @@ static int rzt2h_adc_read_single(struct rzt2h_adc *a=
dc,
> unsigned int ch, int *va
>=20
> =C2=A0disable:
> =C2=A0=C2=A0=C2=A0=C2=A0 rzt2h_adc_start_stop(adc, false, 0);
>=20
> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&adc->lock);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_put_autosuspend(adc->dev);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> =C2=A0}
>=20
> > - Nuno S=C3=A1
>=20
> ________________________________
>=20
> Renesas Electronics Europe GmbH
> Registered Office: Arcadiastrasse 10
> DE-40472 Duesseldorf
> Commercial Registry: Duesseldorf, HRB 3708
> Managing Director: Carsten Jauch
> VAT-No.: DE 14978647
> Tax-ID-No: 105/5839/1793
>=20
> Legal Disclaimer: This e-mail communication (and any attachment/s) is
> confidential and contains proprietary information, some or all of which m=
ay be
> legally privileged. It is intended solely for the use of the individual o=
r
> entity to which it is addressed. Access to this email by anyone else is
> unauthorized. If you are not the intended recipient, any disclosure, copy=
ing,
> distribution or any action taken or omitted to be taken in reliance on it=
, is
> prohibited and may be unlawful.

