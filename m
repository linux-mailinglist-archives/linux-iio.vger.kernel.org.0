Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBA6224BCE
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 16:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgGRO1s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 10:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgGRO1s (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 10:27:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D0242064B;
        Sat, 18 Jul 2020 14:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595082467;
        bh=ps9ZZzz+lcyes6oa4jJWZNjZto/m00DauUtvo08pCNc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ODoM/j36sufJAvVQFb+JUbr5ulclWbrXJlOh81AGFHBcPqK7PooT7H1dY77YVwdK4
         brUPsQlMhxtDUk6hime/23SJ6kklEfL2AfmOx+f0syar/VTlWYWig4AMyne56qxLAt
         qtO24HnjMWkrF2TMuoraGTqzKskHdwAVRsU7vwNs=
Date:   Sat, 18 Jul 2020 15:27:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        William Markezana <william.markezana@meas-spec.com>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
Subject: Re: [PATCH 03/30] iio: common: ms_sensors: ms_sensors_i2c: Fix
 misspelling of parameter 'client'
Message-ID: <20200718152743.6867b3ea@archlinux>
In-Reply-To: <20200716135928.1456727-4-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-4-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:01 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Probably due to docrot.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:186: warning: Function parameter or member 'client' not described in 'ms_sensors_read_serial'
>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:186: warning: Excess function parameter 'cli' description in 'ms_sensors_read_serial'
> 
> Cc: William Markezana <william.markezana@meas-spec.com>
> Cc: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied

> ---
>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> index b52cba1b3c831..b9e2038d05ef4 100644
> --- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> +++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> @@ -165,7 +165,7 @@ static bool ms_sensors_crc_valid(u32 value)
>  
>  /**
>   * ms_sensors_read_serial() - Serial number read function
> - * @cli:	pointer to i2c client
> + * @client:	pointer to i2c client
>   * @sn:		pointer to 64-bits destination value
>   *
>   * Generic i2c serial number read function for Measurement Specialties devices.

