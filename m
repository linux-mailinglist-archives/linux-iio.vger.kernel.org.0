Return-Path: <linux-iio+bounces-18527-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F660A97449
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 20:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1067189997D
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 18:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86222980BE;
	Tue, 22 Apr 2025 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qg+meklA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFA928F951;
	Tue, 22 Apr 2025 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745345493; cv=none; b=hJQhRuCsZKIXUAoW9qlR3S7t11hQvtFAj9PnSl/tyuXGbdcnXiwUetyM1uzrzkCCVkdnIwzrRGAn37noZwVuRBlaadlc1R7O8jO31veu9EM33eb9hgmL0avLjRj1sK6ZdWCmbPgR/3dDW7BTuCZh3VmHwcULGqvIS+jUzdQ5FF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745345493; c=relaxed/simple;
	bh=SvIx++S80MJoaUoA5eJ5m1Ia0u1LVuwEpWYTiDTazoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5fGS9GcLTk07uMc3RsCH/rVMS9kiMiV3un+G8bE15E3+z88uPpL0bLWH0jvYvSwWU+fYay5M4neEPnTZo6rtslms7OWnT8tXWN1laJ3CKOIxQ5Kr6K/2zDyHvhgbHP0VDv0QTJ8bDe0d3cgrHHUpLWlPjGmZANnlkyHGcD2dLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qg+meklA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AC0C4CEE9;
	Tue, 22 Apr 2025 18:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745345493;
	bh=SvIx++S80MJoaUoA5eJ5m1Ia0u1LVuwEpWYTiDTazoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qg+meklA55nJle1d4hOos2AcPWg5lPvSi7s7fzxNRS4iy0iHG9UMDijMRHc7eq9Z2
	 4uFUaZfbTdC8UuKFJC0Hx2uPRGdCwvZ59+U9Bzgi+1Dzo0dUkrHsNDnxFRT5PJjC9Z
	 kQv7XW288krqJBCx0+YeB710x4vj3d8jgEaRaQSm9kkPim1ujpQlBq3mwuzQjWWU0D
	 7LizaJwIZfiwpw6wL76S43FyRsly6ZnJ6wbjEc7XINpQdAEMu5Vva/P/P2J8uJJW6a
	 VYpHCfeFmr3ynaVC4Zengu5OsByeMdd7FmmQhheTikCy2c7SPsPn3G6wyyXEeoTQq0
	 idM6hE2hZGhLg==
Date: Tue, 22 Apr 2025 19:11:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: ak8974: Add __nonstring annotations
 for unterminated strings
Message-ID: <20250422191126.53eb61ed@jic23-huawei>
In-Reply-To: <202503151455.B8E9F6F1@keescook>
References: <20250310222346.work.810-kees@kernel.org>
	<CACRpkdbUk8bVWLPwVRq0qzaKRC80=bV1Wd01h+5xfH1O7-BVaQ@mail.gmail.com>
	<20250315183125.40f9c566@jic23-huawei>
	<202503151455.B8E9F6F1@keescook>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 15 Mar 2025 14:56:02 -0700
Kees Cook <kees@kernel.org> wrote:

> On Sat, Mar 15, 2025 at 06:31:25PM +0000, Jonathan Cameron wrote:
> > On Fri, 14 Mar 2025 11:31:09 +0100
> > Linus Walleij <linus.walleij@linaro.org> wrote:
> >  =20
> > > On Mon, Mar 10, 2025 at 11:23=E2=80=AFPM Kees Cook <kees@kernel.org> =
wrote:
> > >  =20
> > > > When a character array without a terminating NUL character has a st=
atic
> > > > initializer, GCC 15's -Wunterminated-string-initialization will only
> > > > warn if the array lacks the "nonstring" attribute[1]. Mark the arra=
ys
> > > > with __nonstring to and correctly identify the char array as "not a=
 C
> > > > string" and thereby eliminate the warning.
> > > >
> > > > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D117178 [1]
> > > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > > Cc: Jonathan Cameron <jic23@kernel.org>
> > > > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > > > Cc: linux-iio@vger.kernel.org
> > > > Signed-off-by: Kees Cook <kees@kernel.org>   =20
> > >=20
> > > Fair enough,
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > >  =20
> > Kees,
> >=20
> > I've currently queued this for next cycle as it doesn't feel like a fix
> > as such and I've already sent my pull request for the merge window.
> >=20
> > Is it worth rushing it in, or is a fully cycle delay an issue? (6.16)
> >=20
> > If slow is fine, applied to the testing branch of iio.git which gets
> > 0-day bot exposure. =20
>=20
> No rush needed at all. This is just for cleaning up warnings for the
> coming releases of GCC 15 in couple months. Thanks for picking it up!
>=20

Dropped because it clashes with:

  05e8d261a34e ("gcc-15: add '__nonstring' markers to byte arrays")

