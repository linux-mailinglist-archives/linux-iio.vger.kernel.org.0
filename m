Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1692D719F
	for <lists+linux-iio@lfdr.de>; Fri, 11 Dec 2020 09:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436859AbgLKIYC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Dec 2020 03:24:02 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39862 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436846AbgLKIXm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Dec 2020 03:23:42 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201211082248euoutp01223b0ffab667998e16dd12475dea9633~Pm93IjYgv2667426674euoutp01Z;
        Fri, 11 Dec 2020 08:22:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201211082248euoutp01223b0ffab667998e16dd12475dea9633~Pm93IjYgv2667426674euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1607674968;
        bh=EPWpPxaL1kgGyP4y1rAeD68RhW99/C5QTk2XWnaps1g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BFcvi7Sntxic0Qz/yiSYIPzrCMJj80D0pRsJa35lcsVuwX6w/uR/2lAnQiJ3Q5M+Y
         huuFjjD52OiSdOWrpyG3KoW6hKlLysiZJmWlWaJtUCLizWE52E5tDqe/jImvOaAcG9
         570Hczk8jN+jlagxXl3mQHVj2BitBELQJBcieEtQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201211082248eucas1p22f70923933f5ab50cc44ebf033385af0~Pm92j1pHn2458824588eucas1p2Y;
        Fri, 11 Dec 2020 08:22:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 72.48.27958.85C23DF5; Fri, 11
        Dec 2020 08:22:48 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201211082247eucas1p2bcbb136330cf83031d697b08dafa89b0~Pm92EC00a1636416364eucas1p22;
        Fri, 11 Dec 2020 08:22:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201211082247eusmtrp22baf72f4d261456b2730397a38aca3b9~Pm92Cvw9Z2764927649eusmtrp2V;
        Fri, 11 Dec 2020 08:22:47 +0000 (GMT)
X-AuditID: cbfec7f2-f15ff70000006d36-55-5fd32c585127
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1E.15.16282.75C23DF5; Fri, 11
        Dec 2020 08:22:47 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201211082245eusmtip132375ffa3fbef40063d97e5055ac2005~Pm90JJ9H22215522155eusmtip1j;
        Fri, 11 Dec 2020 08:22:45 +0000 (GMT)
