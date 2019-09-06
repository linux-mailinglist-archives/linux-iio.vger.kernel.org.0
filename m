Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B738BABFAB
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2019 20:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436630AbfIFSqe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Sep 2019 14:46:34 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36140 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436545AbfIFSqR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Sep 2019 14:46:17 -0400
Received: by mail-qk1-f193.google.com with SMTP id s18so6662544qkj.3;
        Fri, 06 Sep 2019 11:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LTlygxheqA0ZZNrkDVt9guFUuqGEjiIr9KDMB3qJhbQ=;
        b=YcJJtbieeTzVLmfL5VW7qavVMuiq6c51Ci8Czq2c5VTnQjZ7pseehJ8KRlQyS/JYi5
         mXVeRoA/nd217dCC26yJq5axmKlBP8fnPAjI7zCYCd/k2cmB33hGQjurSlPaBu0CIegI
         2qYJeOulZow6Eug0s4NX9oYTaiOcgkdxDfR31y+4Ub5rs9hrFE7xhbi87LxUS0ACVE1W
         WW/B+ST9KM320vth5QdRLYD6cPST30tWoevZuqY1O7H/554FeWGsGgnFMo30WKwyXQv9
         3lM5Ljc70Zw8Qs81wSO+MWuOdVt9FseZZxB6KzEL7zGE6JscwsSeExDkQlRfe7rRwsjY
         fksA==
X-Gm-Message-State: APjAAAXKP/sDfaQ0XFHiHHif8TidDea/eifQaVJjkSBpqGZYVq3zbEVl
        tOExf91rkCW6EbvnLQBpQCKDzRUEYV3WmMM1oLU=
X-Google-Smtp-Source: APXvYqwe+f4RMkONNgT86kugBZ72qvP1vpX49oBMpid8ck5WPBtzUo7ndLc7rEo7ORmlDBeuo0opYcPQ+aZzocH9T0I=
X-Received: by 2002:a05:620a:145a:: with SMTP id i26mr10522538qkl.352.1567795576166;
 Fri, 06 Sep 2019 11:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190906154609.2421410-1-arnd@arndb.de> <20190906165527.GW2680@smile.fi.intel.com>
In-Reply-To: <20190906165527.GW2680@smile.fi.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 Sep 2019 20:46:00 +0200
Message-ID: <CAK8P3a1S2g__qn4LP+z=ah4L2AJCHndn3LWbMkPedsu_HOd1_g@mail.gmail.com>
Subject: Re: [PATCH] [RFC] Revert "iio: hid-sensor-attributes: Convert to use int_pow()"
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 6, 2019 at 6:55 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 06, 2019 at 05:45:55PM +0200, Arnd Bergmann wrote:
> > The change to use the generic int_pow instead of the private version
> > caused a number of build issues on 32-bit architectures and makes
> > it generally less efficient because of the 64-bit math:
> >
> > drivers/iio/common/hid-sensors/hid-sensor-attributes.o: In function `hid_sensor_write_samp_freq_value':
> > hid-sensor-attributes.c:(.text+0x29c): undefined reference to `__aeabi_uldivmod'
> > drivers/iio/common/hid-sensors/hid-sensor-attributes.o: In function `hid_sensor_read_raw_hyst_value':
> > hid-sensor-attributes.c:(.text+0x420): undefined reference to `__aeabi_uldivmod'
> > hid-sensor-attributes.c:(.text+0x448): undefined reference to `__aeabi_uldivmod'
> > drivers/iio/common/hid-sensors/hid-sensor-attributes.o: In function `hid_sensor_write_raw_hyst_value':
> > hid-sensor-attributes.c:(.text+0x570): undefined reference to `__aeabi_uldivmod'
> >
> > There is probably a nicer solution to this, but for the moment,
> > the revert makes it compile again.
> >
> > Fixes: 473d12f7638c ("iio: hid-sensor-attributes: Convert to use int_pow()")
>
> Does the fix [1] works for you?
>
> [1]: https://lore.kernel.org/linux-iio/6851830d050ddb2f27d1e6969755ee4f3293d37c.camel@intel.com/

It looks like a better fix, I applied that on my test build tree now, will
let you know if I find any remaining unexpected problems with it.

       Arnd
