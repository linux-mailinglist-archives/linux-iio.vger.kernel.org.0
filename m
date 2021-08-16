Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7993ED469
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 14:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhHPNAD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 09:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhHPNAC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 09:00:02 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDC8C061764;
        Mon, 16 Aug 2021 05:59:31 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id js7so9185890qvb.4;
        Mon, 16 Aug 2021 05:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=G+0eo8uBciZZ75lMpCYVoliToSNojQPxAZ9Nw5b+SJ8=;
        b=orP6XdoARpEigMxUeWDxZuA9zCC+uW/v5mMLzo5b2heITGIGxlzoeu6hnKIlFujv7p
         fHN6eYzQlulZa3nKCEh5So3+w1cPm+8Zq/8gxJ9JaaP5HZzq+J/s4MFgc6EFvgScZbi4
         UdlU/BjQsrD/b0OvK8Wtel+ysj8nqqigPrMXIK8AbsJc2ttcqZShas3sxXPizfrCqRP1
         uxQ/++qlPaI3NdTlTQ2zxNkI6+J5ZwnlFk+7JUTKawhRoxHQ6lx0gZ3rG64iQ+LAxOXk
         K0E8mABcCXnoNWfvIohjWK8Ft0hzbxARQbqCc5vePZTuJjgFsUO1EgPjVci1yJC643p+
         H79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=G+0eo8uBciZZ75lMpCYVoliToSNojQPxAZ9Nw5b+SJ8=;
        b=bA5oT8X1Dx83esLx79v1jnxfmKzcR77XULOjkkyaLEoOC8n5oDA743ctl9qnabk9A9
         /sYu9SDTpgzQkIi7knvBx83Lro/tJtXxT0j0cGTYZomysbbHE0ZyuOMU+NHlC/wT6fZS
         7qHHvqiiBhbMa5UZCVa2pDrk5GnNPXec8mM+ABuCvMrVupzO37TeiuumTh6nzGWSnA/j
         U5pnEQso7fIw5HN1tSaPtE9p852dDCL8qHO1TVYU2QGQxz+en+TXcmju7wgb+p472hF6
         zAvl38E2sQn7i9YxwAAM81opH6D+UjPeiQGYswzo7wiLTAxZh7Vt0HGi8ZM7Dn+50LLz
         IEZw==
X-Gm-Message-State: AOAM530caH+fPBJrubiXWniNrsjiS1FsYMGSMU3bvKnKgZjZsS4SXDyZ
        VLIPNs5yvkqrj05FYyoSw8g=
X-Google-Smtp-Source: ABdhPJzDF4RfmwkRTqf/qKkfp3Xcae0sevuTgFNAlLFe/wFS9ENTHz1pyaI8ebi6O+q6BkHYfgIYJw==
X-Received: by 2002:ad4:48d2:: with SMTP id v18mr15775745qvx.41.1629118770536;
        Mon, 16 Aug 2021 05:59:30 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id n124sm6248823qkf.119.2021.08.16.05.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 05:59:29 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 16 Aug 2021 08:59:28 -0400
Message-Id: <CDKYEMJOURHJ.2U1JRK17FRGD0@shaak>
Cc:     "Lars-Peter Clausen" <lars@metafoo.de>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        "Charles-Antoine Couret" <charles-antoine.couret@essensium.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <Nuno.Sa@analog.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-iio" <linux-iio@vger.kernel.org>,
        "devicetree" <devicetree@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>
Subject: Re: [PATCH v6 0/5] AD7949 Fixes
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
References: <20210815213309.2847711-1-liambeguin@gmail.com>
 <CAHp75VdOMg-7xX+KbdaDt5tduPhorujFwvpMPmdHKMVg=vj2Ew@mail.gmail.com>
In-Reply-To: <CAHp75VdOMg-7xX+KbdaDt5tduPhorujFwvpMPmdHKMVg=vj2Ew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon Aug 16, 2021 at 4:08 AM EDT, Andy Shevchenko wrote:
> On Mon, Aug 16, 2021 at 12:35 AM Liam Beguin <liambeguin@gmail.com>
> wrote:
> >
> > While working on another series[1] I ran into issues where my SPI
> > controller would fail to handle 14-bit and 16-bit SPI messages. This
> > addresses that issue and adds support for selecting a different voltage
> > reference source from the devicetree.
> >
> > v1 was base on a series[2] that seems to not have made it all the way,
> > and was tested on an ad7689.
> >
> > v6 drops support for per channel vref selection.
> > After switching the voltage reference, readings take a little while to
> > stabilize, invalidating consecutive readings.
> >
> > This could've been addressed by adding more dummy cycles at the expense
> > of speed, but discussing the issue with colleagues more involved in
> > hardware design, it turns out these circuits are usually designed with =
a
> > single vref in mind.
> >
> > [1] https://patchwork.kernel.org/project/linux-iio/list/?series=3D51154=
5
> > [2] https://patchwork.kernel.org/project/linux-iio/list/?series=3D11697=
1&state=3D%2A&archive=3Dboth
> >
> > Changes since v5:
> > - rename defines: s/AD7949_CFG_BIT_/AD7949_CFG_MASK_/g
> > - rename AD7949_MASK_TOTAL to match other defines
>
> > - make vref selection global instead of per channel, and update
> >   dt-bindings

Hi Andy,

>
> Same as per v5: is it a hardware limitation?
> It's unclear to me what happened here.

I tried to provide more details in the last paragraph above.

After switching the voltage reference, readings take a little while to
stabilize invalidating consecutive readings.

One option was to add more dummy cycles, but in addition to making
things slower it was brought to my attention that this kind of circuit
is usually designed with a single vref in mind.

For those reasons and because I didn't have an explicit need for it, I
decided to drop that part.

Liam

>
> > - reword commits 2/5, 3/5, and 4/5
> > - move bits_per_word configuration to struct spi_device, and switch to
> >   spi_{read,write}.
>
> --
> With Best Regards,
> Andy Shevchenko

