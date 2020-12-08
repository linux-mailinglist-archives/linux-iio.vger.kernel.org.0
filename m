Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5652D2868
	for <lists+linux-iio@lfdr.de>; Tue,  8 Dec 2020 11:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgLHKGk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Dec 2020 05:06:40 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41784 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgLHKGj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Dec 2020 05:06:39 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201208100546euoutp02e0bc3fe49cc95efcce507d79fc493b31~Otb5fCmXP0214502145euoutp02g;
        Tue,  8 Dec 2020 10:05:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201208100546euoutp02e0bc3fe49cc95efcce507d79fc493b31~Otb5fCmXP0214502145euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1607421946;
        bh=Bv2iUMf5t8sR+k2GUep7pVjimXHF1qPn96u6HZaIEr0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hMnSZd9FYOxedyWFXh8LpLwk/gDkZjHMeGMuONNZwPBxe6jnqvwWcKtMnWuodrnqY
         PpjqZpOdUsjc5Hv6aFRI5cnWpHWEaSSx1mrz05aWPxStbFhl6LPVANENFlZHljnrUI
         SO73IGO7eSMZhZntar85lDda9N8SEjHT96N1n6gA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201208100545eucas1p2619963b4961497d52d182d641849c3c8~Otb4-xDnF1791717917eucas1p2j;
        Tue,  8 Dec 2020 10:05:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 24.9B.45488.9FF4FCF5; Tue,  8
        Dec 2020 10:05:45 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201208100545eucas1p2384c9e6421e68c5e4b7a1aacc8015f99~Otb4hk78D2012420124eucas1p2L;
        Tue,  8 Dec 2020 10:05:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201208100545eusmtrp1821931dd698ad93b62a75f6681b1cf83~Otb4gH_oj3074730747eusmtrp1h;
        Tue,  8 Dec 2020 10:05:45 +0000 (GMT)
