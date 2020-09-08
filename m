Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F39260C4B
	for <lists+linux-iio@lfdr.de>; Tue,  8 Sep 2020 09:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgIHHoG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Sep 2020 03:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgIHHoG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Sep 2020 03:44:06 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E340C061573;
        Tue,  8 Sep 2020 00:44:05 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d6so3209906pfn.9;
        Tue, 08 Sep 2020 00:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IVVptDGcawqgCuuuuSn+C2jXTROtX0l06oj8pxRbmDQ=;
        b=oVZ2dDz61KRGBUGd9CGEgxF82wuH/rzVX+9OLfCTI861b+hiYaJpaQ/FpLrdz3i2Zz
         BAen+xFFQex3W9/zOZLw3jIDHCgQPCsaMnYuM6wLgEgvEMKeCy3T2uszHuB8NzbQtuUH
         I0lnBx6aplXO78W76+Jicp8hUG94cqe7qhSC86RwjrmTY9X8RoOOqf16/EkoQNI9meQW
         DFsu95xxQ5WuHU4Th1hZA+JJXolMAX7NJI9d48U5X7TOqMlDYRH8Q+BDGeQrxaTujsLP
         kQPPj67kOpJIytiLMg3d5twjYk1iugvpH4k5Pvh0xz61RjEuKqfhcMVyPzWnUJV7P4yy
         KXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IVVptDGcawqgCuuuuSn+C2jXTROtX0l06oj8pxRbmDQ=;
        b=PLM9/DdBFtOXqSSCzKkg9PoDRcTCEXj3PAmfcesP0WPVyltDktHW9H8e0MYsUE6jXL
         PfbIP4Lh6+8Q8SNe1lLySFzULGSUaksavigSBLCgpG1plSIn21U5VXXKD2I3kVoqpG+a
         OBlmZ5F5rNSy5uJDw+mas4khnYSneoYZU4lBHze3Ud0njipQjsbT70ztNCG+CQMfE00X
         lSH85g7OMK1X4oH0WcG8LB2d6b4pC0G5YbXrjfPnlkAQ8AO46a7Ol9WraHPZ6DpNx2QE
         atBD+lSX4ZRqga0IyTi6rcBfgi9xajkFx2VEGavO3Yr+jWOt+Q559EbWEawMOuibkrBJ
         Hgvw==
X-Gm-Message-State: AOAM532wzY8eNNyWXr7sM04oWiLZlaXYsNHXpZAFd7a8/84uTv3PRPFJ
        JRsT97CfuMiAPEzmUB9zsGwY0jQlmTha7oFK3gJ7PIqbyTLbHg==
X-Google-Smtp-Source: ABdhPJxllos9y1Gn8EfWASnfyzEMYZqQ9haDoiwp/plzKOAUA/WuFCjJRj8iGwXbCw/UjhJ9hb3DRxl5t3F8B7XcfEI=
X-Received: by 2002:a62:838a:: with SMTP id h132mr23492945pfe.72.1599551045021;
 Tue, 08 Sep 2020 00:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <1598259985-12517-1-git-send-email-gene.chen.richtek@gmail.com>
 <1598259985-12517-2-git-send-email-gene.chen.richtek@gmail.com>
 <20200829181157.1b653a88@archlinux> <CAE+NS36j4a6k-JSUbjxzpfbqtE-xMW7qxUUhHPAnc_9V-Lv7LQ@mail.gmail.com>
In-Reply-To: <CAE+NS36j4a6k-JSUbjxzpfbqtE-xMW7qxUUhHPAnc_9V-Lv7LQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 8 Sep 2020 10:43:47 +0300
Message-ID: <CAHp75VcX6P9LOw=1=UgX4tWaxa2_PYPvanpDLG0TE2XzPBatAg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: adc: mt6360: Add ADC driver for MT6360
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 8, 2020 at 9:19 AM Gene Chen <gene.chen.richtek@gmail.com> wrot=
e:
> Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8830=
=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=881:12=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > On Mon, 24 Aug 2020 17:06:24 +0800
> > Gene Chen <gene.chen.richtek@gmail.com> wrote:

> > A few comments inline.  The big one centres on why we can't
> > expose the channels as _raw, _offset and _scale?
> >
>
> I think i have 3 reason for use real value,
> ADC is used to get real value rather than raw data which is not meaningfu=
l.
> And I can decide which formula needs apply according to different conditi=
on.
> Also the junction temperature channel _scale is floating point 1.05
> which is not easy to express.

It's easy to express. Like other values in IIO subsystem which are float.

--=20
With Best Regards,
Andy Shevchenko
