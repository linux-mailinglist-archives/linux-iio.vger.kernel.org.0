Return-Path: <linux-iio+bounces-19034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17204AA86C0
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 16:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7483B69B4
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 14:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E521A3174;
	Sun,  4 May 2025 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/Eqk/TA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6F0189916;
	Sun,  4 May 2025 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746369485; cv=none; b=O9Bm2wxOUQ1pe7G563/jnaTB4nQ1j+B8ZLLR7/ucvMjGqkZXzD5FUMPceFakPt+Cw8Ap9YxLQiKBNYwMhZ3TrZztdxr0CyJqIvEdy7AAYc+ihicp/QcXiLKg7okF01kMlFOhC9iFvciN8rNGfyH88FgGFLn9IGbxBTR9VvfRLcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746369485; c=relaxed/simple;
	bh=s9pFekeydZsrQpXymCx8fY7/v4gmMUl5e/CtbyR7S0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cH3wHYbbXFvQLNRZ/PbRLHUzNU0AHESaDx5jel7ad5ugj3IvcPt0WKNU5fwbTtlkmkDQQC0ovG16XZto+k9plp9KCeaRi9xJVZ/gn3dUusnDYSClyJlqYQ53T22crejObP9XSen4vr1RCc2qp0HFKCclNVtE757dGl1YtuvwVFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/Eqk/TA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E272C4CEE7;
	Sun,  4 May 2025 14:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746369484;
	bh=s9pFekeydZsrQpXymCx8fY7/v4gmMUl5e/CtbyR7S0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X/Eqk/TAKCiTOCnDb0L+ytR9lNprXWdl/WD1NOBt/wSJ8yYnBE7bVoRE83pwRdXqV
	 xmEyh4wFfeb3PHnCEBR5eDB/m1ciDQPYkdbvMZk8s6OI88OGhAxFfANWCbenwm+BE7
	 3sBg6GpujoQXpi7xfYETZWcJGKZlCC8T6knl+jiUD1ut+bN/BG7zjUDjJ9LnQPeZIz
	 QJd8kkXNu+Ipi4pYM+r4yCrLbTdrUPVP3Kz7eXF4ILYkWwwLNsiL718b+ErmJLC+gz
	 0RDwRVuf89q5uoEYIHP1fqmb8G/AHJUSKjBJy6AoAX4x9VZuKjzbskgkAVSi4JH//O
	 NDS6YeU5JQg6w==
Date: Sun, 4 May 2025 15:37:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Angelo Dureghello
 <adureghello@baylibre.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7606_spi: add offload scan mask check
Message-ID: <20250504153756.27cf44fb@jic23-huawei>
In-Reply-To: <CAHp75VdtoxGu1qv7i6uhuPhAeVF7OUF3d5trxqcmupC+ZeAf0A@mail.gmail.com>
References: <20250502-iio-adc-ad7606_spi-fix-offload-scan-mask-check-v2-1-e70c6d71baa3@baylibre.com>
	<CAHp75VdtoxGu1qv7i6uhuPhAeVF7OUF3d5trxqcmupC+ZeAf0A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 2 May 2025 21:21:49 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, May 2, 2025 at 6:42=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
> >
> > Validate the scan mask when SPI offloading is being used.
> >
> > Since this family of ADCs is simultaneous sampling, there isn't a way
> > to selectively disable channels when reading sample data. (Technically,
> > AD7616 has a sequencer so could have some control, but that is for =20
>=20
> so it could
tweaked to=20
so the driver could
given 'it' would otherwise refer to the chip rather than the software.

Good catch.

Applied.

>=20
> > another day).
> >
> > For "regular" IIO triggered buffer reads, this isn't a problem and the
> > IIO core will demux the data and ignore data from disabled channels.
> > However, since SPI offloading is done completely in hardware, we don't
> > have a way to do the same. So before this patch, if less than all
> > channels were enabled, the data would be misplaced in the buffer.
> >
> > By adding a check in update_scan_mode, we can fail to enable the buffer
> > instead of having bad data returned to userspace. =20
>=20
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>=20


