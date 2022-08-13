Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBF5591C78
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 21:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbiHMT7Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Aug 2022 15:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiHMT7X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Aug 2022 15:59:23 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6539113CD0
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 12:59:22 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x21so5051528edd.3
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 12:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mm+gRUhhagdl1joRty7/l/i4KexItQDPKCQADiOGyqE=;
        b=Ph6zLR/TD9JGluulwHu1PFRpeI8aFwXjQVTQkUoJ4ogmUpRaNyTqM8dUwiQmFAijL1
         A2H9xMaf2YdIE836dcgOgVCWevj/odg3iEYcu8iPZt46uovUuWlNgYkO+GxLrBt4Jth8
         zg23KfcbDj+nwWjQVaosBZ94E28pqwGP/DF4SG/5BUjnegwg0H9AIIp1grPtByRTmN0A
         UTJOlbLgNeiCQOEw0eY3BgDc/cYTwMYCKVvtAIoBb+CohHzAC74gUNopK/LafpP6qqn9
         uJMwmXcMzn3jdKFw+PlpvfCQrjtb85bRjA1HrZuxR8ODHLgwnH3vE1bW9ylKUGtx6KDE
         QwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mm+gRUhhagdl1joRty7/l/i4KexItQDPKCQADiOGyqE=;
        b=Euxu+Z92Cri9BTCUwhkhwzfr8FA+ZSBH9vY0Kk9mO+XfGBJl++2R0XNCcErYfOBQl0
         siYmrVhgLNR9k5VubT6/IhlyRHWDclNGd5buQE7BieeDGahG7eoZ60lKBIvyRt64iphw
         /zYyY+FzhYSbkxMYJB7pHSDDWIkAB85qC5iVvqo2EhuN8bq6oOQE8I4o1KP7fJrtxCTz
         9SaOHwHbmJpuIHe7zMNknn2yD5Xiewjw6KKACDQfKj3lzGG4OFglES+TWUVJxj0fdd4J
         GiKIdWRHyjpDurHaY0sxqsKOMTnjPWNd76Al9U8zO9yOqkmUBoGewzlfCsCb1uY359oI
         vSWw==
X-Gm-Message-State: ACgBeo2E4ZksNBoni34wiY0O7Nsh10IIl2xjgcJ8DZzoN2IOvQ8AdWfn
        j79PtPfF3R5XUlX5WxXXgPY4QIh2YRqkSRfoqAT1Qg==
X-Google-Smtp-Source: AA6agR6nZTWl277HOpRmghrdAyTf1q/UU5GhnViDV1K+3enn3bX04BpS/rWLVTvc79UlCsAD4prkD/Q9pC4TIw4D+Kc=
X-Received: by 2002:a05:6402:1f8c:b0:43e:8fab:76c with SMTP id
 c12-20020a0564021f8c00b0043e8fab076cmr8465162edc.126.1660420761020; Sat, 13
 Aug 2022 12:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660337264.git.jahau@rocketmail.com> <a12f892633bbee13a8856c231dc793ebbc5d3a03.1660337264.git.jahau@rocketmail.com>
In-Reply-To: <a12f892633bbee13a8856c231dc793ebbc5d3a03.1660337264.git.jahau@rocketmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 13 Aug 2022 21:59:10 +0200
Message-ID: <CACRpkdZ+Fv0A_ej7MhXbM=r54cx9dMTh5_ibpu4R-Ck1s4Cw1A@mail.gmail.com>
Subject: Re: [PATCH v6 11/14] iio: magnetometer: yas530: Add IIO scaling to "chip_info"
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 13, 2022 at 12:05 AM Jakob Hauser <jahau@rocketmail.com> wrote:

> Add IIO scaling to the "chip_info" structure to ease the handling to
> different YAS variants.
>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
