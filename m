Return-Path: <linux-iio+bounces-3076-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41282866E19
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 10:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC56C285E8E
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 09:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08ABB537E1;
	Mon, 26 Feb 2024 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8U2WHPb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4CD535BD;
	Mon, 26 Feb 2024 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936871; cv=none; b=o17rYzs8SeeZBivaHRJH65qvH4FMpgMGesnaCTuIy51zz+e++QOg3ZHQSuluyqzK2IAa4XsIbu/4rQFHRpu0spWXOKxFPQQcXy8qVT6QiYIuuTPipbSfJDMCSDb8/0XBnFZCZoy6GoMs26QLQETFIV3gS6jF8VY9rvwj586LcWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936871; c=relaxed/simple;
	bh=5IK9YEu5LpRbO3a0D2y1Z0LC+GTmtRDyRX5EeMSt4FE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rfl9TtRvxZvYIPt7JdBA6Q19iIzXIn+jPPySABsxKbZ7pCdT+eJ0B5JCuXHXwlMa81sZADz5VAl9HuPBPOGA4IIqSicCHy/0ez49PhfsECK7zOySPI0wmOgA8dNvPAMegNK/QyUKDiWxLQT2SxLfA7v2cfBfnyow8AFWyGSu1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8U2WHPb; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3d484a58f6so383610866b.3;
        Mon, 26 Feb 2024 00:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708936867; x=1709541667; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6MmkuSp+V5002jD6o/Tdb2BxK0DH+J3pftN7LxPwJO8=;
        b=X8U2WHPbm97vn8qoLl2A1ml4B4aemkZF9vJi2edxOTCp8nwYGBo9FhYfd1Bdro0OES
         CQSDqoahByWCQ3ikt5BLPohljwm/Aun2OLcVXQVYVN4zNteKhLJhWUeT/ARqEZ5BOwl0
         h8lUaf7kXjHKhfFcH2jinGHV4KNB6msUHfSH4cwbGh8QiFmI7QAQVKTmlATH8SqJjmPJ
         X8aV+7whQFE4hDGl1rZAbhFjwGHzqP5eHJAxzLhxJL9iUen1ddx/LpCIP47CEP53Tbdw
         OC3TUHckohNMIMkjufc90n8AASYjmrO0MSVBMRD2Qqar8naaV8+Mwb5ZHudA985Y7Gbm
         QDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708936867; x=1709541667;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6MmkuSp+V5002jD6o/Tdb2BxK0DH+J3pftN7LxPwJO8=;
        b=N0kj10vZclelQIJRtm2H9HbLmP27hw2qOkyr7b44UVYBC0y3r+QYJIGNpDLIipziiA
         E77bBI+BA47pUbLvpl6FhBaWwN8a1SRwwnIKwqOYAmi8f/oCeOEChR92oSYguzDin+sX
         wHhwB++kgSET3/CjPPJUktw/2r6CSk+FZxtBUHejqHPCdYGCzr7NZM0cWMYieYzUtlmb
         kNihS7VMKIfRB04d0DosaEUSEKKn70UCqvdwvXAMeCGcOwZDHShs9+weSrxH/moOWd5o
         sZ/7LoN/LxFcJiBbTlInOk/6r8l09bGoMvDSe8JoXvXJif1yhqQfqCEy/e9fSsO8ydnb
         fnXA==
X-Forwarded-Encrypted: i=1; AJvYcCWEOMeBlwXFDZ/mBh1zFmceqFMhHZWC373u4Uvm92QluDFyaZwHkg2UEqD2j2BKhjKgtq3WoME+I0CcMQCKnBZeUDXBBsxDXUJhiA==
X-Gm-Message-State: AOJu0YxLBQiHp2j/9hNxDZjTHXHcV9sJsahyd4Lqhp3AZBXJreKZsBn7
	NqAHu5Nt+bopwSV7A9GcgCazs4a8k5eZlMyQUzEv6HfsfcZKulhU
X-Google-Smtp-Source: AGHT+IGoqqxAAeP1lcaD5CUYP2MKcTr6BeVZ8S2FR8JVff3XUM6hYA4b/AWw8nYqcLuZkdGcHqksvg==
X-Received: by 2002:a17:906:e283:b0:a3f:2f67:4847 with SMTP id gg3-20020a170906e28300b00a3f2f674847mr3703043ejb.19.1708936867300;
        Mon, 26 Feb 2024 00:41:07 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id e5-20020a170906504500b00a3f5c39bf2asm2196768ejk.0.2024.02.26.00.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 00:41:07 -0800 (PST)
Message-ID: <7ae2a3cf0fefec976de2b77d02d970efcea45abc.camel@gmail.com>
Subject: Re: [PATCH 3/6] iio: temperature: ltc2983: convert to
 dev_err_probe()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Date: Mon, 26 Feb 2024 09:41:06 +0100
