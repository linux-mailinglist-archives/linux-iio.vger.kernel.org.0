Return-Path: <linux-iio+bounces-1693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A549A82DD03
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 17:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D951F2330B
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 16:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79C11799E;
	Mon, 15 Jan 2024 16:08:01 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F31617C70;
	Mon, 15 Jan 2024 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TDH721359z6J6jV;
	Tue, 16 Jan 2024 00:05:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 29ABF1400CD;
	Tue, 16 Jan 2024 00:07:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Jan
 2024 16:07:55 +0000
Date: Mon, 15 Jan 2024 16:07:54 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>,
	<nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
	<jic23@kernel.org>, "Rob Herring" <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
	<olivier.moysan@foss.st.com>
Subject: Re: [PATCH v5 7/8] iio: adc: ad9467: convert to backend framework
Message-ID: <20240115160754.00002cc9@Huawei.com>
In-Reply-To: <0a7f38984f45531b1e08b20ea1d8532e1e78bf73.camel@gmail.com>
References: <20240112-iio-backend-v5-0-bdecad041ab4@analog.com>
	<20240112-iio-backend-v5-7-bdecad041ab4@analog.com>
	<20240112173333.00002ed1@Huawei.com>
	<0a7f38984f45531b1e08b20ea1d8532e1e78bf73.camel@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

> > > +		return ret;
> > > +
> > > +	ret =3D iio_backend_enable(st->back);
> > > +	if (ret)
> > > +		return ret; =20
> >=20
> > I'm curious there is no iio_backend_disable() to be done in the exit pa=
th?
> >  =20
>=20
> Ehehe something I have in my mind, yes. I'm just not disabling the core b=
ecause
> it was the same with the previous approach. My goal was to have (more or =
less)
> the same state before vs after introducing the backend. I was thinking in=
 adding
> a devm_iio_backend_enable() as a follow up patch and use it in here (or a=
ctually
> use it for the first axi-dac/dds user as that one will be come from a "cl=
ean"
> state).
>=20
> If you prefer I can already turn iio_backend_enable() ->
> devm_iio_backend_enable() and use it in this patch.
Might be cleaner to do that.  Or add a big fat comment here to say it'll get
cleaned up in a follow up patch.

>=20
> - Nuno S=E1
> >  =20


