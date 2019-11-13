Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68FD1FBBB5
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2019 23:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfKMWhS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Nov 2019 17:37:18 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38820 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfKMWhS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Nov 2019 17:37:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id c13so2645254pfp.5;
        Wed, 13 Nov 2019 14:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w7B875XZuR5oafFG8NOnl5OI5GsCZ+1ssBbHKFrJSNA=;
        b=d/m02anasZDot/whtRvfnFm0gsNWyld10J7fYzOfI64BcxOfVfBgn7fcJJBYdjkIVk
         zQlcyqV5L7dHO3dOAVKQ24V9iokEnJKRO5LPumfEVbvDwAMuKjaMARfOjx+jxu44Ur1r
         rzQ0989x7JNwDpaPJhD5304VJkPwRWK8mSYcx54a2RGtFX3I8kzl9BQS6KSWAjfu6iXb
         gBSx1T/MVs5PSphidTpet1T/qqxfLsO7UehqjenlSfqKQnDC9fjj/twChfMVS6uF57Ij
         VE0KvK08LhGziEVTBFLiY5jbB9OrWrps6xcICiApRCv3HXvYRHpo9cWMpRpZL0zCqsOH
         dOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=w7B875XZuR5oafFG8NOnl5OI5GsCZ+1ssBbHKFrJSNA=;
        b=a4MPTWadBjK+vt0VZPoLj0Cj4RHJv9RmlaVh+kLQ23C4BGCfbgY+pNh0HH71e9hZs3
         Si9ng3OFA+nytkZgzdXwESSZlii/DbXrr0Ll4urfJWMEatNwo28Jgpdx2nqmOOof3c1M
         7CxJwIZDqPhOhoMCG57ME0Qa0c7hsE9Q/c0GGC/5NnfGgbiWehj0Y9R8/nkRkVGAaZpZ
         zU6W98HtWskmCHwpy5w0H3IZ1VfBAuBpJSTv0HCgy2ZDzcwod++4Yp/Rz7AmjyXExGZ/
         0M13bdvrnj5cdir1EQ/89UT+7inDeVnxGfhLwRip8Rvt38S9LWTE7Rzb9Z/Amz3VKboH
         QsrQ==
X-Gm-Message-State: APjAAAWBzJJmB+Ywguq+f+/+Nzng8MjPpfS7y0VkFvg3PV6kGV6smPXN
        cxxyRqLdFFWneZlvXvrQZEM=
X-Google-Smtp-Source: APXvYqxE14G1QBfNnL/Qz1wTaYvzj0nNNBvHZNCF1mojyUKZHlzFU3JyBmRdGrULYkBraC+sil870Q==
X-Received: by 2002:a63:e407:: with SMTP id a7mr6238050pgi.92.1573684635287;
        Wed, 13 Nov 2019 14:37:15 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 10sm3383259pgs.11.2019.11.13.14.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Nov 2019 14:37:14 -0800 (PST)
Date:   Wed, 13 Nov 2019 14:37:12 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        "Bia, Beniamin" <Beniamin.Bia@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "biabeniamin@outlook.com" <biabeniamin@outlook.com>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH 1/3] iio: Add ADM1177 Hot Swap Controller and Digital
 Power Monitor driver
Message-ID: <20191113223712.GA25398@roeck-us.net>
References: <20191112153552.27431-1-beniamin.bia@analog.com>
 <20191112173757.0000075b@huawei.com>
 <20191112181734.GA30127@roeck-us.net>
 <BY5PR03MB4965158557D9AEA20A48F95F8E760@BY5PR03MB4965.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR03MB4965158557D9AEA20A48F95F8E760@BY5PR03MB4965.namprd03.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 13, 2019 at 08:10:50AM +0000, Hennerich, Michael wrote:
