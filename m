Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9785A6E17
	for <lists+linux-iio@lfdr.de>; Tue, 30 Aug 2022 22:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiH3UF1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Aug 2022 16:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiH3UFZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Aug 2022 16:05:25 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B2E2CCA2
        for <linux-iio@vger.kernel.org>; Tue, 30 Aug 2022 13:05:23 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id s22so6829062qkj.3
        for <linux-iio@vger.kernel.org>; Tue, 30 Aug 2022 13:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=FDjIWM3xWil1sQ/IcpT10UX6ICeya7wc03xyqbmLFrg=;
        b=iXcPdykpSj9ina982A+gwG9G+a5RmGi7eX7lfsuEdwvFv1DiBZWSB/0reSY5blDQdC
         NMpM12ELwAoPBqs7S8u8XVeBm/92ZQ8xUhgfWQIDiN8/Zc1ZuNkeT3rXg4EjVAaWOY3k
         cIL8vHbEFpQrKmELjW+6vR/noIDnqhiI1A3TLTJ1QCAhpQ8ekhqysIB26inUABdfULsE
         FsUqsyfrNUZSO3z0IspFzQNNNr1qDiseRMAmhG1cBm1UUKz2qzNkhpri+Mq53KzFty9h
         JJy5v+oKGfIi46s0OaROGmQzujsJZOSBZYPbd/5bm9+/5LTJsSilcJ6CPyJ0RG/ZSFz2
         hDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FDjIWM3xWil1sQ/IcpT10UX6ICeya7wc03xyqbmLFrg=;
        b=oY93EAsX8SN5Jf7i2+LzJ/sd8K420ZZU/mLEFtUpPiq8O++W+pfBR5W5TWgbjekQNL
         X+062dsQBZe9bjhgC/0ftcGje5xAuBXwrBJmsnqkvSkizsiPQssHYlqgfBSOnR1bcEUp
         IFuqaRNWj40noFzYcjfBHkPNnUc2EjGECggSoMaD4ok1RHrPN38EIeAdFYSrE0/F5iS7
         8xm2ZzbQO3tY9999JBEyelR/pN+y7zNKeXcU8C5fYFRN8PbUtcFcRS5+sw67taQxaYCe
         F63V2An3OVLWfuz+xonEwT9TVxK6ueRMncpKgwllg49h/ZPAwd1rARbQXhgx59H5dFg9
         7qYw==
X-Gm-Message-State: ACgBeo0dz0NluZuMIIwSzeAWaLVEl81FhB8UOQ/cK3c8t+IknpMAI3q3
        Bubcgu06DRzky4w+sQAR6Mhjl/22AV7N3e9a0Ts=
X-Google-Smtp-Source: AA6agR7LZt3926FgbIFG1UJbeikzGbWDBCgwqEXoZvbt7QNaeOoymB9+OwyHMwP6rg7Rv8XUuO9/2xQ+wg0bWSCJunw=
X-Received: by 2002:ae9:e311:0:b0:6ba:e711:fb27 with SMTP id
 v17-20020ae9e311000000b006bae711fb27mr13385846qkf.320.1661889922934; Tue, 30
 Aug 2022 13:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220830183325.2641490-1-jic23@kernel.org>
In-Reply-To: <20220830183325.2641490-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Aug 2022 23:04:47 +0300
Message-ID: <CAHp75VfjWOdgAW=YuszG5Dih_2D78YB20ShaNWVxMGjOKQhsWQ@mail.gmail.com>
Subject: Re: [PATCH] iio: cdc: ad7746: Suppress false uninitialized value warning.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
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

On Tue, Aug 30, 2022 at 10:10 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Fix warning:
> drivers/iio/cdc/ad7746.c:336:14: warning: use of uninitialized value '<unknown>' [CWE-457] [-Wanalyzer-use-of-uninitialized-value]
> reported on linux-next.  The compiler can't see into the implementation
> of kstrtobool() to identify that the if (ret < 0) condition is
> sufficient to detect cases where this parameter is not initialized.

Sorry, but to me this sounds like a false positive that provokes
developer to add not only unneeded, but in some cases harmful code
(yes, there were cases in the history when preinitializing variable
with some value made a regression).
NAK from me (but you always may overrule as a maintainer :-).

-- 
With Best Regards,
Andy Shevchenko
