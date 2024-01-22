Return-Path: <linux-iio+bounces-1854-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E2E837244
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 20:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4751F337E4
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 19:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C908C3EA81;
	Mon, 22 Jan 2024 19:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUtkPg2q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835703D973;
	Mon, 22 Jan 2024 19:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705950988; cv=none; b=I4sf1PliNHXPrgd0Hsz0lMwx645/wHLR40tg8Fb+nwF0aygp+CGw05aD/xbhhvkUyF29e1gqZ4W/DHi0V1P7Y+OfGFOSREkofNRcwA4SBPs1RekrEYWx2je8o1nDzeB9hDMkgR5gTg0UPppDvOLtJox8TIh/I5klyy+bbXNYwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705950988; c=relaxed/simple;
	bh=3XlkGBDgaN7dZeZ50AmnI0nuYNLyzQVvKCVgID1XA3I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bsSAOrlHbYpHwroxPMzebmFLUYhUPtUO60wEh9SP2FxlVp+fSOcVRnafM+pd0jhFn8cVbnokZnpdIo6e17D0z4hii2iP1RZpuapg3yWRH1qFbdLvtpQ64cw9ClJ/biVS1+Y7nThDZ69EX60xdWXJ058tI1GnBNd7+5vsHy6o7U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUtkPg2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE11DC433C7;
	Mon, 22 Jan 2024 19:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705950988;
	bh=3XlkGBDgaN7dZeZ50AmnI0nuYNLyzQVvKCVgID1XA3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nUtkPg2qQIrIHcUicBq+UrnsemDWT0PJFaUvW6N+FeVKVrN56a61t+ejuEVOy8XCY
	 iVMLoqIGnnu1IbCvWh0qKRvyP97pDTewnlkA8zc3363iJdWj7YddORYDZW4Q1oD+bi
	 /tdimemaVMK3fcNOKcE5VwkkUWFsZ/k242cXBgBwDN0RFHy0er9rceWh0US01+S6fe
	 8DrEtFwvv5utz6zjBGAK3dO8QeTQUKZgHS3mWy62ERGbsSq7PL/MZK8TaSEFV0u1E4
	 mEj2OyK1u16qvPxi2Yo3dMMHDV2llrrteE+Cwf3bKF1u3rHy7RcZCgaC0tFtjoEJ8+
	 1ti+e1eOZ9Uaw==
Date: Mon, 22 Jan 2024 19:16:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Nuno Sa
 <nuno.sa@analog.com>
Cc: Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/8] dt-bindings: adc: ad9467: add new io-backend
 property
Message-ID: <20240122191613.2b3334af@jic23-huawei>
In-Reply-To: <a9e31bf39a04426fead96ffdb086c8c4b92fedd9.camel@gmail.com>
References: <20240119-iio-backend-v6-0-189536c35a05@analog.com>
	<20240119-iio-backend-v6-1-189536c35a05@analog.com>
	<170568455280.599772.1565973986432310014.robh@kernel.org>
	<20240122153735.GB601827-robh@kernel.org>
	<a9e31bf39a04426fead96ffdb086c8c4b92fedd9.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jan 2024 17:01:57 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2024-01-22 at 09:37 -0600, Rob Herring wrote:
> > On Fri, Jan 19, 2024 at 11:15:54AM -0600, Rob Herring wrote: =20
> > >=20
> > > On Fri, 19 Jan 2024 17:00:47 +0100, Nuno Sa wrote: =20
> > > > The ad9467 will make use of the new IIO backend framework which is a
> > > > provider - consumer interface where IIO backends provide services to
> > > > consumers. As such, and being this device a consumer,=C2=A0 add the=
 new
> > > > generic io-backend property to the bindings.
> > > >=20
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > ---
> > > > =C2=A0Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 4=
 ++++
> > > > =C2=A01 file changed, 4 insertions(+)
> > > >  =20
> > >=20
> > > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_ch=
eck'
> > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > >=20
> > > yamllint warnings/errors:
> > >=20
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/dt-review-
> > > ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml: i=
o-backends:
> > > missing type definition =20
> >=20
> > Are you going to update the GH PR so I can apply adding io-backends?
> >=20
> >  =20
>=20
> Yes, I can do that. I was thinking you preferred to have the second user =
so I was
> planning in updating only after sending out that series (or Olivier if he=
 ends up
> sending his series first).
>=20
> Olivier already gave his ack in [1], but I guess you would also like Jona=
than's ack
> on that PULL right?
>=20
> Jonathan,
> would that be something you can do? The pull is in [2]... Maybe give your
> comments/review in there if any.

Looks like there is a comment on Rob still to address about io-backend-name=
s.
Otherwise I'm fine with it.

J

>=20
>=20
> [2]: https://github.com/devicetree-org/dt-schema/pull/120
> [1]: https://lore.kernel.org/linux-iio/4b1ffdc4-edce-4a69-a30b-45c29741dc=
2c@foss.st.com/
>=20
> - Nuno S=C3=A1
>=20


