Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01508256890
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 17:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgH2PTF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 11:19:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbgH2PTF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 11:19:05 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4C9420707;
        Sat, 29 Aug 2020 15:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598714344;
        bh=W2rbE6VHPAeW5y9cyufi3o4ecuRWRqU4vfDN60Cd1Eo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MuV4H3U+lnd2WVXNlFvCKb8DKDawjKxe9L6RwkYvW1ZUtj17fBsN8ccbZi9ZVG7d+
         TRqJwFs7rPJdH61gDZ24LsLqoYsRwByiwurE4K4FoDt72iRKyQE2zIjabwyJYuKxFS
         N2NnYchYulNC6q6C8/MM0D6ygN9l+NcI9y204Xew=
Date:   Sat, 29 Aug 2020 16:19:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        michal.simek@xilinx.com, git@xilinx.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        anandash@xilinx.com
Subject: Re: [PATCH v2] iio: core: Fix IIO_VAL_FRACTIONAL calculation for
 negative values
Message-ID: <20200829161900.713541cd@archlinux>
In-Reply-To: <1598465676-28912-1-git-send-email-anand.ashok.dumbre@xilinx.com>
References: <1598465676-28912-1-git-send-email-anand.ashok.dumbre@xilinx.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 Aug 2020 11:14:36 -0700
Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com> wrote:

> Fixes IIO_VAL_FRACTIONAL for case when the result is negative and
> exponent is 0.
> 
> example: if the result is -0.75, tmp0 will be 0 and tmp1 = 75
> This causes the output to lose sign because of %d in snprintf
> which works for tmp0 <= -1.
> 
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>

Looks good.  Just one last thing.

Is this actually hit in an existing driver?  I'm just wondering
how far back we need to push it in stable etc.

Thanks,

Jonathan

> ---
> changes since v1:
> 	Changed -%d to -0 to make the fix clearer.
> 	Removed the email footer.
> 	Updated the commit description with an example
> --
>  drivers/iio/industrialio-core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index cdcd16f1..a239fa2 100644
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
>  		tmp0 = (int)div_s64_rem(tmp, 1000000000, &tmp1);
> -		return scnprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
> +		if ((tmp2 < 0) && (tmp0 == 0))
> +			return snprintf(buf, len, "-0.%09u", abs(tmp1));
> +		else
> +			return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
>  	case IIO_VAL_FRACTIONAL_LOG2:
>  		tmp = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
>  		tmp0 = (int)div_s64_rem(tmp, 1000000000LL, &tmp1);

