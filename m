Return-Path: <linux-iio+bounces-3108-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AFC868117
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 20:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9A96B22007
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 19:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94515130ADE;
	Mon, 26 Feb 2024 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwqQlZLn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A093A12FF68
	for <linux-iio@vger.kernel.org>; Mon, 26 Feb 2024 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975827; cv=none; b=ZigKHZBoxLLhNCLToU5JHDaYU/ArhFb8b2uo+kUto7a6gK1jBPqUiRBNwRMqpdN8oz6fgqayq5ZCy7zwHgI05gf5BoltoWnsWI6SDp6JUQi+pvDl1MLUes6mzdgyiGDDmoGY2m/zumjw/N2YyCjKmAjIBJip0rujYUOarO+6ms8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975827; c=relaxed/simple;
	bh=1Jw7z7D7vXEx996HpOCgaa7Nd7BCkmuDXTdGmROi+08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iU9IQWv9Gd8DUajZYfLFPLxRpNzRmyXvhP7xnJ5/5fC1E/kJb4CDURtYYlmXY1GLsaIugwgIKlKRiUdh76798JDHAV8jk9GugKIODkOH1c8mEDcyZrAe0p39IZfxMqLca5shYsWI22gAQkR+zWIXamcjGDz9o7WRw/ppQ8NdASQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwqQlZLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67801C433C7;
	Mon, 26 Feb 2024 19:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708975825;
	bh=1Jw7z7D7vXEx996HpOCgaa7Nd7BCkmuDXTdGmROi+08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mwqQlZLnoY8U10GxuK4PqHmYR6eXajRcDI/AcUHOn1yJo3WFacta+SmQ4LoIQ5jL/
	 bTt9TindQ2flHBSHeZmRErpdb0n9lFNcNJ/yDS2nLtPnWx3/x/1vAdt8qzJ7JRuwQ4
	 KKPLZfXWz6VabtMi9HOj/6ElnswEIpjaZNPV/zFQyXqRY8yhnWgMgmQCeKSeAPf3hk
	 X1QBgwBzWiqqQNuC7rfOK5+bsEBvlAD1kpDB66hm+7E48ptIqXG5qhNSuyxVH64Tyt
	 SV4083FNNR9+Tvo3vfdzxj/yETBHVR+QRTw5YBchyVBBcQVJOV08OABi9LxLiHGbDy
	 DfT2BVhHUdd5A==
Date: Mon, 26 Feb 2024 19:30:07 +0000
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
Subject: Re: [PATCH v5 1/9] iio: temp: ltc2983: Use __free(fwnode_handle)
 and device_for_each_node_scoped()
Message-ID: <20240226193007.670a6406@jic23-huawei>
In-Reply-To: <95e48bb871d172b51786b814388d8d6e001ac76a.camel@gmail.com>
References: <20240224123215.161469-1-jic23@kernel.org>
	<20240224123215.161469-2-jic23@kernel.org>
	<95e48bb871d172b51786b814388d8d6e001ac76a.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Feb 2024 09:35:49 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sat, 2024-02-24 at 12:32 +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > This use of the new cleanup.h scope based freeing infrastructure allows
> > us to exit directly from error conditions and in the good path with
> > the reference obtained from fwnode_find_reference() (which may be an er=
ror
> > pointer) automatically released.
> >=20
> > Similarly the _scoped() version of device_for_each_child_node()
> > removes the need for the manual calling of fwnode_handl_put() in
> > paths where the code exits the loop early.
> >=20
> > Tidy up some unusual indentation in a dev_dbg() whilst here.
> >=20
> > Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>
> > Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > ---
> > v5: Add the device_for_each_child_node_scoped() change (Nuno)
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
I'll pick up this now as whilst I hope someone will check the others, I know
you are building on this and it will make life easier if this is already
queued up.

Thanks,

Jonathan

