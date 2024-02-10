Return-Path: <linux-iio+bounces-2391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BB1850668
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 21:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3BE9B24478
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 20:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070375FBA9;
	Sat, 10 Feb 2024 20:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2Dwvp8n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5B5F87F;
	Sat, 10 Feb 2024 20:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707598694; cv=none; b=WbW2w2hAm8em1lR+Nfm33Lmyt9RDfreTGMV+odpeOQ1RMzjP4ekaG4o+KkzsxjNctN+kHs9QeJ3WJOkY7dQp5nAwjf5kn86MJsW+fLF7t8BAXs/No8nF8uyEpwYAOQzt7P46jp5aoAFr5kF8tTgHAnT5+te27blLGXffQo4ESAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707598694; c=relaxed/simple;
	bh=frsGjM08bo4R9wnt3danPJkLgbxOoGuT2N59cRQbe0k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=br2Iq3/BXregQq6OGIB93GD1QEu6aKz6fTmLKtvSLtPKkR8t8Gw/lInDblS1Uy1K68y/uueR8Q9HwCbyhEh0gVNi0+1xVU2qVuh/tr2IsrZaK4IUdTCqaT1f1ZxJTHeiTRio8o8D4NvkHaUHEhrwrpXXanWWagUS1rztHlVHTYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2Dwvp8n; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50eac018059so2708165e87.0;
        Sat, 10 Feb 2024 12:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707598691; x=1708203491; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=frsGjM08bo4R9wnt3danPJkLgbxOoGuT2N59cRQbe0k=;
        b=N2Dwvp8nA+kKIldNxsNnQR5N27JDqSV0tc5Lrxz7mAan5jQPgfgmE3V3IK8NSqDR+6
         5VX4A620VQeTj5Ff4qhj9GldpkXtlTJPKS/KTedhtxrWSsaWJd5IAIFHSTXmDzeF6PkK
         l8Rke1hLuWROExobmX9XopzUSqxNGsS1NbAW/o3T67Z4vtgZKD91b034+dFgE+5viCjx
         AvQoPcy8vXp6JAdc8LVHFPAjSjg7lDpmyN9iA5wGV3DN3t4LYGsX/tTtfZ6SJPuYRpu8
         /SQ2NTC8wZ7ex6ddULksxXorutIeot3z+BLuO7uhEfkmQMPbC2I1PEC3B45EBUrLEzsD
         VxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707598691; x=1708203491;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=frsGjM08bo4R9wnt3danPJkLgbxOoGuT2N59cRQbe0k=;
        b=QWXxmtNurQJ41lxCP/JDNVHI+XtwXrzXv1MfeQqeCYD0x4+sTSb5nJlNK1IBNMVG7R
         iEBGzS3S0dhD/eYSieTqDrE07lKD/moQA7DmWf+sX1LmdMe0doBV+TTE/RRxVdheaWOu
         IK2A/NiOqy4L4baYD674QhQfMkb/VDgxHEVZKZV4Fq0Pzr4uU4kyq5w6lp0QCuX2Zy+c
         VFPlnermDQLbs+jdfDVVi/qrtbyLVlOm18E+Ami+l5mWsRRn2ly1DdzCpFYzEwbqjp0b
         ujBu3pqBxXYxTd3N8rp4tNhgzpe4SkTOTLpZhnuzzd1Z+T/dMY4WpRLOAmtya6rePzgm
         fa7w==
X-Forwarded-Encrypted: i=1; AJvYcCV9P09qNgLk88gJ1bEB9cqfD/CUS4u8pEreFnOYMvhp9RW8Pa6Ef+Vu/OCG8apRpVMYadgeAtOVRIDaNzgo+j2DlTAVFG+AZZZLgA==
X-Gm-Message-State: AOJu0YzndjJUg0hOjEwSQ28Dj2dkrmOLL1YBSYoJULH3qOHKR4PJbEfA
	groZ0DFMqYtOp7q667pzp1r0aoFoGWfz5Q3pRVjDIMWEwS85eR9a
