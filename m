Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BF536D69E
	for <lists+linux-iio@lfdr.de>; Wed, 28 Apr 2021 13:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbhD1LiA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Apr 2021 07:38:00 -0400
Received: from first.geanix.com ([116.203.34.67]:38050 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234158AbhD1LiA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 28 Apr 2021 07:38:00 -0400
Received: from [192.168.64.189] (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 3CF7B4661E5;
        Wed, 28 Apr 2021 11:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1619609833; bh=cJNNPY3OXkJ4ZqpUBnyX7/E7d3vUz7Wmr4y6JSvleG8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=C2K8dg19zdapAoSgRnbXbnwpMavkswJvsO1k9RragI8B99zvlmb73BpS9EFCQOGe3
         bvEXl7MBECSaJK3V+mTmtWKJQGSVGy5pDymjhdZi3h8eiBSu7hkibdwVSN7MEP256n
         nbSxAo029Vc2kNBRnABIV5VnGyj998t1sBVmxgelWzc/f9yGg16npw9mcejhcPtoiC
         h3c+SdWK/DPCiE2YVpQjHBneUM0aYZKOU2+GNZuBkEJQlmWoynULclbt5m8/bc52WT
         5nFddBpABRLLuV2bfID/mm/MB840Y+vOoMprLXvAORaKxo4EmWX2v9KOt6dfKUPS0H
         iBw5w42vR4zug==
Subject: Re: [RFC PATCH 4/4] iio: accel: fxls8962af: fix errata bug E3 - I2C
 burst reads
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <Nuno.Sa@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20210428082203.3587022-1-sean@geanix.com>
 <20210428082203.3587022-4-sean@geanix.com>
 <CAHp75Ve5Dyz-Cc7p8G4JzZ1Jhbey330WEHu2u7DLrRsoRbvgjg@mail.gmail.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <65d00eec-6787-b9f5-c954-bbf1eac47050@geanix.com>
Date:   Wed, 28 Apr 2021 13:37:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve5Dyz-Cc7p8G4JzZ1Jhbey330WEHu2u7DLrRsoRbvgjg@mail.gmail.com>
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



On 28/04/2021 13.24, Andy Shevchenko wrote:
> This should be part of that series.
OK, will include next week...
>
> Besides, see below.
>
> ...
>
>> +       bool i2c_device;
>> +       data->i2c_device = i2c_device;
> This is redundant. Use i2c_verify_client() instead.
Thanks I've been looking for a that functionality :)

/Sean

