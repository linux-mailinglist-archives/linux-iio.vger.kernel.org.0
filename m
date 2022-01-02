Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682FE482B7F
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 15:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiABOP0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 09:15:26 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:48431 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiABOP0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 09:15:26 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MauFB-1mXAf23omx-00cSGJ for <linux-iio@vger.kernel.org>; Sun, 02 Jan 2022
 15:15:23 +0100
Received: by mail-wm1-f46.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so17088919wmd.5
        for <linux-iio@vger.kernel.org>; Sun, 02 Jan 2022 06:15:23 -0800 (PST)
X-Gm-Message-State: AOAM530qpeQVD3o5OSyTaCYnjw59cNHl4y+ojaMXPaox2fyAUvl+6CAg
        Qg42cX1yetA5XEJx7bAJEaDYUfCdisVTpb66x+w=
X-Google-Smtp-Source: ABdhPJxMQSRNFyy0hikpwaNGW1Wylx6by80x/WICI7uP9KBiqbEwXmJEZ5dxJRP/sTMT/arrS0QsM94w5r8BcNkvPZU=
X-Received: by 2002:a1c:7418:: with SMTP id p24mr36230993wmc.82.1641132923553;
 Sun, 02 Jan 2022 06:15:23 -0800 (PST)
MIME-Version: 1.0
References: <20220102125617.1259804-1-jic23@kernel.org> <20220102125617.1259804-2-jic23@kernel.org>
In-Reply-To: <20220102125617.1259804-2-jic23@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 2 Jan 2022 09:15:06 -0500
X-Gmail-Original-Message-ID: <CAK8P3a20AatvTxHEXfTpMWD8RJtLbJiTLbhiKJgQrn+KXYG8zw@mail.gmail.com>
Message-ID: <CAK8P3a20AatvTxHEXfTpMWD8RJtLbJiTLbhiKJgQrn+KXYG8zw@mail.gmail.com>
Subject: Re: [PATCH v2 01/51] iio:accel:da311: Switch from CONFIG_PM_SLEEP
 guards to pm_sleep_ptr() etc
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:LlTtxTp14dGDwxeA7z/q7tjurouY0QAyDUkaI5sw2IskVyOrWxz
 NobWmzgKOTmROWec0gEIOppFN30xQvID5kBQG+i8WMVldDi5rmcjbeSBfoJQ/gMq2Os360v
 zSPriOKOnPk2zQS742mXVL8SVVfcp0KgPYurR35PivPjuvvtUzQslFL4LBb6YasaGD/HsLE
 /M0seJXrVQla+eYS2tiAg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CAEtxpKCpjI=:BVP7HSmOiT3syaQk4PeKKB
 RhN9FHAadO9Ls1ctJvaHWrVgcTTl/yqmOIhZ8nZ0tidsCVeQe9+rNCfd9Vu0yh/K3QQx6TUp9
 aqBdDF6cC1264WSbR71W7sMRBarmOfdT5ysm50sF6PTd7uilsPiYqOWlWAtUx/BHhOZUOJpGP
 0CfBYK2OYtzraRekFRmzhDO5C8IbTsieSghonnXUmnAdq4EsvM2fFQCL4nnLwbHUVWKGO1E6M
 7r6b2v3CI0cmdp8vmPErDkFhHo7rm1PkGna+8ua8tYBj80LN7v1avjB8IaN4+zG2VcO6OwLV3
 VynPSCAXqW8ConvEW2vgJw1Qe4Xoh98mNvjcOuR/KOQK6cuREamBgvnulLq+V0SwzhbynYgRb
 fuT2uQG4bGdIsANFMGjgofRAF5O7/LmVD3iPEcYvGbbWQiqdvrrP/4Ug3UVfRdr1ABW2CHOrE
 oH6w8AZ2pkMV6NUqgwFtOxIh/4h7ZdwrIDs5w4ymnS2VFE2YNNWwkLCoUSk/E1WAieUZ4w0V+
 AZEOGf7KQobfTmnSiL/nVEOysNUe5j650o4Amfwp3jF0lwk/+mbUaT5sAN+yKcH1+6oMsNjrx
 JhXK198j5SEZcXIr9xFkShk5/p0ryPks8S0WZ1CVLwj237KamNKasL48jY7ifZbrtfUcfV2Nq
 hKTuD/Kk3IrRA8FSDAtkbFSSxBOCVCKdw4ij/38upfwwntzu9YWl6r4pGuAhnAreCTepsm9gA
 pmW+T+TBP0WeRswatrPOLsKljTu6NYT4i6SQDeE/Dix4rEnidSyK0mGTfaWkTABGmNxXKHjTb
 J8wMnA+9qUsRugiu1QyQk4aS8RK2X9lmGixNaXNkguF6BdRCwA=
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 2, 2022 at 7:55 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> -static SIMPLE_DEV_PM_OPS(da311_pm_ops, da311_suspend, da311_resume);
> +DEFINE_SIMPLE_DEV_PM_OPS(da311_pm_ops, da311_suspend, da311_resume);
>

Does the new DEFINE_SIMPLE_DEV_PM_OPS imply 'static'? I see that you remove
the specifier in all the patches, which would not work otherwise, but
I wonder what that
means for drivers that actually define the pm-ops globally on purpose
and can't do
that any more after the conversion.

      Arnd
