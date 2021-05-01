Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF62F370513
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 05:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhEADDK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Apr 2021 23:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhEADDH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Apr 2021 23:03:07 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C17C06174A;
        Fri, 30 Apr 2021 20:02:16 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id l17so43607oil.11;
        Fri, 30 Apr 2021 20:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X/nyZSBCvvo0nYQ/qrFQbuSlavg9ouEteFy0fWk4M1I=;
        b=GzUP1pHDrqKbgucd2NBdEQqiJs2QLpyao+itQqVUUKYzZCKpKsGve3xCT4KKVWFgwH
         O7QbjLDm8U79HntPlgmPcEm7k/gAwzym8aS4Lzl0V2n9IS7xUlq6rFgiplSAqW4SCsGV
         74sMBvi0PAIRBsz+sHNa2/fA1CBWtTtI4rllJeM9rT3k3LVMrlzjtQQ9zckGknIqR/yR
         b3v90Wm2BkNnQxIp3Cu5Uh/Zd+c9OZkVqZBe0GUJkm0Vswn1qAcYToUg5N9xWFxkKtsH
         BRP9LtBbEnPgBBa7uGCkHpIBHaYaNc2nK70IzaSbnq9EDUHjBgbArz96KuQ+gLfyZz9J
         yJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=X/nyZSBCvvo0nYQ/qrFQbuSlavg9ouEteFy0fWk4M1I=;
        b=QOtP2MzFzFBb2zG9269rup+sFxFcrgBR8YIdEQ+bzP53J+ctf5JLt4uOZkKQBgowxB
         PIRJnNDNeEN+iBqPLecnSHNzfQ1QQ/J9XjZ2WRGNeyJqNsOtNWDCUB7Xw50eTZLK3uUy
         CLmN5ow6PlYurEOxzVx0vToRkjK6lSbrzCBCf80bXg5tGcQlIBIlAvl15T5c0a0LAMee
         i+aO5mlCV0X5ofUe4MVXHxSzWOOg9FUCFwmBy1yOo8RYYdE9qrFWb3PcfLdFCbL820mg
         bYwZ7gYe/ITYehUAitpLQ/AofZI+GSgthx/vqLo4Vu5yDpuDDuIsdq2gWbaKvD4dPlVX
         hSIw==
X-Gm-Message-State: AOAM5312KxI/PP6Yo312P9FKwE73g1bsIym8aYl4xB/v71nuE/Z01GDU
        4NMwKdH434294hLzKTBGVRzYrlvX6/w=
X-Google-Smtp-Source: ABdhPJwTgtJF1UuZ268tXl8IcFwY+ZXuiPev6gTIGGDF5JcQiHZmd58JP+t8KQiuzD74BO9lE13vWg==
X-Received: by 2002:a05:6808:2c2:: with SMTP id a2mr6356333oid.147.1619838135803;
        Fri, 30 Apr 2021 20:02:15 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g3sm1134769otq.50.2021.04.30.20.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 20:02:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 30 Apr 2021 20:02:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        letux-kernel@goldelico.com
Subject: Re: [Q] tps65185 EPD PMIC temperature interface - which subsystem
Message-ID: <20210501030213.GA3198376@roeck-us.net>
References: <20210430232404.26d60fef@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430232404.26d60fef@aktux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 30, 2021 at 11:24:04PM +0200, Andreas Kemnade wrote:
> Hi,
> 
> I am going about to clean up stuff to further upstream support for my
> ebook readers. One question arises about the temperature interface of
> the EPD PMIC. Vendor code uses regulator_get_voltage in the EPDC
> driver to read a temperature in celsius and provides temperature through
> the regulator interface (besides sysfs/hwmon). That is ugly. But what
> are the options, if a kernel consumer should be able to reference it via
> devicetree phandle and read out from it? I see temperature sensors
> both in the iio and the hwmon subsystem, but do not find a description
> why these things are there. If I put it into the iio-subsystem
> iio_channel_get() and friends can be used, if I understand things
> correctly, there are no such functions in the hwmon subsystem, so I
> would not be able to use it there. So the better choice is to put it
> into the iio subsystem?
> 

I am guessing a bit here since a lot of context is missing. Presumably
there is a regulator driver. That regulator driver could register itself
with the hwmon subsystem using [devm_]hwmon_device_register_with_info()
and tell it to register a thermal zone sensor. It should then be possible
to read the temperature of that sensor using thermal_zone_get_temp().

Guenter

> On the consumer side, the temperature, which is pratically the ambient
> temperature, is used to choose the right waveform for the corresponding
> temperature range. Here are some code snippets in the vendor kernel:
> 
> temperature = regulator_get_voltage(fb_data->tmst_regulator);
> dev_dbg(fb_data->dev, "auto temperature reading = %d\n", temperature);
> 
> if (temperature != 0xFF) {
> 	fb_data->last_time_temp_auto_update = now;
> 	fb_data->temp_index = mxc_epdc_fb_get_temp_index(fb_data, temperature);
> }
> 
> static int mxc_epdc_fb_get_temp_index(struct mxc_epdc_fb_data *fb_data, int temp
> )
> {
>         int i;
>         int index = -1;
> 
>         if (fb_data->trt_entries == 0) {
>                 dev_err(fb_data->dev,
>                         "No TRT exists...using default temp index\n");
>                 return DEFAULT_TEMP_INDEX;
>         }
> 
>         /* Search temperature ranges for a match */
>         for (i = 0; i < fb_data->trt_entries - 1; i++) {
>                 if ((temp >= fb_data->temp_range_bounds[i])
>                         && (temp < fb_data->temp_range_bounds[i+1])) {
>                         index = i;
>                         break;
>                 }
>         }
> 
> ... and writing that index to some register in the EPDC.
> 
> As the consumer is not upstream (I have a basic drm-based variant also
> in my clean-up queue), compatibilty to existing systems does not matter
> that much. Also I see no drivers for similar chips upstream.
> 
> Regards,
> Andreas
