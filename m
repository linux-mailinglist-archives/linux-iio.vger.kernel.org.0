Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE472771BB
	for <lists+linux-iio@lfdr.de>; Thu, 24 Sep 2020 15:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgIXNCP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Sep 2020 09:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbgIXNCP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Sep 2020 09:02:15 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD34C0613CE
        for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2020 06:02:14 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c8so3268564edv.5
        for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2020 06:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/2EIFGUpml2WrC1ch4ZZp14W/iWBEO6d7ug8youJYes=;
        b=UdxzWbKXvbpHKL9/zmZD7JKncZvXBDpRRgjYhIPuGH6RrpgKd7nhLtWpyzvF9dCEDC
         r5MbOsRP7MTL8Xack24s7uj0y83wAagMU1q646BdpTEvvLjwalSkI4hnsrQ5TixFLCE6
         WSntaSyHGnld1/2pW2DGLk6Mr39izohxaAJrd5RiYbZI22Hh/ZlQzVtFM/ilW4k8Jund
         nqjVJSCw8+F1oEz5aEtRIJGNAVsWjUMhAyUAlSSvt/HqpywjG4NMxKYuzOrYuPrZIvh5
         k71BLKzwqHzy6CsSkTUlIIvdZ6O8+qBzTb4AcNRBhmjssH8QhpVipTae6Dd793oK1Lg3
         F7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/2EIFGUpml2WrC1ch4ZZp14W/iWBEO6d7ug8youJYes=;
        b=W8M6xZhH9sDGVPE/+UOGF6WLXZlOZvR9+e7fTGcpkMx+ZXiEZ33e8LkVX48FRCutEA
         9MfUCVo1twhOAPaqjbx3QpFmbAQL93Sg1q+9bYXoOoyp3B1Li9iClafbDMpIB3Cunss2
         /YZ4fWYTxJLK4JKg4xpIKk2vLpHuRyKiQKpEGA9u74Eld9lQB1ziN1o2OBwNioE/MLB2
         bae3rfm4UidXGL1hAbn1MfugOukTu5hERUZeZhymnSIGJnHPNszQhd6OHXax0Lp6ZcND
         Urrh/lpZ+mvrF4QLv1NxKqV+EoG4++cZ2LGQKMfOrlh7hQW+/UFwU0WD9AopiNnmjp/3
         rkqg==
X-Gm-Message-State: AOAM533JjAkZOBTamVV4d0njECoMPzVer3x4N5rVNKeb2tx6O/bvzL+c
        XGUv9qA4dLebnHpe9zQ7WcAwoJjI1gX8ER8R9+U=
X-Google-Smtp-Source: ABdhPJxbGxK4hp9Mc7/oo2mP1HluscaBIXEQwRoqoU3Us+ro0A2bSGT2zxVAos4KuEur/5rX3lGqbyUdVWqaiAifpRc=
X-Received: by 2002:aa7:c0d3:: with SMTP id j19mr980837edp.40.1600952533627;
 Thu, 24 Sep 2020 06:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200920135436.199003-1-jic23@kernel.org> <20200920135436.199003-2-jic23@kernel.org>
In-Reply-To: <20200920135436.199003-2-jic23@kernel.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 24 Sep 2020 15:02:02 +0200
Message-ID: <CAFBinCDr=eD-DO_jzWYmcf=MLjwab=Ns0fqJUKdeG_pq4CqrCw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] dt-bindings:iio:adc:amlogic,meson-saradc yaml conversion
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Sun, Sep 20, 2020 at 3:54 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This binding is non trivial due to the range of different parts
> supported having several subtle quirks. Martin has helped
> clarify some of them.
>
> Note, I haven't restricted the amlogic,hhi-sysctrl to only
> be present on the relevant parts if nvmem stuff also is, but
> it would seem to be rather odd if it were otherwise.
>
> Perhaps we look to make this binding more restrictive at a later date.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
this is looking great - so in case it's not too late please add my:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Best regards,
Martin
