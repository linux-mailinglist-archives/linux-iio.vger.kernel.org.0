Return-Path: <linux-iio+bounces-4102-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7534E89AA4F
	for <lists+linux-iio@lfdr.de>; Sat,  6 Apr 2024 12:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05ABEB218B6
	for <lists+linux-iio@lfdr.de>; Sat,  6 Apr 2024 10:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E621D24B2A;
	Sat,  6 Apr 2024 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoUT8I75"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65B41C69E
	for <linux-iio@vger.kernel.org>; Sat,  6 Apr 2024 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712398713; cv=none; b=nsyN9reziR/Cs3P2UADZ9+tZsoiecqfwbmTrFw/VBALBuyPbVpJHzdCXQh2YC2EsnYGNNtdAiZ4peWnFQucK4HTGhvVHAWcLoFblb+0Ag/TZU3h4Z3xPwlDAnXjj7Uup1xfJOy/QVezY8Uft+RNrRGL9OAzjCxF76LUJc5dJbLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712398713; c=relaxed/simple;
	bh=gqPXySi4hnbiXQ5FROF29cwwli3blKzGrV2W/rs7GFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWbQF9drzJYoKUYsHqzPavIDvl/70u1BayDm8ip3AkYE3f8K5HcQg8BLatb6KpBM4BPHUEmpJHIWEmCcvP8kNWkw5shl0sGch6aWaFcn6BouFJQH3ph7hybJneUGpyshvn/hE/mw0XluJOkbFLQNu2hUwMVC3C1uqRYRpq9hcV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoUT8I75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10ECC433C7;
	Sat,  6 Apr 2024 10:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712398713;
	bh=gqPXySi4hnbiXQ5FROF29cwwli3blKzGrV2W/rs7GFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uoUT8I75NBTgGkVrB/48Bn5nPOM4Qyk+J2k/etDiosk6HEMvm5Lws6zrtphQSbP+C
	 lzEBnH8v0BxjUJz/NglnFr98A/rdsgjCwdfosDrf/DadLy6ge6T5dhympia7xkjMz7
	 vn32KHIGvR+TGEu5n3O9HAL532xmUP4RQqX5dsVcO/YP4OekV663phMy56Qaia8LB9
	 WT/xp1K1vSDfmAnnJg362qdUByYvs/eXK3QvMtgXNoHNDgVTPYlJA1DqCWTXMT/gdW
	 g3s7ZtZR3bw2Bs15Y2gC6/QysW7H/d1xE/DB68nT2thH4xnYyhs+ggg4uoiSiiv20P
	 qVFQ+YHtJt50A==
Date: Sat, 6 Apr 2024 11:18:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?=  <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Mihail Chindris <mihail.chindris@analog.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Tomislav Denis
 <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Marijn Suijten
 <marijn.suijten@somainline.org>, Marius Cristea
 <marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 7/8] iio: dac: ad3552r: Use
 device_for_each_child_node_scoped()
Message-ID: <20240406111817.167d47b8@jic23-huawei>
In-Reply-To: <2f506f64a1b3dc0b7eccead4bac04869d55c52d2.camel@gmail.com>
References: <20240330185305.1319844-1-jic23@kernel.org>
	<20240330185305.1319844-8-jic23@kernel.org>
	<2f506f64a1b3dc0b7eccead4bac04869d55c52d2.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 04 Apr 2024 11:14:17 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sat, 2024-03-30 at 18:53 +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > Switching to the _scoped() version removes the need for manual
> > calling of fwnode_handle_put() in the paths where the code
> > exits the loop early. In this case that's all in error paths.
> >=20
> > Removing the goto err; statements also allows more extensive use of
> > dev_err_probe() further simplifying the code.
> >=20
> > Cc: Mihail Chindris <mihail.chindris@analog.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > --- =20
>=20
> Hmm, Mihail is no longer in ADI... I'll see what other drivers he's
> "maintaining" and default them to me.
Great.
>=20
> Anyways,
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
I'll carry on picking these series up piecemeal on basis of
reducing how many patches are outstanding as tags come in.

Applied.


