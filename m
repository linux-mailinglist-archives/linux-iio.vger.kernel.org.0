Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B932D122A
	for <lists+linux-iio@lfdr.de>; Mon,  7 Dec 2020 14:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgLGNdi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Dec 2020 08:33:38 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33541 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgLGNdi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Dec 2020 08:33:38 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201207133243euoutp02a07eaff1232f3828b35d363c2d162b88~OcnTwTsL90185601856euoutp02d;
        Mon,  7 Dec 2020 13:32:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201207133243euoutp02a07eaff1232f3828b35d363c2d162b88~OcnTwTsL90185601856euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1607347963;
        bh=ljQ0v3Ar0KYP2q9/GRtPG9FJKYzmsBEMPJYT7bas0xM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YXnyfI3nXv1DhFtGBhw8rjlj6OWDgzzqG6ggdFQv6tUUzN+M3UpHev4Lt5w3dDEeq
         JsY5rsqNM4QlBu8xSwpaGb6jN+Unr+zoWvEul+H0F5kLgpcw0eew3NnzrXCdwSiqr5
         8/gkKlmm/vhkZki1ZiEurX6kzTnv6KS7IUhhgWLQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201207133237eucas1p19e9329c72365b51bdbaafba28239f22c~OcnOVcZch0957309573eucas1p1O;
        Mon,  7 Dec 2020 13:32:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D4.52.44805.5FE2ECF5; Mon,  7
        Dec 2020 13:32:37 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201207133237eucas1p26f8484944760a14e51dc7353ed33cd28~OcnNreb_Q1175011750eucas1p2A;
        Mon,  7 Dec 2020 13:32:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201207133237eusmtrp22a886004009ed21a7d1310c91ddd5534~OcnNp8qpM0370603706eusmtrp2Q;
        Mon,  7 Dec 2020 13:32:37 +0000 (GMT)
X-AuditID: cbfec7f4-b4fff7000000af05-d5-5fce2ef51212
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2B.33.21957.4FE2ECF5; Mon,  7
        Dec 2020 13:32:36 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201207133234eusmtip21bd44750aa26b3a6918e1852376589e6~OcnLrilqA0874408744eusmtip2c;
        Mon,  7 Dec 2020 13:32:34 +0000 (GMT)
