Return-Path: <linux-iio+bounces-21955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C2BB108EF
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235081888D8F
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 11:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC81257423;
	Thu, 24 Jul 2025 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVdQ2I7i"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B83320A5EB;
	Thu, 24 Jul 2025 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355830; cv=none; b=TyKoetzb7lqvCelnFhhVOHkl2iQHKytFe+J1beX/hujk6+vuxCRmI6ajC4Ww1l35OnGvmMLWFRtkC4S75wSyLFJV2QxO4SXMNFiZxD6+qSNVa2+tn54V/5QvvZ/s1GnLmIB/x81bPdPCZj1ESQBoiJsdnofs81q/8lHeqzil9KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355830; c=relaxed/simple;
	bh=HuoUPFLyXF9aZfFKFFofQna0gKavNBbb4GzmGGP7AL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/xwXjxg7rJZZ8B/9YE2BqbqfzwSgGRbeYP5xwqGHu8j00znRYsfhBmBUa2UMKTv3jB5KEJCmiQS3vpehENSCEZRF2X2jzYKBg7xMCDnIbQb0tRqCztHIbK91DcJyIoCv2jN9LBJkZV92RhUb6RtnezDkinrJ4k0c99oX/K818k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVdQ2I7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DE3C4CEED;
	Thu, 24 Jul 2025 11:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753355829;
	bh=HuoUPFLyXF9aZfFKFFofQna0gKavNBbb4GzmGGP7AL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TVdQ2I7ipTpgbkYoGLMGDYMLYLIML7PQibABfm/csHV34WzLAcIhcVl0wmUSzEBXv
	 8o93GOtSpbGD0IwqNKZShdUp+5j1otWHdajN0EZoyyquSlHjLJDiBILQ2bS9d9wyVU
	 MmgC2lHTRYu8rg6eHGTwi3c8XZGUkEeXEtM5MDCjdEudsizcFAvMPkBFZxLI73fJjn
	 RJ77gITxPSyRKDkcc0qNZnHwCEqnIQ9KkL0GTp7e6mBIeo6fZRl6uiN5ewhaQwFZNN
	 KW2Bo7Tvv3vyermTF4qzLL6J8oY4UZNYPFBpLA0jgv7NYQIg9cUd7nohIGrpauOs15
	 8hCB9UPntJFNA==
Date: Thu, 24 Jul 2025 12:17:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: bma180: use stack allocated buffer for
 scan
Message-ID: <20250724121703.03b29d3b@jic23-huawei>
In-Reply-To: <wwwdesuaxl4w32cf6l2bna4bixrxe4pwy4i3briysda3mjvnku@wyvpeirvf34y>
References: <20250721-iio-use-more-iio_declare_buffer_with_ts-v2-1-f8fb11b8add8@baylibre.com>
	<wwwdesuaxl4w32cf6l2bna4bixrxe4pwy4i3briysda3mjvnku@wyvpeirvf34y>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jul 2025 10:12:04 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, Jul 21, 2025 at 06:16:34PM -0500, David Lechner wrote:
> > Move the scan struct to the stack instead of being in the driver state
> > struct. The buffer is only used in a single function and does not need
> > to be DMA-safe so it does not need to exist outside of that function's
> > scope.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> > Changes in v2:
> > - Preserve the struct instead of using IIO_DECLARE_BUFFER_WITH_TS()
> > - Did not pick up Andy's review tag since the entire patch changed.
> > - Link to v1: https://lore.kernel.org/r/20250710-iio-use-more-iio_decla=
re_buffer_with_ts-v1-1-df6498f54095@baylibre.com
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
Applied to the testing branch of iio.git.

Thanks,

J

