Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518925186B3
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 16:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbiECOds (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 10:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237079AbiECOdr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 10:33:47 -0400
X-Greylist: delayed 429 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 May 2022 07:30:13 PDT
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48C61107
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 07:30:13 -0700 (PDT)
Message-ID: <8f16b39c-b20c-fc68-aa16-2df9c3b65c6e@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1651587783;
        bh=MIydjD9KEhWv1uqyMSAgNp/QDkROZvwgXFiugvhd4R8=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding:From:Subject:To:
         Date:Sender:Content-Type:Content-Transfer-Encoding:
         Content-Disposition:Mime-Version:Reply-To:In-Reply-To:References:
         Message-Id:Autocrypt;
        b=kNd48eLSE89lIJyGXl00qTuBcPHQpw1UO+HkGT4ailV/9Lbkc0Um9aU8oJ8zpf4hc
         SKEiwUULAk4ebnmfRKLIM55PkjYWvPF7KTqG3/9GRLExZKaHvfpfRE8XxqB9LowgYy
         PK0NU+keioa7fP8C2aUgRjBfFg0MDkyQDsvROEVzriASjmdSIMAdey6yIdZ6+ywMDq
         VCBfTps4cuGP4wraJ3rfG9MYC0LaBdRikuojDiynXKb9O5aOQmA6xuiEPVaiQPbllT
         iZiVituFkAMbRfMhdEV7opuaVFFaF1x+wGx9I5Kslei9bJUS63ySyr8gC5q+c744uT
         rpyVuUIBf0TDQ==
Date:   Tue, 3 May 2022 17:23:02 +0300
MIME-Version: 1.0
Subject: Re: [PATCH 26/92] iio: adc: max1241: Fix alignment for DMA safety
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <20220503085935.1533814-1-jic23@kernel.org>
 <20220503085935.1533814-27-jic23@kernel.org>
From:   Alexandru Lazar <alazar@startmail.com>
In-Reply-To: <20220503085935.1533814-27-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 5/3/2022 11:58 AM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ____cacheline_aligned is an insufficient guarantee for non-coherent DMA
> on platforms with 128 byte cachelines above L1.  Switch to the updated
> IIO_ALIGN definition.
> 
> Fixes: 8a80a71d9020 ("iio: adc: Add MAX1241 driver")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Alexandru Lazar <alazar@startmail.com>
> ---
>   drivers/iio/adc/max1241.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max1241.c b/drivers/iio/adc/max1241.c
> index a5afd84af58b..e3dbcc2e4e77 100644
> --- a/drivers/iio/adc/max1241.c
> +++ b/drivers/iio/adc/max1241.c
> @@ -26,7 +26,7 @@ struct max1241 {
>   	struct regulator *vref;
>   	struct gpio_desc *shutdown;
>   
> -	__be16 data ____cacheline_aligned;
> +	__be16 data __aligned(IIO_ALIGN);
>   };
>   
>   static const struct iio_chan_spec max1241_channels[] = {

Looks good, I think we can call this

Acked-by: Alexandru Lazar <alazar@startmail.com>

Thanks!

In addition to that, I also think the changes in max1118 and max1027 are 
OK but I can't test either of them so take this with a grain of salt.

All the best,
Alex

(P.S. Fingers crossed that Thunderbird doesn't screw this up, I'm 
nowhere near my development machine for the next two weeks :-( . 
Apologies if it does!)
