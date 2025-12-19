Return-Path: <linux-iio+bounces-27231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA4ACD14DB
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 19:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C6DE30E81F8
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 18:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119313563F2;
	Fri, 19 Dec 2025 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiRz+/n9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBB93563EE
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166375; cv=none; b=tHW0vBegyAR6AhCQMemImyG2G97wLpZ+tLUwVi91kLTtFSO+GUgj7Yfco+4dMYtlEX/ztUn3ibciiOrKcfbOx1Iz02UTKZPwRjKWtiaiDTo4O8wqz+mg35MKxbWNePn9n/E0bSIiXClm1o18qfcwuuMiQugVa6c6gm6Z03pm21E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166375; c=relaxed/simple;
	bh=irh10DciPGhv3B1A/JTeokXhCulrMM8aREHPMrm5XEY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X+4PZcEK5vIt18raKmawDWq4Wfzf1vUGYgyT9kk2ZkB9yE0uMLgp7VhTprSLo8kila4FKS/TuHRvsTbSEvLgLD8a23lmH2ATDhdnpRWm/fwaGj4AxhB8RLZdl9fth9zX3X7RUTFNDHJ2FO0j2J+9l6D/7o+33hruIsyNufyEsmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiRz+/n9; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42e2e77f519so1449261f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 09:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766166372; x=1766771172; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R454StkDgUY1pasY+RZbwNEW6QTcNs0PObjgvb7WhRM=;
        b=kiRz+/n9ujHEX2fRRKhRJ6MfUZQ8zpMAljaISmNgEoRXiP88Nnvv+Z3ooa2JIcEZIn
         M9qut9dCeXoChmxxSxg5w0l4eY7Cua+VbAHwBPBnSgnsLJWFD6wGH8stwBSWLKEmrWUP
         NxGEQXH2+DJtFAksP8lPwUa/0jo1rfo9jMt1/5wE8e8dUi1FfiDb8ZQOEKaZiKcae1Lk
         j2kYzpAUdMZDGuEvslCnfvwawO0wsvG03pvyrNfloJ7gMfP5EfjZabqCBrl/BwqOyr8I
         /1wgDYmi1ToDvgfjbASC3wgbja14FAljXEQy5nLndNQOh6eFPAkI2m0Hy+ZYfFLzLbC3
         RBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766166372; x=1766771172;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R454StkDgUY1pasY+RZbwNEW6QTcNs0PObjgvb7WhRM=;
        b=LniVv94lTW3aLv68+qn7X4ZxtAPf+hAq9KjEi0QzvcsUuW6Lp2Q9lyCWu+I4/JQUtM
         ss0EWiGENyR3JTPMLdSqWykxrQlBMR7DtrUNe/3pFQX2rB0oZEnVoa3k5oR1S7Tw0bu0
         +6dl/KuctZ9ZNROGN1bqjjpFp5BsXejS5vmbyyRAocOd5FgqGBU3yMJmjQsWj7Az+K6T
         4p2sTWVQnlZk+ZNNp9azYTK0m1FB7S+E/DLFlYbkroxKz3H1N0VvBjVM0rHfDj5K4zcx
         qpE4oQVKfO8bwCXbbKFIXYjBJYO8lJp3sY7zIpm+UlUNAr15UfPSfizbay/hzeBG66mj
         wsPw==
X-Forwarded-Encrypted: i=1; AJvYcCUpw/uhou84WzRfT7BBD12tnlPQ0ry4xVoLY1HYbyboo7+mz83iCgZENDerkqHip6ZZLiuQ7TVapHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKkUdfoS3AMBYZpOQOgIPi2Pscd/VmrnkZIsJq4rxpsE7OnhXp
	XNxmSyfOmGtnp6pqFaT7naAJeXVR1vaz8y9ztrCzKpNp6GrcCfGn52AA
X-Gm-Gg: AY/fxX4SAbhJReJ7F8TOQS7yMoM1Od+st9fSDx4yGXDF0a2ZMzNxxeeD7YebLzbE7Se
	QCLgvaOtZtBqxmN/74aP7G5hYxXhOW6vdbhkbmYlcY9niO5RVZejWnu8AkbpzpWmJNM5KAH4wwv
	UG9M+YnsFCWahY5v3g5j668yLwexXdlw4Kg5dd9nK8ydigK0vwXuRbw70uA6pj4dw7ZARAInLdW
	Xj9l5MlNW3jV+iap+k6vtBtBQ3QoTqLqNdFGnkN9jXMFKity9+iXkVyRcdnO/dhMsxURi+iW18+
	kGR1oxruqjsulIWiGZhTxzu0kYTET5QL7A5TMsgbpagjEI4bfm2Nvg1p4r/4mSAxt/ZdBqS7g6q
	dnVnS8ebK1RB/DepN2zh1VXqMYkyLOdiRLIwwaLCtPYywkEzsgNOFYY9BCdMcsiJTdbisPXwoGG
	DuQ6KMDcNkx6AcMV7TIgLTb1gj+tJcig==
