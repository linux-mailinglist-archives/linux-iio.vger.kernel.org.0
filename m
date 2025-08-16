Return-Path: <linux-iio+bounces-22823-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AC4B28E2B
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 15:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17DAEB01F46
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 13:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430D02E5B38;
	Sat, 16 Aug 2025 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQBXWQZ9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC19323A562;
	Sat, 16 Aug 2025 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755351294; cv=none; b=HwIf5OUgLmaQ1/DBlorC8MpupEDyJkZNWDIUNnHO8TGRUGbxZhDDo+Ne8JD4iOXjcceJTx9GBwFiVXCrqlZLt9FJk1It2lo8ivLsI/zL3LygzkaIYtbzvVZ/DceCsj1Bf/R7TOyw+nd0U5S+7ECTa9m6l9jEWlIM7smht6v/Swg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755351294; c=relaxed/simple;
	bh=tJC2fP8R8CE59ewJaA1jMoW76rPBtMtDYVgvZDtO3q4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUkVn7Hk7CYgE+XVr1PmdIY1sf1cr3tM48w1fIIzPKtVwPX5lNdIcaOUoB09mDtXeARycx6h6eG7P+TyQfw+l3uh69AiobLqMbkdzx33mKRzrZmL9EUVHm8aw5q641Rti2G1rPlyQhgo4hQwu9pkysjOUMrV9sOrb0L6lgAzuEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQBXWQZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37872C4CEEF;
	Sat, 16 Aug 2025 13:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755351293;
	bh=tJC2fP8R8CE59ewJaA1jMoW76rPBtMtDYVgvZDtO3q4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TQBXWQZ9TY9fe5hbnCoxP1TwOCK1clE/ivn8njEPlRbATyxEbDU9BrnYu1PAmzjsI
	 M0u5x1WGLe+LYK+fqxjeDxWExPJwjephPyW9g7l8f6cE1zW5uMWkITvwLD7lee6fXE
	 kvZ6HgwPBztb6kiKU1fRz1LjnTFhkF156H8CfEiy8dsEk3q5Z7BOEYzlbOOetnjXk0
	 1UUIJYxuX9nyMc09rm8sNnZ2wOYZ28Jnwt/jyG19H7BmJBMaftjlGXBlAEFWugFbch
	 mHT9Ecgg1Mbt5sCJZffc21W/LIEWFGqNMvupCJwD9pZRVU/WDpjZlXi10KH1TLUua1
	 LbRqM74LSEHUg==
Date: Sat, 16 Aug 2025 14:34:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Akshay Bansod <akbansd@gmail.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel-mentees@lists.linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: st_lsm6dsx: Replace scnprintf with sysfs_emit
Message-ID: <20250816143445.3dd52031@jic23-huawei>
In-Reply-To: <CAHp75Vf7r53wQtGWes9WH1UubEjhAju+tN0OORTrkNxgTQPsWw@mail.gmail.com>
References: <20250811165641.1214347-1-akbansd@gmail.com>
	<CAHp75Vf7r53wQtGWes9WH1UubEjhAju+tN0OORTrkNxgTQPsWw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Aug 2025 21:17:18 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Aug 11, 2025 at 6:57=E2=80=AFPM Akshay Bansod <akbansd@gmail.com>=
 wrote:
> >
> > Update the sysfs interface for sampling frequency and scale attributes.
> > Replace `scnprintf()` with `sysfs_emit_at()` which is PAGE_SIZE-aware
> > and recommended for use in sysfs. =20
>=20
> LGTM,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>=20

Tweaked patch title to include () for the two functions mentioned.
I think that just makes things a tiny bit clearer.

Applied.

