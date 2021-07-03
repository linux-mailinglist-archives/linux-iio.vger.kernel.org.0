Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998043BA957
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 18:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbhGCQEV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 12:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhGCQEV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jul 2021 12:04:21 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA84D61628;
        Sat,  3 Jul 2021 16:01:43 +0000 (UTC)
Date:   Sat, 3 Jul 2021 17:04:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, lars@metafoo.de,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, leonard.crestez@nxp.com,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 2/4] mfd: rn5t618: Add of compatibles for ADC and power
Message-ID: <20210703170405.60828c57@jic23-huawei>
In-Reply-To: <20210703084224.31623-3-andreas@kemnade.info>
References: <20210703084224.31623-1-andreas@kemnade.info>
        <20210703084224.31623-3-andreas@kemnade.info>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  3 Jul 2021 10:42:22 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> This allows having devicetree nodes for the subdevices.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/mfd/rn5t618.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
> index 384acb459427..b916c7471ca3 100644
> --- a/drivers/mfd/rn5t618.c
> +++ b/drivers/mfd/rn5t618.c
> @@ -24,8 +24,10 @@ static const struct mfd_cell rn5t618_cells[] = {
>  };
>  
>  static const struct mfd_cell rc5t619_cells[] = {
> -	{ .name = "rn5t618-adc" },
> -	{ .name = "rn5t618-power" },
> +	{ .name = "rn5t618-adc",
> +	  .of_compatible = "ricoh,rc5t619-adc" },

Odd to have a name of 618 and a compatible of 619.  Why?
Definitely deserves a comment if this is necessary for some reason!

> +	{ .name = "rn5t618-power",
> +	  .of_compatible = "ricoh,rc5t619-power" },
>  	{ .name = "rn5t618-regulator" },
>  	{ .name = "rc5t619-rtc" },
>  	{ .name = "rn5t618-wdt" },

