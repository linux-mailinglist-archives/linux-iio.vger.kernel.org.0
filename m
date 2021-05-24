Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA09438E38D
	for <lists+linux-iio@lfdr.de>; Mon, 24 May 2021 11:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhEXJyC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 24 May 2021 05:54:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3922 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbhEXJyC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 May 2021 05:54:02 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FpXVs6dtWzCwPQ;
        Mon, 24 May 2021 17:49:41 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 17:52:32 +0800
Received: from localhost (10.52.125.72) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Mon, 24 May
 2021 10:52:29 +0100
Date:   Mon, 24 May 2021 10:50:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 1/5 v3] iio: st_sensors: Create extended attr macro
Message-ID: <20210524105042.00002e59@Huawei.com>
In-Reply-To: <CACRpkdZu0PjH4ciJMSRZ0bywYFjrfWvvfvcpxPQQ+4P=rTNmTw@mail.gmail.com>
References: <20210518230722.522446-1-linus.walleij@linaro.org>
        <323cc45a-6db2-8732-d3b0-784b1250d7f7@redhat.com>
        <20210522191527.228f795a@jic23-huawei>
        <CACRpkdZu0PjH4ciJMSRZ0bywYFjrfWvvfvcpxPQQ+4P=rTNmTw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.125.72]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 24 May 2021 11:43:11 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sat, May 22, 2021 at 8:14 PM Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > @Linus, for IIO stuff, please put a cover letter on series as it makes it
> > easier for people to reply with things like this  
> 
> OK sorry about that, I'll try to keep it in mind.
> 
> > and still let me use b4
> > without manual tweaking.  
> 
> b4 only need the patches to be sent in a thread which I
> actually did, at least this works fine for me from here:
> 
> tmp]$ b4 am -t 20210518230722.522446-1-linus.walleij@linaro.org
> Looking up https://lore.kernel.org/r/20210518230722.522446-1-linus.walleij%40linaro.org
> Grabbing thread from lore.kernel.org/linux-iio
> Analyzing 7 messages in the thread
> ---
> Writing ./v3_20210519_linus_walleij_iio_st_sensors_create_extended_attr_macro.mbx
>   ✓ [PATCH 1/5 v3] iio: st_sensors: Create extended attr macro
>     + Reviewed-by: Hans de Goede <hdegoede@redhat.com> (✓ DKIM/redhat.com)
>   ✓ [PATCH 2/5 v3] iio: accel: st_sensors: Support generic mounting matrix
>   ✓ [PATCH 3/5 v3] iio: accel: st_sensors: Stop copying channels
>   ✓ [PATCH 4/5 v3] iio: magnetometer: st_magn: Support mount matrix
>   ✓ [PATCH 5/5 v3] iio: gyro: st_gyro: Support mount matrix

That only adds the Reviewed-by for patch 1 which was not Hans'
intention.  If the reply was to a cover letter it would apply to all of the patches.

Thanks,

Jonathan


>   ---
>   ✓ Attestation-by: DKIM/linaro.org (From: linus.walleij@linaro.org)
> ---
> Total patches: 5
> ---
>  Link: https://lore.kernel.org/r/20210518230722.522446-1-linus.walleij@linaro.org
>  Base: not found
>        git am ./v3_20210519_linus_walleij_iio_st_sensors_create_extended_attr_macro.mbx
> 
> But I guess that without a 00/nn it is maybe not as clear if a series was
> sent as a thread.
> 
> Yours,
> Linus Walleij

