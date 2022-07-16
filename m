Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549B6577002
	for <lists+linux-iio@lfdr.de>; Sat, 16 Jul 2022 17:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiGPP7k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Jul 2022 11:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiGPP7j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jul 2022 11:59:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEEC13D35
        for <linux-iio@vger.kernel.org>; Sat, 16 Jul 2022 08:59:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EBC3B80AD9
        for <linux-iio@vger.kernel.org>; Sat, 16 Jul 2022 15:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB13C34114;
        Sat, 16 Jul 2022 15:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657987176;
        bh=bjAj6ywOCqzk36/YcJE045pDcW8kApwOFp2Oi1zV8W8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fNa4yetFXqqE7LZXm3q5Z8L+PwtoE9Djmg10zUe7k4MlDdwNgO4vUWpNWrW18mORb
         nJHfNtu9Ep9s5mNleXvE872u09SYJfif32RVC05sReeAEm6hTpTZc+scqfhJ4EmQ3i
         7fhOwJt0RFaTq7KvAFaIq0gRmbpaVwEtL8e7oqLQWEgOTstBN0ozQ0IxAjz6GiA+DZ
         ol2PiZ5EBiJGzlevi4bIz/PTkHGVsrmTr1AXyhg9xFHA2/YnnMaWHjbmkHkPXF+EN4
         OSoGsuni7FiR6xnUkl/fj02igQKTfveIcUVrjaygjQqbyeldS6NgC+M+7Fhx981cO7
         INLWXCiL4jiJQ==
Date:   Sat, 16 Jul 2022 17:09:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        Fawzi Khaber <fawzi.khaber@tdk.com>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH] iio: fix iio_format_avail_range() printing for none
 IIO_VAL_INT
Message-ID: <20220716170929.2f358344@jic23-huawei>
In-Reply-To: <20220627193402.21553-1-jmaneyrol@invensense.com>
References: <20220627193402.21553-1-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Jun 2022 21:34:02 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

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

Fixes tag?

Otherwise looks good to me.
> ---
>  drivers/iio/industrialio-core.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 358b909298c0..0f4dbda3b9d3 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -812,7 +812,23 @@ static ssize_t iio_format_avail_list(char *buf, const int *vals,
>  
>  static ssize_t iio_format_avail_range(char *buf, const int *vals, int type)
>  {
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
>  }
>  
>  static ssize_t iio_read_channel_info_avail(struct device *dev,

