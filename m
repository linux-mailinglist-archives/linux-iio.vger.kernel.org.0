Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA2715D79E
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 13:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgBNMrQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 07:47:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbgBNMrP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 07:47:15 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D3AC20675;
        Fri, 14 Feb 2020 12:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581684435;
        bh=nGHcZeLEc8JzgZrdyhDdZUKrqvwbSxdLiogLT4ZcRP8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C5JK862a2NePQDap8pa4EdH/89REDZ7QdhkQsOoqOl+W38SRAq7VkXGt/eEPYB4Iz
         2X0DEzI1Q4uS0NS1hgoXYezRDsMN8ytJqxxLOdFxOTChPiad4S36cM3TDG+T+jeCYo
         Io1TXgtJEKNSFm1v9mtqxiNPJUehpxzBTiAETaMc=
Date:   Fri, 14 Feb 2020 12:47:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <vilhelm.gray@gmail.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <benjamin.gaignard@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] counter: stm32-timer-cnt: remove iio headers
Message-ID: <20200214124710.758215e3@archlinux>
In-Reply-To: <1581418566-31954-1-git-send-email-fabrice.gasnier@st.com>
References: <1581418566-31954-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Feb 2020 11:56:06 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> The stm32-timer-cnt driver doesn't use the iio interface. The iio headers
> aren't relevant and can be removed as reported by William in [1].
> With this change, mod_devicetable.h needs to be added to define the
> 'of_device_id' struct.
> 
> [1] https://lkml.org/lkml/2020/2/10/1516
> 
> Reported-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied.

thanks,

Jonathan

> ---
> Note this applies on top of:
> - "counter: stm32-timer-cnt: add power management support"
> ---
>  drivers/counter/stm32-timer-cnt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> index 50496f4..ef2a974 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -8,9 +8,8 @@
>   *
>   */
>  #include <linux/counter.h>
> -#include <linux/iio/iio.h>
> -#include <linux/iio/types.h>
>  #include <linux/mfd/stm32-timers.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>

