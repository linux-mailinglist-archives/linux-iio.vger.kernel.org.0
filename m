Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF97E479D01
	for <lists+linux-iio@lfdr.de>; Sat, 18 Dec 2021 22:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhLRVUu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Dec 2021 16:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbhLRVUl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Dec 2021 16:20:41 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42457C061401
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 13:20:41 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id z9so6195666qtj.9
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 13:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CJIkiEgrK7HOSgYZv+eMfdE+z3WvuLWURgphnS3i4U8=;
        b=mdlOSDZDozRGrrnD8d48TrYsxPEV8DLvyBrpxPNQIAWFTE/02+FkT2fcjUcHXfZBQK
         JeM+2hZXoD4MPgqToc28aokG7Klt1g8xN9XtT7AYQe4UISodt/1KRExn91SddT9SyX8H
         9Kjv+5O/THop+B3zjipZMZDkP+urrUGvvP+JJwOGYdi0Ew7qIVdFy8uokOUBmJFmE4tv
         sgLBl1/3rVTfpGlpLErXDD5XxC6OUsLGrvb7r4V7tpRjnGcWgq4T0HippQduzqoyZxBC
         WcwCVt94Sz6AWieSi4IZ2cRc4HC58dUtDgTGHmQigedhIb4vPI0G0UYgtn/bClx8qLtJ
         ioZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CJIkiEgrK7HOSgYZv+eMfdE+z3WvuLWURgphnS3i4U8=;
        b=VIv+aQd81JTOW3oS26tTVLm0akJLs/16HJKHuc2cDFX+iiBdNuH4j5pwiiQ/YwIr+o
         PkPpiZIVfw0mC+jdhK4Ej+rxO3xIFNqwDJB7dP5N7/vXgmpv/h8L7nIqIrurNBnlA2Zj
         rOPdHGzxgd4RaHHxTIai975zqgCKar+xOt3Eba71A54s+5Rqk5t0ktcXeS2ClFwc8+T4
         SB66+GPv8UnCnrla/nqjjJ/ZlhuA7ZAxKV9sJ3F349qh4Ud1EELTKg/tdObCrIqDenCb
         YgEaeujoMaobLIEUFaL8ui2IZlOKL1wAVT951doWTXrDVCBasHNWUK/a1dkiYXvpbeB3
         wcmg==
X-Gm-Message-State: AOAM532Rofx9BDoeaNKd2SMp2VDpVJy+6lFSi+6GtsA+zdWMNbuvf6zM
        cwJb94wrGziezrOG6IoDK9Y=
X-Google-Smtp-Source: ABdhPJza0cx/Te7KThzUuGJEYMMXBA7lxjsZI25f9v+yM7D1aetxY4KPCVAkuJTzWCkd1WKHoW0ccQ==
X-Received: by 2002:ac8:5b8c:: with SMTP id a12mr7462631qta.353.1639862440522;
        Sat, 18 Dec 2021 13:20:40 -0800 (PST)
Received: from marsc.168.1.7 ([2804:30c:b14:b100:c080:51c0:2de2:c68a])
        by smtp.gmail.com with ESMTPSA id o4sm7447303qkh.107.2021.12.18.13.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 13:20:40 -0800 (PST)
Date:   Sat, 18 Dec 2021 18:20:37 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 16/17] iio:adc:ad7280a: Document ABI for cell balance
 switches
Message-ID: <Yb5QpW+Ckk3Fomds@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
 <20211205202710.2847005-17-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205202710.2847005-17-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Looks fine from my side.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

On 12/05, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Very minimal ABI docs. This is unusual enough that I'd expect anyone
> who actually wanted to touch them to go look at the datasheet.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a
> new file mode 100644
> index 000000000000..83b7efe6aa07
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a
> @@ -0,0 +1,13 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_balance_switch_en
> +KernelVersion:	5.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Used to enable an output for balancing cells for time
> +		controlled via in_voltage_Y-voltageZ_balance_switch_timer.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_balance_switch_timer
> +KernelVersion:	5.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Time in seconds for which balance switch will be turned on.
> +		Multiple of 71.5 seconds.
> -- 
> 2.34.1
> 
