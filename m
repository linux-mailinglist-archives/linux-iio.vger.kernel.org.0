Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6078E35F025
	for <lists+linux-iio@lfdr.de>; Wed, 14 Apr 2021 10:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhDNIsy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Apr 2021 04:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbhDNIsv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Apr 2021 04:48:51 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24FEC061574
        for <linux-iio@vger.kernel.org>; Wed, 14 Apr 2021 01:48:28 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id b17so13919975pgh.7
        for <linux-iio@vger.kernel.org>; Wed, 14 Apr 2021 01:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6yke+bSyJ0j5ZSy3rVqv9cM/2GRtMq6TK4p2whz+uwA=;
        b=DI+Kk0QLPS3f2U03YaHPkzF55zVZotaseZOylfw6rJmclD4gZqAXEwtiprwPuzgWQa
         pBXREj+CbeDZEswr1rMMjYpoIUlPTFyCLoaETaKvxsZaPCPQ+N6FVh9Uz3J4g9N86MPn
         jw7KXiRoTFqKuZXipKw+dhoLyCkuFoQD7z7ls60FaqEWjPvgRLNVarMKW1AO0efKS1hj
         hMsW9RSlrDdKjCYeQQ0WL6NPXElEmvVzuuWkbR56jGzqRhuqhtZ9K1WHS66l55twaRRP
         nD+y4bncLcGBsoixG/YtOOR53cG3SKV38eGhMT8Wt4SeDwJcFDBpg3UrUderNwFDJ/R/
         UIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6yke+bSyJ0j5ZSy3rVqv9cM/2GRtMq6TK4p2whz+uwA=;
        b=kF1GfAMQBf65nRTsgG6ijXllEJde4ao/fpit9H33xhUeE/rthkoNi8/mthAnNhdihp
         2MGmAFbVDSpX3vJgHFwef7u6zP3fvBptgi+ed+qqftQTebvx5OiaAmWY1ftv1atM08L6
         q60fg8VoZ63Uux71PCpUHIE85QGm/82EcsddN1v7ez4wJFQ1fHI6cZRt66pNbxj9XcoJ
         tfIqT0rxLK7kXI6ox5HwXMB+2+wHG3F8uZ//64j8nfCDaF0DRnSjq+9Kn0vztUejP8r+
         VX0XL3H9c5kIDo+mhj40t9f3PPhLtjoiHRYDdt6Hl4WlCl+qLYVol8by69AKAs9NlcFZ
         s88g==
X-Gm-Message-State: AOAM5336dwXi5Ml6TdfjO1UTqWQUq70FYRSIBK1qCYMXFml21sTPUPC5
        wpcCn8P4/IU1v8YzGYcR71Hq0l41gaSuRRGg7y/EOS06Kikatw==
X-Google-Smtp-Source: ABdhPJyxzshPp0xeAOVqJ3mANQF8IcTs5jH9Es6CkBOe+5jRmcGRssyYvRWjzkfD4mDXMnaO64l6w+V34WiiDJi6mEc=
X-Received: by 2002:a65:6645:: with SMTP id z5mr35727415pgv.273.1618390108168;
 Wed, 14 Apr 2021 01:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <0ba66635-920a-2541-7b92-447cdb37764b@gentoo.org>
In-Reply-To: <0ba66635-920a-2541-7b92-447cdb37764b@gentoo.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 14 Apr 2021 11:48:17 +0300
Message-ID: <CA+U=DsopM1MXZJEP-h1rjny-fwhvY0s281L5W2EjYe0gD=FDiA@mail.gmail.com>
Subject: Re: CONFIG_HID_SENSOR_IIO_TRIGGER depends on CONFIG_IIO_TRIGGERED_BUFFER
To:     Thomas Deutschmann <whissi@gentoo.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 14, 2021 at 10:47 AM Thomas Deutschmann <whissi@gentoo.org> wrote:
>
> Hi,
>
> when you try to build kernel with
>
>    CONFIG_HID_SENSOR_IIO_TRIGGER=m
>    # CONFIG_IIO_TRIGGERED_BUFFER is not set
>
> build will fail with
>
> > ERROR: modpost: "iio_triggered_buffer_cleanup" [drivers/iio/common/hid-sensors/hid-sensor-trigger.ko] undefined!
> > ERROR: modpost: "iio_triggered_buffer_setup" [drivers/iio/common/hid-sensors/hid-sensor-trigger.ko] undefined!
>
> So CONFIG_HID_SENSOR_IIO_TRIGGER should depend on
> CONFIG_IIO_TRIGGERED_BUFFER.

My bad here.
Will send a fix.
This is a peculiar case where the his-sensor-trigger module gets built
without any sensor drivers to use it.

>
> This was reported via https://bugs.gentoo.org/782496.
>
>
> --
> Regards,
> Thomas Deutschmann / Gentoo Linux Developer
> fpr: C4DD 695F A713 8F24 2AA1 5638 5849 7EE5 1D5D 74A5
>
