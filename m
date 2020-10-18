Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BEB2918DF
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 20:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgJRScQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 14:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgJRScQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 14:32:16 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3F8C061755;
        Sun, 18 Oct 2020 11:32:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b26so4660716pff.3;
        Sun, 18 Oct 2020 11:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K40T/k83wtyWOrI2mPQwTzmm6Q0OfkO1kKDuP9It5QU=;
        b=QxbKiA16yJPrNiOwUwwa1gFCJoPHFm7k2WYEA7SPcJaj9fW7e+AjbnQu7ZYrsDPTLk
         CgBPi0idOZf1OOhXdh+oe0dY5HDioNTKyo8/YTJzdpI6AelccLcGostsEer8eMTaiMXJ
         0ME0DacPTxtgdeoMxAm7syKXwpINXf7ZP+RalmZsE32v7ddFJxql8ftSez0LFBP/G8Vz
         Jftl+b4qUGyYoTThNlxLZhuK/GdI5xIE3VDJpD/rhMmv2DQWJVmQe3mc9JR3vREWV5qC
         Y3IV0C02npU2nuqzn9tK04LWJT1+/mv7tMvGmYWgeWBh83ZC53wMO66ooawxmfyebJl+
         ZzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K40T/k83wtyWOrI2mPQwTzmm6Q0OfkO1kKDuP9It5QU=;
        b=YsL6OJy1h+IDiWHE1iKYQ4YLHZpR2NEkaXtwsaM+s5aHgKpMpeLEnWNy4Aj4ze0MkL
         qYP904pOWBqvFPahslvlhtDbIMjNeC5++XmtsRuBMu9T6+r6JWi8jPbN6rEI2sbrLC/X
         eoww5hvMaD8yVncXF65ZGJ2mo553jprdggfvIlxiTAolp9RiJ6yuwUfr1lbxgbRfZIG3
         d0XRt7O8+VcTpIIgBZgln7o+taJ74b5WHPNTeL6CfrJZ8IllRHnF7wk4BLfdRgFcFef2
         M5f0XIKgSyXdNjbZVXmWuxW5DLfc72UajENdnyIBTyxfiSBcZiVSdopwJQ8Kn4uzlaGM
         JwxQ==
X-Gm-Message-State: AOAM530ie8UlKoT24kNGudw+a5MGJgvDJOwcmi2bowXawy+Stw5Cf999
        VlLxq9/2VnPlcLBx4Bmzubu8H23SmPPOJUcUhRU=
X-Google-Smtp-Source: ABdhPJy0T474mJLE0+aZoaHtqo4YHqfTdvAt7GpQnZQEKFltdgzGUdJMMj/pHuUAu+b3Ybm3jfoAJPBMnvBTXNjkWXo=
X-Received: by 2002:a63:f908:: with SMTP id h8mr4294553pgi.203.1603045935923;
 Sun, 18 Oct 2020 11:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201018171545.3190476-1-fparent@baylibre.com>
In-Reply-To: <20201018171545.3190476-1-fparent@baylibre.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 18 Oct 2020 21:31:59 +0300
Message-ID: <CAHp75VfJUhA3WmmirctmrieQfZKSNerFa=nwPmBYvffXUTRp9A@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: mediatek: fix unset field
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, chun-hung.wu@mediatek.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 18, 2020 at 8:16 PM Fabien Parent <fparent@baylibre.com> wrote:
>
> dev_comp field is used in a couple of places but it is never set. This
> results in kernel oops when dereferencing a NULL pointer. Set the
> `dev_comp` field correctly in the probe function.
>
> Fixes: 6d97024dce23 ("iio: adc: mediatek: mt6577-auxadc, add mt6765 support")
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Shouldn't be a blank line in the tag block.

I think Jonathan can fix it, but be more careful in the future.

-- 
With Best Regards,
Andy Shevchenko
