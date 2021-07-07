Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7383BE770
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jul 2021 13:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhGGL4N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Jul 2021 07:56:13 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:47001 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhGGL4L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Jul 2021 07:56:11 -0400
Received: by mail-lj1-f175.google.com with SMTP id q4so2302397ljp.13
        for <linux-iio@vger.kernel.org>; Wed, 07 Jul 2021 04:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:to:cc:in-reply-to
         :references;
        bh=N6+k6WVQG9Sqp0tNMVaC38Xfr4SjjxzCrwgglT8bn+g=;
        b=KiOd9SUIb7rSLtEo+PpWY9YALHTkQuLN0cX+J3FVBIMj533tbCuC+g0eCJcgAc5aMo
         BF1kX7Z8qeygsXKq/+nSFemmaJV2DR59g7yP5tOhjdpRG6g1+ow/zZwSCCYGt1sJ7riu
         Ar/xkw+1qFmN1rPEQJD9/lIkUfZmYSRet4+KhzBo9ihwWFqEfdjlKWr9hkiFTpMm5SKw
         twV4RFM+XatWz8jvlxI5dFpnImFu5P0XjIzzjvkJWlp4g5l37nJQJ7xPVi5dze13rHwY
         /IMKdSB0gyE/LsquY68qqsS7b4VTh0NJeeaDpssxDzEpIVfOYALWsu4pG0nw9IRxcOdE
         QD4w==
X-Gm-Message-State: AOAM531rOaJdYOg6/GuRxoL/SZ2dY+5D9vZYLg3fMeoxyo/QR/NPsGJC
        EtC5UJ3ecdXYhOadTSioEQQ=
X-Google-Smtp-Source: ABdhPJwLMCFXDh7FsIw1aAKFj32CSpJaKFXUaXONX1fjeodt7Q4sOHJjm/peN++HhIwvyohaZUvPpg==
X-Received: by 2002:a05:651c:1032:: with SMTP id w18mr19369073ljm.34.1625658809803;
        Wed, 07 Jul 2021 04:53:29 -0700 (PDT)
Received: from localhost (88-112-11-80.elisa-laajakaista.fi. [88.112.11.80])
        by smtp.gmail.com with ESMTPSA id b14sm1687468lfb.149.2021.07.07.04.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 04:53:29 -0700 (PDT)
Message-ID: <60e595b9.1c69fb81.5284.9247@mx.google.com>
Date:   Wed, 07 Jul 2021 14:53:28 +0300
From:   Hannu Hartikainen <hannu@hrtk.in>
Subject: RE: [RESEND PATCH] iio: adis: set GPIO reset pin direction
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        Antti =?iso-8859-1?q?Ker=E4nen?= <detegr@rbx.email>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
In-Reply-To: <PH0PR03MB63661EDEE130924514602A84991A9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210706092922.v555jjvxbyv52ifw@haukka.localdomain>
        <PH0PR03MB63661EDEE130924514602A84991A9@PH0PR03MB6366.namprd03.prod.outlook.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

Thanks for reviewing the patch. I'll also chime in. We were working on
an ADIS device together with Antti so I've read some of the relevant
code, documentation and datasheets.

On Wed, 7 Jul 2021 08:36:47 +0000, "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> Thanks for the patch. Forcing the device reset was intentional
> (thus the GPIO_ASIS). But what Lars is suggesting is a good idea
> and a neat improvement here.

I don't understand what you mean. The GPIO consumer documentation[0]
states that if GPIO_ASIS is used, the pin direction must be set in
driver code later. AFAICT that doesn't happen.

If a pin was defined as input by default by the manufacturer, I don't
think there's a way to make an ADIS device work with RST on it without
patching the driver. Device trees couldn't be used to do that IIRC. I.e.
this patch is needed so the device reset works.

On Wed, 7 Jul 2021 10:18:57 +0200, Lars-Peter Clausen <lars@metafoo.de> wrote:
> How about requesting it as GPIOD_OUT_HIGH and removing the 
> gpiod_set_value_cansleep(gpio, 1) to avoid unnecessary toggling of the pin.

GPIOD_OUT_LOW and GPIOD_OUT_HIGH have different semantics.[1] Is setting
the pin to use wrong semantics to save one line of code and possibly
toggle the pin one time less worth it? (The ADIS devices whose
datasheets I've read have the RST pin as active low, ie. GPIOD_OUT_LOW
is semantically correct.)

If we really want that, I think the better choice is to use GPIO_ASIS,
gpiod_direction_output and gpiod_set_raw_value_cansleep and skip
semantically describing the pin altogether.

Hannu

[0]: https://www.kernel.org/doc/html/latest/driver-api/gpio/consumer.html
> GPIOD_ASIS or 0 to not initialize the GPIO at all. The direction must
> be set later with one of the dedicated functions.
[1]: https://www.kernel.org/doc/html/latest/driver-api/gpio/consumer.html#the-active-low-and-open-drain-semantics
