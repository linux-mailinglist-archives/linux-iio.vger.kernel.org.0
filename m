Return-Path: <linux-iio+bounces-23487-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ED4B3CE91
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 20:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4400356387B
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 18:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7E72D878C;
	Sat, 30 Aug 2025 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1xQslMG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7A220B1F5;
	Sat, 30 Aug 2025 18:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756577294; cv=none; b=JJlnWAPe6wNerXN89wlfa3yjXdFpBCIs4VgcAUcPqqyZYykBAgZMpAmbIpYMHPTjxJ/AOVESHmDbljYpTMv1VdFYdj1Jq9bjLlK022qkLxMRCgDMCMLq4Lsi8RFRjLvJX/JH64sbjajzjB9pXAKkmU2rxuedNu6qU5rIZtj8alU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756577294; c=relaxed/simple;
	bh=ovfXQ4GkncKR+e9jX7HLkSh0L4SmXMHVegEmDjWMwd0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dccCpvaHVK2qY1IXK5hLeVlk6pcGmtj0q9f/vlkoMAGoYeRICcbLvIVWwrOGmoICvoME3DzmcyrozUvPAeM3WGsvLBSskydXb5z97XnlvhZ7uD0TAGN9tOdaFzohv0WkRVNsS8QPDovRjWqCP6PF5S2Z7ymlq7Q8HoesPwPtDgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1xQslMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3521BC4CEEB;
	Sat, 30 Aug 2025 18:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756577294;
	bh=ovfXQ4GkncKR+e9jX7HLkSh0L4SmXMHVegEmDjWMwd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W1xQslMGNcuoLa1p7x4SI6op6qjNpydUWNUmQ5tA/ERwXav8B5ekgUQAmF8uFPq5n
	 1oESqBJFiHEfOcoROzNm7n0BUzC13uP+5O8jOjsGYyBLJu8HtEdkoMQI/IyvYr4R0J
	 WfyNXuI7IHuneBfV7Z9pNkLrm4mYm3yIfHP5I6KLJqg/aN1NHL0mlBrd9Q4ac2zsEV
	 L0W8vm/Wq1OVe7oO6jaj/AD8Yifs9trkDVBjLneaVYjd+IHSEBMvs/W1K5pdLznpA0
	 jOYoA6kIA6LTOuOr3ancMLzYg/6tAfRKjOWn4VmKzcP8P2Pbvd6N3u0bbbyGndzJDn
	 i79mzmT8TeUfQ==
Date: Sat, 30 Aug 2025 19:08:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: ltr390: Add runtime PM support
Message-ID: <20250830190806.7dd92eb9@jic23-huawei>
In-Reply-To: <CAE3SzaR14zWWM_g-H4C76+6fBDotuAux7n2V1g94R2xLFQZOYQ@mail.gmail.com>
References: <20250822180335.362979-1-akshayaj.lkd@gmail.com>
	<20250825152608.6468c27b@jic23-huawei>
	<CAE3SzaR14zWWM_g-H4C76+6fBDotuAux7n2V1g94R2xLFQZOYQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Aug 2025 02:29:12 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> Hi Jonathan,
> Thanks for your review. Please see my followup inline.
>=20
> On Mon, Aug 25, 2025 at 7:56=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Fri, 22 Aug 2025 23:33:26 +0530
> > Akshay Jindal <akshayaj.lkd@gmail.com> wrote: =20
> > > +
> > > +     if (!state) {
> > > +             ret =3D regmap_clear_bits(data->regmap, LTR390_INT_CFG,=
 LTR390_LS_INT_EN);
> > > +             data->irq_enabled =3D false; =20
> >
> > Just take an extra reference to runtime pm on enable of event and put i=
t disable.
> > Then no need for special handling with a local flag etc. =20
>=20
> Consider a scenario, where the user only disables the event instead of
> enabling it,
> (i.e. user wrote 0 on the sysfs attribute before it was 1). In this case,
> If enable means inc ref count and disable means dec ref count, then
> this would lead to refcount underflow and the suspend callback will
> not be called.
>=20
> To handle this case, we would need to check whether irq/event was
> enabled or not.
> For that either we can use the local flag as I did, or I would need to
> do a read and test
> for the interrupt bit being set. I feel using the local flag would be
> cleaner and would
> require less code.
> If you are fine with local flag usage, then shall I not stick to only
> local flag usage?
>=20

Normally we'd check the register to find out what whether the event
is enabled or not.  If we are asking for the state it is already in
then just return having done nothing.  If bus reads are an overhead
worth avoiding regcache will ensure we only do it once.

Then if we are doing something, do the runtime pm get / put as appropriate.

Jonathan


> Thanks,
> Akshay


