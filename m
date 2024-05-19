Return-Path: <linux-iio+bounces-5117-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5820F8C9554
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 18:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07891F21B2A
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 16:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07894487B0;
	Sun, 19 May 2024 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxXKfFos"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC53B4501B;
	Sun, 19 May 2024 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716137691; cv=none; b=GhPCj+STkrY6K81QOcRKO15PkoeV4wDtnr6OudvUCpgQV2VHaCuWa0dhu/Fa/0TY/dwqqV8qC4sAc1/QrruNodICu3oZlipBgJh3YHE8gNA10XAZQczzBEgIegV6TTVq9cMWJrtv7CSZdI37Vqh18gKaTc/ts2QY/Tn40On9dQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716137691; c=relaxed/simple;
	bh=tR4mc4IZBn+VwLq6uI83LBm5Hav1YvQbFaYXMsVsAn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ck3AXsVioiPqZotO7bgyWRcaB/zb6GBDoXzxAeMc/+gTVrQdbxGSultBpe33LGkigjyPjfsaRxE0p6v2Z9EW+bFoYuM/T8nr1GYtCJbEtYZgxIMHb4ASBFv8vSvkH26U8By0x8ZrKkeiPE0/wGNJP0BZM/JVGrfW2LHq0ok7brA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxXKfFos; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BFEC4AF07;
	Sun, 19 May 2024 16:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716137691;
	bh=tR4mc4IZBn+VwLq6uI83LBm5Hav1YvQbFaYXMsVsAn4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uxXKfFosQgBvoj1mDrpbBmBnJ9EdbIMjKlWw6Q/FwNu5KemtHTyniqVotxguFcSzv
	 Qel2uVToJ6X/LOvzev76uwqDlHiH3CxGaIZDHJeBWLiHdYu3wDIPSHHNJalY9bGolh
	 hHP4BSStmnGcN5mTEbgwxjWltRt5+x4gFCV2VB74Xtma9PSI9V14FYldMAg03RYO2H
	 o5QfB4pMIvNlkwt7Kxz5GcXwr05T3BBUR94zZ/mw/Eahgzt0cyKiDSqJPAaIX+xW9u
	 yeDDwXh8nRfpp2pHx29ZLN61esD7NFzXnCyvFf5NZoXb7BIgAuRYtMHXsth7NgzPAO
	 SfDacurBvxi4Q==
Date: Sun, 19 May 2024 17:54:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>, dumitru.ceclan@analog.com,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] dt-bindings: adc: ad7173: add support for ad411x
Message-ID: <20240519175438.5959fab2@jic23-huawei>
In-Reply-To: <CAMknhBFKM+DC9jNDV+cZ5agwsXJ1iqU9DB3XD-y3sVcRWJOAsQ@mail.gmail.com>
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
	<20240514-ad4111-v2-1-29be6a55efb5@analog.com>
	<CAMknhBGNPvxegL+YbnLGoKjA=P3Vx=x+39aXuMgq+cv2KgdeLw@mail.gmail.com>
	<151d6893-3e9e-4331-8dde-5293e75f10ef@gmail.com>
	<CAMknhBFKM+DC9jNDV+cZ5agwsXJ1iqU9DB3XD-y3sVcRWJOAsQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


> > =20
> > >> +
> > >> +          There are special values that can be selected besides the=
 voltage
> > >> +          analog inputs:
> > >> +            21: REF+
> > >> +            22: REF=E2=88=92
> > >> +          Supported only by AD7172-2, AD7172-4, AD7175-2, AD7175-8,=
 AD7177-2:
> > >> +            19: ((AVDD1 =E2=88=92 AVSS)/5)+
> > >> +            20: ((AVDD1 =E2=88=92 AVSS)/5)=E2=88=92
> > >> +          Supported only by AD4111, AD4112:
> > >> +            12: IIN3+
> > >> +            11: IIN3=E2=88=92
> > >> +            13: IIN2+
> > >> +            10: IIN2=E2=88=92
> > >> +            14: IIN1+
> > >> +             9: IIN1=E2=88=92
> > >> +            15: IIN0+
> > >> +             8: IIN0=E2=88=92 =20
> > >
> > > I just made a late reply on v1 where Jonathan suggested that the
> > > current inputs are differential with a similar comment to this:
> > >
> > > It doesn't seem to me like current inputs are differential if they are
> > > only measuring one current. They take 2 pins because you need a way
> > > for current to come in and go back out, but the datasheet calls them
> > > single-ended inputs.
> > > =20
> > It seemed to me that the conclusion that we arrived to was to expose the
> > precise pins that are used in the conversion and document the selection.
> >
> > Yes, it is a single-ended channel. So revert to the way it was in V1 us=
ing
> > single-channel? =20
>=20
> I'd like to hear Jonathan's opinion on this one.

Yes.  I think we rather went off on a false tangent on this.  Any current i=
nput
using a shunt is of this form and so far we've treated them as single ended=
 :(
e.g. pac1934 does this for it's sense inputs where there is an external
'sense resitor'.  Similar for the stand alone afe driver for a current sens=
e shunt
which is used with a differential voltage input, but presents a single ended
current measurement.

Sorry for misguiding things :(=20

At the end of this, I don't suppose anyone fancies writing up some notes
on how to describe different types of channel?

>=20
> > =20
> > >> +
> > >>          items:
> > >>            minimum: 0
> > >>            maximum: 31
> > >> @@ -154,6 +195,23 @@ patternProperties:
> > >>            - avdd
> > >>          default: refout-avss
> > >>
> > >> +      adi,current-channel:
> > >> +        description: |
> > >> +          Signal that the selected inputs are current channels.
> > >> +          Only available on AD4111 and AD4112.
> > >> +        type: boolean

I'm lost. Why do we need this one?  Is the channel selection not sufficient
to tell us this?

> > >> +
> > >> +      adi,channel-type:
> > >> +        description:
> > >> +          Used to differentiate between different channel types as =
the device
> > >> +           register configurations are the same for all usage types.
> > >> +        $ref: /schemas/types.yaml#/definitions/string
> > >> +        enum:
> > >> +          - single-ended
> > >> +          - pseudo-differential
> > >> +          - differential
> > >> +        default: differential
> > >> + =20
> > >
> > > As suggested above, we should soon have diff-channels and
> > > single-channel to differentiate between (fully) differential and
> > > single-ended. Do we actually need to differentiate between
> > > single-ended and pseudo-differential though?
> > > =20
> > Not really, so just a bool differential flag? (this seems weird as we h=
ave diff-channels) =20
>=20
> Or we need to change the proposed single-channel property to allow two
> inputs. I guess we'll see what Johnathan has to say.

I think single ended fits better for the current channels with just one
parameter.