In-Reply-To: <20240224184341.791e5263@jic23-huawei>
References: <20240222-ltc2983-misc-improv-v1-0-cf7d4457e98c@analog.com>
	 <20240222-ltc2983-misc-improv-v1-3-cf7d4457e98c@analog.com>
	 <20240224184341.791e5263@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-02-24 at 18:44 +0000, Jonathan Cameron wrote:
> On Thu, 22 Feb 2024 13:55:54 +0100
> Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> > Use dev_err_probe() in the probe() path. While at it, made some simple
> > improvements:
> > =C2=A0* Declare a struct device *dev helper. This also makes the style =
more
> > =C2=A0=C2=A0 consistent (some places the helper was used and not in oth=
er places);
> > =C2=A0* Explicitly included the err.h and errno.h headers;
> > =C2=A0* Removed an useless else if().
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>=20
> Hmm. Up to you whether you rebase on top of the device_for_each_child_nod=
e_scoped()
> patch - mostly depends if you give the new version a reviewed by or not!
>=20

Already gave my tag. I see you're already doing some dev_err_probe() in the=
re so I
can just add the missing ones after rebasing.=20

> If they land in the other order I can fix it up whilst applying.
> After that series is in place though the number of places this will do
>=20
> 	dev_err_probe(dev, ret, "message\n");
> 	return ERR_PTR(ret);
>=20
> Makes me wonder whether
> 	return ERR_PTR(dev_err_probe(dev, ret, "message\n")); is
> too ugly or not?
>=20

Yeah, IMO, that's a bit ugly :). We may making it slightly better for the d=
river by
adding a macro for the above.

> Maybe we need a dev_err_probe_ret_ptr() but that's also ugly.
>=20

I almost send a patch for that as well. I think this driver is indeed a goo=
d
candidate for introducing an helper like this. My thought on naming was som=
ething
like dev_errp_probe() though.

> One comment inline which is why I didn't just pick this up today and send
> a new version of this patch in my series.
>=20
> Jonathan
>=20
> > ---
> > =C2=A0drivers/iio/temperature/ltc2983.c | 190 ++++++++++++++++++++-----=
-------------
> > =C2=A01 file changed, 98 insertions(+), 92 deletions(-)
> >=20
> > diff --git a/drivers/iio/temperature/ltc2983.c
> > b/drivers/iio/temperature/ltc2983.c
> > index 23f2d43fc040..4b096aa3fbd8 100644
> > --- a/drivers/iio/temperature/ltc2983.c
> > +++ b/drivers/iio/temperature/ltc2983.c
> > @@ -8,6 +8,8 @@
> > =C2=A0#include <linux/bitfield.h>
> > =C2=A0#include <linux/completion.h>
> > =C2=A0#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > =C2=A0#include <linux/kernel.h>
> > =C2=A0#include <linux/iio/iio.h>
> > =C2=A0#include <linux/interrupt.h>
> > @@ -656,11 +658,12 @@ ltc2983_thermocouple_new(const struct fwnode_hand=
le *child,
> > struct ltc2983_data
> > =C2=A0			 const struct ltc2983_sensor *sensor)
> > =C2=A0{
> > =C2=A0	struct ltc2983_thermocouple *thermo;
> > +	struct device *dev =3D &st->spi->dev;
> > =C2=A0	struct fwnode_handle *ref;
> > =C2=A0	u32 oc_current;
> > =C2=A0	int ret;
> > =C2=A0
> > -	thermo =3D devm_kzalloc(&st->spi->dev, sizeof(*thermo), GFP_KERNEL);
> > +	thermo =3D devm_kzalloc(dev, sizeof(*thermo), GFP_KERNEL);
> > =C2=A0	if (!thermo)
> > =C2=A0		return ERR_PTR(-ENOMEM);
> > =C2=A0
> > @@ -687,8 +690,9 @@ ltc2983_thermocouple_new(const struct fwnode_handle=
 *child,
> > struct ltc2983_data
> > =C2=A0					LTC2983_THERMOCOUPLE_OC_CURR(3);
> > =C2=A0			break;
> > =C2=A0		default:
> > -			dev_err(&st->spi->dev,
> > -				"Invalid open circuit current:%u", oc_current);
> > +			dev_err_probe(dev, -EINVAL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid open circuit current:%u",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 oc_current);
> Hmm. I'm in two minds on these.=20
> We don't get the advantage of return dev_error_probe() and I'm not seeing=
 these
> hitting EPROBE_DEFER so getting the debug advantages.

I would argue on logging (output) consistency (I think Andy pointed that in=
 some
other series - I think my IIO backend stuff).

- Nuno S=C3=A1


