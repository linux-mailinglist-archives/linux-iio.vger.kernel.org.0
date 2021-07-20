Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AEC3CFD00
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jul 2021 17:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238002AbhGTO0s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 10:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239559AbhGTOPU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 10:15:20 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1809C0617A7;
        Tue, 20 Jul 2021 07:52:42 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s18so22727193pgg.8;
        Tue, 20 Jul 2021 07:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P7LMpW5XzWUvxMXqbWYSmu2pjZJM72dfTIn65I782GM=;
        b=n+wWRzMYO/1gyDJXN5G/60cdAWJH5Yr/7yj6VsIKzZJnyzhbYVVBijDepJmljmhzTJ
         h5zBbl83UFS38rCqoSZOLNW7O4jyqBXPCgY8UbJ/ltHylbX25bEBKrKBCiKjIVvpKvml
         IzK8oARt0PMAYUBsfsjK9GUd0Y+UYJrDWmP1DeVMZjrlsiiUfDM4pbhTGx1oGulY7Nbo
         QQyHBn0ADzUMxarjYtZkw0nI+IT6qweW2fOFudck6UEXWCxSEXLlqIYmbp4kpp9zJAyX
         oPTw+BRvKSgFTcYbN7wZwkVN7cOnTAcNZM44NOo2yi2j9RnTY9XunRB2aBopy99kxg+r
         vmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P7LMpW5XzWUvxMXqbWYSmu2pjZJM72dfTIn65I782GM=;
        b=pJPMKmQIH1/yUz4SAxbDSJlydT7n2uZUGKeNrOA4CaYn12VDQlywCNwNAfnr5+HEIg
         0UERl/O+6pDMq20KxOoIAQb4DcZx6xyM2XnvDx4LH7YLDG1LeUgZ2XRNq4L3gMBIVGuU
         2VrbVSrBwy+2sK9lJI6T3zQ0N22IKuZxh99dF8gOTOfuS7iwxoR+sz1QGs0AyLT4kB1g
         04phXQE37Gb+5I8kGny9pbHqN22YOx3NFBcWoSpb8UmFsc8iz8Togmun8IdTPpkKA2B9
         PicxgoSO9rO7lrepfUVjHsRJmqJxSnoI/zrE7LS9Yp/SNk+R+XPzPlp/lKoUFR7S57Iz
         ar8g==
X-Gm-Message-State: AOAM532myAdhvCDTjd819pHu79dfn0UAmblSscRv1iu3FtQA2Z4586vZ
        +nF/Lk2wJBL1Xj58g+4a5Ky5/clHgyIfqPmqi+s=
X-Google-Smtp-Source: ABdhPJxVf49szxJIXAodhwcL8PVRy/A2HS2ce+aYz72ayuXwkJizuBtMsvwgt56shChZm6zOtQCG0Qz20cdwt8yx8Tw=
X-Received: by 2002:aa7:8a04:0:b029:332:950e:d976 with SMTP id
 m4-20020aa78a040000b0290332950ed976mr32334962pfa.40.1626792762291; Tue, 20
 Jul 2021 07:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210716114210.141560-1-antoniu.miclaus@analog.com>
 <CAHp75VcNhJrp4YGZQu1ZB2J4ARtuT2T2p-72H1qn4F+KtZDVoQ@mail.gmail.com>
 <CY4PR03MB3399083DDE3A03C55D3153FE9BE29@CY4PR03MB3399.namprd03.prod.outlook.com>
 <CAHp75VcN2fjVDMfkpgyE2tqu=21ku4KBowNDKJxvpbKzwuEPew@mail.gmail.com> <CY4PR03MB339939479450FC5F3E8172D39BE29@CY4PR03MB3399.namprd03.prod.outlook.com>
In-Reply-To: <CY4PR03MB339939479450FC5F3E8172D39BE29@CY4PR03MB3399.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 20 Jul 2021 17:52:02 +0300
Message-ID: <CAHp75VfS64KmnLwiRB9+oFne+LD5+O5PSSQDD=9gnAg=zVeMEg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] iio: frequency: adrf6780: add support for ADRF6780
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 20, 2021 at 5:33 PM Miclaus, Antoniu
<Antoniu.Miclaus@analog.com> wrote:
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Tuesday, July 20, 2021 5:08 PM
> > On Tue, Jul 20, 2021 at 4:17 PM Miclaus, Antoniu
> > <Antoniu.Miclaus@analog.com> wrote:
> > > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Sent: Friday, July 16, 2021 5:53 PM
> > > > On Fri, Jul 16, 2021 at 2:43 PM Antoniu Miclaus
> > > > <antoniu.miclaus@analog.com> wrote:

...

> > > > First question is why not to use the regmap API (I have heard it has
> > > > gained support of 17 bit)?
> > >
> > > Initially that was the plan, but after this patch:
> > >
> > https://urldefense.com/v3/__https://github.com/torvalds/linux/commit/41
> > 91f19792bf91267835eb090d970e9cd6277a65__;!!A3Ni8CS0y2Y!ptUV0YC2nfD
> > 6AdH_y5U0ziyELl4B9pDL0ubkdpFHFtrFNE_NqUS_TWm_gE-SlHV315Ak$
> > > the custom write formats for regmap allow the read only via cached
> > registers.
> > >
> > > Therefore, I preferred using spi transfers for write/read to/from the
> > device.
> >
> > Not sure I follow you. That patch is upstream. Does it prevent you
> > from switching to regmap SPI API?
>
> It does not prevent me from switching to regmap SPI API.
> It will prevent me from using regmap_read to read directly from device.
> https://github.com/torvalds/linux/commit/4191f19792bf91267835eb090d970e9cd6277a65#diff-3e0b7d2f0a55adb6573693a514cb8024a81a55da848cb22632ab5fd4dd6dd4e4R39

How? If it's the case it's a huge regression in the API and must be fixed ASAP.

-- 
With Best Regards,
Andy Shevchenko
