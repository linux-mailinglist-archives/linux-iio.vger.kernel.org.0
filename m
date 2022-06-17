Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722EC54F1CB
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jun 2022 09:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbiFQHWW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jun 2022 03:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380607AbiFQHWT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2022 03:22:19 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974FECD
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2022 00:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=MdsJci63yjz7iu4X0ztALnZ7jW/aMf9CpapWaosDvZM=; b=X7BGxWcnOsIT4YWCtkewzZcKV7
        aZYg+/tEzoricuNkIbBcEFCl4jiYBU97q92lxIyCUfGkduERzyr/D3FqaAhRz52vmrNgFREaZB8qC
        0qq3MIHuGefjY1jnnSauaHHgQJG2ZYLGp4AL0E22EyvHEqYI2pFWFiJ+7zh5P8MyebivzF1xOAZHY
        BqShPnzSY0u6nrU2UhkHR6cTHJixo6AkoExr+hYk8fnUVTJMzXQI2+Mnv7I04oa/Cr7E5b50C+ki+
        YfWGVjwP508lXBN1WtNmNLagem6pesJBKdgxqXSFxMnJC6WIrjJwfMFkIr5f0xM7BSCcDzw0uFE5Y
        c7jgkn7A==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1o26J0-0004lt-CS; Fri, 17 Jun 2022 09:22:10 +0200
Received: from [2001:a61:2a7f:a201:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1o26J0-00030f-4y; Fri, 17 Jun 2022 09:22:10 +0200
Message-ID: <44170bf8-5777-e30b-b74d-a6835b1937e2@metafoo.de>
Date:   Fri, 17 Jun 2022 09:22:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Intel Timed-IO driver in IIO/Counter subsystem
Content-Language: en-US
To:     "N, Pandith" <pandith.n@intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc:     "vilhelm.gray@gmail.com" <vilhelm.gray@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
References: <BYAPR11MB3240148739EBB945211DD77BE1AF9@BYAPR11MB3240.namprd11.prod.outlook.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <BYAPR11MB3240148739EBB945211DD77BE1AF9@BYAPR11MB3240.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.6/26574/Thu Jun 16 10:06:40 2022)
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 6/17/22 08:37, N, Pandith wrote:
> Hi,
>
> We have a Intel Timed IO peripheral with following functionalities :
>
> 1. Event capture capability - Captures event count and timestamp.
> 2. Pulse generation - periodic or single event generation.
> 3. Return cross-timestamp on request.
>
> Timed IO device is being used in various Industrial use cases such as : time capture, synchronization, fan speed calculation etc.
>
> IIO or counter subsystem seems to be suitable for timed-io driver.
>
> Is it favourable to implement as part of IIO or counter subsystem ? Wanted to know your feedback.

That sounds like a mix of a counter and PPS device. Have you looked at 
the PPS subsystem[1]?

[1] https://www.kernel.org/doc/html/latest/driver-api/pps.html