Subject: Re: [PATCH v4 2/7] Input: use input_device_enabled()
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        kernel@collabora.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <27ce1176-6318-45aa-4e22-3dec9f3df15d@samsung.com>
Date:   Mon, 7 Dec 2020 14:32:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20200608112211.12125-3-andrzej.p@collabora.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1BUZRj223PZA7VyuCTfYMQMGjOQsVKN81lmkFhnyJnITBumCdc4XAqQ
        diXDmZKLoWwwayiw7hIoLRcXBVmuu8htl2RkYQloI0UoAnFDwLjIXYjlYPHved/3ed7nfb6Z
        j8IcJkkXKiL6BCuOFkW6k7Z41a1508uPvU3BO5Myt6GCwX4clclLCTSkT8OQIc8CUPOEAUcD
        5vfRaEsWDykNe1D28HWAzv6VQqA/E9U8dEaRh6NyUyqB1BlaHMkGH2JItzKKoY6OG3ykupBL
        oPz6YhxpB8ZIVFgvA0gz+BuBcprHcSRduIqhO5MzBOrWZZNoKq0ZIHlHPQ+lTCtIdN5Qzkdd
        l77H0NSjBgJV1zXwUPFNC4YWdbf4qM3YRaAn1RocWSqcUbpejOZ1OThaWUjCfD2ZEbMfU9On
        AkxyYgSjVfTxmX8mPmUWGwGjUaeQTLnqNFN7eYrHzMrbAKMa1RPM8pWLOJOWNE4yZeM1PCYr
        ewUwsic7A7cE2e4JYSMjvmLFwr1HbcMzagNjDAe+VpfQ8UDrLwUUBenXYFtriBTYUA50EYAp
        TQc5PA1gZg0tBbareArAny7c5VsHVn5VrZzkSIUAmnujONIEgLMjM4R1qSP9Jsy+uN/ad6KV
        GPw7vRJYC4yOt4GVvWdwq5qkfaB0TLq2SUDvhd26ojWM09uhqq6OsOLn6GOwVDq3zrGHty8N
        rWltVg0eylrWMEa7waRKJcZhZ3h3KJdnNYP0uWdg3lUDzp3tD8f7zYDDjnCkpWI9zvNwRftU
        kATggOk6nytSAexOlK8r3oD3TAukNRtGe8JSnZBr+8F7xRqCe8fN8Pcxe+6IzTC9Kgvj2gJ4
        LtmBY3tARUvJf7ZNv3Rh54G7YkM0xYY4ig1xFP/7Xga4GjizsZKoMFbySjR70lsiipLERod5
        f3Y8SgNWv4VxuWW6BhSOTHjrAY8CegApzN1J4OHSHuwgCBHFnWLFx4PFsZGsRA+2Uri7s+BY
        xbVgBzpMdIL9gmVjWPHTKY+ycYnnSXs+ESUY5FvNJQnONz/f5Cg28fdPxShDk384mnpox5cB
        2S7z9uzIs66V41d63v75oDoqf16YMCAfatok69l9f1E2/O2D3W5dXsb35o1u4j8yam/Ej+o+
        bF4S5IU9yNznOvajb31OropKEH5ATRYHbd8RUH07ThbS+86Bfvv05V2pRTXyMEvi6fylXX1+
        9ebidkuo8mSMk1eBbu5XxfSRPrXv2cPGvi0fVe5b+jhuOSu10S5I8yijMTC8IS4ix8X/pWVl
        byvZdFhotAgfFxwpi3E9JfhG275t9t1DMM/jrRc1ps7OUs+ezlcDJOZhqdDu2swLPqFdPq/P
        YRV37O5/19rpmL/ijkvCRT5emFgi+heBzm97hQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTdxTH/d1HHxrMpYDcNWNznTNxjtoCZYcFiC4+rmyJbslMHNOu4OWR
        QWtaMG7JHCsOpELwwcvCAFmZWqfDVh4FoVvLQALI0ECEQFfkMQYFZXQzKNDxWsJ/n5xzPt+T
        kxweLviOI+QlKlNYtVKRJOJsJNoXWx2BbvEDucSsDYUfhx0E3Cn6mYQRWw4O9opxBM0zdgKG
        eg6Bq7UQg2J7OJSM3UKQ+SSLBKfWiMFZfQUB5gfZJBjzLQTkDk/iUO9x4dDVVcUFw+UyEiqb
        bhJgGZriwLWmXASm4V4SSpunCdC9uIFD39//kvCovoQDsznNCIq6mjDIcus5cMFu5sLDK+dx
        mH1qJaG20YrBzXvjOLysb+FCR/tDEhZqTQSM3/WHSzY1zNWXEuB5kY7v3sFM9Oxh6gYNiMnQ
        JjIW/SCXeTZznHn5C2JMxiwOYzZ8wzSUz2LM86IOxBhcNpJZvJpHMDnp0xzmznQdxhSWeBCT
        uyA5vOVTcbhalZrCbk1QaVIiRNFSCBJLw0AcFBImlga/e+y9IJloV2T4CTYp8RSr3hX5uTgh
        v+HwSfuHp423qTRk2atDfB5NhdA1DUUcHdrIE1CViB6rshCrjVfptoI0cpV96Ple3drQU0Tn
        deQhHeLxfKgIuiRv33LdlyrGac+3v63IOJXBp6cmdi6zgPoB0f0N/GXmUFJaN7UcxOd5UZH0
        o/rrK0xQ22hDYyO5nOlHxdCd7d6rI95025WRlUj+0qrJ3Na1+FC61DyEr/LrdHp18Rr70/0j
        ZdgFJNCv0/XrFP06Rb9OKUeEEfmyqZrk+GSNVKxRJGtSlfHiWFWyCS39Y03LnLkOlU7MiG0I
        4yEbonm4yNdru7BTLvA6ofjyK1atkqtTk1iNDcmWzrmIC/1iVUsPrUyRS0MlMmlIaJhEFhYa
        LPL3qv7+J7mAileksF+w7ElW/b+H8fjCNMx0V0aMxZt+v6HPDkRx9/dap0yjaTPJ/KSMY85N
        m6OqWiqm/xyQQIzH50jE/lq3t49vd6GjN/CU6o1L7bfbRI/fmXRynmRqPpg6vnP7wOZKKH1W
        95oyaceZRP1gX/nWoz1+vSNVRr5PPnf/XxvaDgjOmx5HBVHuAKf3uc732fzoy7eQ5OvRoIt5
        Z8cPOhuiDwqvtwlFwbHaAPqMy2nNcec2/mogs1u9A6LIyCOT1oCY4eru4U8KZOe0b5bNj8qf
        438ciBO+dW+3clOUdHbuH7PScX/wWt+A47RpA0S3H21+pebjQy6PJM6duUVv3TP/Uc9iYUVn
        Wkd/WIHR0P3ZvgVMRGgSFNK3cbVG8R+NMNSPGAQAAA==
