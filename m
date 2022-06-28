Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E67155D5DC
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345215AbiF1MVr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jun 2022 08:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345418AbiF1MVq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2022 08:21:46 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FAD2F03D
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2022 05:21:44 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id v38so11195822ybi.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2022 05:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1RoeZU8bguLbDz+ChoJvmiZXyjT68YTOSoBdHMsjfXU=;
        b=pAR8E+KisFopPRiDQxXlRc9ZEmdjfNFVzuz54nz2zMD0n2sD+Fv+KwNfGqc8A/T1qB
         Y7orGj7xr7zUBeOETUYkPcjCQ03VXSoOTS/XPIkIUFf6lw0wfNGEOHYKLfEYfbQXDDyv
         RMsPyQVcbF4E+HBgNH8Ie9btdfR7fw1Y0jn7gKRp8qLQU7fCE38nwou3Uh01Tw2NcIwD
         RRvP7ud3wCCWBwO+W2dd2XN0WAzqdpYYJ77awJwzKbN1Q327ur6ZeOltCmq0SP8QrTSA
         T3ZQiwCDaMKmAo3KjYrqZqUasDzykf/jfg+B7zFc53EgArrvqZAoHZFgB42fOKwsCmFV
         tdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1RoeZU8bguLbDz+ChoJvmiZXyjT68YTOSoBdHMsjfXU=;
        b=mESkLUP9+akKZU8xH130nBQlRqXJJ9Awk7jFSq8BUewYjlCGqgugJKJc2FX+FjeGgu
         fxyRlMCoV/3Ler6G3H/QLiWcz8w/BrSTmycV6NGjeMYKJ68glOGVWg8WDBNe4i1nmKQS
         uX/+k/U1tBOcYtzjBDlZ8hUhA9V5QA+qCPZUGBLNzjBnE5ka0HuRlylVAJqiURI5rfcw
         +R1jcxxjG9/eKpC+mfeERAi5vQ7EnLfXs+lLVrx3r14Fx66UgVqvKrYewZJOehvur9SZ
         DwVj+zpZjO0NGtmz5ZMDo2Ovg4hhB9sFiIxuLxVd1Tl+AVE1ciQiiO+BaHel/PWzyNvK
         cdgQ==
X-Gm-Message-State: AJIora/9+1Q5nTOJtP33LKpAJRfvksVmN8MRdU+zWC2Wj/Y2A+/lbQc6
        Z2ko3CVBE8hiPsJuqw1QS2JfezqOTjXdJGbUtwrEjD6VMrGd9w==
X-Google-Smtp-Source: AGRyM1v0D1yZ5q90X2UTW32zh1K/QSLKu8g7KjUEBaD139fyViJsm6yVnCM+AFNFZ8UTgWYUA7vY6FC8+SPnol2pSg4=
X-Received: by 2002:a25:dd83:0:b0:66c:8d8d:4f5f with SMTP id
 u125-20020a25dd83000000b0066c8d8d4f5fmr17132984ybg.79.1656418903743; Tue, 28
 Jun 2022 05:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220626122938.582107-1-jic23@kernel.org>
In-Reply-To: <20220626122938.582107-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jun 2022 14:21:06 +0200
Message-ID: <CAHp75VfjnE4dKtPb23cKJkHgkqwX2zNDMmCN07VtKCgcY6j9dQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] staging/iio: Clean up AD7746 CDC driver and move
 from staging.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 26, 2022 at 2:20 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Changes since v2:  Thanks to Andy Shevchenko for review
> - Fix the horrible mess I made of a rebase that meant v2 didn't build
>   mid patch set.
> - Fix various build issues I'd missed due to wrong make file (fails to
>   update variables after moving them, missing unaligned include,
>   failure to cleanup staging driver Kconfig / Makefile)
> - Change new ABI to _zeropoint and add more the description to hopefully
>   add clarify to what this is. I don't think it's going to be a particularly
>   common bit of ABI, but still good to get it right.


For non-commented patches (except 17th):
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
For commented, in case you address the comments I suggested, you may
also add a tag.

