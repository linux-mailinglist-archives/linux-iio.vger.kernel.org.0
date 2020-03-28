Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCA31968B0
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 19:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgC1Sui (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 14:50:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43346 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgC1Sui (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 14:50:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id f206so6312746pfa.10;
        Sat, 28 Mar 2020 11:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lJztbg3kquFXjjuv4enGOn4xogqAqaadH1DhetiB26k=;
        b=GrZPc3M+d/HKKXspmK1fowRDcNl5MdRG2JpyOfUUrBlLbSmWUtRH7oneRISr5HwQfz
         kpcdlMdHL6H6WlnPABvm/1eACsodKwSTKjgyVCjNrsIBiQOt4ClpvEIzRbbjBh4lDMF+
         53MSE6kzSA54B/NWJ3tZYF/aGI44Ii7hqXOK0sYsp9hC03hfQhgLgMYB3bfszT0gdGez
         DBdD85JJ5sRyLkYzr4ZpzndawidofqaPj9/5zW3ARPGM5CSi2W7rrqEK1+jYEADfEe1O
         1IEwVWOU+EBzJv0zpoS9pLeq7h+y1CGT3Kbd04oetZygKrxm7TZ64dKxw650Fwh15ckj
         RoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lJztbg3kquFXjjuv4enGOn4xogqAqaadH1DhetiB26k=;
        b=XgS2/9GEpVLoH/Ql8bSMJf6kD2hUYt/bHCphIMv4O2U7JSB8DXEvAGSBQ60K0+Fvtr
         dtpg5ZzMzfhie3M87S/iDWeVOBMsV+5l3xqyvLREtQfYdmvWItmteHrAJ1NBAsj/tC9g
         r5K6cW4R9E6cQ6rDqpoxNpjpvXKe367eNs8KW2z5LoB/JNaViLYwZpWx5ATf8hG0V3i1
         Gh7DHNI1PsyKfugXlmu9hrIM0lpZStmidr/T8eNIb3aOUcufpgeWiAyc/0ayvhxVIYtg
         6TjOUn40+hiB72iq+/YGMn8w5lRPoS3CEnRFQLBDdPjwAbRF/nDwVfRxzpN+lZG2quSE
         wUtg==
X-Gm-Message-State: ANhLgQ2jEdK5ajTCwEfsc+UznE4rRCVcy76jV1Ym46DS5+OSnlZKjnOi
        gWrU3S9fXtbzV79oORoX7540YKbor5mTxiZ9qXw=
X-Google-Smtp-Source: ADFU+vvB3hIe4HEhNOKz/p6x69voaqbgpdkUnlsdlWWjaLUCVYBnfIv/CtD7hZr9iBy+SSZdivtXaesNKI8B2LqdmEs=
X-Received: by 2002:a63:798a:: with SMTP id u132mr5651237pgc.203.1585421436474;
 Sat, 28 Mar 2020 11:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200322224626.13160-1-sravanhome@gmail.com> <20200322224626.13160-4-sravanhome@gmail.com>
 <CAHp75VfauHuAv1Wr=7ga=G+6JOYXuop_oyXiwmQgKeB2e_z=tQ@mail.gmail.com> <20200328144234.081b964f@archlinux>
In-Reply-To: <20200328144234.081b964f@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 28 Mar 2020 20:50:24 +0200
Message-ID: <CAHp75VdTN3W3gsRRgvbKgduzcWFwVsm_K=dahAhE0ymWKBt-BA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] iio: adc: mp2629: Add support for mp2629 ADC driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Saravanan Sekar <sravanhome@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 28, 2020 at 4:42 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 23 Mar 2020 01:32:34 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Mar 23, 2020 at 12:47 AM Saravanan Sekar <sravanhome@gmail.com> wrote:

...

> > > +       indio_dev->dev.of_node = pdev->dev.of_node;
> >
> > Jonathan, doesn't IIO core do this for all?
> >
>
> Nope.  I'm not totally sure it's always safe to do so
> as we have some weird parent structures in some cases.
> A quick grep suggests that we may be fine though, or
> alternatively be able to get away with a set it if not
> already set approach.
>
> I'll take a look when I get some time. It would be nice
> to clean this up.

We may follow the GPIO subsystem's approach, i.e. if there is no node
provided take the one from the supplied  struct device.
But it may have side effects. So, it's completely up to you.

-- 
With Best Regards,
Andy Shevchenko
