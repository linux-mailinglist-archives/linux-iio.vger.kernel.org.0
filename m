Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5540115BBA
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2019 10:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfLGJjc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Dec 2019 04:39:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfLGJjb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Dec 2019 04:39:31 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43E822173E;
        Sat,  7 Dec 2019 09:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575711571;
        bh=3oxFgfcVwBJYgbQuUqLTNEyrtcwoU4bjFGfXR2SFFEs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yihPvVCN94W7tknNhFFbDbQLZS8GmZsu/fEl2xKp8H5s7RJ8Xx9cLSSYXiBCLFaA2
         bilrK8eig6JGhE5OahFJbTyeRW+nT0P3pBOoRiTLFPSTaAB2NgjvZGgTII1gt7cPAI
         xiMQVPYi4Bj42XfHFzzLBKQlhEooVpiThlKPKGuM=
Date:   Sat, 7 Dec 2019 09:39:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: ad2s1200: Drop legacy include
Message-ID: <20191207093926.4e1df45e@archlinux>
In-Reply-To: <20191202082301.62599-1-linus.walleij@linaro.org>
References: <20191202082301.62599-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  2 Dec 2019 09:23:01 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> This driver is using the GPIO descriptor API but yet includes
> the legacy <linux/gpio.h> header for no reason. Drop the
> surplus include.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to have fun.

THanks,

Jonathan

> ---
>  drivers/iio/resolver/ad2s1200.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/resolver/ad2s1200.c b/drivers/iio/resolver/ad2s1200.c
> index 17b89623418c..a391f46ee06b 100644
> --- a/drivers/iio/resolver/ad2s1200.c
> +++ b/drivers/iio/resolver/ad2s1200.c
> @@ -10,7 +10,6 @@
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> -#include <linux/gpio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>

