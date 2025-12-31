Return-Path: <linux-iio+bounces-27446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 453F2CEC6DE
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 19:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3577300E00A
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 18:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0632F363F;
	Wed, 31 Dec 2025 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0J2XXuq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A812F362A;
	Wed, 31 Dec 2025 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767204169; cv=none; b=mhYonThjI6KzqwYUFlRbeAgUi42OpSOBq5q1OrFgcE3Fl0u5kQXl1sXyFiremdAu55wqvxL5hnP/T115RfJ7G74/NXLOaM9JOmgcXGPJBFmBzAe4nGYtEgkWaSDFo0EaOtR6ucDavwP/J1flJc+8CGkK0O6hwylR43TEoPgPC3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767204169; c=relaxed/simple;
	bh=ewgo0adcXH5/I9G/WqgEK2faT1M8lpN+HzKypGXF5PU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N76Zdo3iYVzQegXNSM/ZriVHYu786sjFd9m9J7ZId4g6RFD0HOi8faOUWygyRKrYZIbkrAX70gkQAVuuz1lxLnb9486Fg5cNzzxkIIAPnPo2O59I1WA0Z9r2JBHl2ijUYIicwjz64ruZ12TKxeDwhsUQr34REiF6oqzrH/YtUfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0J2XXuq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A917BC113D0;
	Wed, 31 Dec 2025 18:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767204168;
	bh=ewgo0adcXH5/I9G/WqgEK2faT1M8lpN+HzKypGXF5PU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J0J2XXuqemsVfIV1idpFoQEOgEQOLe0ExeQf03tcJyko3mK2UKfEZ3Y/owXeoZoMq
	 Vv3WmSBXjuJbejnNPSzpskN3XCdO+B70ABhm7J1pm8dvg9XvJ03V4oLr/UeyqVKsa8
	 quEX/hnWh5vSv4xtjnGL6B7HL5Qj732kHEotK5hUINym3E5rUGG7sgbp57MvPxOKhb
	 lTH5TP3MeIkfUKpK3ghA2L1XuWm8m9s6o6D+9zQ0La+2wh5njVAS5CPJ+GZidru4tJ
	 QgLEq6Kfhqgq2jT0yN2hJRtzddlry6DWQylTgJ4g+aoL98+fTaHRngqCRutgLUrmb8
	 tydxBtbw6Hhyg==
Date: Wed, 31 Dec 2025 18:02:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Tomas Borquez <tomasborquez13@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 1/6] staging: iio: ad9832: cleanup dev_err_probe()
Message-ID: <20251231180238.7d564a7f@jic23-huawei>
In-Reply-To: <CAHp75VfBwsKMdksib_UDMGraoPREBHF-ttcxxBpKvpyV2bEQjw@mail.gmail.com>
References: <20251230203459.28935-1-tomasborquez13@gmail.com>
	<20251230203459.28935-2-tomasborquez13@gmail.com>
	<CAHp75VfBwsKMdksib_UDMGraoPREBHF-ttcxxBpKvpyV2bEQjw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Dec 2025 00:47:43 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Dec 30, 2025 at 10:35=E2=80=AFPM Tomas Borquez <tomasborquez13@gm=
ail.com> wrote:
> >
> > Cleanup dev_err_probe() by keeping messages consistent and adding
> > error message for clock acquisition failure. =20
>=20
> AFAICS this does two things, the second one is reuse of the temporary
> variable for struct device.
>=20
Agreed. Ideal patch break up would be to not just mention
them but do the struct device *dev first, then the dev_err_probe()
change.