X-Google-Smtp-Source: AGHT+IEhT/5dLxh5HTLh6hGgZhYH7EX4es44O+PqhQpmKZ7vS8/Cy8kb5+2nzIRui+//NhqVda6rDw==
X-Received: by 2002:a05:6512:2246:b0:511:5326:54d8 with SMTP id i6-20020a056512224600b00511532654d8mr1865115lfu.52.1707598690647;
        Sat, 10 Feb 2024 12:58:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWk8iTijx78QTXMOET7RYZE3FSZWqniEK7NbX/jAHXILSH2q4YcjjRlZswhqOfF5O6HohYxjahTEoYXSXcf3rO5UocDCX6CsjbO+5WL+BOo7EFC8GmzPwVDAkZm05KO131uG3bE5lh/l+KtNMnnksbN0In/mIaAKRFc8ENy0z6dJ4+Hqg7bIymMRTPM3djywzeZSN//R5f+S8YhsvKgb3oROxJ4A6Sy6h/aso1dcjDfcnRqh9Dk+y29Zk8ow41a5l/sA8x8yZQHDGy6/7F1pXEJD1Xo/UfMMRHPgsAHRACGiWGxBjS6yFQfqZdogdtCyMslRoDRwLqkpGDK6rUyaXzodVUsEEn2YKt3YjFJjBf6iDwco98sZA0ZUNJpZewGkw==
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id l9-20020a1c7909000000b0040e527602c8sm4203308wme.9.2024.02.10.12.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 12:58:10 -0800 (PST)
Message-ID: <e2568807fa54b7a8719aab4c9ce19a7d4425082b.camel@gmail.com>
Subject: Re: [PATCH v10 7/7] iio: adc: adi-axi-adc: move to backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Sat, 10 Feb 2024 21:58:09 +0100
In-Reply-To: <CAHp75Vd1KkZHFon205O8sNF_zo6G5-m1vZNpnZZNr-V1CTP_VQ@mail.gmail.com>
References: <20240209-iio-backend-v10-0-3ed842064318@analog.com>
	 <20240209-iio-backend-v10-7-3ed842064318@analog.com>
	 <CAHp75Vd1KkZHFon205O8sNF_zo6G5-m1vZNpnZZNr-V1CTP_VQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-09 at 18:45 +0200, Andy Shevchenko wrote:
> On Fri, Feb 9, 2024 at 5:26=E2=80=AFPM Nuno Sa <nuno.sa@analog.com> wrote=
:
> >=20
> > Move to the IIO backend framework. Devices supported by adi-axi-adc now
> > register themselves as backend devices.
>=20
> ...
>=20
> > -#include <linux/iio/iio.h>
> > -#include <linux/iio/sysfs.h>
> > -#include <linux/iio/buffer.h>
> > -#include <linux/iio/buffer-dmaengine.h>
> > -
> > =C2=A0#include <linux/fpga/adi-axi-common.h>
> > -#include <linux/iio/adc/adi-axi-adc.h>
>=20
> + Blank line?
>=20

can be...

> > +#include <linux/iio/backend.h>
> > +#include <linux/iio/buffer-dmaengine.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/iio.h>
>=20
> ...
>=20
> > +static int axi_adc_enable(struct iio_backend *back)
> > =C2=A0{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct adi_axi_adc_state *st =3D =
iio_backend_get_priv(back);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_set_bits(st->regma=
p, ADI_AXI_REG_RSTN,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ADI_AXI_REG_RSTN_MMCM_RSTN);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return ret;
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fsleep(10);
>=20
> Would be nice to have a comment that probably the datasheet defines
> the minimum timeout for reset. Ah and you decreased it 1000x times,
> why?
>=20

Arghh, always forget that fsleep() is us... That said, there's no minimum t=
imeout
specified in the docs. I guess the original developer has the sleeps out of=
 habit or
some "hidden" knowledge. In my testing I did not noticed anything weird wit=
h the
10us. I'll move back to the original timeout though. I can then check and m=
ake sure
10us is enough and send a follow up patch.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return regmap_set_bits(st->regmap=
, ADI_AXI_REG_RSTN,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADI_AXI_REG_RSTN_RSTN |
> > ADI_AXI_REG_RSTN_MMCM_RSTN);
> > =C2=A0}
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 expected_ver =3D (unsigned int *)=
device_get_match_data(&pdev->dev);
>=20
> expected_ver should have const and you can drop the casting IIUC.

Right...

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!expected_ver)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -ENODEV;
>=20


