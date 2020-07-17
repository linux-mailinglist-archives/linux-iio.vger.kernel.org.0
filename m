Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061982243E5
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 21:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgGQTKh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 15:10:37 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58850 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728440AbgGQTKf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 17 Jul 2020 15:10:35 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jwVka-0008Lk-EN; Fri, 17 Jul 2020 21:10:28 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 30/30] iio: adc: rockchip_saradc: Demote Demote seemingly unintentional kerneldoc header
Date:   Fri, 17 Jul 2020 21:10:27 +0200
Message-ID: <4422628.h3HLAr0T0d@diego>
In-Reply-To: <20200717165538.3275050-31-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org> <20200717165538.3275050-31-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Am Freitag, 17. Juli 2020, 18:55:38 CEST schrieb Lee Jones:
> This is the only use of kerneldoc in the source file and no
> descriptions are provided.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/adc/rockchip_saradc.c:190: warning: Function parameter or member 'reset' not described in 'rockchip_saradc_reset_controller'
> 
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Subject-line says "Demote Demote..."

Otherwise
Reviewed-by: Heiko Stuebner <heiko@sntech.de>


> ---
>  drivers/iio/adc/rockchip_saradc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 582ba047c4a67..cf4ec59c1dab0 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -183,7 +183,7 @@ static const struct of_device_id rockchip_saradc_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, rockchip_saradc_match);
>  
> -/**
> +/*
>   * Reset SARADC Controller.
>   */
>  static void rockchip_saradc_reset_controller(struct reset_control *reset)
> 




