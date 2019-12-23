Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 310BD1298BD
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 17:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfLWQeK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 11:34:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbfLWQeK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 11:34:10 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1477620663;
        Mon, 23 Dec 2019 16:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577118849;
        bh=hqhFk3w8zw+TLBSiP+m5sgLeq7J7E5pbm7SpAEzkrk8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QylS0lLDLCI/84CTFSftcDYt3oiuA+Xa8CyyWUsK3C1rZFHBRyag5kffkqlVGsfw8
         Kvfgt3MAlT7l6FGzrboX0O+hGLRAh/Qb0vidP6iMFwCBoA4llx4fLXhTBgNaXMhHaG
         iIGBY66KyR9FgJ4KEaj+9R+7OfGooEV6k69N1iiU=
Date:   Mon, 23 Dec 2019 16:34:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: light: remove unneeded semicolon
Message-ID: <20191223163406.33fe6673@archlinux>
In-Reply-To: <20191216105101.7200-1-chenzhou10@huawei.com>
References: <20191216105101.7200-1-chenzhou10@huawei.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Dec 2019 18:51:01 +0800
Chen Zhou <chenzhou10@huawei.com> wrote:

> Fixes coccicheck warning:
> 
> ./drivers/iio/light/lm3533-als.c:745:2-3: Unneeded semicolon
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders poke at the various other patches.

Thanks,

Jonathan

> ---
>  drivers/iio/light/lm3533-als.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
> index 6733b52..bc196c2 100644
> --- a/drivers/iio/light/lm3533-als.c
> +++ b/drivers/iio/light/lm3533-als.c
> @@ -742,7 +742,7 @@ static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
>  	if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MAX) {
>  		dev_err(&als->pdev->dev, "invalid resistor value\n");
>  		return -EINVAL;
> -	};
> +	}
>  
>  	ret = lm3533_write(als->lm3533, LM3533_REG_ALS_RESISTOR_SELECT, val);
>  	if (ret) {

