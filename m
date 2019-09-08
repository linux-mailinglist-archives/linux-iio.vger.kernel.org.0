Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C31AFACC77
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 13:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbfIHLi2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 07:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728862AbfIHLi2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 07:38:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2425F206BB;
        Sun,  8 Sep 2019 11:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567942707;
        bh=UACYLLIPEn9E879/MO6pj3oCzTpjS5SHXEfvpF4kCcQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dz8/tv8jmzNACaTmoUNcwEVWgFEMWMHLuKrsh+nRlp8xeajjZK5KC0Y0egznEe4hL
         sIJyD23LVIPiRyzXHhTxJiJR7FxmpHyCXpMggqZRxQ/Fdgiyh+J9//iW0yvdHDgRoj
         K7H17FVcIImzTgHqVxX7w2/3OI1YFKCr3OpXigZ0=
Date:   Sun, 8 Sep 2019 12:38:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Kevin Tsai <ktsai@capellamicro.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: cm36651: redundant assignment to variable
 ret
Message-ID: <20190908123822.7a17b7cc@archlinux>
In-Reply-To: <20190901152749.12916-1-colin.king@canonical.com>
References: <20190901152749.12916-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  1 Sep 2019 16:27:49 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable ret is being assigned a value that is never read and
> is being re-assigned a little later on. The assignment is redundant
> and hence can be removed.
> 
> Addresses-Coverity: ("Ununsed value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to do not much with it.

Thanks,

Jonathan

> ---
>  drivers/iio/light/cm36651.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
> index 1019d625adb1..90e38fcc974b 100644
> --- a/drivers/iio/light/cm36651.c
> +++ b/drivers/iio/light/cm36651.c
> @@ -532,7 +532,7 @@ static int cm36651_write_prox_event_config(struct iio_dev *indio_dev,
>  					int state)
>  {
>  	struct cm36651_data *cm36651 = iio_priv(indio_dev);
> -	int cmd, ret = -EINVAL;
> +	int cmd, ret;
>  
>  	mutex_lock(&cm36651->lock);
>  

