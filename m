Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845E76AA990
	for <lists+linux-iio@lfdr.de>; Sat,  4 Mar 2023 13:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjCDMhC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Mar 2023 07:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCDMhA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2023 07:37:00 -0500
Received: from mail-108-mta177.mxroute.com (mail-108-mta177.mxroute.com [136.175.108.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8AE1258E
        for <linux-iio@vger.kernel.org>; Sat,  4 Mar 2023 04:36:56 -0800 (PST)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta177.mxroute.com (ZoneMTA) with ESMTPSA id 186aca00383000edb4.006
 for <linux-iio@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Sat, 04 Mar 2023 12:36:53 +0000
X-Zone-Loop: 39acdc9b42d39c27335ff70a245615a57172dff9ef5b
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ahepp.dev;
        s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:
        To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=iJdvTxcxbKyGSnJTdIa73KJnwMQ8ml/4r+mdNofz4SE=; b=OnQemOQo44ptDF+rRNiRSH5Vi+
        S/iGoIdp+DfwRJUX3ONt1mgEyUyVtSt1Y76jKTYazlck9LokTfvJcWJMiEDhOrz77JjkHgmkxtPOM
        I3SUOcfcIfhjR9gXgdDoWZHuqHKJhgBqBth18q1CL7AA1TlxKcVGUhmXvJkCIhyOmr/ksIherVrMS
        oVNdjREdPhFB+nj3HRtN7WSWH2+XgBQ+4OPPWyWpBMuh08TS1USZg6k288H4dKcLEt4Ft0BErpVoN
        RSW4/i331xv6OFcVSpfVNXuLnMk9LE2l3zW+XGmmj0qhle+5ipk+I5xtby6XVUV9es8iWciXfXuhA
        +4YX5Rmw==;
Message-ID: <55efb99d-f84a-0df9-67fa-0bf5c1372a42@ahepp.dev>
Date:   Sat, 4 Mar 2023 04:36:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: Add MCP9600 thermocouple EMF
 converter bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <20230304004109.78659-1-andrew.hepp@ahepp.dev>
 <73aa71ad-4cde-09d6-1af8-774701e330cd@linaro.org>
From:   Andrew Hepp <andrew.hepp@ahepp.dev>
In-Reply-To: <73aa71ad-4cde-09d6-1af8-774701e330cd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: andrew.hepp@ahepp.dev
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Krzysztof,

Appreciate the feedback! Snipping for brevity.

On 3/4/23 3:20 AM, Krzysztof Kozlowski wrote:

...
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    minItems: 1
>> +    maxItems: 6
>> +
>> +  interrupt-names:
>> +    minItems: 1
>> +    maxItems: 6
>> +    items:
>> +      enum:
> 
> The interrupts should be usually strictly ordered and you allow any
> combinations. Why?
> 
> Why are they optional?

The driver as currently written doesn’t support any interrupts. The 
device does not require interrupts to function.

This is the first dt-binding I’ve written, so it’s very possible that 
I’ve made a mistake, but I believe any combination of interrupts should 
be valid. Each of the interrupts listed represent an independent 
physical pin of the mcp960x chip. That pin might not be connected at 
all, so it seems to me that any combination of interrupts should be allowed.

MCP9600 and MCP9601 chips have four alert interrupts that trigger when 
temperature crosses a threshold (with configurable hysteresis). The 
MCP9601 adds short and open circuit detection interrupts.

> 
> 
>> +        - open
>> +        - short
>> +        - alert1
>> +        - alert2
>> +        - alert3
>> +        - alert4
>> +
>> +  thermocouple-type:
...

Thanks,
Andy
