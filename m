Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3C850B131
	for <lists+linux-iio@lfdr.de>; Fri, 22 Apr 2022 09:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444602AbiDVHQG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Apr 2022 03:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382656AbiDVHQF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Apr 2022 03:16:05 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3D650E34
        for <linux-iio@vger.kernel.org>; Fri, 22 Apr 2022 00:13:12 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id x24so4935562qtq.11
        for <linux-iio@vger.kernel.org>; Fri, 22 Apr 2022 00:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=0fmhi7nPReMevSqI0LI0Lo+X5D/NpCa5X0e1vGX4pqE=;
        b=SbXSdkYb33nbdK37XXnqacmP2NnWS6f+RYYAkNixdKEpNI4s7hTkBGzU04iVF7G0ie
         wfwVhLBV7vsvGBudc3mTaVgXWskfH3KUrunK2/W8+9TepWlC6Z3wwulZOqQ4eKVd6zw8
         rol7aL+GQXKRWwPpoDtx2vObMaZ1ruPv4R4FCGUyVAXVQ6XOOR1HXHh0BytSEW2LZT/W
         IaGvOkTdAuMU6B3eeGYrfiGJA3YY7LeqjvesrXrmh9FRxv++Qj+C6xWytq34eoSziB/r
         uARc9lCOXym7kdgB5jSsyh4zGNTyuRZYn8XiJMbdoTbLvwWBMIuB3v0kXbbOPwCYcThy
         ipIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=0fmhi7nPReMevSqI0LI0Lo+X5D/NpCa5X0e1vGX4pqE=;
        b=eX5n+3E6Pg/Ozwc4CGqROVkTbzwrTkmCbIIJY0rnagL2koiZchAAmuJX+hFlaM/HBr
         X/1+/JUxTwAxj9oFu0dMlFH3H436eW9ngsVf+TNlLH9m7sFjFeGLFdXUf0uSm22q6TmA
         VYvL+iaEWSjo1lMXNQVn8umzcCiRtbSnW8amdZux8ti0cpIkeDPrc4lo1kaWH8ACo2aY
         Nrv2gfkfMd7YUtUGI+qt02TXhs8YAxLWoGp24G4cS1wmpn5e4QgNIoHq3kW4BMQ7V6B+
         skI6MeJroI2uGzQUYivIcHjpfL2uYWSuZH8nJRPLLgXcXHPsBdoRpxFe1U+9vBXxWzAG
         A03g==
X-Gm-Message-State: AOAM533ZvOnzg3lbfDO34qgZEVNy40KJ1qPiQA49mTaeOSvC5CPCKgdW
        GgSoSWB/IUlGgUdkt+mSzso=
X-Google-Smtp-Source: ABdhPJwKgACLl/U540BaLpZIqgu+qqpp1UuvGieD3/V3Oqso1P/I87DMbNleXyKK9+x4gnpbfgEafw==
X-Received: by 2002:ac8:5f8d:0:b0:2f3:3f9a:d5bb with SMTP id j13-20020ac85f8d000000b002f33f9ad5bbmr2209517qta.314.1650611591354;
        Fri, 22 Apr 2022 00:13:11 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef01:8200:22bd:4059:2626:d604? (p200300f6ef01820022bd40592626d604.dip0.t-ipconnect.de. [2003:f6:ef01:8200:22bd:4059:2626:d604])
        by smtp.gmail.com with ESMTPSA id j1-20020ac85c41000000b002f24ed4fc04sm871933qtj.83.2022.04.22.00.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 00:13:10 -0700 (PDT)
Message-ID: <9cac1481126c7af052d62905d0414d71c2a052b3.camel@gmail.com>
Subject: Re: IIO: Ensuring DMA safe buffers.
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de, catalin.marinas@arm.com
Date:   Fri, 22 Apr 2022 09:13:54 +0200
In-Reply-To: <09b77aaad1f02f07c471fbc25069449aefa4a3b4.camel@gmail.com>
References: <20220419121241.00002e42@Huawei.com>
         <bcb20a4bc1b877506596341aebfea28b628694b2.camel@gmail.com>
         <20220421100528.00006326@Huawei.com>
         <09b77aaad1f02f07c471fbc25069449aefa4a3b4.camel@gmail.com>
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

