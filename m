Return-Path: <linux-iio+bounces-16875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8B5A6319A
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 19:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 000917A9656
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 18:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261AA2040B2;
	Sat, 15 Mar 2025 18:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLyVyfmB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38241CD1F;
	Sat, 15 Mar 2025 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742063493; cv=none; b=UwzLT6vplCgtOEOEu8yVfs1Pn+M1oA4HjoXQ5nY4vGAhtvGyoLdjRln45xSWlwg+bRmij1PPvVHkEwa1q2ubfkrS/hrd/QqyLua9N11PFi/46hfGqw+LLZCSkyUajqY7JZiUPXKT7IzNw78S1v8XlwR2nDLJDQprzwKmnNUgQ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742063493; c=relaxed/simple;
	bh=1eCl0H/Io7JBG9hn06zddztdlZ4zO0KVqLIi4Be0JpI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVE7vMXq6fsVBi9uoTRHMkWe/4F+oc0SxD/g3D7QNP1/2d+w4ITYOkCz+yrLEjbr8d3ahHuwjIiI4bOVhxDOOGFH5zHBZaOAsx+KnkRTjq/lRcR7WCcLIVB8HMQQ/7QBUtkM8xYrf+XPOUhOP6PzKNjqQQ0eEbok7JHYWrCo0yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLyVyfmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEC0C4CEE5;
	Sat, 15 Mar 2025 18:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742063493;
	bh=1eCl0H/Io7JBG9hn06zddztdlZ4zO0KVqLIi4Be0JpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MLyVyfmBepCfcP2wJK8aYnwApctOP/XRbPz5ja0sHQQz/ttnl7VxK03OLhq8z7WiI
	 eef1lcQek6otutCWRCj2SHEuWWUTvy00uaG5UoCpLAM+5G/fPeTuJ/NDyDbVVeO7C8
	 fWF+tCiMxaUzb1GLZd3Z5ZHpxMMtRR2XC8KRtLZjILA8nDMGzn1HxAT3+TgM3RT3eA
	 3NNklnaALiDnNOSupS3VOOl+iZM6+8MeJ2bOQRoFGeOLkfOnJT9MEEzskNbx45fPdd
	 TZmcjMXJJidkg3p2TAoAhY5JE2hvFUpl8RxP+mmZ4ynbLhpYI1wcsFKfgEfe18N6/H
	 UqMwpvlGkKGoQ==
Date: Sat, 15 Mar 2025 18:31:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kees Cook <kees@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: ak8974: Add __nonstring annotations
 for unterminated strings
Message-ID: <20250315183125.40f9c566@jic23-huawei>
In-Reply-To: <CACRpkdbUk8bVWLPwVRq0qzaKRC80=bV1Wd01h+5xfH1O7-BVaQ@mail.gmail.com>
References: <20250310222346.work.810-kees@kernel.org>
	<CACRpkdbUk8bVWLPwVRq0qzaKRC80=bV1Wd01h+5xfH1O7-BVaQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Mar 2025 11:31:09 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Mon, Mar 10, 2025 at 11:23=E2=80=AFPM Kees Cook <kees@kernel.org> wrot=
e:
>=20
> > When a character array without a terminating NUL character has a static
> > initializer, GCC 15's -Wunterminated-string-initialization will only
> > warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> > with __nonstring to and correctly identify the char array as "not a C
> > string" and thereby eliminate the warning.
> >
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D117178 [1]
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: linux-iio@vger.kernel.org
> > Signed-off-by: Kees Cook <kees@kernel.org> =20
>=20
> Fair enough,
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
Kees,

I've currently queued this for next cycle as it doesn't feel like a fix
as such and I've already sent my pull request for the merge window.

Is it worth rushing it in, or is a fully cycle delay an issue? (6.16)

If slow is fine, applied to the testing branch of iio.git which gets
0-day bot exposure.

Jonathan

> Yours,
> Linus Walleij


