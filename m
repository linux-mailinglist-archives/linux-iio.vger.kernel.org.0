Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0AA2E7AEF
	for <lists+linux-iio@lfdr.de>; Wed, 30 Dec 2020 17:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgL3QKn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Dec 2020 11:10:43 -0500
Received: from www381.your-server.de ([78.46.137.84]:59320 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgL3QKn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Dec 2020 11:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=sWSDtogyvTGXGLULesv3/v2KaIDCSWZ07uGJFvMVxVw=; b=c+/7vFhGr1TJhw/LIsLFUagUXJ
        xCEQWX2ZZvkCW6OWy6p8i2+JMGmkmliAVqxvC96c7byJuo96TpBtxEj1zksocA1c5FywhGiAQv7y0
        uq0huF/Q4+0lD8wYpOaL62n7h2AeUxXpxqdu6n9FOY3flDsjGGqnFrhUuuT6K8GGqGF77utIw373T
        clSmFJlbbj6YBhuvlm86iBSIw8RKCAQmaZMt2lTNy3aQMssK0JHRhnve7quaidoLPR+e/Vg6buMjV
        R9vmC9wN6dfraObd6vgOoKoj+pb5B5PHd/MCIdrXJw7knZhXH9Ge1zWmEUt5RYTYtvj2EbBaiAXGW
        tH+rSy5w==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kue2t-0004QP-7o; Wed, 30 Dec 2020 17:09:55 +0100
Received: from [2001:a61:2af4:a201:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kue2s-000DSH-Vk; Wed, 30 Dec 2020 17:09:55 +0100
Subject: Re: [RFC PATCH v2 1/1] iio/scmi: Adding support for IIO SCMI Based
 Sensors
To:     Jonathan Cameron <jic23@kernel.org>,
        Jyoti Bhayana <jbhayana@google.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        cristian.marussi@arm.com, sudeep.holla@arm.com,
        egranata@google.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com, Peter.hilber@opensynergy.com,
        ankitarora@google.com
References: <20201224031921.1547519-1-jbhayana@google.com>
 <20201224031921.1547519-2-jbhayana@google.com>
 <20201230134104.48d07ff5@archlinux>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <220be27a-8eef-8582-9a8c-270f16fda688@metafoo.de>
Date:   Wed, 30 Dec 2020 17:09:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201230134104.48d07ff5@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26033/Wed Dec 30 13:42:10 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/30/20 2:41 PM, Jonathan Cameron wrote:
> On Thu, 24 Dec 2020 03:19:21 +0000
> Jyoti Bhayana <jbhayana@google.com> wrote:
>
>> +	/*
>> +	 * The seconds field in the sensor interval in SCMI is 16 bits long
>> +	 * Therefore seconds  = 1/Hz <= 0xFFFF. As floating point calculations are
>> +	 * discouraged in the kernel driver code, to calculate the scale factor (sf)
>> +	 * (1* 1000000 * sf)/uHz <= 0xFFFF. Therefore, sf <= (uHz * 0xFFFF)/1000000
>> +	 *  To calculate the multiplier,we convert the sf into char string  and
>> +	 *  count the number of characters
>> +	 */
>> +
>> +	mult = scnprintf(buf, 32, "%llu", ((u64)uHz * 0xFFFF) / UHZ_PER_HZ) - 1;
> use sizeof(buf) instead of having 32 again.
>
Since this is just interested in the number of characters and not the 
string itself I believe it is possible to just call sprintf with NULL 
instead of a buffer. It will then still return the number of characters, 
but not print anything.

But maybe providing a ilog10() helper is the better approach.

