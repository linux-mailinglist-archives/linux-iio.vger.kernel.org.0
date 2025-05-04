Return-Path: <linux-iio+bounces-19057-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7479EAA8858
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 19:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29971757BB
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 17:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9181E1991CB;
	Sun,  4 May 2025 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abDBGjyN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463831E5B91;
	Sun,  4 May 2025 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746378702; cv=none; b=bcz3p5AhhTWNDur1MhUNecopfdkCFYLrQJX72A/MDD+sB76i+fBIlXdnrvwxb2u2cC/Cu2ya9Ox4BEzvSfU369TR6ebMHmWNgdsvlZO5IMCldjmTHnnZR32IlJvMndIQOcSRwdJqcTP89EstYEKBnQT/mawssb6XXpttAJGtICg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746378702; c=relaxed/simple;
	bh=ibjUWSAUfLwtzvf59Yp/2FVYayCZFaq7BJh4eClGZfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORshypNi1JiYHKNt67mc+KOke9mlFlDXRjGI4KMGjuHBnzAZ+HER9D96P64fZedG0nY1DdssJos/AOhuZQFJJ9pIQwrinc/TCguPBWuh+TCBb/OWCyjON275ytmg3LMynZisqe5chOMEtjaUe2lNuVOH8wJq1f04uY8taSUd7tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abDBGjyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E78C4CEE7;
	Sun,  4 May 2025 17:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746378700;
	bh=ibjUWSAUfLwtzvf59Yp/2FVYayCZFaq7BJh4eClGZfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=abDBGjyN5T4tpU1olHuoyuwtx+zkEO0UOo+9Qy6xxmadqY2GHPvW8dmkUpqefkFik
	 2Gg8uo2UFBpkE2oEfOryW1i/E/TqYhhnglLnQomJl7FwYoEZ4stQ/WI2szHOR8qf5Q
	 pS/XG/PpZwKRMBWtXJAWxFLBEkyScmvJs7S6JALH9kBm3dj5+W+3NB0aQW67FgAVmC
	 NZW4B6fX65Ot6V3uh55XfojDrJF93AhjugU8Rd+8HD9y4dbiYUpCQMtBdi9hJslBMG
	 rtjOgEKzzRQiIZikqrYkHolfuqCjrO2f3wFVNYoEOu2taDEZBBmJkgB8bVKN+xDK9E
	 C3OWOj+3aSWhg==
Date: Sun, 4 May 2025 18:11:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v7 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Message-ID: <20250504181131.3fc515ca@jic23-huawei>
In-Reply-To: <CAHp75VeY_vjS=Ca4L34UMjVyDvG6iLdrW_c-owKWBLK-3Lg0BA@mail.gmail.com>
References: <20250429-togreg-v7-0-0af9c543b545@analog.com>
	<20250429-togreg-v7-3-0af9c543b545@analog.com>
	<CAHp75VeY_vjS=Ca4L34UMjVyDvG6iLdrW_c-owKWBLK-3Lg0BA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Apr 2025 01:18:58 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Apr 29, 2025 at 5:20=E2=80=AFAM Kim Seer Paller
> <kimseer.paller@analog.com> wrote:
> >
> > The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are
> > low-power, 16-bit, buffered voltage output DACs with software-
> > programmable gain controls, providing full-scale output spans of 2.5V or
> > 5V for reference voltages of 2.5V. These devices operate from a single
> > 2.7V to 5.5V supply and are guaranteed monotonic by design. The "R"
> > variants include a 2.5V, 5ppm/=C2=B0C internal reference, which is disa=
bled
> > by default.
> >
> > Support for monitoring internal die temperature, output voltages, and
> > current of a selected channel via the MUXOUT pin using an external ADC
> > is currently not implemented. =20
>=20
> LGTM,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>=20

Series applied and pushed out as testing for 0-day to take a first
poke at it.

Thanks,

Jonathan

