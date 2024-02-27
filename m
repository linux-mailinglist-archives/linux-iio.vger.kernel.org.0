Return-Path: <linux-iio+bounces-3118-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D35868A7C
	for <lists+linux-iio@lfdr.de>; Tue, 27 Feb 2024 09:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C672F281135
	for <lists+linux-iio@lfdr.de>; Tue, 27 Feb 2024 08:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA4556442;
	Tue, 27 Feb 2024 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRogejLH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5157156440
	for <linux-iio@vger.kernel.org>; Tue, 27 Feb 2024 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021315; cv=none; b=BkVJwh3r2zP5K0nMSbgY0eLHiWGAPcLprNIpu/nGlf/Ioe8fTSs/q8PzzLx9S0jtkXMWZvPzzi4P71NjLcrbwHELwLHvThTKYKzG/Lq0yGio/d/Gm1o45hamtMDHl9LtxJCV/MoSluSDbSGmuC0m6Z+gllGpS9oa+zHomB+qeh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021315; c=relaxed/simple;
	bh=MFgLu/hDZry4e1JojNb9IhbNh+eaC/HuiME0ix/QRNs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qLsrJzZMcaW99rJxn+I5om1nIP1JfK09+z03kkDAjRaY5nst/8rirCLr/nsKiY05UeK6ROhuor8aKu2VTzgpSSVkmaMLEgMsFdmEVX/Wixp1Y6bD90Vuv+F5IOfD+GiS3MlOybRGWhuvK+x/WpEHC5MkxU4dco+Y2ysT2JMfGnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRogejLH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3f3d0d2787so396237566b.3
        for <linux-iio@vger.kernel.org>; Tue, 27 Feb 2024 00:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709021312; x=1709626112; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MFgLu/hDZry4e1JojNb9IhbNh+eaC/HuiME0ix/QRNs=;
        b=lRogejLHVNsgTavzSiXNPlNij1HimfuBXuRvGxuHzaewrWX6koRv+YyuvQiSsm51iu
         QHRUTvYmaMuIZ1TSNMmo5Qtig2xFR8DgbwOHNV2tykuck+2D0sab4jw8DZ/+IklczWDh
         YoBOsJOJFNjwiBZZJ6jbxl1FOIdpr0w81PYAJ3RfENBsTkhMPJ98J4Hk45OXrtGcmwg9
         Bk/VKpwCg9n5yi2RJxvH44RS4eFl2TS8PJnkY0xUdyZcKTV1buwbi96tMHcR7RN+R5aG
         W3x1kYMN+nma77n3km9JIZrlGbFhCjhnFiCmWOzuborOwhWEgEouMgSjc0J679xNqNOa
         EXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709021312; x=1709626112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MFgLu/hDZry4e1JojNb9IhbNh+eaC/HuiME0ix/QRNs=;
        b=WZw3D7Mieqb+JdkMawtcv+dEQ7cqR26sFe8LpmwDwJpv5hRxWqzdKCUUR7Fkcn5T/l
         dzy+xr62erZ9yxEuaTivvhI1NVobdwJhw+ul+5FJcPfNkSVqKcPWq9T8YlwFM2LeJXLT
         xzD4/2cAkeUxMHesrsKLjO5YNZQ+V7HJJhZzyJDM4/W8IUxTiu/0/78pB3D9vkcM9Z5I
         5zpQvw3kY2Qy6FFFjIfLaC8V8/USba9rAgW8D3Lyrf9Q3rVirk6QhMTl3yn0NgZtWXiZ
         xG5i9hPZjk2tmc73vCN8nMC5va1kXyyEcaaTve55zP8o8My7KI8psXFwyQbO4OhRdArG
         uwyA==
X-Gm-Message-State: AOJu0YwH6nh0DImTsZpHYzVn7PWEfzkhKp1pBPqWT3R/UQAsk6JGrkOv
	Z+YpyULLG5r7BuvmLx6whWjfmIkQHFzFsSynPQQIyDIPl/NFI0o7jecnaAOygsk=
X-Google-Smtp-Source: AGHT+IEoTwKMYapEtzsqg7jPtnUQYhkkG2+PzTCoriKuZVSpvXvvkc3FdKHKJl3lVAr+8DPe4ki5nw==
X-Received: by 2002:a17:906:4f91:b0:a3e:7d36:62b1 with SMTP id o17-20020a1709064f9100b00a3e7d3662b1mr5649414eju.46.1709021311390;
        Tue, 27 Feb 2024 00:08:31 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id p20-20020a170906141400b00a3ce60b003asm510493ejc.176.2024.02.27.00.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 00:08:31 -0800 (PST)
Message-ID: <91e8fe48524d13891cb12bf756da24286dcd8af3.camel@gmail.com>
Subject: Re: [PATCH v5 1/9] iio: temp: ltc2983: Use __free(fwnode_handle)
 and device_for_each_node_scoped()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Mihail Chindris
 <mihail.chindris@analog.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Tomislav Denis <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>,  Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>,  Marijn Suijten
 <marijn.suijten@somainline.org>, Marius Cristea
 <marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Tue, 27 Feb 2024 09:08:30 +0100
In-Reply-To: <20240226193007.670a6406@jic23-huawei>
References: <20240224123215.161469-1-jic23@kernel.org>
	 <20240224123215.161469-2-jic23@kernel.org>
	 <95e48bb871d172b51786b814388d8d6e001ac76a.camel@gmail.com>
	 <20240226193007.670a6406@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-26 at 19:30 +0000, Jonathan Cameron wrote:
> On Mon, 26 Feb 2024 09:35:49 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Sat, 2024-02-24 at 12:32 +0000, Jonathan Cameron wrote:
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >=20
> > > This use of the new cleanup.h scope based freeing infrastructure allo=
ws
> > > us to exit directly from error conditions and in the good path with
> > > the reference obtained from fwnode_find_reference() (which may be an =
error
> > > pointer) automatically released.
> > >=20
> > > Similarly the _scoped() version of device_for_each_child_node()
> > > removes the need for the manual calling of fwnode_handl_put() in
> > > paths where the code exits the loop early.
> > >=20
> > > Tidy up some unusual indentation in a dev_dbg() whilst here.
> > >=20
> > > Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>
> > > Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >=20
> > > ---
> > > v5: Add the device_for_each_child_node_scoped() change (Nuno)
> > > ---=C2=A0=20
> >=20
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> I'll pick up this now as whilst I hope someone will check the others, I k=
now
> you are building on this and it will make life easier if this is already
> queued up.
>=20

Thanks,

Will work on top of that for my series.

- Nuno S=C3=A1

