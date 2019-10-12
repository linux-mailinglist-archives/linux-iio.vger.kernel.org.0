Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17077D4FF4
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 15:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfJLNQB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 09:16:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfJLNQB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 09:16:01 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26FD32087E;
        Sat, 12 Oct 2019 13:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570886160;
        bh=3gLnp9LH973aDTBxXPE+wf8ttNUJ0TCNXxOem9zvn9I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V5QaR2guE9oZvZqRTv5TzEhV4tTnlU4bKLtUREXqxRTTvtHnLSEMw11+MXS531OdF
         Z6AEHZoBOE0YyR41nbQhgvfCZ5Pctxu4oGccP/D6ar2dsTJBtPLLGeqwUVLXA288dj
         ZYlG1nCndMgyZN/SZKjRsNb+x5tQ0aQSNZC1vwik=
Date:   Sat, 12 Oct 2019 14:15:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jonathan.cameron@huawei.com>, <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] iio: imu: adis16480: make sure provided frequency is
 positive
Message-ID: <20191012141551.761178d8@archlinux>
In-Reply-To: <20191008141537.31512-1-alexandru.ardelean@analog.com>
References: <20191008141537.31512-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 8 Oct 2019 17:15:37 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> It could happen that either `val` or `val2` [provided from userspace] is
> negative. In that case the computed frequency could get a weird value.
> 
> Fix this by checking that neither of the 2 variables is negative, and check
> that the computed result is not-zero.
> 
> Fixes: e4f959390178 ("iio: imu: adis16480 switch sampling frequency attr to core support")
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
> 
> Changelog v1 -> v2:
> * also check that val & val2 are not negative (in addition to checking if
>  't' is zero
> 
>  drivers/iio/imu/adis16480.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index 01dae50e985b..0bec1fea823d 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -317,8 +317,11 @@ static int adis16480_set_freq(struct iio_dev *indio_dev, int val, int val2)
>  	struct adis16480 *st = iio_priv(indio_dev);
>  	unsigned int t, reg;
>  
> +	if (val < 0 || val2 < 0)
> +		return -EINVAL;
> +
>  	t =  val * 1000 + val2 / 1000;
> -	if (t <= 0)
> +	if (t == 0)
>  		return -EINVAL;
>  
>  	/*

