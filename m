Return-Path: <linux-iio+bounces-10511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAB199B540
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 15:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3F11F22434
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 13:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F1518953A;
	Sat, 12 Oct 2024 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnQO+rom"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E703E1E511;
	Sat, 12 Oct 2024 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728741010; cv=none; b=qpeoGZDXPP+S5asYgoyx+qV3z0iiuoQRPGM8MYhQ3FQl5yKgrrvt3H9dk31hW9wyXwSVoSWCC5mGRm59eBdnX74RDnFzOZkgs8CqMo8Q9qcnrvElvFI8aI3XkCYh73FBHt+uAkDIUxD1R+z1dTZjLYrNU6ppkcCAOSTw4dXvXz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728741010; c=relaxed/simple;
	bh=6EWyHw8HKcgTxodnlI+02n4ossslScOQMzJKHrr7ePE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCebp2w42XWxQkQ5XZFBhDXa9MdHfBCYlz030P4HhMjZwbZYsySBjojoBGYRbQa/3MqQn0uKhjYi6bK9zmg3Vsw35KYWymQtcMQpuL7TO/0dJzdUcoU7aD/vXIDgKySZvAMsqqFe5dWeDOKgeAdDOaU5Tn93/eImjjnDuXk1mCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnQO+rom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB7DC4CECE;
	Sat, 12 Oct 2024 13:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728741009;
	bh=6EWyHw8HKcgTxodnlI+02n4ossslScOQMzJKHrr7ePE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CnQO+rombQak1hdUpWoJyDinH7gFooGMs0efWZ2S/QiD8/ktOEVDoIQ4RhAT0uv10
	 /qZ2oQ+jsn5WLSB/dp8oETxkBWzxlv6oZm28E6SFkzNiR01eiOEuc0oNIt6TVV/Hqw
	 Xn2r246J8B/e4zlyrwj21oRmQuhZwoa0OAe1jSFNMCbcx3l1+oCq6+Z6Mv30/zQ3s0
	 TseOXhM3Uf+cWt/FB1hEYH/f34BUV/6G/pSSUF7UOxmW/Hv2XLukqW6CV8AV3CCuTJ
	 Fv+HrBAGuKaYlmSUuO3FTxQq4I8E9GxEIAQOLSaZT0ccyMxr3NMyPjyK1VmoUn7Lvo
	 m2VBDFTL3exAg==
Date: Sat, 12 Oct 2024 14:50:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich	 <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
  <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan	
 <olivier.moysan@foss.st.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dletchner@baylibre.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 02/10] iio: dac: adi-axi-dac: update register names
Message-ID: <20241012145001.133d9bbf@jic23-huawei>
In-Reply-To: <34ce8e9c13a3680c7a3ab44e5c91ab80042ad009.camel@gmail.com>
References: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
	<20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-2-3d410944a63d@baylibre.com>
	<a02f256c54089da4faa3ee1807c01b9cb6e70bc6.camel@gmail.com>
	<eyx4gykoki4b4gwf6rmtnjgqec3ltdgtszbjugidtf37uei4pn@jqczhf3thuka>
	<34ce8e9c13a3680c7a3ab44e5c91ab80042ad009.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Oct 2024 08:47:00 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2024-10-10 at 19:52 +0200, Angelo Dureghello wrote:
> > Hi Nuno,
> >=20
> > On 10.10.2024 14:59, Nuno S=C3=A1 wrote: =20
> > > On Tue, 2024-10-08 at 17:43 +0200, Angelo Dureghello wrote: =20
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > >=20
> > > > Non functional, readability change.
> > > >=20
> > > > Update register names so that register bitfields can be more easily
> > > > linked to the register name.
> > > >=20
> > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > --- =20
> > >=20
> > > I don't fully agree that this is so much better that's worth the chur=
n...
> > >=20
> > > From a quick a look I saw (I think) some defines where _REG seems to =
be
> > > missing.
> > > Those is fine to change for consistency but I don't really seeing the=
 big
> > > benefit in changing them all.
> > >=20
> > > (Sorry for only complaining in v5 about this...)
> > >  =20
> >=20
> > no problem,
> >=20
> > the change was suggested from Jonathan, was not something i need,=20
> > let's see if he has further feedbacks, in case i can roll back
> > easily.
> >  =20
>=20
> Oh, I see... Well, still don't think it's worth the churn but he has the =
last
> word on this :)
For some of the fields there was no connect between the field naming and
the register whereas there was for others.

That makes it easy for bugs to hide.  So on balance I do like this patch.

The disadvantage is that the fix in patch 1 will either cause us dependency
issues or have to wait for the merge window.

Given no one shouted about the bug before I guess merge window is probably
soon enough.


Jonathan


>=20
> - Nuno S=C3=A1
>=20


