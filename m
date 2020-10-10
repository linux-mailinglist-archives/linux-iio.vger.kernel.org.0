Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDD828A25E
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 00:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388035AbgJJW5D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Oct 2020 18:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731361AbgJJTMW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Oct 2020 15:12:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B695422400;
        Sat, 10 Oct 2020 16:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602348861;
        bh=Yd+Ts5zV4Imhr2dlD4CN2STzRAnre/8W1ZiC+y6m/NU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kNWySn40Fc1xgX/LG2i+iwLibfi85Qh8i5IV/OCvtrv/F/ydOQitt1DlIBy4zHPVZ
         iNLKuXTBkFLTB6E2vpilcsc5UZj6jGXofy0/Cmw1S0yDCmt+7rJpMKTQ2j1CnixEA7
         67m5Z0bhjNvdDa78h/RXjXj4uJCNsnc3SzG/jcME=
Date:   Sat, 10 Oct 2020 17:54:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        michal.simek@xilinx.com, git@xilinx.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        anandash@xilinx.com
Subject: Re: [LINUX PATCH v3] iio: core: Fix IIO_VAL_FRACTIONAL calculation
 for negative values
Message-ID: <20201010175415.6e51d873@archlinux>
In-Reply-To: <1601910316-24111-1-git-send-email-anand.ashok.dumbre@xilinx.com>
References: <1601910316-24111-1-git-send-email-anand.ashok.dumbre@xilinx.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  5 Oct 2020 08:05:16 -0700
Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com> wrote:

> Fixes IIO_VAL_FRACTIONAL for case when the result is negative and
> exponent is 0.
> 
> example: if the result is -0.75, tmp0 will be 0 and tmp1 = 75
> This causes the output to lose sign because of %d in snprintf
> which works for tmp0 <= -1.
> 
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> Reported-by: kernel test robot <lkp@intel.com> #error: uninitialized symbol tmp
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
As this doesn't have a fixes tag etc and from v2 discussion was only hit
with a new driver, I'm not currently taking this a a fix.
If people want me to rush it in / backport to stable then let me know

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

Thanks,

Jonathan

> ---
> 
> Changes in v3:
> 	Fixed a bug caught by kernel test robot and used correct variable
> 
> ---
>  drivers/iio/industrialio-core.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index cdcd16f1..ffd5176 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -592,6 +592,7 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
>  {
>  	unsigned long long tmp;
>  	int tmp0, tmp1;
> +	s64 tmp2;
>  	bool scale_db = false;
>  
>  	switch (type) {
> @@ -614,10 +615,13 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
>  		else
>  			return scnprintf(buf, len, "%d.%09u", vals[0], vals[1]);
>  	case IIO_VAL_FRACTIONAL:
> -		tmp = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
> +		tmp2 = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
>  		tmp1 = vals[1];
> -		tmp0 = (int)div_s64_rem(tmp, 1000000000, &tmp1);
> -		return scnprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
> +		tmp0 = (int)div_s64_rem(tmp2, 1000000000, &tmp1);
> +		if ((tmp2 < 0) && (tmp0 == 0))
> +			return snprintf(buf, len, "-0.%09u", abs(tmp1));
> +		else
> +			return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
>  	case IIO_VAL_FRACTIONAL_LOG2:
>  		tmp = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
>  		tmp0 = (int)div_s64_rem(tmp, 1000000000LL, &tmp1);

