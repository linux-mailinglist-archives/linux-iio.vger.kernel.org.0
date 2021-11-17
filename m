Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1054454BC1
	for <lists+linux-iio@lfdr.de>; Wed, 17 Nov 2021 18:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhKQRRf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Nov 2021 12:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbhKQRRf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Nov 2021 12:17:35 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF31C061570;
        Wed, 17 Nov 2021 09:14:36 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y12so14212760eda.12;
        Wed, 17 Nov 2021 09:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hUu3vxHWsDQg639aiNLE2xiOomzS21tmbZdfXQFwxnQ=;
        b=oLiP4Dyxkp8Wjwp+tKQBjVRNXPYgoObkG4yHWiNcxcYWtgha3Zs4XRRgCloMjca0HD
         siJaUu1CjmF7uVqmCNLABGxqb4HSoKJP++MzZOL+vhJwMnXcerMyUvWnF1vwehB8pmGD
         xN5p5ZgXLMS4JuISg9yy7AJ4Q5HFBMz9ipYL/DqSLpcbO6L8EqhNoUBpa1FnFgoCJboO
         sun5vxuJzfAJ/zV/DLyDW2ufAOYbvMJImjGOpT6LcN2ptjaJqlWCw7zlkPdP7gbaP+0P
         tdL4/2h7aMXK72i41LU/QSFpZbAon8SpxuOEh6/iKiF4e9bpb2OLtHLxbYZc2FI0wJpx
         Qw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hUu3vxHWsDQg639aiNLE2xiOomzS21tmbZdfXQFwxnQ=;
        b=Jz4IiSvyvTCLStkLhpBEfg8STMyUkA5Z5+8IdsB+hp+wNB42f/Y4LRKrLqwBSNgyxL
         G49LBn5Lz5q0iBFm3glth36c0Z3oOd7rMnRFIe1AjQ7rcBH78X3npqJS6ofMoNUL+kUW
         jrvPn3BMm5uKFUK9U8L9JTddQ1NhMcA/AnnTsWbtXJauXhc1sz5ET7rX2vXFxxFe7Ald
         kPDpzSYVasLEmB3uCr8XOYVfn3833RkfZDZnHF3Q0HyDCqpQKT/g4kXjifWrShjC3uMA
         hveWjbsWv7NATBMSmk6zTem41r3wCJcFOqmchBq3xEPOZC5MGFBsRsykyJknYHF7FD4C
         xqrA==
X-Gm-Message-State: AOAM530dG+xL1ZbU03Eh8og9Wrc8FGJVVKk9bTyTnMBbMkGlJWyMWnNG
        tf+lW2MwHUA0oFqIBGCz8IhhPj+Mn5qDt556dD4=
X-Google-Smtp-Source: ABdhPJxPNGb7sIRKkHf64pq/IAE1bvXx3ymCyjWU2B39T+ktVLR//khn4aikRDT7vXZyvylhOgqAv7DkJHF0Q0UFY3Q=
X-Received: by 2002:a50:9ec9:: with SMTP id a67mr365143edf.238.1637169275100;
 Wed, 17 Nov 2021 09:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20211117161028.11775-1-anand.ashok.dumbre@xilinx.com>
In-Reply-To: <20211117161028.11775-1-anand.ashok.dumbre@xilinx.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 Nov 2021 19:13:54 +0200
Message-ID: <CAHp75VdkGHvauZG7Nw4dDEb4+ZeVS4Pt2x05EiOiVCBVv8s10w@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Add Xilinx AMS Driver
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>, git <git@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 17, 2021 at 6:46 PM Anand Ashok Dumbre
<anand.ashok.dumbre@xilinx.com> wrote:
>
> Add Xilinx AMS driver which is used for Xilinx's ZynqMP AMS controller.
> This AMS driver is used to report various interface voltages and temperatures
> across the system.
> This driver will be used by iio-hwmon to repport voltages and temperatures
> across the system by using various channel interfaces.
> This driver handles AMS module including PS-Sysmon & PL-Sysmon. The binding
> documentation is added for understanding of AMS, PS, PL Sysmon Channels.

Thanks and wait a bit, please. No need to send patches so often. We
haven't settled down yet on v9. Here you effectively ignored my
comment given again patch 5/5. Why?

...

> Changes in v10:
>         - Fixed licence in zynqmp.dtsi.
>         - Changed the macros to use BIT().
>         - Realign some code to fit within 100 chars.
>         - Modified readl_poll_timeout usage.

>         - Usage of array_size() instead of check_mul_overflow().

Why? I have asked you why you haven't used kcalloc there as well.

>         - Usage of dev_err_probe() instead of dev_err().
>         - Usage of kcalloc instead of kzalloc()

-- 
With Best Regards,
Andy Shevchenko
