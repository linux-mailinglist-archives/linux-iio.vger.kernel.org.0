Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B85381D77
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 10:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbhEPI5V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 04:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbhEPI5V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 May 2021 04:57:21 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5521C061573;
        Sun, 16 May 2021 01:56:05 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id o59so1758811qva.1;
        Sun, 16 May 2021 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FyhBI/ZNBupoUTALEieNNind18REakMszINUdKUseIo=;
        b=qKe0c6vJ3tRyA8T7jcTUVREICvcXhdyymcsnAsSHpYzR+/+BPh1sd+1hngd1QS8Wym
         v6Kxn6Y+R5r8lQ608MzKnuMz3Sqt2kNvB8uYj0sCnnnm1hLxev7+q+mnsFtxEsIVsolj
         A2SVWRmM5T5pn89QfhkmPl6rJbmj+nOz5mqV+c9pO5tPOLWyoC5KHacI82cNZI7IoR1n
         iIuV8GBgyxwrYGQr2IxI5q6UdioPEeLKSL966r0q85tIAobRBcrei6inwTiIjCRTlK25
         W6eXNdE1RdzsjyrNv1MT6v3bJmiSCabgSskVzZCqk3I19wWp52MRkbu929PjiNeVM5L9
         g7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FyhBI/ZNBupoUTALEieNNind18REakMszINUdKUseIo=;
        b=Bp74Mn9xN0Jo2oviVxy3DnnFX3j+yPnidA6zhMe7Gn0f9XXYDYKi9K6r3U7vTiTIc/
         zvGkBc9M+FdMocEygnGsF5tu/Cg/1kmlJipPMuTH/ANrBa2y+F4azyisB/e0Vgg2Rfs2
         O9iji0eo58IuujWWNQOHIPhV+vaq6BH9FIfgxn7XLSkV4h9TDoYVA4TW5irdQtI0X+E2
         xRi8tgxhgtlWPffQr38gcGd7o9Aj9Y/smnaT2KWF7FbGe8+SN9BBqmAjPRbqbWFW9Z7S
         RS2UJw3dFFVNhz3DZ/jmX5NJW0hWg2Isteid7HuWTSKnVI0dLof4M7dfYeiKwyNx0PAj
         mCiQ==
X-Gm-Message-State: AOAM532FqAGsirgWvgs9XwFbCkdx4okB/bipL4TKPzsVi3SgjtLV1mvI
        zanFKgRN5//yvsyJE7z4DOk=
X-Google-Smtp-Source: ABdhPJyZgSugBwvMT4OLtM7k/PlOtbKviXB4ykm4w6Epj/ihziwBq912sh+AEk6gM80O/7frps81Yw==
X-Received: by 2002:a0c:8bd1:: with SMTP id a17mr54478447qvc.62.1621155364960;
        Sun, 16 May 2021 01:56:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v18sm8050212qkv.34.2021.05.16.01.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 May 2021 01:56:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [RFC PATCH v1 0/2] hwmon: (iio_hwmon) optionally force iio
 channel type
To:     Liam Beguin <liambeguin@gmail.com>, jdelvare@suse.com,
        jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
References: <20210516044315.116290-1-liambeguin@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <29235b1d-78f3-6d8f-567f-78ca6f350340@roeck-us.net>
Date:   Sun, 16 May 2021 01:56:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210516044315.116290-1-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/15/21 9:43 PM, Liam Beguin wrote:
> Add a devicetree binding to optionally force a different IIO channel
> type.
> 
> This is useful in cases where ADC channels are connected to a circuit
> that represent another unit such as a temperature or a current.
> 
> `channel-types` was chosen instead of `io-channel-types` as this is not
> part of the iio consumer bindings.
> 
> In the current form, this patch does what it's intended to do:
> change the unit displayed by `sensors`, but feels like the wrong way to
> address the problem.
> 
> Would it be possible to force the type of different IIO channels for
> this kind of use case with a devicetree binding from the IIO subsystem?
> 

That doesn't make sense to me. If an ADC is used to report temperatures,
it would be a thermistor, and the ntc_thermistor driver should be used.
Not sure what to do with currents, but overriding "voltage" with "current"
seems wrong.

Guenter

> It would be convenient to do it within the IIO subsystem to have the
> right unit there too.
> 
> Thanks for your time,
> Liam
> 
> Liam Beguin (2):
>    hwmon: (iio_hwmon) optionally force iio channel type
>    dt-bindings: hwmon: add iio-hwmon bindings
> 
>   .../devicetree/bindings/hwmon/iio-hwmon.yaml  | 41 +++++++++++++++++++
>   drivers/hwmon/iio_hwmon.c                     |  2 +
>   2 files changed, 43 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml
> 
> 
> base-commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
> 

