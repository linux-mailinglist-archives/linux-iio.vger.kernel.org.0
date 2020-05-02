Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768861C2760
	for <lists+linux-iio@lfdr.de>; Sat,  2 May 2020 20:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgEBSBp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 May 2020 14:01:45 -0400
Received: from www381.your-server.de ([78.46.137.84]:52370 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgEBSBp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 May 2020 14:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8I+Hn7E68vFWn4rc9egcH+6P7fyOrFPXVwlizaUW9w0=; b=HxSLmT8E53oyA/H3tqK3kSB8KR
        6R3pw0nrMUvR9bXNoNEpxjlNP9zZ6EZmqY8v0xgjG1gSBbDln4Vq03i8x+lh+22Ju8PwyzbBzRVbM
        6odq4EHPDmJ6IeCat0aycYmgX3uMNLvCYEopG6RMDxbFtABs70gRZmdkRHUKkyS5O+z+jT+uVTaMm
        d+Cssg/S4mmtV88XnddYz2bOuvRHSq1wzZQmJCVZTlGeggq5wZlAI9qkpSWqiGj1tDd4D/7hpD0K1
        8cWaxLZrVltoTRxJLZJb0hdqnYDr650cubsFstNNmt/4M+VhDYunnPkXVGN6CF+Q35xZ29gdqj6W0
        9nakBupA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jUwSJ-0007OK-W0; Sat, 02 May 2020 20:01:40 +0200
Received: from [82.135.65.122] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jUwSJ-000Wod-MA; Sat, 02 May 2020 20:01:39 +0200
Subject: Re: [PATCH v5 5/6] iio: imu: Add support for adis16475
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
References: <20200413082445.17324-1-nuno.sa@analog.com>
 <20200413082445.17324-6-nuno.sa@analog.com>
 <2418ed60-8407-0c99-bf5d-1afc3964de2b@metafoo.de>
 <20200502184010.134eb8b5@archlinux>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <67202bd8-e0a5-be53-13c6-e01a25e2a85b@metafoo.de>
Date:   Sat, 2 May 2020 20:01:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200502184010.134eb8b5@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25800/Sat May  2 14:08:18 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/2/20 7:40 PM, Jonathan Cameron wrote:
> On Mon, 27 Apr 2020 20:06:07 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>> On 4/13/20 10:24 AM, Nuno Sá wrote:
>>> [...]
>>> +static irqreturn_t adis16475_trigger_handler(int irq, void *p)
>>> +{
>>> [...]
>>> +	__be16 data[ADIS16475_MAX_SCAN_DATA], *buffer;
>>> [...]
>>> +
>>> +	iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);
>> If the timestamp is enabled the IIO core might insert padding between
>> the data channels and the timestamp. If that happens this will disclose
>> kernel stack memory to userspace.
>>
>> This needs either a memset(data, 0x00, sizeof(data)) or maybe put data
>> into the state struct and kzalloc it.
> Good spot. Could simply do __be16 data[ADI..] = {0}; rather than explicit
> memset, but some form of zeroization is needed.
>
> I've fixed up the applied patch with the above approach.
There is actually another issue. The stack data is not necessarily 
aligned to 64 bit, which causes issues if we try to put the 64-bit 
timestamp in it. I think data should really be in the state struct.
