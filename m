Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D663CD1FD
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 12:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbhGSJwu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 05:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbhGSJwu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 05:52:50 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D866CC061574;
        Mon, 19 Jul 2021 02:40:12 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d9so4882191pfv.4;
        Mon, 19 Jul 2021 03:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Lu76TUF5t5P7dhULSWQL1jOmPG4hRwR7T2VCuhQQuSc=;
        b=s/e2GR87SdKlpiDUPcwZ+dquU6uA39GKut+j1/4HcntzhbYi3Z7/E8VVQDfxiBGt9s
         TOwP3W4uDRwEkYNx6sLQxz8/xmY+FwFbW3nWxk5Mt7SQrqefrvXHDJ/Dh6ZewK3qwCnx
         RtmyF/EPz0wUZLHw6PxG4QkLRem5eWFeAOnNlkMeOi4zJsrom0YszNhftGIAD+VvcCf0
         Whs77pdZvsdc7xqM2ljwWgkL4ERK0QfG1yKw5x6xYpVh6J7hiaY7Fzb20VKrKUzNHoMn
         oJ1OHSrvqWYvh787wWCiR9PfR5JIwFds1prNGj4qV7QJpoDGSRkTVNLJhVF9atqHui7i
         p12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Lu76TUF5t5P7dhULSWQL1jOmPG4hRwR7T2VCuhQQuSc=;
        b=i/25vCHiK8fQoJrlZoflHnCHBpCZ7JcsJNxUQNWZ1pRarvROAbyT2gnFofXImcHDzK
         HbX1WynWQN76Yhn0/lH5nl/Yvwncb+1cBhZ6bsz4jdC9PiazPRzCMEtpRtTQAIYSTkvG
         3rZWrfUHIvXXU/b/IvKgpyszUkB5VHCXvgEmuLW5u+CSTSwQHGc2nFk6MPTUQrGia9jT
         zmdkvjOhEEl8DOA3svEasvrDcKHtPpH4a9f+raZQi3n0mf6+txMswXFxxUx1YNwphlEh
         igFPSUaHedr083x6+xlpZfLKAzUZJBTgp4aSD2c4Uhd4wC3/f3G9pFl/ZgIol2RVyZ6W
         gKiQ==
X-Gm-Message-State: AOAM530Ddxn3wh8AiTZjlhM4qyJhZ9yDmQJqdDBffmFV89vwWhZBMNlQ
        /3R+LfJxtGmzhganqEgwMnhnI0i5vUB4y5P2h1nmQ5QYCKQK5pyx
X-Google-Smtp-Source: ABdhPJyc6W2WqVVRhAqL8WPMeFs3lJRq2sffzWDsBMKIVXyG30vBCtTy1sl0G9+nn7MncbPvQs7tLgVu8y17tvuavIE=
X-Received: by 2002:a05:6a00:9a5:b029:30d:fad7:4515 with SMTP id
 u37-20020a056a0009a5b029030dfad74515mr25338538pfg.28.1626690808507; Mon, 19
 Jul 2021 03:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20210715141742.15072-3-andrea.merello@gmail.com> <CAHp75Vf_Og2wjRy2j0gC37DgR0x9B_F5iSUj8VOtWkhWjgiOag@mail.gmail.com>
 <CAN8YU5NKGLO6a4wqaW07NAU-OdsdBohoXzMCBcskaFsCRtrGhw@mail.gmail.com> <YPF97IvnlUDtIHar@smile.fi.intel.com>
In-Reply-To: <YPF97IvnlUDtIHar@smile.fi.intel.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 19 Jul 2021 12:33:16 +0200
Message-ID: <CAN8YU5MMtP8M7jTDP2S3EBM-PM1dsxVLEgGyB-3BtY5xUF+JTQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> > > > +               for (i = 0; i < 4; i++)
> > > > +                       vals[i] = (s16)le16_to_cpu(raw_vals[i]);
> > >
> > > Extract this to be a helper like there are for u32 and u64.
> >
> > Could you please point me to those helpers? I don't know what you are
> > referring to.
>
> Read include/linux/byteorder/generic.h to the end.

I realized that implementing an helper like the other ones wouldn't
work in this specific case: I'd say a reasonable helper would take a
ptr to a s16 as its destination argument, but here we are assigning to
a int vector; so our brand new helper would be of no use here.

What I can do is to implement a macroized helper that would have no
issues wrt ptr type; I guess something like this:

#define le16_to_cpu_signed_array(dst, src, len) \
({ \
    size_t __i; \
    for (__i = 0; __i < len; __i++) \
        dst[__i] = (s16)le16_to_cpu(src[__i]); \
})

What's your opinion here? should I go with something like this or do
you prefer to let the open-coded implementation stay in this specific
case?
