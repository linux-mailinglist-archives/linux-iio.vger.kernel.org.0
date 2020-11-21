Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E552C2BC01D
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 15:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgKUO6z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 09:58:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:38118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727926AbgKUO6y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 09:58:54 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59DFA22201;
        Sat, 21 Nov 2020 14:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605970734;
        bh=X97Yw7cQloTCULbQRjfU2ij20JzzIs+6GxljGzqB1/w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XIeXvQZQsgnbL3SyP0DTg5SLjsD0eTRkLo28p/cdhtPexI2t/TmmugjDVfZwYgRjj
         DPlP05DgKDiJw2022Q67HzrtimfzjMFfqv0eEC+vW+R7K489mbMqAGjC38wsFqOyfn
         EDJof7S+ZY8WIPUm3MR+6TSW3TJLp9pWs7nOWXIc=
Date:   Sat, 21 Nov 2020 14:58:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v2] iio: sx9310: Fix semtech,avg-pos-strength setting
 when > 16
Message-ID: <20201121145849.32e14ab9@archlinux>
In-Reply-To: <20201120182944.543428-1-swboyd@chromium.org>
References: <20201120182944.543428-1-swboyd@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Nov 2020 10:29:44 -0800
Stephen Boyd <swboyd@chromium.org> wrote:

> This DT property can be 0, 16, and then 64, but not 32. The math here
> doesn't recognize this slight bump in the power of 2 numbers and
> translates a DT property of 64 into the register value '3' when it
> really should be '2'. Fix it by subtracting one more if the number being
> translated is larger than 16.
> 
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Evan Green <evgreen@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Changes from v1 (https://lore.kernel.org/r/20201120073842.3232458-1-swboyd@chromium.org):
>  * Changed ternary to consider 17 to 31 as the same as 16
> 
>  drivers/iio/proximity/sx9310.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index a2f820997afc..ee1b4ff05a37 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -1305,7 +1305,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
>  		if (ret)
>  			break;
>  
> -		pos = min(max(ilog2(pos), 3), 10) - 3;
> +		pos = min(max(ilog2(pos), 3), 11) - (pos >= 32 ? 4 : 3);

Given this is now rather tricky to read, I'd just do an explicit lookup of
the allowed values.  Probably just a switch statement.

Thanks,

Jonathan

>  		reg_def->def &= ~SX9310_REG_PROX_CTRL7_AVGPOSFILT_MASK;
>  		reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL7_AVGPOSFILT_MASK,
>  					   pos);
> 
> base-commit: 5b19ca2c78a0838976064c0347e46a2c859b541d

