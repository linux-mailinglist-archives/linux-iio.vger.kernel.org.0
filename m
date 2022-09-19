Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9005BCF99
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 16:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiISOur (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 10:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiISOur (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 10:50:47 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2900ADF1F
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 07:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=CtjNyR0PZD+lYbWZmeaNFjfhz30uKH1XiGjjA9riguc=; b=fKtH0Gpv2kl5zivUpMlpdan3w+
        fV1qY07sc/V8zScM6fDjPVu92soowqHo/5kyP/s1M95I7Wk6AWzWAGw5ndidFytaOijEV9+k4H/lD
        kMTfpq6gIuYBdtPR9fBi2sd0tXEzTiGSabEScf2NFcQxKLeNIYcLBSpody6hSbLninc9J7ZovC9Ws
        l5GQ4vofoBuVRS8YC7epqH9h/nTa5L2C9utmJSvyu//XetnTHDK6jKysS+R+H6RZHB5WB3Equzdm7
        QpNCjfagflsvN2hZ0TZlORf3V55bbSHQfM5ym4rRWzGHPwA3/9OC99IK6Np8x7aKnRyQpzgLAF0zR
        1/TuuBKg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1oaI6d-000DbZ-H8; Mon, 19 Sep 2022 16:50:43 +0200
Received: from [2001:a61:2a52:ad01:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1oaI6d-000T2F-Nn; Mon, 19 Sep 2022 16:50:43 +0200
Message-ID: <bfb7c7c8-0381-0557-b69a-98f2f272605b@metafoo.de>
Date:   Mon, 19 Sep 2022 16:50:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] iio: adc: ad7124: Silent no spi_device_id warnings
Content-Language: en-US
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Wei Yongjun <weiyongjun@huaweicloud.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
References: <20220919145945.823327-1-weiyongjun@huaweicloud.com>
 <d4fa7502-d5a5-9849-8daf-efc25a22ae81@metafoo.de>
In-Reply-To: <d4fa7502-d5a5-9849-8daf-efc25a22ae81@metafoo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.7/26663/Mon Sep 19 09:56:35 2022)
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/19/22 16:46, Lars-Peter Clausen wrote:
> On 9/19/22 16:59, Wei Yongjun wrote:
>> From: Wei Yongjun <weiyongjun1@huawei.com>
>>
>> Add spi_device_id entries to silent following SPI warnings:
>>
>> SPI driver ad7124 has no spi_device_id for adi,ad7124-4
>> SPI driver ad7124 has no spi_device_id for adi,ad7124-8
> What generates those warnings?
>
Ok, found it. 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5fa6863ba69265cb7e45567d12614790ff26bd56

Can you mention this in the commit message, that this is to fix module 
autoloading for the driver? That makes it much more clear why we want to 
fix this.

