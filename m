Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C8837365F
	for <lists+linux-iio@lfdr.de>; Wed,  5 May 2021 10:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhEEIhP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 May 2021 04:37:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2998 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbhEEIhO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 May 2021 04:37:14 -0400
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FZqXJ65hSz70gFc;
        Wed,  5 May 2021 16:25:20 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 5 May 2021 10:36:17 +0200
Received: from localhost (10.52.120.138) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 5 May 2021
 09:36:16 +0100
Date:   Wed, 5 May 2021 09:34:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: bme680_i2c: Make bme680_acpi_match depend on
 CONFIG_ACPI
Message-ID: <20210505093438.00005238@Huawei.com>
In-Reply-To: <20210505093235.00007c38@Huawei.com>
References: <20210504174019.2134652-1-linux@roeck-us.net>
        <CAHp75Vd-iTkA5Y6tEHtfcqLxxmHaaU8nLQSL7eWb-gaa-c8AJg@mail.gmail.com>
        <8f8b6f33-4308-bfda-2238-9a54e19c3f9f@roeck-us.net>
        <20210505093235.00007c38@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.138]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 5 May 2021 09:32:35 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 4 May 2021 11:00:52 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On 5/4/21 10:44 AM, Andy Shevchenko wrote:  
> > > On Tue, May 4, 2021 at 8:40 PM Guenter Roeck <linux@roeck-us.net> wrote:    
> > >>
> > >> With CONFIG_ACPI=n and -Werror, 0-day reports:
> > >>
> > >> drivers/iio/chemical/bme680_i2c.c:46:36: error:
> > >>         'bme680_acpi_match' defined but not used    
> > >     
> > >> Given the other patch, question of course is if this ACPI ID
> > >> is real. A Google search suggests that this might not be the case.
> > >> Should we remove it as well ? STK8312 has the same problem.    
> > > 
> > > For this one definitely removal. Looking into the code it suggests a
> > > cargo cult taken that time by a few contributors to invent fake ACPI
> > > IDs while submitting new drivers.
> > > Feel free to add my tag or if you wish me I'll add it explicitly.
> > >     
> > 
> > I'll resend and let you add the tag, and send a similar patch
> > for STK8312. I'll wait until tomorrow, though - I sent a number of
> > patches today already, and I want to avoid yet another "account
> > suspended" notice from gmail.  
> 
> If you find some valid ACPI entries that are hitting this problem,
> I'd prefer we just got rid of the ACPI_PTR() usecases rather than
> added IFDEF magic.
> 
> The space wasted by having these is trivial and I'd rather not
> introduce ifdef around any of these tables.
> 
> Dropping the ones we are fairly sure are spurious is even better!

If I get bored I'll just do a scrub of all the instances of this that
you haven't already cleaned up.  It's worth noting that we do
know some highly suspicious looking entries are out there in the wild. 

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > 
> > Thanks,
> > Guenter  
> 

