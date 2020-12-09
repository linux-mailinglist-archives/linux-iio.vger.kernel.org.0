Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B302D3B90
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 07:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgLIGi0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 01:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgLIGiZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 01:38:25 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C934DC0613CF;
        Tue,  8 Dec 2020 22:37:45 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id j1so423126pld.3;
        Tue, 08 Dec 2020 22:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=e50gjx2u+dk5VMtYgu+q4thABv8jJUcueqKzMMAspdM=;
        b=ixLOM9HvY9cq9Z4h6NLLxTGvQ6HSYGtx3j6FDGjAbxvLa2OpQf6evTG0K7aZ8AyjSg
         Vz4p0EtroLc123xr1LjxiO7na/Pplis+8FzmNk1d2UrvVlqZn09vTY6OtuwPEytSuGG5
         2KCJbhZpSunbmaFIabDEFehnWei8Vt8i4Oc66zINdaloS1KlTL4RhfHAx8SycAn2ADXy
         YYLbUI9xC9wRdfqk9Ka7jLgWNvZxP0tNIfJltreYt+Oh5syP5tk1wE9V022lxItkYGs5
         /OGETCIhjaIt9TdmtA4GohQaG58NA5xxvbe5jJROaeFQOjvoee/Vgex7LnTi6mSyI+/t
         Kb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e50gjx2u+dk5VMtYgu+q4thABv8jJUcueqKzMMAspdM=;
        b=Ons/8vi8C/L+E3fvYfxpGl1el4ZSLrhT+YqYYXGdq81ubG5rU+9yF8adMRuF+hOrKH
         RLPe1BmRhYaqx5k7/K69Yb0Fqy636p/FNuJQuJuFuZilQNOxsHgdVchppHVSKzb7cBrX
         0XfZKUhBbJa02Kcmj1yTyp3/H48UWfXfsJVGTQw15Wwrws76gN6C2D0f5qFnXK+CLB8y
         AFe8X1bGY9ogB6or/q8C0qa6Um7QK34ThJvUBkw5B4Mg5qXtIVTjWMmWR4VfOrIC8Etv
         6JQ7DkJ/reIP5dKb5ka/9UEecKzQS1QY90PZrC7/eLqPvKgxzTWu4Jd693QLmamF0srJ
         EZ8Q==
X-Gm-Message-State: AOAM531QnZ3PWySNvyoiq97K1qx1db4BjdgnbwZVv5H86nAqSe1xRM9s
        skpQfVIRSKfh3kNe8uhCcoU=
X-Google-Smtp-Source: ABdhPJwjfEiPLMae+ffo6Cnhp7douBFcf3vSLYOtRxV9vdx0S2C51CdSPEgUeVMZh9kilf8XyPe8TA==
X-Received: by 2002:a17:90b:4a0d:: with SMTP id kk13mr880119pjb.23.1607495865199;
        Tue, 08 Dec 2020 22:37:45 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id z11sm990299pfj.191.2020.12.08.22.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 22:37:44 -0800 (PST)
Date:   Tue, 8 Dec 2020 22:37:40 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
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
Subject: Re: [PATCH v4 2/7] Input: use input_device_enabled()
Message-ID: <X9BwtHs9XriwR8gL@google.com>
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
 <20200608112211.12125-3-andrzej.p@collabora.com>
 <CGME20201207133237eucas1p26f8484944760a14e51dc7353ed33cd28@eucas1p2.samsung.com>
 <27ce1176-6318-45aa-4e22-3dec9f3df15d@samsung.com>
 <9c784a23-eade-eacd-3e67-d344a5758b83@collabora.com>
 <ad093ba3-7b17-18f3-6bb5-d8133c3da89a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad093ba3-7b17-18f3-6bb5-d8133c3da89a@samsung.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 08, 2020 at 11:05:42AM +0100, Marek Szyprowski wrote:
> Hi Andrzej,
> 
> On 07.12.2020 16:50, Andrzej Pietrasiewicz wrote:
> > Hi Marek,
> >
> > W dniu 07.12.2020 o 14:32, Marek Szyprowski pisze:
> >> Hi Andrzej,
> >>
> >> On 08.06.2020 13:22, Andrzej Pietrasiewicz wrote:
> >>> Use the newly added helper in relevant input drivers.
> >>>
> >>> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> >>
> >> This patch landed recently in linux-next as commit d69f0a43c677 ("Input:
> >> use input_device_enabled()"). Sadly it causes following warning during
> >> system suspend/resume cycle on ARM 32bit Samsung Exynos5250-based Snow
> >> Chromebook with kernel compiled from exynos_defconfig:
> >>
> >> ------------[ cut here ]------------
> >> WARNING: CPU: 0 PID: 1777 at drivers/input/input.c:2230
> >> input_device_enabled+0x68/0x6c
> >> Modules linked in: cmac bnep mwifiex_sdio mwifiex sha256_generic
> >> libsha256 sha256_arm cfg80211 btmrvl_sdio btmrvl bluetooth s5p_mfc
> >> exynos_gsc v4l2_mem2mem videob
> >> CPU: 0 PID: 1777 Comm: rtcwake Not tainted
> >> 5.10.0-rc6-next-20201207-00001-g49a0dc04c46d-dirty #9902
> >> Hardware name: Samsung Exynos (Flattened Device Tree)
> >> [<c0111718>] (unwind_backtrace) from [<c010d050>] (show_stack+0x10/0x14)
> >> [<c010d050>] (show_stack) from [<c0b32810>] (dump_stack+0xb4/0xd4)
> >> [<c0b32810>] (dump_stack) from [<c0126e24>] (__warn+0xd8/0x11c)
> >> [<c0126e24>] (__warn) from [<c0126f18>] (warn_slowpath_fmt+0xb0/0xb8)
> >> [<c0126f18>] (warn_slowpath_fmt) from [<c07fa2fc>]
> >> (input_device_enabled+0x68/0x6c)
> >> [<c07fa2fc>] (input_device_enabled) from [<c080a0f8>]
> >
> > Apparently you are hitting this line of code in drivers/input/input.c:
> >
> > lockdep_assert_held(&dev->mutex);
> >
> > Inspecting input device's "users" member should happen under dev's lock.
> >
> This check and warning has been introduced by this patch. I assume that 
> the suspend/resume paths are correct, but it looks that they were not 
> tested with this patch thus it has not been noticed that they are not 
> called under the input's lock. This needs a fix. Dmitry: how would you 
> like to handle this issue?

The check is proper and the warning is legit, cyapa should not be
checking this field without holding the lock. I think we can simply
remove this check from the power ops for gen3 and gen5, and this should
shut up the warning on suspend, but there other places in cyapa that do
check 'users', and they also need to be fixed.

Thanks.

-- 
Dmitry
