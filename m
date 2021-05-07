Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44705376340
	for <lists+linux-iio@lfdr.de>; Fri,  7 May 2021 12:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhEGKDD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 May 2021 06:03:03 -0400
Received: from first.geanix.com ([116.203.34.67]:36524 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235275AbhEGKCp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 May 2021 06:02:45 -0400
Received: from [192.168.100.10] (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id 9144C467D47;
        Fri,  7 May 2021 10:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1620381672; bh=xFiKiN2nWu8Cl1UkBEpXfx79lj76B7DNes8C9eciy2w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=N2aWN77xx12vtWpuQNwTB2WlSAwdy2P+ip9gS8wPnQLQvc2Qv/gaWHtIXDoes5nsl
         ENoXkFRJHrTJLIbMiQ1JN0A7h9qzwkCCoeuiI6itpFIL7RZH268tt+3zgOZKT9p2gS
         zvcRkBoIEyN2iMoq+NKg8xLY49jd6sImeM5EnP7rGZRv8qdn/GL8dC2Bnb55Y1RLBe
         JtFsKLhbVWkqvK3N6nBRo0NSI2Fz1j1EtUbTJPnRhtBSgZ91KCGK8G6XwTzJyS4Xye
         rl10l7HoWdA/tvxs8CYbSd1HsDaixSVnCURgJLK2309F81hjK74BMXEP/a1blwyACo
         +KROyz4YwrJfw==
Subject: Re: iio: imu: st_lsm6dsx: sample rate?
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>
References: <1b645b15-f866-ee45-1b92-8dd32340409a@geanix.com>
 <YJOnNb4+3OFnLLC1@lore-desk>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <7fab7ea1-39b3-4301-dfa2-c740d4664430@geanix.com>
Date:   Fri, 7 May 2021 12:01:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJOnNb4+3OFnLLC1@lore-desk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 06/05/2021 10.22, Lorenzo Bianconi wrote:
>> Hi,
>>
>> Any specific reason to why the 12.5Hz sample rate is implemented as 13Hz ?
>>
> 
> Hi Sean,
> 
> what is the device you are referring to? I guess now all devices support
> 12.5Hz.
> 
> Regards,
> Lorenzo
> 
>> Br,
>> /Sean 

Hi Lorenzo,

I see the issue is fixed in:
commit f8710f0357bc36c740782c95f34ea847c75b7498

Author: Lorenzo Bianconi <lorenzo@kernel.org>

Date:   Sun Nov 3 20:47:18 2019 +0100



    iio: imu: st_lsm6dsx: express odr in mHZ

    

    Express available frequencies in mHZ in order to support even

    rational ODRs. This patch is need to fix an Android CTS failure

    

    Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

    Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

/Sean
