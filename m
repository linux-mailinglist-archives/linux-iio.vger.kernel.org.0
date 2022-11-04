Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384C0619696
	for <lists+linux-iio@lfdr.de>; Fri,  4 Nov 2022 13:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiKDMwv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Nov 2022 08:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiKDMwu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Nov 2022 08:52:50 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E34EE31
        for <linux-iio@vger.kernel.org>; Fri,  4 Nov 2022 05:52:49 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id s20so2956725qkg.5
        for <linux-iio@vger.kernel.org>; Fri, 04 Nov 2022 05:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaYM8WO3vkjyskF4qdpmfOVYZRkNE2iZEkb6pQEElCc=;
        b=PhwiFSj24SVRYseMgdVK19A3CDw3f9Rc+t8zp/fdzSVwKXId0RKtvB3WQ+5TMbLyAJ
         038LTTptGe9GgSpm/2qKtexzSruOB/mmHICDuIm5d/o/sxdXyHEaQMLA6YygLMfiPjw/
         g5QkrQSRC+MUVJnQjiIqktHOddH3NeCnW5mC5gQ3aCncV9adpO2AxULIUicmurvmorCt
         im2SSfB2YlhhCA07d5JN5yHJKQyGUPvZf7eofy+x+rqBaAcSw4GZnn02C37KMswyeGrH
         U5SJwQPu3yE4Tlla7pfhTr1NK5cvYcPc523FTG49FgyRM6xovvX8fe2GTH2QQsiM9+V5
         AaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NaYM8WO3vkjyskF4qdpmfOVYZRkNE2iZEkb6pQEElCc=;
        b=lq78O/UMtmcWWcGO2nH2cJz8bg8PKUvBIShQBfMgT9NJzNxNI+yoOP7LEw12FVEkWa
         lnoQXgRwJSRFWgNkL09z+APlrBvlXsSf9umCprrw+nY0m26oENVKsRYBX1hHkSST5DsD
         WYRzBPsGitTbVg+rM9Z2wrY8Izkiig1UPpA6E7rPq8RSJLMLCBt77xhQ/k+G0MlhMCwu
         /bRPMGStIyQVAUuBSGoRMXPaKIDV8YJh/Nb96CoJjpQwWFn/62KxD1S6KIfBYRMvyveT
         iZBu36ZBMi3TtlIUyGOpzw383KZYJel3Qv68W0K1TtFGbponRVzZlErTagje5DIh59M1
         9odw==
X-Gm-Message-State: ACrzQf32cDc6xzFhfmuRh9cWNEC+C7w/uLX+y7uROVKEVlBcpTq2DPOr
        NeWCqpAXJzubS2cFpGTWvssjKTvUVL7QfcNAEOU=
X-Google-Smtp-Source: AMsMyM4GIMABVPu22vPYfPhrQ35WdysGEK8p3g1Ua1rkvrGC0v2Uo1Sy1f/15Gh2VRVWXoZDbmFq7VMFiC8nxVFE4cI=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr26677900qkp.504.1667566368726; Fri, 04
 Nov 2022 05:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221104090307.17734-1-wupeng58@huawei.com> <CAHp75Vd_h3Avyafefg0fj-2BMCqvAH4U3Fd3biTptMMZdo_c2g@mail.gmail.com>
 <d46af04a6bd6373286a18a6f71aebd2c6aafd93a.camel@gmail.com>
In-Reply-To: <d46af04a6bd6373286a18a6f71aebd2c6aafd93a.camel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 4 Nov 2022 14:52:12 +0200
Message-ID: <CAHp75VcpgrHz4MLmY+U=C74b=qpfipURJEbuTU6kn7RftdT_cA@mail.gmail.com>
Subject: Re: [PATCH -next] iio: core: fix missing mutex_unlock() in iio_device_claim_buffer_mode()
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     Peng Wu <wupeng58@huawei.com>, jic23@kernel.org, lars@metafoo.de,
        nuno.sa@analog.com, linux-iio@vger.kernel.org, liwei391@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Nov 4, 2022 at 1:11 PM Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> On Fri, 2022-11-04 at 11:54 +0200, Andy Shevchenko wrote:
> > On Fri, Nov 4, 2022 at 11:05 AM Peng Wu <wupeng58@huawei.com> wrote:
> > >
> > > In the success path of iio_device_claim_buffer_mode(),
> > > mutex_unlock()
> > > should be called before return.
> >
> > Please, understand how the code works.
> > NAK.
> >
> > Nuno, perhaps we need to put a comment inside the function to explain
> > this?
> >
>
> Hmm... I guess we can do that but, honestly, the docs in the function
> should be pretty straight. Maybe saying that it's supposed to work as
> iio_device_claim_direct_mode() would help (as that one is familiar)...
>
> Alternatively, having sparse annotations could also make it more easy
> to understand the intent.

Maybe simply

/* Yes, we leave it locked here */

before return 0; would suffice?

--=20
With Best Regards,
Andy Shevchenko
