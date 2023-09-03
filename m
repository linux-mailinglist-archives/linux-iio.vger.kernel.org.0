Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3661790CD6
	for <lists+linux-iio@lfdr.de>; Sun,  3 Sep 2023 18:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243985AbjICQCS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Sep 2023 12:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjICQCS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Sep 2023 12:02:18 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6935DFE
        for <linux-iio@vger.kernel.org>; Sun,  3 Sep 2023 09:02:14 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E88598645D;
        Sun,  3 Sep 2023 18:02:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693756932;
        bh=ycmqQ4rq5mBd0t2v/fa2P4Tj0gA5RaRbEduISVI4lq4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=zeGz7JHoM2VsMf9tRKg+fXnmJZ/hqJTKr7wlvNKqKOqIQ34rpZ9hEpUF6jUlzRf72
         BghYRPQvbCvqPZALr4EtD5X5RUoWCy3y7PzAbKNt8nSi5b4AhZ4vL89ADXUOXt/ryt
         P1jlGyUS2xL87pc0nIr7ljHoTqTCSbj0ND0reubUeWtOdkgGOTF2ywwZLbeGlQGT5f
         AIVI+AwY5NLLih3DIvL3yh9jViFsGKoZB50+59h5Km7cBo9OCudixTCnQehBY8UueY
         PR/f0LwS5zSidQMclYyEZ/vZFNcAXddq6Sh8Qs5dl7yjfEK7e/GnbPlqItm6xqg2I5
         kb9ny3OhV5B3Q==
Message-ID: <4093c2db-7cd9-41c3-3ad6-daa8f435fe10@denx.de>
Date:   Sun, 3 Sep 2023 18:02:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] iio: adc: ti-ads1015: Add edge trigger support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>
References: <20230831182502.154899-1-marex@denx.de>
 <20230903130042.6fa69ea0@jic23-huawei>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230903130042.6fa69ea0@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/3/23 14:00, Jonathan Cameron wrote:
> On Thu, 31 Aug 2023 20:25:02 +0200
> Marek Vasut <marex@denx.de> wrote:
> 
>> The comparator generates an edge on the IRQ like and stays in the
>> configured state until cleared. Support edge triggered IRQs as well
>> as not all controllers do support level triggered IRQ.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> Hi Marek,
> 
> Seems safe enough change given the latch is enabled.
> 
> I guess it's not really a fix, but I'd be fine with a request
> for this to be added to stable if you like.

It isn't really a fix, so next release is fine.

> Applied to the togreg branch of iio.git and pushed out as testing
> only until I can rebase on rc1.

Thanks
