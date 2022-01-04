Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9DF484348
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jan 2022 15:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiADOYw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Jan 2022 09:24:52 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]:40461 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiADOYw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jan 2022 09:24:52 -0500
Received: by mail-qv1-f53.google.com with SMTP id q3so34461465qvc.7
        for <linux-iio@vger.kernel.org>; Tue, 04 Jan 2022 06:24:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BzxLzg/gYF0FXGkDDU2GvpoFXGjGAa56JIC7qXfQAqY=;
        b=Ss+uAlY1Gf3HP9Wvuy+EU+TT8a1J/jSAV5MmJMbiZgqt0qNLfw7C22dkSUppzyzezw
         6/VU2Py6dHNROUq8lLkVMd9u/pbSmgtJCa+zKMuDVBluqqcPzZJmLkAziDdHDMISngQQ
         FH5wdQuV+J5+wf4v+ix+/XQ4nEE9ukQzD1YHOSO1poWH3aVMu7Dv9GnJcfnPpzbfSkvS
         bmNRvrOfKSIxTszFj6aKuFRVdsjnMIG+r/tMgEkzz5puISWw1V5C6elkBpaqKL1T79pk
         qWcIweoOIOP0ItZRvvuN9rCnfvpSikqLLc+3fkvlIEIELCTx908YWj7VjgSEfHHFGESL
         gy2g==
X-Gm-Message-State: AOAM530IQF2oFlnd5XmSjBK7l5556d6pf2l667GC8WTf2wt3KRvItCEh
        SD8nWAUiBPXvBJSQI6CG+V+mLLRAJASZE0t0RrI6/hj/i2c=
X-Google-Smtp-Source: ABdhPJz6oT2XlGVzH7O+3HDH+wXH/sNY1sb5FfliJr1Zc9U5QNuQ82K1LEFseqb6ahIRe4HhifHscp3dYdGprKvlEyg=
X-Received: by 2002:a05:6214:508f:: with SMTP id kk15mr45292229qvb.61.1641306291307;
 Tue, 04 Jan 2022 06:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20220102125617.1259804-1-jic23@kernel.org> <20220102125617.1259804-2-jic23@kernel.org>
 <CAK8P3a20AatvTxHEXfTpMWD8RJtLbJiTLbhiKJgQrn+KXYG8zw@mail.gmail.com>
 <20220103152444.0e22e971@jic23-huawei> <CAK8P3a0OSU8Pz2=92ZQ2+uOXSoumRMPLEZM1zthsaYuZb162Kw@mail.gmail.com>
 <20220104141601.00005ed8@Huawei.com>
In-Reply-To: <20220104141601.00005ed8@Huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Jan 2022 15:24:40 +0100
Message-ID: <CAJZ5v0iuL34w5t1z5JTMwfYHjb+mBZjpLi+s6B1bwcAV9HyOLw@mail.gmail.com>
Subject: Re: [PATCH v2 01/51] iio:accel:da311: Switch from CONFIG_PM_SLEEP
 guards to pm_sleep_ptr() etc
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Cameron <jic23@kernel.org>,
        linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 4, 2022 at 3:16 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 3 Jan 2022 12:58:46 -0500
> Arnd Bergmann <arnd@arndb.de> wrote:
>
> > On Mon, Jan 3, 2022 at 10:24 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > > On Sun, 2 Jan 2022 09:15:06 -0500 Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > That came up in discussion of the patch series introducing this macro
> > > https://lore.kernel.org/linux-pm/20211216110936.6ccd07d3@jic23-huawei/
> > >
> > > Most of the cases that don't define it as static
> > > also export the symbol for use by other modules so the approach of letting
> > > the compiler detect it as dead code won't always work.
> > >
> > > Exceptions from a bit of grepping are
> > > net/ethernet/broadcom/bnx2x/
> > > scsi/esas2r/esas2r_init.c
> > >   not sure on reasoning behind the file splits in these drivers
> > >   but definitely looks like it we could just merge a few files
> > >   and let this be static + the compiler remove it neatly.
> > >
> > > vs 17 cases where the symbol is exported and more cleverness will
> > > be needed.
> >
> > I don't see why exporting the symbol makes a difference at all, either
> > it is needed in another file or it is not.
>
> Ah. My reasoning was that the purpose behind that patch set (letting
> compiler remove the functions etc when unused) was not applicable in EXPORT*
> cases.  However, I'd neglected that the DEFINE_SIMPLE_DEV_PM_OPS()
> macro is probably useful anyway as those cases would need CONFIG_PM*
> guards if they want to remove the code when PM stuff isn't enabled.

I agree with Arnd that including "static" in the
DEFINE_UNIVERSAL_DEV_PM_OPS and DEFINE_SIMPLE_DEV_PM_OPS is not
particularly useful.

> >
> > I think it would be more natural to not include 'static' in the macro,
> > that is certainly what all other macros like this do, and it's still
> > trivial to add 'static' manually, but impossible to remove it.
>
> IIRC there are other cases like this, but it was exactly this somewhat
> unusual element that made me raise the question in the original discussion.
>
> Paul, over to you for reasoning.  If we are going to change this
> now is the time before they get significant use and we end up having
> to add static to lots of places.

So please feel free to submit a patch removing these "static"
qualifiers from the macros in question or I will do that.

Thanks!
