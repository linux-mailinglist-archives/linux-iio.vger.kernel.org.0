Return-Path: <linux-iio+bounces-24314-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B2BB8C673
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 13:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD9958232B
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 11:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8442F9982;
	Sat, 20 Sep 2025 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwJmtALL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8022E0B5F;
	Sat, 20 Sep 2025 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758366252; cv=none; b=gP7xjCir+eEO4HNkJ8EyMdFJ8VkjVFoTW7Zz+CiiJgWVDt7JiS+g+Fdkc9+loCsYUUtz18DNI/9EVwA7XjW9iVmNjU7Zn6Ff58+sP9391yFiHluJoiQvJXt9xfTFdd/ODAiWTgASz6z4JotEI4duzVSCuqG2Xq30E5DtLfVnYF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758366252; c=relaxed/simple;
	bh=TZONtrJ4BRxNqktjJxW+LYMjRCcM7hr9N9x31AF/6f8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mnfw07tFp8JjiZ4DX/qui6RiaAn/hpl6d1lTsn9QXpI5RpTxJWG+YyOL+t6aNxfTUN2OBCg+V55Sb5fnxSxY3vlStFr6S1R2eO+zlYVlNBrJnm2ECv3o1zksDaqzusV29y5ZMDUQ6O4oW0vKRGg8Z6feGYzbgXYUkdnnX7AEOk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwJmtALL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF90C4CEEB;
	Sat, 20 Sep 2025 11:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758366251;
	bh=TZONtrJ4BRxNqktjJxW+LYMjRCcM7hr9N9x31AF/6f8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DwJmtALLRwuJrcG3BTOdkIxef4PPjoX9rdg4psECZqafpz6uCmsUzRSshlIpQyTeq
	 2r+U+cS9FsR7bANpJZAIm8pEi8M0d3q0tzMfJMZl8ljs39zpcUZRfsZVy7EuFclwLC
	 Ewq5NL6DTIHgndCZmGAja5nm3tOZGTNrHZ9QFoIW/PVpj9KDonJQW9XbzOBaZVyq1H
	 rSgjV2DBeZ6dKK1YnYAjOCb8kEQmaB0snoMkFdxUPSZ7DC0i2TaixBmVHb3BIppfiQ
	 +jrKd7HK6ptdbZF+qEruqas8A+dZCm2znkHPTK6B+mmbqB1cecB3o1BEdr/nLfchmN
	 JkrSPIUYnshYA==
Date: Sat, 20 Sep 2025 12:04:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich 
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= 
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: adc: ad7124: drop nr field
Message-ID: <20250920120404.6af20b23@jic23-huawei>
In-Reply-To: <f2eb2424e4b3fc787d1f20b17852e97b1a708cc8.camel@gmail.com>
References: <20250917-iio-adc-ad7124-drop-nr-field-v1-0-5ef5cdc387c6@baylibre.com>
	<f2eb2424e4b3fc787d1f20b17852e97b1a708cc8.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Sep 2025 11:25:27 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2025-09-17 at 15:39 -0500, David Lechner wrote:
> > The motivation behind this series was to remove the `nr` field in struct
> > ad7124_channel since it is duplicating the same value as struct
> > iio_chan_spec.address (and duplicated again by .scan_index).
> >=20
> > When it came to actually doing that though, I found that it was easier
> > to first clean things up by removing the ad7124_enable_channel()
> > function - which is a nice cleanup by itself. So ended up with 2 patches
> > that end with the same result without ever mentioning the duplication.
> >=20
> > ---
> > David Lechner (2):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7124: inline ad7124_enable_c=
hannel()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7124: remove unused `nr` fie=
ld
> >=20
> > =C2=A0drivers/iio/adc/ad7124.c | 19 ++++++-------------
> > =C2=A01 file changed, 6 insertions(+), 13 deletions(-)
> > ---
> > base-commit: 561285d048053fec8a3d6d1e3ddc60df11c393a0
> > change-id: 20250917-iio-adc-ad7124-drop-nr-field-518102218a61
> >=20
> > Best regards, =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Applied to iio.git/testing

Thanks

J