X-AuditID: cbfec7f5-c77ff7000000b1b0-36-5fcf4ff964ec
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DE.6C.21957.8FF4FCF5; Tue,  8
        Dec 2020 10:05:44 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201208100543eusmtip163dc4372fdcda95019639546a8e0affd~Otb2ggtFC0248002480eusmtip1B;
        Tue,  8 Dec 2020 10:05:42 +0000 (GMT)
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
Message-ID: <ad093ba3-7b17-18f3-6bb5-d8133c3da89a@samsung.com>
Date:   Tue, 8 Dec 2020 11:05:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <9c784a23-eade-eacd-3e67-d344a5758b83@collabora.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTZxzNd+/tC1e8FBxfqkZSDRubFtw0fovIVuKWu8QFt+wFbsMyrkAG
        hbQy3eI2XnFQQBiwUUqloChPeRQKpSrOltEpjzqMMJ4RaBhDoOtAHBBglosb/53vnN/5zu/8
        8ePigidsITdKdpqWy6TRIrYL0dS+2L1vMcga6lf9gze6Oj5CoHpVLQvZTJk4Ml+aBKjNYSbQ
        6IMgNG3Jx1Ch2R9pJq4B9P1YGgs9TKrEUIr6EoEaujNYqPLHFgJljT/CkXFtGkdWax0HleZq
        WehKaxWBWkZn2KisNQsg3XgvCxW1zRJIuVSBo/6/F1jovlHDRnOZbQCprK0YSptXs1G2uYGD
        egrScTRnv8VCzTdvYajqxiSOlo3tHNTZ0cNCK806Ak02eqIckxwtGosItLaUjL/hQ009kFCG
        4VJAnU+KolrUwxzqL8dn1PLPgNJVprGphtLvqOvFcxj1RNUJqNJpE4taLckjqMzkWTZVP2vA
        qHzNGqCyVvyOPx/i4h9OR0d9Sct9A066RI7cacTjbORZraoZJIB8VyXgcSF5AA5UrRJK4MIV
        kOUA/rJiYTsFATkPYMpwHCPMAZhe2IU/c4zoBzmMUAbgI3s5YB4OAJXz5qcKl+tOHoGavDed
        vAdZiMM/c/TrQziZwIP6wRTC+RWb3A+VM8r1PD4ZAK0XnWYelyD3QIvNtI63kWGwVvnPxowb
        vFNgW/fySAnUL7SznBgnd8FkfSHOYE84YNNizjBIZmyBNZW9GLP3UajKTQUMdodTlkYOg3fA
        jtwMgjEkAzjafY2z4QbwfpJqw3EYDnUvsZ3dcNIH1hp9GVoCh6p0LCcNSVf4+4wbs4QrzGnK
        xxmaD1PPC5hpb6i21PwXe/teD54NROpN1dSb6qg31VH/n1sMiErgSccrYiJoxasy+oxYIY1R
        xMsixJ/HxujA09voWLU8NoDyKYfYBDAuMAHIxUUefG9hV6iAHy796mtaHhsqj4+mFSawnUuI
        PPlGfXWogIyQnqa/oOk4Wv5Mxbg8YQK2I3C3767t1yvexYx3p1ln7oqtp+DDFyV9dT4D3sLX
        t2j3fKqQXCi8Yi0K1+50T5SJz8WyM7zejzkYzDf8tKhPDWm4sDNy4Fx94hgZ0D8nPBHbEkgX
        H6xY1k7kCGsItXHquWBJuNnrlYa8rr2OgkNH/6AnktJPeI5lNa3mlLyAzg6NHFlMlF/Otn/b
        d1z+Qf8nBSLbsX0fnSp5+9jeskMHXgtMC9FttdvveRX9+rJrWIgHDJaNzXThIVsvP04MG1Lz
        3itx+WZQrNEE5YXe7LafdHB83Pr8+NXbin97y3H4Q/vFef9ZH4N9d3Jplcp1oTdx9MLHg3Sd
        XxDvarSt03A74Ub6OyJCESnd/xIuV0j/BdJ214CKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTdxTH97uPtpgwLwXlDhmYxpkhsbS0sNMJRF2W3C3ZGGYZkc3VCldK
        pNS1ZcLcYhVzCXUENlCwlJdWDIhOqKw8BEyLNIism4pGFsh4RBnjMR6BIQKjwyX898k53883
        OckR4EKOFyBISTOwujRVqoi3iehecfXvXox1KyXVQVA1PEBAXfFPJIw4cnFwXhpF0DHtJGCw
        NxbGXUUYlDijwPLsOoLsoRwS/jhTg8FZ8yUCbL98T0LN+SYC8ob/wqF5dRwHt/smH6wF5SRc
        abtGQNPgBA+utuUhqB9+TEJZxyQBphfVODydmSfhYbOFB7O5HQiK3W0Y5MyZeZDvtPHhwcVz
        OMxOtZNgb23H4NrtURyWmjv5cL/7AQnL9noCRm/5w48OHSw2lxGw+iIL3xvCjPXuYxr7rYjh
        zqQwTeZ+PvP39JfM0h3E1Nfk8Bib9RTTUjGLMQvF9xFjHXeQzEplIcHkZk3ymLrJRowpsqwi
        Jm9Z8snWBHGUTptuYLertXpDtOhzKYSLpQoQh8sVYqnsnUPvhkeIwmKiktjUlK9ZXVjMYbF6
        oOsWfnyEyigvtiMjKnrdhLwENCWnBxp+55vQJoGQuoLoR5YVcn0RSHddML5iX/rlYxNvPTSF
        6HO15ZgJCQS+VDRtKXzfM/ejSnB69fRdwiPgFOdFT4yFelhIDWP0fF2wh3mUlDZNeIq8BN5U
        DO0udfI9TFA7aNeIg+/p3EIdoXu6fdYjPnTXxZH/Kr2ofXTDfCe5Xh9Jl9kG8XUOprMaSl6x
        P903Uo7lI6F5g27eoJg3KOYNSgUiapAfm67XJGv0UrFepdGnpyWLE7WaerT2kD93LtoaUdnY
        tNiBMAFyIFqAi/y8dwb0KIXeSarMb1idVqlLT2X1DhSxds4PeMCWRO3aR6cZlNJISYRUHqmQ
        RCgiZSJ/74bSWqWQSlYZ2GMse5zV/e9hAq8AIxZ/ICbd/unbSblko7qdfbI0ExfOnajydh3c
        8178nm2QGD9ZIP+q+7Lb8tEXp3YfUrV+FrI3Y9dl/+e+lfcCW5K2KyqCQuzZb8Vljpoqb1Sd
        bC078m3GjO8Hy6HJw7Khp6cvnCyNVXNP+pyBnIQvP++vyZQpZS9Xr97c/DBFc3Q6bHMDZZx6
        wzoTdWxrQSE7UXqwlvunu6M9oaDuNc5QHxz9Z2bwwo7e61z2oiv/RMuvZ22KsKQeblvH6ILs
        zepk+rcPj/ZpLXGhXcbneVSFqX/JyN1pyrw7Z9//nZw7XJUQlGVV3Zvr9RkX4jX9OrPkmUp9
        wxU4vX/oY2fhwqPbJSz4igi9WiXdhev0qn8BB1s7KhkEAAA=
