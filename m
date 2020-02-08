Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24E5F1564BB
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2020 15:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgBHORT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Feb 2020 09:17:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:45724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbgBHORT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Feb 2020 09:17:19 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14CAE2082E;
        Sat,  8 Feb 2020 14:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581171438;
        bh=z5cQib/9fiCGYeeu6o1Klzel6o81Q2+YFMOQ6rt6FE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AnauG0QCiOEPSdpqJe6FuDH15Pynll2mV1N/I5iuB/b7idTR7KZ7qheY8uj4lgUTI
         YZ1O5q/3cNNgFRZfEhFrGzeyBOAz5eB0COdaWe9E+pINN9hWJ/D/POg2TH2F5lI4nu
         o6Ag+lqmXhK7cvkc5OY2tvQTHNn40WSAxkKM1aq0=
Date:   Sat, 8 Feb 2020 14:17:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>
Cc:     Tomas Novotny <tomas@novotny.cz>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: vncl4000: Fix early return in
 vcnl4200_set_power_state
Message-ID: <20200208141713.469fb174@archlinux>
In-Reply-To: <19efdcd597b21ece9ad0ff894b6566d2ef4e2c02.1581066317.git.agx@sigxcpu.org>
References: <19efdcd597b21ece9ad0ff894b6566d2ef4e2c02.1581066317.git.agx@sigxcpu.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  7 Feb 2020 10:12:09 +0100
Guido G=C3=BCnther <agx@sigxcpu.org> wrote:

> Don't return early unconditionally.
>=20
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
I've merged this down into the original patch.

Thanks,

Jonathan


>=20
> ---
> I've not added a 'Fixes:' line since this is not part of Linus tree yet.
> Tested proximity and ambient light on a vcnl4040 and checked the driver
> suspends/resumes correctly and puts out valid data right after resume. =20
>=20
>  drivers/iio/light/vcnl4000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 3b71c7d538af..38fcd9a26046 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -149,7 +149,7 @@ static int vcnl4200_set_power_state(struct vcnl4000_d=
ata *data, bool on)
>  	if (ret < 0)
>  		return ret;
> =20
> -	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, val);
> +	ret =3D i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, val);
>  	if (ret < 0)
>  		return ret;
> =20

