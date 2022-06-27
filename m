Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A9C55CF54
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbiF0WIZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jun 2022 18:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242679AbiF0WHz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2022 18:07:55 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411F91E3FA
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2022 15:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=EKAxXLruVZ47KMOGk77Qd7WK2xozBrejaq0+lva205w=; b=BayINbs+sm8pxj3g8oXaG5k4k0
        mcu2mwZJCZtn/a8EcaMV6pBJnZrKIaqLntcvMaKbuuaTv7A1FGtub3UZpHA+qIv8rxqneScugr68+
        0kKbt0UBF21fKBs3amWfeoo3lOS1I5BkMcxo9EPMkYUysizH0SdwhWA7lqdSti/fP+Ik9pqyr5T5Z
        Uj12eXyz9YIK+gj3Duf+63R1WC7CWBe55FyUBrR8SL5ZMIROAeRAx3tPMZJMyD0VgxPd0jC/aDBvr
        i+bCkYR0BrrOH3R/2yrB9m4MhqxB2tbLt7EO7VrE87pYYVLw5qayAIlCMugRJ+Ng7z0AP4NSDUAup
        uRn/mjZA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1o5wsP-0006uR-8W; Tue, 28 Jun 2022 00:06:37 +0200
Received: from [2001:a61:2a49:8301:9e5c:8eff:fe01:8578]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1o5wsP-000V1x-3A; Tue, 28 Jun 2022 00:06:37 +0200
Message-ID: <fde8b70b-a8c8-3e70-b55d-beede2bd7040@metafoo.de>
Date:   Tue, 28 Jun 2022 00:06:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] iio: fix iio_format_avail_range() printing for none
 IIO_VAL_INT
Content-Language: en-US
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, Fawzi Khaber <fawzi.khaber@tdk.com>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
References: <20220627193402.21553-1-jmaneyrol@invensense.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20220627193402.21553-1-jmaneyrol@invensense.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.6/26586/Mon Jun 27 10:06:41 2022)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 6/27/22 21:34, Jean-Baptiste Maneyrol wrote:
> From: Fawzi Khaber <fawzi.khaber@tdk.com>
>
> iio_format_avail_range() should print range as follow [min, step, max], so
> the function was previously calling iio_format_list() with length = 3,
> length variable refers to the array size of values not the number of
> elements. In case of non IIO_VAL_INT values each element has integer part
> and decimal part. With length = 3 this would cause premature end of loop
> and result in printing only one element.
>
> Signed-off-by: Fawzi Khaber <fawzi.khaber@tdk.com>
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> ---
>   drivers/iio/industrialio-core.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 358b909298c0..0f4dbda3b9d3 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -812,7 +812,23 @@ static ssize_t iio_format_avail_list(char *buf, const int *vals,
>   
>   static ssize_t iio_format_avail_range(char *buf, const int *vals, int type)
>   {
> -	return iio_format_list(buf, vals, type, 3, "[", "]");
> +	int length;
> +
> +	/*
> +	 * length refers to the array size , not the number of elements.
> +	 * The purpose is to print the range [min , step ,max] so length should
> +	 * be 3 in case of int, and 6 for other types.
> +	 */
> +	switch (type) {
> +	case IIO_VAL_INT:
> +		length = 3;
> +		break;
> +	default:
> +		length = 6;
> +		break;
> +	}
> +
> +	return iio_format_list(buf, vals, type, length, "[", "]");
>   }
>   
>   static ssize_t iio_read_channel_info_avail(struct device *dev,

Change looks good! Lets also add a unit test for this in iio-test-format.c

