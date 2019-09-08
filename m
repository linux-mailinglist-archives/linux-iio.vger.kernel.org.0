Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9B4ACC97
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 14:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfIHMOH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 08:14:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729003AbfIHMOH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 08:14:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C36A218AC;
        Sun,  8 Sep 2019 12:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567944847;
        bh=v0OzorZmln8aLi2yfQxgoh3gpMCfimqxY/nfBfXj2EY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OT00zRgA+ZKpRU8jZSto/E1vs0hiRk0RXznNu35k5AVy3kVdctBxQMR66cz8j6hpi
         Pkn9c8i98stkkV0s1StYEUfkvOQ3hInXhs1H6AIXwI8C9C2gSzveNAC09pgn5441mH
         SmDjIvw1i27Sn3C05cUNodxZ5+EuhZn7DS4ol02o=
Date:   Sun, 8 Sep 2019 13:13:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Pascal Bouwmann <bouwmann@tau-tec.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 1/1] iio: fix center temperature of bmc150-accel-core
Message-ID: <20190908131358.7cedb1bf@archlinux>
In-Reply-To: <bcb0af95-94d4-eb15-0918-8d35b376da8e@tau-tec.de>
References: <bcb0af95-94d4-eb15-0918-8d35b376da8e@tau-tec.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 29 Aug 2019 07:29:41 +0200
Pascal Bouwmann <bouwmann@tau-tec.de> wrote:

> The center temperature of the supported devices stored in the constant
> BMC150_ACCEL_TEMP_CENTER_VAL is not 24 degrees but 23 degrees.
>=20
> Signed-off-by: Pascal Bouwmann <bouwmann@tau-tec.de>

Your patch is corrupted, but I've manually applied it.

I haven't marked it for stable because I worry a little that this will give
people unexpected changes in long term trends.  Better they see that only
on a major kernel version upgrade.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
> In the datasheet of the BMC150 device the center temperature is given
> wrongly.
> See https://community.bosch-sensortec.com/t5/MEMS-sensors-forum/
> center-temperature-of-bmc150-device/td-p/9328
>=20
> diff --git a/drivers/iio/accel/bmc150-accel-core.c=20
> b/drivers/iio/accel/bmc150-accel-core.c
> index 807299dd45eb..7e86a5b7ec4e 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -125,7 +125,7 @@
>  =C2=A0#define BMC150_ACCEL_SLEEP_1_SEC=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 0x0F
>=20
>  =C2=A0#define BMC150_ACCEL_REG_TEMP=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0 0x08
> -#define BMC150_ACCEL_TEMP_CENTER_VAL=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 24
> +#define BMC150_ACCEL_TEMP_CENTER_VAL=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 23
>=20
>  =C2=A0#define BMC150_ACCEL_AXIS_TO_REG(axis)=C2=A0=C2=A0=C2=A0 (BMC150_A=
CCEL_REG_XOUT_L +=20
> (axis * 2))
>  =C2=A0#define BMC150_AUTO_SUSPEND_DELAY_MS=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 2000
>=20