X-CMS-MailID: 20201208100545eucas1p2384c9e6421e68c5e4b7a1aacc8015f99
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
        <27ce1176-6318-45aa-4e22-3dec9f3df15d@samsung.com>
        <9c784a23-eade-eacd-3e67-d344a5758b83@collabora.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andrzej,

On 07.12.2020 16:50, Andrzej Pietrasiewicz wrote:
> Hi Marek,
>
> W dniu 07.12.2020 o 14:32, Marek Szyprowski pisze:
>> Hi Andrzej,
>>
>> On 08.06.2020 13:22, Andrzej Pietrasiewicz wrote:
>>> Use the newly added helper in relevant input drivers.
>>>
>>> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
>>
>> This patch landed recently in linux-next as commit d69f0a43c677 ("Input:
>> use input_device_enabled()"). Sadly it causes following warning during
>> system suspend/resume cycle on ARM 32bit Samsung Exynos5250-based Snow
>> Chromebook with kernel compiled from exynos_defconfig:
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 1777 at drivers/input/input.c:2230
>> input_device_enabled+0x68/0x6c
>> Modules linked in: cmac bnep mwifiex_sdio mwifiex sha256_generic
>> libsha256 sha256_arm cfg80211 btmrvl_sdio btmrvl bluetooth s5p_mfc
>> exynos_gsc v4l2_mem2mem videob
>> CPU: 0 PID: 1777 Comm: rtcwake Not tainted
>> 5.10.0-rc6-next-20201207-00001-g49a0dc04c46d-dirty #9902
>> Hardware name: Samsung Exynos (Flattened Device Tree)
>> [<c0111718>] (unwind_backtrace) from [<c010d050>] (show_stack+0x10/0x14)
>> [<c010d050>] (show_stack) from [<c0b32810>] (dump_stack+0xb4/0xd4)
>> [<c0b32810>] (dump_stack) from [<c0126e24>] (__warn+0xd8/0x11c)
>> [<c0126e24>] (__warn) from [<c0126f18>] (warn_slowpath_fmt+0xb0/0xb8)
>> [<c0126f18>] (warn_slowpath_fmt) from [<c07fa2fc>]
>> (input_device_enabled+0x68/0x6c)
>> [<c07fa2fc>] (input_device_enabled) from [<c080a0f8>]
>
> Apparently you are hitting this line of code in drivers/input/input.c:
>
> lockdep_assert_held(&dev->mutex);
>
> Inspecting input device's "users" member should happen under dev's lock.
>
This check and warning has been introduced by this patch. I assume that 
the suspend/resume paths are correct, but it looks that they were not 
tested with this patch thus it has not been noticed that they are not 
called under the input's lock. This needs a fix. Dmitry: how would you 
like to handle this issue?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

