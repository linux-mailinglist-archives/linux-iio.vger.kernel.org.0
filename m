Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D313B185B83
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 10:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgCOJc5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 05:32:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728108AbgCOJc4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 05:32:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FE9C206BE;
        Sun, 15 Mar 2020 09:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584264776;
        bh=VY4L1xw5QTllEiBo3usXe+erLdqlZxEYoSBW+d90VEM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SSBOFa8IWj/dUFNuK+YgGSexgLn8RggwcdjrAqf+y/Pf6wet/IEZykkRaknB2Nr86
         dI/xmxy8G2auyb0cQCpFHZScdM4enoXrHnZydob5iwN4FyMJ2f1K5sea7t0AeHp51E
         NkZAZQLN3AaTFMSEL+h0eqMjQ9VeH0rgXbo17/bo=
Date:   Sun, 15 Mar 2020 09:32:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org,
        Lars =?UTF-8?B?TcO2bGxlbmRvcmY=?= <lars.moellendorf@plating.de>
Subject: Re: [PATCH] iio: xilinx-xadc: Fix typo in author's name
Message-ID: <20200315093247.32b7ae33@archlinux>
In-Reply-To: <20200309102847.14291-1-lars@metafoo.de>
References: <20200309102847.14291-1-lars@metafoo.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  9 Mar 2020 11:28:47 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> It appears the author of the xilinx-xadc driver can't even spell his own
> name correctly. Fix that.
>=20
> Reported-by: Lars M=C3=B6llendorf <lars.moellendorf@plating.de>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
:)

Applied to the togreg branch of iio.git. =20

Thanks,

Jonathan

> ---
>  drivers/iio/adc/xilinx-xadc-core.c   | 2 +-
>  drivers/iio/adc/xilinx-xadc-events.c | 2 +-
>  drivers/iio/adc/xilinx-xadc.h        | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-=
xadc-core.c
> index ec227b358cd6..2d6505a66511 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -3,7 +3,7 @@
>   * Xilinx XADC driver
>   *
>   * Copyright 2013-2014 Analog Devices Inc.
> - *  Author: Lars-Peter Clauen <lars@metafoo.de>
> + *  Author: Lars-Peter Clausen <lars@metafoo.de>
>   *
>   * Documentation for the parts can be found at:
>   *  - XADC hardmacro: Xilinx UG480
> diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilin=
x-xadc-events.c
> index dbfd5da290a4..2357f585720a 100644
> --- a/drivers/iio/adc/xilinx-xadc-events.c
> +++ b/drivers/iio/adc/xilinx-xadc-events.c
> @@ -3,7 +3,7 @@
>   * Xilinx XADC driver
>   *
>   * Copyright 2013 Analog Devices Inc.
> - *  Author: Lars-Peter Clauen <lars@metafoo.de>
> + *  Author: Lars-Peter Clausen <lars@metafoo.de>
>   */
> =20
>  #include <linux/iio/events.h>
> diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
> index 4017f18b0a4f..25abed9c0285 100644
> --- a/drivers/iio/adc/xilinx-xadc.h
> +++ b/drivers/iio/adc/xilinx-xadc.h
> @@ -3,7 +3,7 @@
>   * Xilinx XADC driver
>   *
>   * Copyright 2013 Analog Devices Inc.
> - *  Author: Lars-Peter Clauen <lars@metafoo.de>
> + *  Author: Lars-Peter Clausen <lars@metafoo.de>
>   */
> =20
>  #ifndef __IIO_XILINX_XADC__

