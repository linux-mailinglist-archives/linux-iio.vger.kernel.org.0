Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9058C1541DE
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 11:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgBFK3U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 05:29:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:43314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728394AbgBFK3U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 05:29:20 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A46A206CC;
        Thu,  6 Feb 2020 10:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580984960;
        bh=H4ojcjOui5q7QcsywcALwvAJbGNX9wX0l+S2a2fHvY8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bHWdjw7hCXs1FcUOJNXoFKIyAHygzKv+Nha5MecI4AQEl9QrZ0upXWbjKKaEDdxWX
         qSBMgdtldC7YPDgLYWWufRykoR60UgDS4njwmlJ534qtGUc1Minotjj5/qkxmM59Ck
         D0yL37Wf0P3Ptvp48n0K0HXZCZ69G11x1drmm99k=
Date:   Thu, 6 Feb 2020 10:29:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Silvan Murer <silvan.murer@gmail.com>,
        linux-iio@vger.kernel.org,
        Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH 4/3] iio: dac: ltc2632: remove some unused defines
Message-ID: <20200206102915.2e32cb5e@archlinux>
In-Reply-To: <20200203203126.7003-1-u.kleine-koenig@pengutronix.de>
References: <20200130131549.1170-1-u.kleine-koenig@pengutronix.de>
        <20200203203126.7003-1-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  3 Feb 2020 21:31:26 +0100
Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:

> These two defines are unused since the driver was introduced in commit
> 02b829f9e11f ("iio: dac: Add support for ltc2632 DACs").
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
A bit of fuzz and the mysterious bit of this being patch 4 of 3 aside all g=
ood.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ltc2632.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
> index 1e7ffa0f6071..7adc91056aa1 100644
> --- a/drivers/iio/dac/ltc2632.c
> +++ b/drivers/iio/dac/ltc2632.c
> @@ -12,9 +12,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/regulator/consumer.h>
> =20
> -#define LTC2632_ADDR_DAC0                       0x0
> -#define LTC2632_ADDR_DAC1                       0x1
> -
>  #define LTC2632_CMD_WRITE_INPUT_N               0x0
>  #define LTC2632_CMD_UPDATE_DAC_N                0x1
>  #define LTC2632_CMD_WRITE_INPUT_N_UPDATE_ALL    0x2

