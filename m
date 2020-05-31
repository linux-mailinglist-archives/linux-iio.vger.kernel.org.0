Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6491E97C4
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 15:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgEaNIA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 09:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgEaNIA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 09:08:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34058206F0;
        Sun, 31 May 2020 13:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590930480;
        bh=LsNZ8MHd00u/idS5b22PlPzpqejEi9Fsz1AxIDrEwOY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pjMsdq/iGuuUsKJCI/ymn7YXbyBbkTq/FFdr4PqxY6eOYuSv6ZPn8hi/qOo7OjaPV
         CClf2j2n48RIJsx7cxj6o7fcgjI49KLO8Hld0XbkbVFEYo7CGHtVKZ61hKmmK6Z+EI
         6n8oP8UBWMonMzvWVZk/ytyKocvZpcJRsnjHdIhU=
Date:   Sun, 31 May 2020 14:07:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] iio: adc: max11100: Constify struct iio_chan_spec
Message-ID: <20200531140756.090f6204@archlinux>
In-Reply-To: <20200526210223.1672-2-rikard.falkeborn@gmail.com>
References: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
        <20200526210223.1672-2-rikard.falkeborn@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 May 2020 23:02:18 +0200
Rikard Falkeborn <rikard.falkeborn@gmail.com> wrote:

> max11100_channels is not modified and can therefore be made const to
> allow the compiler to put it in read-only memory.
> 
> Before:
>    text    data     bss     dec     hex filename
>    3776    1168       0    4944    1350 drivers/iio/adc/max11100.o
> 
> After:
>    text    data     bss     dec     hex filename
>    3968     976       0    4944    1350 drivers/iio/adc/max11100.o
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max11100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
> index 3440539cfdba..b121ca78f851 100644
> --- a/drivers/iio/adc/max11100.c
> +++ b/drivers/iio/adc/max11100.c
> @@ -37,7 +37,7 @@ struct max11100_state {
>  	u8 buffer[3] ____cacheline_aligned;
>  };
>  
> -static struct iio_chan_spec max11100_channels[] = {
> +static const struct iio_chan_spec max11100_channels[] = {
>  	{ /* [0] */
>  		.type = IIO_VOLTAGE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |

