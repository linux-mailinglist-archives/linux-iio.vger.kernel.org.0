Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA453AB0F4
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jun 2021 12:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhFQKK7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Jun 2021 06:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhFQKK6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Jun 2021 06:10:58 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631E8C061574
        for <linux-iio@vger.kernel.org>; Thu, 17 Jun 2021 03:08:50 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id z22so8133408ljh.8
        for <linux-iio@vger.kernel.org>; Thu, 17 Jun 2021 03:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/K9JdrkX00XkCp6n0wSR+1iRbh6dB6xvMbGj1K3e5J4=;
        b=hHgmaQ+RGEQLmYJsTlUak3WrXg/uvXM80tSKuknFKDkznExy5R38VgBOB3Q+kTxoft
         82PYnv0TLNCJ8wcjE6rtnYFvE/2Bjuoxduregf8AfaivMQZlGk/9kg3i34B9Jd4/uFGf
         agmmTwT9uoI74gj3ZKlMzDDqdBlKszj58nvDMNj4n1wDL1SeMe4K4J9GZcgP0gkiOiSw
         F1xty4zEYPptMnLH4qa+fjr1nGvfe1/SIVZkdZFnc3j/1GuOtBsfnqH7m8nWqwqA6TTP
         JcR2iBNloU0vzQ6zuU6Vm1+rZkrn52iVVnWxBHJXIZyvUTLILW7XLMpFG3XLOZvSGGPt
         d86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/K9JdrkX00XkCp6n0wSR+1iRbh6dB6xvMbGj1K3e5J4=;
        b=bA/YDlvujFpP0aX7VmFIBQycUHK4lzIN/4s4lFl0HhwDjWzDcg2idLKglhoQWdVR+4
         lmUNMO4qpOfiKIc+WJaHOP7B9lm1b6Vm5xMvcjTrjfLP70ayixeWTqbgnSm0r4RKORW1
         yXcvaI74Qak+1aVnsPiogWTAwFaj5YGLqbWgDOlA3YTIUiKc+odO0uvmii+AKCBTaBfS
         eGdkddIQll+oFPugFLK0BXQ1VknxSp0tGrbYm6hvUWvW2jV0VomT/4gqAxsbihzbcSyR
         7gmX9EIGhgv+HQQOJndaOTFbIHM3OoAVXZ3NLt1+3W+cbSXem93IBJNzkuqO6pvqq36R
         9/kA==
X-Gm-Message-State: AOAM530qBMrISwrGGgCOhpUgj3MkfIQIO5egv+85KPYOeEatXI0qTrV3
        MjFrtBu8Ihy74Q/yvzYtPpuwt8y3672/dFPg9Or51g==
X-Google-Smtp-Source: ABdhPJxq4w+U2SyDaPgoGa0SI3DohBcoERNxstc3FrVBWCjFtP2ur7vzb5VAhoYaUN1JNh644HGYXnLLQHE+xV1NZsI=
X-Received: by 2002:a05:651c:1411:: with SMTP id u17mr3890137lje.438.1623924528722;
 Thu, 17 Jun 2021 03:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210614163150.7774-1-stephan@gerhold.net> <20210614163150.7774-2-stephan@gerhold.net>
 <CACRpkdYPz4JOWgzynVzAmJXH1MWAXjvH16k_kwi0KqGE9_NnSQ@mail.gmail.com> <20210616133328.56106589@jic23-huawei>
In-Reply-To: <20210616133328.56106589@jic23-huawei>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Jun 2021 12:08:37 +0200
Message-ID: <CACRpkdbyd7F58Q-mXjARf9xRM3ThaM38QdUKOhfowMk9budxBw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: accel: bma255: Fix interrupt type
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 16, 2021 at 2:31 PM Jonathan Cameron <jic23@kernel.org> wrote:

> Be a little bit careful.  There is always the possibility
> someone has a board doing cheap level conversion via an inverter
> (I have one of those, though not with this device).
> We could in theory represent that explicitly, but I think this
> is still mostly done by just flipping the sense in DT and pretending
> the inverter doesn't exist.

This is what we do, the DT is not a 100% map of the actual
system, and we have no inverter driver, so that flag is used to
indicate "some electronics" that flip the polarity.

We should document that better though.

> So whilst it might superficially make sense to change it for
> all cases, make sure we get someone familiar with the board to
> sanity check them.

Was just thinking of those that I can test :)

Yours,
Linus Walleij
