Return-Path: <linux-iio+bounces-23255-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B748B34557
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 17:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924FA1885F0C
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA182F39A7;
	Mon, 25 Aug 2025 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="AHTmaT4j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5FD2F360C
	for <linux-iio@vger.kernel.org>; Mon, 25 Aug 2025 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134878; cv=none; b=fFBQZVk5FDs1kyzVwAgoW6rnq9RIHMeDTnjPviK1Y+1GCmMVAtEQJeNQdREMGd1te2AvsEXB7jTvURyQ155uKHGm0dSrH64AlxXWjNY9Bl9DAPMWBZOZEuQBL4idUhXnm80UUbYWBdjyFEiF7RW06W9rA9U9JUk8UkHCBhGXX7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134878; c=relaxed/simple;
	bh=rXdwHNU85Qjk0GtyGVi9u1XRwpYcyepp/ONeSlt5oIA=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHOSXUOO4hNCq20RQTLz2lkroaz32g4w7pNDnEvdrXKl5waXSjmkw9HBaKlW9XeapJghmWkeW2bJvywSPa9BaNa6UW/VNvg9jomB6UXLi2VE/zwE4xjDYr7aeCPcRRMpvz1GAof6eQTg74xb6AOqQn7b4YcB3iRLjTo5zxEJIcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=AHTmaT4j; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1756134861; x=1756394061;
	bh=3/6Aun7aUZM0TUc8HgYjVm375wAKs/aNao7PL8OhJ/Y=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AHTmaT4jNTvu0jCNmKr6qAOZYSUT4rNmhgZo5XBECd0WH40ravtq6FfQhw/QmhMw9
	 i0Tovk+RwRRANg5TcB9ikSYiFOuA/d5g6qYxE5ubbipLSeTRGdQ1FMsb8IQHjtNTe1
	 MOpQv47xDnvT4aN1an2sihY0cQ7HMJRKUW+F4LTRogrZtewytCm0xipArG9KGIELpo
	 /IiLdRwSMTYoPBL7BccCotF7aWPJiHukJxMPXcmvAgTT1sNrPXvExINb15zS3PACk+
	 umnKQyfSTRPImd/sOs2R1k+xAOHThDjbIkeD/hMrNEgpnhHzmy7rgMuackp91Z1s3E
	 H/t01WqMKOqFA==
Date: Mon, 25 Aug 2025 15:14:15 +0000
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH v2 1/5] iio: imu: inv_icm42600: Simplify pm_runtime setup
Message-ID: <6utm3ywkymr3hretvru7xkdv7p7p3wtmd62blfyapmgagr3pzc@42oiakgdxmqp>
In-Reply-To: <yegzkmvizfcxwohvkxtfguylamvlpy3hsabkxydjwhyiy3fonn@mqjqdpkpo375>
References: <20250808-icm42pmreg-v2-0-a480279e7721@geanix.com> <20250808-icm42pmreg-v2-1-a480279e7721@geanix.com> <CAHp75VdKNE0xD8xbJQ2RSCA=_MB9DMZtXRTCNkpdKdv8vW-Q-w@mail.gmail.com> <20250809190609.4fef9df7@jic23-huawei> <CAHp75Vc5CxOj77cw85hmioFTG6YJCe3ZJWwJsJW+QL79K8GpWw@mail.gmail.com> <yegzkmvizfcxwohvkxtfguylamvlpy3hsabkxydjwhyiy3fonn@mqjqdpkpo375>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 8ac87c0f8133c81bbced517b3d3a312ea4133a34
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 02:21:26PM +0100, Sean Nyekjaer wrote:
> On Sat, Aug 09, 2025 at 10:27:52PM +0100, Andy Shevchenko wrote:
> > On Sat, Aug 9, 2025 at 8:06=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> > > On Fri, 8 Aug 2025 23:37:51 +0200
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > On Fri, Aug 8, 2025 at 5:58=E2=80=AFPM Sean Nyekjaer <sean@geanix.c=
om> wrote:
> >=20
> > ...
> >=20
> > > > > +       struct device *dev =3D regmap_get_device(st->map);
> > > > >
> > > > > +       if (!pm_runtime_status_suspended(dev))
> > > > > +               regulator_disable(st->vddio_supply);
> > > >
> > > > I would rather use positive conditional as it seems to me more scal=
able
> > >
> > > To potentially save time when Sean looks at this.  I don't follow. Do=
 you mean
> > > something like
> > >         if (pm_runtime_status_suspended(dev))
> > >                 return;
> > >
> > >         regulator_disable(st->vddio_supply);
> > >
> > > ?
> >=20
> > Yes.
> >=20
> > > If so I'm not seeing why we'd want this to scale as it's a single use
> > > devm_set_action_or_reset() callback doing just one thing.
> >=20
> > While I agree in _this_ case, in general the check and return
> > immediately is more scalable for reading purposes, e.g., indentation
> > will be one level less. Also it won't require additional churn in
> > adding {, i.e. changing conditional line just for that.
> >=20
>=20
> I like the return early if pm_runtime_status_suspended() is true.
>=20
> Andy, when doing reviews please keep the function name, as it's much
> easier to add the changes.
>=20
> Jonathan, do we think checking pm_runtime_status_suspended() is a viable
> option? Should we ask on the linux-pm list?
>=20
> If it's ok; I will patch:
> drivers/iio/adc/ti-ads1100.c
> drivers/iio/pressure/bmp280-core.c
> drivers/iio/pressure/icp10100.c

Hi Jonathan,

Did you see my question here?
Just ignore this if you are vacationing...

/Sean


