Return-Path: <linux-iio+bounces-23402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C80AAB3C3DC
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 22:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA321C25840
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 20:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D16C345720;
	Fri, 29 Aug 2025 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="E6nrgv6T"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256BD343D96
	for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499945; cv=none; b=mtwwDAWBuUVXLcgcS6T1KxoXf+g6+Ed03QrgFE8RAL1tn+ihZV/RYeoXQleIODp4t+XlTcRVFkXU8pQHC85e/RZ9G3gmoHXfzXGo1VG4jyDKr+YDf3Gq8Do7ZnPVChIhzvUUs1+Znuzu1cWaBgbRMywUfpE82LSldZraT9uzp2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499945; c=relaxed/simple;
	bh=owOHG9Dtik4l2LIvHIKjqkBxu8PNRXBqKXdys1DJXN8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:Subject:To:
	 References:In-Reply-To; b=nao9lAAq6UqNNDxbb0mUtuLZ/vgKrwoMNODwA7V5VZvdj06CQ+mNfHVb2XyoXuEyFzPH1D2gvZRCLTzoFvofHn648wuW4veSFEnnbP0BN6UyVIsmImhNMybn0CE80ShLEMIS0j80OPzz16geJPOZ9RUFUGeiYu0Ux34wX/AZbKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=E6nrgv6T; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1756499938; x=1757799938;
	bh=B9Iadrj2XMnTaLp/weUdPBYM3YQOWVmBQ2WC25/x1Xw=; h=From;
	b=E6nrgv6TX6vRgxC3Fh2GrT6I/FkU1wW3vGscL8OZmmfFuSnDFjkHC10bc2sgYCgDR
	 g7+4yGswrbYFq1sjV6SqMU8KMk9FWcsQi2MCJjsf8HPpDgIH+bIbBKrb9Mw9odvO/5
	 FZkj/2D2Mk5A2UuID/Mk6L6WYXnOEbCAEUyFzLJuQg6zjHG6Gb6zfw5Hiey6p7gKum
	 9lOQIWPpTM6Nqo9ZuHATEuIvgTvJUT3UcjLv2up4Ou2pquHCVztjn8pKMC2i08T030
	 IoOgQ0l6DvU9Fa0XIdfiWYrbwdbAykgHHCOLfwSLGi38ps7WvvIWnviVAXQH7LdQ0y
	 iFFrzCAf9m2gg==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 57TKcv1i021646
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 22:38:58 +0200 (CEST)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 Aug 2025 22:38:57 +0200
Message-Id: <DCF79FFP6NJS.J73DD94U1ZNK@matfyz.cz>
From: "Karel Balej" <balejk@matfyz.cz>
Cc: "Jonathan Cameron" <jic23@kernel.org>,
        "David Lechner"
 <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        "Andy Shevchenko" <andy@kernel.org>, "Lee Jones" <lee@kernel.org>,
        "David
 Wronek" <david@mainlining.org>, <phone-devel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
To: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
        "Jonathan
 Cameron" <jonathan.cameron@huawei.com>
References: <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz>
 <20250829-88pm886-gpadc-v1-1-f60262266fea@dujemihanovic.xyz>
 <20250829172730.000079b5@huawei.com> <2453108.NG923GbCHz@radijator>
In-Reply-To: <2453108.NG923GbCHz@radijator>

Duje Mihanovi=C4=87, 2025-08-29T19:40:41+02:00:
> On Friday, 29 August 2025 18:27:30 Central European Summer Time Jonathan =
Cameron wrote:
>> On Fri, 29 Aug 2025 00:17:41 +0200
>>=20
>> Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz> wrote:
>> > +	iio->name =3D "88pm886-gpadc";
>> > +	iio->dev.parent =3D dev;
>> > +	iio->dev.of_node =3D parent->of_node;
>>=20
>> Done in core code.
>> https://elixir.bootlin.com/linux/v6.16.3/source/drivers/iio/industrialio=
-core.
>> c#L2044 __iio_device_register() so unless you use it before that call
>> shouldn't need this.
>>=20
>> I'm not sure what it is used for though.
>
> It was to explicitly bind the ADC (specifically, its IO channels) to
> the PMIC devicetree node. However, since the core does this already,
> will drop.

I believe the PMIC binding should probably be updated with the
#io-channel-cells property then, isn't that so?

