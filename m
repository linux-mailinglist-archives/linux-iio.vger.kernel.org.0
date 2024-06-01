Return-Path: <linux-iio+bounces-5582-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396AF8D718D
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 20:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B46AAB21421
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 18:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904EE154BF7;
	Sat,  1 Jun 2024 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATN9Qb1Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40040208D4;
	Sat,  1 Jun 2024 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717267243; cv=none; b=lpz4RvXWOoH/Wt7yJ535EbaqNIJOWcZJl0IJcPegLCiYaFg0glF0gtnAJvw4O5xx6j9ET15krEbSiduTIWAGNY6Has3S6yTJAP2xcyMaTI9Fyw0HPVPZ5IBTFk+3hppoG4hE/XPV5bSOm/EBC6gmNCUeOkSC/KLGfB7VsJrXneE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717267243; c=relaxed/simple;
	bh=LR/c8x+xXZigA1KgG3xrmw32mIIHb4FKtgh/evN9SM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjqp9/c4s/ZxmRJr2kio7Nawf8idtXnWhG9Z06u5iofXcHIpqYAh8gl6CStTqCKVDF1BH/vAZLjYImNj03ahlc5fyQrT2tzdtiibKdZtHkeKNnsh5DQha0XGDs0QVzvTQ48pkL9S5EvvE8sKr6DXAxeexmVz3C4BGbeoGITGzjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATN9Qb1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4473C116B1;
	Sat,  1 Jun 2024 18:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717267242;
	bh=LR/c8x+xXZigA1KgG3xrmw32mIIHb4FKtgh/evN9SM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ATN9Qb1Q/SYgGwtk3wP8kvB3/y8+DRjJA8v1hmyRJ/eLdP0QxQAB44DsMT+mu4Xzk
	 SHv3yJCzIkg7gk1LztXMe6qxxJziJsG7ZviTNApc1uDS7cKus6+D3R/uCKE8ASoCIF
	 3HWi4TON/z3r08sHdJsH2uW15L2Yx4tjx7zeXsz187l4hfH4RkA0/t0oxfO2PPB3m0
	 VnhrkcTlCq2i2TvcWLQkiZQ/aqbnXRfAaJWrV6mnt7UioOUBNEjK8gH7US+EOoXMBu
	 4btudvWHnlBYOtsTs8R7ILHaXf1H0yWWY8+hNP8B1cSYF4KvuD2+Rw2VH09OgEkJet
	 osMYhweOv4pQg==
Date: Sat, 1 Jun 2024 19:40:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>, dumitru.ceclan@analog.com,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: adc: ad7173: refactor ain and vref
 selection
Message-ID: <20240601194027.67c97d76@jic23-huawei>
In-Reply-To: <5e263d5ce90d6ad187adb7d4a007ce2e79095829.camel@gmail.com>
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
	<20240527-ad4111-v3-3-7e9eddbbd3eb@analog.com>
	<71452f6882efe6a181d477914488617d28a38e2f.camel@gmail.com>
	<4b704b553282c0689dfef714c49ba97a33198898.camel@gmail.com>
	<d2f4e6da-75b1-4450-b295-45772dfb3f33@gmail.com>
	<5e263d5ce90d6ad187adb7d4a007ce2e79095829.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 May 2024 09:10:43 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2024-05-30 at 17:45 +0300, Ceclan, Dumitru wrote:
> > On 29/05/2024 15:49, Nuno S=C3=A1 wrote: =20
> > > On Wed, 2024-05-29 at 14:27 +0200, Nuno S=C3=A1 wrote: =20
> > > > On Mon, 2024-05-27 at 20:02 +0300, Dumitru Ceclan via B4 Relay wrot=
e: =20
> > > > > From: Dumitru Ceclan <dumitru.ceclan@analog.com> =20
> >=20
> > ...
> >  =20
> > > > > +static int ad7173_validate_voltage_ain_inputs(struct ad7173_stat=
e *st,
> > > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ain[2]) =20
> > >=20
> > > Pass the pointer and size of it... Also, it should be made 'const'
> > >  =20
> >=20
> > I'm learning here: what is the purpose of passing the size of it?
> > This is a specific case where the size will always be 2
> >  =20
>=20
> Basically readability... Yes, in this case it will be a stretch to assume=
 we'll ever
> have anything bigger than 2 (so the scalability argument is not so applic=
able) so I'm
> ok if you don't pass the size. It's just I really dislike (as a practice)=
 to have
> raw/magic numbers in the code. In here, it won't be that bad as by the co=
ntext, one
> can easily understand the meaning of 2. Nevertheless, I would, still, at =
the very
> least consider to either use a #define or a better name for the iterator =
(anything
> more meaningful than 'i' so that it looks more understandable than 'i < 2=
')
>=20

I'm late to the game, but I'd just split it into two parameters.
Code is shorter as well.

static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
					      unsigned int ain0, unsigned int ain1)
{
	if (ain0 >=3D st->info->num_inputs ||
	    ain1 >=3D st->info->num_inputs)
		return dev_err_probe(&st->sd.spi->dev, -EINVAL,
				     "Input pin number out of range for pair (%d %d).\n",
				     ain0, ain1);
	return 0;
}

> - Nuno S=C3=A1=20
> >  =20
>=20