> 
> 
> > -----Original Message-----
> > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> > Sent: Dienstag, 12. November 2019 20:18
> > To: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Cc: Bia, Beniamin <Beniamin.Bia@analog.com>; jic23@kernel.org;
> > lars@metafoo.de; Hennerich, Michael <Michael.Hennerich@analog.com>;
> > pmeerw@pmeerw.net; gregkh@linuxfoundation.org; linux-
> > iio@vger.kernel.org; devel@driverdev.osuosl.org; linux-
> > kernel@vger.kernel.org; mark.rutland@arm.com; robh+dt@kernel.org;
> > devicetree@vger.kernel.org; paulmck@linux.ibm.com;
> > mchehab+samsung@kernel.org; linus.walleij@linaro.org;
> > nicolas.ferre@microchip.com; biabeniamin@outlook.com; Jean Delvare
> > <jdelvare@suse.com>
> > Subject: Re: [PATCH 1/3] iio: Add ADM1177 Hot Swap Controller and Digital
> > Power Monitor driver
> > 
> > On Tue, Nov 12, 2019 at 05:37:57PM +0000, Jonathan Cameron wrote:
> > > On Tue, 12 Nov 2019 17:35:50 +0200
> > > Beniamin Bia <beniamin.bia@analog.com> wrote:
> > >
> > > > From: Michael Hennerich <michael.hennerich@analog.com>
> > > >
> > > > ADM1177 is a Hot Swap Controller and Digital Power Monitor with Soft
> > > > Start Pin.
> > > >
> > > > Datasheet:
> > > > Link:
> > > > https://www.analog.com/media/en/technical-documentation/data-
> > sheets/
> > > > ADM1177.pdf
> > > >
> > > > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > > > Co-developed-by: Beniamin Bia <beniamin.bia@analog.com>
> > > > Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> > >
> > > Hi Beniamin,
> > >
> > > A couple immediate thoughts.
> > >
> > > 1. That cc list has some rather non obvious people on it.  Unless something
> > >    fairly surprising is going on, probably better to cut it back a bit.
> > >
> > > 2. Why IIO?  Not entirely obvious to me.  From first glance this is definitely
> > >    doing hardware monitoring.  If there is a reason there should be a clear
> > >    statement here on why.
> > >
> > 
> > I don't see why this is implemented as iio driver. I think it should be
> > implemented as hardware monitoring driver.
> 
> Totally agree that this driver could have been implemented as HWMON driver.
> Well we use this device as USB supply monitor on our embedded portably kits, to detect low VBUS or excess current draw. 
> 
> ADALM-PLUTO and ADALM2000:
> https://www.analog.com/en/design-center/evaluation-hardware-and-software/evaluation-boards-kits/adalm-pluto.html
> 
> https://www.analog.com/en/design-center/evaluation-hardware-and-software/evaluation-boards-kits/ADALM2000.html
> 
> The only connectivity to the host PC is via IIO/libiio USB Gadget FS and Ethernet backends.
> 
> We recommend people to read the IIO attributes whenever they report an issue.
> Unless libiio supports directly HWMON or HWMON adds an IIO bridge we would prefer this driver being exposed as IIO device, since HWMON users still can use the IIO/HWMON bridge.
> 

I do not think this is a valid argument.

- This is a hardware monitoring chip.
- Implementing kernel support as IIO driver, keeping it out of tree for years,
  establishing an iio based use case, and then pressuring kernel maintainers
  to accept an iio driver seems inappropriate.
- The argument of "we need libiio support for this chip" could effectively
  be used to re-implement pretty much all hwmon drivers as iio drivers.
- The iio->hwmon bridge would add complexity for the majority of potential
  users of this chip. Focus should be on the majority, not on one use case.
- Userspace may as well use libsensors and/or sensors to do the necessary
  access - or implement it if neded. Or add a libsensors based backend to
  libiio (or to iiod).
- Last but not least, it would be more appropriate to implement a generic
  hwmon->iio bridge for iio use cases for chips supported by hwmon drivers,
  similar to the hwmon->thermal bridge.

Guenter
