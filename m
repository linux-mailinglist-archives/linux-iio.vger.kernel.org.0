Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432673D486D
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 17:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhGXPFp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 11:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhGXPFo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Jul 2021 11:05:44 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0892C061575;
        Sat, 24 Jul 2021 08:46:15 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h2so7264550lfu.4;
        Sat, 24 Jul 2021 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sffnf9T+HDaeklR+SXFRloM02OtNxtUSj/wfngSo6ps=;
        b=axSiGC6W9WCnQx3YXyXZJ1Qoy1I1rjTHPv9m0VNZsi48GVA+8oIkuGSP2KnCQcZsvw
         qZht948bYXEDAI03qizSGACxNipG4KkJgVAL290PXyKKKe4BCCtJY5mBbdzC1hA/d4mj
         M4NmDEF0bN+6uv5lP7+7BLucfQkmNJ68Lkz1+AAqo/81RWZs36lyFfzrj8kH224zBK2J
         p6PtkBFYCMoe8kR7gW6NVKdDzmjxEVT57XvK4ufnlwy/viKy/s1lRr+aJ2fUMbiqesHj
         kbJg4RIc094t6PKYXVxC8DwQbBPsrv335GmkbtQUqQB+4jxBImKt1PKW7s3AvSRfQUin
         vfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sffnf9T+HDaeklR+SXFRloM02OtNxtUSj/wfngSo6ps=;
        b=S+CTwUPYh64ORlCSFiXRHi98UoSIisyfnEWGTv6fVSM330k7xjminsTn6yWS4kzWfo
         zbi0UVpf84w3ogmQb06KWPeWWv9FR2SeGLWjg2nDo0Ye2UTugJGcRuN0XQhnEN3gW3TU
         IFmZ5HeEybqJBUAvlknkIAiBG68cTbtB8pWDWJoHlSlZAo7QLHfc3dTRow81A7OShEYV
         8nvt2LMn4Pvj+1pvIRKhV5ulweUNjJJn1DJou2JRoIoGP4RBfUZRt40rBp+0AbikZbvD
         XFWwp4qsbKbOHIe6OY1bP3PlI41GKT/m1Gsp1FXrVmTus/M4hMw+RHxYPMvOenlX/Myi
         lYMQ==
X-Gm-Message-State: AOAM531YkrW5nX1+Zs0K5BFiG/9gbyh8idya0TvG3FJZwsyd05EA6/52
        +iDqOYZd8DS8PJabSTOCH3+V3BWqLD6EEV9lmd8=
X-Google-Smtp-Source: ABdhPJw6Opk+Xec3/M1Gz6JkYtTn4AePvHDFW8tyCf9VNFToRaAHZcdccNgIku0kGKz7QXT1CJf+Lkc86sWw97BKE1I=
X-Received: by 2002:a19:c312:: with SMTP id t18mr6901214lff.354.1627141573558;
 Sat, 24 Jul 2021 08:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210722062155.32998-1-puranjay12@gmail.com> <20210722062155.32998-2-puranjay12@gmail.com>
 <20210723172902.00004151@Huawei.com>
In-Reply-To: <20210723172902.00004151@Huawei.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Sat, 24 Jul 2021 21:16:02 +0530
Message-ID: <CANk7y0g9c8BMdbTe2LcLwcc1ZYtFZL+mK5y4AxMF_eXGWDxb8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: accel: Add ADXL355 in trivial-devices
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Berghe, Darius" <Darius.Berghe@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 23, 2021 at 9:59 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 22 Jul 2021 11:51:53 +0530
> Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> > Add ADXL355, a 3-Axis MEMS Accelerometer into trivial-devices.yaml.
> >
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>
> Hi Puranjay,
>
> So, a binding should include (as well as we can) all hardware elements,
> not just those currently supported by the driver.
>
> This particular device has two interrupts + a dataready signal which is
> effectively another interrupt. It also has dual power supplies.
>
> That makes it a rather non-trivial device from the point of view of
> bindings. Hence, please give it a file of it's own and also document
> the interrupt and supply elements.
>
> Jonathan
>

I will add a separate file in  the next version.

thanks,
Puranjay

> > ---
> >  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> > index 8341e9d23..0097d6e81 100644
> > --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> > +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> > @@ -41,6 +41,8 @@ properties:
> >            - adi,adp5589
> >              # +/-1C TDM Extended Temp Range I.C
> >            - adi,adt7461
> > +            # ADXL355:- 3-Axis Low noise MEMS Accelerometer.
> > +          - adi,adxl355
> >              # +/-1C TDM Extended Temp Range I.C
> >            - adt7461
> >              # AMS iAQ-Core VOC Sensor
>
