Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494B736D612
	for <lists+linux-iio@lfdr.de>; Wed, 28 Apr 2021 13:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239567AbhD1LG1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Apr 2021 07:06:27 -0400
Received: from first.geanix.com ([116.203.34.67]:36360 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238997AbhD1LG0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 28 Apr 2021 07:06:26 -0400
Received: from [192.168.64.189] (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 38A1B466030;
        Wed, 28 Apr 2021 11:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1619607939; bh=aFMfEnlUEnd5TUNCfKoBaXBxYMlU0Il7i9gQLT3zy/U=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=mifhXFFnZI4mCuN70nZxAzyIH0610QTWm9EaVdxkXsrjHkY55eyJLJ2QPjUhV3mWx
         k0N9+s4HB34STwKVGeFdpljoHpEM2t3sNUFCykijGDMGaA/uwyNVdAJvxdJg7O55Kj
         dp88V3ldAtC3W4lttD3onXLNxY37Nm05D0yRl1tJ6DMlf/F56zgDig52BQq8xzgAqB
         hjjEwBh3qQFnL9eI2Xc4ZCQJLZIU+IJKpPPePX5uYnerMUufQ4b6nYWoxPb7XZvW6j
         IuSGyQCQRyfQ9Z4HhC1ZnqK1aief9pUeL9n2Dlq8I9wMLRRNUg1CUQ4pdEavya46OA
         F7DVCP4pGXfQQ==
Subject: Re: [RFC PATCH 3/4] iio: accel: fxls8962af: add hw buffered sampling
To:     jic23@kernel.org, linux-iio@vger.kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de, Nuno.Sa@analog.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20210428082203.3587022-1-sean@geanix.com>
 <20210428082203.3587022-3-sean@geanix.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <d536b4ab-eaa5-5411-9b68-266b7a8a56b6@geanix.com>
Date:   Wed, 28 Apr 2021 13:05:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210428082203.3587022-3-sean@geanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 28/04/2021 10.22, Sean Nyekjaer wrote:
> |@@ -433,7 +450,10 @@ static int fxls8962af_read_raw(struct iio_dev 
> *indio_dev, ret = fxls8962af_get_temp(data, val); break; case 
> IIO_ACCEL: - ret = fxls8962af_get_axis(data, chan, val); + if 
> (iio_buffer_enabled(indio_dev))|
|Seeing the iio_device_claim_direct_mode() is doing exactly the same 
check :)|
> |+ ret = -EBUSY; + else + ret = fxls8962af_get_axis(data, chan, val); 
> break; default: ret = -EINVAL;|

