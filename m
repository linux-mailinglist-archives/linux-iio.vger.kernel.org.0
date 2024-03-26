Return-Path: <linux-iio+bounces-3817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F100C88CA7F
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 18:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AAB1C6603D
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 17:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56541C6B0;
	Tue, 26 Mar 2024 17:13:28 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57051C693;
	Tue, 26 Mar 2024 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473208; cv=none; b=OlLdGGH87ipYWGDR0u6GtOf48YF8azH2X3Aagxo5ZxFPRXALWmSwN3NjGqF6O+K9o+a89610h1c/a4VSDAiQPXb+x8WGxq16hU+USZjUf/1Bspeb6vsO/OZuxyWtMSYbX9JNKCpRLmdkyaOBgf7PGXkn7K1lTt7FUewhENQRyP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473208; c=relaxed/simple;
	bh=MnzMXAzZV1h7sUIdg5Aeq4kt19V4kaa+bzh/Anm4CGE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQVM3FBPbhLfitugcH1VRsvXuvn14cOaOZ0AuKUwzY5OJZyzd78yMKmMFiK3UWR2SeyNJMvSaVkTLx74uTZ11p/6nD4dOzteqsSojVAUnfeHCOwin4Z+6PRWqFMapoQNP+zjPzG0VmeLiBWilaHQr9bi+9LjttwUgDSVwTdy+hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V3x8z72w7z6K9KK;
	Wed, 27 Mar 2024 01:08:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EC4C6140594;
	Wed, 27 Mar 2024 01:13:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 26 Mar
 2024 17:13:17 +0000
Date: Tue, 26 Mar 2024 17:13:16 +0000
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
Message-ID: <20240326171316.000018f5@Huawei.com>
In-Reply-To: <20240326165043.GB28895@pendragon.ideasonboard.com>
References: <20240325203245.31660-1-laurent.pinchart@ideasonboard.com>
	<20240325203245.31660-2-laurent.pinchart@ideasonboard.com>
	<20240325204857.4f2fd468@jic23-huawei>
	<20240325205641.GD23988@pendragon.ideasonboard.com>
	<20240326152927.00006229@Huawei.com>
	<20240326165043.GB28895@pendragon.ideasonboard.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 26 Mar 2024 18:50:43 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> On Tue, Mar 26, 2024 at 03:29:27PM +0000, Jonathan Cameron wrote:
> > On Mon, 25 Mar 2024 22:56:41 +0200 Laurent Pinchart wrote: =20
> > > On Mon, Mar 25, 2024 at 08:48:57PM +0000, Jonathan Cameron wrote: =20
> > > > On Mon, 25 Mar 2024 22:32:41 +0200 Laurent Pinchart wrote:
> > > >    =20
> > > > > The DAC081C081 is a TI DAC whose software interface is compatible=
 with
> > > > > the DAC5571. It is the 8-bit version of the DAC121C081, already
> > > > > supported by the DAC5571 bindings. Extends the bindings to suppor=
t this
> > > > > chip.
> > > > >=20
> > > > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.co=
m>   =20
> > > >=20
> > > > Hi Laurent,
> > > >=20
> > > > Given it's a part number where no one is going to guess it is compa=
tible
> > > > with the DAC5571 and that we don't have a history of fallback compa=
tibles
> > > > I'm fine with this change, but just wanted to ask is a fallback com=
patible
> > > > useful to you to run with older kernels?
> > > >=20
> > > > I should have noticed when Peter added the dac121c081. If we add a =
fallback
> > > > should do that one as well.   =20
> > >=20
> > > I've indeed noticed that there should have been a fallback for
> > > dac121c081, but didn't stop to ponder why that wasn't the case, and j=
ust
> > > went along with the flow :-) I agree a fallback could be useful, which
> > > would then allow dropping patch 2/5 from this series (*). I can do so=
 if
> > > you prefer.
> > >=20
> > > * This is not entirely true. While the DAC1081C081 is largely compati=
ble
> > > with the DAC5573, they have different values for one of the power-down
> > > resistors (2.5k=CE=A9 instead of 1k=CE=A9 if I recall correctly). To =
be completely
> > > accurate, the driver should report that. We could still use the fallb=
ack
> > > compatible, reporting the wrong power-down resistor value. =20
> >=20
> > Hmm - Would anyone really care about that value being wrong? =20
>=20
> I don't have enough expertise with IIO to be sure, but my guess is that
> nobody would.
>=20
> > I think perhaps that's just about significant enough that maybe a fallb=
ack
> > compatible doesn't make sense here. =20
>=20
> Then let's keep it simple and just merge this patch as-is ? :-)
Makes sense. I'm on wrong computer at the moment but will pick it up at
weekend if not before.

Jonathan


>=20
> > > > > ---
> > > > >  Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac5571=
.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> > > > > index 79da0323c327..e59db861e2eb 100644
> > > > > --- a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> > > > > +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> > > > > @@ -21,6 +21,7 @@ properties:
> > > > >        - ti,dac5573
> > > > >        - ti,dac6573
> > > > >        - ti,dac7573
> > > > > +      - ti,dac081c081
> > > > >        - ti,dac121c081
> > > > > =20
> > > > >    reg:   =20
>=20


