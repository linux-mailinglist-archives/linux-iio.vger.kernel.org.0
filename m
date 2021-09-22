Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA404147EA
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 13:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbhIVLi4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 07:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbhIVLiv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2021 07:38:51 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7D4C061574
        for <linux-iio@vger.kernel.org>; Wed, 22 Sep 2021 04:37:21 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u18so10442808lfd.12
        for <linux-iio@vger.kernel.org>; Wed, 22 Sep 2021 04:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcmvpJZE2DA53pTZh1XoC9uyOBgFM1SCPQPbO8lLlOo=;
        b=hLt+wIFjQYOb8wkoZOBsLgRMZYcme72dNhQwjXvU4lBlf9uS+XUzKndOAgk4mqUs2X
         RlVG0nC5GM2e93LTVXSXvSjxn/IEgjLeVl3cohPltuzQwhknRiBMw1P261rewZxWPJBa
         0DoMfuwr9gG64PHOH+3ZEQlOvTcwp5cDdGCdP/CIQn38ICKtFFAspam3TdBIG4Jlhtbj
         KJbW3Q7uddy6c00YBgIFRKFAc0Demdp9rh5EdzKLdALfLeOZDx6cfCitjat5Kp8OJsKF
         ikh+RS/Rk7CR9b1ihx83B3+vPVXHzzP8RBR+pOJhDoJtt6EfY/YUsBTfCufZKCqNCtR4
         NueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcmvpJZE2DA53pTZh1XoC9uyOBgFM1SCPQPbO8lLlOo=;
        b=zPHVIa+oIIqd/jxj909ABevE/zzXw9gzFnWMsc0rlttQL2YytMdOmkDrMUVZZF5YSh
         FoN4JVBGskjI+T/A4t7UBxw9ZnpqIh+r3iC4U0eXDJ0t01zItK2+ElJZJgDfFhXS2Fpe
         vcIoQM9GBvQ0oi4hvwm1Kby6ID0dcovXiPvsDQ23yBbTU/Q4nhGtk+yYAI/f3ixsVAqm
         CvyQYKaic8DMncvmX0v7911Tr1FssEv4r4sJIGSsWb+ikS0u0a1oHn/pI5W377E5jZtt
         6Kci/X7IajB6vXD80pX8C+S+bdfqO1rp+9uChXCjT7+yLS6JUaj9EkylljVpZREkAWEJ
         s9zg==
X-Gm-Message-State: AOAM530Luhx+HFyMisaQ3cobJd6ey9p+6Md1IRg23tYTA7OH01qY+9AO
        Im/noM7CfalSaeqeoHX/BH0lTnrQelm8i5P5Q+eixEpDXww=
X-Google-Smtp-Source: ABdhPJxwZp1myzwSPgHj1JRwUFLpUimpsLg8dapxt2c+PNohxEOdA/SdyqygTmwdiVFzkBUxn66Gb64/KS8ToVvhl+E=
X-Received: by 2002:a2e:9942:: with SMTP id r2mr34580173ljj.92.1632310639466;
 Wed, 22 Sep 2021 04:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5Cwdn_-to8G+RvVUbG+UkYM7+budUsvWVLeY7PutoO2Mw@mail.gmail.com>
 <74f1974b-ac08-96f1-887e-99580a2bf212@axentia.se>
In-Reply-To: <74f1974b-ac08-96f1-887e-99580a2bf212@axentia.se>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 22 Sep 2021 08:37:08 -0300
Message-ID: <CAOMZO5Bhs3qLwgqGYHO7Oswr1qvarkzmNFyWQi3-_geZTj3BVA@mail.gmail.com>
Subject: Re: Reading ADC that comes from a multiplexer
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Peter,

On Wed, Sep 22, 2021 at 4:27 AM Peter Rosin <peda@axentia.se> wrote:

> Basically, the whole point is that you simply don't. The iio-mux exposes
> the channels as 8 new ADCs, and whenever you read a value from one of
> them, the iio-mux operates the gpios for you, giving you the impression
> that you have 8 independet ADCs. They are of course not independent, but...

Thanks for the clarification. It was helpful.

> That's exposed to user-space as:
>
> $ ls "/sys/bus/iio/devices/iio:device3"
> in_altvoltage2_compare_interval  in_altvoltage5_scale
> in_altvoltage2_invert            in_altvoltage6_compare_interval
> in_altvoltage2_raw               in_altvoltage6_invert
> in_altvoltage2_scale             in_altvoltage6_raw
> in_altvoltage3_compare_interval  in_altvoltage6_scale
> in_altvoltage3_invert            in_altvoltage7_compare_interval
> in_altvoltage3_raw               in_altvoltage7_invert
> in_altvoltage3_scale             in_altvoltage7_raw
> in_altvoltage4_compare_interval  in_altvoltage7_scale
> in_altvoltage4_invert            name
> in_altvoltage4_raw               of_node
> in_altvoltage4_scale             power
> in_altvoltage5_compare_interval  subsystem
> in_altvoltage5_invert            uevent
> in_altvoltage5_raw
> $ cat "/sys/bus/iio/devices/iio:device3/name"
> envelope-detector-mux

Ah, so that's my issue then. I don't see a new device inside
/sys/bus/iio/devices/.

I only see the original stmpe ADC:

ls "/sys/bus/iio/devices/iio:device0"
dev              in_voltage5_raw  in_voltage_scale  power
in_temp8_input   in_voltage6_raw  name              subsystem
in_voltage4_raw  in_voltage7_raw  of_node           uevent

Maybe my dts is not correct to make the mux appear under
/sys/bus/iio/devices/iio:device1.

Here is my dts that shows more context with the STMPE811 ADC:
https://pastebin.com/raw/7Nn2aAtN

stmpe811 is an mfd device that can be used as a touchscreen and as a normal adc.

I only use the adc functionality.

Any suggestions are welcome.

Thanks,

Fabio Estevam
