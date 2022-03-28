Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A8F4E8B3C
	for <lists+linux-iio@lfdr.de>; Mon, 28 Mar 2022 02:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiC1AdQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Mar 2022 20:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiC1AdP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Mar 2022 20:33:15 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1554A4889B
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 17:31:35 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C830881FBB;
        Mon, 28 Mar 2022 02:31:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1648427493;
        bh=oSFMfqD1hSlMJ3Eusc6TwiNGpDSyAJoP7J2jncMGexc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=zjD7dUPNa8VqmCVF6rpnIPkdMKt0DpCe/iCWMLUTpTWChwgHIw7ftHIiQR8N7Jy8F
         S9gyaEpQWELz4oH9sjq0FWu+pBZUwRLXvVo3qMBmHmcaejoTlwcmqyJQ3JMW4Klo3I
         rZ4mq9/glnchU9JROkpA8Q5XElnG92nlql+K2HmLl1f49Dcrb2iLLAcAn4kcSz/uar
         kWgGz/8Gj0zu7iYI5vCvQ6H0pFgJFGzMuudO2Y/egLl1F9B/nE99sQ5rPhwvA4rwFS
         TwwF2oWqrPiQRxXzdam0xGxjSqbrLUP5liVO0nW2KWEjyiP/YdbMkAcYA0VFnFN1IQ
         a0+/FKlK+EL7g==
Message-ID: <2a5699df-51b0-de6f-6651-b0e0eefd8667@denx.de>
Date:   Mon, 28 Mar 2022 02:31:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 10/10] iio: adc: ti-ads1015: Switch to read_avail
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20220322220210.207454-1-marex@denx.de>
 <20220322220210.207454-10-marex@denx.de>
 <20220327161835.5c661300@jic23-huawei>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20220327161835.5c661300@jic23-huawei>
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

On 3/27/22 17:18, Jonathan Cameron wrote:
> On Tue, 22 Mar 2022 23:02:10 +0100
> Marek Vasut <marex@denx.de> wrote:
> 
>> Replace sysfs attributes with read_avail() callback. This also permits
>> removal of ads1115_info, since the scale attribute tables are now part
>> of chip data.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Andy Shevchenko <andy@kernel.org>
>> Cc: Daniel Baluta <daniel.baluta@nxp.com>
>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Sorry, I didn't catch your question on v3 about why I was advocating
> signed.
> 
> You are passing pointers to those arrays as signed in the
> read_avail.
> 
> Obviously you can 'get away with it' because the values are small
> positive numbers and hence in 2's complement the data representation
> will be the same.  Not pretty though so my inclination would
> be to keep them signed everywhere.
> 
> If you are fine with that change I can change it whilst applying if
> nothing else comes up in review.

I'm fine with it, although I did switch them all to unsigned int in this 
V4 (unless I'm missing something still).
