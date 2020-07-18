Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311E7224CA2
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGRPrg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPrf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:47:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35D3820724;
        Sat, 18 Jul 2020 15:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595087255;
        bh=XRzti79uQVFdjmMWIbjdiSJkDMaIb68IwjOeKKoGMc8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=APeEhjHotbWvqTGg/NBXd/m66Q+hLGctikEm40ssS/Ojz+UtDwqspFLqyXYHPiaPC
         jQI50wIHs4wV9yDDm7c3VCGEABde4H31fOVdFOp3oiJKvudrhoYLAttWaNsAhFoTkW
         z8BWtSfIb1pz7OxTP1s6R5u7AYed/MX4CmzQHnm0=
Date:   Sat, 18 Jul 2020 16:47:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 11/30] iio: adc: ad799x: Demote seemingly unintentional
 kerneldoc header
Message-ID: <20200718164731.3a1a0841@archlinux>
In-Reply-To: <20200717165538.3275050-12-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-12-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:19 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> This is the only use of function related kerneldoc in the sourcefile
> and no descriptions are provided.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/adc/ad799x.c:192: warning: Function parameter or member 'irq' not described in 'ad799x_trigger_handler'
>  drivers/iio/adc/ad799x.c:192: warning: Function parameter or member 'p' not described in 'ad799x_trigger_handler'
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad799x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index ef013af1aec07..007ec7ad94752 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -182,7 +182,7 @@ static int ad799x_update_config(struct ad799x_state *st, u16 config)
>  	return 0;
>  }
>  
> -/**
> +/*
>   * ad799x_trigger_handler() bh of trigger launched polling to ring buffer
>   *
>   * Currently there is no option in this driver to disable the saving of

