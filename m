Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A622536E4A4
	for <lists+linux-iio@lfdr.de>; Thu, 29 Apr 2021 07:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhD2FyY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Apr 2021 01:54:24 -0400
Received: from first.geanix.com ([116.203.34.67]:36028 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhD2FyY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Apr 2021 01:54:24 -0400
Received: from [192.168.64.189] (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id E53224660FB;
        Thu, 29 Apr 2021 05:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1619675616; bh=zSYlWFz2O93WvLrDkXlJ/t/irAYSXtm5kijIeiKmvHM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iSmrfln6r3QVg/K1qv4Q3EmJ9TKnSNwuEm51c2K3jtc0RrBtCPnT7ImFxQoCW2kK/
         J1k7HJ+2P7YVPXkgdh0VbAbmHdn2SylGSUd6KqVYmfjMlbKvQcN5MCDWqUXmhm6MoL
         EicGsbwnVVYL+jG//3/oyU8Ht9Pm4TCQQchq5sredbH5iHfMe8pHb23XBHTeW78AJ+
         X719gKtPhK9ajJN8qvwT3c+jvwiWGVGIdjzaN+IDqb53bgtBTc8O+ayM5rE5HDp8g5
         QrfVDxca7lEcFo/67xyRu0ULnMkGpSXzJZ+JtNt/Piadr4tceWUagG2CBer99an5pg
         2kd/jyJ/hA1oA==
Subject: Re: [PATCH v3 1/2] iio: accel: add support for FXLS8962AF/FXLS8964AF
 accelerometers
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de, Nuno.Sa@analog.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20210428080107.3584120-1-sean@geanix.com>
 <20210428151925.000015e3@Huawei.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <b1529522-6fc9-ad01-e05c-5b8d4c8364f1@geanix.com>
Date:   Thu, 29 Apr 2021 07:53:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210428151925.000015e3@Huawei.com>
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



On 28/04/2021 16.19, Jonathan Cameron wrote:
>> +static int fxls8962af_get_temp(struct fxls8962af_data *data, int *val)
>> +{
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	unsigned int value;
>> +	int ret;
>> +
>> +	ret = fxls8962af_drdy(data);
> I'm a little confused.  You check data is ready before calling power on
> which could result in you moving from standby to active state?
>
>
Reading it again, I would definitively move it around :)
When testing it looks like we currently are getting the last sample from 
active state.

/Sean
