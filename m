Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF383509DBD
	for <lists+linux-iio@lfdr.de>; Thu, 21 Apr 2022 12:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388469AbiDUKiN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Apr 2022 06:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388445AbiDUKh7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Apr 2022 06:37:59 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE90C252B2
        for <linux-iio@vger.kernel.org>; Thu, 21 Apr 2022 03:35:08 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id q75so3218160qke.6
        for <linux-iio@vger.kernel.org>; Thu, 21 Apr 2022 03:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=5Xo3Wy4Bwoun9DBLdGdJjSb223VeyshQJxwX+Kr72rw=;
        b=Usp8vsZTzOTlQ4HMGltzGgXMpNYTcNNrcIHwHK7ONGovW0bFMKVqB4CZx3YaT0fgK6
         UFM39DLxyHnYKcoSWbs5z1O3b1mxodroq4IRvrui9BRipGqfWvnKjAQMv3jN5hi8ozVF
         FePRvzVuJcz9D/dC7w0Zm0/vl+hIaLBThgDeqyq92PeyoUOHQw4y4w5SeHg8AGbiZl54
         BkwJaN7Zh/OIuPea72jK/gZuA9EGfd3I5qIjHDbVGEyJ6F4WresilugTbMSN/RqdfXmI
         yXWjKRDjAw5ujod2QSFnmuhjMX2eGLM/g6F7hPWpZmumj6NGCPZw5jHPnGqG47cKFGpz
         HtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=5Xo3Wy4Bwoun9DBLdGdJjSb223VeyshQJxwX+Kr72rw=;
        b=HTDTPqOwcwIrGC2IsENiQ75nwLoFfSzg//ecIrYuvNA3jNAM/7mrABAIn4+OAWQGe7
         LWWWRCDYLZUDp6qEksVzoE9cKmQm09CczN7oCPMk3xICdGCbCjLfSw61WlOBjkDZhq5j
         /1hVUUIbTDzJox27HvsH7OAK9No5iu/F4c1k/G9acnI7HE0mhvqShLqPz0Szt+SM6AAF
         kKhZejFbKdjCgzsvI9qVs5miSr898J1Masz3XNK4XvTJcWbsit14h/H/f38mNkqJPzHH
         DgtN12NB8EbqjrMKGzqVXE6252D5iW/+wdcQgP5AmNq1Rzeax1OCOdk3P0iNfRjdulE3
         Gc1w==
X-Gm-Message-State: AOAM531PPOkGiFHjPpaJzz8rJc4loWgFULPimYPz5MAeP1x3Mx4V7Tod
        MLjJOl9UahY4v6WbIXDN4XA=
X-Google-Smtp-Source: ABdhPJy6K+8mBb4n9rfqPnI7eJHbDeZKoYyBTVR6hnYaw2/P7u2qZCmIqcDTGW2Tt28Dpb+gnoDHbQ==
X-Received: by 2002:a05:620a:2552:b0:67b:32e2:2400 with SMTP id s18-20020a05620a255200b0067b32e22400mr14765256qko.768.1650537307660;
        Thu, 21 Apr 2022 03:35:07 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef02:a900:c14b:a9e1:ff7d:55a1? (p200300f6ef02a900c14ba9e1ff7d55a1.dip0.t-ipconnect.de. [2003:f6:ef02:a900:c14b:a9e1:ff7d:55a1])
        by smtp.gmail.com with ESMTPSA id p144-20020a37a696000000b0069f02b93b36sm578958qke.133.2022.04.21.03.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 03:35:07 -0700 (PDT)
Message-ID: <09b77aaad1f02f07c471fbc25069449aefa4a3b4.camel@gmail.com>
Subject: Re: IIO: Ensuring DMA safe buffers.
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de, catalin.marinas@arm.com
Date:   Thu, 21 Apr 2022 12:35:50 +0200
In-Reply-To: <20220421100528.00006326@Huawei.com>
References: <20220419121241.00002e42@Huawei.com>
         <bcb20a4bc1b877506596341aebfea28b628694b2.camel@gmail.com>
         <20220421100528.00006326@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 
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

