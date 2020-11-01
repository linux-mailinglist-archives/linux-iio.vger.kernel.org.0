Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5492A1ED7
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 16:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgKAPAg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 10:00:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:42612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgKAPAf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Nov 2020 10:00:35 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F1C1206DC;
        Sun,  1 Nov 2020 15:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604242835;
        bh=GyAsRj4um/ki1Ww96ZpeK3KP7ktvVbefJETi9/8iZw8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zdUQE6j48xyzqSMAKP4TzWMyrrdulEYXxmI+so6/Xlkh8rrgNbA/7GMLvLGLVf03O
         FaCXuv9FPhCZOX7kTiFbiUkoGirADUFI6ClmAgVJ8yxeaC5DjBOBD1EbrqhKBXuXXk
         fzY2pMW2KlHg4jaMGjfAdTtFaC7+n8+X47gSZY1Y=
Date:   Sun, 1 Nov 2020 15:00:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     trix@redhat.com
Cc:     lars@metafoo.de, pmeerw@pmeerw.net, alexandru.ardelean@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: bmc150: remove unneeded semicolon
Message-ID: <20201101150027.5fc8bd21@archlinux>
In-Reply-To: <20201031134319.2134314-1-trix@redhat.com>
References: <20201031134319.2134314-1-trix@redhat.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 31 Oct 2020 06:43:19 -0700
trix@redhat.com wrote:

> From: Tom Rix <trix@redhat.com>
> 
> A semicolon is not needed after a switch statement.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index fc6840f9c1fa..73e55ec815ec 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -190,7 +190,7 @@ static bool bmc150_magn_is_writeable_reg(struct device *dev, unsigned int reg)
>  		return true;
>  	default:
>  		return false;
> -	};
> +	}
>  }
>  
>  static bool bmc150_magn_is_volatile_reg(struct device *dev, unsigned int reg)

