Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C6855C596
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 14:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345414AbiF1MQg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jun 2022 08:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345383AbiF1MQg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2022 08:16:36 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A885825C76
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2022 05:16:35 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-317a66d62dfso114781767b3.7
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2022 05:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GkKspg2u6R6jexEqgukN9yCccSFbM4xhOI8mmjYXifo=;
        b=aweVwLn8T0wOUku13O59RH+3lQC/5R6KhbDlqXOKHviP38d0eDuPW26OXFx0ovWdXU
         OBR0DFHke4Wpfkivb+6/waTju1/e/u7OyWEdbXNHvn0X7rInXsbysVW8t0ehiFcrEkbM
         w+v9AOVOmaAcCgiITPQrmuRTyOA6lNB67nvMV2qbmV0bpKOtstY06OHfVpYEiRJY1vBr
         npKOU8mfylPdUPDrRXO155D3KNOtB9chtXajcTUqn4MEu4dnELpo8dhQHqGKUEtJ0Qvr
         hdw7RlgUdOLVfdp+u9wmyi2+w6WXvMe9brNL5e6wNd7Gnhphe9kHtBuFQgFrErWODLNP
         y3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GkKspg2u6R6jexEqgukN9yCccSFbM4xhOI8mmjYXifo=;
        b=lKFfDJykdl3UE0+sypiSdaiei+9Raw+rwvzOBBogr4NQLKxhjT7HeffV3T3UretwJY
         AvsdtDogBwcT20/97+bRSQjzDYF9Pah+nIAmFq5UxBZGBiahK6l9H3+xAIukzthqZ1hM
         WQ/1fLBrYOde8f8SqYdSBwHP73MU9DeMprNFkFw/cibMNuhe2FoTn15cJld0W5eerwPr
         uG+mfJvEAYifPGAASEBNVVoEYd5UK/uE+bIcCYq8AtH6rc1TFUr2QrEXFmJjIB7MtdmS
         Xt4fKLATH7Hzj4MeoOzEdgqCL5tL9/OZk2r8lH5bY9jAG/ujDxJdFBENVkb4wRYuqAY8
         +qNw==
X-Gm-Message-State: AJIora8Jk4h36Ksy+4XjG1BV4O4jbFn+O3+ZR6LjbVCNciRx6B2L/WHZ
        vHDtZsTDEJMG6bE68ZxSQpS1jl5xBLmlvyRV0ms=
X-Google-Smtp-Source: AGRyM1sGHwdXwcNLBLdpdbbEGUsa7+Fw0rSe0W35IHge4LMDk0swVgMFI8bXYE9FJob5OXAhTmJUWNodPCW1zie0i8s=
X-Received: by 2002:a81:468b:0:b0:318:4cac:6576 with SMTP id
 t133-20020a81468b000000b003184cac6576mr20359835ywa.277.1656418594738; Tue, 28
 Jun 2022 05:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220626122938.582107-1-jic23@kernel.org> <20220626122938.582107-9-jic23@kernel.org>
In-Reply-To: <20220626122938.582107-9-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jun 2022 14:15:57 +0200
Message-ID: <CAHp75VfopwTrTQ-QeDs2CbmGy+xoUGeQ2g=ysr5AP3f78VxFLw@mail.gmail.com>
Subject: Re: [PATCH v3 08/17] staging: iio: cdc: ad7746: Break up use of
 chan->address and use FIELD_PREP etc
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

On Sun, Jun 26, 2022 at 2:20 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Instead of encoding several different fields into chan->address use
> an indirection to a separate per channel structure where the various
> fields can be expressed in a more readable form.  This also allows
> the register values to be constructed at runtime using FIELD_PREP()

FIELD_PREP().

(Note period)

> Drop the now redundant _SHIFT macros.

...

>  /* CAPDAC Register Bit Designations (AD7746_REG_CAPDACx) */
>  #define AD7746_CAPDAC_DACEN            BIT(7)
> -#define AD7746_CAPDAC_DACP(x)          ((x) & 0x7F)
> +#define AD7746_CAPDAC_DACP_MASK                0x7F

GENMASK() ?

-- 
With Best Regards,
Andy Shevchenko
