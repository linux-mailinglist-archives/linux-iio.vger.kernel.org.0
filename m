Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6EFCCF83
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 10:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfJFIrV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 04:47:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfJFIrV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 04:47:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBBB82084B;
        Sun,  6 Oct 2019 08:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570351640;
        bh=c8wQBhzReeO3t1vOHi+a7/28eNRkYXtRH3pMCWzLa5Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xHVYQxviIYMK9bHyg28Rf1cdONm0nrTpsBT2Q2rniwGmonDnFvP0HPO/EK+RKorDP
         xuF1sjVm2q5PLTz0o2oTcYz1qmrjlns1RJyd6yawfsfeQLtfm2/6RlkNmayNKj3IJ1
         mjjimneRVXZ5AMnlh2FW+QrDSEhgdKzA/IxGaXiA=
Date:   Sun, 6 Oct 2019 09:47:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: clean up indentation issue
Message-ID: <20191006094715.61f0a32e@archlinux>
In-Reply-To: <20190925123253.11944-1-colin.king@canonical.com>
References: <20190925123253.11944-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Sep 2019 13:32:53 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a return statement that is indented incorrectly, add in
> the missing tab.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to ignore it.

Thanks,

Jonathan

> ---
>  drivers/iio/gyro/itg3200_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
> index 998fb8d66fe3..981ae2291505 100644
> --- a/drivers/iio/gyro/itg3200_core.c
> +++ b/drivers/iio/gyro/itg3200_core.c
> @@ -154,7 +154,7 @@ static int itg3200_write_raw(struct iio_dev *indio_dev,
>  					  t);
>  
>  		mutex_unlock(&indio_dev->mlock);
> -	return ret;
> +		return ret;
>  
>  	default:
>  		return -EINVAL;

