Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B862D609AA9
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 08:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiJXGi2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 02:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiJXGiZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 02:38:25 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D7458091
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 23:38:17 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id j21so5560305qkk.9
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 23:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lxnav.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fsOiC+x4jbQg2AI82o1c6FVgGRvae5LgQbo//KCgMPA=;
        b=uGVMATcxl8aJCmPrvkTHCO+PicBfylpepuzLv/A+igtmUM1uWPkck9WS0qESv7wmRS
         aEAsLNQWybz0J83BiTnJZIz8pIZO+ygaWPLdZBMzgetXXsg+Idp6ZLzFH2z38My+eGz4
         wp1rT6DvRqVC5G3K+ZRtVrJ6DeBemIiiOv0oQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsOiC+x4jbQg2AI82o1c6FVgGRvae5LgQbo//KCgMPA=;
        b=fqlBfC8xUPsavBrskb4D98e5iyMgexwHUu5Zu5qalwf2OJa28bOyto9YoF8rTbZLvr
         53ylzUs0m3xjGyB1mIZLeaagqPaxuPi2zoyYFs4jzDDUViDRaduLYrUB3AZctsVcn5Sf
         xUJd5/imNnrfm2EHFx/yiSaXpNvMzNGYdywqvR/EHZpCwqIJSShHitOfssFRBdYK+xya
         PREpXnxtMZy4j/WfGG6PBWjNrPKphfzUFH3kllqcU932W/v+xZ+AUJFGvNylOg5nw4/n
         c6XIa5nyXMF87ZOJDGByOyv2rmE9VUd8gtW3kDDraHyQLKP1g4ZFkId0hbu+4zjZtyMz
         5zKA==
X-Gm-Message-State: ACrzQf1dJshCxXtdgBtiAYzLeAwug/2NWtiH33BLs/74I3I5lGsZrcKE
        yDWzUuKkRHsoWuT0eScMEpWSyY7agFTrt6ZX7AV9XsUeFMYUSA==
X-Google-Smtp-Source: AMsMyM5tSVrVszLR+lwo8P+ienZPZ7fnw3WFxIUDrOYZvDhfuAt4jx21oRq7AoW9iVOPfVEw/pXeVAl4MffKsZoQFMo=
X-Received: by 2002:a37:de03:0:b0:6ee:88a2:eb9a with SMTP id
 h3-20020a37de03000000b006ee88a2eb9amr21831942qkj.241.1666593496783; Sun, 23
 Oct 2022 23:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221021135827.1444793-1-mitja@lxnav.com> <20221021135827.1444793-2-mitja@lxnav.com>
 <20221023120634.0dda4b5f@jic23-huawei>
In-Reply-To: <20221023120634.0dda4b5f@jic23-huawei>
From:   =?UTF-8?Q?Mitja_=C5=A0pes?= <mitja@lxnav.com>
Date:   Mon, 24 Oct 2022 08:37:49 +0200
Message-ID: <CACbQKWeA7QDn3tDdP4oNQ9cHyubNCDvCphOLndDDf-gBXpkcDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iio: pressure: ms5611: fixed value compensation bug
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 23, 2022 at 1:06 PM Jonathan Cameron <jic23@kernel.org> wrote:
> Fixes tag?

I believe this should be:
Fixes: 9690d81a02dc ("iio: pressure: ms5611: add support for MS5607
temperature and pressure sensor")

Kind regards,
Mitja
