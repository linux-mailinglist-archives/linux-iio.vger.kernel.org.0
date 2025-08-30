Return-Path: <linux-iio+bounces-23455-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE379B3CB0F
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 15:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932225607BF
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 13:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CA61E3DDE;
	Sat, 30 Aug 2025 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="OOZeaIUx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889BF1632DD;
	Sat, 30 Aug 2025 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756559248; cv=none; b=HxTL/J5PsuiTXNAf1bg34N99K4GmVSvuS7hrKYkMRny1ZDOlmCZTyk2uUhxxPpdxNVZ8y8AlTERKAlW5N0TfeQxHnvwcUDn66AoBm63OlrVYz+PC86BSDY/8vXAqoBwSsBbIX7/oNHBgYEFOxKB6cSXb/i0Vb8cxOKOcRgwCd1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756559248; c=relaxed/simple;
	bh=5KS0O4ZGTJRuZ+XjiT1yQ7ysM3FbhtQFxAlV7ZUyxuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SB1ubuHAjk1wZLPLaivdhS3Bq/PbfGQgz5KRxOX1yAG0R8v7xtc8TJut46bQlWzeI+fXWKJWbVjNF0nrGYhFuQKKuxQC6jCIQieXDWzf3BQ+h2JRRVe1mr6j0QUoV+YjF5IZVxeeQkj5VJdhQ/w6scCwEW81WfJxTil2rD4VKSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=OOZeaIUx; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=mxXxkZUBYF5bYtZ2X2zE0fR75h0KNKIPapF/RoR+gz4=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1756559233; v=1; x=1756991233;
 b=OOZeaIUxy1iac2ViPetI3Fw61UM5lvo0hMes5dn5vkB+jOsDp2WQ1yXCvPYKl7m7F6160I97
 MbSnm254g8KAbzt6AvaAEZK1UgrLl5sAJP06SdGuvsZWdRwe//nwYPBAhZBge9axUuX0cf8vWJp
 CHobMys6sBXg2iEpzzO/DMeSjDRlxjRqdDA4Db4N+ug02c+KZT7kZwljoR5o7mFGBDRr5byhrTv
 vlHpk8CCzGVrvRYTJHxSPTnbEDDWn3WfxsFZAsxLUZ/Z09LmrGNPYCtVcEQRo2tyHt9iqI/Nzth
 0q6rB+eY8Vw/ExrnyGTYw8dar2nKpb6/Bu7p/BTrEVY8w==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 55baaa3f; Sat, 30 Aug 2025 15:07:13 +0200
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
To: David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>,
 Lee Jones <lee@kernel.org>, David Wronek <david@mainlining.org>,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
Date: Sat, 30 Aug 2025 15:07:12 +0200
Message-ID: <22825864.EfDdHjke4D@radijator>
In-Reply-To:
 <CAHp75Vd+hAucOyjqLj=rY3oLSySiReVupRQdBjwoLQSPAZMNMQ@mail.gmail.com>
References:
 <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz>
 <CAHp75Ve=xJ6vTUydaTw9GuYr22ZXp3HFA5N0tP7NET=CvZJB8Q@mail.gmail.com>
 <CAHp75Vd+hAucOyjqLj=rY3oLSySiReVupRQdBjwoLQSPAZMNMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Saturday, 30 August 2025 06:41:58 Central European Summer Time Andy=20
Shevchenko wrote:
> On Sat, Aug 30, 2025 at 7:37=E2=80=AFAM Andy Shevchenko
>=20
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Aug 29, 2025 at 2:41=E2=80=AFAM David Lechner <dlechner@baylibr=
e.com>=20
wrote:
> > > On 8/28/25 5:17 PM, Duje Mihanovi=C4=87 wrote:
> ...
>=20
> > > > +     ret =3D regmap_bulk_read(*map, regs[chan], buf, 2);
>=20
> On top, please drop a double pointer and use map directly. That's
> already a pointer, what's the issue with it to begin with?

struct regmap is only defined in a regmap-internal header, so it has to
be a double pointer or a struct containing a regmap pointer. I went
with David's advice and created this struct.

Regards,
=2D-
Duje



