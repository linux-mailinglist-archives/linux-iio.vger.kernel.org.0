Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96DB224CC8
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgGRP7z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:59:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgGRP7z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:59:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 817522076A;
        Sat, 18 Jul 2020 15:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595087995;
        bh=CP3p2govezDlK2FpqZiBjhP4KxaTQqaBw290MEpQbh0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HPkP+ruFHvUsgyLElIGzyQGMlNSgHXJ/cQyKMIUBib+zieOP/BrVoVh+FcUZzdeDW
         HliaJuS8UIcOdqmnPtoHed4febxmKXz4eu76Fw9WAX3imkNS2IgOzICcWr7wwxT81z
         ivN/glYCKdYdjCOnr6mZvgNcQZnpuFp/lyTOSl0E=
Date:   Sat, 18 Jul 2020 16:59:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 21/30] iio: adc: max9611: Demote obvious misuse of
 kerneldoc to standard comment blocks
Message-ID: <20200718165950.594d8b72@archlinux>
In-Reply-To: <20200717165538.3275050-22-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-22-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:29 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> No attempt has been made to document any of the demoted structs here.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/adc/max9611.c:117: warning: cannot understand function prototype: 'const unsigned int max9611_mux_conf[][2] = '
>  drivers/iio/adc/max9611.c:145: warning: cannot understand function prototype: 'const unsigned int max9611_gain_conf[][2] = '
> 
> Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max9611.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> index 04d5ff7d2c8ec..3a361299a70f4 100644
> --- a/drivers/iio/adc/max9611.c
> +++ b/drivers/iio/adc/max9611.c
> @@ -110,7 +110,7 @@ enum max9611_conf_ids {
>  	CONF_TEMP,
>  };
>  
> -/**
> +/*
>   * max9611_mux_conf - associate ADC mux configuration with register address
>   *		      where data shall be read from
>   */
> @@ -133,7 +133,7 @@ enum max9611_csa_gain_params {
>  	CSA_GAIN_OFFS_RAW,
>  };
>  
> -/**
> +/*
>   * max9611_csa_gain_conf - associate gain multiplier with LSB and
>   *			   offset values.
>   *

