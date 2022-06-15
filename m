Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6717854C512
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 11:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiFOJtc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 05:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346456AbiFOJtV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 05:49:21 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CEF488AC;
        Wed, 15 Jun 2022 02:49:18 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id m20so22056539ejj.10;
        Wed, 15 Jun 2022 02:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QCKpeqEfTS4E6wW79c/P3cTks5oS6TYw3XIdgKTe3lc=;
        b=F1v0m7RCn1fj32YglfwUSrLijv/R2ebOkGMHr5jgXudOnzsZY2abWTbYLvvZZIf7/1
         DkGeQB5J/tk431btMx8eBY6+NIEYqWr5M2ny9jYkDwI0byUt9ynDwDfiw/DVwOwxFJJs
         qujoZirZxih6FMDHM0uuKkqOy4QMbI52uyVlBnTFOXpN9Lwa7jqIvzWiyQhZ/AJI5jsT
         SZJH+a1E7vzx8NIo6V9JsHMF+GXjmkCxwuaVfIwpWYbh/9IsEzk4yxCxn9zm+EvNDjcX
         A2wLY/pBO1I+uDlfsAChgmmQ9zO5CCUlqLrGNWvTWbv+iLobn9e37EzlYuusBIPguxpz
         YXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QCKpeqEfTS4E6wW79c/P3cTks5oS6TYw3XIdgKTe3lc=;
        b=JsMVxl41C4iltfwc2mLGph0swPFxAmiJklJTIfmIWLO6cvRG96F3pwujtadAynt5uF
         9/U46UULu7gKfD8VP2qu2yWSN6yoQH8nzjR5sBYqoD3Gr+ieqnNeEZIIi387RCQoMDrR
         U+PQSP/Dz7c2O8FjuvZ7kxooFvfdi6ZWIpbn9qNIW3VtH3CkMAifqyhq6XVPEd4EzkPu
         Q/7x1QleBlysUz8UbVIV3NhpGSELN9Zrqa00VOkE8r9qf/SJOYkn8sXTuR/FDme/5mM7
         0Yc4K/kIKpKraOs2RyvQtFiV4szK0I9F2FALRoiOMS3j4Egv8Y6GteSE5vBQDxEQB16J
         bNBA==
X-Gm-Message-State: AOAM532u8JwasrTNlR9LNLSs/xkk//QCocg+Ue7ONuOvRkP/MLRvzNTd
        7BHmEDsl/wU49Cvni+RpnkCZX3Fhbk0L1U8syGM=
X-Google-Smtp-Source: ABdhPJyDsIEgyhvdL6efswx/TfmG3xjmCRL3UEyaz49DTSDtZYSctbilgS8flMEWsTGnf9Ch/+n7D1OROXmfvYi3v3I=
X-Received: by 2002:a17:906:c7c1:b0:711:d2e9:99d0 with SMTP id
 dc1-20020a170906c7c100b00711d2e999d0mr8046131ejb.639.1655286557167; Wed, 15
 Jun 2022 02:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220614194225.2226447-1-sravanhome@gmail.com> <20220614194225.2226447-4-sravanhome@gmail.com>
In-Reply-To: <20220614194225.2226447-4-sravanhome@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jun 2022 11:48:39 +0200
Message-ID: <CAHp75Vd+RNV=PC0S=uJCvtWbg1x01bcAp6cbMoOdF-So8Gb0-Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] iio: adc: mp2629: restrict input voltage mask for mp2629
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 14, 2022 at 9:42 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> add support for mp2733 which is updated version of mp2629

Add

> with a higher range of input voltage.

-- 
With Best Regards,
Andy Shevchenko
