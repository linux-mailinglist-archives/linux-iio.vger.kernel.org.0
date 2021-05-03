Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A815D371428
	for <lists+linux-iio@lfdr.de>; Mon,  3 May 2021 13:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhECLUC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 May 2021 07:20:02 -0400
Received: from first.geanix.com ([116.203.34.67]:60644 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230137AbhECLUC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 3 May 2021 07:20:02 -0400
Received: from [192.168.16.65] (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id EBA3D464A60;
        Mon,  3 May 2021 11:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1620040747; bh=kXB3YCcK/ylnbe65GLDLYyntmUOPk461VKrm6Flz6d4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Hq+plliBuBQo0GueimTwMoREegtOdDMad0kQzMqS4k1lDrRy7FpaY40ewrCDpN6V0
         HhFx8//lAT8WK/Gankn5e6Lh3c0Jtuj4CAbE+rKtYxqqzFuB9tI1dw5YrNIMgVem3Y
         NC8mm3k32a3t1qUEGcFhNC2hgGxUnnVO9WNRPpQ6UM6r9WuJGiHsZ4e+ghwxyQsbKE
         +gcE6I4aK8M5h+5SHH2Pa75u2fSMBI6vLi5UFjXkY0WuLzpJyf5ZkLlYFio1sS+eMN
         CKAaCjPcEtWOaObcJmzYq6gNzbvSN0Eg8szzJMftngYfv/9uIJOvlfHWswNp1hJHkG
         dFTp7n3MTr7vA==
Subject: Re: [PATCH v4 4/6] iio: accel: fxls8962af: add interrupt support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <Nuno.Sa@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20210429122806.3814330-1-sean@geanix.com>
 <20210429122806.3814330-4-sean@geanix.com>
 <CAHp75Vf7-5EOpsP8u4rfcjceoKFwQH+U90+JazsLJvmARXmEBQ@mail.gmail.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <388cae14-e138-554c-5def-30cc6d16af86@geanix.com>
Date:   Mon, 3 May 2021 13:19:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf7-5EOpsP8u4rfcjceoKFwQH+U90+JazsLJvmARXmEBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 30/04/2021 11.02, Andy Shevchenko wrote:
>> +#include <linux/of_irq.h>
> See below.
> 
> ...
> 
>> +static irqreturn_t fxls8962af_interrupt(int irq, void *p)
>> +{
>> +       struct iio_dev *indio_dev = p;
>> +       struct fxls8962af_data *data = iio_priv(indio_dev);
>> +       unsigned int reg;
>> +       int ret;
>> +
>> +       ret = regmap_read(data->regmap, FXLS8962AF_INT_STATUS, &reg);
>> +       if (ret < 0)
>> +               return IRQ_NONE;
>> +
>> +       return IRQ_NONE;
> And how is it handled?
> 

Interrupt from the accelerometer is not enabled in this patch.
So there is nothing to handle :)
Interrupts are enabled and handled in:
"[PATCH v4 5/6] iio: accel: fxls8962af: add hw buffered sampling"

/Sean
