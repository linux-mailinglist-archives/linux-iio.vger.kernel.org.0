Return-Path: <linux-iio+bounces-26842-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C095CAABE9
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 19:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16D11300AC71
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 18:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1897E2C08B1;
	Sat,  6 Dec 2025 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoH+d4HF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02872C0274;
	Sat,  6 Dec 2025 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765044457; cv=none; b=fX30f2bUPk3rk74kyg2aGUCuJ8Kx3oK8DDKPRqj+cCS00EIgJEOBp9W76Pf8PU/wTCaJ1OitQfjtVSFeXvWqOByPn326SApY+gtv7aDJthOAW1LmSNWVZoIqkt4HRl44POGBZ1oLa53IWkfP4d3Hys1wu6GAWW53ab5Vairnlxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765044457; c=relaxed/simple;
	bh=YGOo1P0K7gaOztsvsJKvQ6qCqk5qHNr8pLVMsdmkSJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idmnqoiLbsHquWeSoq41SAZ3z2yCu1X7vinNM/KSxqpBpEJ7TMPGqjVULM6r8E5QCXeC+YNKq/HsuO0Y5nIDiNlwLmdFv0PfBAY+lIXpXiFTFKeUA7q5jO4o00mAVpsHi9Lq74qrM36G30nF1KSpTaP8XkcJ5u0uBjOW8F81j+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoH+d4HF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433A6C4CEF5;
	Sat,  6 Dec 2025 18:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765044457;
	bh=YGOo1P0K7gaOztsvsJKvQ6qCqk5qHNr8pLVMsdmkSJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YoH+d4HF/1iLj9eOnfLH4YKQq+iCBblzrusMquIWiu0Ow5c8E21b9hUmsbyEhOwsx
	 M3EHrzxlUI2OvN56Te5N9/fSDUuQN38ykAFWtOn/S4LXSXO2+HXpdZd05jj0wnNS9P
	 /2A85FfwhWtj6Dxl5+rzZ8M+0USs8Taz2J7Ou4TXhnJz9zslyUkfOj66DB3EDeBazg
	 q19BhWfoTfbX6QNy/iyLPUKdjaOAtRv47dkPLU8RgbhHjjmJ2m7HaIfmvKdHBhuYB9
	 NrnMfjAU/fU7O8uUvgngUiaePxc5/8JLYjY2Gl5E3iAhEGBn9czwwz0BzoQrgA5c85
	 nDmdsMYcWnddw==
Date: Sat, 6 Dec 2025 18:07:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Kurt Borja
 <kuurtb@gmail.com>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Benson Leung <bleung@chromium.org>, Antoniu
 Miclaus <antoniu.miclaus@analog.com>, Gwendal Grignou
 <gwendal@chromium.org>, Shrikant Raskar <raskar.shree97@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH RFC 1/6] iio: core: Match iio_device_claim_*() return
 semantics
Message-ID: <20251206180725.4f8f2840@jic23-huawei>
In-Reply-To: <CAHp75VerpV6u8DgQH53a=2eAPQGk4KgFobXTueh90EBnFL=BTg@mail.gmail.com>
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
	<20251203-lock-impr-v1-1-b4a1fd639423@gmail.com>
	<9562673ef83dd73b6092b5a7d2042b380a55700c.camel@gmail.com>
	<CAHp75VerpV6u8DgQH53a=2eAPQGk4KgFobXTueh90EBnFL=BTg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Dec 2025 17:05:29 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Dec 4, 2025 at 4:22=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
> > On Wed, 2025-12-03 at 14:18 -0500, Kurt Borja wrote: =20
> > > In order to improve API consistency with conditional locks, use
> > > true/false return semantics in iio_device_claim_buffer_mode().
> > >
> > > This also matches iio_device_claim_direct() return semantics. =20
>=20
> > Even if the rest gets a NACK, I think at least this patch makes sense. =
In fact I
> > would even extend it so that we have the same inline API with proper an=
notations:
> >
> > https://elixir.bootlin.com/linux/v6.18/source/include/linux/iio/iio.h#L=
679
> >
> > So it really has the same semantics as iio_device_claim_direct() =20
>=20
> I remember I looked into this when Jonathan provided an API, but I
> have no memory of why we have the -EBUSY which is not used in the
> callers.

Random historical choice.   I think at the time I vaguely thought
we might have other return values, but they never surfaces so these
might as well have always return booleans.

Jonathan



