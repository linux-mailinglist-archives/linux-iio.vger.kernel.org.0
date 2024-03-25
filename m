Return-Path: <linux-iio+bounces-3807-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5220688BB27
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 08:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAB42E2DFF
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 07:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F2F130A65;
	Tue, 26 Mar 2024 07:24:17 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx2.mythic-beasts.com (mx2.mythic-beasts.com [46.235.227.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88F184D29;
	Tue, 26 Mar 2024 07:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711437857; cv=none; b=sKndtGarr/Lhitz9nR9UOMUi9OjmtKzz+/2TthrbAiBSyDBLFNIFKRHZsxlEJ6Zyq1v1dzfpNO5WAVCuIXTk4FLXA0NDjLif/dHz3QboeacETuFgxMUccA8J2P/C0Ko6MPHwnV3aWJLwrShuHdtNsawmfAAy1bpvmp8BPzTaKaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711437857; c=relaxed/simple;
	bh=l6JtmrWNF3LKBIp+HzdX8pz/gxhDJudluV04fWRvOo4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ApBOAAa2ytMoQkGDQyAxXosEjN8wklmkos2MSB0idHJMB4GLZHPJom1d0RyhgqV8RQTY1CSadW6UoqZoSp4SucHRF8iR+EK/3XCcQZtaPKLSF5NuSFYQT8N5WIw5owsQTlbAH7IN6opY8Q4QLWtitubZ5GUIfEbt0nzvvOiEOuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk; spf=pass smtp.mailfrom=jic23.retrosnub.co.uk; arc=none smtp.client-ip=46.235.227.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jic23.retrosnub.co.uk
Received: by mailhub-hex-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <jic23@jic23.retrosnub.co.uk>)
	id 1rp19q-00CxpK-M5; Tue, 26 Mar 2024 07:23:57 +0000
Date: Mon, 25 Mar 2024 22:32:59 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Jonathan Cameron <jic23@kernel.org>
CC: devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Trevor Zaharichuk <trevor@au-zone.com>,
 Greg Lytle <greg@au-zone.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sean Nyekjaer <sean@geanix.com>,
 linux-iio@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/5=5D_dt-bindings=3A_iio=3A_da?=
 =?US-ASCII?Q?c=3A_ti=2Cdac5571=3A_Add_DAC081C081_support?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240325222308.GA31216@pendragon.ideasonboard.com>
References: <20240325203245.31660-1-laurent.pinchart@ideasonboard.com> <20240325203245.31660-2-laurent.pinchart@ideasonboard.com> <20240325204857.4f2fd468@jic23-huawei> <20240325205641.GD23988@pendragon.ideasonboard.com> <20240325222308.GA31216@pendragon.ideasonboard.com>
Message-ID: <435DAE05-A189-4238-AAD4-C5F4E3032DD6@jic23.retrosnub.co.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BlackCat-Spam-Score: 25



On 25 March 2024 22:23:08 GMT, Laurent Pinchart <laurent=2Epinchart@ideaso=
nboard=2Ecom> wrote:
>On Mon, Mar 25, 2024 at 10:56:44PM +0200, Laurent Pinchart wrote:
>> On Mon, Mar 25, 2024 at 08:48:57PM +0000, Jonathan Cameron wrote:
>> > On Mon, 25 Mar 2024 22:32:41 +0200 Laurent Pinchart wrote:
>> >=20
>> > > The DAC081C081 is a TI DAC whose software interface is compatible w=
ith
>> > > the DAC5571=2E It is the 8-bit version of the DAC121C081, already
>> > > supported by the DAC5571 bindings=2E Extends the bindings to suppor=
t this
>> > > chip=2E
>> > >=20
>> > > Signed-off-by: Laurent Pinchart <laurent=2Epinchart@ideasonboard=2E=
com>
>> >=20
>> > Hi Laurent,
>> >=20
>> > Given it's a part number where no one is going to guess it is compati=
ble
>> > with the DAC5571 and that we don't have a history of fallback compati=
bles
>> > I'm fine with this change, but just wanted to ask is a fallback compa=
tible
>> > useful to you to run with older kernels?
>> >=20
>> > I should have noticed when Peter added the dac121c081=2E If we add a =
fallback
>> > should do that one as well=2E
>>=20
>> I've indeed noticed that there should have been a fallback for
>> dac121c081, but didn't stop to ponder why that wasn't the case, and jus=
t
>> went along with the flow :-) I agree a fallback could be useful, which
>> would then allow dropping patch 2/5 from this series (*)=2E I can do so=
 if
>> you prefer=2E
>
>And in that case, should I first introduce support in the bindings for
>"ti,dac121c081", "ti,dac7571" and deprecate usage of "ti,dac121c081"
>alone ?

Yes=2E Not sure if we need an explicit binding entry for deprecated versio=
n=2E=2E=2E

>
>> * This is not entirely true=2E While the DAC1081C081 is largely compati=
ble
>> with the DAC5573, they have different values for one of the power-down
>> resistors (2=2E5k=CE=A9 instead of 1k=CE=A9 if I recall correctly)=2E T=
o be completely
>> accurate, the driver should report that=2E We could still use the fallb=
ack
>> compatible, reporting the wrong power-down resistor value=2E
>>=20
>> > > ---
>> > >  Documentation/devicetree/bindings/iio/dac/ti,dac5571=2Eyaml | 1 +
>> > >  1 file changed, 1 insertion(+)
>> > >=20
>> > > diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac5571=
=2Eyaml b/Documentation/devicetree/bindings/iio/dac/ti,dac5571=2Eyaml
>> > > index 79da0323c327=2E=2Ee59db861e2eb 100644
>> > > --- a/Documentation/devicetree/bindings/iio/dac/ti,dac5571=2Eyaml
>> > > +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac5571=2Eyaml
>> > > @@ -21,6 +21,7 @@ properties:
>> > >        - ti,dac5573
>> > >        - ti,dac6573
>> > >        - ti,dac7573
>> > > +      - ti,dac081c081
>> > >        - ti,dac121c081
>> > > =20
>> > >    reg:
>