X-Google-Smtp-Source: AGHT+IGWPEuVRXwN3JzKCdS8JH+D8Wka3VeXw3J7I2BxHyebQssS8bcqkm/+ZbEN0TW3I9+Czdaz2A==
X-Received: by 2002:a05:6000:178c:b0:431:104:6daf with SMTP id ffacd0b85a97d-4324e709ab3mr4707087f8f.54.1766166372162;
        Fri, 19 Dec 2025 09:46:12 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa4749sm5843396f8f.37.2025.12.19.09.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 09:46:11 -0800 (PST)
Message-ID: <c513acf3003d1e1129d1f76bf285b79c888f78b5.camel@gmail.com>
Subject: Re: [PATCH v2] iio: dac: adi-axi-dac: Make use of dev_err_probe()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Date: Fri, 19 Dec 2025 17:46:52 +0000
In-Reply-To: <20251219162129.00006aa9@huawei.com>
References: 
	<20251219-iio-axi-dac-minor-changes-v2-1-e9fccc019b01@analog.com>
	 <20251219162129.00006aa9@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-12-19 at 16:21 +0000, Jonathan Cameron wrote:
> On Fri, 19 Dec 2025 15:54:29 +0000
> Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Be consistent and use dev_err_probe() as in all other places in the
> > .probe() path.
> >=20
> > While at it, remove the line break in the version condition. Yes, it
> > goes over the 80 column limit but I do think the line break hurts
> > readability in this case. And use a struct device *dev helper for
> > neater code.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> This has turned into a bit of an X and Y and Z patch.=C2=A0 In theory
> should be split up but I guess it's not too bad.

Yeah, I kind of felt a bit like that when looking at the patch diff.
>=20
> However I'm not sure why you fixed one indent and left a bunch of similar
> cases looking worse?
>=20
> Jonathan
>=20
> > ---
> > Ended up dropping the dev_info() -> dev_dbg() patch.
> > ---
> > Changes in v2:
> > - Patch 1
> > =C2=A0 * Added helper struct device variable as suggested by Andy;
> > =C2=A0 * Removed the braces as suggested by David.
> > - Link to v1:
> > https://lore.kernel.org/r/20251203-iio-axi-dac-minor-changes-v1-0-b5465=
0cbeb33@analog.com
> > ---
> > =C2=A0drivers/iio/dac/adi-axi-dac.c | 63 +++++++++++++++++++++---------=
-------------
> > =C2=A01 file changed, 30 insertions(+), 33 deletions(-)
> >=20
> > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-da=
c.c
> > index 0d525272a8a8..ceab9f6fa3b4 100644
> > --- a/drivers/iio/dac/adi-axi-dac.c
> > +++ b/drivers/iio/dac/adi-axi-dac.c
>=20
>=20
> > =C2=A0	/* Let's get the core read only configuration */
> > =C2=A0	ret =3D regmap_read(st->regmap, AXI_DAC_CONFIG_REG, &st->reg_con=
fig);
> > @@ -975,34 +972,34 @@ static int axi_dac_probe(struct platform_device *=
pdev)
> > =C2=A0
> > =C2=A0	mutex_init(&st->lock);
> > =C2=A0
> > -	ret =3D devm_iio_backend_register(&pdev->dev, st->info->backend_info,=
 st);
> > +	ret =3D devm_iio_backend_register(dev, st->info->backend_info, st);
> > =C2=A0	if (ret)
> > -		return dev_err_probe(&pdev->dev, ret,
> > +		return dev_err_probe(dev, ret,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to register iio backend\n");
> > =C2=A0
> > -	device_for_each_child_node_scoped(&pdev->dev, child) {
> > +	device_for_each_child_node_scoped(dev, child) {
> > =C2=A0		int val;
> > =C2=A0
> > =C2=A0		if (!st->info->has_child_nodes)
> > -			return dev_err_probe(&pdev->dev, -EINVAL,
> > +			return dev_err_probe(dev, -EINVAL,
> > =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 "invalid fdt axi-dac compatible.");
> > =C2=A0
> > =C2=A0		/* Processing only reg 0 node */
> > =C2=A0		ret =3D fwnode_property_read_u32(child, "reg", &val);
> > =C2=A0		if (ret)
> > -			return dev_err_probe(&pdev->dev, ret,
> > +			return dev_err_probe(dev, ret,
> > =C2=A0						"invalid reg property.");
> > =C2=A0		if (val !=3D 0)
> > -			return dev_err_probe(&pdev->dev, -EINVAL,
> > +			return dev_err_probe(dev, -EINVAL,
> > =C2=A0						"invalid node address.");
> > =C2=A0
> > =C2=A0		ret =3D axi_dac_create_platform_device(st, child);
> > =C2=A0		if (ret)
> > -			return dev_err_probe(&pdev->dev, -EINVAL,
> > -						"cannot create device.");
> > +			return dev_err_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 "cannot create device.");
> I'm not against this fixing up the indent but why not the ones above htat=
 look
> just as bad?

Hmm I think this one were my automated fingers... Maybe the best thing to d=
o is
to split up the patches and take care of these indents in the patch adding
the local struct device *dev variable. Does that works for you?

- Nuno S=C3=A1
=20


>=20

