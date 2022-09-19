Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A96C5BCF82
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 16:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiISOsx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 10:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiISOsu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 10:48:50 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB15415727
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 07:48:49 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id a20so18073746qtw.10
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 07:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hMDJjODUqEj3FXHso3eD1FVRza4WMRGlNSluLhUFHyc=;
        b=jwue8W6dlLHRjYclwUIiRrLph1iFElVA/3szRD3mDubBRKSpZkFz0KL/CZN/vZpr23
         Qv+ABh+/MMGCJyJHLWabmzca9n4YEjLsKpVB78H9N6T6uBpLrWhB0WS7p2aFpwlkruBA
         tZ9iVMC5aVShVn40Zkb8PEob8WSGS4JiVV+0oBNIrSoHdZKfPndix26yKnK51h8ad2Cv
         lA3fuBKB4NGHNxfX3zXASy7J2cwGZW9WnkTLSxm6T3IkUteP0foxHBcc4XPGKtmoNoE0
         mNRmteWdP6/Uumav2IPa8AuPz5c9HKvhDSpba7YJphO9WqUZAeN4DvYkKUT6m4udY7lE
         GEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hMDJjODUqEj3FXHso3eD1FVRza4WMRGlNSluLhUFHyc=;
        b=rvuWfWr0mdBdaeCxqgahxtIbBfw1ePRXlxZKsnudnX3FUizyvdRDHgbCsZgZtIrSsI
         ysvNeOKTP1FRu/lXQ1UDBmq9oFkbGi7CLfE98b4EFKQZSmvsMuH2zGLFXxGtv86Rk6xw
         XfIfx3tQ8fyRJYeK7+hyjaXHZFKZi7KNEid1oijM+sxJ/F4/oe7Yp74g5F8TGmInZiaY
         d0hTOeui/ZorQtL0tufk+Cs3Sp+ysnIc+CejVf9YYqx8SztFJF9hFvZqCXl4ie82QZjN
         Q7ypDHxhGeECoDiuqRha+kptVKhjPNCHVH2bsfhVwm2HIMHPUbeKVqaGslcejA5uTuJX
         H4kA==
X-Gm-Message-State: ACrzQf0i0kIchKa2HwQpTBRQCYibZmjvRo4gXnl8KKkBibp8FAjr5Ugi
        6NZ6X6dWIDzNFON1T+9xeVDAgfrYeN8KllbQUB8=
X-Google-Smtp-Source: AMsMyM6RY/ZXxfx8n1C7j3KJTztwY/I+TWH6wLxUpBFgXZybd1HYpzOIfAQjUsjUwt8SkaQBKi8wztiRaxMDvpqLit4=
X-Received: by 2002:ac8:7c43:0:b0:35c:cd8f:3da5 with SMTP id
 o3-20020ac87c43000000b0035ccd8f3da5mr14094616qtv.61.1663598928783; Mon, 19
 Sep 2022 07:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220919150011.823383-1-weiyongjun@huaweicloud.com>
In-Reply-To: <20220919150011.823383-1-weiyongjun@huaweicloud.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 19 Sep 2022 17:48:12 +0300
Message-ID: <CAHp75VexgwZKxa3q9G-b+37q0mduFDtmD_jjryBKeFmncTp68w@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads131e08: Silent no spi_device_id warnings
To:     Wei Yongjun <weiyongjun@huaweicloud.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 19, 2022 at 5:43 PM Wei Yongjun <weiyongjun@huaweicloud.com> wrote:
>
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> Add spi_device_id entries to silent following SPI warnings:
>
> SPI driver ads131e08 has no spi_device_id for ti,ads131e04
> SPI driver ads131e08 has no spi_device_id for ti,ads131e06

...

> +static const struct spi_device_id ads131e08_ids[] = {
> +       { "ads131e04", (kernel_ulong_t)&ads131e08_info_tbl[ads131e04] },
> +       { "ads131e06", (kernel_ulong_t)&ads131e08_info_tbl[ads131e06] },
> +       { "ads131e08", (kernel_ulong_t)&ads131e08_info_tbl[ads131e08] },
> +       { },

Please, no comma for the terminator entry.

> +};

-- 
With Best Regards,
Andy Shevchenko
