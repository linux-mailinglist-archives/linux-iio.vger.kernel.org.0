Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC59B3280D1
	for <lists+linux-iio@lfdr.de>; Mon,  1 Mar 2021 15:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbhCAO3J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Mar 2021 09:29:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236386AbhCAO3D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Mar 2021 09:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614608856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IXCBRh2c+qBG4FYkxXs4egkrr88I5IuLhf4mFWnbMs4=;
        b=NaGHHOgqKWRRoi8mjIzdCknQ9aRwrbiWLrztxl03z23n42WU0sidlhCuthNDYizyScm8+y
        a/Vu1w2sYyoXG357K5V8hubEUgcsIZfJuRmaqVUHo+pQUnwZTFd6SpUMBtT/KG1GN6MAgz
        qSgGsl7oRQSCzSTpvIxBiy67WnT1e/o=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-Vmnr0-oFMmGUu24Bz7SdGA-1; Mon, 01 Mar 2021 09:27:34 -0500
X-MC-Unique: Vmnr0-oFMmGUu24Bz7SdGA-1
Received: by mail-pj1-f70.google.com with SMTP id gv10so88744pjb.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Mar 2021 06:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IXCBRh2c+qBG4FYkxXs4egkrr88I5IuLhf4mFWnbMs4=;
        b=VSAd00LAwx+tMnzkeEnu7d5RkZ/Le/Pi1pjxuTG3J8449IAXAEll1ZEeiMpDuqatTP
         8p+RY6lEIYDc5VO1GTHu/CqFFhzlxIumj3ZDGdKd949lBa/1n7cdOG+is/BwUbjmE5f7
         oaAWznJTx4WU8+sSzetcGorbTxmMuVIAyBDfH3o3svAKZrV5fi4wdKwh9bG1RCdvSE+X
         OdtaruTURHUkcZ9O1Cq0gliagr5pR9L26idKcfZrHTdBi2MXvc70IiBij32aB3VVRjkY
         VcbV4uGrgAUg81mRWlV0B0TcWBLhMcwc4a/50X0ipupE01/iZ56RSBHs4OL2571b7DnK
         3A9A==
X-Gm-Message-State: AOAM530ZJAu6xw4uYLoxcOqpS962cYivp5+nxbkVRIo7z0ia+8YuwZiJ
        ORrjIrwNbgIlwyjHEUFaJ1pGNNDcRTCqHhpJf9I1tJaTa/s74LQxTNEzpNmK3eYe5KXZWYcrAXv
        giWj2rzzMGLIXicT1S+aFHmmR6UYFvN2vV10q
X-Received: by 2002:a17:902:9b91:b029:e2:898c:d721 with SMTP id y17-20020a1709029b91b02900e2898cd721mr15893414plp.32.1614608853362;
        Mon, 01 Mar 2021 06:27:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1RhN7M5F9TIKLkoUngTtVB6Hn2M7hQyWdTc6rjiMIGVlZ9uKlnDsBGo49gjLo70zIi6BUT0oKxAcpEbauCeg=
X-Received: by 2002:a17:902:9b91:b029:e2:898c:d721 with SMTP id
 y17-20020a1709029b91b02900e2898cd721mr15893396plp.32.1614608853104; Mon, 01
 Mar 2021 06:27:33 -0800 (PST)
MIME-Version: 1.0
References: <20210228012643.69944-1-ronald@innovation.ch> <20210228012643.69944-4-ronald@innovation.ch>
 <CAHp75Vfd6wZwg9HWJoEwvzAAZR=8K2zDWbz4FZfbbrJBvZS4yQ@mail.gmail.com>
In-Reply-To: <CAHp75Vfd6wZwg9HWJoEwvzAAZR=8K2zDWbz4FZfbbrJBvZS4yQ@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 1 Mar 2021 15:27:22 +0100
Message-ID: <CAO-hwJLXAHvjYKxu8pyqMPCNgMrN-H8bGWudVqCaRFnWODHPVQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] HID: core: Export some report item parsing functions.
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     =?UTF-8?Q?Ronald_Tschal=C3=A4r?= <ronald@innovation.ch>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 1, 2021 at 3:18 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Feb 28, 2021 at 3:30 AM Ronald Tschal=C3=A4r <ronald@innovation.c=
h> wrote:
> >
> > These are useful to drivers that need to scan or parse reports
> > themselves.
>
> ...
>
> > -       while ((start =3D fetch_item(start, end, &item)) !=3D NULL)
> > +       while ((start =3D hid_fetch_item(start, end, &item)) !=3D NULL)
> >                 dispatch_type[item.type](parser, &item);
>
> > -       while ((next =3D fetch_item(start, end, &item)) !=3D NULL) {
> > +       while ((next =3D hid_fetch_item(start, end, &item)) !=3D NULL) =
{
> >                 start =3D next;
>
> I don't see the full picture, but perhaps you may also introduce
> for_each_hid_item() or so.

Same here, I don't see the full picture, but I would suggest to not
export those functions at all.

From 4/5, I can see that you are using them in
appleib_find_collection(), which is only called by
appleib_add_device(), which in turn is always called with a parsed and
started HID device. Why can you not rely on the core parsing and
iterate over the already parsed hid_field?

Cheers,
Benjamin

