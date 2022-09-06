Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14935AE905
	for <lists+linux-iio@lfdr.de>; Tue,  6 Sep 2022 15:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiIFNE4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Sep 2022 09:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240190AbiIFNEz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Sep 2022 09:04:55 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A32A21828
        for <linux-iio@vger.kernel.org>; Tue,  6 Sep 2022 06:04:54 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1278a61bd57so9419462fac.7
        for <linux-iio@vger.kernel.org>; Tue, 06 Sep 2022 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7Haewm4pcI6ughQ1h8d6eCH0y+Fa4YzQ3XWrFfPFHdM=;
        b=gZ1NSeFPE+0lZGlav/wzFNn/dSqU/yNEuwpQNNs0Nt55bsLZoMeJWS1/CQjYcGUbFE
         dzhWj5EOasmyF5MoUzSG632ZX9kIvuof3pTMMq4CLyF1LDCoXZBjA71zLJimTWpyuA6o
         jSAp+m3l7226UqJgAF7kldOPfXx4JiMwHq2LDJTG2yyIWo5dcyE7mhodkTF9uPaFdFlv
         hC7ZSYWwVVpoMhesTgy2Ta/E54WY8/BeewR+QOBuVx/WvmUZjzSY1Pcx54TyG84y8pm+
         82fr1EpeW8VcejHmBrvL0EaXNX24lwevhxeVvUtRk5Cl2Y7C9WSOLgX+S41ZUYeuZ5dW
         F72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7Haewm4pcI6ughQ1h8d6eCH0y+Fa4YzQ3XWrFfPFHdM=;
        b=gz+myNEtRUDuofmh+1mXza+92kGi/GU3Uqwa1LjcBnzNrOwyVypTLISvyDqAMYOn1J
         ERAGZuHlD/tD7GwiIrSEOQ/isrvcrRq4DO0uFWaNKtVbFto9ZI1k8TozL/oCrEzKFuKg
         tm2KR1KVdOWERrJuyhRtHJFnzyJRZfWw/0/SkaLOKEuIe/Q9w5Vyrxx946Gh+ELzWeEY
         jpFZBFmwWS3VpP7nD45Xwt/0u5ZF2UXqWoi2sy7dWXNuPa6ukQi2epAHObTxhvugOzmp
         WqCRgb8I/ie85Fjz53qa0OyQp97CbjmMiA31um5A9DN/XQ71eG6pd6/bk2HkhRa4U3BF
         3bjg==
X-Gm-Message-State: ACgBeo0/su3xBeLShavUSLZ9erffrcjfIbKN8i1Uf98UoC/r3Fmn79mD
        gDScmcGPOCNpr8w6iJqArPWcljxVypfIIhhtslvN5488pTc=
X-Google-Smtp-Source: AA6agR6B6YeRaWAlddT2IpJ3b2YefZvlzZju/DNCIjrQ3U9qB9vM+iWjlJiKiS/BIaTrwzI8b92Tgus8vmDxx/umhEQ=
X-Received: by 2002:a05:6808:e90:b0:345:49f2:a112 with SMTP id
 k16-20020a0568080e9000b0034549f2a112mr10039724oil.7.1662469492642; Tue, 06
 Sep 2022 06:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662454215.git.cmo@melexis.com> <32c4b72624e4a3480b202f24f506ca91029e47f7.1662454215.git.cmo@melexis.com>
 <CAHp75VezNufWGW6sC+ALmX9H4yavWRCmpHuv9ZVoRycQxZ-uQg@mail.gmail.com>
 <CAKv63utD2NzbUYR2=rrmZtkdtwOzoQBW7dZ5yzNa-r8uKmqXaw@mail.gmail.com> <CAHp75Vc1a1bguLxX7Laewa9f2k9c38KeOD1zsikmC+3=21MnyQ@mail.gmail.com>
In-Reply-To: <CAHp75Vc1a1bguLxX7Laewa9f2k9c38KeOD1zsikmC+3=21MnyQ@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Tue, 6 Sep 2022 15:04:16 +0200
Message-ID: <CAKv63utCSXVgOP4JkEBQSzDWF_s443a-ZbCd8V4tP9=z461McA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 6 Sept 2022 at 14:37, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Tue, Sep 6, 2022 at 1:52 PM Crt Mori <cmo@melexis.com> wrote:
> > On Tue, 6 Sept 2022 at 12:21, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > >
> > > Very good and documented code, thanks!
> > > I believe you better to use DEFINE_.*_PM_OPS instead of legacy ones
> > > (due to pm_ptr() usage).
> > > Otherwise, with some nitpicks that wouldn't prevent a green light,
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > >
> > I checked DEFINE_.*_PM_OPS usage around drivers and you either have
> > SIMPLE (where you define suspend/resume) or you have RUNTIME (for
> > runtime suspend/resume), but never are those two together. So I am a
> > bit puzzled how to get this working.
>
> The one which suits here is called _DEFINE_DEV_PM_OPS(). But it's
> basically the same what you put here with the possible unused case.
>
I thought underscore prefixed macros are the ones not to be used
directly by drivers. I also found no occurrence in current drivers, so
it was not something that was done so far?
