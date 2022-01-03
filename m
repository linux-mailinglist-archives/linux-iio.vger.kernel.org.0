Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A01483680
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jan 2022 18:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiACR7F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jan 2022 12:59:05 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:49609 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiACR7E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jan 2022 12:59:04 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MhDN4-1mQQ683fCU-00eHu7 for <linux-iio@vger.kernel.org>; Mon, 03 Jan 2022
 18:59:02 +0100
Received: by mail-wm1-f42.google.com with SMTP id b73so21865783wmd.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Jan 2022 09:59:02 -0800 (PST)
X-Gm-Message-State: AOAM531Wq15XrmMXUKacdiXIYmF3l4HWgZ8I7NuSIm/XurIgNlaJn8Bx
        NGMA76hGf6DgJ5SOQmeo8qB1CSlcBg1bJPWmLO0=
X-Google-Smtp-Source: ABdhPJyvQ4HHCWTYCAyHrO07RkXS1Fn5Oofd5diUYcSO+PA15pgH7nlCOAULNjzX+Y1/aCCO8gDgVI8DbqsbOo6UnkQ=
X-Received: by 2002:a7b:cc90:: with SMTP id p16mr39489953wma.98.1641232742389;
 Mon, 03 Jan 2022 09:59:02 -0800 (PST)
MIME-Version: 1.0
References: <20220102125617.1259804-1-jic23@kernel.org> <20220102125617.1259804-2-jic23@kernel.org>
 <CAK8P3a20AatvTxHEXfTpMWD8RJtLbJiTLbhiKJgQrn+KXYG8zw@mail.gmail.com> <20220103152444.0e22e971@jic23-huawei>
In-Reply-To: <20220103152444.0e22e971@jic23-huawei>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 3 Jan 2022 12:58:46 -0500
X-Gmail-Original-Message-ID: <CAK8P3a0OSU8Pz2=92ZQ2+uOXSoumRMPLEZM1zthsaYuZb162Kw@mail.gmail.com>
Message-ID: <CAK8P3a0OSU8Pz2=92ZQ2+uOXSoumRMPLEZM1zthsaYuZb162Kw@mail.gmail.com>
Subject: Re: [PATCH v2 01/51] iio:accel:da311: Switch from CONFIG_PM_SLEEP
 guards to pm_sleep_ptr() etc
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:gNKTcGz0N4U8IFUbhwNk3+L3I3BZr9uFNPLotJvLHti5K1QvRMg
 oz1DBeSgz+4L7PI1cgg57hj3jkz/JcPRqgPypWCA00Fzuj8rb5D6sn274/2753hb0v1bG+1
 zj5R21QDFmCv8R5vsHWdoq5C3vIfxtOW/SKE/WTzq7Rd1A8+026oLEaeVJumZ05QPObpuzy
 5Ql2EgLIhXuCHr4b5j7qg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8svhRsfb3zY=:1fHbT864aYH9fVPc5MKQqZ
 9lQ1l6erqNtHGPj3ksVh/NzbeYsjzErBzlZR0XDTWikB1XLPv931vf39cKml5XGdVWQAjhONY
 Zy3oRvvTqFuM8cp427UfhM11+fmvdd2Z3bz747ZdKPd4sH9vlz8jLLDU9E5jBhfIUFi7Xp9Gu
 gyALlGbwZIvzc6vwN3cJnz2Kg5wHyd9/cvI6KPq2wdeEQEcOPj3nXxZO3dQIZLxbHK9kpp4qE
 rON55lMMCB2Wpyws9jx6RFdRQWnWiJAj2hqBcfBqO98Rm/3VjOCmb6re60/rPNr6QiZkfcTMO
 tg9I0EBha2ybMprwanIVsuwEAOcnpUJ7+JibNC9SPHEewhBGpKWAcMgE20bQSUT/Q11BuNmci
 l7FA/pIblxTsxdEVcUZTsaioe7PvSptcrDr2TZuv1KwaRsWoSe+xHnZXdNdf4AGKHGvUKa+5b
 X0X9eJv6QdCsyB4hzP3QUVL/SDbPAmB3Oh+A2TxhD8sO5930thfVeLHV0iCMAA9XuI88CO/8d
 EJDXs3tHkBD121oBXMMfm2JSid+sF1G8LYFICVFlqV8aHPgwySB7wtTuLD/K0tCIAFAGKZe77
 82mLrtkdeD86JghMHRsShMS4QjQJAuraq/L/9l8bIw3ovV7m8opwVyynY+B3/p9EpX3QQzwuP
 24U8etVeQ4Bps9KyqPLCbdHlqfx37uuf7LWjwkILeFnCsOC/FKO6YfRp/BwqAz+LW2P8=
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jan 3, 2022 at 10:24 AM Jonathan Cameron <jic23@kernel.org> wrote:
> On Sun, 2 Jan 2022 09:15:06 -0500 Arnd Bergmann <arnd@arndb.de> wrote:
>
> That came up in discussion of the patch series introducing this macro
> https://lore.kernel.org/linux-pm/20211216110936.6ccd07d3@jic23-huawei/
>
> Most of the cases that don't define it as static
> also export the symbol for use by other modules so the approach of letting
> the compiler detect it as dead code won't always work.
>
> Exceptions from a bit of grepping are
> net/ethernet/broadcom/bnx2x/
> scsi/esas2r/esas2r_init.c
>   not sure on reasoning behind the file splits in these drivers
>   but definitely looks like it we could just merge a few files
>   and let this be static + the compiler remove it neatly.
>
> vs 17 cases where the symbol is exported and more cleverness will
> be needed.

I don't see why exporting the symbol makes a difference at all, either
it is needed in another file or it is not.

I think it would be more natural to not include 'static' in the macro,
that is certainly what all other macros like this do, and it's still
trivial to add 'static' manually, but impossible to remove it.

       Arnd
