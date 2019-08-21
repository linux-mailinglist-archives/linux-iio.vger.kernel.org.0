Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 511B598540
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2019 22:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfHUUJ0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Aug 2019 16:09:26 -0400
Received: from www381.your-server.de ([78.46.137.84]:38792 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfHUUJ0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Aug 2019 16:09:26 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1i0Wv4-0004sC-KZ; Wed, 21 Aug 2019 22:09:22 +0200
Received: from [93.104.96.205] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1i0Wv4-0006yU-D3; Wed, 21 Aug 2019 22:09:22 +0200
Subject: Re: [PATCH 1/1] iio: core: Fix fractional format generation
To:     Alexander Stein <alexander.stein@systec-electronic.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190821155023.6333-1-alexander.stein@systec-electronic.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <0a9920f8-8546-1138-78d8-755f0a43c930@metafoo.de>
Date:   Wed, 21 Aug 2019 22:09:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821155023.6333-1-alexander.stein@systec-electronic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.3/25548/Wed Aug 21 10:27:18 2019)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/21/19 5:50 PM, Alexander Stein wrote:
> In case the result is -0.3252 tmp0 is 0 after the div_s64_rem, so tmp0 is
> non-negative which results in an output of 0.3252.
> Fix this by explicitly handling the negative sign ourselves.

Hi,

Thanks for you patch. Some comments inline.

> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
>  drivers/iio/industrialio-core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 245b5844028d..18350c1959ae 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -568,6 +568,7 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
>  {
>  	unsigned long long tmp;
>  	int tmp0, tmp1;
> +	const char *sign = vals[0] < 0 ? "-" : "";
>  	bool scale_db = false;
>  
>  	switch (type) {
> @@ -593,11 +594,11 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
>  		tmp = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
>  		tmp1 = vals[1];
>  		tmp0 = (int)div_s64_rem(tmp, 1000000000, &tmp1);
> -		return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
> +		return snprintf(buf, len, "%s%u.%09u", sign, abs(tmp0), abs(tmp1));

I think this breaks the case where vals[1] is negative, but vals[0] is
positive. Maybe we can use a similar approach as for
IIO_VAL_INT_PLUS_NANO. Maybe even put this into a small helper function.

>  	case IIO_VAL_FRACTIONAL_LOG2:
>  		tmp = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
>  		tmp0 = (int)div_s64_rem(tmp, 1000000000LL, &tmp1);
> -		return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
> +		return snprintf(buf, len, "%s%u.%09u", sign, abs(tmp0), abs(tmp1));
>  	case IIO_VAL_INT_MULTIPLE:
>  	{
>  		int i;
> 

