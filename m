Return-Path: <linux-iio+bounces-1273-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6F681E83D
	for <lists+linux-iio@lfdr.de>; Tue, 26 Dec 2023 16:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252D71F2356F
	for <lists+linux-iio@lfdr.de>; Tue, 26 Dec 2023 15:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26FB4F5E4;
	Tue, 26 Dec 2023 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnTYmuAI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79D04EB5E;
	Tue, 26 Dec 2023 15:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E245C433C8;
	Tue, 26 Dec 2023 15:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703606355;
	bh=JNxmqunYM7saPd+2X/fx7r1OXTgeask2+hIz4m5cu2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VnTYmuAIokatU2uxPuIAkGHV9mfJyISNjofRtSklSPCI1xonJVWlolWNSlmLnv7OG
	 EYtzRGIE1XQ3FX+91gkQh9EjKyK+NNtVBbPmil8wtF5DP5xqGqizhhJKWutOXttR9b
	 NxhkkDEaTEawTYKVWsPmi/1t5TW5sdmOtsSK410cevrHzo7N62EG+0erMdk6xmy+4P
	 zDXexkcfsZZkQ41xbHFs/bpAVb5HhfOTTTrWi0fNp8H2yp27/aSEwrRIxu/CgzGjeX
	 U6zJf8dYcxQCHBu6ziO5hmX0/jsKQFQK+zYlOpucuLNWlE/mlFDsHBbOpZEg5wZEW6
	 QsZP31HKdg87g==
Date: Tue, 26 Dec 2023 15:59:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v4 6/8] iio: add the IIO backend framework
Message-ID: <20231226155904.043fee13@jic23-huawei>
In-Reply-To: <f7df488b33c89ce7078c39a87ba1108fac5a10bd.camel@gmail.com>
References: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
	<20231220-iio-backend-v4-6-998e9148b692@analog.com>
	<20231221174437.5935a5c3@jic23-huawei>
	<f7df488b33c89ce7078c39a87ba1108fac5a10bd.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D devm_add_action_or=
_reset(dev, iio_backend_release, back);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0link =3D device_link_add(d=
ev, back->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!link)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0pr_warn("%s: Could not link to supplier(%s)\n", dev=
_name(dev),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev=
_name(back->dev)); =20
> >=20
> > Why is that not an error and we try to carry on? =20
>=20
> I guess having the links are not really mandatory for the whole thing to =
work (more
> like a nice to have). That's also how this is handled in another subsyste=
ms so I
> figured it would be fine.
>=20
> But since you are speaking about this... After you pointing me to Bartosz=
's talk and
> sawing it (as stuff like this is mentioned), I started to question this. =
The goal
> with the above comment is that if you remove the backend, all the consume=
rs are
> automatically removed (unbound). Just not sure if that's what we always w=
ant (and we
> are already handling the situation where a backend goes away with -ENODEV=
) as some
> frontends could still be useful without the backend (I guess that could be
> plausible). I think for now we don't really have such usecases so the lin=
ks can make
> sense (and we can figure something like optionally creating these links i=
f we ever
> need too) but having your inputs on this will definitely be valuable.

I'm not keen on both trying to make everything tear down cleanly AND making=
 sure
it all works even if we don't. That just adds two code paths to test when e=
ither
should be sufficient on its own.  I don't really mind which.  Bartosz's stu=
ff
is nice, but it may not be the right solution here.=20

>=20
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_debug("%s: Found backen=
d(%s) device\n", dev_name(dev),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 dev_name(back->dev));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > +}
> > > +

Jonathan


