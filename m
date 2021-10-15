Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786C342F4A1
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 16:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbhJOODA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 10:03:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3982 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239577AbhJOODA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 10:03:00 -0400
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HW79d3SY5z67blg;
        Fri, 15 Oct 2021 21:56:53 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 16:00:51 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 15 Oct
 2021 15:00:50 +0100
Date:   Fri, 15 Oct 2021 15:00:49 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, <linux-iio@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 26/48] mfd: ti_am335x_tscadc: Drop unused definitions
 from the header
Message-ID: <20211015150049.0000673b@Huawei.com>
In-Reply-To: <20211015081506.933180-27-miquel.raynal@bootlin.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
        <20211015081506.933180-27-miquel.raynal@bootlin.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Oct 2021 10:14:44 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> The STEP ENABLE definitions are highly unclear and not used so drop them.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks for tidying that up.

> ---
>  include/linux/mfd/ti_am335x_tscadc.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index a85643677bef..1cd8cd34f2b7 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -39,13 +39,6 @@
>  /* IRQ wakeup enable */
>  #define IRQWKUP_ENB		BIT(0)
>  
> -/* Step Enable */
> -#define STEPENB_MASK		(0x1FFFF << 0)
> -#define STEPENB(val)		((val) << 0)
> -#define ENB(val)		(1 << (val))
> -#define STPENB_STEPENB		STEPENB(0x1FFFF)
> -#define STPENB_STEPENB_TC	STEPENB(0x1FFF)
> -
>  /* IRQ enable */
>  #define IRQENB_HW_PEN		BIT(0)
>  #define IRQENB_EOS		BIT(1)

