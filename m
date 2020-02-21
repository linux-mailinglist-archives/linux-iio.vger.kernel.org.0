Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD087167E0B
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 14:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgBUNJu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 08:09:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbgBUNJt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 08:09:49 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FB672073A;
        Fri, 21 Feb 2020 13:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582290589;
        bh=x5dOhvzHSc8beGLE+9gDETJ0R/m5PPi0qfK+oDIEYww=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HVh8kJpmpuqQ1D1wq6/C2x7vvemNAjZU8ObMOq47fjSfzZiB8XaZSudlIwhY6SuSi
         2uaXPFAXV3rAXPw9Kvit8Y0l2+XUsdUL5PqsGhOxQvH2nujJV8Vc4iaYLvcTUyvCtB
         w7c2qqIkNWlbFvayAUIgNuU9NnitY9ERzIWMI1Ns=
Date:   Fri, 21 Feb 2020 13:09:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: adxl372: Set iio_chan BE
Message-ID: <20200221130945.3b0111dd@archlinux>
In-Reply-To: <20200219143112.25976-1-alexandru.tachici@analog.com>
References: <20200219143112.25976-1-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Feb 2020 16:31:12 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> Data stored in the iio-buffer is BE and this
> should be specified in the iio_chan_spec struct.
> 
> Fixes: f4f55ce38e5f8 ("iio:adxl372: Add FIFO and interrupts support")
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adxl372.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 9c6eebf379ca..3eb413df3c8d 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -237,6 +237,7 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
>  		.realbits = 12,						\
>  		.storagebits = 16,					\
>  		.shift = 4,						\
> +		.endianness = IIO_BE,					\
>  	},								\
>  }
>  

