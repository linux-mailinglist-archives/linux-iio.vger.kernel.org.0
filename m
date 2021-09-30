Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1217641D855
	for <lists+linux-iio@lfdr.de>; Thu, 30 Sep 2021 13:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350290AbhI3LGL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Sep 2021 07:06:11 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:49239 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350289AbhI3LGL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Sep 2021 07:06:11 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MvJjz-1mn9b81Zwn-00rFfp; Thu, 30 Sep 2021 13:04:27 +0200
Received: by mail-wr1-f44.google.com with SMTP id k7so9268714wrd.13;
        Thu, 30 Sep 2021 04:04:27 -0700 (PDT)
X-Gm-Message-State: AOAM530aYBLVOIXWKKOTE9wlGtbpSbj3h9sTMvBwWXC7TEsEVNCnAB/c
        oR4UzdzAI6UWnfl+/JiTC8GGASCIXrVCMLf3GfE=
X-Google-Smtp-Source: ABdhPJy1xEUoEv0MPNfkxd+7bEPQ5aTe3WHfilrEA8zzOCj4njTUOJuS5/AGkDQ6Sh+U+gR+2Oy24/rBGxxYFzE6N7A=
X-Received: by 2002:a5d:6cb4:: with SMTP id a20mr5464868wra.428.1632999866916;
 Thu, 30 Sep 2021 04:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210930081025.366039-1-drhunter95@gmail.com>
In-Reply-To: <20210930081025.366039-1-drhunter95@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 30 Sep 2021 13:04:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3LPLbJRDEsYgSL9x=rrk1=AmBWxFBNd0H591NKrLnMZA@mail.gmail.com>
Message-ID: <CAK8P3a3LPLbJRDEsYgSL9x=rrk1=AmBWxFBNd0H591NKrLnMZA@mail.gmail.com>
Subject: Re: [PATCH v4] workaround regression in ina2xx introduced by
 cb47755725da("time: Prevent undefined behaviour in timespec64_to_ns()")
To:     Iain Hunter <drhunter95@gmail.com>
Cc:     lothar.felten@gmail.com, iain@hunterembedded.co.uk,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Zeng Tao <prime.zeng@hisilicon.com>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:gPwyXOUSqhD2JyrnR9xytDHMiVW4DELITPtkFiJXSAOqYSc/EkL
 WMDVysnbyrwLFPacdn2twqA+KcXKEEhthTyM3L1ILSAMZxEvuIo63MtgOUP4nwmyFa4Ehud
 xJhFFYVHx8wwarXPk9mig2WdH9hxrGLcgvXNaSGH/TnA9vu/LgFd7aR7no3/x4zMrXXqPmt
 wjxxy2V89tEtg71YhCCZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5cYFcAwxonU=:G1ly75JYKNmg3iArcyZ2vK
 8a9nmP8I3bp4Hc9ok/4KNn/IYTq2dpffMogwdPKR4sbBA66+H+dj71QqicK9sUK0bhka2lX+/
 nDmNtteoVtIqmTP4G/RIv9ep4WZ2NjVMN9O/1W4Imk91hnOZSXZNN3s+aIjEyWet9SOUbLQ+R
 lcEhgU9jsJJicAjVwWgCASMzgps7s/m6SrjlASCn7tlnV6j47Pf1uA2KkWJ4Rl+6hkdjGczVI
 wvZ1l0ePAJYRChDMYt35Rbl4Q/iVwQmP0Z3YmYy/ABS/52o/F7rQNEv3ihXWkcdZWaCz4swTq
 KkvIEBJGFGCBA4pIJH5hUjOirSb2+OPku7vT3z2YUEku7WUZj9L26Cug9bZA0ImU8FxstAoKE
 XmfetWQiiCeOwTmwv3LlMx7RJtHTpcyTMwmqcHvdNhO0/qEO7tRRuIj+bbmMMb62G+FSNEM5j
 wzxiCax5WHZQpX5qy4P9UVleTwo77YKClNC4rQ+dBivuy3zwZiR3/M6i3r3HblYLeC4qD2dIR
 wmfUmlr5rX2rUZQo2un6fvJD3TSrrvssuKa2ox3/vXYjwi0IGBBjQhHOPTlgjalyhIaLp/FeE
 UJwXmJdx84uWrWBNuo+IVIiBc+Mx9UF9rOTojEKPXdGHjZBNEaXBdmpYPdc4zZC9fJP+Yuum3
 Z5U/LzsO9IrLGD8p7HeypRTQJko2bFuCFLHs5vQXv8Ym7cuyjaGuTy017CMoOBSfcpRR2AXCJ
 P+gtaAQisfMq9g1Sr1/69o23ouewr4oSiBnbBg==
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 30, 2021 at 10:10 AM Iain Hunter <drhunter95@gmail.com> wrote:
>
> From: Iain Hunter <iain@hunterembedded.co.uk>
>
> That change adds an error check to avoid saturation during multiplication
> to calculate nano seconds in timespec64_to_ns().
> In ina2xx_capture_thread() a timespec64 structure is used to calculate
> the delta time until the next sample time. This delta can be negative if
> the next sample time was in the past. In the -1 case timespec64_to_ns()
> now clamps the -1 second value to KTIME_MAX. This essentially puts ina2xx
> thread to sleep forever.
> Proposed patch is to:
> 1 change from timespec64_XXX() to standard raw ktime_XXX() APIs to remove
> non-standard timespec64 calls.
> 2 split the functionality in the loop into two parts:
> - do while loop only does the test to see if the next sample time is in the
> future or in the past and so will be skipped and the sample time
> incremented until it is in the future. This test is done with a simple
> signed comparison as we are only interested in the sign being positive or
> negative.
> - after do while loop we know that next is later than now and so delay is
> positive and ksub_sub() can be used to get the delay which is positive.
>
> Signed-off-by: Iain Hunter <iain@hunterembedded.co.uk>
>
> Fixes: cb47755725da("time: Prevent undef$

The changelog text could be improved to more closely follow the
style described in Documentation/process/submitting-patches.rst,
but the important information is here and the changes look good
to me.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
