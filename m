Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5164F127F7F
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2019 16:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfLTPi7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Dec 2019 10:38:59 -0500
Received: from sender4-op-o11.zoho.com ([136.143.188.11]:17104 "EHLO
        sender4-op-o11.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfLTPi7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Dec 2019 10:38:59 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1576856324; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ete8nDfbjMemKuv3U1vyPbsLah+80GDIki/Ssl0DHwBEgQ67nsi31XHbzSdZjLXxLrVLn1VdPm/cb6M8D2Wa83ZS218ka1g0TCzKJD3M07dqiTVkP8rVg5AOhwr8CPlD4NjH1jsaG/0gv4NDRk0r0i4XhTtzmf/ZAUXEn/1pfjE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1576856324; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=jGAXoe+RtUEJhHVG4fzxyeeTaAMDlemfjZegvpM3sN8=; 
        b=i+F4ra6ORh/ecCvorhhQponAjEmkVa2WQUiZb0k7wwH1bp4IvSc4WJ2W9sZIBssQ7bdh22ae2x3dm/729vW+JLuoSf+BRNVY3mVTghQDy3djvYbIqedckYeGCBNIgzsMLzdEu8rXI+Nfa8Q9Eba+LJ12x9qj0KYy2kyGeoLt5Jg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie (pool-173-73-58-202.washdc.fios.verizon.net [173.73.58.202]) by mx.zohomail.com
        with SMTPS id 157685632244183.04042224278498; Fri, 20 Dec 2019 07:38:42 -0800 (PST)
Date:   Fri, 20 Dec 2019 15:23:10 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v7 3/3] iio: (bma400) basic regulator support
Message-ID: <20191220152310.GC16415@nessie>
References: <20191219041039.23396-1-dan@dlrobertson.com>
 <20191219041039.23396-4-dan@dlrobertson.com>
 <CAHp75VeU07TsV2NC5Myvmi7Q6tARbmt9=wQDRnXFqaX2G2Luiw@mail.gmail.com>
 <CACRpkdbTissSRyJ5uh8X6RFTM+VSSML-JmtOC_i8_UY0VTVRAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbTissSRyJ5uh8X6RFTM+VSSML-JmtOC_i8_UY0VTVRAA@mail.gmail.com>
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 19, 2019 at 10:41:19PM +0100, Linus Walleij wrote:
> On Thu, Dec 19, 2019 at 12:06 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Dec 19, 2019 at 6:28 AM Dan Robertson <dan@dlrobertson.com> wrote:
> > >
> > > Add support for the VDD and VDDIO regulators using the regulator
> > > framework.
> > ...
> >
> > > +       data->vdd_supply = devm_regulator_get(data->dev, "vdd");
> >
> > > +       data->vddio_supply = devm_regulator_get(data->dev, "vddio");
> >
> > devm_regulator_bulk_get() ?
> 
> I always thought to use regulator_bulk* maybe 3 regulators and
> definitely for more that 4 as it also clouds the view bit and is not
> as straightforward to read as the single functions, but I suppose
> it is a bit subjective :)

I tend to agree, but I think in this case it will at least simplify the
goto's.

Cheers,

 - Dan

