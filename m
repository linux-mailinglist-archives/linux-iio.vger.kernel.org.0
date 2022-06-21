Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157ED55320A
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 14:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350040AbiFUM3Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 08:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiFUM3Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 08:29:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519936275
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 05:29:14 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LS5R50SvJz688nt;
        Tue, 21 Jun 2022 20:28:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 14:29:11 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 21 Jun
 2022 13:29:11 +0100
Date:   Tue, 21 Jun 2022 13:29:09 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Stefan Lengfeld <stefan.lengfeld@inovex.de>
CC:     <linux-iio@vger.kernel.org>
Subject: Re: Questions: IIO type for absorbance and float values in
 channels?
Message-ID: <20220621132909.00005439@Huawei.com>
In-Reply-To: <20220621121855.ynnv5ckymbmmvjcm@gmail.com>
References: <20220621121855.ynnv5ckymbmmvjcm@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Jun 2022 14:18:55 +0200
Stefan Lengfeld <stefan.lengfeld@inovex.de> wrote:

> Hi all,

Hi Stefan,

> 
> I'm currently working on a linux kernel driver for a new sensor design. It's a
> special kind of light sensor that measures the reflection of emitted light.
> 
> I'm trying to fit this type of sensor into the IIO subsystem but I hit some
> issues.
> 
> 
> Question 1:
> 
> The sensor measures the absorbance[1] of a material. It's the negative
> logarithmic quotient of the received and emitted light. It's a unit-less value.
> 
> As far as I can see there is currently no predefined IIO type in the kernel for
> this.  I have search the list [2], but nothing matches.
> 
> Do I overlook something or what channel type should I use for this sensor
> measurement value?

So the closest we've seen to this is some of the health sensors (pulse oximeter
targeting devices) but in that case the processing is done with a custom userspace
library so we just pass values on in fixed point.

So probably needs a new channel type.

 
> 
> 
> Question 2:
> 
> The sensor effectively returns a float value of the measurement. I grepped trough
> the existing IIO drivers, but there seems only one driver that deals with float
> values.  The sps30 driver[3] gets a float from the device, but converts it to a
> integer value before passing it to the IIO subsystem.
> 
> I know that it's possible to provide a 'scale' attribute per channel to
> userspace[4], which can be a float point number.

More fixed point - though we have a couple of precision options. The aim there
is to ensure we only need a few bits of custom code to consume these values
in kernel. Raw value can also be fixed point.


> So effectively the result of a
> measurement can be a float-point value after it's computed in userspace.
> 
> Are floats really not supported as channel values? What is the recommend
> approach to deal with these measurement values?

So, in kernel we basically can't do floats (not quite true, but near enough that
it doesn't matter).  Given IIO can have in kernel consumers, that more or
less rules out true floating point handling.

We have in the past discussed simply passing them on to userspace (and
hence ruling out any interpretation of the value) but so far no one has added
the necessary support.  I'm not against adding that support, but I would
want to see the code / docs to fully understand why we are doing it.
It will be a special case in various code paths hence the extra consideration
needed.

> 
> 
> Question 3:
> 
> Is there another kernel subsystem/UAPI that fits this type of sensor
> better?  (My guess would be: No, IIO is the correct subsystem.)

Based on your description, IIO is the best option.

Jonathan

> 
> 
> Thanks a lot for answering my question.
> 
> 
> Kind regards,
> Stefan
> 
> [1]: https://en.wikipedia.org/wiki/Absorbance
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/iio/types.h#n14
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/chemical/sps30.c#n39
> [4]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/dummy/iio_simple_dummy.c#n122

