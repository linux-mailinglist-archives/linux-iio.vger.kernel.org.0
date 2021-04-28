Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF1936D668
	for <lists+linux-iio@lfdr.de>; Wed, 28 Apr 2021 13:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhD1L0B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Apr 2021 07:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhD1L0B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Apr 2021 07:26:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05496C061574;
        Wed, 28 Apr 2021 04:25:14 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id f6-20020a17090a6546b029015088cf4a1eso8959146pjs.2;
        Wed, 28 Apr 2021 04:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GiTCuYKm/6h5ampIjNwVQGvI4RkwG5NPjFTrJbik8QA=;
        b=RT5QNcUJFwUvVAOAi1hpINrlU1EZGwJo7sBJVrkoqS75D6SfzQ0TfEgw5IIbedjyPR
         t9Sk6PYgj5zijW6VZRdhBCYL4r4cRsGcdnKeJx7dGAgfTfKH4k1tjlJ3hNswr/WL9+7Y
         6/tzStxulSUuvvJk9zlQAAcGUXy9g/ntiCe3p2tHNLQVfLsMjXJ7CEaNoKgGKy/2IV1l
         fHnKIDJhhXn6V4yJ1eoPtGDjjqxlh62yFjEj/w1FVayc4nYaD9Kt+LMusuF1PkedZFdT
         JmgS5JesDuxxgbzyZxagsJ/4wRRCRGyLaFVliG5NZncmTPyCvfDe5eFNr/4pdkOzz35E
         /BKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GiTCuYKm/6h5ampIjNwVQGvI4RkwG5NPjFTrJbik8QA=;
        b=JegLLVsuwFx+xIxUnm/7b290Xjg/8JT/BGV2FzbDFLamR4EGgtIoVsDe95vgLEhCSv
         pa9xfwaL7NIW4veNe+vBSnMqeCTQ6qqLoiDaTdUmpJop3SuVYoNm/kEXkyQFrSMqyuDj
         /7WxmZwpWxHV22PuecDIkNHjTNRs4ONiNKtdwrDTz/SXZwJuTSBLVMgmbZcE37kIJPTV
         FxbjMGBNTzqrypp1q5uBxL+E1lzJyHcN63KcaC2jOylxygX17/VGPi34UuAVG18CY7Z4
         b8Q7mY8zJxPmTEjps7GKvTF196mrrhI2eHI5+TU1N2+nTxPUah12ybbYnqQvLbmb9125
         1P8Q==
X-Gm-Message-State: AOAM5334IQVV0ST2WyyZaxOMU/bdYD2mKH56NQOtHNUZtOX06W69f8E5
        /au+0nJxhjwBLixkOKVVnkNGcY4iFcGQQldnXw96eDGV6Zg=
X-Google-Smtp-Source: ABdhPJyX0V3Rupc5IlvwmYIb9exUlQnu56fu4atoXGTN4getXUeLrRPcN1xgwoTQErLbCE57WdfMi+MhnyKXVscXFJ0=
X-Received: by 2002:a17:90a:bd13:: with SMTP id y19mr3648019pjr.181.1619609114433;
 Wed, 28 Apr 2021 04:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210428082203.3587022-1-sean@geanix.com> <20210428082203.3587022-4-sean@geanix.com>
In-Reply-To: <20210428082203.3587022-4-sean@geanix.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 28 Apr 2021 14:24:58 +0300
Message-ID: <CAHp75Ve5Dyz-Cc7p8G4JzZ1Jhbey330WEHu2u7DLrRsoRbvgjg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] iio: accel: fxls8962af: fix errata bug E3 - I2C
 burst reads
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?B?TnVubyBTw6E=?= <Nuno.Sa@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 28, 2021 at 11:22 AM Sean Nyekjaer <sean@geanix.com> wrote:
>
> When flushing the hw fifo there is a bug in the I2C that prevents burst
> reads of more than one sample pair.
>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> This series depends on "iio: accel: add support for
> FXLS8962AF/FXLS8964AF accelerometers"

This should be part of that series.

Besides, see below.

...

> +       bool i2c_device;


> +       data->i2c_device = i2c_device;

This is redundant. Use i2c_verify_client() instead.


-- 
With Best Regards,
Andy Shevchenko
