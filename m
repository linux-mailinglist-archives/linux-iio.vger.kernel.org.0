Return-Path: <linux-iio+bounces-11362-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD749B1A18
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 19:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93419B21607
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 17:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB7C1CACF7;
	Sat, 26 Oct 2024 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWvh3vkw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85B41531EA;
	Sat, 26 Oct 2024 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729964159; cv=none; b=UQfQgV12TQRiHioWMYbg3AV+Q31WzvMOhjaBLcb0dugLBNMT3NnwDuZuIerxefr8fYJXUZj9RGyr3CWl4wc3Xm8TZcvFWvRcMq6g987BGXFOO+hk3yy0yU2aRBXXnAPhqtm33HTTPeiso37nNLy9cVtpijsefwPYabDLGhP+93o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729964159; c=relaxed/simple;
	bh=vzweB+jXCTcI1HfN4bxxv3ww/Ee1lK0HAib7kJZ/DEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLdHkRNb2EVnLg8hrXCl2lC7L2H9YxnrnS749o9f6L4Vs8adnvn7bjf3xDMaan/GXr0vStArvPAZKfhX06XSGpIbU7vUi07Y8YLzejSLVjqkhDztDqWuaIbdx/0Sp2RZclyPcJWtU8W2AdLSlwXiRE4ozIVaFnSfUo760L1w8OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWvh3vkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F11C4CEC6;
	Sat, 26 Oct 2024 17:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729964158;
	bh=vzweB+jXCTcI1HfN4bxxv3ww/Ee1lK0HAib7kJZ/DEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MWvh3vkwuX9588RqTxWNuSGRR0FgnuH1WIgMuL4Phhn4ll119pJUD12z2S6lVhUuH
	 ozMbuINnGQ2lAVyxAY1QS31c5iC/aKhaf+lf8sbyTFiLdAGKhJwpqbhk0tqAYsUdCO
	 WTolR+ZnyLUPrv99cBL/qNQp1hg5rKFtEoDTz/riMN1dW2o7gMzPrDZzQbcfPAvPRM
	 +a2ezplXProrQ0+4iUiyYUCY7xGqQ4u+Thjmfw2ARYEx4jazKFduhc/6azP8GxOmyy
	 /ZCXtLoqrrWecWOnlfF3l4ylMACdNS7Z3GHMm1YhGJlHrtMObmb9PNGj3TvqsmVLRN
	 /ofzTAoq4S+QQ==
Date: Sat, 26 Oct 2024 18:35:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier
 Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown
 <broonie@kernel.org>
Subject: Re: [PATCH v7 7/8] iio: dac: ad3552r: add high-speed platform
 driver
Message-ID: <20241026183502.40662850@jic23-huawei>
In-Reply-To: <f70854c2-8006-4278-b149-6d8c3e76b30d@baylibre.com>
References: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
	<20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-7-969694f53c5d@baylibre.com>
	<9f00e86e8a7d8f821cdb79d5b083235daec481a9.camel@gmail.com>
	<exprb7zhsr5qbpjdhbxisodmm4pf74hwl7ijql5o6zyuc3assg@sf53j42lzurf>
	<14d0f5fb4240a7e0c3665d4ffc128117c5515ac6.camel@gmail.com>
	<wvnyqgng5h2trpjlrwuvxryvy2i7sftnribnkjp5uh5ogrxdoc@wbh5do3rmqqe>
	<f70854c2-8006-4278-b149-6d8c3e76b30d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Oct 2024 10:13:25 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 10/24/24 10:02 AM, Angelo Dureghello wrote:
> > Hi Nuno,
> >=20
> > On 24.10.2024 15:05, Nuno S=C3=A1 wrote: =20
> >> On Tue, 2024-10-22 at 18:40 +0200, Angelo Dureghello wrote: =20
> >>> Hi Nuno,
> >>>
> >>> On 22.10.2024 14:28, Nuno S=C3=A1 wrote: =20
> >>>> On Mon, 2024-10-21 at 14:40 +0200, Angelo Dureghello wrote: =20
> >>>>> From: Angelo Dureghello <adureghello@baylibre.com>
> >>>>>
> >>>>> Add High Speed ad3552r platform driver. =20
>=20
> ...
>=20
> >>>>> +	switch (mask) {
> >>>>> +	case IIO_CHAN_INFO_RAW:
> >>>>> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> >>>>> +			return st->data->bus_reg_write(st->back,
> >>>>> +				=C2=A0=C2=A0=C2=A0 AD3552R_REG_ADDR_CH_DAC_16B(chan- =20
> >>>>>> channel), =20
> >>>>> +				=C2=A0=C2=A0=C2=A0 val, 2);
> >>>>> +		} =20
> >>>>
> >>>> Maybe we'll get the new stuff in time for this :)
> >>>> =20
> > This is not clear, sorry.
> >  =20
>=20
> Probably this :-)
>=20
> https://lore.kernel.org/all/20241023105757.GA9767@noisy.programming.kicks=
-ass.net/
>=20
> But it hasn't reached the stable tree yet.

Agreed. It is going to be nice to get rid of so much ugly code.
I guess mostly next cycle however.

Jonathan

