Return-Path: <linux-iio+bounces-6250-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58930907906
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 19:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1B5286E25
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 17:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D235149C47;
	Thu, 13 Jun 2024 17:00:12 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D474512EBC7;
	Thu, 13 Jun 2024 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298012; cv=none; b=fBkEORougChd1PHdCd2NF1cf3nnytWdAldi/hR89foDM6tqsIabZ4zHCbU+kJlquGB5VJFrriQ08wxHqHCpArFgnDIijoNSAf7+KLvaHphLcAhlYc0PwSeeu6QC7x/KNQKIECFIZtN6ZEiEA0AqDMddW2rTTDpF9aM7t6CcgaHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298012; c=relaxed/simple;
	bh=r2FXAgMa0jD+t3ToDPQWNEY6z4v9oqO4oDHY5ah3aU8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CyMDX/pSYOwNaC+ycEe1h7osCl1xGdgMfmsWDGmFZh2ti1EcJ8iTWHawXLWb4TuOivI0osj2hrVtCk8uxABKo20v7KY2dMgxg+RccGtLUifrpI1ChWSIRAdK817/lkyfGGnIBIRNFB4fh4Z+QIbTfZUG/MLhDSF/DCpIV2qz4u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0TDP2ZPMz6K6VF;
	Fri, 14 Jun 2024 01:00:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5405C140A87;
	Fri, 14 Jun 2024 01:00:07 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Jun
 2024 18:00:06 +0100
Date: Thu, 13 Jun 2024 18:00:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
CC: Jonathan Cameron <jic23@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "Hennerich, Michael"
	<Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<noname.nuno@gmail.com>
Subject: Re: [PATCH v3 1/5] iio: ABI: Generalize ABI documentation for DAC
Message-ID: <20240613180005.0000480e@Huawei.com>
In-Reply-To: <PH0PR03MB71416493AB2788638599CAE4F9C02@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240603012200.16589-1-kimseer.paller@analog.com>
	<20240603012200.16589-2-kimseer.paller@analog.com>
	<20240608154053.1cf1097e@jic23-huawei>
	<PH0PR03MB71416493AB2788638599CAE4F9C02@PH0PR03MB7141.namprd03.prod.outlook.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 12 Jun 2024 10:57:42 +0000
"Paller, Kim Seer" <KimSeer.Paller@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, June 8, 2024 10:41 PM
> > To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> > devicetree@vger.kernel.org; David Lechner <dlechner@baylibre.com>; Lars-
> > Peter Clausen <lars@metafoo.de>; Liam Girdwood <lgirdwood@gmail.com>;
> > Mark Brown <broonie@kernel.org>; Dimitri Fedrau <dima.fedrau@gmail.com>;
> > Krzysztof Kozlowski <krzk+dt@kernel.org>; Rob Herring <robh@kernel.org>;
> > Conor Dooley <conor+dt@kernel.org>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Nuno S=E1 <noname.nuno@gmail.com>
> > Subject: Re: [PATCH v3 1/5] iio: ABI: Generalize ABI documentation for =
DAC
> >=20
> > [External]
> >=20
> > On Mon, 3 Jun 2024 09:21:56 +0800
> > Kim Seer Paller <kimseer.paller@analog.com> wrote:
> >  =20
> > > Introduces a more generalized ABI documentation for DAC. Instead of
> > > having separate ABI files for each DAC, we now have a single ABI file
> > > that covers the common sysfs interface for all DAC.
> > >
> > > Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> > > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com> =20
> >=20
> > A few comments inline.
> >=20
> > I wondered if it made sense to combine voltage and current entries of e=
ach
> > type
> > in single block, but I think the docs would become too complicated with=
 lots
