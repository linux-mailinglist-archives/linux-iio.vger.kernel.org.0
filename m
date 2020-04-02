Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 130A219C953
	for <lists+linux-iio@lfdr.de>; Thu,  2 Apr 2020 21:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389297AbgDBTCS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Apr 2020 15:02:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41167 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388843AbgDBTCR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Apr 2020 15:02:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id d24so1686506pll.8;
        Thu, 02 Apr 2020 12:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6yHfKlaCzswQfxovPpLdXkshSIOZGxKsbwiyjHduQhQ=;
        b=FMjyYjFS9dJWJ6Kufsp8wFXo4bon8NQ/xj3XlxYm3k9C/CCHoNQw5slUw277HlDJ0+
         XY5OoqwS2GIbSMm9eI6Cc992ICMNYsZ06POmIZPstcIioFVOz69byrDtsNNXZzT8lFS3
         KdmK1u4KiK5kkFbXreYuMAzH9RebBBPNi8lmWyyzwNYM6x5ewD5mzbJz5Gkrpz1P8zqT
         lTkYn5LypHhZzOBFSEFirni+nY2Am5iSaa4Us78yjlyNie2RJqOmyWU4FsWeea+GgfSR
         WVBZ8iOrlEU0MTi+I0jpNOw5Dk8lXXwaDz6e3pu5QYnK3A+chHn7leasiVTniupAi/ko
         Urdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6yHfKlaCzswQfxovPpLdXkshSIOZGxKsbwiyjHduQhQ=;
        b=FAZNx9KOZ6NN/oz7HYn1xmOKHe8sT3Wmi34wAdxAdwGWif1OxWvKNOkEc+sESO9/iz
         JbPyb0cxkxTRz0na0EJGhIMt7yfCcYh5DUxu+bHHwmv6kvxS3K9GwEgjdcp86AlhCh/g
         T6XIGL98izeYgS3f3qeElOM/SdAJDdqKTwX8asQOsy9KUNt+FV3OosgtY+0vziCRHPRe
         x6Z1QsubI3NqjekomPSHbVSaCc/RUwyIxmMxtTm3DizDn1SN86HvhY+Ds1rMawHRtJ5f
         LM/cXh/QbF3I8UMqsvgeNAbbS7DnFfGCzDM+mUCU/rMQZ76I9AWpsgNP/KjY2SPXvOd7
         wwPQ==
X-Gm-Message-State: AGi0PuYwCMMW1YcWul4yD9r22Or4hp7dH79GyYZJZqrSsT8gQzC1lWj4
        kQX4fy+wnHO9ZXNbG1aR9hVYqLAebjgXT8oC64Q=
X-Google-Smtp-Source: APiQypLiABGWEuSpBPsVE+16FnXvEv+J3IeXgmeAKbsxy7kWLepFn3RNroasquV/ua9mGroakBr424wUXGYvlrNYSgE=
X-Received: by 2002:a17:902:8215:: with SMTP id x21mr4212381pln.255.1585854136837;
 Thu, 02 Apr 2020 12:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200401185138.10673-1-alazar@startmail.com> <20200401185138.10673-3-alazar@startmail.com>
 <CAHp75VffpBYh+5xrWeeJJH8gRmJqT9ya5eQFedWi190_=p8HKQ@mail.gmail.com> <4431cacc-4af6-a497-5850-20dfceb588c1@metafoo.de>
In-Reply-To: <4431cacc-4af6-a497-5850-20dfceb588c1@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 2 Apr 2020 22:02:05 +0300
Message-ID: <CAHp75VdeME1Bck2nFSW4r5PUA2mJDewEJZYZXhVhP-L-A-Nhig@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: adc: Add MAX1241 driver
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Alexandru Lazar <alazar@startmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 2, 2020 at 9:55 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 4/2/20 8:45 PM, Andy Shevchenko wrote:
> > On Wed, Apr 1, 2020 at 9:47 PM Alexandru Lazar <alazar@startmail.com> wrote:
> >> Add driver for the Maxim MAX1241 12-bit, single-channel ADC.
> >>
> > Perhaps put data sheet link as Datasheet: tag here?
> >
> >> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> >> Signed-off-by: Alexandru Lazar <alazar@startmail.com>
> > ...
> >
> >> +       indio_dev->name = spi_get_device_id(spi)->name;
> > Shouldn't be rather part number?
> > Jonathan?
>
> This is the part number as defined in the spi_device id table :)

Okay!

> +static const struct spi_device_id max1241_id[] = {
> +       { "max1241", max1241 },
> +       {}
> +};


-- 
With Best Regards,
Andy Shevchenko
