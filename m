Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6B5726353
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jun 2023 16:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240719AbjFGOwa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 7 Jun 2023 10:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbjFGOw3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Jun 2023 10:52:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB1C1BF3
        for <linux-iio@vger.kernel.org>; Wed,  7 Jun 2023 07:52:27 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qbr0P40sBz6J6tD;
        Wed,  7 Jun 2023 22:52:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 7 Jun
 2023 15:52:25 +0100
Date:   Wed, 7 Jun 2023 15:52:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     David Schiller <david.schiller@jku.at>
CC:     <linux-iio@vger.kernel.org>
Subject: Re: Questions about ad5933 driver
Message-ID: <20230607155224.000001d0@Huawei.com>
In-Reply-To: <1204b19a92343a9e3a6ec5df3cef94f6777e08c4.camel@jku.at>
References: <3e5653d1aec953e8aba8c00d073cd033a9f7a873.camel@jku.at>
        <20230606113013.00000530@Huawei.com>
        <1204b19a92343a9e3a6ec5df3cef94f6777e08c4.camel@jku.at>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 6 Jun 2023 12:51:50 +0200
David Schiller <david.schiller@jku.at> wrote:

> On Tue, 2023-06-06 at 11:30 +0100, Jonathan Cameron wrote:
> > Ideally clean up the driver.  If you are willing that would be great,
> > if not would you be able to test changes made by someone else?  You
> > are first person in years that I know has one! :)  I can't remember
> > how far this driver is from being ready to move out of staging, but I
> > can probably find some time to do a thorough review of that in next
> > few weeks.  
> 
> Yes, I'm willing to test any patches that are provided to me. :)
> I can also try to come up with my own changes, but I'm not that familiar
> with the IIO subsystem beyond what I've learned in the past couple days,
> so I'd need some assistance.
> 
> > That may require extra ABI definitions possibly including the real and
> > imag modifiers at which point your patch to libiio would be correct.  
> 
> Yes, that's what I though too. I wasn't sure how "official" libiio is,
> as it's not in the kernel tree.

Not 'official' though it is fairly commonly used, but the documented ABI in
Documentation/ABI/testing/sysfs-bus-iio*
is and these aren't there either.

I'm not 100% sure this is the right way to solve this ABI gap though
so need to have a bit of a think about it.  Using a modifier means we can't
use them for anything else, so need to consider if there are other modifiers
(or it has meaning for differential channels) when deciding if this is
an ABI we want to add.

Thanks,

Jonathan


> My quick and dirty patch currently looks
> like this:
> 
> 
> diff --git a/channel.c b/channel.c
> index 469d037e..6a57a271 100644
> --- a/channel.c
> +++ b/channel.c
> @@ -114,6 +114,8 @@ static const char * const modifier_names[] = {
>         [IIO_MOD_PITCH] = "pitch",
>         [IIO_MOD_YAW] = "yaw",
>         [IIO_MOD_ROLL] = "roll",
> +       [IIO_MOD_REAL] = "real",
> +       [IIO_MOD_IMAG] = "imag",
>  };
>  
>  /*
> diff --git a/iio.h b/iio.h
> index 135e335c..3c803479 100644
> --- a/iio.h
> +++ b/iio.h
> @@ -196,6 +196,8 @@ enum iio_modifier {
>         IIO_MOD_PITCH,
>         IIO_MOD_YAW,
>         IIO_MOD_ROLL,
> +       IIO_MOD_REAL,
> +       IIO_MOD_IMAG,
>  };
>  
>  /**
> 
> 
> 
> 

