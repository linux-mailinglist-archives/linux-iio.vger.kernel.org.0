Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373CC34BC56
	for <lists+linux-iio@lfdr.de>; Sun, 28 Mar 2021 14:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhC1Mdm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Mar 2021 08:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhC1MdB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Mar 2021 08:33:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961A6C061762
        for <linux-iio@vger.kernel.org>; Sun, 28 Mar 2021 05:32:53 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so6393817pjb.4
        for <linux-iio@vger.kernel.org>; Sun, 28 Mar 2021 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xFgRAiozSuIsPnNupM1553EqM57FpMfSBpRQbSpKgqc=;
        b=DcJnvdgNTWN0GzFGo0O7s05utPOFc1jm2TDIroRxbUjODgOPdpWmKkO/WJEf6rY4db
         Ajibgx90GH66H9Ww7MoKRKJy2QFuXWJxBuKoUhAk1kiTrMq+Jfbtaox4cNofAPVIPFTq
         hbyGgS9frJaSZkUUW7cOcWPfZ97VJ51NQFYbJM9/RZkzULQopgVSxtIxmOuud81eQC6M
         +CM1vbQ7wriAH7TY5b6WKw0v7CVXTNI71pqhmGmezVwHpOb3DcOK9/alG2nZQVAWwr/t
         LTeidy+2aqL3MVAytVSi7z1sBGe7AfxTDdX/4JiqCdPe6JXn9Y1Bw9WPghM14BlfaVcJ
         K69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xFgRAiozSuIsPnNupM1553EqM57FpMfSBpRQbSpKgqc=;
        b=ckUJvxsb2bhfeCiPc2vju8p+c1v8vukEEwig1LWq/qbnQFCGtiuJeX517sidvRx4/W
         JRW76EnZHTRXvt69fzX0sfRT9jK586oLWFKxHfy1KDZT9BJ6NtqFcbs7i1AIJZmtzQMd
         wHAPlDsTuBA90m906+/TiGhwk59jbKKurFy4lVscoiUSs5hWoNZE/OF4M6JpGav5s4T2
         9FzB7l1ekR7jOoY6/gt860d+qDFE2n/ukJ1McexFt/DKmdTmHViuWqKuia+sC5Hfobne
         whBzB7j1HE/7ltkwZN2LZg7j9YkqGwR5ViTgPR2Hhldfc5GZ8RGTfZGPLqUO575NfVvR
         3NUQ==
X-Gm-Message-State: AOAM531dNWl5owUKuYUmIHEgd3B7WChGKVcLQl2dQRlfP9QF2EsJbgPd
        nPKNJQx0GpAxOZmtNHdFrolQb3elp1QLgpPOjJf45FOYIRI=
X-Google-Smtp-Source: ABdhPJzNdEoE6mgZ9kLfhwntIzDWSBxxSSZFa0H9TFVFF8aDxTesRzRtSV8NGzqjE5bFUdlVtQ1TtPKQhOnronDGG1I=
X-Received: by 2002:a17:90a:e454:: with SMTP id jp20mr22940003pjb.129.1616934773013;
 Sun, 28 Mar 2021 05:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210328033639.1021599-1-gwendal@chromium.org> <20210328033639.1021599-3-gwendal@chromium.org>
In-Reply-To: <20210328033639.1021599-3-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 28 Mar 2021 15:32:36 +0300
Message-ID: <CAHp75VcD4NC8AN1m4DoW8D_Y=n2yTFUyWt5ZSX5=Awg=yFLwNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: sx9310: Add debouncer-depth parameters
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 28, 2021 at 6:36 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Semtech SX9310 SAR sensor has a debouncer filter: only when N
> measurements are above/below the far/close threshold an event is
> sent to the host.
> By default the debouncer is set to 2 events for the close to far
> transition and 1 event (no debounce) for far to close.
> It is a balance speed of detection and false positive avoidance.
>
> On some chromebooks, the debouncer is set to a larger number.
...

> +               ret = device_property_read_u32(dev, "semtech,close-debouncer-depth", &depth);
> +               ret = device_property_read_u32(dev, "semtech,far-debouncer-depth", &depth);

Are they existing properties or new ones? To me sounds like the
latter. In such a case you missed DT bindings update.

-- 
With Best Regards,
Andy Shevchenko
