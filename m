Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53312276AEB
	for <lists+linux-iio@lfdr.de>; Thu, 24 Sep 2020 09:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgIXHhi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Sep 2020 03:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgIXHhd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Sep 2020 03:37:33 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28646C0613CE;
        Thu, 24 Sep 2020 00:37:33 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id q21so2267125ota.8;
        Thu, 24 Sep 2020 00:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0LgeB6IhoKHpPJRdUqtdxcrEPshsH9ulrWgRlYFPb5s=;
        b=R7cwN5O2MUBBBCDXSxHG6WFubm52sa9P3VadV2G153g1zfGBi3uKFXyWIRNbXpCEnP
         Hz2zBx/zoz9KLqIqINRB/7z8FctR9R+BV8im590D/mGuhr2C5+gzK61wgqqjh8NqYKyC
         APK2zr3I9fjunBwjZINK2+ua3dLsih3Z90wCpI/xVYTnp6mb9qKhwUcVdidUumHdMRHS
         s8JVFlCvl4hyoekpnt1TeYxIk0cXEn8yKNkdPrOv8eP1lHVaTJhE/YXIMYJAiKt67/tH
         AoRB7a/4+ZoQmPpUOW8MVFixrhEPmPxCZp+5VbzFOzIHMM+iTObkL5Cs6oi3B8PCVHjo
         1FFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0LgeB6IhoKHpPJRdUqtdxcrEPshsH9ulrWgRlYFPb5s=;
        b=QAAcuxWWn9AB+YMTiPUclKe+2MlbjpCyEbIjYPtKlc0pov9rvlpdhxSPo6GgxKv/i7
         Cd2/BxhvUJ582ZbVBkj/DX8neA+KuGqf4cmV1TuUJgbk1NZEPutNy1MPMNtuX3pnJuB7
         vfRHRlLw0RrCMAkrcu3XLZAUjl7PiM8LmozkC0XTu43xd5ThVam42dBuTl+5MgA3AlP7
         5FxubPLtaLNUjMEubXX5TcG7RV9rCD/7qWM0QWjVjrojcUkrx2jVRbyYvMRbMJGhR5p7
         ecQ+zHOXOTIynzKK1A0gT+vutTDAZqKs/jaapcViJpjhX55Y7B2BeC6AxIgF2Brh2eJz
         uyTQ==
X-Gm-Message-State: AOAM530AIjntUfBQLwyiI2WRF+53bgI6Cu1RDp7IYcX3fyQPbhe5VWoL
        SRXj/Bq1mIeoVJzeOUCwbzRaTN3/z7Nxm4ivERI=
X-Google-Smtp-Source: ABdhPJytolHnKin5qHWsuzdw4wR3D0CV3ghZN/gVL/TGyQAMpHz0QdXRWHeayrfvfXIarb+cu6NLd6rpTZ0LUp8Pvto=
X-Received: by 2002:a9d:7095:: with SMTP id l21mr2326757otj.224.1600933052470;
 Thu, 24 Sep 2020 00:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200922132559.38456-1-alexandru.ardelean@analog.com>
 <20200922132559.38456-4-alexandru.ardelean@analog.com> <20200923213912.05dda5ef@archlinux>
In-Reply-To: <20200923213912.05dda5ef@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 24 Sep 2020 10:37:20 +0300
Message-ID: <CA+U=DsoMGHtGRcBrj-w_sQveKQEWjkfupBSr9QHjTtxbvEQa0w@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: iio: ad9467: add entry for for AD9434 ADC
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 23, 2020 at 11:42 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 22 Sep 2020 16:25:57 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > Add entry for the AD9434 high-speed ADC which is supported by the 'ad9467'
> > driver.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
> Probably want to tweak a few other bits of the binding.
> It has some specific statements about the ad9467 as this is only
> second device to be added.  Need to change to those to "ad9467 and similar"
> or something like that + add description for this part.

Yep, that was sloppy on my part.
Will update.

>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> > index c4f57fa6aad1..0e8da8ee6975 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> > @@ -19,6 +19,7 @@ description: |
> >  properties:
> >    compatible:
> >      enum:
> > +      - adi,ad9434
> >        - adi,ad9467
> >
> >    reg:
>
