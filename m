Return-Path: <linux-iio+bounces-5940-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990F38FF58C
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00591B24666
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 19:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA7B71750;
	Thu,  6 Jun 2024 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kxw0PvxZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83CD44361;
	Thu,  6 Jun 2024 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717703904; cv=none; b=CruEIK6MtrbLnZHUoV0YwlXhZFUf3EQxmFwzA80qSHu0/1InyC0GaZIBQpa0cA2tnenUwPS1qEyVGcubC66PMv/fHwyENwvCsZ2GBsv3nz5o8DIgR27DrpmpixiW10Mg3Rgt9w3dsuEYkxYZkJjMCsfq3ZF+k5HdldU4jhaDwsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717703904; c=relaxed/simple;
	bh=Ew+uJIHo1tIv3V3cIwq+PSc8g98kQVzDQiK0ACMNhjc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=epQGY8xmgH0SrCHbt39puAh7E+0feOkLwhwUygreDAREHFy2ij2h6kUzZwGgk/is7UaVKn49zqCOB7vJ5jmlevpWe5Ac2eJPmOM8GTevnjYI7yqDJhgSPauyQEzx7HRlpVBIjhx9rjuAseDz+B3W3e2mhXmn6JHFysrfjFmzQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kxw0PvxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B09AC2BD10;
	Thu,  6 Jun 2024 19:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717703903;
	bh=Ew+uJIHo1tIv3V3cIwq+PSc8g98kQVzDQiK0ACMNhjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kxw0PvxZlvq15FdUzivZMcou6nAZV13taDbuK/NcPoGENpZmvccKY9eOC1Trn7u+d
	 8KmYAxQ/4bKhzl/LMlp+kPI6D3uOAu1jMM99XckQ6/hp7r/qPIwNKTpoCyD6cdQXKj
	 5p94n0MwBhXTpu7HX0kRqMOWqx3SE98CfaonMv3PEFbtqHwAhwFM67WH8hsZ7mZGdw
	 li2/G/wYPqzoZEppGcvUCH2hwJ/MvYjC9iCUq3PnDZYTDOMw22KF8QNpNQF9ujOf+Y
	 UFVhgxDIqQtqv7I8mpJrBLFli0ULUwsm0K6NmiodGfbPWOb1PqPB+DRyL7G3U09xuB
	 R8Rg64G1sreSw==
Date: Thu, 6 Jun 2024 20:58:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>, dumitru.ceclan@analog.com,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] dt-bindings: adc: ad7173: add support for ad411x
Message-ID: <20240606205813.65b342c4@jic23-huawei>
In-Reply-To: <0f0c0b92-af0d-4e68-9880-bacfd53d726f@gmail.com>
References: <20240531-ad4111-v4-0-64607301c057@analog.com>
	<20240531-ad4111-v4-1-64607301c057@analog.com>
	<20240601193512.0e17992b@jic23-huawei>
	<efa10caa-5e78-4f3f-8cca-c61d7a01e6fd@gmail.com>
	<20240603210014.6258134d@jic23-huawei>
	<0f0c0b92-af0d-4e68-9880-bacfd53d726f@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Jun 2024 09:54:31 +0300
"Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:

> On 03/06/2024 23:00, Jonathan Cameron wrote:
> > On Mon, 3 Jun 2024 12:46:10 +0300
> > "Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:
> >  =20
> >> On 01/06/2024 21:35, Jonathan Cameron wrote: =20
> >>> On Fri, 31 May 2024 22:42:27 +0300
> >>> Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel=
.org> wrote:
> >>>    =20
> >>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com> =20
>=20
> ...
>=20
> >>>> +          Supported only by AD7172-2, AD7172-4, AD7175-2, AD7175-8,=
 AD7177-2:
> >>>> +            19: ((AVDD1 =E2=88=92 AVSS)/5)+
> >>>> +            20: ((AVDD1 =E2=88=92 AVSS)/5)=E2=88=92   =20
> >>>
> >>> That's what it says on the datasheet (so fine to copy that here) but =
I'm curious, what does
> >>> that mean in practice?  How can we have negative and postive signals =
of the difference
> >>> between two power supply voltages where I'm fairly sure AVDD1 always =
greater than AVSS.
> >>>   =20
> >>
> >> I have not tested that as I do not have a model that supports this wir=
ed up.
> >> If I had to guess they are the same signal but one should be connected=
 to the
> >> positive input, one to the negative input...but I could be wrong. =20
> >=20
> > If they are, then as far as I we are concerned is this one channel with=
 two
> > representations depending on whether it is 1st or 2nd in the list?
> > Can we use one number and hide that detail in the driver?
> >=20
> > Seems odd though if that is the case.
> >=20
> > I guess if we find out later this is the case we can tighten the bindin=
g to
> > enforce the right one instead of squashing them to one value, but that
> > is a bit ugly.  Any chance of digging out the info?  If not we can go a=
head
> > but ideally answering things like this make a our life easier in the lo=
ng run.
> >=20
> > Jonathan
> >  =20
>=20
> "(Avdd1/Avss)/5+ as positive input and (Avdd/Avss)/5- as negative
>   this is used for monitoring power supplies, the inputs must be selected=
 in pair"
> Perhaps it's an internal voltage divider...? I dunno
>=20
> So it seems like this cannot be used as a common mode voltage input.
> I'll restrict the driver to only allow these inputs paired together
> and rename the define for these selections.
Most mysterious :)  I'd be interested to know what value it reads
back if you ever get the part.

Ah well, great to have gotten that extra detail even if it leaves
more questions!

Jonathan

>=20
>=20
>=20


