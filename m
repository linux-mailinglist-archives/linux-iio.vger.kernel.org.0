Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFC4A19C93C
	for <lists+linux-iio@lfdr.de>; Thu,  2 Apr 2020 20:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbgDBSz6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Apr 2020 14:55:58 -0400
Received: from www381.your-server.de ([78.46.137.84]:55958 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732214AbgDBSz6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Apr 2020 14:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fKsOtiZ5cqqJb+vxcZ4y9u2bLpGbyUzcShKf+FTpLFQ=; b=lmGm1muQUlissLhe/K17gQWPTp
        RRJEoMqSTHvQO+1d5U+NT5rYynkJy6mOs5lPZ3qEAiEm6/g67nqRzk3RGduBE4LX0xn0Isv0lHswd
        O9X2eld1rxRDLYl3xeTFtOYgggdt228fegTgjPxP/k7lbqufyEBFuWEvAo9LIfS9ijqEw+eYJlCyf
        laOkJkebnhyAuLL/pmQ0Ve7OinsRvrLzkjxE1nzA+E3m1V5qlM7n60RJ0HG79KuFzDKXAETqx9EFp
        0XelgymVUzqpsr1PsGrbo55o0ueE21JfOkYM5RYsoGx9NrcD+e6Nzj/pvDq9BuYWFiiIVONhDQN6U
        3svwTmDg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jK50K-0001o5-Q4; Thu, 02 Apr 2020 20:55:52 +0200
Received: from [82.135.64.109] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jK50K-000Td1-Fa; Thu, 02 Apr 2020 20:55:52 +0200
Subject: Re: [PATCH v6 2/2] iio: adc: Add MAX1241 driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
References: <20200401185138.10673-1-alazar@startmail.com>
 <20200401185138.10673-3-alazar@startmail.com>
 <CAHp75VffpBYh+5xrWeeJJH8gRmJqT9ya5eQFedWi190_=p8HKQ@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <4431cacc-4af6-a497-5850-20dfceb588c1@metafoo.de>
Date:   Thu, 2 Apr 2020 20:55:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VffpBYh+5xrWeeJJH8gRmJqT9ya5eQFedWi190_=p8HKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25770/Thu Apr  2 14:58:54 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/2/20 8:45 PM, Andy Shevchenko wrote:
> On Wed, Apr 1, 2020 at 9:47 PM Alexandru Lazar <alazar@startmail.com> wrote:
>> Add driver for the Maxim MAX1241 12-bit, single-channel ADC.
>>
> Perhaps put data sheet link as Datasheet: tag here?
>
>> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>> Signed-off-by: Alexandru Lazar <alazar@startmail.com>
> ...
>
>> +       indio_dev->name = spi_get_device_id(spi)->name;
> Shouldn't be rather part number?
> Jonathan?

This is the part number as defined in the spi_device id table :)

+static const struct spi_device_id max1241_id[] = {
+	{ "max1241", max1241 },
+	{}
+};

- Lars

