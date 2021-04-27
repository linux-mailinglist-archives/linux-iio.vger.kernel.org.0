Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A4736C868
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 17:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbhD0PMh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 11:12:37 -0400
Received: from first.geanix.com ([116.203.34.67]:50006 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235466AbhD0PMh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Apr 2021 11:12:37 -0400
Received: from [172.20.10.2] (80-62-116-178-mobile.dk.customer.tdc.net [80.62.116.178])
        by first.geanix.com (Postfix) with ESMTPSA id 808FA46607B;
        Tue, 27 Apr 2021 15:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1619536312; bh=IDKZ+RcU6hsX+LtuGE5R5UC4/4JWo1I5GMf++Oj+hsg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NK7eabM9neDEhPnq1MbcRyRxwCNvjnrqHsJbHpHXmR30+Lu2vxuiB0lG6EEzdWIkW
         MPyfv+jksGqcwFGIRzSGTfwu5wEPAUG9GSpAABMXFCNoGD75OV6QKot9ogjaEmapor
         wkwcbBGBJdX5167wwubz9BwYyeW6K2ezDHZ9vNk54HUw7Ct1QghZd39zPUhV1fmhsn
         aQoCaNpvGcVKwXPO2FS6AP3oNhKTW62h4wOOlWNAxyIU7Z8OgK7v6x9ahgGB8JSLOv
         eTfMoDQKmpVdbfV++OC7tbTOQZe14VEiuVyIbDMXpgYMIoClkwY5EGFZi6WwwzJRHq
         JhWIqyXSu2d/g==
Subject: Re: [PATCH v2 1/2] iio: accel: add support for FXLS8962AF/FXLS8964AF
 accelerometers
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <Nuno.Sa@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20210423101951.2876009-1-sean@geanix.com>
 <CAHp75VdEHy0-F-pg8sSUF5FK=NfDgBuDj0wLWqpGjpqE11mjww@mail.gmail.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <5110607a-c94a-d833-fd7d-52bd40d35b79@geanix.com>
Date:   Tue, 27 Apr 2021 17:11:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdEHy0-F-pg8sSUF5FK=NfDgBuDj0wLWqpGjpqE11mjww@mail.gmail.com>
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



On 23/04/2021 14.51, Andy Shevchenko wrote:
>> +               default:
>> +                       ret = -EINVAL;
>> +                       break;
> return -EINVAL;
>
>> +               }
>> +
>> +               iio_device_release_direct_mode(indio_dev);
Hi Andy,

Thanks for the review :)
Will have to set ret in order to clear the direct_mode();

/Sean
