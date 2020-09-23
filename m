Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E592761A1
	for <lists+linux-iio@lfdr.de>; Wed, 23 Sep 2020 22:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIWUGB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Sep 2020 16:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgIWUGB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 23 Sep 2020 16:06:01 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DF40206DB;
        Wed, 23 Sep 2020 20:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600891560;
        bh=P/Z2necY07Wz6Baq+W3uxRHx6slSf38PO8zGHsLwcS4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nzgqPtt42u218JCc901I5DC3rw2NIxAsIzkVV0C1TVEGQftwkwu3xrEbnGtjGV/4B
         G5zMWvrc3tuF/tf8oLtC5/HWHnkz3F61d3K82gyAh9imvjPilACIKS08AwRcSeZtBf
         yhP1IvZZGgSfPEAsbNy3fGJG41o2C42cZ1BPGqug=
Date:   Wed, 23 Sep 2020 21:05:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: fix spellint typo in comments
Message-ID: <20200923210556.4a940355@archlinux>
In-Reply-To: <1600772818-30882-1-git-send-email-wangqing@vivo.com>
References: <1600772818-30882-1-git-send-email-wangqing@vivo.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 22 Sep 2020 19:06:56 +0800
Wang Qing <wangqing@vivo.com> wrote:

> Change the comment typo: "definately" -> "definitely".
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
Applied.  Thanks,

Jonathan

> ---
>  drivers/iio/light/gp2ap002.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
> index d5e1cd2..7ba7aa5
> --- a/drivers/iio/light/gp2ap002.c
> +++ b/drivers/iio/light/gp2ap002.c
> @@ -566,7 +566,7 @@ static int gp2ap002_probe(struct i2c_client *client,
>  
>  	/*
>  	 * Initialize the device and signal to runtime PM that now we are
> -	 * definately up and using power.
> +	 * definitely up and using power.
>  	 */
>  	ret = gp2ap002_init(gp2ap002);
>  	if (ret) {

