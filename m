Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A672D1520
	for <lists+linux-iio@lfdr.de>; Mon,  7 Dec 2020 16:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgLGPuv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Dec 2020 10:50:51 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51704 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgLGPuv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Dec 2020 10:50:51 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 79D0D1F44D66
Subject: Re: [PATCH v4 2/7] Input: use input_device_enabled()
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
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
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
 <20200608112211.12125-3-andrzej.p@collabora.com>
 <CGME20201207133237eucas1p26f8484944760a14e51dc7353ed33cd28@eucas1p2.samsung.com>
 <27ce1176-6318-45aa-4e22-3dec9f3df15d@samsung.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <9c784a23-eade-eacd-3e67-d344a5758b83@collabora.com>
Date:   Mon, 7 Dec 2020 16:50:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <27ce1176-6318-45aa-4e22-3dec9f3df15d@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Marek,

W dniu 07.12.2020 o 14:32, Marek Szyprowski pisze:
> Hi Andrzej,
> 
> On 08.06.2020 13:22, Andrzej Pietrasiewicz wrote:
>> Use the newly added helper in relevant input drivers.
>>
>> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> 
> This patch landed recently in linux-next as commit d69f0a43c677 ("Input:
> use input_device_enabled()"). Sadly it causes following warning during
> system suspend/resume cycle on ARM 32bit Samsung Exynos5250-based Snow
> Chromebook with kernel compiled from exynos_defconfig:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1777 at drivers/input/input.c:2230
> input_device_enabled+0x68/0x6c
> Modules linked in: cmac bnep mwifiex_sdio mwifiex sha256_generic
> libsha256 sha256_arm cfg80211 btmrvl_sdio btmrvl bluetooth s5p_mfc
> exynos_gsc v4l2_mem2mem videob
> CPU: 0 PID: 1777 Comm: rtcwake Not tainted
> 5.10.0-rc6-next-20201207-00001-g49a0dc04c46d-dirty #9902
> Hardware name: Samsung Exynos (Flattened Device Tree)
> [<c0111718>] (unwind_backtrace) from [<c010d050>] (show_stack+0x10/0x14)
> [<c010d050>] (show_stack) from [<c0b32810>] (dump_stack+0xb4/0xd4)
> [<c0b32810>] (dump_stack) from [<c0126e24>] (__warn+0xd8/0x11c)
> [<c0126e24>] (__warn) from [<c0126f18>] (warn_slowpath_fmt+0xb0/0xb8)
> [<c0126f18>] (warn_slowpath_fmt) from [<c07fa2fc>]
> (input_device_enabled+0x68/0x6c)
> [<c07fa2fc>] (input_device_enabled) from [<c080a0f8>]

Apparently you are hitting this line of code in drivers/input/input.c:

lockdep_assert_held(&dev->mutex);

Inspecting input device's "users" member should happen under dev's lock.

Regards,

Andrzej
