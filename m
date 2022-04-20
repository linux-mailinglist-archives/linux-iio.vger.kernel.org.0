Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF476508824
	for <lists+linux-iio@lfdr.de>; Wed, 20 Apr 2022 14:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345412AbiDTMcx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Apr 2022 08:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378704AbiDTMck (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Apr 2022 08:32:40 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6938B86C
        for <linux-iio@vger.kernel.org>; Wed, 20 Apr 2022 05:29:54 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id a5so1195476qvx.1
        for <linux-iio@vger.kernel.org>; Wed, 20 Apr 2022 05:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=7eYOyIpqFCPoAIaPtGlclzYDgiifTBbcT/vot2KnzLE=;
        b=WRgHW+wkW9jz5ht/mukIfk2IXwl5J7RwYhSwjUIejuaj9HW1SQfZMmAL7H2AFM8shk
         o1RPghyxe6tWqNhFcVxVEYdc2MoIvkfMeoZOsHr9PYlb6RB/ZkLj6o5QeEkW1q5d7mJy
         taFA8MXt1Ii5Ol8Kw39ayLUFEOE0pb97Gqvpy23HfKkPuzsyUN3iyWA8A7R3BPzFrd4o
         e0o5BEacTz0hKTAfJrJi6xD01CaemKu3jn0z6dqEnolbyFxKDJiSMvfpaoWZV+OljA7Z
         UzDtE0HV1jROL/cLXQrZC1qiVoJB9zrfvbifMLbT4UjQoi+k62swfdsqi342m7w8M509
         njLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=7eYOyIpqFCPoAIaPtGlclzYDgiifTBbcT/vot2KnzLE=;
        b=14Lzlmn5sFoIQWHYDZ2Q+TFRzHsS1wYFXvPi9uJe+EXY2h8ktUmAN/P7SQ07Rhr0Go
         FIURi6nM/NuXmRsabtMGGvuL9/CFGD0pBnhDejahmyzYcxbUPd7Zu35lfSjpoxr7T8uA
         0OQZpb9nz4PvlfJE4gihaHW/K9g0ZAk3uRZy8oD7wjgRZXVOErjFvz2s7McnsJVfUlhA
         2G0iapIJY4gDUJHrUInujZOL+VynSPMvuwE6rTwmKSj+dTCSwd2AHKai9eVo8PhSich8
         jzuYkh7sStMDXaT4nJJGhnFWVzntg9Zo4hBRDY212BFFblp/9H/vZbFhuPHZOWG7BJ4k
         ARkg==
X-Gm-Message-State: AOAM530qCGiyZ3V7F6OKDw1AfWo7EmnczuLfwRTT9e5Nc4GBDkQlYplj
        vH8WZS9zoeCA6Zgw+w8WqP8=
X-Google-Smtp-Source: ABdhPJxKdzDNxKXdusXADxEz3BYcrd2cU7AOT0lwedgNB17BeXgEmWzQh2DJMslIObLqjVcOZzWGYw==
X-Received: by 2002:a05:6214:27cb:b0:444:4223:9e1e with SMTP id ge11-20020a05621427cb00b0044442239e1emr14779179qvb.36.1650457793709;
        Wed, 20 Apr 2022 05:29:53 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef02:a900:c14b:a9e1:ff7d:55a1? (p200300f6ef02a900c14ba9e1ff7d55a1.dip0.t-ipconnect.de. [2003:f6:ef02:a900:c14b:a9e1:ff7d:55a1])
        by smtp.gmail.com with ESMTPSA id o14-20020a05622a138e00b002f335c3dbf2sm1689873qtk.37.2022.04.20.05.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 05:29:53 -0700 (PDT)
Message-ID: <bcb20a4bc1b877506596341aebfea28b628694b2.camel@gmail.com>
Subject: Re: IIO: Ensuring DMA safe buffers.
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, catalin.marinas@arm.com
Date:   Wed, 20 Apr 2022 14:30:36 +0200
In-Reply-To: <20220419121241.00002e42@Huawei.com>
References: <20220419121241.00002e42@Huawei.com>
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

On Tue, 2022-04-19 at 12:12 +0100, Jonathan Cameron wrote:
> Hi All,
>=20
> For a long time IIO has been making assumption that
> ____cacheline_aligned
> was sufficient to ensure buffers were in their own cacheline and
> hence
> DMA safe.=C2=A0 We generally needed this for all SPI device drivers as
> many
> SPI ABI calls can pass the buffer directly through to be used for
> DMA.
> Not that regmap doesn't currently do this but it might in future (and
> did
> in the past).=C2=A0 I can't remember the history of this well enough to
> know
> why we did it that way. I don't remember the pain of debugging random
> corruption caused by getting it wrong however...
>=20
> However it turns out via
> https://lore.kernel.org/all/20220405135758.774016-1-catalin.marinas@arm.c=
om/
> =C2=A0
> "[PATCH 00/10] mm, arm64: Reduce ARCH_KMALLOC_MINALIGN below the
> cache line size"
> discussion that there are platforms where this isn't true and need
> 128 byte alignment despite a ____cacheline_size aligning to 64 bytes
> on
> all ARM64 platforms.
>=20

Oh boy... Here it goes my 5 cents on this

> (I should probably have known that as the platform I support in my
> day
> job has 128 byte cachelines in L3 - however it's DMA coherent so
> that's not a problem).
>=20
> The above series also highlights that we can do much better anyway on
> some platforms
> using the new ARCH_DMA_MINALIGN (currently it's only defined for some
> archs but
> after that patch everyone gets it).=C2=A0 We should be safe to use that
> everywhere
> we currently force ___cachline_aligned and waste a little less space
> on padding
> which is always nice ;)
>=20

The above series actually made me go an try to have some more
understanding on kmalloc. I might be completely wrong but AFAIU, for
our typical case, this won't matter much. Typically we have something
like:

struct something {
    //typically we do have more parameters
    int val;
    u8 buffer[8] ____cacheline_aligned;
};

I thing the idea is to replace this by the compile time annotation
ARCH_DMA_MINALIGN which is 128 (for arm64). That means that
kmalloc(sizeof(struct something)) will put us already in the kmalloc-
256 cache (right?) and then we will just get 256 aligned objects as
this is a power of 2. The point is that as we normally do the compile
time annotation we should still have the padding bytes as given by
sizeof().

If I understood things correctly, the above series is way more
beneficial for smaller kmalloc calls (without annotation) that won't
need the 128 align constrain or for structures with zero length arrays
(annotated with ARCH_DMA_MINALIGN) where kmalloc() calls end up in the
kmalloc-192 cache.

Does the above make any sense?

That said, I think that we also need to be careful in
iio_device_alloc(). Ideally, to save some space, we only align to a
real cache line (padding between iio and private struct) and not
ARCH_DMA_MINALIGN. Would it be enough?

> Given we have no reports of a problem with 128 byte non DMA coherent
> platforms
> I don't propose to 'fix' this until we can make use of the new define
> in the above patch set.=C2=A0 That is going to make a mess of backporting
> the
> fix however.=C2=A0 I'm wishing we did what crypto has done and had a
> subsystem
> specific define for this but such is life.=C2=A0 We will also want to be

We do have IIO_ALIGN but as we just found out is wrongly defined and
was never enforced. Maybe now is a good time for enforcing it :)
>=20

- Nuno S=C3=A1