Subject: Re: [PATCH] Input: cyapa - do not call input_device_enabled from
 power mode handler
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
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
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <fa0e07b1-dee7-9b44-897d-66095f2eab90@samsung.com>
Date:   Fri, 11 Dec 2020 09:22:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <X9MbMja+TEfbKkmJ@google.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ta1CUZRTHe/a97AItvVyMB6Vy1miEuE41nUQR1KF36oPpVBPOKG36CkyA
        uCuoUalA4i4yXOTmLgjYBrVExELALhvEQjINDtDCBhhQCCYRLCGMCITE7kLx7XfO+Z/nnP+Z
        eQSE80N6qyA67gwniRPHiGh7sv7WYpfvez69EQED9ykoHxshoaawmoJxQwYBbTcnELTPtpEw
        ajoIUx0FPFC27YaiP6oQpN2VUfB7spoHqYqbJNR2XaVAnaclIXPsLwJ0q1MEdHd/ywfVtRIK
        vmiuJEE7Ok1DRXMmAs3YLxTcaDeTIF/6ioDBBw8p6NUV0TCX0Y6gsLuZB7J5BQ1ZbbV8MF5P
        J2BupoWChu9beFCpnyBgWXeLD7c7jRSsNGhImKhzgxyDBBZ1N0hYXUohQrzYSVMo2zisQuzl
        5GhWqxjms3/PHmOXf0CsRi2j2VrVBbapdI7HLhTeRqxqykCxj8tySTYjxUyzNeZGHltQtIrY
        zJWAt54+Yr/7BBcTnchJ/IPft4+qkHfS8Tne5+5p0vgXkX6HHNkJMPMy1sru0RZ2Zr5EuD/9
        HTmyX+N5hBdalklbMIfwbGfamkpg7Vgs59nyFQjfb9oIZhHunJdRlqdcmGO4rK+ftLAr448b
        lEvIIiKYKQfc0jzCtxRoJhDLp+XW2UImGA/2FVrzJOOJS7X5hIW3MB/gavmjdY0T/un6uPVR
        O8YbL7SqrUwwz+GU75SEjd3wnfES60aYueqA9R1mymb0ANaXqvk2dsGTHXXr7IFXtRsNKQiP
        dlXx17sR7k0uRDZVEB7qWrIegGC8cLXO35YOxUOVGsp2F0c8MO1kW8IR59QXELa0EF+57GxT
        v4AVHd/8N7a1x0hkIZFikzXFJjuKTXYU/88tRaQauXEJ0thIThoYx531k4pjpQlxkX7HT8Vq
        0NrX6Hzc8aARFU/O+hkQT4AMCAsIkavwGdIY4Sw8IT7/ESc5FSFJiOGkBrRNQIrchGrl1xHO
        TKT4DPchx8Vzko0qT2C39SIv97D5bmyM91FBnV5SFda9X2X++c1+n5CavpHwZ5v33gkOvVDn
        MnKEC2nTFmfkPnUetTY86Z7VkHhQudfrUJCLp/GzOmV+j0mQ8eI+utih4HPfmaBB/0NziR6/
        nkseSl/kQ5LHdhM/CuSer1TAteEudJZIn3nV6xNR6tv00KWECbHkz+d3qU6HmwJ2Xjr9T/2e
        dz8OWSljdmUnPXI8PFCbTYuwap/n+JjypOLHeLsnjO4p3cbQlyA8LybMW+aeEFmbGPT6UY9e
        X9dPDalOupXf8pLa83t8jofsvOJvf9J5akSoFfRklwvY17bYvaGvjN2TzzTFGbc79m/bYQor
        2S90Ui6LSGmUONCbkEjF/wJuvZSbiQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTVxzHd+6jvahkl4fjhG1IrlkcRAvl5Q+DKMvmbljmiHNuwU2seAPI
        07YsYsxswKiUERAZj0J4KGgsc2qLg/J0hagEhIWXY1sN77DyWkVGCgNGwSX898k538/3/E7y
        Y0jHqyJXJiZBKcgTZHGcaAvVvvLEtOfL3T0R3pV/usGtkRcUPCi4R8OoMZOElhsTCFotLRQM
        9X0GU0/yCShqCYLi8bsIrgyn0zCYqiXgkuYGBfrO72nQ/mCgIGtkkoS61SkSurrui6HieikN
        lU1VFBiGpkVwuykLgW6kn4aS1hkK1It3SBh4+Q8NPXXFIpjLbEVQ0NVEQPorjQiyW/Ri6C7M
        IGFutpmGmsZmAqoaJkhYqnssho72bhqWa3QUTFS7QI5RDta6EgpWF9PIgx68uS+ErzVVIP5y
        agxv0JjE/N+WE/zSI8TrtOkiXl9xka8vmyP4hYIOxFdMGWl+pTyX4jPTZkT8g5lags8vXkV8
        1rJ32FvhkiB5YrJScI9OVCj3c8el4CORBoLExy9QIvXd+80+H3/OKzjotBAX860g9wo+KYm+
        rW4XJeV4nhvTXRGrUMNONWIYzPph6y1CjbYwjmwlwrn6AVKN7NbO38FteSp6g53wv/1q0UZo
        FmFzzQJhu3BiT+Dy3ueUjZ1ZL1xTtIhsIZJ9uRXrr02+ru0n8Yq+c71WxEqxetpWZcfYs8F4
        oLdAbGOKfQ+XGfJI20jb2VP4WbvDRsQBtxWOrj9gx3rihV+060yyAbhEP0Ru8A6c9rDoNbvg
        30dLiWzkqNmkazYpmk2KZpNShigtchaSFfFR8QofiUIWr0hOiJJEJsbr0NpK/vzYWl2L7pgt
        EiMiGGREmCE5Z/t3qe4IR/vTspTzgjwxQp4cJyiMyH/tO9dI1+2RiWs7naCMkAZ4+0v9AgK9
        /QMDfDkXe7/WHyMc2SiZUogVhCRB/r9HMHauKiIo9dxfR76YdL/YmPPr+7PPlz5oI3NLfxKH
        unsd2GkxhXIvUp55pOTPHBKb5o9rXXJHxqeaw6q3NkaW/8aEDj7S/qE2DmwbHsvv9QvL6/Uw
        fHThzAXzYd8aw+Vt8pPhboTFOjYQq/180nSoe/xr5XUf+3sOPd1lGvH0sVN3G/Y9zSCeyjjL
        KEd/qj//YZZxrzUnq+WY69vKuMbqs28erh8ci7o5bFb0XVquD+LGVwsr5ZqKKoNv+GyO73CB
        g+vRoxlT7BvzM/W7g5M/bl3u2BHLueMxj/kDnWSf+TvzK+eHZ7/65Iyqzm5aV++0/+AeryQm
        W9JWFWI94naVDk1Q3Q/ZpWI4ShEtk3qScoXsP1vWUG0bBAAA
