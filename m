Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75964E4882
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 22:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbiCVVnf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 17:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbiCVVnN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 17:43:13 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807505EDF7
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 14:41:45 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 3118A8395F;
        Tue, 22 Mar 2022 22:41:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1647985303;
        bh=pP5CNx8FGy0eEjfSciGSAY60O+5DCpebVFy2GM2hUnQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gRsy3VVXyuIfo31wLjhxZsbWPHUJHLkh07sYJ7ZCSdBLBVGqepA+NeYax/mVVsCgJ
         fRwLJ+U8UaU0KHiO9zaJ7+oQW0ACdBkFL/6h/8Z4ZxgtN2feZ7Fy3Fb7yg5m74nqnx
         taXJzD4CDYKfoKSCZ9gDPghj2fjnhNpJ0ODl4u6wLgzUflF1oPOISBezbz2zw3E9IA
         3oI2BsyZUDA+45mE7hiA157Mt9H13Tnw0KlyByoyTNVOqV5+8c76TrDgbexHjTr6l1
         6guS/JMk2OMKrJMFN5oQkVDRJTiwTeGO/T8GZL4WFuAR3Kj6CoA95u/4GuKY1nb2P9
         3jcvwu6j99AnA==
Message-ID: <d917bc8a-132e-61a3-5ff5-24c498a45d98@denx.de>
Date:   Tue, 22 Mar 2022 22:41:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 08/10] iio: adc: ti-ads1015: Convert to OF match data
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20220320181428.168109-1-marex@denx.de>
 <20220320181428.168109-8-marex@denx.de>
 <CAHp75VerZC8CdT9uzEierPMtkaoMSE7KWAXfoOwFuEj5Ks=c-w@mail.gmail.com>
 <20220322210029.00000a4c@Huawei.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20220322210029.00000a4c@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/22/22 22:00, Jonathan Cameron wrote:
> On Mon, 21 Mar 2022 11:24:12 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
>> On Sun, Mar 20, 2022 at 8:14 PM Marek Vasut <marex@denx.de> wrote:
>>>
>>> Replace chip type enumeration in match data with pointer to static constant
>>> structure which contain all the different chip properties in one place, and
>>
>> contains
>>
>>> then replace handling of chip type in probe() with simple copy of fields in
>>> the new match data structure into struct iio_dev.
>>>
>>> This reduces code and increases static data.
>>
>> I like this change! My comments below.
> Nice work indeed. Nothing else from me on this one.
> 
> I like the fact you also got rid of some odd casting away of const
> whilst you were doing this.

[...]

>>> +       chip = (const struct ads1015_chip_data *)
>>> +               device_get_match_data(&client->dev);
>>
>> Redundant casting. After dropping it it will become one line.
>>
>>> +       if (!chip)
>>> +               chip = (const struct ads1015_chip_data *)id->driver_data;

I don't think I can get rid of this ^ id->driver_data one though.

The device_get_match_data() yes, that cast can be removed.
