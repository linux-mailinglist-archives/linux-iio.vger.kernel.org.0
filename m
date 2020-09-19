Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F58270E1C
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 15:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgISNVx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 09:21:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgISNVx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 09:21:53 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAAEC20888;
        Sat, 19 Sep 2020 13:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600521712;
        bh=nwuMnE7pvASnCeNQhRDBPyBd9YDkqAU1VKdLN8jpsBU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mbRinwU9ogl5tyck4lRj72YJBtcEgV6pSC2HlCKfYeudD+07DhJg/JfMZiGflBAJ0
         DLgAe8vaCjOBBZwKf3i3tNKQkwHnzgG7r0ZKOXXPPkEgO+g7JGixaVUSycNH3pkQW9
         ex4ANv9GuXzqnDwnqoAVpCxfAvCqVkGThiNrJ0QQ=
Date:   Sat, 19 Sep 2020 14:21:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/4] Refactor ADIS Burst Mode
Message-ID: <20200919142148.5ed5ff9d@archlinux>
In-Reply-To: <20200917155223.218500-1-nuno.sa@analog.com>
References: <20200917155223.218500-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 17 Sep 2020 17:52:19 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> This series refactors the ADIS burst mode. The 2 main ideas of the
> refactor are:
>=20
> 1. As discussed in previous patches, there's no point in
> enabling/disabling burst mode at runtime. Hence, we can drop the `en`
> variable.
> 2. Replace the `extra_len` by `burst_len` where users have now to
> explicitly define the size of the burst buffer. The point is to remove
> the following line from the lib:
>=20
> ```
> /* All but the timestamp channel */
> burst_length =3D (indio_dev->num_channels - 1) * sizeof(u16);
> ```
>=20
> The library should not assume that a timestamp channel is defined.
> Moreover, most parts also include some diagnostic data, crc, etc.. in
> the burst buffer that needed to be included in an `extra_len` variable
> which is not that nice. On top of this, some devices already start to
> have some 32bit size channels ...
>=20
> While doing this (and mainly when looking at the adis16400) drivers it
> felt that the burst variables belong to the per chip `adis_data`
> structure. As seen in the adis16400 driver, some drivers might support
> multiple devices with different burst sizes.
>=20
> For now, it does not feel necessary to wrap these variables in a
> `adis_burst` structure but I don't see any problem in doing so if
> required...

Looks good to me as it stands.

Series applied to the togreg branch of iio.git.

Thanks,

Jonathan

>=20
> Nuno S=C3=A1 (4):
>   iio: adis: Move burst mode into adis_data
>   iio: adis16400: Drop adis_burst usage
>   iio: adis16475: Drop adis_burst usage
>   iio: adis. Drop adis_burst struct
>=20
>  drivers/iio/imu/adis16400.c   | 32 +++++++++++++-------------------
>  drivers/iio/imu/adis16475.c   | 18 +++---------------
>  drivers/iio/imu/adis_buffer.c | 12 +++++-------
>  include/linux/iio/imu/adis.h  | 26 +++++++++-----------------
>  4 files changed, 30 insertions(+), 58 deletions(-)
>=20

