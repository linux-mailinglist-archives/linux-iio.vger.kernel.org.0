Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826A7554FA5
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jun 2022 17:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbiFVPmc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jun 2022 11:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353708AbiFVPmb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2022 11:42:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B7936E35
        for <linux-iio@vger.kernel.org>; Wed, 22 Jun 2022 08:42:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u15so7454146ejc.10
        for <linux-iio@vger.kernel.org>; Wed, 22 Jun 2022 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=inovex.de; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C31W0sv7gTJ7jc4b8BAxRt8r8uCV0ogCyemwyJk4uXQ=;
        b=cMRgPdK/K033zzV6jMIWBDyZpa0aR0O05PsvSxql1KG3+HiwCW7QyHk+rJBUxjBw9d
         sIjV+IXXGDM9SyX3BMKoYSGTKIDTNTxmWPheTMADxETyXwRU3IeNMg+KcxpmEuuBU7MG
         fIf1JVBH74MQzAUOi0NKVIOT5XdKGRo4Chh8Wu+LfxRU2A0nhMC3uLPpKjDDnJ/TPXf0
         MUf4pNKEMnEfL/zkiBwhIMDWAzQby0OiDq9guynfcNvOoeMwvMQRM2b6BF7oTnSYkzGH
         XW16idFzJ/YlCPtAHuIVqvioC7s9x85CPU/YVATNChqkP9G8JBJ87zAq1+yQVT13aoiF
         Vh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C31W0sv7gTJ7jc4b8BAxRt8r8uCV0ogCyemwyJk4uXQ=;
        b=hqYTDx9vwq0f2P+eyfQb+8N5HFnLIjfBaqBuEGqBcZGr9e77urp1+xjeTf1X+BdGtj
         xZQ8IOJ1CthdYdkFiJWMVzGpItCLifKpbKYzvs10hdxCTNGaR1WSodt/+Et0GfDqhEtj
         KikcYRpnNW05RrxAmDDNXM9Kh6rC8scVHOTF/sX/tQ6I0n6gJ27NdpEsKfVX+qhK9nUh
         eaSl4U33mCRgRhaYvk7Hxc7254JoL9O1Hnnnxpe9fVfIcn3xSMVxqqZeTquhHXhJkHoA
         z4MJxL/Bs5YAcrk0rqEB8Q7629jH2d7ZACxAyV/3m+r5K8JG3EX+vFLFi73ucK4QXjqz
         ovEA==
X-Gm-Message-State: AJIora/AbFvCw5D8bCzI+0jJ+fnBV3stEzQ1Xawh6W6+QVhAh7valDGA
        WVfmdGMGyD778R9pdvc2BLT9B2V+6avd4Q==
X-Google-Smtp-Source: AGRyM1sqRwJRB180fChbUCnUrEL5XhWUC1kadOZa9iCDkf9BNHi0DcNLeZednrgRP2IN90yuomR7DA==
X-Received: by 2002:a17:906:3f49:b0:722:e1d2:f857 with SMTP id f9-20020a1709063f4900b00722e1d2f857mr3898823ejj.15.1655912547968;
        Wed, 22 Jun 2022 08:42:27 -0700 (PDT)
Received: from gmail.com (2001-4dd4-c5f9-0-6894-638d-e33f-5da2.ipv6dyn.netcologne.de. [2001:4dd4:c5f9:0:6894:638d:e33f:5da2])
        by smtp.gmail.com with ESMTPSA id e1-20020a056402330100b00435a997303bsm1941939eda.71.2022.06.22.08.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 08:42:27 -0700 (PDT)
Date:   Wed, 22 Jun 2022 17:42:25 +0200
From:   Stefan Lengfeld <stefan.lengfeld@inovex.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: Questions: IIO type for absorbance and float values in channels?
Message-ID: <20220622154225.gy26zikpdty64ufl@gmail.com>
References: <20220621121855.ynnv5ckymbmmvjcm@gmail.com>
 <20220621132909.00005439@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220621132909.00005439@Huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan, 

On Tue, Jun 21, 2022 at 01:29:09PM +0100, Jonathan Cameron wrote:
> > Is there another kernel subsystem/UAPI that fits this type of sensor
> > better?  (My guess would be: No, IIO is the correct subsystem.)
> 
> Based on your description, IIO is the best option.

Great. This means that I'm on the right track.


> > Question 1:
> > 
> > The sensor measures the absorbance[1] of a material. It's the negative
> > logarithmic quotient of the received and emitted light. It's a unit-less value.
> > 
> > As far as I can see there is currently no predefined IIO type in the kernel for
> > this.  I have search the list [2], but nothing matches.
> > 
> > Do I overlook something or what channel type should I use for this sensor
> > measurement value?
> 
> So the closest we've seen to this is some of the health sensors (pulse oximeter
> targeting devices) but in that case the processing is done with a custom userspace
> library so we just pass values on in fixed point.

I have look at the 'oximeter' drivers in the IIO framework, namely
afe440x and max3010x. All use the IIO type IIO_INTENSITY and the
max30100x drivers also use the modifiers IIO_MOD_LIGHT_*.

You also referenced the modifiers in your response to Andy.


> So probably needs a new channel type.

Ok. This makes it a bit harder for us, because we want to provide a
kernel driver that also works for older kernels.

Is there a private IIO type range that can be use in the meantime,
until a new IIO type is accepted and merged upstream?

Another side note/question: Is there a documented mapping between the
IIO types and physical SI units?  I have found nothing about that in the
IIO documentation. It would have helped me to better understand the
differences between the various types.

Just for reference. I mentioned the absorbance, but there is also
another equivalent physical value: the refelctance[1]. It's the same
value just without the negative logarithm.


> > So effectively the result of a
> > measurement can be a float-point value after it's computed in userspace.
> > 
> > Are floats really not supported as channel values? What is the recommend
> > approach to deal with these measurement values?
> 
> So, in kernel we basically can't do floats (not quite true, but near enough that
> it doesn't matter).  Given IIO can have in kernel consumers, that more or
> less rules out true floating point handling.

Yes, float point math is frowned in the kernel. I have read the kernel
hacking documentation [2]. :-) But I also know that the functions
kernel_fpu_begin() and kernel_fpu_end() exist (including there
performance problems ;-) ).


> We have in the past discussed simply passing them on to userspace (and
> hence ruling out any interpretation of the value) but so far no one has added
> the necessary support.  I'm not against adding that support, but I would
> want to see the code / docs to fully understand why we are doing it.
> It will be a special case in various code paths hence the extra consideration
> needed.

Ack on that. My take way is that it's currently not implemented but
theoretical acceptable upstream to pass float point values from the chip
to userspace. But it would require a good/valid show case and extra work
in the IIO subsystem.

I take this information to the sensor engineers. Maybe we can rework the
communication/data protocol to pass the measurement as integer values
with a separate scale factor that does not require raw float point
values.


> > I know that it's possible to provide a 'scale' attribute per channel to
> > userspace[4], which can be a float point number.
> 
> More fixed point - though we have a couple of precision options. The aim there
> is to ensure we only need a few bits of custom code to consume these values
> in kernel. Raw value can also be fixed point.

Yes. I already saw and tested the IIO_VAL_* defines (like
IIO_VAL_INT_PLUS_NANO or IIO_VAL_FRACTIONAL) that can be used to provide
fixed point scale values to userspace. They work great and maybe we can
use them.

Thanks again!

Kind Regards, 
Stefan

[1]: https://en.wikipedia.org/wiki/Reflectance
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/kernel-hacking/hacking.rst?id=9d2231c5d74e13b2a0546fee6737ee4446017903#n134
