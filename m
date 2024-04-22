Return-Path: <linux-iio+bounces-4445-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578498AD322
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 19:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8926B1C216C1
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 17:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DF1153BC9;
	Mon, 22 Apr 2024 17:09:44 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F73153BC1;
	Mon, 22 Apr 2024 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805783; cv=none; b=YT9WhCIJG/5di/KyeRXynrvnhigo9aVY+cZi+LPFvE4CBqilpj3Rtk4cKgRjgMcas8LcT+Xr08qbPLFIclZ6X9uCO4q0bdWbvfEl9h6jLQxHqG8bRnMK65Y11g4/1y1LfXCtnpelCMNHpPgjklTSR41IXymkc4tC95yMPz/WvC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805783; c=relaxed/simple;
	bh=7baHeQKiToZpKZ/AYc97PczeedzukBfRzZHO77+bf3M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXnvafKVoagilmqxMdhT9IKU0WWyl8FbFJn4kuhZ3kgnkMMJ+iTzuwgTliudzujPM+tRH84Rz8RVNu1mUDw1x1fBGy5hUv/H6eIElZY+XCUspzftBD3RNydUQ819w3H3toufMpP8QPwCKxixzIl+1z4/w6RTebKnfsbl8HfD8JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNWrr67NNz67Ct8;
	Tue, 23 Apr 2024 01:07:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2CD3F140AB8;
	Tue, 23 Apr 2024 01:09:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 18:09:38 +0100
Date: Mon, 22 Apr 2024 18:09:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	<devnull+nuno.sa.analog.com@kernel.org>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, Alexandru Ardelean
	<alexandru.ardelean@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
	<olivier.moysan@foss.st.com>
Subject: Re: [PATCH 3/8] dt-bindings: adc: axi-adc: add clocks property
Message-ID: <20240422180937.00005441@Huawei.com>
In-Reply-To: <be927df578a936e7699a26edfddd42470689e7cd.camel@gmail.com>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
	<20240419-ad9467-new-features-v1-3-3e7628ff6d5e@analog.com>
	<20240420160404.57bd835d@jic23-huawei>
	<be927df578a936e7699a26edfddd42470689e7cd.camel@gmail.com>
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

On Mon, 22 Apr 2024 17:06:22 +0200
Nuno S=E1 <noname.nuno@gmail.com> wrote:

> On Sat, 2024-04-20 at 16:04 +0100, Jonathan Cameron wrote:
> > On Fri, 19 Apr 2024 17:36:46 +0200
> > Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >  =20
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > Add a required clock property as we can't access the device registers=
 if
> > > the AXI bus clock is not properly enabled.
> > >=20
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com> =20
> > Fix, or doesn't matter until this series?
> >  =20
>=20
> It does matter. But reality is that it's rare for you to catch this issue=
 because
> such a fundamental clock is typically enabled pretty early during boot. B=
ut we did
> had some issues (on other cores) regarding this. Anyways, for correctness=
, I'll add a
> tag on v2.
>=20
Add that info as well so people can judge how important this is to backport.

J

> - Nuno S=E1
>=20
>=20


