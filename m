Return-Path: <linux-iio+bounces-23540-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A2CB3D426
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 17:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86DD3BF0F6
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BCB218580;
	Sun, 31 Aug 2025 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtyvF//U"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427867261E
	for <linux-iio@vger.kernel.org>; Sun, 31 Aug 2025 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756654324; cv=none; b=OThyp0pMRSuHdqm1eYT23WjdzQkEuFUk+lwfNvuXXvRuFWgBOQpkDiLA2iGSSZI/GctjfqkrdUBgEryt6rpjlup3eQhF+5hCv4qyyfd3mzaqKLGGc6SKjoiDne6YTBPMhrfl1VRiDIUvuHa/QHhQ6rAipGt40HqogImjMj2NQpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756654324; c=relaxed/simple;
	bh=9DiTigFKgq3LRYcYCL5ysCeqd8Q8UgOjVXRU9ktHStA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTE2eSmRC0yRwdRItwddC6BrRyinM4Af5pY5qJ1I6y3rL+DZJndI+f3qfjZ5YpfzeXZRDPTeqVXZ/3SQzLgkaAPfH6UeMvckIyDD6ToE3KUh4C7V7TTmY6jmSpyAJSZVRhieY6I8c2B77Q5hG+2WThfr+pLyn8wEiEHbpa3oQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtyvF//U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5893C4CEED;
	Sun, 31 Aug 2025 15:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756654323;
	bh=9DiTigFKgq3LRYcYCL5ysCeqd8Q8UgOjVXRU9ktHStA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gtyvF//UCl5UpCvLRjdXLNQ7GaejcXidL3WEuLL2ebSQmwWLT4tkRp3Xy5rNEb4gC
	 BoIgCjdYWfQUHw8k7UtooDlPLzKWm543TxwsqrYngAfk2qJbFc0j7pcfpUKaqo36Ae
	 ANYJXkpECnGgpJ6TQiOYvl4tbx7JaztQrAcDkFPn3siMF0tyJIveVMdMtM/mqy8rc3
	 IpgJVMT44WLoFYFe3YBI81YhVqr2vJU6mIQang1+i+6GNEDl3kpPLMi8e29ThfNaUt
	 3onwEYEvo91HBuBLLLCqBTB+iEwCIdzlYnrLT+25tq1e+AeMDpDnH1QPoZUVPugWCu
	 6FZN42y2PCCaQ==
Date: Sun, 31 Aug 2025 16:31:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: Sidharth Seela <sidharthseela@gmail.com>, "dlechner@baylibre.com"
 <dlechner@baylibre.com>, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [RFC] chemical/mhz19b.c: Integrating mh-z-series in
 mhz19b_of_match.
Message-ID: <20250831163155.43574713@jic23-huawei>
In-Reply-To: <CAKbEznu_LH9azd-xF3hizsrqzJm51K-ixi32VNXe93vvR4WrAA@mail.gmail.com>
References: <CAJE-K+CTfwVJkKEzb8D0hijg1VRK4EUOBCytbFJme7EiLMFWBw@mail.gmail.com>
	<CAKbEzntRe1h_5_5JqJ0hTgYdSsrHZ=ZNtZiTTJVuRAMAEmpSKA@mail.gmail.com>
	<CAJE-K+A1MG1rg1-y15GqWUravy9xsjYgemFhgJpEBEitzM3wzA@mail.gmail.com>
	<CAKbEznu_LH9azd-xF3hizsrqzJm51K-ixi32VNXe93vvR4WrAA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Aug 2025 01:03:23 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

> Hello Sidharth,
>=20
> On Fri, Aug 29, 2025 at 3:58=E2=80=AFAM Sidharth Seela <sidharthseela@gma=
il.com> wrote:
> >
> > Thank You for your response Gyeyoung,
> >
> > On Thu, Aug 28, 2025 at 7:18=E2=80=AFPM Gyeyoung Baek <gye976@gmail.com=
> wrote: =20
> > > Yes, that sounds good.
> > > As David suggested, using compatible =3D "winsen,mh-z19c",
> > > "winsen,mh-z19b" looks simple and appropriate. =20
> >
> > But How can we confirm if mh-z19c supports Range settings, Zero-calibra=
te,
> > Span-calibrate? which Winsen's documentation skipped. =20
>=20
> Ah, if the commands for z19c are not documented, then maybe it=E2=80=99s =
not
> ideal to unify them..
> But for this driver I don=E2=80=99t think we need to be that strict.
> So IMO we could just add it to the compatible list for now, with a
> comment noting the uncertainty.

I'm a bit later to the discussion (so maybe this is resolved later)
but if we have an existing compatible that we have documentation suggesting
supports more features, then we can't have a fallback compatible to that.
The other way around would have been fine though. So fallback from more
featured device to less featured devices (as long as the control / features
are a strict subset).

Jonathan

>=20
>=20
> > I still am worried just about this, all the other specs are almost too =
similar.
> > Would anyone be having a mhz-19c with them to check those 3 commands.
> > --
> > Thanks,
> > Sidharth Seela =20
>=20


