Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9392439C64
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 12:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfFHKX3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 06:23:29 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53350 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfFHKX2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jun 2019 06:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559989406; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tdw8LUmBZWbwyaBxKvH4GHIrDdHlccVhMKjUUwHBxHI=;
        b=UdXmnH//oB+A+1isESaZyhXYu0NH4gh4KgrUMjNuJ9fWmfgz1gHkiR95hu/hr6+WNu5dgv
        OsmBfY/lYaT+ccL1u5JiD/E3aNiUG9R2ShNYXg38ExH4u5XNyWn4QCCDtbj4xbYJCGowYY
        mTXF3x6/KhMXyPY/RuVnnexzwGEh3WE=
Date:   Sat, 08 Jun 2019 12:23:21 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] iio: ingenic-adc: Make probe function __init_or_module
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Artur Rojek <contact@artur-rojek.eu>, od@zcrc.me,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1559989401.1815.6@crapouillou.net>
In-Reply-To: <20190607160501.16369-1-paul@crapouillou.net>
References: <20190607160501.16369-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I misunderstood what __init_or_module was for. Please ignore this=20
patch. Sorry for the noise.


Le ven. 7 juin 2019 =E0 18:05, Paul Cercueil <paul@crapouillou.net> a=20
=E9crit :
> This allows the probe function to be dropped after the kernel finished
> its initialization, in the case where the driver was not compiled as a
> module.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/iio/adc/ingenic-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ingenic-adc.c=20
> b/drivers/iio/adc/ingenic-adc.c
> index 92b1d5037ac9..027f710df843 100644
> --- a/drivers/iio/adc/ingenic-adc.c
> +++ b/drivers/iio/adc/ingenic-adc.c
> @@ -279,7 +279,7 @@ static const struct iio_chan_spec=20
> ingenic_channels[] =3D {
>  	},
>  };
>=20
> -static int ingenic_adc_probe(struct platform_device *pdev)
> +static int __init_or_module ingenic_adc_probe(struct platform_device=20
> *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
>  	struct iio_dev *iio_dev;
> --
> 2.21.0.593.g511ec345e18
>=20

=

