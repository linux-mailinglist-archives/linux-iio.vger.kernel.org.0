Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B97E6193E8
	for <lists+linux-iio@lfdr.de>; Fri,  4 Nov 2022 10:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiKDJzF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Nov 2022 05:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKDJzD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Nov 2022 05:55:03 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5151E729
        for <linux-iio@vger.kernel.org>; Fri,  4 Nov 2022 02:55:01 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id w4so2765987qts.0
        for <linux-iio@vger.kernel.org>; Fri, 04 Nov 2022 02:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WcbdPf5mcbTE9USdyuDwmcu6+Eyj2e27aF2m5iQXwS4=;
        b=HPEjogco/A+G5ALWXhf7wrqQfNx94fV8/Rw84rOtWhV3yAn7qSalH4iDpDjiIt3Qn7
         v6+EilyoFnQn5Dqw4OGvvJ0gRlgtYvncBKjG61LYFCTIIv0edfealsCv90OIVXk1Yq0i
         BdfDsSf4BI14xDZLrT1cAkZSuPcJpIVMXqI7dGrqY0xbuAg0nDKpxkQD98jNpfwynjC8
         jMdhaFrqIggGQLyjLFCArd/UNa8+G3CMqo1vKtEnHaSOjJ2MWgEeHz6oKF+nCSlEdlWn
         fLj3ds4eBYUKdIXt6g+PAg2fj4DaT/ip8vYO8awP+gbyOVhpCcgketf8fARpTZCudoeQ
         Q0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcbdPf5mcbTE9USdyuDwmcu6+Eyj2e27aF2m5iQXwS4=;
        b=ebLf69nBtEWjSxRuGNq7UO9JV/I0urTATvGhL2LURpv3s14zYKv/a03l8+mv/gjdDc
         SZSm4MWiRx+GnP+ZKhiO4G+hIaU98XQPTU6DEYHm/bDA9+3lwJLgQNo5VC5eaH/bepIh
         JnNN+9vDKoiJEeWpworSEVaIE9Dsy2px1yyQi9fysxgxf97Fpwnp6kv/AB2d/Im6xszo
         rRN9JL35ZV4ZLa3ApmB4GiNJ/LXt9tgko7RNMScJegP4Zs1OCrvDW6yffjrp7v56hOiI
         w3HocYOCY5AGnGjhWA1pL+pLZLoF8ekCjRpAWIxDY7ikAoCtZ2WWzp/4BxP31fysX0c4
         WOdw==
X-Gm-Message-State: ACrzQf3ZBMFWlnc+pDReScgVOOyswNq47g2TcyA1T49QcQNORJ74gPMY
        BveOnWHwCVzTjmRR1hxVmBCfF0uqRyre4oAC6qY=
X-Google-Smtp-Source: AMsMyM5F2gNByJNQqzBWsNm8Gg8yVIQWHzj3Y98Dg/C35vUHRb3r30smlCAhEihjwtd5Nvh9Vf0D2QW6jjkIBDTd0Ww=
X-Received: by 2002:ac8:59c3:0:b0:3a5:43b0:6a5b with SMTP id
 f3-20020ac859c3000000b003a543b06a5bmr12188991qtf.61.1667555700716; Fri, 04
 Nov 2022 02:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221104090307.17734-1-wupeng58@huawei.com>
In-Reply-To: <20221104090307.17734-1-wupeng58@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 4 Nov 2022 11:54:24 +0200
Message-ID: <CAHp75Vd_h3Avyafefg0fj-2BMCqvAH4U3Fd3biTptMMZdo_c2g@mail.gmail.com>
Subject: Re: [PATCH -next] iio: core: fix missing mutex_unlock() in iio_device_claim_buffer_mode()
To:     Peng Wu <wupeng58@huawei.com>
Cc:     jic23@kernel.org, lars@metafoo.de, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, liwei391@huawei.com
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

On Fri, Nov 4, 2022 at 11:05 AM Peng Wu <wupeng58@huawei.com> wrote:
>
> In the success path of iio_device_claim_buffer_mode(), mutex_unlock()
> should be called before return.

Please, understand how the code works.
NAK.

Nuno, perhaps we need to put a comment inside the function to explain this?

-- 
With Best Regards,
Andy Shevchenko
