Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8087558C596
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 11:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242409AbiHHJbp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 05:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242513AbiHHJbH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 05:31:07 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DBBDFD
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 02:30:59 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id z7so643529qki.11
        for <linux-iio@vger.kernel.org>; Mon, 08 Aug 2022 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ILZ4fdrUm7C1Av8NW/eyrpoPVZX0p2WQccCJ5ToI2Ho=;
        b=SM6oIdHqcxZtMVAYE0P7fcWplxK5ipm7FyWhbl/S+tKcUejGdVyYmaA/+a1v3xygaW
         D7zOpCTV2rXrgqjLFq9V117IqxKtF/5aOF+hxy0zYN7RiXXI0rHwK2QHrFqI0jW8Chz4
         ZgrMyGrc/3ZhqqU9ufR6fsWpQ2I+F9e1L9jpqH8aDs+dIldYEkBFmuiF0zo5X60XgWp/
         SEhbudx0YVpEo+KNeJ/b9oxhj+uoFmEARDdBPg4SId7niLRjUm5K1xhWukJVs9KzW4h8
         PhgPZynQR6N4iwPEcu9CWIxWELNRcnoobuTr0wDnenteH2gAIsFBrB7mIQxTw18olqB0
         lhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ILZ4fdrUm7C1Av8NW/eyrpoPVZX0p2WQccCJ5ToI2Ho=;
        b=z3a/t6PSMyshQil1WKvvNw6Qz66/lVIBXbRIyocvbfRGHAnw2uWQHjE6vnpfPlrBwK
         6G5WQ9Gd11Ht77STN/NpJ3RI+mbdf+QTbGNVYnPSC6lDnd4FGjwn1uvkzhJ8gQM17MWZ
         qEaGQxxncGyqnXuWIRATwRW9PEMUY0OLtAJz5KH8txOTZMBErKp0OtnpOcBv/j6liqKh
         pY756b2TVlki6Zk/hAunm7tyPzuJS1tJuXxDgwcqULcEFd1pmKQLUkCIxCxXn24bZVyC
         u/UifNFbHit4dfLHWhIdB82SbncA+yvac108noSHTofg1+cn69mzVxsU0mnzGr+tZtTf
         6exA==
X-Gm-Message-State: ACgBeo3FfVoaYSxa+79Hva6dW8HcHDhBJnHw4UVnmvigAFS0NvOMhaaj
        ZGEkzMM3yHLaOut7u4jJInZutIJRQq1rSZNJ3hF0OzsOeXTqUw==
X-Google-Smtp-Source: AA6agR69OM9hR9Aoo45g/mti7QqcL4LMQxHiEJZVu2Qav+SOMuC1AChJQrh5cPUuWELtqjJFI262xNeNUyhrE1mQOCM=
X-Received: by 2002:ae9:e88d:0:b0:6b9:4a0b:cea5 with SMTP id
 a135-20020ae9e88d000000b006b94a0bcea5mr3175365qkg.748.1659951058919; Mon, 08
 Aug 2022 02:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220807190414.1039028-1-jic23@kernel.org>
In-Reply-To: <20220807190414.1039028-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 11:30:22 +0200
Message-ID: <CAHp75VfG3FRoAtH9RhgjVzJDKy8DgwnUi4wn_cN9im5-U3MrRQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] iio: Convert some drivers from deprecated UNIVERSAL_DEV_PM_OPS()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Crt Mori <cmo@melexis.com>,
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

On Sun, Aug 7, 2022 at 8:59 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> During discussions of the new PM macro definitions, it because clear that
> UNIVERSAL_DEV_PM_OPS() generally doesn't make much sense as it can lead
> to unnecessary work.
>
> For the drivers in this set I've taken a look at how the ops are used
> and believe we can just switch to DEFINE_RUNTIME_PM_OPS() which will only
> do the suspend if the device is not already runtime suspended.
>
> I'd like some review of these (more than for the straight forward NOP conversions).

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Thanks,
>
> Jonathan
>
>
> Jonathan Cameron (2):
>   iio: pressure: icp10100: Switch from UNIVERSAL to
>     DEFINE_RUNTIME_DEV_PM_OPS().
>   iio: temp: mlx90632: Switch form UNVIVERSAL to
>     DEFINE_RUNTIME_DEV_PM_OPS()
>
>  drivers/iio/pressure/icp10100.c    | 10 +++++-----
>  drivers/iio/temperature/mlx90632.c | 10 +++++-----
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> --
> 2.37.1
>


-- 
With Best Regards,
Andy Shevchenko
