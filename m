Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C65158BAE8
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2019 15:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfHMN6F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Aug 2019 09:58:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728205AbfHMN6F (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Aug 2019 09:58:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FE62206C2;
        Tue, 13 Aug 2019 13:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565704684;
        bh=5hY8OZVsklcPrzPyZuR0CGTcNrqsFhS18bZmriS/fD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y8Khf+8WwAyiOpzydqnUl0JPHB5gMKBIBn5Kn5E8Z0z9bSI/R3Ye0B1KQNufnZRJ+
         xKqHMq/KF2ODN0BQfsJoXD179qnt6v/C5NnJaGIuzTVUrsQnY/AKz49IKtGp7LdW2q
         hsyqbGq2YrpffOcISbd6Wqlgye/kfWchk6rHJ3SM=
Date:   Tue, 13 Aug 2019 15:58:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-iio@vger.kernel.org,
        Martyn Welch <martyn.welch@collabora.com>
Subject: Re: [PATCH] iio:light:noa1305: Fix missing break statement.
Message-ID: <20190813135802.GB27392@kroah.com>
References: <20190813133851.14345-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813133851.14345-1-Jonathan.Cameron@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 13, 2019 at 09:38:51PM +0800, Jonathan Cameron wrote:
> This got caught by the implicit fall through detection but is
> a bug rather than missing marking.
> 
> Reported-by: 0-DAY kernel test infrastructure
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Fixes: 741172d18e8a ("iio: light: noa1305: Add support for NOA1305")
> ---
>  drivers/iio/light/noa1305.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
> index 7b859ae1044d..5ebfbc52f541 100644
> --- a/drivers/iio/light/noa1305.c
> +++ b/drivers/iio/light/noa1305.c
> @@ -85,6 +85,7 @@ static int noa1305_scale(struct noa1305_priv *priv, int *val, int *val2)
>  	case NOA1305_INTEGR_TIME_400MS:
>  		*val = 100;
>  		*val2 = 77 * 4;
> +		break;
>  	case NOA1305_INTEGR_TIME_200MS:
>  		*val = 100;
>  		*val2 = 77 * 2;
> -- 
> 2.20.1
> 

Gustavo, your work caught a bug _before_ it hit Linus's tree this time :)

I'll go queue this up now, thanks for the fast response Jonathan.

greg k-h
