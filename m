Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDAE1C80D0
	for <lists+linux-iio@lfdr.de>; Thu,  7 May 2020 06:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgEGEXW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 May 2020 00:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbgEGEXW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2020 00:23:22 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DD6C061A0F;
        Wed,  6 May 2020 21:23:22 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u10so1545950pls.8;
        Wed, 06 May 2020 21:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6G+6eM+WUd8jnoXez9hLJ5VPYRmDs4q7SM6DwmQSnA4=;
        b=L9JVeMJqgEQBzurgIqXdi3L9TtEo0pjexujwUfiAFa1SI6mhcCSpGS/l35i+s6+o74
         2fQykf8CgPob+2Ha8noFcvBGOyYTRa3SxkLPC3tuqNh9nNQTk8tvBGykuRKpvRqNjbbQ
         AbBEfqHEbCSbpKO0KTyk/2E5t907BFOMx+a8Te+gtqMD99dg6iNafZoyoBAON3J2meKl
         gPi2rZYIhTuEnzLjXH8yDRsKMv4h/PsufacBHXtr7D3ivThthxaRlG+IfI3VB/sfmOBj
         2Cmbm8iellbywzHSGnlmK+T+7VmCaPAljBChuo6geyQjReshvrIKCjuEGsv4hU0tu1p+
         oWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6G+6eM+WUd8jnoXez9hLJ5VPYRmDs4q7SM6DwmQSnA4=;
        b=NcKUH67/gfZZnhAsYHyvTEqJq9rLwVuC5XzFhFkodeIDm8fSTjY93Pzl3Xn+qxljq2
         NB8QwG7GuoLzXeQoEVTxLeHLOPs0X/95N/RxOyfTVINfqRYEnmkmNFIBVASMSxvB+Fel
         kzutREfIaE1qii43ImLV3UViMQMdh8AUQX7EwLeYOgeQtdxdY5Jik89yoZ016uhIsDJR
         CExVs8TadJYqpePEi3JK4xV087GyKQMgpReoMKjL+knYwENxw3CoxS+HM179woaNI21U
         aShmsgEhfhRgyVl1IQz3gCRzlGOsJl3hOkVk2qwQ1bm6a+0VJN6EiJ3Oq1+354BNfYeb
         kbag==
X-Gm-Message-State: AGi0PuadYi09YDNuedcTz4eRndwV2L+PW332nTyNRg1NzW06eQM3mB1T
        Z+2fhu6g0Bxc+ky1z9frI+s=
X-Google-Smtp-Source: APiQypKfVQJJDaMh/+EdjgY2icxQ8eu1eW9hG6nbY1dwgWodpmUB8r4EHl2DChcWe82TXYKcYbfrUw==
X-Received: by 2002:a17:90a:32ea:: with SMTP id l97mr13148734pjb.50.1588825401246;
        Wed, 06 May 2020 21:23:21 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id x7sm3461022pfj.122.2020.05.06.21.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 21:23:20 -0700 (PDT)
Date:   Wed, 6 May 2020 21:23:18 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Input <linux-input@vger.kernel.org>
Subject: Re: [PATCH 2/5] input: misc: bma150: Conditionally disable bma023
 support
Message-ID: <20200507042318.GD89269@dtor-ws>
References: <20200503172206.13782-1-xc-racer2@live.ca>
 <BN6PR04MB0660B420EFA83668BBF4F315A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
 <CACRpkdb3kG=7SQg8RGh1F=8=_mivV6p_zxpodFT=M-f3PmiyYQ@mail.gmail.com>
 <BN6PR04MB0660BA0E181869F866594E98A3A50@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR04MB0660BA0E181869F866594E98A3A50@BN6PR04MB0660.namprd04.prod.outlook.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 06, 2020 at 08:46:12PM -0700, Jonathan Bakker wrote:
> Hi Linus,
> 
> On 2020-05-06 5:46 a.m., Linus Walleij wrote:
> > On Sun, May 3, 2020 at 7:22 PM Jonathan Bakker <xc-racer2@live.ca> wrote:
> > 
> >> The bma180 IIO driver has been extended for support for bma023.
> >> However, this could cause conflicts with this driver.  Since some
> >> setups may depend upon the evdev setup, disable support in this
> >> driver for the bma023 only when the IIO driver is being built.
> >>
> >> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> > 
> > I would just fix this with KConfig instead, like add mutually
> > exclusive depends on these two drivers.
> > 
> > Set this input driver as:
> > depends on BMA180=n
> > 
> > And the IIO driver as:
> > depends on INPUT_BMA150=n
> > 
> > It's a rough measure but this input driver should anyway
> > go away.

Isn't the driver handle more than bma023? I see bma150 and smb380 ID's.
If we go Kconfig route we will be disabling it for them as well when IIO
driver is enabled.

> > 
> 
> Ok, sounds good to me.  If I include a patch removing the input
> driver, can I just drop this patch entirely?

> 
> The only in-tree user of the input driver (based on i2c ids) is Intel
> Mid.  Not sure what the kernel policy on dropping drivers is.

Do we still support this platform? I'd start there.

Thanks.

-- 
Dmitry
