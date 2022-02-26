Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4D64C57DF
	for <lists+linux-iio@lfdr.de>; Sat, 26 Feb 2022 20:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiBZTu3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Feb 2022 14:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiBZTu2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Feb 2022 14:50:28 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422961DAC70
        for <linux-iio@vger.kernel.org>; Sat, 26 Feb 2022 11:49:54 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id r13so17290456ejd.5
        for <linux-iio@vger.kernel.org>; Sat, 26 Feb 2022 11:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQm/8EZuv4iUVCQpgzsPLxIp+cQmk1vzpMnG8eElwKU=;
        b=aK7vV+zQmw92jwTFKg3Hv1G1NQMlqA8DmitQ74nuYFKaheC3dqOedikiAJ+GevbUhs
         wvfVGXggoYAh6GYYsdDE2sNenuNSKtFjjY2THSRxr8Ur1lHq3u7fpYVKo6NbRzfyT+i7
         sL4RYEzQbM5OGgQb6okvl4yuQ1F5mXMUW2mk50FJycxZpPiQxbk/Gq2MLFmcFhRC0VCG
         odkahNJ6CbUytX6nwoeIgw99i5trw9IWIebUw7shFmtRflyPi5JpTnJ7RV3ZEbgsNvTZ
         B60xh60ChCKmbUYFICWo6+lLI0KPEte5Yfk/w58WXqHDfSWVSIMtttdmR9AE8DYvjdEA
         I1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQm/8EZuv4iUVCQpgzsPLxIp+cQmk1vzpMnG8eElwKU=;
        b=7ixn4h4SsUKSL571Wwu7YrT23Ktg1nEFRz9ARWoHGRxLKmdurk9ZQ2+UwtNYh81gh4
         Is9oqBQXNKBlLGDJ85eHPJo26GgrzQFact18rQb/62QHMbp1+JHMBMcP6hsWFVjkkIXO
         AwufFV00Qsj1KmnVDCgax6iVjfgCkEuv3l6sMiTXjU+XhjEJVHkjYAKhEgzB2Hu6lvGr
         VFFbOqQA6YciazRkUt30ebbsdU8nhP7/PkhswC1F25Ijk8/YshqiaZEQW5PGs59wxbXd
         m2DVMeQ20LArMInx3ezdfRPFs2cgknqVolkrJ3nUwSJ/Ddeyj/+8U7cHiz3py4pTdrU4
         6n7w==
X-Gm-Message-State: AOAM530CqYisVMgZgcnVlENBM/DdgGjZ5P5kuGpTgGYp9vVSSk42Kpvj
        lS2zfAjY5HnnKhuEPfULyKJ2KssvijY5bAC57A5RBbo6+20=
X-Google-Smtp-Source: ABdhPJypRQeHXDbuGguWBy1Sz2iNxxu850tG52VrjJNCRPekzNZ/EbAMd1R4aGg3tvIBjga53FrFAI4WI9IY19MFfD4=
X-Received: by 2002:a17:906:5950:b0:6b3:65b7:82d3 with SMTP id
 g16-20020a170906595000b006b365b782d3mr10152248ejr.636.1645904992690; Sat, 26
 Feb 2022 11:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20220224211034.625130-1-nathan@kernel.org>
In-Reply-To: <20220224211034.625130-1-nathan@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 26 Feb 2022 21:49:16 +0200
Message-ID: <CAHp75VdW8g_bvPvvfWOW5SUkEm9PYu8UvO9Mf_wshLLB3u=zPw@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: adxl367: Fix handled initialization in adxl367_irq_handler()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>, patches@lists.linux.dev,
        llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
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

On Thu, Feb 24, 2022 at 11:25 PM Nathan Chancellor <nathan@kernel.org> wrote:

...

>   drivers/iio/accel/adxl367.c:879:14: note: initialize the variable 'handled' to silence this warning
>           bool handled;
>                       ^

>                        = 0

Bad advice (at minimum it should be false, but in general it might
hide a real issue)

>   1 error generated.

-- 
With Best Regards,
Andy Shevchenko
