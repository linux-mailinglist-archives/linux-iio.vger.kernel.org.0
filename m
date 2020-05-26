Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AC41E1E56
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 11:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbgEZJWV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 05:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388425AbgEZJWU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 05:22:20 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349AEC08C5C0
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2020 02:22:20 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z6so23564818ljm.13
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2020 02:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VakK3K1bdraH2CNaKAl1HsIOSqvOwW4BrMU1GIVbMHI=;
        b=MnxWolw9+48E82BoH0W4h0NGW8qNWn6yMAn4GAyxdbSVePnsGeI36UvX1g9L5RRBi8
         GmM11E2y1xIjISz2igNjVGdMCjBKrM7dGLaLrpPJt/vhSsAhQ32ci4eQ/Joq+sj/zxf+
         ZdBlienAY0XqjGtuVjQqycVSNEJFq7gk7pteYStezGwHhU3RBvGrWZg6O7UAPFBTZra5
         jMQ40HcgtLQwdQekePnYsX3Zhvn/0w52mgrC1lbXvcqldPEHypNpf2kG9KIh8jqLkT1i
         yvd1yL6iKiKNNxyS2HcwW4tOv/FS/YwC/HTfDTNd7pS7xmbG5epLeZYMGoTsofuPO8k6
         5KzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VakK3K1bdraH2CNaKAl1HsIOSqvOwW4BrMU1GIVbMHI=;
        b=qMT71bzWJ1tp2M/T+dqzBql5yw1M4t5M+oqaBn4j0nPa+rh0oSsbE45WhY4ppSXsXf
         LfIsx3dmqu+mMr4I14uYMJbxOLqbfdE55uhVrtjI1PXZGUL0NGs2CFHvRHtox4UDgpU2
         YEeU5WVpCk+mL5ZGCXhVLgzJ+cVc3KXAkxupPHnwA9biCuLVEjOjUZMIKDkGKSLtcHoy
         ZqZdGm6Nign3ORmDkCarwTT24okvnODHwLDgG23bX/SuihwUKJ9VLM8YQ1Aaj1ANsjY0
         8NgTlinpi2J92YHVJyy2iBeDN1M7xdMByEeSlY+3snwUNJBWhW6ArAiiPpMYlBu01rDx
         vLlg==
X-Gm-Message-State: AOAM531XFvx9yvZJu7gD+No+y8vHry9GnfG2ToauhcyeG3+bTWZLJnAu
        Ci3vLeFs3fJa6ZPRNGU2vgDp0G2JAVhOhaA3Y7AVUbcT
X-Google-Smtp-Source: ABdhPJw8pZgJaIXNUkLHn6B/J6FuTQ9hom3jWdzfr1ToPBwixrVD38ffTLrjv381+a2u7Q5Qz7hclK+v3FW2m0rQXNA=
X-Received: by 2002:a05:651c:32d:: with SMTP id b13mr146695ljp.283.1590484938670;
 Tue, 26 May 2020 02:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200525151117.32540-1-jonathan.albrieux@gmail.com> <20200525151117.32540-4-jonathan.albrieux@gmail.com>
In-Reply-To: <20200525151117.32540-4-jonathan.albrieux@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 May 2020 11:22:07 +0200
Message-ID: <CACRpkdZo4PsC9Y8seMfS33escA6ZVKWwnbW2BCFOKiX2gY8RDw@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] dt-bindings: iio: magnetometer: ak8975: add gpio
 reset support
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 25, 2020 at 5:13 PM Jonathan Albrieux
<jonathan.albrieux@gmail.com> wrote:

> Add reset-gpio support.
>
> Without reset's deassertion during ak8975_power_on(), driver's probe fails
> on ak8975_who_i_am() while checking for device identity for AK09911 chip.
>
> AK09911 has an active low reset gpio to handle register's reset.
> AK09911 datasheet says that, if not used, reset pin should be connected
> to VID. This patch emulates this situation.
>
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
