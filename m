Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD6D58C57E
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 11:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242015AbiHHJWm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 05:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241654AbiHHJWk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 05:22:40 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7542193
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 02:22:39 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id k19so1674500qkj.7
        for <linux-iio@vger.kernel.org>; Mon, 08 Aug 2022 02:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8fh9iM2tXG5OdN+Jzjdi+0jHZned2a1VqBLl48v1K7w=;
        b=YtoYg+YnoD3HzGTNB7x1jyXv5ddOgPIIMTuRNr8adzETlSW0+4E9q8b6357lR6il7m
         rX9t2aREr4tc1MuAez/MPx/wh1w4l9mHS9hIH/IitiAPPkQF1T6f/urAl+556FGzrw6V
         tcExRyYN12kX74gNWEVtJklwnxz0DEyfNl1MO+sZhW4nk7VKSJXq5cEjxt7pY7fzPPAk
         VGtI2zRQm0V3Jt1Jzn4zmlRoqhR72dzf4GsptMIP7E04zsOyN3/wH9giLX6j7RxL8BBc
         OlHYs39R7dxn5WXnCXm7WbjaheE8MbyTnCSlV60fjvt5TZkCLOL8zzSIlUsv1ppORap5
         E47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8fh9iM2tXG5OdN+Jzjdi+0jHZned2a1VqBLl48v1K7w=;
        b=sivt0jNfVsCdZ2eDfO4b5O4Q0LMPCezVuIFqr5zkJoAEgTHJmRKAJHQskOUW4dTLs/
         wq/e6vW02jKNqKj8MIj0366fdGGusLqj/Hr4I69TCeSFjnhDSClAj3jOUigyUoZrPRui
         y8wNHo2McS7BtCevAyMLzCcBEbnIP0zzESMNGW4tGlyxo3iFwCMYUahHBAA9AQT6csOM
         FHX01yKEvmDR6HMUvm9jy/JCX5GSqQs2E3UOocChKgntPucNeLgpZ2OgcZuKkWUqQQdr
         jrb6PB3oVDgeMDqjJkQYNRrILsTdaSkuSNjpt64YwkHAD78xj9WlwdyzvjMWmYM2zWic
         Zckw==
X-Gm-Message-State: ACgBeo32tEzX1X08RKJiRdm5Cku1psHFUKFlaNAxwGvq0AyClY22609w
        vm4GAKql77aMIzOL6rEu5RFCfdejCX2gIBYh8Zw=
X-Google-Smtp-Source: AA6agR4zijU/qs74wPpHt5ylJUgFgo/6lM+9Isyrwf4B39Sl2vnm9t8SS3FVO51sfsglbli+3+5FbDpur01RSXCUDuA=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr13302146qko.383.1659950558811; Mon, 08
 Aug 2022 02:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220807184534.1037363-1-jic23@kernel.org>
In-Reply-To: <20220807184534.1037363-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 11:22:00 +0200
Message-ID: <CAHp75VePiBGRmKJiPbHtyX_waO8Qb6hkM0+pNh3kx_Let5MHPw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Trivial cleanup and refactor dev_pm_ops handling.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
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

On Sun, Aug 7, 2022 at 8:38 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This driver was taking an unusual approach to handling the optionality of
> structures / callbacks depending on CONFIG_PM.  Bring it inline with
> other similar drivers.
>
> Part of continuing to move IIO over to the new PM macros that don't require
> such complex handling.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Jonathan Cameron (2):
>   iio: magn: hmc5843: Drop excessive indentation of assignments of
>     hmc5843_driver
>   iio: magn: hmc5843: Move struct dev_pm_ops out of header
>
>  drivers/iio/magnetometer/hmc5843.h      | 13 +------------
>  drivers/iio/magnetometer/hmc5843_core.c |  8 ++++----
>  drivers/iio/magnetometer/hmc5843_i2c.c  |  2 +-
>  drivers/iio/magnetometer/hmc5843_spi.c  | 14 +++++++-------
>  4 files changed, 13 insertions(+), 24 deletions(-)
>
> --
> 2.37.1
>


-- 
With Best Regards,
Andy Shevchenko
