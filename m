Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3455224C9A
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgGRPlL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPlL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:41:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5658920734;
        Sat, 18 Jul 2020 15:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595086871;
        bh=gRMgGwf57TpWPzv7Fbg6pSq51jgQkkjsG4BSEsJTtiY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vhDKfOeAWLe7UDWWcA5aD5lJ/VBnc9BydNt3VYm9OIhzCnGxATwCWVwx8aYxE37X3
         CatwSYJfcNL2pmKQtMJTftAS+nrL6BurvAaApoKVF6oXL/ZndRLeCU/i0Czf6m0wIt
         ++w4xCYAHFneoj3m0+gONsZfOlTTd9vJ+1Wrq7lg=
Date:   Sat, 18 Jul 2020 16:41:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        David Veenstra <davidjulianveenstra@gmail.com>,
        Graff Yang <graff.yang@gmail.com>
Subject: Re: [PATCH 08/30] iio: resolver: ad2s1200: Change ordering of
 compiler attribute macro
Message-ID: <20200718164106.5e57f276@archlinux>
In-Reply-To: <20200717165538.3275050-9-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-9-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:16 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc gets confused if the variable does not follow the
> type/attribute definitions.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/resolver/ad2s1200.c:44: warning: Function parameter or member '____cacheline_aligned' not described in 'ad2s1200_state'
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: David Veenstra <davidjulianveenstra@gmail.com>
> Cc: Graff Yang <graff.yang@gmail.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Holding this for now whilst we discuss whether to just fix it in
the kernel-doc script.

J
> ---
>  drivers/iio/resolver/ad2s1200.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/resolver/ad2s1200.c b/drivers/iio/resolver/ad2s1200.c
> index a391f46ee06b7..29cfd57eff9e7 100644
> --- a/drivers/iio/resolver/ad2s1200.c
> +++ b/drivers/iio/resolver/ad2s1200.c
> @@ -40,7 +40,7 @@ struct ad2s1200_state {
>  	struct spi_device *sdev;
>  	struct gpio_desc *sample;
>  	struct gpio_desc *rdvel;
> -	__be16 rx ____cacheline_aligned;
> +	__be16 ____cacheline_aligned rx;
>  };
>  
>  static int ad2s1200_read_raw(struct iio_dev *indio_dev,

