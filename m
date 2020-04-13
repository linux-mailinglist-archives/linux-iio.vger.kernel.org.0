Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2881A68F9
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 17:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgDMPgO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 11:36:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728194AbgDMPgN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Apr 2020 11:36:13 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA5622072C;
        Mon, 13 Apr 2020 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586792173;
        bh=ySJ/GZ+In15NYeLHoiARho05iwPwM96hM78oDSnn3u4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k2i6dfph/vfNL/JUvwdMldgHGQna7KMCx43iJ0B9PPYZKoRGdbusbuGVzC0ZkzgtI
         bZt9ct5xW8bBDEiZ0elrES7yPSglluNUH/YQxJmoV3tyXa/FDS+4ABNXA4bH3fQk/N
         7/bGXJKBPnBjKzo6QjgwwGud7rg617wrjKbPoBcA=
Date:   Mon, 13 Apr 2020 16:36:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Aishwarya R <aishwaryarj100@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Richard Fontana <rfontana@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: at91-adc: Use devm_platform_ioremap_resource
Message-ID: <20200413163607.4fc548a2@archlinux>
In-Reply-To: <20200412135644.4027-1-aishwaryarj100@gmail.com>
References: <20200409151125.32677-1-aishwaryarj100@gmail.com>
        <20200412135644.4027-1-aishwaryarj100@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 12 Apr 2020 19:26:42 +0530
Aishwarya R <aishwaryarj100@gmail.com> wrote:

> From: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>
> 
> Use the helper function that wraps the calls to
> platform_get_resource() and devm_ioremap_resource()
> together. It reduces boilerplate and suggested by coccinelle.
> 
> Signed-off-by: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>
Same comments as the previous patch.  Applied anyway (this time)
mostly because it's quicker for me than insisting on a v3.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91_adc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index abe99856c823..0368b6dc6d60 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -1152,7 +1152,6 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	int ret;
>  	struct iio_dev *idev;
>  	struct at91_adc_state *st;
> -	struct resource *res;
>  	u32 reg;
>  
>  	idev = devm_iio_device_alloc(&pdev->dev, sizeof(struct at91_adc_state));
> @@ -1182,9 +1181,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	if (st->irq < 0)
>  		return -ENODEV;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -
> -	st->reg_base = devm_ioremap_resource(&pdev->dev, res);
> +	st->reg_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(st->reg_base))
>  		return PTR_ERR(st->reg_base);
>  

