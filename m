Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AC11D4CFC
	for <lists+linux-iio@lfdr.de>; Fri, 15 May 2020 13:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgEOLsp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 May 2020 07:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgEOLso (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 May 2020 07:48:44 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F62C061A0C
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2020 04:48:44 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id e125so790785lfd.1
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2020 04:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zmHQ5oi+w1dpbsygDsoRqF7sOTAFHFbBfzdldzAPp9o=;
        b=N4PTtziTxHqM1fDkdSXxCv8Jg8FAni3IghpbZsnhKCoXYREBuI/Djyf0QrCyZON2o3
         uW91HJZeyAEd7QFZvCfGBj6IW72RQH4ooap6ejFY8+n9ddzl+DfpVB1fW64c2Y7UtIoS
         NbbnTyQ80k6T3D4MKAX59EysQOijXofxIm8nIbEZds5DRzahgX7amx/0KCt+RtHmCn5L
         ERXm3vPNmV3j/VWceLYoBFbvkr+ueFUofBitvDj88tLWX6oa6wY6NEzcCs1YWpPDIxf9
         PAG7IjNvBlsuvvnbZXQI6j8FAcN/Q/rkLLQIg+GxAHMsj5J3UhaM8aSZKn8aSS+YMf/6
         J7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zmHQ5oi+w1dpbsygDsoRqF7sOTAFHFbBfzdldzAPp9o=;
        b=tIa8uBxb9JwVLBm9D8Sd8Nk417lEv/BcwT8sQ7TpiWGbq8dunN794BKGSqTQAIx5qa
         RFxoONNWKYXdjfLCkJpjjjtFUOQrVDYrTcqIOgomWExC96LHWAxQiajDaLtpu7wPOOrP
         ZZApmpD3C70D1JRdTsVOedsgjb5E3JknIOzgW+XhlAe0hARU8TZW6/rd8ytpLJTxfe0F
         9xILTR5Um3XjzoLQ8ImgqUguatP1t6sQ3HR3lsV50y0Ppi7i9SIWmMKwQ+Fc+hpaXkD0
         uqN0I0VsVkh++m0wQh14IIVDfoB6HznBj/1amU3rDUvW4YUAJsD+I7fbL/Ikr2o3qjBt
         2iqQ==
X-Gm-Message-State: AOAM533MZMY/8UnZ7oiwbyjFGKf1p0aZpYNNLY4fKKlW6XsyxnypZw19
        VZ5ON7qX2c3tJ7kXDATpiZ/LH0jkukU6YIaq2kIF9g==
X-Google-Smtp-Source: ABdhPJwtH+Xe/KX7TAFGDyQmYdkwB+GwNwnhINwGOKf6w5JzQCbvrgv8JDJazPsCnZbWVl7rRbd6+vTir3BwFcJbK04=
X-Received: by 2002:ac2:4823:: with SMTP id 3mr2156225lft.194.1589543322352;
 Fri, 15 May 2020 04:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200514204901.3199-1-xc-racer2@live.ca> <BN6PR04MB0660C7BA4CE07978AEC884E1A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
In-Reply-To: <BN6PR04MB0660C7BA4CE07978AEC884E1A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 May 2020 13:48:31 +0200
Message-ID: <CACRpkdbucZ68KODd3shecm0uEkFgTzh4XiN08JdCM_chYApoXA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] iio: accel: Add bma150/smb380 support to bma180
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, May 14, 2020 at 10:49 PM Jonathan Bakker <xc-racer2@live.ca> wrote:

> The bma150/smb380 are very similar to the bma023 but have a temperature
> channel as well.
>
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>

The temperature channel can be added later, let's go ahead with this!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
