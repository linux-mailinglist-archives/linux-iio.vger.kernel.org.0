Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74579256869
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 16:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgH2Osr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 10:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgH2Osq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Aug 2020 10:48:46 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE0DC061236;
        Sat, 29 Aug 2020 07:48:46 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id ay8so1651064edb.8;
        Sat, 29 Aug 2020 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b/qCN7j8tb2VUbSrI7tBTv/xuxn0AqjD1uWSjfTSjT4=;
        b=hHbur1rsCmRq/5XRl3unzdV1tt10cWSYSErINzv3YotSrO4cpzSxPBIZJ2F8a/p32y
         EbtjHtBuQMT/xnw1bnaezOZ1tZ1Y9WFE9e6+e3Gf8QQSqDHzcBWhyDMXhaBBzEOtJCJU
         dqIIYRY1M1LPLrByw0nz0/WJmEAEMMTHuU3scdguAfue9jBMtfmdRg+szVvVqmjfcc/T
         dtYopwsHvM5tIAyofaF/KHVMrxQEyw8Vw3BB3mONHh1jgQSMvvFUzz3zh8ZAwQk88kVq
         BlIgeLZ5FoZJGig/TL19ACCrjD9laRdwz9auEmT5qN2ItBU+IlMD/NOdsLSTkEu/AAJN
         VIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/qCN7j8tb2VUbSrI7tBTv/xuxn0AqjD1uWSjfTSjT4=;
        b=DgvpB2sjNFJpP+3qXKtS/8jDyZSxTtsSebXnp1ZwP/3A3iww/aTVAWU4DltCCqMa9m
         22od24eNqJbhXpDX84S9wKIQ9j98CnXqZ38kd+kFV0LLQoXZZXeSvov2/jNxDua8xOfj
         szqzizPjsI+wFbTyx1neZ6ETZUgHfKBprMAmLultbBKPY2eEv3bExymtEUQHjevB9Ghs
         CEo8Wyw6rHJX02cdlw+Dd7d5Mqq6zS+9mUbTobfqhHQoRng1lsWslmSiP9JeuQFBwMT1
         3sc0yuZqVppXB70faOKCHhJkpsfnw3+aGM0jFUXAFmpwBtA8RCfs0AyMzBoNiuv2TApJ
         9TIg==
X-Gm-Message-State: AOAM531nrvAjBlctb3iVC6zVasxrpFD7zyygq6iKqotJ/eMR7PgISSbD
        ysz4w6gWebqDz3o93Ymrxq20fME4p4fb9hoP6QM=
X-Google-Smtp-Source: ABdhPJxMlnl1Lp/VRHMrdqqkFtqSaK4C9u1G2u7BpHPiLA9TpJhoMPjyU5seldtykzBb1BcV6pduKOwjgdRUKlBblPA=
X-Received: by 2002:a50:fb98:: with SMTP id e24mr3048905edq.130.1598712524689;
 Sat, 29 Aug 2020 07:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200829064726.26268-1-krzk@kernel.org> <20200829064726.26268-6-krzk@kernel.org>
In-Reply-To: <20200829064726.26268-6-krzk@kernel.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 29 Aug 2020 16:48:33 +0200
Message-ID: <CAFBinCCDvnT2HUuAF3J4FCWXKGpo-Wp-VxBuVFZSAovjeV04=g@mail.gmail.com>
Subject: Re: [PATCH v3 06/18] iio: adc: meson_saradc: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 29, 2020 at 8:49 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
