Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5BD55AA58
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jun 2022 15:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiFYNMR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Jun 2022 09:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiFYNMR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Jun 2022 09:12:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6C32124A
        for <linux-iio@vger.kernel.org>; Sat, 25 Jun 2022 06:12:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6DB48CE07EB
        for <linux-iio@vger.kernel.org>; Sat, 25 Jun 2022 13:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC800C3411C;
        Sat, 25 Jun 2022 13:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656162730;
        bh=BvugPVXmIDgTzXu7r+qOIIXLRA9Stk6Aetwpat6Z53A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qlI2CXJiYRD5PwR3k4Xk/AvkAAZ/tIAM0lYs1Y9Sy3mH1UMy/l6N5Vok2WZsltffU
         JltoqKwij+YTJ5JwC23qs1zk6HuKGxR0np5P+f1gGZATh1vHlWQ6+KZxjZNJCSUKh0
         kM0lOyMU9Xpm1GvnEu3aetYfySzab3QMzS+HcGPcVQH0xDhcf99OXq1DfIRrDrUe89
         llG2TYNiKbJpsfbTYR5Jt6Do/ue9t1fE2KO+HauYCnfLdaqfxMmrV5S+LzsIquve1B
         Jk0T/3BCURvqiLkkbueO+vUIxBsgbfd2U1RieCn9pujzkGdAz8Wmsw285uYSdmKw/F
         yKmV/g0iAwBew==
Date:   Sat, 25 Jun 2022 14:21:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Lengfeld <stefan.lengfeld@inovex.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-iio@vger.kernel.org
Subject: Re: Questions: IIO type for absorbance and float values in
 channels?
Message-ID: <20220625142138.3b4d838e@jic23-huawei>
In-Reply-To: <20220622154225.gy26zikpdty64ufl@gmail.com>
References: <20220621121855.ynnv5ckymbmmvjcm@gmail.com>
        <20220621132909.00005439@Huawei.com>
        <20220622154225.gy26zikpdty64ufl@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jun 2022 17:42:25 +0200
Stefan Lengfeld <stefan.lengfeld@inovex.de> wrote:

> Hi Jonathan, 
> 
> On Tue, Jun 21, 2022 at 01:29:09PM +0100, Jonathan Cameron wrote:
> > > Is there another kernel subsystem/UAPI that fits this type of sensor
> > > better?  (My guess would be: No, IIO is the correct subsystem.)  
> > 
> > Based on your description, IIO is the best option.  
> 
> Great. This means that I'm on the right track.
> 
> 
> > > Question 1:
> > > 
> > > The sensor measures the absorbance[1] of a material. It's the negative
> > > logarithmic quotient of the received and emitted light. It's a unit-less value.
> > > 
> > > As far as I can see there is currently no predefined IIO type in the kernel for
> > > this.  I have search the list [2], but nothing matches.
> > > 
> > > Do I overlook something or what channel type should I use for this sensor
> > > measurement value?  
> > 
> > So the closest we've seen to this is some of the health sensors (pulse oximeter
> > targeting devices) but in that case the processing is done with a custom userspace
> > library so we just pass values on in fixed point.  
> 
> I have look at the 'oximeter' drivers in the IIO framework, namely
> afe440x and max3010x. All use the IIO type IIO_INTENSITY and the
> max30100x drivers also use the modifiers IIO_MOD_LIGHT_*.
> 
> You also referenced the modifiers in your response to Andy.
> 
> 
> > So probably needs a new channel type.  
> 
> Ok. This makes it a bit harder for us, because we want to provide a
> kernel driver that also works for older kernels.
> 
> Is there a private IIO type range that can be use in the meantime,
> until a new IIO type is accepted and merged upstream?

No unfortunately. Such ranges only work with a bunch of 'vendor id'
type magic to allow avoidance of clashes so tend to be complex unless
you expect to have long term vendor specific types.  The result
is that I know a bunch of vendors are carrying backports of core
IIO changes to enable new sensor types (and features sometimes),
obviously a bit harder to do if you are providing a single sensor
driver.

> 
> Another side note/question: Is there a documented mapping between the
> IIO types and physical SI units?  I have found nothing about that in the
> IIO documentation. It would have helped me to better understand the
> differences between the various types.

Documentation/ABI/testing/sysfs-bus-iio 
has most stuff.  We haven't done a great job at cross reference between
the other docs and there.


> 
> Just for reference. I mentioned the absorbance, but there is also
> another equivalent physical value: the refelctance[1]. It's the same
> value just without the negative logarithm.
> 
> 
> > > So effectively the result of a
> > > measurement can be a float-point value after it's computed in userspace.
> > > 
> > > Are floats really not supported as channel values? What is the recommend
> > > approach to deal with these measurement values?  
> > 
> > So, in kernel we basically can't do floats (not quite true, but near enough that
> > it doesn't matter).  Given IIO can have in kernel consumers, that more or
> > less rules out true floating point handling.  
> 
> Yes, float point math is frowned in the kernel. I have read the kernel
> hacking documentation [2]. :-) But I also know that the functions
> kernel_fpu_begin() and kernel_fpu_end() exist (including there
> performance problems ;-) ).
> 
> 
> > We have in the past discussed simply passing them on to userspace (and
> > hence ruling out any interpretation of the value) but so far no one has added
> > the necessary support.  I'm not against adding that support, but I would
> > want to see the code / docs to fully understand why we are doing it.
> > It will be a special case in various code paths hence the extra consideration
> > needed.  
> 
> Ack on that. My take way is that it's currently not implemented but
> theoretical acceptable upstream to pass float point values from the chip
> to userspace. But it would require a good/valid show case and extra work
> in the IIO subsystem.

Yup.

> 
> I take this information to the sensor engineers. Maybe we can rework the
> communication/data protocol to pass the measurement as integer values
> with a separate scale factor that does not require raw float point
> values.

Would be great if that is a fair representation of what is going on
in the device.   If the device is doing something hideously non linear
using an actual FPU then it might be very challenging.

> 
> 
> > > I know that it's possible to provide a 'scale' attribute per channel to
> > > userspace[4], which can be a float point number.  
> > 
> > More fixed point - though we have a couple of precision options. The aim there
> > is to ensure we only need a few bits of custom code to consume these values
> > in kernel. Raw value can also be fixed point.  
> 
> Yes. I already saw and tested the IIO_VAL_* defines (like
> IIO_VAL_INT_PLUS_NANO or IIO_VAL_FRACTIONAL) that can be used to provide
> fixed point scale values to userspace. They work great and maybe we can
> use them.
> 
> Thanks again!

Good luck. Looking forward to seeing the code + more details on
your sensor!

Jonathan

> 
> Kind Regards, 
> Stefan
> 
> [1]: https://en.wikipedia.org/wiki/Reflectance
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/kernel-hacking/hacking.rst?id=9d2231c5d74e13b2a0546fee6737ee4446017903#n134