X-CMS-MailID: 20201211082247eucas1p2bcbb136330cf83031d697b08dafa89b0
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
        <ad093ba3-7b17-18f3-6bb5-d8133c3da89a@samsung.com>
        <X9BwtHs9XriwR8gL@google.com> <X9MbMja+TEfbKkmJ@google.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 11.12.2020 08:09, Dmitry Torokhov wrote:
> Input device's user counter is supposed to be accessed only while holding
> input->mutex.  Commit d69f0a43c677 ("Input: use input_device_enabled()")
> recently switched cyapa to using the dedicated API and it uncovered the
> fact that cyapa driver violated this constraint.
>
> This patch removes checks whether the input device is open when clearing
> device queues when changing device's power mode as there is no harm in
> sending input events through closed input device - the events will simply
> be dropped by the input core.
>
> Note that there are more places in cyapa driver that call
> input_device_enabled() without holding input->mutex, those are left
> unfixed for now.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>
> Marek, could you please try this one?

The warning is still there:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 1787 at drivers/input/input.c:2230 
input_device_enabled+0x68/0x6c
Modules linked in: cmac bnep mwifiex_sdio mwifiex sha256_generic 
libsha256 sha256_arm btmrvl_sdio btmrvl cfg80211 bluetooth s5p_mfc 
exynos_gsc v4l2_mem2mem videob
CPU: 1 PID: 1787 Comm: rtcwake Not tainted 
5.10.0-rc7-next-20201210-00001-g70a81f43fddf #2204
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c0111a58>] (unwind_backtrace) from [<c010d390>] (show_stack+0x10/0x14)
[<c010d390>] (show_stack) from [<c0b3503c>] (dump_stack+0xb4/0xd4)
[<c0b3503c>] (dump_stack) from [<c0127428>] (__warn+0xd8/0x11c)
[<c0127428>] (__warn) from [<c012751c>] (warn_slowpath_fmt+0xb0/0xb8)
[<c012751c>] (warn_slowpath_fmt) from [<c07fbccc>] 
(input_device_enabled+0x68/0x6c)
[<c07fbccc>] (input_device_enabled) from [<c080a204>] 
(cyapa_reinitialize+0x4c/0x154)
[<c080a204>] (cyapa_reinitialize) from [<c080a354>] (cyapa_resume+0x48/0x98)
[<c080a354>] (cyapa_resume) from [<c06b0230>] (dpm_run_callback+0xb0/0x3c8)
[<c06b0230>] (dpm_run_callback) from [<c06b0604>] (device_resume+0xbc/0x260)
[<c06b0604>] (device_resume) from [<c06b29e4>] (dpm_resume+0x14c/0x51c)
[<c06b29e4>] (dpm_resume) from [<c06b35b8>] (dpm_resume_end+0xc/0x18)
[<c06b35b8>] (dpm_resume_end) from [<c01a1270>] 
(suspend_devices_and_enter+0x1b4/0xbd4)
[<c01a1270>] (suspend_devices_and_enter) from [<c01a1fa4>] 
(pm_suspend+0x314/0x42c)
[<c01a1fa4>] (pm_suspend) from [<c019fe90>] (state_store+0x6c/0xc8)
[<c019fe90>] (state_store) from [<c0388438>] (kernfs_fop_write+0x10c/0x228)
[<c0388438>] (kernfs_fop_write) from [<c02dc3e8>] (vfs_write+0xc8/0x530)
[<c02dc3e8>] (vfs_write) from [<c02dc98c>] (ksys_write+0x60/0xd8)
[<c02dc98c>] (ksys_write) from [<c0100060>] (ret_fast_syscall+0x0/0x2c)
Exception stack(0xc3923fa8 to 0xc3923ff0)
irq event stamp: 54139
hardirqs last  enabled at (54147): [<c01a5f20>] vprintk_emit+0x2b8/0x308
hardirqs last disabled at (54154): [<c01a5ee4>] vprintk_emit+0x27c/0x308
softirqs last  enabled at (50722): [<c01017a8>] __do_softirq+0x528/0x684
softirqs last disabled at (50671): [<c0130ac8>] irq_exit+0x1ec/0x1f8
---[ end trace 1fbefe3f239ae597 ]---