> Note that the --no-renames was used to preserve full code listing
> for the actual move out of staging to aid review. The ad7746 file is
> moved with no changes.
>
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/iio/cdc/ad7746.c
> similarity index 100%
> rename from drivers/staging/iio/cdc/ad7746.c
> rename to drivers/iio/cdc/ad7746.c
>
> This started out as an experiment with Vincent Whitchurch's roadtest
> testing framework [1] and that worked well so I carried on cleaning up the
> driver.  Note that if you are using roadtest rebased to current
> kernel, add CONFIG_UML_RANDOM as suggested by Vincent in reply
> to v2 of this series.  I still saw one freeze but with that config
> element added roadtest runs the tests successfully the vast majority
> of the time.
>
> Mostly this is standard tidy up, move to new interfaces, then move the driver
> out of staging, but there are a few other things in here.
>
> 1) Precision improvement for IIO_VAL_FRACTIONAL_LOG2.
>    The ad7746 is a 24 bit sensor and this highlighted that 9 decimal
>    places wasn't enough to keep the error introduced by
>    _raw * _scale from growing too large over the whole range (I couldn't
>    write a sensible test for it).  So I've proposed increasing the precision
>    of the calculation used to provide the sysfs attributes with this value
>    type and printing a few more decimal places (12), but only if overflow
>    will not occur due to val[0] > ULLONG_MAX / PICO
> 2) _zeropoint ABI addition.  This driver had an odd use of _offset for
>    the case of differential channels that applied the offset to both
>    of the differential pair (hence userspace shouldn't not apply it when
>    converting to the base units. That isn't inline with the existing
>    documentation for _offset and it wasn't clear to me that it made sense
>    at all.  To avoid confusion I've added this new ABI (_zeropoint) for this.
> 3) roadtest file - note this is not a complete test set for the driver and
>    mainly focused on the main channel reads and places I thought I might
>    have broken things whilst working on the driver.  Given roadtest isn't
>    upstream yet this test will have to wait. That doesn't block merging
>    the rest of the series.
>
> My conclusion on roadtest - Very useful indeed. I'd encourage others to
> consider developing some basic sanity tests for drivers they are working on.
> Hopefully my python code isn't too hideous to understand at least!
> Vincent, it might be worth thinking about some generic code to handle the
> 'variants' on correct ABI like I introduce here because I switched from
> a shared by type scale to an individual one per channel for the voltages.
> Both were ABI compliant so that sort of change is fine most of the time
> though we have to be careful with it.
>
> All comments welcome.  Note there may be changes that make more sense
> to do after moving this out of staging as long as there are no ABI changes involved
> etc.  Feel free to highlight those sorts of changes as well as anything more
> significant.
>
> [1] https://lore.kernel.org/all/20220311162445.346685-9-vincent.whitchurch@axis.com/
>
> Jonathan Cameron (17):
>   iio: core: Increase precision of IIO_VAL_FRACTIONAL_LOG2 when possible
>   iio: ABI: Fix wrong format of differential capacitance channel ABI.
>   staging: iio: cdc: ad7746: Use explicit be24 handling.
>   staging: iio: cdc: ad7746: Push handling of supply voltage scale to
>     userspace.
>   staging: iio: cdc: ad7746: Use local buffer for multi byte reads.
>   staging: iio: cdc: ad7746: Factor out ad7746_read_channel()
>   staging: iio: cdc: ad7764: Push locking down into case statements in
>     read/write_raw
>   staging: iio: cdc: ad7746: Break up use of chan->address and use
>     FIELD_PREP etc
>   staging: iio: cdc: ad7746: Drop unused i2c_set_clientdata()
>   staging: iio: cdc: ad7746: Use _raw and _scale for temperature
>     channels.
>   iio: core: Introduce _zeropoint for differential channels
>   staging: iio: cdc: ad7746: Switch from _offset to _zeropoint for
>     differential channels.
>   staging: iio: cdc: ad7746: Use read_avail() rather than opencoding.
>   staging: iio: ad7746: White space cleanup
>   iio: cdc: ad7746: Add device specific ABI documentation.
>   iio: cdc: ad7746: Move driver out of staging.
>   RFC: iio: cdc: ad7746: Add roadtest
>
>  Documentation/ABI/testing/sysfs-bus-iio       |  21 +-
>  .../ABI/testing/sysfs-bus-iio-cdc-ad7746      |  11 +
>  drivers/iio/cdc/Kconfig                       |  10 +
>  drivers/iio/cdc/Makefile                      |   1 +
>  drivers/iio/cdc/ad7746.c                      | 820 ++++++++++++++++++
>  drivers/iio/industrialio-core.c               |  32 +-
>  drivers/staging/iio/Kconfig                   |   1 -
>  drivers/staging/iio/Makefile                  |   1 -
>  drivers/staging/iio/cdc/Kconfig               |  17 -
>  drivers/staging/iio/cdc/Makefile              |   6 -
>  drivers/staging/iio/cdc/ad7746.c              | 767 ----------------
>  include/linux/iio/types.h                     |   1 +
>  .../roadtest/tests/iio/cdc/__init__.py        |   0
>  .../roadtest/roadtest/tests/iio/cdc/config    |   1 +
>  .../roadtest/tests/iio/cdc/test_ad7746.py     | 323 +++++++
>  15 files changed, 1211 insertions(+), 801 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-cdc-ad7746
>  create mode 100644 drivers/iio/cdc/ad7746.c
>  delete mode 100644 drivers/staging/iio/cdc/Kconfig
>  delete mode 100644 drivers/staging/iio/cdc/Makefile
>  delete mode 100644 drivers/staging/iio/cdc/ad7746.c
>  create mode 100644 tools/testing/roadtest/roadtest/tests/iio/cdc/__init__.py
>  create mode 100644 tools/testing/roadtest/roadtest/tests/iio/cdc/config
>  create mode 100644 tools/testing/roadtest/roadtest/tests/iio/cdc/test_ad7746.py
>
> --
> 2.36.1
>


-- 
With Best Regards,
Andy Shevchenko
