Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA8919E67D
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 18:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgDDQq3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 12:46:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDDQq2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 12:46:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04114206D4;
        Sat,  4 Apr 2020 16:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586018788;
        bh=YQG4A/GOYNd5Jp5QAvFtVV//iwhK5hZrHteGmAX+ZTI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Chu2MnaGnccIKwDG6kMVXAqNdd6Up23J/BnZNgW1WTxLB+vGzeu/1vBFuH3d2Wmj7
         IiRhxh4zmcsdEsCdrEvbHRbieYyKMuZxwYVXbpc65XAPVWIJiTU1LqoAUdFekAGqVI
         79he8aXsBtMixMTbsEaeIcwT3gzoKlqJ8IPDlwQ0=
Date:   Sat, 4 Apr 2020 17:46:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <alexandru.ardelean@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: core: Fix handling of 'dB'
Message-ID: <20200404174624.0b7f1c80@archlinux>
In-Reply-To: <20200401112230.4708-1-mircea.caprioru@analog.com>
References: <20200401112230.4708-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 1 Apr 2020 14:22:30 +0300
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> This patch fixes the call to iio_str_to_fixpoint when using 'dB' sufix.
> Before this the scale_db was not used when parsing the string written to
> the attribute and it failed with invalid value.
> 
> Fixes: b8528224741b ("iio: core: Handle 'dB' suffix in core")
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>

Gah, I guess this messed up around the introduction of the character handling.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 157d95a24faa..7da9cd2a2b58 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -909,14 +909,11 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  			return -EINVAL;
>  		integer = ch;
>  	} else {
> -		ret = iio_str_to_fixpoint(buf, fract_mult, &integer, &fract);
> +		ret = __iio_str_to_fixpoint(buf, fract_mult, &integer, &fract,
> +					    scale_db);
>  		if (ret)
>  			return ret;
>  	}
> -	ret = __iio_str_to_fixpoint(buf, fract_mult, &integer, &fract,
> -				    scale_db);
> -	if (ret)
> -		return ret;
>  
>  	ret = indio_dev->info->write_raw(indio_dev, this_attr->c,
>  					 integer, fract, this_attr->address);

