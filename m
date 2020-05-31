Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0A11E97F2
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 15:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgEaNr7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 09:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgEaNr7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 09:47:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDECE206F1;
        Sun, 31 May 2020 13:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590932879;
        bh=DH8ycjhUV5ikfmryVloe1Fw9MRgpGEyedmhdrEq9BTE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CGDrJsrnqa0vPPYTJsDsfFyXprppb7WGtUpI5D0fDz7Esl3caqtprjnUMU2JpMXz5
         TmLwVjgPeEMvFu7UqFpDX1YzxWQiWcI6fGvXtaF5/lBEcURk/MkibnVMrevaW+Z14P
         3DTc4VdeKqoITgpqgYJFTDkE+zE6+/WllohFsUHA=
Date:   Sun, 31 May 2020 14:47:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] iio: light: stk3310: Constify regmap_config
Message-ID: <20200531144755.1874867c@archlinux>
In-Reply-To: <20200526210223.1672-6-rikard.falkeborn@gmail.com>
References: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
        <20200526210223.1672-6-rikard.falkeborn@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 May 2020 23:02:22 +0200
Rikard Falkeborn <rikard.falkeborn@gmail.com> wrote:

> stk3310_regmap_config is not modified and can be made const to allow the
> compiler to put it in read-only memory.
> 
> Before:
>    text    data     bss     dec     hex filename
>   16027    5424     128   21579    544b drivers/iio/light/stk3310.o
> 
> After:
>    text    data     bss     dec     hex filename
>   16347    5104     128   21579    544b drivers/iio/light/stk3310.o
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Applied.

thanks,

Jonathan

> ---
>  drivers/iio/light/stk3310.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index 185c24a75ae6..9d1e503bc958 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -487,7 +487,7 @@ static bool stk3310_is_volatile_reg(struct device *dev, unsigned int reg)
>  	}
>  }
>  
> -static struct regmap_config stk3310_regmap_config = {
> +static const struct regmap_config stk3310_regmap_config = {
>  	.name = STK3310_REGMAP_NAME,
>  	.reg_bits = 8,
>  	.val_bits = 8,

