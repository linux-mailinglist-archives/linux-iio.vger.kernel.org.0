Return-Path: <linux-iio+bounces-3815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1022588C6F5
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 16:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B11A1C63DA2
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 15:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C012113C9AE;
	Tue, 26 Mar 2024 15:29:35 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1D713C9B5;
	Tue, 26 Mar 2024 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466975; cv=none; b=hWPUXez4D6I6KR5ZhH0u8rAW2lwnnaWFhnxSfIa1kwEBMGHzdxG2MJzOjic/hPHHfVoGl0eMv5uqbiz8LoVTS3rsF8zUUgHJK0rgcHVLrdBVQ5tZO10Ba3qE6wdxjyy8K85kRFY9LeaKrwS1+aFwCbilvt/7LW6KdI2cIQ5oBfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466975; c=relaxed/simple;
	bh=UOqd6ZJ+xqo5YsFIO1ebtjM3W5gPTRG7A1rsHNjT53U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWcoWviTUdiBBPPzDFESOSlhSQbcx4y4urHRZocf5B15kl5fVYonT2pJPAHenSYU45bslIA+fJESDdeceRNtwDzYsjABIsPYOzuQtYzngOKbl9mEBZdHoL070H/wEt67hJDBFhgzv8qfrtrqu21Hq1ez+mjsXSnjVY72ZY5kVeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V3tsB4XDsz6K9K1;
	Tue, 26 Mar 2024 23:25:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 71E811406AE;
	Tue, 26 Mar 2024 23:29:28 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 26 Mar
 2024 15:29:27 +0000
Date: Tue, 26 Mar 2024 15:29:27 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC: Jonathan Cameron <jic23@kernel.org>, <devicetree@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>, "Trevor
 Zaharichuk" <trevor@au-zone.com>, Greg Lytle <greg@au-zone.com>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Sean Nyekjaer <sean@geanix.com>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: iio: dac: ti,dac5571: Add DAC081C081
 support
Message-ID: <20240326152927.00006229@Huawei.com>
In-Reply-To: <20240325205641.GD23988@pendragon.ideasonboard.com>
References: <20240325203245.31660-1-laurent.pinchart@ideasonboard.com>
	<20240325203245.31660-2-laurent.pinchart@ideasonboard.com>
	<20240325204857.4f2fd468@jic23-huawei>
	<20240325205641.GD23988@pendragon.ideasonboard.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 25 Mar 2024 22:56:41 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Jonathan,
>=20
> On Mon, Mar 25, 2024 at 08:48:57PM +0000, Jonathan Cameron wrote:
> > On Mon, 25 Mar 2024 22:32:41 +0200 Laurent Pinchart wrote:
> >  =20
> > > The DAC081C081 is a TI DAC whose software interface is compatible with
> > > the DAC5571. It is the 8-bit version of the DAC121C081, already
> > > supported by the DAC5571 bindings. Extends the bindings to support th=
is
> > > chip.
> > >=20
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com> =
=20
> >=20
> > Hi Laurent,
> >=20
> > Given it's a part number where no one is going to guess it is compatible
> > with the DAC5571 and that we don't have a history of fallback compatibl=
es
> > I'm fine with this change, but just wanted to ask is a fallback compati=
ble
> > useful to you to run with older kernels?
> >=20
> > I should have noticed when Peter added the dac121c081. If we add a fall=
back
> > should do that one as well. =20
>=20
> I've indeed noticed that there should have been a fallback for
> dac121c081, but didn't stop to ponder why that wasn't the case, and just
> went along with the flow :-) I agree a fallback could be useful, which
> would then allow dropping patch 2/5 from this series (*). I can do so if
> you prefer.
>=20
> * This is not entirely true. While the DAC1081C081 is largely compatible
> with the DAC5573, they have different values for one of the power-down
> resistors (2.5k=CE=A9 instead of 1k=CE=A9 if I recall correctly). To be c=
ompletely
> accurate, the driver should report that. We could still use the fallback
> compatible, reporting the wrong power-down resistor value.
>=20

Hmm - Would anyone really care about that value being wrong?
I think perhaps that's just about significant enough that maybe a fallback
compatible doesn't make sense here.

Jonathan

> > > ---
> > >  Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yam=
l b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> > > index 79da0323c327..e59db861e2eb 100644
> > > --- a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> > > @@ -21,6 +21,7 @@ properties:
> > >        - ti,dac5573
> > >        - ti,dac6573
> > >        - ti,dac7573
> > > +      - ti,dac081c081
> > >        - ti,dac121c081
> > > =20
> > >    reg: =20
>=20


