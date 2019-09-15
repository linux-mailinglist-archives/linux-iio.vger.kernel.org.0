Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 339C0B2F70
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 11:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfIOJso (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 05:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfIOJso (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 05:48:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E67C22077C;
        Sun, 15 Sep 2019 09:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568540923;
        bh=XZ3E5JBgolhHb2dzMbDcf9pFGV5cWCk2O6sg7TzZLUc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yM8x+mC7Db+QFnLMbn/4ALY+ood1Uy4G+fH3bw3GLgylFmPlKDaDdr1eUUn31/cFc
         WYJaQFxVykWviaP4hQ49R8KmGRPXNYvjuxVAIV0zY06jSksLtzhZ7rUHKcag6Cq/sC
         /JlNZY+lSpafOWYPF2gdi6DGitwBAqRY4w5t3ijQ=
Date:   Sun, 15 Sep 2019 10:48:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: bh1750: Resolve compiler warning and
 make code more readable
Message-ID: <20190915104838.0776d2a4@archlinux>
In-Reply-To: <20190913202413.3034-1-kw@linux.com>
References: <20190910203814.31075-1-kw@linux.com>
        <20190913202413.3034-1-kw@linux.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Sep 2019 22:24:13 +0200
Krzysztof Wilczynski <kw@linux.com> wrote:

> Separate the declaration of struct bh1750_chip_info from definition
> of bh1750_chip_info_tbl[] in a single statement as it makes the code
> hard to read, and with the extra newline it makes it look as if the
> bh1750_chip_info_tbl[] had no explicit type.
>=20
> This change also resolves the following compiler warning about the
> unusual position of the static keyword that can be seen when building
> with warnings enabled (W=3D1):
>=20
> drivers/iio/light/bh1750.c:64:1: warning:
>   =E2=80=98static=E2=80=99 is not at beginning of declaration [-Wold-styl=
e-declaration]
>=20
> Related to commit 3a11fbb037a1 ("iio: light: add support for ROHM
> BH1710/BH1715/BH1721/BH1750/BH1751 ambient light sensors").
>=20
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.  Added Uwe's Acked-by as well.

Sorry for the confusing advice I gave earlier, I managed to confuse
myself on what the original code said.

Jonathan

> ---
> Changes in v3:
>   Updated wording of the commit message as per the review feedback.
>=20
> Changes in v2:
>   Made definition of bh1750_chip_info_tbl separate from declaration
>   as per the review feedback.  This also makes the code more readable.
>   Updated wording of the subject and the commit message.
>=20
>  drivers/iio/light/bh1750.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> index 28347df78cff..adb5ab9e3439 100644
> --- a/drivers/iio/light/bh1750.c
> +++ b/drivers/iio/light/bh1750.c
> @@ -59,9 +59,9 @@ struct bh1750_chip_info {
> =20
>  	u16 int_time_low_mask;
>  	u16 int_time_high_mask;
> -}
> +};
> =20
> -static const bh1750_chip_info_tbl[] =3D {
> +static const struct bh1750_chip_info bh1750_chip_info_tbl[] =3D {
>  	[BH1710] =3D { 140, 1022, 300, 400,  250000000, 2, 0x001F, 0x03E0 },
>  	[BH1721] =3D { 140, 1020, 300, 400,  250000000, 2, 0x0010, 0x03E0 },
>  	[BH1750] =3D { 31,  254,  69,  1740, 57500000,  1, 0x001F, 0x00E0 },