> > of wild cards etc.  Hence I think the duplication is fine.
> >=20
> > Jonathan
> >  =20
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-iio-dac   | 61 +++++++++++++++++=
++
> > >  .../ABI/testing/sysfs-bus-iio-dac-ltc2688     | 31 ----------
> > >  2 files changed, 61 insertions(+), 31 deletions(-)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac =20
> > b/Documentation/ABI/testing/sysfs-bus-iio-dac =20
> > > new file mode 100644
> > > index 000000000000..36d316bb75f6
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-dac
> > > @@ -0,0 +1,61 @@
> > > +What: =20
> > 	/sys/bus/iio/devices/iio:deviceX/out_currentY_toggle_en =20
> > > +KernelVersion:	5.18
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +       		Toggle enable. Write 1 to enable toggle or 0 to disable it.=
 This =20
> > Tab vs space issue - see below.
> >  =20
> > > +		is useful when one wants to change the DAC output codes. The =20
> > way =20
> > > +		it should be done is:
> > > +
> > > +        	- disable toggle operation;
> > > +        	- change out_currentY_rawN, where N is the integer value of=
 the =20
> > symbol; =20
> > > +        	- enable toggle operation. =20
> > Same question as below on whether this is accurate - Maybe it just need=
s to
> > mention
> > this scheme needs to be used for autonomous toggling (out of software
> > control).
> > It works for software toggling but may be overkill!
> >  =20
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_rawN
> > > +KernelVersion:	5.18
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		This attribute has the same meaning as out_currentY_raw. It is
> > > +		specific to toggle enabled channels and refers to the DAC =20
> > output =20
> > > +		code in INPUT_N (_rawN), where N is the integer value of the =20
> > symbol. =20
> > > +		The same scale and offset as in out_currentY_raw applies.
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_symbol
> > > +KernelVersion:	5.18
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Performs a SW switch to a predefined output symbol. This =20
> > attribute =20
> > > +		is specific to toggle enabled channels and allows switching =20
> > between =20
> > > +		multiple predefined symbols. Each symbol corresponds to a =20
> > different =20
> > > +		output, denoted as out_currentY_rawN, where N is the integer =20
> > value =20
> > > +		of the symbol. Writing an integer value N will select =20
> > out_currentY_rawN. =20
> > > +
> > > +What: =20
> > 	/sys/bus/iio/devices/iio:deviceX/out_voltageY_toggle_en =20
> > > +KernelVersion:	5.18
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +       		Toggle enable. Write 1 to enable toggle or 0 to disable it.=
 This =20
> >=20
> > Mix of spacing and tabs is inconsistent. Hence the odd indent in this r=
eply
> > version.
> >  =20
> > > +		is useful when one wants to change the DAC output codes. The =20
> > way =20
> > > +		it should be done is: =20
> >=20
> > Hmm. Is this true?  If we are doing autonomous toggling on a clock or s=
imilar
> > than agreed.
> > If we are using the out_current_symbol software control it would be com=
mon
> > to switch
> > to A, modify B, switch to B, modify A etc.
> >=20
> > I think our interface has probably evolved and so this might need an up=
date. =20
>=20
> I agree that the description could be clear about the differences between=
=20
> autonomous and software toggling. If we were to change the description, w=
ould=20
> this suffice?
>=20
> Description:
>         Toggle enable. Write 1 to enable toggle or 0 to disable it. This
>         is useful when one wants to change the DAC output codes. For auto=
nomous toggling, the way
>         it should be done is:
>=20
>         - disable toggle operation;
>         - change out_currentY_rawN, where N is the integer value of the s=
ymbol;
>         - enable toggle operation.

To here is good as focuses on the use case.

>=20
> For software toggling, one can switch to A, modify B, switch to B, modify=
 A, etc.

I'd not mention this part (not sure if you were intending to though given t=
he formatting!)

Jonathan


> >  =20
> > > +
> > > +        	- disable toggle operation;
> > > +        	- change out_voltageY_rawN, where N is the integer value of=
 the =20
> > symbol; =20
> > > +        	- enable toggle operation. =20
>=20
>=20


