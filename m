Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1828C619838
	for <lists+linux-iio@lfdr.de>; Fri,  4 Nov 2022 14:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiKDNgo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Nov 2022 09:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiKDNgn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Nov 2022 09:36:43 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31502C124
        for <linux-iio@vger.kernel.org>; Fri,  4 Nov 2022 06:36:40 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a13so7709290edj.0
        for <linux-iio@vger.kernel.org>; Fri, 04 Nov 2022 06:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8ev+7MEn1pNnZQF/hCxiNNmdzP0gBMBmryxqDZ3NcUY=;
        b=qhwFSJHbhqjJRxdtv5sttMH7VXK0YKRN/0aiDVNHR3ictuOKIF6Yja2DralPy/R30p
         RFSNkevPI6EjBO9xMbvO9w59nhcViDoMCg2lYZb1NmKjkoz5T4UgzCSyLdaGBfBO6im9
         fWptBmmZmsbZ14fFsVMVyLTlQsG7bILCX7SyVW2u1ugsK3BpRuumNIsIfyEcdaAM4Omk
         r2zZ+ZWh8ZS/fOKndvnjKAEnSZ+1wvpOcEzQeAMPa7Kla71qFtIs8enwOEGyiu46CVQV
         vZttHoSCTU5NeUVvsjYN4lEuHpd9KviX/BkVsJr0QNLl5C4cbO6GoWLUzed8/jWgVJdl
         4dkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ev+7MEn1pNnZQF/hCxiNNmdzP0gBMBmryxqDZ3NcUY=;
        b=JrGBI/Fw2J3nAfVJ5G2IqIJS1rXG9p/DUQ1KWhIacu/3ZaJgpM3Wo7lo1LpaX9yOFU
         79PVMw08y4d0YjtgUdVymd1f8HPUFfwQRESha156KQKF/UTUczTl34xnpckv3Yh810X6
         2Q133y/30OppRL5ct/1WXTQ9t5LHR2/1/vIASABt9poMm/oocJUnDG0ogmFAfjALQ131
         cv/UVKnOQh1VRNpcTjusFAyy0iHPtjq2WTGAyJ/9WfxC0AHz8gYxP7zpiZgd/1pGDRmn
         ngEuajOJtVVEmbra/xMZLWGiY7Bc7HWnLINCFiLJPXioQ7po1oWBMO5ImRWSFH46V/fC
         CffQ==
X-Gm-Message-State: ACrzQf09omanlkz5KrMNTKV88pqIB4lxrmn06RMFRSXJVZtx47+EUWhO
        wPF1bQg5Gnrnku6L9ggkF5am82GIcGYKQeBb
X-Google-Smtp-Source: AMsMyM7IYfUpv1lR5RKOThK+fjn+9qjuuA0b8dNMvgnSh35FOhPCTSTi0g+AuBe+Gv7z8IylaGmMmg==
X-Received: by 2002:a05:6402:42d0:b0:457:d16e:283d with SMTP id i16-20020a05640242d000b00457d16e283dmr35478015edc.395.1667568999059;
        Fri, 04 Nov 2022 06:36:39 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id qq18-20020a17090720d200b007add62dafb7sm1826488ejb.5.2022.11.04.06.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:36:38 -0700 (PDT)
Message-ID: <126c385f005958ac72662ac549c699623d44fdcd.camel@gmail.com>
Subject: Re: [PATCH -next] iio: core: fix missing mutex_unlock() in
 iio_device_claim_buffer_mode()
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Peng Wu <wupeng58@huawei.com>, jic23@kernel.org, lars@metafoo.de,
        nuno.sa@analog.com, linux-iio@vger.kernel.org, liwei391@huawei.com
Date:   Fri, 04 Nov 2022 14:38:07 +0100
In-Reply-To: <CAHp75VcpgrHz4MLmY+U=C74b=qpfipURJEbuTU6kn7RftdT_cA@mail.gmail.com>
References: <20221104090307.17734-1-wupeng58@huawei.com>
         <CAHp75Vd_h3Avyafefg0fj-2BMCqvAH4U3Fd3biTptMMZdo_c2g@mail.gmail.com>
         <d46af04a6bd6373286a18a6f71aebd2c6aafd93a.camel@gmail.com>
         <CAHp75VcpgrHz4MLmY+U=C74b=qpfipURJEbuTU6kn7RftdT_cA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2022-11-04 at 14:52 +0200, Andy Shevchenko wrote:
> On Fri, Nov 4, 2022 at 1:11 PM Nuno S=C3=A1 <noname.nuno@gmail.com> wrote=
:
> > On Fri, 2022-11-04 at 11:54 +0200, Andy Shevchenko wrote:
> > > On Fri, Nov 4, 2022 at 11:05 AM Peng Wu <wupeng58@huawei.com>
> > > wrote:
> > > >=20
> > > > In the success path of iio_device_claim_buffer_mode(),
> > > > mutex_unlock()
> > > > should be called before return.
> > >=20
> > > Please, understand how the code works.
> > > NAK.
> > >=20
> > > Nuno, perhaps we need to put a comment inside the function to
> > > explain
> > > this?
> > >=20
> >=20
> > Hmm... I guess we can do that but, honestly, the docs in the
> > function
> > should be pretty straight. Maybe saying that it's supposed to work
> > as
> > iio_device_claim_direct_mode() would help (as that one is
> > familiar)...
> >=20
> > Alternatively, having sparse annotations could also make it more
> > easy
> > to understand the intent.
>=20
> Maybe simply
>=20
> /* Yes, we leave it locked here */
>=20
> before return 0; would suffice?

Yes, I think so...

- Nuno S=C3=A1

