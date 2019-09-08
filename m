Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69DA8ACC36
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 12:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfIHKtt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 06:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbfIHKtt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 06:49:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E23F20863;
        Sun,  8 Sep 2019 10:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567939788;
        bh=+w/QuT5L4Ow9ftifoOWm4Sae4CkvZuplB/gI2gFR8bs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jAiftC9iSBodWKXEs9ctWPujlcYnoAYiAp3gheIoyh7VpYOe12FONlSEvEVvW81hv
         ZXEu7Mvee9IaF/wKqgMGm6ylh9tWsawvYW7qDjj3xCpYj0oTYY+OXd3I2wp927uq4b
         ptR2fk9NDTo5mWAkZOO2tBio2vxg9lzOTVJinaz0=
Date:   Sun, 8 Sep 2019 11:49:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: bh1750: Move static keyword to the front of
 declaration
Message-ID: <20190908114944.18bb78e3@archlinux>
In-Reply-To: <20190902113132.26658-1-kw@linux.com>
References: <20190902113132.26658-1-kw@linux.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  2 Sep 2019 13:31:32 +0200
Krzysztof Wilczynski <kw@linux.com> wrote:

> Move the static keyword to the front of declaration of
> bh1750_chip_info_tbl, and resolve the following compiler
> warning that can be seen when building with warnings
> enabled (W=3D1):
>=20
> drivers/iio/light/bh1750.c:64:1: warning:
>   =E2=80=98static=E2=80=99 is not at beginning of declaration [-Wold-styl=
e-declaration]
>=20
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>

This one has me confused.  The warning seems to be false as static
is at the beginning of the declaration....

Sure we "could" combine the declaration with the definition as you have
done here, but that has nothing much to do with the warning.

What am I missing?

Jonathan

> ---
> Related: https://lore.kernel.org/r/20190827233017.GK9987@google.com
>=20
>  drivers/iio/light/bh1750.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> index 28347df78cff..460c0013f1a9 100644
> --- a/drivers/iio/light/bh1750.c
> +++ b/drivers/iio/light/bh1750.c
> @@ -42,7 +42,7 @@ struct bh1750_data {
>  	u16 mtreg;
>  };
> =20
> -struct bh1750_chip_info {
> +static const struct bh1750_chip_info {
>  	u16 mtreg_min;
>  	u16 mtreg_max;
>  	u16 mtreg_default;
> @@ -59,9 +59,7 @@ struct bh1750_chip_info {
> =20
>  	u16 int_time_low_mask;
>  	u16 int_time_high_mask;
> -}
> -
> -static const bh1750_chip_info_tbl[] =3D {
Looks like the beginning fo the declaration to me!

Jonathan

> +} bh1750_chip_info_tbl[] =3D {
>  	[BH1710] =3D { 140, 1022, 300, 400,  250000000, 2, 0x001F, 0x03E0 },
>  	[BH1721] =3D { 140, 1020, 300, 400,  250000000, 2, 0x0010, 0x03E0 },
>  	[BH1750] =3D { 31,  254,  69,  1740, 57500000,  1, 0x001F, 0x00E0 },

