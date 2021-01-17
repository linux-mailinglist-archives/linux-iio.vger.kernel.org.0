Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154412F9629
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jan 2021 00:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbhAQXNh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Jan 2021 18:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729936AbhAQXNc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Jan 2021 18:13:32 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29A4C061573
        for <linux-iio@vger.kernel.org>; Sun, 17 Jan 2021 15:12:52 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id q1so29449532ion.8
        for <linux-iio@vger.kernel.org>; Sun, 17 Jan 2021 15:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=im4bE/w84JjMB3cjJEm1Ye+OqhnCNifbTp8lXLt1We0=;
        b=Afqa8byszZdYQTZLOZg7IEhJspPlIKfJV7WV+7C9Mvr8hgPTFzw6uUsBcqVQ31wZmy
         evi5qI+GqMha+KtwoSfQiUZgyKAQz4mzC9V7P2bxIz7O+LZj/5HkYqZmIffEMpfxJ+7D
         l3j//fJqgn9iPrZnN97jLdfV4s30LxgB3SgYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=im4bE/w84JjMB3cjJEm1Ye+OqhnCNifbTp8lXLt1We0=;
        b=IEnZSeKYQApD/iq/GT4+n8galAF6Ge7ga5lu/1TMjziSMuPAclToOnhWPAxzptZUB7
         Nepsk3YABEYgP/BubuSsR80ML4Y8rTWpYJ4eLc5/3OsA6hXY0pNOwzIu9DKLKIeiaWO5
         L64KcYW4o0I2GnH0LyyRpjs41w9pcs9BDoO/nEAEZ9tjVbB0rE5EazweFqYBS0KUIBDq
         p0GZWSwTrjpUIlkhaJgUVVZGsUmEdAILmso4IaRS1OvCZybK4GSChGwDecTPypPwsZFE
         rd7EKqKHdJ+yvCGUqOKxGfSnCOXiDpsWfsTd8JTvCCiexCIoyi7cXpslNkU7tjBko22q
         45mw==
X-Gm-Message-State: AOAM533iFLr3yL6U1g49llKD2K468c8ZJK1OiNl9IKzDOa+BFXE5wFj0
        sOZmvfmcG9kELLR8mD5+Y+000nnVsRamcZSyFEGrYQ==
X-Google-Smtp-Source: ABdhPJwfISpW/ABfzDse9PklBb08typP9x3DVmjhW/pCpEIKFNNaDrzlkn4grJwDWB758b0BOL4HCIX2lLgFRVtp5J8=
X-Received: by 2002:a92:a054:: with SMTP id b20mr19327815ilm.98.1610925172092;
 Sun, 17 Jan 2021 15:12:52 -0800 (PST)
MIME-Version: 1.0
References: <20210117153816.696693-1-jic23@kernel.org> <20210117153816.696693-6-jic23@kernel.org>
In-Reply-To: <20210117153816.696693-6-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 17 Jan 2021 15:12:40 -0800
Message-ID: <CAJCx=gkLbAnUsZ5cybxWRq8dbrdk8qvhVMje0FCs2NKPenW5Ug@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] iio:ABI docs: Combine sysfs-bus-iio-humidity-hdc2010/hdc100x
 into one file
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Eugene Zaikonnikov <ez@norphonic.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 17, 2021 at 7:40 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> These contain only one entry for out_current_heater_raw (_available).
> Document this in a new sysfs-bus-iio-humidity file, and make it a little
> more generic by allowing for non 0/1 values.
>
> Fixes:
> $ scripts/get_abi.pl validate
> Warning: /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010:0  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x:0
> Warning: /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010:1  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x:1
>
> Cc: Eugene Zaikonnikov <ez@norphonic.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  ...s-bus-iio-humidity-hdc2010 => sysfs-bus-iio-humidity} | 3 ++-
>  Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x | 9 ---------
>  2 files changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010 b/Documentation/ABI/testing/sysfs-bus-iio-humidity
> similarity index 79%
> rename from Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010
> rename to Documentation/ABI/testing/sysfs-bus-iio-humidity
> index 5b78af5f341d..cb0d7e75d297 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-humidity
> @@ -6,4 +6,5 @@ Description:
>                 Controls the heater device within the humidity sensor to get
>                 rid of excess condensation.
>
> -               Valid control values are 0 = OFF, and 1 = ON.
> +               In some devices, this is just a switch in which case 0 = OFF,
> +               and 1 = ON.
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x b/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x
> deleted file mode 100644
> index b72bb62552cf..000000000000
> --- a/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -What:          /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw
> -What:          /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available
> -KernelVersion: 4.3
> -Contact:       linux-iio@vger.kernel.org
> -Description:
> -               Controls the heater device within the humidity sensor to get
> -               rid of excess condensation.
> -
> -               Valid control values are 0 = OFF, and 1 = ON.
> --
> 2.30.0
>
