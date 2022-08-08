Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459C058C578
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 11:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242361AbiHHJVP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 05:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242343AbiHHJVN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 05:21:13 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B950B2BDB
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 02:21:09 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id z7so631888qki.11
        for <linux-iio@vger.kernel.org>; Mon, 08 Aug 2022 02:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=zM+fqYaB9DSMRySGxWoXld1+MMwnQsZA0DiMEU98ong=;
        b=QT+PNn5aS0/u4pjLiehy7nKQAIOEecupNX39n8RCqdI+2nr/4rJNHprNa3gpCi+QY2
         M9a8NQY2i7ZLQ1pXBTh6/brBqsmfm0DaFDIztLShw1Ay1HbwEbjszqDFAqLRv7gYFh3K
         U4uGSDD5N6di9mlveCaD+CF5AyDWssaLZilLF/etziVDf+gykZ3zjCdUjych1yPPgGgg
         Y1v9xKKmJ3ofZgMA1WzAqGSwyfJXYfj+xB2UBYRYAkSGAHwNi/k61ClEQM6mgWdu/DLc
         j59gEwzj6mg1e/vQhRx3QL1uqYkzNqpdN1/5q+FM8MNxbRAt4LQlKHkZLV8FIfU0bDLe
         Q11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zM+fqYaB9DSMRySGxWoXld1+MMwnQsZA0DiMEU98ong=;
        b=TRGrLPKiqyJLV/rAvecrFBEOAFn02B7NbY5WUd7H56l/QaS+oo7OG55y7v1sXb59/h
         3z02mkmEMKj0nl0jDx72FqMFY4UbIC/V6UfiOdj5mdn0MTJa+Ff/mGFfNn2Cj8JnsHHs
         4faz/HYUF+QXhOA/CFkYnO75ciaAIFjWZivs8RA7rp1A0KEg2uW0yV5n2psgtW5Ltl44
         UKe4VbzIg0i56ZSYMbRLop2cnk4n5zt2/OmLHhaUUKC1t5y8EuiYqnVVuS4aF+S61fxx
         307IBhfEbMz4654r545LF63z7g3AXdlUpRsl+o2nUmrcfCv00msdjqaAshY4BxtG/nMN
         gDVQ==
X-Gm-Message-State: ACgBeo0k/tkdlRuRVa4My44Zuy15e1xrzOXb7hHgvgKRNyoDcpuGLkbC
        nANAUZlEjIvPWrnSvYvNrij50peYUnfO8aJtPxU=
X-Google-Smtp-Source: AA6agR5c5ZlE0OI/xFsozCPKPTxhMYfRiyIS5GveXv4Q024msO8wz8dNbUM33YWZpQjMujKnbOE1rmGeNGHq8RaSBzQ=
X-Received: by 2002:a05:620a:8018:b0:6b6:5df:977 with SMTP id
 ee24-20020a05620a801800b006b605df0977mr13008999qkb.320.1659950468836; Mon, 08
 Aug 2022 02:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220807151218.656881-1-jic23@kernel.org>
In-Reply-To: <20220807151218.656881-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 11:20:32 +0200
Message-ID: <CAHp75VejHmUx_PkoKfijcmVdZWdEvXtKwVWTTPy9uadB559FcA@mail.gmail.com>
Subject: Re: [PATCH 0/4] staging: iio: DMA alignment fixes.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
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

On Sun, Aug 7, 2022 at 5:37 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> When I introduced IIO_DMA_MINALIGN and applied it to all the drivers
> in drivers/iio I said I'd swing by the few remaining staging drivers
> at a later date. This set fixes those staging/iio drivers.
>
> Note that no one has been very active on these drivers for some time.
> They do however support parts that are still available (and I have
> at least one of them) so I think it's worth keeping them around for now.
> Perhaps the necessary cleanup work can be done against emulation or
> road test or we can get parts for anyone interested in doing the necessary
> work.
>
> Anyhow, upshot is that it's unlikely anyone will feel ownership of these
> drivers enough to review this series so if anyone has time a quick
> glance over it would be much appreciated!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

for non-commented patches.

-- 
With Best Regards,
Andy Shevchenko
