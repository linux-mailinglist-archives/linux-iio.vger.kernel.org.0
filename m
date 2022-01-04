Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47E7484772
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jan 2022 19:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiADSG4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Jan 2022 13:06:56 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:38451 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiADSGz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jan 2022 13:06:55 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M8QiW-1n0QUI1AC8-004T9F for <linux-iio@vger.kernel.org>; Tue, 04 Jan 2022
 19:06:54 +0100
Received: by mail-wm1-f46.google.com with SMTP id n19-20020a7bc5d3000000b003466ef16375so150953wmk.1
        for <linux-iio@vger.kernel.org>; Tue, 04 Jan 2022 10:06:54 -0800 (PST)
X-Gm-Message-State: AOAM5308Tb/FPpvNvSa/VhmdGVOtp2vAv2j4eHGfbz++dd8LC3DRw/M8
        pd7EttX10jrnuDiPFwHDUZarAphh7BjsrbSb5Us=
X-Google-Smtp-Source: ABdhPJxPUtP+CFOHGKPn0LaLlTMVIioVVHNDU/sk685eDw1HvcNtpNS7jWUZofNEVp3AAQsBV2GlYFUjfneCXCt6D2E=
X-Received: by 2002:a7b:c198:: with SMTP id y24mr42641682wmi.1.1641319613972;
 Tue, 04 Jan 2022 10:06:53 -0800 (PST)
MIME-Version: 1.0
References: <20220102125617.1259804-1-jic23@kernel.org> <20220102125617.1259804-2-jic23@kernel.org>
 <CAK8P3a20AatvTxHEXfTpMWD8RJtLbJiTLbhiKJgQrn+KXYG8zw@mail.gmail.com>
 <20220103152444.0e22e971@jic23-huawei> <CAK8P3a0OSU8Pz2=92ZQ2+uOXSoumRMPLEZM1zthsaYuZb162Kw@mail.gmail.com>
 <20220104141601.00005ed8@Huawei.com> <O2Y65R.THAX75MFFTRJ1@crapouillou.net>
In-Reply-To: <O2Y65R.THAX75MFFTRJ1@crapouillou.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 4 Jan 2022 13:06:40 -0500
X-Gmail-Original-Message-ID: <CAK8P3a2dcxZ7a5vgjyMO7xMxu-R3iUsvAn_VwFm3uPmNunAiVw@mail.gmail.com>
Message-ID: <CAK8P3a2dcxZ7a5vgjyMO7xMxu-R3iUsvAn_VwFm3uPmNunAiVw@mail.gmail.com>
Subject: Re: [PATCH v2 01/51] iio:accel:da311: Switch from CONFIG_PM_SLEEP
 guards to pm_sleep_ptr() etc
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:bvV/QqQ8sgu3Df59g7baa2Xhf3eXybEqWFS1NKcCg+nXdT/S4a6
 kQfAoUtYQr8Ko36MaQCVB9WfsPMadtLI8BwP/6CSnpUq/y+lGifCY0spwyD5GpIaXxjSFOH
 +WfPCBUGiSG4Kir84MAWUvVhYFxvmqcnotBRl7IInR9N6v/Hntk5/h8bBQ52dIPPUEilox7
 jmuw0+LEGEgW1Zgf0xG7A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0F+/rb1g4b8=:JD+wS4GkUvzOueMYhnX3Lv
 Fr9WJNUnGca36Kf97WbZUEWSm0HENqma+l5BsZ6Jz/uWGDoDIjMoarNMj/RZp8gvTfgbl12OW
 trP1MY6ndWntnfRfI7jaWCCrQBNkMh31p6gkI5GBuKLi0+tM6Nd27EJqaBvgfJ4S39PUZYhF6
 YTy96vaRW9qePeogYmaZ1ZMCHVSbKjSq/apdaaG2jMZubVk6vPJq5GCopjmNqSpSX8rQmDRHM
 Pd2uwztiLfbK7mVu073ljBUedSO2uRC4l05hSwL3zwSve8Kt26grtbQYZ/b9lJaHA1EFPOA6j
 nJxWZobwkrnY44LjfvdBDLgNXU0Amr1dWfu+CjQydLgRBj6MHeGNITQNcsQYnBCP4kbWQqkvY
 PYOo0UKCbbp3w21Eep2zaVvchU7mX8r/oq/o3KhDn6vwWLvilM9S60DC7QQ6rw/N3UoIUjW5f
 sUtwrzfrUMmOp8xprMKWMyGR649Xyvm2nwqa3x2gg48Bvs4cZNICKUVBn+yY/Tp0tfFJbS1Pv
 eSL5v3GhKsK96kcHeCfYulYRAKk6NkH7ZJF3BLvDSHyNXV19UBui7T5Hgu+VtjhtdmQV88mAW
 QgBrOxMve3wwd5OkEBVOg4GM9c6W3cPy3Q7DG7F8/6WctALQ1/rdAWoIUMdgnSgvYPJrfdbhT
 L58VsOmHIk9DdJSvChV4VYX5lwurwX/LYmz7Soe96hXL+4eNDasN2bbUOhOg6ukZNCibHwk65
 Qm2EOh/3v4QkH3Vv6qjZFgZ4frsaP0mLM+HHOgJiwo4wtjAg7N0nwtlTMvv69C82HknICcIhi
 x4npLB7pRIeGGReXis6NJEzakNowtKptl/ZNfcEWMYzoe9fptM=
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 4, 2022 at 10:08 AM Paul Cercueil <paul@crapouillou.net> wrote:
> Le mar., janv. 4 2022 at 14:16:01 +0000, Jonathan Cameron
> >
> > Paul, over to you for reasoning.  If we are going to change this
> > now is the time before they get significant use and we end up having
> > to add static to lots of places.
>
> I have an idea on how to tackle automatic dead code removal on exported
> dev_pm_ops symbols. It means introducing a separate
> EXPORTED_SIMPLE_DEV_PM_OPS(), so the current DEFINE_SIMPLE_DEV_PM_OPS()
> macro could keep the "static". Unless you still think it's a bad idea,
> then in this case we can remove it.

I would prefer removing the implicit 'static' if only for consistency reasons,
which to me outweighs the simplicity aspect in this case.

         Arnd
