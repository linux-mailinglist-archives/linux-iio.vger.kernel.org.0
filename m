Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128231CC9ED
	for <lists+linux-iio@lfdr.de>; Sun, 10 May 2020 11:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgEJJwm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 May 2020 05:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbgEJJwm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 May 2020 05:52:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 132C920820;
        Sun, 10 May 2020 09:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589104361;
        bh=UNTtwhximIfphTFUiJ0t06E4k73XdFCK+rXEofTQgBA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=irHWIN9bSKRMi6LY2WR48cdRl7v8B/R/YqTomOck68PCRfDI3/cBEd5sCVHX8CAXS
         HeZ15K88YRFklayCmjrWy+MparELArnR2mal4gOBI8iuvbBgNfm/PWMpLeRuUNLGe9
         K8R9vtOUP28no2zb/wtDQJumcT9nkKBSdlTrXFwI=
Date:   Sun, 10 May 2020 10:52:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org,
        tglx@linutronix.de, allison@lohutok.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: bmp280: fix compensation of humidity
Message-ID: <20200510105236.241eee37@archlinux>
In-Reply-To: <20200504181033.GA15745@arbad>
References: <20200504181033.GA15745@arbad>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 May 2020 20:10:34 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Limit the output of humidity compensation to the range between 0 and 100
> percent.
> 
> Depending on the calibration parameters of the individual sensor it
> happens, that a humidity above 100 percent or below 0 percent is
> calculated, which don't make sense in terms of relative humidity.
> 
> Add a clamp to the compensation formula as described in the datasheet of
> the sensor in chapter 4.2.3.
> 
> Although this clamp is documented, it was never in the driver of the
> kernel.
> 
> It depends on the circumstances (calibration parameters, temperature,
> humidity) if one can see a value above 100 percent without the clamp.
> The writer of this patch was working with this type of sensor without
> noting this error. So it seems to be a rare event when this bug occures.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

On basis of description I'm going to take this the slow way (next merge
window).  If you want it backported to stable I don't mind but I haven't
marked it as such so you'll have to request it explicitly after the
patch is in Linus' tree.  It's reasonably likely the scripts will
pick this one up anyway though...

Thanks,

Jonathan

> ---
> 
> Change to v2:
> Thanks to the review of Jonathan a more descriptive commit message is
> added.
> 
> Change to v1:
> Thanks to Tomasz for suggesting the easier to use function clamp_val()
> which is now used.
> 
>  drivers/iio/pressure/bmp280-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 29c209cc1108..297ee2205bf6 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -271,6 +271,8 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
>  		+ (s32)2097152) * calib->H2 + 8192) >> 14);
>  	var -= ((((var >> 15) * (var >> 15)) >> 7) * (s32)calib->H1) >> 4;
>  
> +	var = clamp_val(var, 0, 419430400);
> +
>  	return var >> 12;
>  };
>  

