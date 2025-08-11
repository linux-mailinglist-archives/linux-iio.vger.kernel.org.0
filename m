Return-Path: <linux-iio+bounces-22574-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1E9B20BBE
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 16:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0297B162844
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 14:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E3722D7A1;
	Mon, 11 Aug 2025 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Dx66m1sj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749D6229B13
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922104; cv=none; b=B5gVb5XNsUy6c/Yp+iFoK8TnyH6+YjyGJ1exVvK9Y8ixE+qPIEcd5YjGUFahCwu+/ilOSJDb0wFCT0TDLWaJ9OlnQRxOub/ufLQhlN5Ua64rZHq7WQDvdpVLTnE07uzgV1NePQYpYaeffQAfOou9uLmngZI5KDidT4veuDtIuzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922104; c=relaxed/simple;
	bh=Yqu91Mw2u58K7YukY/E38adIulhW9GLwRHDjlRWn2mI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4yaK3B9KeJIQsACZctM4giCDcu43+LYdWsasPfy9Qo3roAAMrRAST4BP1oov2aoJFjpYAmVTEq231dKZ+uz4ARWcQQOy3oIZJyZSxxmWq/Ja1SlZb2L7QtvWXy/7mO3iTRhiA4bHUpDtBjkV22FXBfUAn6YJ2iR4qZxirGsM1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Dx66m1sj; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1754922093; x=1755181293;
	bh=2ISnAhKRFakOlaBUCAkTfCVOv13Yq77JCKj6xfCLBbk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Dx66m1sjZdzURhymJxumzW4VLZQAWhYQK6IsTaQGcW7c5OpHs6mOG1U3VehZgCVIS
	 a2GaH2F65RIeE4hTJFJSfRIlh0rNZ/v+MvQDX+DyUFNbyeNkzCLNbQxMlN6C0yAM9e
	 eyW11b3xnzvzIQrkdM3VefCW4E0gJLUEny38BilFxTQ/lSLUP7WCTNIA7dwVumr5iW
	 fOpYvaQlQlOMQMKvkQU6aKSqYYrJbJMDHi4LTdc7kknDAgbcoXCkcjgxWpITUzoPCq
	 AQgRt1SUHUWpr3W7QbDEpIR7R0kApQYcWLmLvyCcyIC/vMddYmX4zxI4dCgEmdNEMJ
	 TfKFSKhC/O3wg==
Date: Mon, 11 Aug 2025 14:21:26 +0000
To: Andy Shevchenko <andy.shevchenko@gmail.com>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 1/5] iio: imu: inv_icm42600: Simplify pm_runtime setup
Message-ID: <yegzkmvizfcxwohvkxtfguylamvlpy3hsabkxydjwhyiy3fonn@mqjqdpkpo375>
In-Reply-To: <CAHp75Vc5CxOj77cw85hmioFTG6YJCe3ZJWwJsJW+QL79K8GpWw@mail.gmail.com>
References: <20250808-icm42pmreg-v2-0-a480279e7721@geanix.com> <20250808-icm42pmreg-v2-1-a480279e7721@geanix.com> <CAHp75VdKNE0xD8xbJQ2RSCA=_MB9DMZtXRTCNkpdKdv8vW-Q-w@mail.gmail.com> <20250809190609.4fef9df7@jic23-huawei> <CAHp75Vc5CxOj77cw85hmioFTG6YJCe3ZJWwJsJW+QL79K8GpWw@mail.gmail.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: e4e3371675e81746fe652610ce97b400bf471c4d
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 09, 2025 at 10:27:52PM +0100, Andy Shevchenko wrote:
> On Sat, Aug 9, 2025 at 8:06=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> > On Fri, 8 Aug 2025 23:37:51 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Fri, Aug 8, 2025 at 5:58=E2=80=AFPM Sean Nyekjaer <sean@geanix.com=
> wrote:
>=20
> ...
>=20
> > > > +       struct device *dev =3D regmap_get_device(st->map);
> > > >
> > > > +       if (!pm_runtime_status_suspended(dev))
> > > > +               regulator_disable(st->vddio_supply);
> > >
> > > I would rather use positive conditional as it seems to me more scalab=
le
> >
> > To potentially save time when Sean looks at this.  I don't follow. Do y=
ou mean
> > something like
> >         if (pm_runtime_status_suspended(dev))
> >                 return;
> >
> >         regulator_disable(st->vddio_supply);
> >
> > ?
>=20
> Yes.
>=20
> > If so I'm not seeing why we'd want this to scale as it's a single use
> > devm_set_action_or_reset() callback doing just one thing.
>=20
> While I agree in _this_ case, in general the check and return
> immediately is more scalable for reading purposes, e.g., indentation
> will be one level less. Also it won't require additional churn in
> adding {, i.e. changing conditional line just for that.
>=20

I like the return early if pm_runtime_status_suspended() is true.

Andy, when doing reviews please keep the function name, as it's much
easier to add the changes.

Jonathan, do we think checking pm_runtime_status_suspended() is a viable
option? Should we ask on the linux-pm list?

If it's ok; I will patch:
drivers/iio/adc/ti-ads1100.c
drivers/iio/pressure/bmp280-core.c
drivers/iio/pressure/icp10100.c

/Sean