On Thu, 2022-04-21 at 10:05 +0100, Jonathan Cameron wrote:
> On Wed, 20 Apr 2022 14:30:36 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Tue, 2022-04-19 at 12:12 +0100, Jonathan Cameron wrote:
> > > Hi All,
> > >=20
> > > For a long time IIO has been making assumption that
> > > ____cacheline_aligned
> > > was sufficient to ensure buffers were in their own cacheline and
> > > hence
> > > DMA safe.=C2=A0 We generally needed this for all SPI device drivers a=
s
> > > many
> > > SPI ABI calls can pass the buffer directly through to be used for
> > > DMA.
> > > Not that regmap doesn't currently do this but it might in future
> > > (and
> > > did
> > > in the past).=C2=A0 I can't remember the history of this well enough
> > > to
> > > know
> > > why we did it that way. I don't remember the pain of debugging
> > > random
> > > corruption caused by getting it wrong however...
> > >=20
> > > However it turns out via
> > > https://lore.kernel.org/all/20220405135758.774016-1-catalin.marinas@a=
rm.com/
> > > =C2=A0
> > > "[PATCH 00/10] mm, arm64: Reduce ARCH_KMALLOC_MINALIGN below the
> > > cache line size"
> > > discussion that there are platforms where this isn't true and
> > > need
> > > 128 byte alignment despite a ____cacheline_size aligning to 64
> > > bytes
> > > on
> > > all ARM64 platforms.
> > > =C2=A0=20
> >=20
> > Oh boy... Here it goes my 5 cents on this
>=20
> :)
>=20
> >=20
> > > (I should probably have known that as the platform I support in
> > > my
> > > day
> > > job has 128 byte cachelines in L3 - however it's DMA coherent so
> > > that's not a problem).
> > >=20
> > > The above series also highlights that we can do much better
> > > anyway on
> > > some platforms
> > > using the new ARCH_DMA_MINALIGN (currently it's only defined for
> > > some
> > > archs but
> > > after that patch everyone gets it).=C2=A0 We should be safe to use
> > > that
> > > everywhere
> > > we currently force ___cachline_aligned and waste a little less
> > > space
> > > on padding
> > > which is always nice ;)
> > > =C2=A0=20
> >=20
> > The above series actually made me go an try to have some more
> > understanding on kmalloc. I might be completely wrong but AFAIU,
> > for
> > our typical case, this won't matter much. Typically we have
> > something
> > like:
> >=20
> > struct something {
> > =C2=A0=C2=A0=C2=A0 //typically we do have more parameters
> > =C2=A0=C2=A0=C2=A0 int val;
> > =C2=A0=C2=A0=C2=A0 u8 buffer[8] ____cacheline_aligned;
> > };
> >=20
> > I thing the idea is to replace this by the compile time annotation
> > ARCH_DMA_MINALIGN which is 128 (for arm64). That means that
> > kmalloc(sizeof(struct something)) will put us already in the
> > kmalloc-
> > 256 cache (right?) and then we will just get 256 aligned objects as
> > this is a power of 2. The point is that as we normally do the
> > compile
> > time annotation we should still have the padding bytes as given by
> > sizeof().
> >=20
> > If I understood things correctly, the above series is way more
> > beneficial for smaller kmalloc calls (without annotation) that
> > won't
> > need the 128 align constrain or for structures with zero length
> > arrays
> > (annotated with ARCH_DMA_MINALIGN) where kmalloc() calls end up in
> > the
> > kmalloc-192 cache.
> >=20
> > Does the above make any sense?
> If we keep the padding between iio_dev and iio_priv at
> ARCH_DMA_MINALIGN
> then we should be fine because we get
>=20