X-CMS-MailID: 20201207133237eucas1p26f8484944760a14e51dc7353ed33cd28
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201207133237eucas1p26f8484944760a14e51dc7353ed33cd28
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201207133237eucas1p26f8484944760a14e51dc7353ed33cd28
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
        <20200608112211.12125-1-andrzej.p@collabora.com>
        <20200608112211.12125-3-andrzej.p@collabora.com>
        <CGME20201207133237eucas1p26f8484944760a14e51dc7353ed33cd28@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andrzej,

On 08.06.2020 13:22, Andrzej Pietrasiewicz wrote:
> Use the newly added helper in relevant input drivers.
>
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

This patch landed recently in linux-next as commit d69f0a43c677 ("Input: 
use input_device_enabled()"). Sadly it causes following warning during 
system suspend/resume cycle on ARM 32bit Samsung Exynos5250-based Snow 
Chromebook with kernel compiled from exynos_defconfig:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1777 at drivers/input/input.c:2230 
input_device_enabled+0x68/0x6c
Modules linked in: cmac bnep mwifiex_sdio mwifiex sha256_generic 
libsha256 sha256_arm cfg80211 btmrvl_sdio btmrvl bluetooth s5p_mfc 
exynos_gsc v4l2_mem2mem videob
CPU: 0 PID: 1777 Comm: rtcwake Not tainted 
5.10.0-rc6-next-20201207-00001-g49a0dc04c46d-dirty #9902
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c0111718>] (unwind_backtrace) from [<c010d050>] (show_stack+0x10/0x14)
[<c010d050>] (show_stack) from [<c0b32810>] (dump_stack+0xb4/0xd4)
[<c0b32810>] (dump_stack) from [<c0126e24>] (__warn+0xd8/0x11c)
[<c0126e24>] (__warn) from [<c0126f18>] (warn_slowpath_fmt+0xb0/0xb8)
[<c0126f18>] (warn_slowpath_fmt) from [<c07fa2fc>] 
(input_device_enabled+0x68/0x6c)
[<c07fa2fc>] (input_device_enabled) from [<c080a0f8>] 
(cyapa_gen3_set_power_mode+0x128/0x1cc)
[<c080a0f8>] (cyapa_gen3_set_power_mode) from [<c0807894>] 
(cyapa_suspend+0x74/0x114)
[<c0807894>] (cyapa_suspend) from [<c06ae924>] (dpm_run_callback+0xb0/0x3c8)
[<c06ae924>] (dpm_run_callback) from [<c06aefe4>] 
(__device_suspend+0x104/0x784)
[<c06aefe4>] (__device_suspend) from [<c06b2994>] (dpm_suspend+0x184/0x540)
[<c06b2994>] (dpm_suspend) from [<c06b369c>] (dpm_suspend_start+0x98/0xa0)
[<c06b369c>] (dpm_suspend_start) from [<c01a0a10>] 
(suspend_devices_and_enter+0xec/0xbd4)
[<c01a0a10>] (suspend_devices_and_enter) from [<c01a180c>] 
(pm_suspend+0x314/0x42c)
[<c01a180c>] (pm_suspend) from [<c019f6f8>] (state_store+0x6c/0xc8)
[<c019f6f8>] (state_store) from [<c0387b04>] (kernfs_fop_write+0x10c/0x228)
[<c0387b04>] (kernfs_fop_write) from [<c02dbd48>] (vfs_write+0xc8/0x530)
[<c02dbd48>] (vfs_write) from [<c02dc2ec>] (ksys_write+0x60/0xd8)
[<c02dc2ec>] (ksys_write) from [<c0100060>] (ret_fast_syscall+0x0/0x2c)
Exception stack(0xc45bffa8 to 0xc45bfff0)
...
irq event stamp: 14101
hardirqs last  enabled at (14109): [<c01a567c>] vprintk_emit+0x2d8/0x32c
hardirqs last disabled at (14116): [<c01a5640>] vprintk_emit+0x29c/0x32c
softirqs last  enabled at (13264): [<c01017a8>] __do_softirq+0x528/0x684
softirqs last disabled at (13253): [<c01304c4>] irq_exit+0x1ec/0x1f8
---[ end trace 6687a21e6b7e94a9 ]---
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1777 at drivers/input/input.c:2230 
input_device_enabled+0x68/0x6c
Modules linked in: cmac bnep mwifiex_sdio mwifiex sha256_generic 
libsha256 sha256_arm cfg80211 btmrvl_sdio btmrvl bluetooth s5p_mfc 
exynos_gsc v4l2_mem2mem videob
CPU: 1 PID: 1777 Comm: rtcwake Tainted: G        W 
5.10.0-rc6-next-20201207-00001-g49a0dc04c46d-dirty #9902
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c0111718>] (unwind_backtrace) from [<c010d050>] (show_stack+0x10/0x14)
[<c010d050>] (show_stack) from [<c0b32810>] (dump_stack+0xb4/0xd4)
[<c0b32810>] (dump_stack) from [<c0126e24>] (__warn+0xd8/0x11c)
[<c0126e24>] (__warn) from [<c0126f18>] (warn_slowpath_fmt+0xb0/0xb8)
[<c0126f18>] (warn_slowpath_fmt) from [<c07fa2fc>] 
(input_device_enabled+0x68/0x6c)
[<c07fa2fc>] (input_device_enabled) from [<c080a0f8>] 
(cyapa_gen3_set_power_mode+0x128/0x1cc)
[<c080a0f8>] (cyapa_gen3_set_power_mode) from [<c08088b4>] 
(cyapa_reinitialize+0xcc/0x154)
[<c08088b4>] (cyapa_reinitialize) from [<c0808984>] (cyapa_resume+0x48/0x98)
[<c0808984>] (cyapa_resume) from [<c06ae924>] (dpm_run_callback+0xb0/0x3c8)
[<c06ae924>] (dpm_run_callback) from [<c06aecf8>] (device_resume+0xbc/0x260)
[<c06aecf8>] (device_resume) from [<c06b10d8>] (dpm_resume+0x14c/0x51c)
[<c06b10d8>] (dpm_resume) from [<c06b1cac>] (dpm_resume_end+0xc/0x18)
[<c06b1cac>] (dpm_resume_end) from [<c01a0ad8>] 
(suspend_devices_and_enter+0x1b4/0xbd4)
[<c01a0ad8>] (suspend_devices_and_enter) from [<c01a180c>] 
(pm_suspend+0x314/0x42c)
[<c01a180c>] (pm_suspend) from [<c019f6f8>] (state_store+0x6c/0xc8)
[<c019f6f8>] (state_store) from [<c0387b04>] (kernfs_fop_write+0x10c/0x228)
[<c0387b04>] (kernfs_fop_write) from [<c02dbd48>] (vfs_write+0xc8/0x530)
[<c02dbd48>] (vfs_write) from [<c02dc2ec>] (ksys_write+0x60/0xd8)
[<c02dc2ec>] (ksys_write) from [<c0100060>] (ret_fast_syscall+0x0/0x2c)
Exception stack(0xc45bffa8 to 0xc45bfff0)
...
irq event stamp: 55479
hardirqs last  enabled at (55487): [<c01a567c>] vprintk_emit+0x2d8/0x32c
hardirqs last disabled at (55494): [<c01a5640>] vprintk_emit+0x29c/0x32c
softirqs last  enabled at (53552): [<c01017a8>] __do_softirq+0x528/0x684
softirqs last disabled at (53541): [<c01304c4>] irq_exit+0x1ec/0x1f8
---[ end trace 6687a21e6b7e94aa ]---
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1777 at drivers/input/input.c:2230 
input_device_enabled+0x68/0x6c
Modules linked in: cmac bnep mwifiex_sdio mwifiex sha256_generic 
libsha256 sha256_arm cfg80211 btmrvl_sdio btmrvl bluetooth s5p_mfc 
exynos_gsc v4l2_mem2mem videob
CPU: 1 PID: 1777 Comm: rtcwake Tainted: G        W 
5.10.0-rc6-next-20201207-00001-g49a0dc04c46d-dirty #9902
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c0111718>] (unwind_backtrace) from [<c010d050>] (show_stack+0x10/0x14)
[<c010d050>] (show_stack) from [<c0b32810>] (dump_stack+0xb4/0xd4)
[<c0b32810>] (dump_stack) from [<c0126e24>] (__warn+0xd8/0x11c)
[<c0126e24>] (__warn) from [<c0126f18>] (warn_slowpath_fmt+0xb0/0xb8)
[<c0126f18>] (warn_slowpath_fmt) from [<c07fa2fc>] 
(input_device_enabled+0x68/0x6c)
[<c07fa2fc>] (input_device_enabled) from [<c0808834>] 
(cyapa_reinitialize+0x4c/0x154)
[<c0808834>] (cyapa_reinitialize) from [<c0808984>] (cyapa_resume+0x48/0x98)
[<c0808984>] (cyapa_resume) from [<c06ae924>] (dpm_run_callback+0xb0/0x3c8)
[<c06ae924>] (dpm_run_callback) from [<c06aecf8>] (device_resume+0xbc/0x260)
[<c06aecf8>] (device_resume) from [<c06b10d8>] (dpm_resume+0x14c/0x51c)
[<c06b10d8>] (dpm_resume) from [<c06b1cac>] (dpm_resume_end+0xc/0x18)
[<c06b1cac>] (dpm_resume_end) from [<c01a0ad8>] 
(suspend_devices_and_enter+0x1b4/0xbd4)
[<c01a0ad8>] (suspend_devices_and_enter) from [<c01a180c>] 
(pm_suspend+0x314/0x42c)
[<c01a180c>] (pm_suspend) from [<c019f6f8>] (state_store+0x6c/0xc8)
[<c019f6f8>] (state_store) from [<c0387b04>] (kernfs_fop_write+0x10c/0x228)
[<c0387b04>] (kernfs_fop_write) from [<c02dbd48>] (vfs_write+0xc8/0x530)
[<c02dbd48>] (vfs_write) from [<c02dc2ec>] (ksys_write+0x60/0xd8)
[<c02dc2ec>] (ksys_write) from [<c0100060>] (ret_fast_syscall+0x0/0x2c)
Exception stack(0xc45bffa8 to 0xc45bfff0)
...
irq event stamp: 55829
hardirqs last  enabled at (55837): [<c01a567c>] vprintk_emit+0x2d8/0x32c
hardirqs last disabled at (55844): [<c01a5640>] vprintk_emit+0x29c/0x32c
softirqs last  enabled at (53552): [<c01017a8>] __do_softirq+0x528/0x684
softirqs last disabled at (53541): [<c01304c4>] irq_exit+0x1ec/0x1f8
---[ end trace 6687a21e6b7e94ab ]---
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1777 at drivers/input/input.c:2230 
input_device_enabled+0x68/0x6c
Modules linked in: cmac bnep mwifiex_sdio mwifiex sha256_generic 
libsha256 sha256_arm cfg80211 btmrvl_sdio btmrvl bluetooth s5p_mfc 
exynos_gsc v4l2_mem2mem videob
CPU: 1 PID: 1777 Comm: rtcwake Tainted: G        W 
5.10.0-rc6-next-20201207-00001-g49a0dc04c46d-dirty #9902
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c0111718>] (unwind_backtrace) from [<c010d050>] (show_stack+0x10/0x14)
[<c010d050>] (show_stack) from [<c0b32810>] (dump_stack+0xb4/0xd4)
[<c0b32810>] (dump_stack) from [<c0126e24>] (__warn+0xd8/0x11c)
[<c0126e24>] (__warn) from [<c0126f18>] (warn_slowpath_fmt+0xb0/0xb8)
[<c0126f18>] (warn_slowpath_fmt) from [<c07fa2fc>] 
(input_device_enabled+0x68/0x6c)
[<c07fa2fc>] (input_device_enabled) from [<c080a0f8>] 
(cyapa_gen3_set_power_mode+0x128/0x1cc)
[<c080a0f8>] (cyapa_gen3_set_power_mode) from [<c0808890>] 
(cyapa_reinitialize+0xa8/0x154)
[<c0808890>] (cyapa_reinitialize) from [<c0808984>] (cyapa_resume+0x48/0x98)
[<c0808984>] (cyapa_resume) from [<c06ae924>] (dpm_run_callback+0xb0/0x3c8)
[<c06ae924>] (dpm_run_callback) from [<c06aecf8>] (device_resume+0xbc/0x260)
[<c06aecf8>] (device_resume) from [<c06b10d8>] (dpm_resume+0x14c/0x51c)
[<c06b10d8>] (dpm_resume) from [<c06b1cac>] (dpm_resume_end+0xc/0x18)
[<c06b1cac>] (dpm_resume_end) from [<c01a0ad8>] 
(suspend_devices_and_enter+0x1b4/0xbd4)
[<c01a0ad8>] (suspend_devices_and_enter) from [<c01a180c>] 
(pm_suspend+0x314/0x42c)
[<c01a180c>] (pm_suspend) from [<c019f6f8>] (state_store+0x6c/0xc8)
[<c019f6f8>] (state_store) from [<c0387b04>] (kernfs_fop_write+0x10c/0x228)
[<c0387b04>] (kernfs_fop_write) from [<c02dbd48>] (vfs_write+0xc8/0x530)
[<c02dbd48>] (vfs_write) from [<c02dc2ec>] (ksys_write+0x60/0xd8)
[<c02dc2ec>] (ksys_write) from [<c0100060>] (ret_fast_syscall+0x0/0x2c)
Exception stack(0xc45bffa8 to 0xc45bfff0)
...
irq event stamp: 56143
hardirqs last  enabled at (56151): [<c01a567c>] vprintk_emit+0x2d8/0x32c
hardirqs last disabled at (56158): [<c01a5640>] vprintk_emit+0x29c/0x32c
softirqs last  enabled at (53552): [<c01017a8>] __do_softirq+0x528/0x684
softirqs last disabled at (53541): [<c01304c4>] irq_exit+0x1ec/0x1f8
---[ end trace 6687a21e6b7e94ac ]---

Let me know how I can help debugging this issue.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

