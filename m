Return-Path: <linux-iio+bounces-5299-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF928CF058
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 19:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD141C20A20
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 17:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1337F86655;
	Sat, 25 May 2024 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgHTja8g"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD008B644;
	Sat, 25 May 2024 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716656803; cv=none; b=Nr7ph1ovX43TcUj2nSGTvJzxlcyp9uO+EkaiVZsyPy36kMIw1W0cTUzTha0CPg8pE5AtvsOX3SbWLPth59wg0q2bpe6NkJ3iBTOzWXhRdEdBaIM7omGn3eWwDT1JoctYOsOs1vVQd7IADZOvfvmgcePMAuigNAyNtqsAsGnvyMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716656803; c=relaxed/simple;
	bh=tE6ZECodS00GPgxiBJ0iCYbVxSfe+MO5kN0/aXMxSAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jr7AYZCAsAK/kU/fIrLXR738XwafACYASKNANtbwjwwRCXAlNY1UPidAYXG564PzoFPNPZu45PlY+IhtLO6af8GBaR89JjGZqwTmug2Ttx/RO3TSQZpP9X+bDANnAteMKi8DQc28dhfFPRuOtrTFSYi7+wvNeu+bbm7OITbrEiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgHTja8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB57C2BD11;
	Sat, 25 May 2024 17:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716656803;
	bh=tE6ZECodS00GPgxiBJ0iCYbVxSfe+MO5kN0/aXMxSAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kgHTja8g7anhkAqdhs5fFANVREOpzf4xeqJ1OfsufeDQ/85RgrDu6vwK6rk4CVpi5
	 +WkcKyu3XrWCMTIewwfpsJQEkDkkQabH9Hk1gtJtX5lerL8UWsLCYEGzzGIjRXvEH+
	 ITMwf4DdLjCIy+5yJ/IC2SCQTqFuPiVoVJaMWcH0nTcexFHIgpmHYjxXFtMcEUbW6Q
	 yLr8sR95C4XftnKlc5RadA6Y8A28FkBFYH3EEMS8UydB7gN0ATmTVt1H2cZPdU6OXt
	 XEt8NSecEaZGFq6R6NoWc2HohqmH3ASYaynYr3WV0VliLtaF1vsms24tyKhJKOW6dS
	 DGEBqZwHaoEug==
Date: Sat, 25 May 2024 18:06:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
 lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] minor fixes and improvements
Message-ID: <20240525180631.13446abc@jic23-huawei>
In-Reply-To: <751faef385f81f8a2dd0dcc2acd2d4519bebebe5.camel@gmail.com>
References: <20240522150141.1776196-1-adureghello@baylibre.org>
	<751faef385f81f8a2dd0dcc2acd2d4519bebebe5.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 23 May 2024 14:45:01 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2024-05-22 at 17:01 +0200, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >=20
> > After testing this driver, add some minor fixes and improvements,
> > as adding single channel variants support (ad3541r, ad3551r), also as a
> > preparatory step to bigger future improvements related to fast-rate mode
> > for this DAC family.
> >=20
> > Previous patches (v1, 3/3)
> > https://lore.kernel.org/linux-iio/20240510141836.1624009-1-adureghello@=
baylibre.org
> > https://lore.kernel.org/linux-iio/20240510141836.1624009-2-adureghello@=
baylibre.org/
> > https://lore.kernel.org/linux-iio/20240510141836.1624009-3-adureghello@=
baylibre.org/
> >=20
> > Angelo Dureghello (6):
> > =C2=A0 dt-bindings: iio: dac: fix ad3552r gain parameter names
> > =C2=A0 dt-bindings: iio: dac: add ad35xxr single output variants
> > =C2=A0 iio: dac: ad3552r: add model data structure
> > =C2=A0 iio: dac: ad3552r: add support for ad3541r and ad3551r
> > =C2=A0 iio: dac: ad3552r: change AD3552R_NUM_CH define name
> > =C2=A0 iio: dac: ad3552r: uniform structure names
> >=20
> > =C2=A0.../bindings/iio/dac/adi,ad3552r.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 43 ++++--
> > =C2=A0drivers/iio/dac/ad3552r.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 140 ++++++++++++------
> > =C2=A02 files changed, 128 insertions(+), 55 deletions(-)
> >  =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
This series crossed with a series using
device_for_each_child_node_scoped()

I've rebased on top of that. Was moderately straightforwards but
given last week I messed a similar change up completely please
check the testing branch of iio.git!

The mess was all it the patch adding model_data

Thanks,

Jonathan

>=20


