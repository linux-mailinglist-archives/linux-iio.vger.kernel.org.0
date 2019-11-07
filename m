Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F705F30C2
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2019 15:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfKGODa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 7 Nov 2019 09:03:30 -0500
Received: from ox4u.de ([212.118.221.216]:54322 "EHLO s1.ox4u.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfKGODa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Nov 2019 09:03:30 -0500
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Nov 2019 09:03:29 EST
Received: by s1.ox4u.de (Postfix, from userid 65534)
        id D9EFB26012A; Thu,  7 Nov 2019 14:54:53 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on s1.ox4u.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED
        autolearn=disabled version=3.4.1
Received: from ws-140106.localnet (unknown [212.185.67.146])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by s1.ox4u.de (Postfix) with ESMTPSA id 0A753260113;
        Thu,  7 Nov 2019 14:54:52 +0100 (CET)
From:   Alexander Stein <alexander.stein@systec-electronic.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iio: core: Fix fractional format generation
Date:   Thu, 07 Nov 2019 14:54:52 +0100
Message-ID: <4116142.9TFg0imz4M@ws-140106>
In-Reply-To: <20190822060607.25339-1-alexander.stein@systec-electronic.com>
References: <20190822060607.25339-1-alexander.stein@systec-electronic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Gentle ping

On Thursday, August 22, 2019, 8:06:07 AM CET Alexander Stein wrote:
> In case the result is -0.3252 tmp0 is 0 after the div_s64_rem, so tmp0 is
> non-negative which results in an output of 0.3252.
> Fix this by explicitly handling the negative sign ourselves.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
> Changes in v2:
> * Support vals[0] >= and vals[1] < 0 in IIO_VAL_FRACTIONAL
> * Note: IIO_VAL_FRACTIONAL is untested, as I lack hardware
> * Note2: Currently IIO_VAL_FRACTIONAL is only called with vals[1] from
>          in-kernel drivers AFAICS
> 
>  drivers/iio/industrialio-core.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 245b5844028d..247338142c87 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -568,6 +568,7 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
>  {
>  	unsigned long long tmp;
>  	int tmp0, tmp1;
> +	char *sign;
>  	bool scale_db = false;
>  
>  	switch (type) {
> @@ -593,11 +594,17 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
>  		tmp = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
>  		tmp1 = vals[1];
>  		tmp0 = (int)div_s64_rem(tmp, 1000000000, &tmp1);
> -		return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
> +		if (vals[1] < 0) {
> +			sign = vals[0] >= 0 ? "-" : "";
> +		} else {
> +			sign = vals[0] < 0 ? "-" : "";
> +		}
> +		return snprintf(buf, len, "%s%u.%09u", sign, abs(tmp0), abs(tmp1));
>  	case IIO_VAL_FRACTIONAL_LOG2:
> +		sign = vals[0] < 0 ? "-" : "";
>  		tmp = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
>  		tmp0 = (int)div_s64_rem(tmp, 1000000000LL, &tmp1);
> -		return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
> +		return snprintf(buf, len, "%s%u.%09u", sign, abs(tmp0), abs(tmp1));
>  	case IIO_VAL_INT_MULTIPLE:
>  	{
>  		int i;
> 


-- 
Dipl-Inf. Alexander Stein

SYS TEC electronic AG
Am Windrad 2
08468 Heinsdorfergrund
Germany
Tel: +49-3765-38600-0, Fax: +49-3765-38600-4100
Email   : alexander.stein@systec-electronic.com
Internet: http://www.systec-electronic.com

Board of Directors: Dipl.-Ing. Ronald Sieber, Dipl.-Ing. Dirk Bause
Chairman of the Supervisory Board: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 32220; USt.-Id Nr. 
DE150534010

--------------------------------------------------------------------------

Diese E-Mail enthält vertrauliche und/oder rechtlich geschützte 
Informationen.

Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrtümlich 
erhalten haben, informieren Sie bitte sofort den Absender und vernichten 
Sie diese Mail.

Das unerlaubte Kopieren sowie die unbefugte Weitergabe dieser Mail sind 
nicht gestattet.

--------------------------------------------------------------------------

This e-mail may contain confidential and/or privileged information.

If you are not the intended recipient (or have received this e-mail in 
error) please notify the sender immediately and destroy this e-mail.

Any unauthorized copying, disclosure or distribution of the material in 
this e-mail is strictly forbidden.

--------------------------------------------------------------------------


