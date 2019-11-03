Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E85DEED33D
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2019 12:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfKCL6l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Nov 2019 06:58:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:45512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfKCL6l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Nov 2019 06:58:41 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15F9320842;
        Sun,  3 Nov 2019 11:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572782320;
        bh=M7FyKpnyuEzG2QJKlhU/ranTTBSFTIVEnsVVqp7+NPg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jg5Ii0cntsp6WDoepGYoPHc4sA0Bo55SqZJCv9VirdRBQNfSQbVPbFPCXt6cqaPX9
         1UunNwJJ12ZGz7YnPrHbcD9WuWoVJdN/PnoV6zyh+rj6umszY8Ma8efE0GHtDOAnuD
         9V9XbDKbSjH+nMPK85iZD817Os9WGiGpVM0RlcyA=
Date:   Sun, 3 Nov 2019 11:58:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 2/2] iio: adis16480: Add debugfs_reg_access entry
Message-ID: <20191103115835.5096dd19@archlinux>
In-Reply-To: <20191028163349.28866-2-nuno.sa@analog.com>
References: <20191028163349.28866-1-nuno.sa@analog.com>
        <20191028163349.28866-2-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Oct 2019 17:33:49 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The driver is defining debugfs entries by calling
> `adis16480_debugfs_init()`. However, those entries are attached to the
> iio_dev debugfs entry which won't exist if no debugfs_reg_access
> callback is provided.
>=20
> Fixes: 2f3abe6cbb6c ("iio:imu: Add support for the ADIS16480 and similar =
IMUs")
> Cc: <Stable@vger.kernel.org>
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git.=20

Note I dropped the cc for stable from this thread but not the patch.
That should mean they pick it up from mainline once it gets there.

Thanks,

Jonathan

> ---
> Changes in v2:
>  * Add a Fixes tag and Cc stable.
>=20
>  drivers/iio/imu/adis16480.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index 3b53bbb11bfb..94aa1c57e605 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -921,6 +921,7 @@ static const struct iio_info adis16480_info =3D {
>  	.read_raw =3D &adis16480_read_raw,
>  	.write_raw =3D &adis16480_write_raw,
>  	.update_scan_mode =3D adis_update_scan_mode,
> +	.debugfs_reg_access =3D adis_debugfs_reg_access,
>  };
> =20
>  static int adis16480_stop_device(struct iio_dev *indio_dev)

