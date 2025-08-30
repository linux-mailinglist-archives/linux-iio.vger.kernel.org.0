Return-Path: <linux-iio+bounces-23465-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19C6B3CD16
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 18:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6571C207BEE
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 16:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6D72D24BC;
	Sat, 30 Aug 2025 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="YMiKrohF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5AE2D24A5;
	Sat, 30 Aug 2025 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756571367; cv=none; b=a/4YalXi1lcNnEg4LkZHS8pU61lfQTYWl3DJVRJFPlzsIxtu3uly/zxRKD7sX5JISiCNbJUcMa7KpGfrS8o7g4nsats34QLWaBj96b2YWAfy74bkbNEUbbyudQuSRaZN/OxK3rWE+Vru3V0QvchyeE1TOkmhFFLa4GJux00WMrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756571367; c=relaxed/simple;
	bh=uE4LBUrOK8Zfb9RWv7X/lsQaqJGhS2HzCZ8KaQqfhJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iq9/CxgtmISp8wMfgicukiJ/pilOnnJzUL5T0SQX1/aPNchYNLQlK2H+9Uswja5sRp2yHIFVgBxYmj+Awgb3DQx5NcF8S5jlNkTj9Po7PGUEXFrih+tmAo2ZBpnk8HNiK/AnuK+Ikdx32ZVotRIJaIGnyY4tSukG9ImjfiQrgrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=YMiKrohF; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=J7oKY9aeWRA54ISXN0P4ha3epQPBP25dKfwt7/+vG4k=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1756571349; v=1; x=1757003349;
 b=YMiKrohFsXZ26eryhi+eVM2XFJU+gARHgwtsRlX2HsR9SEu6LIajNBurRBQuIRJFXNLZsstB
 f+YH+QdxYz9utStWm2wDDMiRLrnwaX+uzS+fMc44Ez7geSLFKd/F75nry13b4A3d/6I9W2pYzVN
 JY5/Q/j90f22u2kniGRrZtr8DifAqOsdmHfXzlRvmH66jhMpKx3cLCZfw7w1M1eKrz0O/rjU6fR
 YddZhTIeOKMt89CiZk/+as0a28drDA0eU0K9+e77duzTPgzXrmdFoSwbzouNk1bkh6dT7BIHv6F
 AjBSt2i3mTL1cWj7aZPXABYTV8wky1mU5GDQEMU9jeWMQ==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id cfcca67f; Sat, 30 Aug 2025 18:29:09 +0200
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>,
 Lee Jones <lee@kernel.org>, David Wronek <david@mainlining.org>,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
Date: Sat, 30 Aug 2025 18:29:08 +0200
Message-ID: <6191915.lOV4Wx5bFT@radijator>
In-Reply-To:
 <CAHp75VcU-AbfRfMZUanV8eHb5oatQPhGS-ntyWuDFtUgKc-OLA@mail.gmail.com>
References:
 <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz>
 <10724132.nUPlyArG6x@radijator>
 <CAHp75VcU-AbfRfMZUanV8eHb5oatQPhGS-ntyWuDFtUgKc-OLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Saturday, 30 August 2025 16:53:48 Central European Summer Time Andy Shev=
chenko wrote:
> On Sat, Aug 30, 2025 at 4:04=E2=80=AFPM Duje Mihanovi=C4=87 <duje@dujemih=
anovic.xyz> wrote:
> > On Saturday, 30 August 2025 06:37:27 Central European Summer Time Andy =
Shevchenko wrote:
> > > On Fri, Aug 29, 2025 at 2:41=E2=80=AFAM David Lechner <dlechner@bayli=
bre.com> wrote:
> > > > On 8/28/25 5:17 PM, Duje Mihanovi=C4=87 wrote:
> > > > > +config 88PM886_GPADC
> > > > > +     tristate "Marvell 88PM886 GPADC driver"
> > > > > +     depends on MFD_88PM886_PMIC
> > > > > +     default y
> > >=20
> > > Really? Why tristate then?
> > > I would expect default MFD_88PM886_PMIC instead,
> > >=20
> > > > > +     help
> > > > > +       Say Y here to enable support for the GPADC (General Purpo=
se
> > > > > ADC)
> > > > > +       found on the Marvell 88PM886 PMIC. The GPADC measures var=
ious
> > > > > +       internal voltages and temperatures, including (but not li=
mited
> > > > > to)
> > > > > +       system, battery and USB.
> > >=20
> > > Please, add a line about the module name if one chooses 'm'. Or see
> > > above =E2=80=94 drop the "tristate" and explain why this driver may n=
ot be a
> > > module in the commit message.
> >=20
> > 'default MFD_88PM886_PMIC' would make it y as that one is a bool. How
> > about 'default m if MFD_88PM886_PMIC' or, since this already depends on
> > _PMIC, 'default m'?
>=20
> I didn't get it. Why? defaulting to MFD is okay, otherwise one needs
> to explain 'y' (and even explicit 'm' choice) for the _leaf_ driver.

I just wanted to keep the driver as modular as possible, including by
default. Regardless, this sounds OK to me.

Regards,
=2D-
Duje



