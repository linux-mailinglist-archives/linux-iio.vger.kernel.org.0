Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6569927C8D
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2019 14:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbfEWMRD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 May 2019 08:17:03 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40595 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfEWMRD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 May 2019 08:17:03 -0400
Received: by mail-oi1-f193.google.com with SMTP id r136so4173491oie.7;
        Thu, 23 May 2019 05:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vytJJSYekkSiyBVgQQl6qDtWru7tnPiRrubetUC8tio=;
        b=oGq5J7in9VarQ3qZA/gtw8FNzheFvA18Th1kc5LHMflKGoZSBHjURWW95hM96mh9Ri
         /573ejEL4w9FAOwJzaBRp9nqUMnsMr3DkV30CAK4ptefGTPBw0mELOWyK6zwvp8EJody
         W7TinychtA5oT7z17RShhb5+uPEn59OInqOd4mDGADwTUxMZE8pg2MOSyRpwRRxjdab7
         owvq6suGoFOt/KrXs3tIPPGz/3QghFkLjHWvCJiylFq9+KbUEqD71T5A2W0EvvU0oI0a
         3kwpu0C2YAtC7CDycowc8s0FncwJ/7BsEQNVM5ZiPQpyfb3C9K9FHwZskySnLZ8ThdOe
         C4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vytJJSYekkSiyBVgQQl6qDtWru7tnPiRrubetUC8tio=;
        b=mn9PV/fTV4ekZbUK13cQ0CU5Ect0UxBgrgRTNLHEZO3ZjPAX3evUbgTLWSKnwJrtR5
         JMOUTGjscV0wVATbRLL3wbyj/wyeRKmEPAp7RW3F7ljC6xlDZLmWyz/G/RMKUwoDzQwI
         RjYv1odJpfVO2kd4cY7HRSBmEAxlE9JIpu1yRcpp0etAUvjx4fpc1bkHk/TSntl74CY3
         /iews7LA1Zj8oGf7SmCBgy/AZZJhjyMiFBu2zecs74JMDmS2A4O04g2IiU/ALhjxuE3d
         LOZsD9FyONwGiShHVD1wjDfNOg4xuOpexlAaq6wgWT5KzbhLZ9b0zYuQg/HaCxWATmW0
         PRMg==
X-Gm-Message-State: APjAAAU9UaC1U9eNbAOjrlI4IEm4PsbB7DNsvh7BKcNLTtwUl69TXDau
        OcvS6rIHSDZRsObO4r7LRhLBhmWw24v8OWIsluk=
X-Google-Smtp-Source: APXvYqxdaJFz8CQWrBavxJvivRCQC6gaDYTO8asCojo3qV5Yha9gV5fFG1CAvh/5FazolhY2fOfLE+cHl4r9PJLyDWI=
X-Received: by 2002:aca:6208:: with SMTP id w8mr2607316oib.128.1558613822839;
 Thu, 23 May 2019 05:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <1557759185-167857-1-git-send-email-adam.michaelis@rockwellcollins.com>
 <1557759185-167857-3-git-send-email-adam.michaelis@rockwellcollins.com>
 <20190514182311.GA31516@bogus> <20190518100753.39b438cb@archlinux>
In-Reply-To: <20190518100753.39b438cb@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 23 May 2019 15:16:51 +0300
Message-ID: <CA+U=DspGJpVvo05HspwFVXvbdBiF1HUzYji0o3pWO4j_Wf7CHw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] dt-bindings: iio: ad7949: Add adi,reference-select
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Adam Michaelis <adam.michaelis@rockwellcollins.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <michael.hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        charles-antoine.couret@essensium.com, devicetree@vger.kernel.org,
        brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Stefan Popa <stefan.popa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 18, 2019 at 12:08 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 14 May 2019 13:23:11 -0500
> Rob Herring <robh@kernel.org> wrote:
>
> > On Mon, 13 May 2019 09:53:03 -0500, Adam Michaelis wrote:
> > > Adding optional parameter to AD7949 to specify the source for the
> > > reference voltage signal. Default value is maintained with option '3' to
> > > match previous version of driver.
> > >
> > > Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
> > > ---
> > >     V2:
> > >     - Add some defines to reduce use of magic numbers.
> > >     V3:
> > >     - Re-think usage of device tree parameter to focus on the
> > >     actual reference sources instead of the raw hardware
> > >     configuration.
> > > ---
> > >  .../devicetree/bindings/iio/adc/ad7949.txt          | 21 +++++++++++++++++++--
> > >  1 file changed, 19 insertions(+), 2 deletions(-)
> > >
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> Looks fine to me as well. Analog review awaited before applying.
> For reference
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

CC-ing my work email

Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

>