>   drivers/input/mouse/cyapa_gen3.c |    5 +----
>   drivers/input/mouse/cyapa_gen5.c |    3 +--
>   2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
> index a97f4acb6452..4a9022faf945 100644
> --- a/drivers/input/mouse/cyapa_gen3.c
> +++ b/drivers/input/mouse/cyapa_gen3.c
> @@ -907,7 +907,6 @@ static u16 cyapa_get_wait_time_for_pwr_cmd(u8 pwr_mode)
>   static int cyapa_gen3_set_power_mode(struct cyapa *cyapa, u8 power_mode,
>   		u16 always_unused, enum cyapa_pm_stage pm_stage)
>   {
> -	struct input_dev *input = cyapa->input;
>   	u8 power;
>   	int tries;
>   	int sleep_time;
> @@ -953,7 +952,6 @@ static int cyapa_gen3_set_power_mode(struct cyapa *cyapa, u8 power_mode,
>   	 * depending on the command's content.
>   	 */
>   	if (cyapa->operational &&
> -	    input && input_device_enabled(input) &&
>   	    (pm_stage == CYAPA_PM_RUNTIME_SUSPEND ||
>   	     pm_stage == CYAPA_PM_RUNTIME_RESUME)) {
>   		/* Try to polling in 120Hz, read may fail, just ignore it. */
> @@ -1223,8 +1221,7 @@ static int cyapa_gen3_try_poll_handler(struct cyapa *cyapa)
>   	    (data.finger_btn & OP_DATA_VALID) != OP_DATA_VALID)
>   		return -EINVAL;
>   
> -	return cyapa_gen3_event_process(cyapa, &data);
> -
> +	return cyapa->input ? cyapa_gen3_event_process(cyapa, &data) : 0;
>   }
>   
>   static int cyapa_gen3_initialize(struct cyapa *cyapa) { return 0; }
> diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
> index abf42f77b4c5..afc5aa4dcf47 100644
> --- a/drivers/input/mouse/cyapa_gen5.c
> +++ b/drivers/input/mouse/cyapa_gen5.c
> @@ -518,8 +518,7 @@ int cyapa_empty_pip_output_data(struct cyapa *cyapa,
>   			*len = length;
>   			/* Response found, success. */
>   			return 0;
> -		} else if (cyapa->operational &&
> -			   input && input_device_enabled(input) &&
> +		} else if (cyapa->operational && input &&
>   			   (pm_stage == CYAPA_PM_RUNTIME_RESUME ||
>   			    pm_stage == CYAPA_PM_RUNTIME_SUSPEND)) {
>   			/* Parse the data and report it if it's valid. */
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

