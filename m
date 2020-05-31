Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566641E97F4
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 15:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgEaNsx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 09:48:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgEaNsw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 09:48:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB04206F1;
        Sun, 31 May 2020 13:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590932932;
        bh=wKxxJ69sCKK08/CajGt2YX8NU6dfARAeeUDi0+P5S+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0tL0wqworscs11HLvnA+TA05Y04ORhsVNDuK8ty3U3Cf2fY4tBIF+Z0IcFDiVDhuO
         tIUVxBsT5pTZdzbkzIIZ3+KxNaTT2e0jhTldfcLAydhJAO/U610u1ukXFuv9WlcgvM
         ApvBUUD96tymMgEYdQ8ezSlnJLnvkj7rrB4owzLk=
Date:   Sun, 31 May 2020 14:48:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: magnetometer: mmc35240: Constify struct
 reg_default
Message-ID: <20200531144848.4af9a574@archlinux>
In-Reply-To: <20200526210223.1672-7-rikard.falkeborn@gmail.com>
References: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
        <20200526210223.1672-7-rikard.falkeborn@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 May 2020 23:02:23 +0200
Rikard Falkeborn <rikard.falkeborn@gmail.com> wrote:

> mmc35240_reg_defaults is not modified and can be made const to allow the
> compiler to put it in read-only memory.
> 
> Before:
>    text    data     bss     dec     hex filename
>    9759    3288     128   13175    3377 drivers/iio/magnetometer/mmc35240.o
> 
> After:
>    text    data     bss     dec     hex filename
>    9823    3224     128   13175    3377 drivers/iio/magnetometer/mmc35240.o
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/mmc35240.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
> index 1787d656d009..f27586716b5c 100644
> --- a/drivers/iio/magnetometer/mmc35240.c
> +++ b/drivers/iio/magnetometer/mmc35240.c
> @@ -459,7 +459,7 @@ static bool mmc35240_is_volatile_reg(struct device *dev, unsigned int reg)
>  	}
>  }
>  
> -static struct reg_default mmc35240_reg_defaults[] = {
> +static const struct reg_default mmc35240_reg_defaults[] = {
>  	{ MMC35240_REG_CTRL0,  0x00 },
>  	{ MMC35240_REG_CTRL1,  0x00 },
>  };

