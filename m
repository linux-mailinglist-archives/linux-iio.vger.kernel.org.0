Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B534E21475D
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 18:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGDQ3V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 12:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgGDQ3V (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 12:29:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BC66206B6;
        Sat,  4 Jul 2020 16:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593880160;
        bh=5uivsfNv00vVOwSQdVj9OXMpaD34v95Uj4LXUPLTFWU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AgHHxI2Xg+fwSDdyC+obuEolaT6UeI2CrljEPQYvdEyk0f2g7gxRLhObL9qnbpFbp
         UyB0jq/KwNFOZjYIi4cG1uPcIway9yg/8c8vlOmA6eQEIRxn5XhTkzMaS2oku5KUW7
         ddmp0Ru+p1eR4PU5rB8i3PXf8tGkbO0RhB/SMPLU=
Date:   Sat, 4 Jul 2020 17:29:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Luca Weiss <luca@z3ntu.xyz>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
Subject: Re: [PATCH] iio: light: stk3310: add chip id for STK3311-X variant
Message-ID: <20200704172916.7a8a7359@archlinux>
In-Reply-To: <20200703194406.110855-1-megous@megous.com>
References: <20200703194406.110855-1-megous@megous.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  3 Jul 2020 21:44:05 +0200
Ondrej Jirman <megous@megous.com> wrote:

> From: Icenowy Zheng <icenowy@aosc.io>
> 
> The STK3311 chip has a variant called STK3311-X, which has a different
> chip id of 0x12.
> 
> Add the chip id to the driver.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Given this is clearly not quite compatible with the stk3311 probably
best to also add a an id to the of id table.  Any idea what else
is different?

Thanks,

Jonathan

> ---
>  drivers/iio/light/stk3310.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index 185c24a75ae6..1a8401d198a4 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -37,6 +37,7 @@
>  
>  #define STK3310_CHIP_ID_VAL			0x13
>  #define STK3311_CHIP_ID_VAL			0x1D
> +#define STK3311X_CHIP_ID_VAL			0x12
>  #define STK3335_CHIP_ID_VAL			0x51
>  #define STK3310_PSINT_EN			0x01
>  #define STK3310_PS_MAX_VAL			0xFFFF
> @@ -453,6 +454,7 @@ static int stk3310_init(struct iio_dev *indio_dev)
>  
>  	if (chipid != STK3310_CHIP_ID_VAL &&
>  	    chipid != STK3311_CHIP_ID_VAL &&
> +	    chipid != STK3311X_CHIP_ID_VAL &&
>  	    chipid != STK3335_CHIP_ID_VAL) {
>  		dev_err(&client->dev, "invalid chip id: 0x%x\n", chipid);
>  		return -ENODEV;

