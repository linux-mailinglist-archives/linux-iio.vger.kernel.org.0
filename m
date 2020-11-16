Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA222B40A8
	for <lists+linux-iio@lfdr.de>; Mon, 16 Nov 2020 11:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgKPKSQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Nov 2020 05:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgKPKSQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Nov 2020 05:18:16 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46C3C0613D1
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2020 02:18:15 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id s25so23604656ejy.6
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2020 02:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TyZ9ZtY9yDgRe9DpEP4oC7xWjfKvJWnIXoJrIOMjIkM=;
        b=PkJTo5hd6B4iKdg2XokVVhnfHJ5+hL8dhjkCk40O6MvB/TmPrYsNzxbomBBjRDtxs7
         KkvzLncB3zORojtr5jzaoii6NbmB6GhDcJG/amMbYdVkwiMuRS1pXvZzybwHdhpbd4dC
         9itDv9Msio9jXMRqlcFCPqBsWCu4sJaSiI33jxyUKvEM/rMRvdjjQk6CDGiqmxTM/aUH
         oz+4wkiRKKUYHaO/wTHE51XLC/Yotd07i4Wvd42QvlhGZ3NZoy+wURsYq1lS+slERM+p
         jjHvKUsJAydn6/zqTjO6oDSLf6XFCjRT2uLUo5Dq6zd5Ap+DBV6Tr4dPB9bzg+LCTpRg
         Ro+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TyZ9ZtY9yDgRe9DpEP4oC7xWjfKvJWnIXoJrIOMjIkM=;
        b=niPOGPbdohT7xYbB5f7NCK9tGNYz7RzdJiMSl+4jBLEAP8hPdJeiiKraV2bTLBTbB1
         XVt65ymADkw47r+TMUo3TJKb2h4XTaD65eIYjF5xQgBqWDk/zO5i0krQJuRYALNHRgD2
         JPP00GZJEZqW5uRWApf3zODdLaWiBmPUn0EfgPzXrYIQ7bapkD3LbTJZXcCBREyTdTn6
         E41fzj0TkgFf1vHYnfGfgpWSVfiMZP3uDCntiGdhZF6nrv4PMpdVbwBM/prm1209wVBR
         s3NGaBtTE1+JJphdIUtuo4RHzBBZJM72ZGd0aDe/AAyAA/el3W2esEEWY3NrcCfA9Fi5
         I7iA==
X-Gm-Message-State: AOAM532jS3OQhpKOU2bgtm/iX+fOrVMVnLDMxVBxC2cqeDJMp+3s2Rbd
        ApXfXzJvyYY5KaQEUJ7cOysT8j7J6hu79f23TuZojg==
X-Google-Smtp-Source: ABdhPJygoICSgX3CQadiHsBppVuoGmBdHFBAMjOVVXiIqIbR5WyB9+LccdJlLTGwq92r/Iov+baiHDPVwImzC0t1oWU=
X-Received: by 2002:a17:906:14d:: with SMTP id 13mr13916968ejh.516.1605521894586;
 Mon, 16 Nov 2020 02:18:14 -0800 (PST)
MIME-Version: 1.0
References: <20201102142228.14949-1-brgl@bgdev.pl> <20201102142228.14949-2-brgl@bgdev.pl>
 <20201114154641.0258f4ee@archlinux> <X7ADFLwEpUHkTiT+@kroah.com>
In-Reply-To: <X7ADFLwEpUHkTiT+@kroah.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 16 Nov 2020 11:18:03 +0100
Message-ID: <CAMpxmJUHiNqKNVDxaWLeDja6huR78u1Hp7JHF_aP5L_UgjYzbg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] device: provide devm_krealloc_array()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 14, 2020 at 5:16 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Nov 14, 2020 at 03:46:41PM +0000, Jonathan Cameron wrote:
> > On Mon,  2 Nov 2020 15:22:25 +0100
> > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > When allocating an array of elements, users should check for
> > > multiplication overflow or preferably use one of the provided helpers
> > > like: devm_kmalloc_array().
> > >
> > > This provides devm_krealloc_array() for users who want to reallocate
> > > managed arrays.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > +CC Greg KH.
> >
> > As this is going into a very generic place I'd like a relevant ack.
> > That file is a bit of a wild west for acks, but Greg seems most
> > appropriate person.
> >
> > So Greg, any comments on this one?
>
> As there is only 1 user of this function in the patch series, you don't
> save any extra code space here, I don't think this is worth it.
>

It's worth it in that the overflow check before allocation doesn't
seem to belong in a driver IMO but is a general check that should live
in common code.

> We are seeing less and less gains from these new devm_* additions, and
> only more confusion and problems with them.  So perhaps don't add this?
> I don't think it is needed.
>

I think you're referring to the discussion on
devm_platform_ioremap_resource()? I would argue that consolidation of
common operations in helpers is rarely a bad thing but it's a
discussion for another thread.

I'm not too attached to this patch - if you think this should be
dropped then fine, but I don't see how the name devm_krealloc_array()
can confuse anyone.

Bartosz
