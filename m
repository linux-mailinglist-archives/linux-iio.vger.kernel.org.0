Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE984414944
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 14:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbhIVMqL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 08:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbhIVMqL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2021 08:46:11 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DC2C061574
        for <linux-iio@vger.kernel.org>; Wed, 22 Sep 2021 05:44:40 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i4so11489779lfv.4
        for <linux-iio@vger.kernel.org>; Wed, 22 Sep 2021 05:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N6zy0XIQ/Ot4nV1fJewZ2Mzh0jnz4dCBiZEPZp+vzwQ=;
        b=GxpOln0iQ5Taha7w32msAJiU4luYcrITT/LN6seEyswmjNzyw6cv5oSOaN2/wNenS6
         T/9fi83cFyfkQWytSKxvrKdOae5Ri078OzMtMFfnDGoYPb1b3MPU2JV2bDsJt/d0D4RF
         6unz0EbCdsoEpdk1TJrcoeEwNK1x9kF4Wmi+i6YWSdhgihewwPxQuk1VPkVp2llPbE3U
         T5merrcMAj3Z61ROwocwHcwh5nO4zHzyokywNuIg+vz3uZ1cOPD4V6Z7OD3AePNi3PKB
         HyRFXy6RZG41PLgOFvGG2/faKXwHPWM5Ih4VPz7MvEu2r/LNUyWSvu8Nsa3kxkoWaklF
         TmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6zy0XIQ/Ot4nV1fJewZ2Mzh0jnz4dCBiZEPZp+vzwQ=;
        b=rDRi0r23f/Fw5McoVbJDPiNwuveccTrWVjvbyhZ9orWGkFi6xFBa/6fXpU9ZkU166U
         tmqUyrETl9KP+xJFTBJcAE2RBaAQrQ16TI9V/inkuayE4kp8jOamd1sOnxajXra+uuaQ
         YocBgj1dgM/mavGhmLTBhRKH5wrXkWcQTcGEmvXYcsinWEaPjyX+9lQy1M6qRT9QXMwl
         h+C/T1/nMXGkWH2IIYtw5/THBiGb2OYh7zaIeGU0Y8itzfX5XcVVJqFXsx9ohdwVpsfk
         98E+nviFwTWHlAMyigCVPyea3lE4vs6ju3GsLFP5MxsC1YkGBrOz71Y97XJgL/ewkktJ
         g9OQ==
X-Gm-Message-State: AOAM531bdJ9BTJJN24iKK+XTq7j3KxBmthVeUFd7BDb6gGcQcUNTVAYX
        rgaUbLcRIPThXPNd/4e0oz+DUcjuDPqg2Ei0XfOEWSUfs8s=
X-Google-Smtp-Source: ABdhPJw7wBjZWopnAvqKnwuEsD6KIR6co3Aq2dOcWaemKGQoVnAEgHb/DVfCQEdGKj6rsIMEQpAn4m13TjIv+SVmrJA=
X-Received: by 2002:a2e:9942:: with SMTP id r2mr34931266ljj.92.1632314679248;
 Wed, 22 Sep 2021 05:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5Cwdn_-to8G+RvVUbG+UkYM7+budUsvWVLeY7PutoO2Mw@mail.gmail.com>
 <74f1974b-ac08-96f1-887e-99580a2bf212@axentia.se> <CAOMZO5Bhs3qLwgqGYHO7Oswr1qvarkzmNFyWQi3-_geZTj3BVA@mail.gmail.com>
In-Reply-To: <CAOMZO5Bhs3qLwgqGYHO7Oswr1qvarkzmNFyWQi3-_geZTj3BVA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 22 Sep 2021 09:44:28 -0300
Message-ID: <CAOMZO5A0a20_+JHmCMYXLuZYCE04GDTqt0x_GXtVxA5Q4MSAog@mail.gmail.com>
Subject: Re: Reading ADC that comes from a multiplexer
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 22, 2021 at 8:37 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Peter,
>
> On Wed, Sep 22, 2021 at 4:27 AM Peter Rosin <peda@axentia.se> wrote:
>
> > Basically, the whole point is that you simply don't. The iio-mux exposes
> > the channels as 8 new ADCs, and whenever you read a value from one of
> > them, the iio-mux operates the gpios for you, giving you the impression
> > that you have 8 independet ADCs. They are of course not independent, but...
>
> Thanks for the clarification. It was helpful.
>
> > That's exposed to user-space as:
> >
> > $ ls "/sys/bus/iio/devices/iio:device3"
> > in_altvoltage2_compare_interval  in_altvoltage5_scale
> > in_altvoltage2_invert            in_altvoltage6_compare_interval
> > in_altvoltage2_raw               in_altvoltage6_invert
> > in_altvoltage2_scale             in_altvoltage6_raw
> > in_altvoltage3_compare_interval  in_altvoltage6_scale
> > in_altvoltage3_invert            in_altvoltage7_compare_interval
> > in_altvoltage3_raw               in_altvoltage7_invert
> > in_altvoltage3_scale             in_altvoltage7_raw
> > in_altvoltage4_compare_interval  in_altvoltage7_scale
> > in_altvoltage4_invert            name
> > in_altvoltage4_raw               of_node
> > in_altvoltage4_scale             power
> > in_altvoltage5_compare_interval  subsystem
> > in_altvoltage5_invert            uevent
> > in_altvoltage5_raw
> > $ cat "/sys/bus/iio/devices/iio:device3/name"
> > envelope-detector-mux
>
> Ah, so that's my issue then. I don't see a new device inside
> /sys/bus/iio/devices/.
>
> I only see the original stmpe ADC:
>
> ls "/sys/bus/iio/devices/iio:device0"
> dev              in_voltage5_raw  in_voltage_scale  power
> in_temp8_input   in_voltage6_raw  name              subsystem
> in_voltage4_raw  in_voltage7_raw  of_node           uevent
>
> Maybe my dts is not correct to make the mux appear under
> /sys/bus/iio/devices/iio:device1.

Just realized that iio-mux.c does not get probed.

In mux_probe():

parent = devm_iio_channel_get(dev, "parent");

is always returning -EPROBE_DEFER, even though I passed:

        io-channel-names = "parent";
