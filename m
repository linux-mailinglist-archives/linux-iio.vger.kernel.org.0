Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC9C3E34DA
	for <lists+linux-iio@lfdr.de>; Sat,  7 Aug 2021 12:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhHGKhx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Aug 2021 06:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbhHGKhu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Aug 2021 06:37:50 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED1DC0613CF;
        Sat,  7 Aug 2021 03:37:33 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c16so10640377plh.7;
        Sat, 07 Aug 2021 03:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cOqop49TO9y4iKlVvaZlNAFE274ACz5k07MpZwKL26g=;
        b=Bv3rSHN2iQk1YdtOZV+oPO7kNdI+98gUGdMBh0AkIr7PitjVuURcz5/0vDDB+3p2x4
         tYzks2qCpGrhtPHMwfEu+N4pAZ56oYQ8euVtIKM6d8NJaRiWmV+YnUxbi+ExQcZ4pcPD
         ikCzjnn7QJWqoOU7Av/VbazABcQ8VHBQq80u373HKqvoMTz5mOFVSBEE6vdZE+TR9fjd
         6jAIaaSTuZPfuyUva2R4ElvjmcHItJEg34H+ds2EziQmN1sm3fImMI9gZNt8m7UJ4048
         nqY+yQ0i606NKCO+leA0fvjRbOZm1hsUX3o1mDb7u2rRzveemXHSNrSirX8zPKZUDCbh
         i2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cOqop49TO9y4iKlVvaZlNAFE274ACz5k07MpZwKL26g=;
        b=GY3iPyrvRKewUYCeLtYdZicTSkaWflmyQV61UrvcMvlJrYti5sA4GvKOLxtaU2j5XW
         gu2MeptcXDhI30ZOYoqLLeSnkjDVl5GukHvuGYKvKbYue25nm5u5dldTsXjnpML5com+
         kaLybah7YCxgErcVp6H/6uWFkc9inzjAQLl29hKWjs1aL+S39ZGaihjsstIWyoSstFwN
         GmHOZfaQ+uJCJ2Bk2QNNRfpb8ZE9Qf/b3qPMKGbE/KBWnngDkdWZeVGpGOYD4Mp9fx3i
         DjIwF776jWEo39L00Hd64YhRKucv1YVWFOam+NiKDSgpe/UXcYiwtbCKt4lNT83Uz5dB
         fe9Q==
X-Gm-Message-State: AOAM532VVhwNOSz/0/t50GWSG2rzbsdxE7vh3namksbxIR2OZdgT2MKv
        1+hBBVuEHxvzPRvX4BajgzBciAOXZeyFpsYnTdoP8V+y33w=
X-Google-Smtp-Source: ABdhPJyZkbcJ7w1Xu92vuQiCpBzQFI/sjQ2dQTNJrwxePMa9aUSvWB445uc08XeRtyzX/MrA+0VvHZl0zuKpcrQnVLQ=
X-Received: by 2002:a17:90b:33c5:: with SMTP id lk5mr26016485pjb.129.1628332652567;
 Sat, 07 Aug 2021 03:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210806105524.231838-1-xxm@rock-chips.com>
In-Reply-To: <20210806105524.231838-1-xxm@rock-chips.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 7 Aug 2021 13:36:56 +0300
Message-ID: <CAHp75VcSMx3CPt9cgzdZ63xRrowm1H+Jpbhd5W74oeVBUY34WQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: rockchip_saradc: add voltage notifier so get
 referenced voltage once at probe
To:     Simon Xue <xxm@rock-chips.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        David Wu <david.wu@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 6, 2021 at 6:24 PM Simon Xue <xxm@rock-chips.com> wrote:
>
> From: David Wu <david.wu@rock-chips.com>
>
> Add voltage notifier, no need to query regulator voltage for
> every saradc read, just get regulator voltage once at probe.
>
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: David Wu <david.wu@rock-chips.com>

The order of SoB tags seems wrong or Co-developed-by is missed.

-- 
With Best Regards,
Andy Shevchenko
