Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64A141A7B4
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 13:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfEKLtL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 May 2019 07:49:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728526AbfEKLtL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 May 2019 07:49:11 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B19C2146F;
        Sat, 11 May 2019 11:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557575350;
        bh=0bGRBAjOshAD95C4e1pSM8zt2quIj/Enze1DCLSbCQg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=egYpDecqn9SOsfLFkpYLBblPdNLRD38lWcH0FThLOmE/f9BjIdVlQSwUlHwwh52w2
         dE9NX7nMsBf4FhKQ0UE9eKmTBBRiqauxItM7czV2xU8NV4ibTxulK3sdMNG8xVFnG8
         JwIBJ2MTAaD6Sd+XyuEE3aTgHFRWbXAgpOJsfLmQ=
Date:   Sat, 11 May 2019 12:49:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ruslan Babayev <ruslan@babayev.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        xe-linux-external@cisco.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: dac: ds4422/ds4424 fix chip verification
Message-ID: <20190511124905.11d24e5b@archlinux>
In-Reply-To: <20190505192438.2644-2-ruslan@babayev.com>
References: <20190505192438.2644-2-ruslan@babayev.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  5 May 2019 12:24:37 -0700
Ruslan Babayev <ruslan@babayev.com> wrote:

> The ds4424_get_value function takes channel number as it's 3rd
> argument and translates it internally into I2C address using
> DS4424_DAC_ADDR macro. The caller ds4424_verify_chip was passing an
> already translated I2C address as its last argument.
> 
> Signed-off-by: Ruslan Babayev <ruslan@babayev.com>
> Cc: xe-linux-external@cisco.com
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ds4424.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
> index 2b3ba1a66fe8..ae9be792693b 100644
> --- a/drivers/iio/dac/ds4424.c
> +++ b/drivers/iio/dac/ds4424.c
> @@ -166,7 +166,7 @@ static int ds4424_verify_chip(struct iio_dev *indio_dev)
>  {
>  	int ret, val;
>  
> -	ret = ds4424_get_value(indio_dev, &val, DS4424_DAC_ADDR(0));
> +	ret = ds4424_get_value(indio_dev, &val, 0);
>  	if (ret < 0)
>  		dev_err(&indio_dev->dev,
>  				"%s failed. ret: %d\n", __func__, ret);

