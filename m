Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014C129EEE7
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 15:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgJ2O4q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 10:56:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgJ2O4p (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Oct 2020 10:56:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE5C3206D4;
        Thu, 29 Oct 2020 14:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603983405;
        bh=NhHSb0cGGfO1JA2R7ksjOO1AEhzpS6Xx77Qyu4hv63A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jTO5B4BVO+w4340QYOeSNfPOFhsGxX/UBt0ppTcanbUGy9YN6nV+s/O0ExLVQgVpF
         xecdt5fiLkYuQLSxtXUWNo0Q9PWCTnW5URmOu8GIXIQlZfVmx1cM22yX9MqQucMYGm
         j385TDje4I5fY2tzIcA8/0hwOYvyUpwZ5MBooz7k=
Date:   Thu, 29 Oct 2020 14:56:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     trix@redhat.com
Cc:     paul@crapouillou.net, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio/adc: ingenic: remove unneeded semicolon
Message-ID: <20201029145639.4f9ad714@archlinux>
In-Reply-To: <20201027201128.1597230-1-trix@redhat.com>
References: <20201027201128.1597230-1-trix@redhat.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Oct 2020 13:11:28 -0700
trix@redhat.com wrote:

> From: Tom Rix <trix@redhat.com>
> 
> A semicolon is not needed after a switch statement.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
Hi Tom,

Ideally this set of similar patches in one subsystem would have been as a series.
Makes it easier to pick up with b4 and I'm lazy ;)

Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ingenic-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
> index 92b25083e23f..7886cdca5a5e 100644
> --- a/drivers/iio/adc/ingenic-adc.c
> +++ b/drivers/iio/adc/ingenic-adc.c
> @@ -542,7 +542,7 @@ static int ingenic_adc_read_avail(struct iio_dev *iio_dev,
>  		return IIO_AVAIL_LIST;
>  	default:
>  		return -EINVAL;
> -	};
> +	}
>  }
>  
>  static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,

