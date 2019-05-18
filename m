Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2699122341
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 12:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfERKfe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 06:35:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfERKfe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 May 2019 06:35:34 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A4782087E;
        Sat, 18 May 2019 10:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558175733;
        bh=rguySsEOq+x1PGhSAfvkomBO3m+7PPVtFbTny4CxQvk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cOVT/saTJsx+a5tobw3SyYPMSJhf//2/uGEpTPTOKcllnYJ6Yf5yMDiz7P38DgrXa
         Bm/lQx8yBCEvwrau2ItFfNCPKUsy1Mzc2qyOmjzBeIOEgvUXYi9stJX2Mxb5FPd4ob
         XgeKGurk1c+phpe1Ph98kgE8CNRTJaaERC3L6CFE=
Date:   Sat, 18 May 2019 11:35:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chun-Hung Wu <chun-hung.wu@mediatek.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <peter.wang@mediatek.com>, <kuohong.wang@mediatek.com>,
        <jg_poxu@mediatek.com>
Subject: Re: [PATCH 3/4] iio: adc: mediatek: SET_LATE_SYSTEM_SLEEP_PM_OPS
 support
Message-ID: <20190518113527.5210b0bf@archlinux>
In-Reply-To: <1557994247-16739-4-git-send-email-chun-hung.wu@mediatek.com>
References: <1557994247-16739-1-git-send-email-chun-hung.wu@mediatek.com>
        <1557994247-16739-4-git-send-email-chun-hung.wu@mediatek.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 May 2019 16:10:46 +0800
Chun-Hung Wu <chun-hung.wu@mediatek.com> wrote:

>   Move suspend/resume to late_suspend and
> early_resume to gurantee users can use auxadc
guarantee

> driver at suspend/resume stage.
No problem with the patch content, but we need a reason why they may
want to do so?

Thanks,

Jonathan
> 
> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> ---
>  drivers/iio/adc/mt6577_auxadc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index e1bdcc0..58d7cb2 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -326,9 +326,10 @@ static int mt6577_auxadc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(mt6577_auxadc_pm_ops,
> -			 mt6577_auxadc_suspend,
> -			 mt6577_auxadc_resume);
> +static const struct dev_pm_ops mt6577_auxadc_pm_ops = {
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(mt6577_auxadc_suspend,
> +				     mt6577_auxadc_resume)
> +};
>  
>  static const struct of_device_id mt6577_auxadc_of_match[] = {
>  	{ .compatible = "mediatek,mt2701-auxadc", .data = &mt8173_compat},

