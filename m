Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1471F88EF
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jun 2020 15:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgFNN1U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jun 2020 09:27:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgFNN1U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jun 2020 09:27:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 643A82068E;
        Sun, 14 Jun 2020 13:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592141239;
        bh=YVrr4tAAenYjEuAQ6/B7z9JD29kRhfi69apPPnTeHbQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JZ5c9NEh0GLnNog5HEDkSUgRVCmx/hj9ZSzp9FepzXvlo4Kv2igvneCOumeQpgndX
         22dC38J1i/mb7V9g3SgGHhXV1itLPWojbl4t1ikhwFdswGs76KAzlByrv31nlFfHDV
         LvIbTOYwtNWxSnZpM9VMfzbkvAFhmcrsQBEeiuRo=
Date:   Sun, 14 Jun 2020 14:27:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mugilraj D <dmugil2000@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Bakker <xc-racer2@live.ca>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: Replace symbolic permissions with octal
 permissions
Message-ID: <20200614142715.02e737bb@archlinux>
In-Reply-To: <1592036351-10166-1-git-send-email-dmugil2000@gmail.com>
References: <1592036351-10166-1-git-send-email-dmugil2000@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 13 Jun 2020 13:49:01 +0530
Mugilraj D <dmugil2000@gmail.com> wrote:

> Resolve following checkpatch issue:
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider
> using octal permissions '0444'.

Hmm. I guess that's just about worth tidying up, but (see inline...)

Take into account that any change does have an impact on maintainability
of a driver, and generally no one will take white space changes to
drivers outside staging unless there is a good reason.

Jonathan

> 
> Signed-off-by: Mugilraj D <dmugil2000@gmail.com>
> ---
>  drivers/iio/accel/bma180.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 265722e..b716347 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -531,14 +531,13 @@ static ssize_t bma180_show_scale_avail(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(in_accel_filter_low_pass_3db_frequency_available,
> -	S_IRUGO, bma180_show_filter_freq_avail, NULL, 0);
> +	0444, bma180_show_filter_freq_avail, NULL, 0);
>  
>  static IIO_DEVICE_ATTR(in_accel_scale_available,
> -	S_IRUGO, bma180_show_scale_avail, NULL, 0);
> +	0444, bma180_show_scale_avail, NULL, 0);
>  
>  static struct attribute *bma180_attributes[] = {
> -	&iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.
> -		dev_attr.attr,
> +	&iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,

This change is unrelated and basically just noise.

>  	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
>  	NULL,
>  };

