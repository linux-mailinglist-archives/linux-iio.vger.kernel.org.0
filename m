Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 566B44749C
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2019 15:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfFPNLn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jun 2019 09:11:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfFPNLn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Jun 2019 09:11:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B696020866;
        Sun, 16 Jun 2019 13:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560690702;
        bh=zWOZhjjiwUw9kLTG/2bybfeHap0bYa+9tK3KavN6Ag0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LLrnfsyoPILj/fmVxOAtjvrWnHhRr7Z24BQwVwqhFiXVWpNLcFXua2O27YcPpMvSo
         1mAzyAiMqcKLUWGJh4/IAZcGoQGya3BglEHCwXOgXVqyPedHr1rrL7LoGWHrsRrGP1
         Rrpb1aqrG3TqfpAXo8PdXrJW1hsNfZTHBI6FDFzA=
Date:   Sun, 16 Jun 2019 14:11:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <gregkh@linuxfoundation.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: adt7316: Add missing include files
Message-ID: <20190616141137.254a1291@archlinux>
In-Reply-To: <20190614152846.28108-1-yuehaibing@huawei.com>
References: <20190614152846.28108-1-yuehaibing@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Jun 2019 23:28:46 +0800
YueHaibing <yuehaibing@huawei.com> wrote:

> Fix build error:
> 
> drivers/staging/iio/addac/adt7316.c: In function adt7316_store_update_DAC:
> drivers/staging/iio/addac/adt7316.c:949:3: error: implicit declaration of
>  function gpiod_set_value; did you mean gpio_set_value? [-Werror=implicit-function-declaration]
>    gpiod_set_value(chip->ldac_pin, 0);
> 
> drivers/staging/iio/addac/adt7316.c: In function adt7316_setup_irq:
> drivers/staging/iio/addac/adt7316.c:1807:13: error: implicit declaration of
>  function irqd_get_trigger_type; did you mean devm_iio_trigger_free? [-Werror=implicit-function-declaration]
>   irq_type = irqd_get_trigger_type(irq_get_irq_data(chip->bus.irq));
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 7f6b6d553df7 ("Staging: iio: adt7316: Add all irq related code in adt7316_irq_setup()")
> Fixes: c63460c4298f ("Staging: iio: adt7316: Use device tree data to set ldac_pin")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Hi yuehaibing,

You were second to send a fix for this. I've had it in my
fixes branch since last week, but not done a pull request quite yet.
I'll probably send it out later today.

https://patchwork.kernel.org/patch/10978301/

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 37ce563..9d3d159 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -16,6 +16,8 @@
>  #include <linux/i2c.h>
>  #include <linux/rtc.h>
>  #include <linux/module.h>
> +#include <linux/irq.h>
> +#include <linux/gpio/consumer.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/events.h>