On Thu, 2022-04-21 at 12:35 +0200, Nuno S=C3=A1 wrote:
> On Thu, 2022-04-21 at 10:05 +0100, Jonathan Cameron wrote:
> > On Wed, 20 Apr 2022 14:30:36 +0200
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >=20
> > > On Tue, 2022-04-19 at 12:12 +0100, Jonathan Cameron wrote:
> > > > Hi All,
> > > >=20
> > > > For a long time IIO has been making assumption that
> > > > ____cacheline_aligned
> > > > was sufficient to ensure buffers were in their own cacheline
> > > > and
> > > > hence
> > > > DMA safe.=C2=A0 We generally needed this for all SPI device drivers
> > > > as
> > > > many
> > > > SPI ABI calls can pass the buffer directly through to be used
> > > > for
> > > > DMA.
> > > > Not that regmap doesn't currently do this but it might in
> > > > future
> > > > (and
> > > > did
> > > > in the past).=C2=A0 I can't remember the history of this well enoug=
h
> > > > to
> > > > know
> > > > why we did it that way. I don't remember the pain of debugging
> > > > random
> > > > corruption caused by getting it wrong however...
> > > >=20
> > > > However it turns out via
> > > > https://lore.kernel.org/all/20220405135758.774016-1-catalin.marinas=
@arm.com/
> > > > =C2=A0
> > > > "[PATCH 00/10] mm, arm64: Reduce ARCH_KMALLOC_MINALIGN below
> > > > the
> > > > cache line size"
> > > > discussion that there are platforms where this isn't true and
> > > > need
> > > > 128 byte alignment despite a ____cacheline_size aligning to 64
> > > > bytes
> > > > on
> > > > all ARM64 platforms.
> > > > =C2=A0=20
> > >=20
> > > Oh boy... Here it goes my 5 cents on this
> >=20
> > :)
> >=20
> > >=20
> > > > (I should probably have known that as the platform I support in
> > > > my
> > > > day
> > > > job has 128 byte cachelines in L3 - however it's DMA coherent
> > > > so
> > > > that's not a problem).
> > > >=20
> > > > The above series also highlights that we can do much better
> > > > anyway on
> > > > some platforms
> > > > using the new ARCH_DMA_MINALIGN (currently it's only defined
> > > > for
> > > > some
> > > > archs but
> > > > after that patch everyone gets it).=C2=A0 We should be safe to use
> > > > that
> > > > everywhere
> > > > we currently force ___cachline_aligned and waste a little less
> > > > space
> > > > on padding
> > > > which is always nice ;)
> > > > =C2=A0=20
> > >=20
> > > The above series actually made me go an try to have some more
> > > understanding on kmalloc. I might be completely wrong but AFAIU,
> > > for
> > > our typical case, this won't matter much. Typically we have
> > > something
> > > like:
> > >=20
> > > struct something {
> > > =C2=A0=C2=A0=C2=A0 //typically we do have more parameters
> > > =C2=A0=C2=A0=C2=A0 int val;
> > > =C2=A0=C2=A0=C2=A0 u8 buffer[8] ____cacheline_aligned;
> > > };
> > >=20
> > > I thing the idea is to replace this by the compile time
> > > annotation
> > > ARCH_DMA_MINALIGN which is 128 (for arm64). That means that
> > > kmalloc(sizeof(struct something)) will put us already in the
> > > kmalloc-
> > > 256 cache (right?) and then we will just get 256 aligned objects
> > > as
> > > this is a power of 2. The point is that as we normally do the
> > > compile
> > > time annotation we should still have the padding bytes as given
> > > by
> > > sizeof().
> > >=20
> > > If I understood things correctly, the above series is way more
> > > beneficial for smaller kmalloc calls (without annotation) that
> > > won't
> > > need the 128 align constrain or for structures with zero length
> > > arrays
> > > (annotated with ARCH_DMA_MINALIGN) where kmalloc() calls end up
> > > in
> > > the
> > > kmalloc-192 cache.
> > >=20
> > > Does the above make any sense?
> > If we keep the padding between iio_dev and iio_priv at
> > ARCH_DMA_MINALIGN
> > then we should be fine because we get
> >=20
>=20
> Sure... I was just thinking in a way of saving some space. But
> ARCH_DMA_MINALIGN is probably the safest way to go if we want to make
> sure things are right. For the record I was not even thinking in
> KMALLOC_MINALIGN but using something like cache_line_size() to get
> the
> __real__ size. Even though I think KMALLOC_MINALIGN would work even
> though our cache line might be 128. That will be already the case for

Well, this is total nonsense from me... KMALLOC_MINALIGN will fail
miserably if our cache line is bigger than it. For arm64 that would be
on KMALLOC_MINALIGN=3D=3D64 and cache line=3D=3D128. That said, aligning
iio_priv() to a cache line would be safe and we could save some space
in case the line is < ARCH_DMA_MINALIGN (which typically is).

Anyways, as Jonathan pointed out we typically just have one IIO object
per driver so the hassle is probably not worth it.

- Nuno S=C3=A1


