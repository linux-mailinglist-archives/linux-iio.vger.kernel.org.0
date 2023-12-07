Return-Path: <linux-iio+bounces-703-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D7E8083F3
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 10:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328A3283CDC
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 09:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C821134AF;
	Thu,  7 Dec 2023 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bdiu6Q0p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4017210E7
	for <linux-iio@vger.kernel.org>; Thu,  7 Dec 2023 01:10:27 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3334254cfa3so370634f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 07 Dec 2023 01:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701940225; x=1702545025; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=meXn0PuUEImHxkggbvFizEL/O+xU769tHcIYvum6eqA=;
        b=Bdiu6Q0pvNb5cEXyFdz4V9RVonhB+bTQowKZ/+M3gZwL3v0FbtAJoOjVNdC9k723Xt
         YW6uMs6+/oluOTWmIlrp5c6wwM1GZOeDNm7sm2+Rr3I9Kfk895tNGMj0xydzJQCY1xCV
         3LCUE++4rNGDrfrfl+i2HVOhK/1Ng7Wl5tC50vVVKUF1CAMYfPDf5qEx0oFcFj5egj9G
         MHd3nYzDfTXBtS9R0hy+Mm/BJEaL9e4BEhmNSUQpz9kekj3K8cZWmT+3ABFQNwg00ebq
         mCMy9ACebWPU++ipLJu3z1F9lkcAnO2zXKU+4BpTWjm/6xlT7pWxCq/LQBL1Qbbtu0+7
         G2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701940225; x=1702545025;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=meXn0PuUEImHxkggbvFizEL/O+xU769tHcIYvum6eqA=;
        b=djlKQZc9K2zsKQH3kfNOjn8Ks6YySQwUQtlyBzQH050280cYfmrU7GMsD5ERlW9uOa
         FXdbx3Lj3GMLm42mWtg2oxdMsZ5QJzPUfkWHOmYNTAu+EFT5tbWHLqxXp6HuMi4yUP7C
         16kVa2k36Zb7zbdfrUSyXnNXQEfHLSbo1gimZuS4z0ZjY44DUbTT9XAPEwsjkIhvgOz1
         0VnpcTTKGV4ZKXsVK1i/5hJPWmyAlN00dgOzE621COjpPI36oE/f9oR/TIx8rVjmBUwU
         18g4suMTcM71tGu2XUsr2vJdpHCbv6Ge5bjmHAGagz+WMKDWeRiCw8lR+K+BjPKrZth9
         iI9Q==
X-Gm-Message-State: AOJu0Yzhs1DCbdqarS12TQ+xvtpn8UlrRQ0mQE0L7Wkoj6yGK75OD3RL
	vPzh3XSyYdYh0oDHPk/nljw=
X-Google-Smtp-Source: AGHT+IF8801xPmkdo10VkbBDQdyiaiugmOctFlbN1Rp3/5PWDn5iMfx7uWTf53vtz84Cc331d9mJYg==
X-Received: by 2002:a5d:4bd0:0:b0:333:9ed:ee4 with SMTP id l16-20020a5d4bd0000000b0033309ed0ee4mr2824053wrt.20.1701940225425;
        Thu, 07 Dec 2023 01:10:25 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id w12-20020a5d608c000000b003335ebde680sm895064wrt.75.2023.12.07.01.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 01:10:25 -0800 (PST)
Message-ID: <720a93ea28b76068335ecdbb8976ded296db535e.camel@gmail.com>
Subject: Re: [PATCH 3/8] iio: adc: ad9467: add mutex to struct ad9467_state
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 07 Dec 2023 10:10:24 +0100
In-Reply-To: <CAMknhBEEqnTRQBLzeXuNSLzSgZB=x_jASSWVZDjpo3YVS5wq3A@mail.gmail.com>
References: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com>
	 <20231205-iio-backend-prep-v1-3-7c9bc18d612b@analog.com>
	 <CAMknhBEEqnTRQBLzeXuNSLzSgZB=x_jASSWVZDjpo3YVS5wq3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-06 at 16:27 -0600, David Lechner wrote:
> On Tue, Dec 5, 2023 at 11:06=E2=80=AFAM Nuno Sa via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > When calling ad9467_set_scale(), multiple calls to ad9467_spi_write()
> > are done which means we need to properly protect the whole operation so
> > we are sure we will be in a sane state if two concurrent calls occur.
>=20
>=20
> ad9467_outputmode_set() also has multiple calls to ad9467_spi_write().
> Does it need similar protection?
>=20

Just called during probe (of the axi-adc driver) before registering the IIO=
 device.
We should not need the lock in there (for now).

> >=20
> > Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/adc/ad9467.c | 7 ++++++-
> > =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > index 0f2dce730a0a..badbef2ce9f8 100644
> > --- a/drivers/iio/adc/ad9467.c
> > +++ b/drivers/iio/adc/ad9467.c
> > @@ -4,8 +4,9 @@
> > =C2=A0 *
> > =C2=A0 * Copyright 2012-2020 Analog Devices Inc.
> > =C2=A0 */
> > -
> > +#include <linux/cleanup.h>
> > =C2=A0#include <linux/module.h>
> > +#include <linux/mutex.h>
> > =C2=A0#include <linux/device.h>
> > =C2=A0#include <linux/kernel.h>
> > =C2=A0#include <linux/slab.h>
> > @@ -121,6 +122,8 @@ struct ad9467_state {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 output_mode;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gpio_desc=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *pwrdown_gpio;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* ensure consistent state obtain=
ed on multiple related accesses */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mutex=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 lock;
> > =C2=A0};
> >=20
> > =C2=A0static int ad9467_spi_read(struct spi_device *spi, unsigned int r=
eg)
> > @@ -161,6 +164,7 @@ static int ad9467_reg_access(struct adi_axi_adc_con=
v *conv,
> > unsigned int reg,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (readval =3D=3D NULL) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 guard(mutex)(&st->lock);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D ad9467_spi_write(spi, reg, writeval);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n ret;
> > @@ -310,6 +314,7 @@ static int ad9467_set_scale(struct adi_axi_adc_conv=
 *conv,
> > int val, int val2)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (scale_val[0] !=3D val || scale_val[1] !=3D val2)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conti=
nue;
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 guard(mutex)(&st->lock);
>=20
> Why is the guard inside of the for loop instead of outside?
>=20
> __ad9467_get_scale() called in this loop calls ad9467_spi_read() too,

Hmm, am I missing something? __ad9467_get_scale() is not doing any spi acce=
ss, is it?
I think you made confusion with the version without underscore...

- Nuno S=C3=A1
>=20

