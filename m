Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20275185C8F
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 14:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgCONRu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 09:17:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728582AbgCONRu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 09:17:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D9A7205ED;
        Sun, 15 Mar 2020 13:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584278269;
        bh=HeQolw+seE625icIJdWntQTD/5ixC2/595+ZXUUxzU4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xHg/yiCsdMDwE/IcK3czju9q/Az+kTvmsJA/3fqg0dW5VgpjpXUsCN9aucKEORD8V
         zAe4gLYBkhlpRYWq4io+S78FwAkMUipaxdSyOPAcTmDSRldoMdksMHi0w7HNcPJp0M
         2BmsbEziwYyPRTOcW3mJsWHBl43eNEKkrs8eP7Ok=
Date:   Sun, 15 Mar 2020 13:17:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <biabeniamin@outlook.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH 3/4] iio: adc: ad7476: Add AD7091 support
Message-ID: <20200315131745.435e580e@archlinux>
In-Reply-To: <20200311084328.17680-3-beniamin.bia@analog.com>
References: <20200311084328.17680-1-beniamin.bia@analog.com>
        <20200311084328.17680-3-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Mar 2020 10:43:27 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> From: Dragos Bogdan <dragos.bogdan@analog.com>
> 
> AD7091R is already supported by this driver. While AD7091R allows the
> choice of an internal or an external voltage reference, for AD7091 the
> reference is only provided by VDD. Since this information is anyway
> obtained through the "vcc" regulator, no other driver changes are
> required for adding AD7091 support as well.
> 
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7476.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 3b48073dd62d..cd7d42df2033 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -341,6 +341,7 @@ static int ad7476_remove(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id ad7476_id[] = {
> +	{"ad7091", ID_AD7091R},
>  	{"ad7091r", ID_AD7091R},
>  	{"ad7273", ID_AD7277},
>  	{"ad7274", ID_AD7276},

