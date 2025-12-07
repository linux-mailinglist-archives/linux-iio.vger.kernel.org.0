Return-Path: <linux-iio+bounces-26871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DA3CAB504
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 13:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CACC3047676
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 12:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7682DA756;
	Sun,  7 Dec 2025 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTMPjEvG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46509230BDB;
	Sun,  7 Dec 2025 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765112217; cv=none; b=o6aaCfX2+9Q55Y4H/aJAkl5a4M6ZPQgQutkrwQswH7XXE2OGTL7Mq/71d6gm9SdDYbwN+UJMxsi/KKLSX9XRLhmUcQ0DUKKBKwfwmzSH0bR+HcBg3kw6NlnSZYMJwWIz7hYOuTMtrjhECMKXGvaqOLNRp9VrJFNDnh98Oj8mihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765112217; c=relaxed/simple;
	bh=f2xWALuw3+WeC+Z5pH+02Ds/LER2mNynFgFeupYsLo4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqAW08w2mGHnkodKfIYXIT1TQoyx2L0HO7nWnCkFSvtbZPxDgiJSdoBnvmCZXI7E+9IsjfbeVlgde4l5zY/380zmkAD/6FFOQYjzjLBLfK11GRMekfwrrMLwIR8Dj471At2Sc3qU2KXAVrn/drHYYvYrc5q1J5meOtng4aVpGPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTMPjEvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F12C4CEFB;
	Sun,  7 Dec 2025 12:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765112216;
	bh=f2xWALuw3+WeC+Z5pH+02Ds/LER2mNynFgFeupYsLo4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MTMPjEvGqY4QIbG9txT9/XU3GChn84i/g8ZXa8nNxb6dl/wS33kE1HqCp9/p+hkNo
	 Z3mNTEn6ZxCV3Gwm/wggJSLMD4KM2I9W/+/gQtLILQlD9V58JNNfg74QbmytGNtBb8
	 Ro0WYrwevHnYnnu33CiAGS4K+Mt55kNv3oGU2u4JuPbhmbbrM9kDcLsdv5/JMrLrUD
	 3mHFaBI1lkMmhYfumUEr9M6E4Ki9zMLjoHfEj+jo3RYn04emXFFag7M8u7HPJ4p1Tj
	 y2x+to52uB7WZekcr1wPfnRvA4Ari/p10k9Kq5hO8gJgsPMFfZFV/n2USI0H2SjaZI
	 BMpZzxqC2F+pw==
Date: Sun, 7 Dec 2025 12:56:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Haotian Zhang <vulab@iscas.ac.cn>, lars@metafoo.de,
 michael.hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7606: Fix incorrect type for error return
 variable
Message-ID: <20251207125647.7306b84f@jic23-huawei>
In-Reply-To: <CAHp75Vf=GOsvXsCmbKzpiui2=jbetTkm9Yru9ZCp9T0+txMF-g@mail.gmail.com>
References: <20251203050844.330-1-vulab@iscas.ac.cn>
	<CAHp75Vf=GOsvXsCmbKzpiui2=jbetTkm9Yru9ZCp9T0+txMF-g@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Dec 2025 11:16:26 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Dec 3, 2025 at 7:09=E2=80=AFAM Haotian Zhang <vulab@iscas.ac.cn> =
wrote:
> >
> > The variable ret is declared as unsigned int but is used to store return
> > values from functions returning int, which may be negative error codes.
> >
> > Change ret from unsigned int to int. =20
>=20
> > Fixes: 849cebf8dc67 ("iio: adc: ad7606: Add iio-backend support") =20
>=20
> Since it returns an int, it is just double conversion (however in the
> standard promotion from unsigned to signed is UB if I remember
> correctly). That said, I am not sure this justifies the Fixes tag, but
> I'm not against it.
>=20
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>=20
I think it is worth getting this backported as it's definitely wrong
if not an actual bug so I'll keep the fixes tag and take it via my fixes
branch.

Thanks,

Jonathan


