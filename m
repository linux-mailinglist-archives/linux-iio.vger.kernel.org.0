Return-Path: <linux-iio+bounces-24061-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FDAB5618E
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 16:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE441C227F9
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 14:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC57E2EFDAC;
	Sat, 13 Sep 2025 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKhgqg2R"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D2E2ED14B;
	Sat, 13 Sep 2025 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757773440; cv=none; b=EdQOnG7O/Oi1yI6claZdUuLy8QdIJ+lwRtnmpLNTFShfcfJ6sRozKkTnX12wRH/UNZhi0JcjPlobCJy+fIrd42tP1MKZ9TRE+oQKUNmg6RuXj4B5NwE/KLb5M415BX46VnQhjjgHKWbSbnoWehy5BHpRZH3WZJqD7v78D/2eASU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757773440; c=relaxed/simple;
	bh=mC9kzsBFw0R9A397SnSTLwvWIByMWDbpIaFbXIknlBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhwSOojGikeV8UkmmGBbZakv1qUUgsSUg8vKFi97M7isdd7nzrfVnvfebnMJYHcOiD6kO+3XSQjlBVCK9uSDKO490RZD7/Yjapwge1jkP0ZuJG73iGMyT/3a/s1mCfFiuRqKWCNt7rKZxQmsadHmtd4ISx4itFT6lUXTXnwxPs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKhgqg2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3934C4CEEB;
	Sat, 13 Sep 2025 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757773440;
	bh=mC9kzsBFw0R9A397SnSTLwvWIByMWDbpIaFbXIknlBk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bKhgqg2RAR4Q9NPqxkafflvG8QH3gnUIR9d3/tFIGMyVCG0dA/tn1zW3suEYhj94l
	 ayEhbS80egqioWjERJ4HKwI4F148dzHgaGei79vEOQPWE42CBEXiStaoKmHNfI1sGy
	 V9m17dt8kiZq3ooJq0VlTsPI1hQNl8xQHYkprNErIZxks+t8DRdwQIG2k2NvXW1Eq3
	 K6zfLo+Bjp+79aDy954/JU1jvX0ANXJ/za1YVRSf152RM8DIQ2GskBPwEY+gkgLSFW
	 mAL50jyxAmqVNRky84mt4QSH4zzUNpQ8jyrgtzatGX/C6q8miZgU1Ohj4wrrRh9aD9
	 uwwQ2WWhm7FxA==
Date: Sat, 13 Sep 2025 15:23:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Salah Triki <salah.triki@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, Markus.Elfring@web.de
Subject: Re: [PATCH v4 3/3] iio: pressure: bmp280: Use
 gpiod_set_value_cansleep()
Message-ID: <20250913152351.4455efc2@jic23-huawei>
In-Reply-To: <aKXg6h0nW-GMcy1m@smile.fi.intel.com>
References: <20250818092740.545379-1-salah.triki@gmail.com>
	<20250818092740.545379-4-salah.triki@gmail.com>
	<aKXg6h0nW-GMcy1m@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Aug 2025 17:51:22 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Aug 18, 2025 at 10:27:32AM +0100, Salah Triki wrote:
> > Switch to `gpiod_set_value_cansleep()`, which is safe to use in
> > sleepable contexts like the driver probe function. =20
>=20
> The commit message is unclear on why? aspect. You need to elaborate that =
some
> GPIO chips may be located behind slow (and hence sleepable) busses, such =
as
> I=C2=B2C).
>=20
> Code wise I agree with the change.
> With amended commit message
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20

I added a brief not on slow buses and applied.

Thanks,

Jonathan