Sure... I was just thinking in a way of saving some space. But
ARCH_DMA_MINALIGN is probably the safest way to go if we want to make
sure things are right. For the record I was not even thinking in
KMALLOC_MINALIGN but using something like cache_line_size() to get the
__real__ size. Even though I think KMALLOC_MINALIGN would work even
though our cache line might be 128. That will be already the case for
objects with KMALLOC_MINALIGN alignment and with buffers annotated with
ARCH_DMA_MINALIGN.

> 0=C2=A0 iio_dev
>=20
> 128 start of iio_priv
>=20
> 256 start of aligned region (after changing to ARCH_DMA_MINALIGN as
> you say above.
> 383 end of potential DMA Safe region - so need to not have anything
> else
> before this.
>=20
> and I think we get in kmalloc-384 cache if it exists.=C2=A0 Which is fine=
.

Probably we end up in 512 which is also fine :)

> >=20
> > That said, I think that we also need to be careful in
> > iio_device_alloc(). Ideally, to save some space, we only align to a
> > real cache line (padding between iio and private struct) and not
> > ARCH_DMA_MINALIGN. Would it be enough?
>=20
> For now I suggest stick to ARCH_DMA_MINALIGN but in future we may be
> able
> to relax that.=C2=A0 We do however run into the same issue crypto does
> of giving missleading information to the compiler (even it if it's
> a non issue in reality) because the structures at iio_priv() will
> still have compile time alignment markings to ARCH_DMA_MINALIGN
> and if the padding of struct iio_dev doesn't bring us to that
> boundary
> then the alignment isn't what he compiler thinks it is.

I think in our case this might not be a problem as I think we will
always end up in a kmalloc cache where the iio_dev alignment will
always be bigger than ARCH_DMA_MINALIGN (multiple of) so iio_priv()
should always start at an ARCH_DMA_MINALIGN aligned address (not sure
though). If I understood your point correctly this is already what will
happen in other objects after that series because we can mark a DMA
buffer with 128 alignment and the container object might end up with
64. Apparently no issue observed so far...

> I'm not immediately sure how else to get that alignment as we don't
> want to be hand adding padding to each driver..=C2=A0 We could do
> something
> magic like introducing a second region with iio_priv2() but that
> is horrible.
>=20
> Walking through this.=C2=A0 If KMALLOC_MINALIGN
> falls to a small enough number then we 'could get'
>=20
> 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 iio_Dev
>=20
> x + delta=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start of iio_priv
> x + delta + 128=C2=A0 start of aligned region
> x + delta + 256=C2=A0 end of aligned region.
> -- any issue will occur because back end of this shares the min
> dma aligned region with something else.
>=20
> So at worst we get into the 384 size kmalloc cache and should be
> fine anyway.
>=20
> Note that we don't care that much about potential savings as there
> is only one of these structures per driver instance so it'll be very
> minor.
>=20

Given the above point, agreed with using ARCH_DMA_MINALIGN (also safer
as I'm not 100% sure about what I have been saying :))


> >=20
> > > Given we have no reports of a problem with 128 byte non DMA
> > > coherent
> > > platforms
> > > I don't propose to 'fix' this until we can make use of the new
> > > define
> > > in the above patch set.=C2=A0 That is going to make a mess of
> > > backporting
> > > the
> > > fix however.=C2=A0 I'm wishing we did what crypto has done and had a
> > > subsystem
> > > specific define for this but such is life.=C2=A0 We will also want to
> > > be=C2=A0=20
> >=20
> > We do have IIO_ALIGN but as we just found out is wrongly defined
> > and
> > was never enforced. Maybe now is a good time for enforcing it :)
>=20
> Agreed. I'll spin a series to change that to be inline with what
> crypto
> does and use throughout the drivers.=C2=A0 Then we can move forwards from
> there as Catalin's series moves forwards.
>=20
> What fun :)
>=20

Cool, I'll help with reviewing...

- Nuno S=C3=A1=20


