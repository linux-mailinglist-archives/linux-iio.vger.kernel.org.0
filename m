Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A896224BEA
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 16:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGROkE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 10:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgGROkE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 10:40:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C858520684;
        Sat, 18 Jul 2020 14:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595083204;
        bh=nvn1jkxHHeYYWEQoAjKg5uofe3fLSd64oTcVeFIWWM0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o8r+0ObtPAJmTRvOUxAuMKPAjOpO9G/4WFhdifT4R1z0WEhSQg2L2Act7vwLMmG6P
         zUGOKsPNNUybqCaKFFHlF75HePtOM6ljxenhS5uULWbSxfLiwH1kaFoGsfgc6JxQpX
         DRPK0a+c19ZfYQnNh5WhGtnpaH8ytxiBVCmXjBVM=
Date:   Sat, 18 Jul 2020 15:40:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 10/30] iio: dummy: iio_simple_dummy: Add newline after
 function-end
Message-ID: <20200718154000.60e04716@archlinux>
In-Reply-To: <20200716135928.1456727-11-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-11-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:08 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Fixes the following checkpatch.pl warning(s):
> 
>  CHECK: Please use a blank line after function/struct/union/enum declarations
>  #46: FILE: drivers/iio/dummy/iio_simple_dummy.c:690:
>   }
>  +/*
>  total: 0 errors, 0 warnings, 1 checks, 22 lines checked
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied

> ---
>  drivers/iio/dummy/iio_simple_dummy.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
> index be66b26373723..cc4335963d0cf 100644
> --- a/drivers/iio/dummy/iio_simple_dummy.c
> +++ b/drivers/iio/dummy/iio_simple_dummy.c
> @@ -687,6 +687,7 @@ static int iio_dummy_remove(struct iio_sw_device *swd)
>  
>  	return 0;
>  }
> +
>  /*
>   * module_iio_sw_device_driver() -  device driver registration
>   *

