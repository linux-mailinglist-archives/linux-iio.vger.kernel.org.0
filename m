Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B94A450439
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 13:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhKOMRY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Nov 2021 07:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhKOMRX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Nov 2021 07:17:23 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6663C061570;
        Mon, 15 Nov 2021 04:14:26 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id w1so4815426edc.6;
        Mon, 15 Nov 2021 04:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/gFycgLwyUjPa56INw/jotbUAOArA4S3TZPtoDHTkhw=;
        b=nZeqMsC9B+frnRpBsl8HNdu6ipmI1MmXmepnct1stIpOCHPxcsCXTX95VrB7s94Tk5
         FooebXGDsHa3yd6hcCGWnv2KmSa1GACgrH3Dy1lSgMn+ZS5LYW6buTiTgUevPlYH126F
         wP5xQCBQpDVQTQ4i5PWrDIHwiLV47nvEw5lXetKJA95R0/Mk9IBudz3F8riyowSbUonr
         fE/wslenOKtkim5lvroGv8kyVm/76IY3UUEeIazuqSwz1BHuQ7M4hovDPo6Vc1J/2mxV
         VTY/odNC1uRoF2bTqGuszFjPhUhhFF52oBCSznezapiL7ylbS5rhfyPM0Ge/sJQivlG8
         e2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gFycgLwyUjPa56INw/jotbUAOArA4S3TZPtoDHTkhw=;
        b=z49ZrYL+UDA0i6B9nEXXzuE2F6qQGjZPZAuL+OtD5tIv112EKC19ZZ8SBLVLLawmgb
         jz1IOvnECXuXiZVk9oXiMHOil9P42a7IVz13wFANkkwTKpxKp1DzsairPtsWwIYLESu3
         GCi1osAS/uiAi8KcHA1aMdmCdaCSO8h9ANOQT8M8Rjd44ISnCw+9FPdQRN7mRx9KyesG
         xI/F3r1uEUKVMlROq9dNMMY6VUIl0/oH+4Dai9fSxQo0vCwXlmfAfjKe8SddExetR2+p
         AzJonddAdC515iU8tKWiYCeX5kn0w/97jCcwjTlL3P7sromD0ao0T6OPDDNRWyn8Uf/E
         q9gQ==
X-Gm-Message-State: AOAM5306hFhQQfvXE/hn5gtxuAOCOKlyowpCMfxCb3bBXR6mvPqGPoqL
        JufXGENntPZXxvAiu3RlBcMXwhBRpnJ7WmCv8a8=
X-Google-Smtp-Source: ABdhPJzzwWnEWZ1UrwJqyyomeAyCyojDjxz3yveHxH6voyPEbrTiAjqQZOA4Hl39RcdjtqSve9bKe8DBK6BkJ67PTvM=
X-Received: by 2002:a05:6402:2067:: with SMTP id bd7mr6432385edb.240.1636978465314;
 Mon, 15 Nov 2021 04:14:25 -0800 (PST)
MIME-Version: 1.0
References: <20211108210509.29870-1-anand.ashok.dumbre@xilinx.com>
 <20211108210509.29870-3-anand.ashok.dumbre@xilinx.com> <20211113161724.371e4bcf@jic23-huawei>
 <CAHp75Vfz7zPXg2E=7Q+E-QnvfdHEDv7eFin1srjVZ53PtrMz7g@mail.gmail.com> <BY5PR02MB6916142EBF6AE18E49273A94A9989@BY5PR02MB6916.namprd02.prod.outlook.com>
In-Reply-To: <BY5PR02MB6916142EBF6AE18E49273A94A9989@BY5PR02MB6916.namprd02.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Nov 2021 14:13:43 +0200
Message-ID: <CAHp75VeemaMFCLncFAF24RU6kEbj=9F3w5LWjA-o-uky=pO=5w@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] iio: adc: Add Xilinx AMS driver
To:     Anand Ashok Dumbre <ANANDASH@xilinx.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>, git <git@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Manish Narani <MNARANI@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 15, 2021 at 1:59 PM Anand Ashok Dumbre <ANANDASH@xilinx.com> wrote:

...

> > > > +             ams->pl_base = of_iomap(node, 0);
> > >
> > > Hmm. So of_iomap() leaves us dependent on dt specific calls. Whilst it
> > > doesn't exactly look hard to create a generic version covering at
> > > least dt and acpi I don' think there is an equivalent acpi function currently
> > defined.
> > >
> > > Andy, do you think this is a good thing to add to the generic firmware
> > > node handling?  It's a bit specialist as most of the time this will be
> > > wrapped up in the platform device handling or similar rather than being in a
> > child node like this.
> >
> > I saw this issue previously somewhere else and we can do something about
> > it.
> > But first (before going to ACPI guts) we may indeed introduce a basic
> > skeleton under fwnode API for this.
> >
> > Something like
> >
> > void __iomem *fwnode_iomap(...)
> > {
> >   if (is_of_node(fwnode))
> >     return of_iomap();
> >   return NULL;
> > }
> > EXPORT_SYMBOL_GPL(fwnode_iomap);
> >
> > At least it will allow drivers to make them property provider agnostic.
> >
> > Okay, I checked the current version of the ACPI specification and the
> > proposed DTS here. With above API and something like
> >
> > Device (AMS0) {
> >   Name (_CRS, ...)
> >   ...
> >   Device (PLMN) {
> >     Name (_CRS, ...)
> >   }
> >   Device (PSMN) {
> >     Name (_CRS, ...)
> >   }
> > }
> >
> > we may get the resource from the corresponding fwnode's _CRS object
>
> Just to be sure, do I need to do anything for this in this iteration?

Can you provide a helper to drivers/base/property.h for the X-node
iomap() to be agnostic?

(X - SW, FW, ...)

-- 
With Best Regards,
Andy Shevchenko
