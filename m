Return-Path: <linux-iio+bounces-8286-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B8C94953C
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 18:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578EF1C20B10
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 16:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C331642AAA;
	Tue,  6 Aug 2024 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEGZkpz0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDDC15CB;
	Tue,  6 Aug 2024 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960256; cv=none; b=stPE2XpJG1SMkq7jXsDjIdispeCcb/oRQc6GNVUg6u4FuQeBRPWnHCBqqGQO+QNPS0qJ1CONlSkAzxvQpEFd+eI2okcX7QMaTlMKLHLoSUwjOlzBtUcGH1cnzlSYbWKzrrWxDTGSrpXIcl6MhfsZAZjGyzAk9Oq9NsucD5QtJ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960256; c=relaxed/simple;
	bh=fjSPPJzmJA8JFAafZqpeE+4EtoL2c7ZzAn6rqHVfCA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hK/QYI4NJxAqaTiiIHYBtvbkgX2bhsjaFK/9vRpa5Cm8eVBjrezYbC2v25Q0dCxnGouZOlmsZLZq3vFrcZkcjT3p3Mmpi4GDs3VqDLoXA1G/cgldhRQCZa6KbX0s7euWZAvK8yE93KkBlKymedEyW1xEPNe/3bUiq4ODrZhgVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEGZkpz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB1AC32786;
	Tue,  6 Aug 2024 16:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722960256;
	bh=fjSPPJzmJA8JFAafZqpeE+4EtoL2c7ZzAn6rqHVfCA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iEGZkpz08j8sHFKGt/itZUIkWgpq74ZcSZJB2JZ5/QyMoYgu4RKq4J0t9+lxA6Xb9
	 pRGZjolLe8xi7r72aj4MhBIyH5wtbePPfz80EBVaxzFWJQJ02oOi8ZN5tNPOimXnH0
	 RaRhE0sQXzR3/g1NfkZ78r2UjGkqAhcbQqPv+1bG/4T4+Qhx9MkwyqN5fRbhcBIdTa
	 f6WW2ATS3P6YOtbIGO9RaRWdYRCA5i/sGMy61jceJC/VhQhGZXE3ZiihkLlCxp0KGo
	 tNZBB9fLgA7E26EjuzqQwy/LH6WgXnabHfbbKWsxNLk9CZpaZAYmz340JiAvK9MSpK
	 PirhR3m/LzoNg==
Date: Tue, 6 Aug 2024 17:04:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>, lars@metafoo.de,
 alexandru.tachici@analog.com, Jonathan.Cameron@huawei.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Dumitru Ceclan
 <dumitru.ceclan@analog.com>
Subject: Re: [PATCH] iio: adc: ad7124: fix DT configuration parsing
Message-ID: <20240806170410.4a967dee@jic23-huawei>
In-Reply-To: <15304301efe5c23d55984f8a1f2a5016d7be213d.camel@gmail.com>
References: <20240806085133.114547-1-dumitru.ceclan@analog.com>
	<15304301efe5c23d55984f8a1f2a5016d7be213d.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 06 Aug 2024 12:45:06 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2024-08-06 at 11:51 +0300, Dumitru Ceclan wrote:
> > The cfg pointer is set before reading the channel number that the
> > configuration should point to. This causes configurations to be shifted
> > by one channel.
> > For example setting bipolar to the first channel defined in the DT will
> > cause bipolar mode to be active on the second defined channel.
> >=20
> > Fix by moving the cfg pointer setting after reading the channel number.
> >=20
> > Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
> > Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

>=20
> > =C2=A0drivers/iio/adc/ad7124.c | 3 +--
> > =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> > index 3beed78496c5..672d41bac8ca 100644
> > --- a/drivers/iio/adc/ad7124.c
> > +++ b/drivers/iio/adc/ad7124.c
> > @@ -839,8 +839,6 @@ static int ad7124_parse_channel_config(struct iio_d=
ev
> > *indio_dev,
> > =C2=A0	st->channels =3D channels;
> > =C2=A0
> > =C2=A0	device_for_each_child_node_scoped(dev, child) {
> > -		cfg =3D &st->channels[channel].cfg;
> > -
> > =C2=A0		ret =3D fwnode_property_read_u32(child, "reg", &channel);
> > =C2=A0		if (ret)
> > =C2=A0			return ret;
> > @@ -858,6 +856,7 @@ static int ad7124_parse_channel_config(struct iio_d=
ev
> > *indio_dev,
> > =C2=A0		st->channels[channel].ain =3D AD7124_CHANNEL_AINP(ain[0]) |
> > =C2=A0						=C2=A0 AD7124_CHANNEL_AINM(ain[1]);
> > =C2=A0
> > +		cfg =3D &st->channels[channel].cfg;
> > =C2=A0		cfg->bipolar =3D fwnode_property_read_bool(child, "bipolar");
> > =C2=A0
> > =C2=A0		ret =3D fwnode_property_read_u32(child, "adi,reference-select",
> > &tmp); =20
>=20
>=20


