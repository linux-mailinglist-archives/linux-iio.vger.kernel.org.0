Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC0A81A5E57
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 13:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgDLLsG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 07:48:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgDLLsG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 07:48:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3806A20708;
        Sun, 12 Apr 2020 11:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586692086;
        bh=Cq2x5fenTwfIajDDtRYq+QYOfzEBDEJNTS6/wFH0wnA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KVBq1lBxrAB/gZLRyJXUWeDqee/ghOkTfyDneKfrEmlpaklywyjIH+axiQNG6ekmo
         ctyLi2ve9WG82jsaWSQAAxZ+eDojz1vbWbFgvcZZWA2nAeTpn86p03k1yrLiKbjrJn
         zhC0xlxCrVz3/XefEAVqql9vK2JrD94lMWI/r+lI=
Date:   Sun, 12 Apr 2020 12:48:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v4 5/6] iio: imu: Add support for adis16475
Message-ID: <20200412124801.2a80b067@archlinux>
In-Reply-To: <CAHp75VcOxjnNRetQxUR=8Z-WA=V6rzAFwCfhjNCmjQE3hgAEEA@mail.gmail.com>
References: <20200406150846.878-1-nuno.sa@analog.com>
        <20200406150846.878-6-nuno.sa@analog.com>
        <CAHp75VeK8K0WHK3gDwyT3ZAaMaVdfZ5xVG94JY4O8fd2U0HEHg@mail.gmail.com>
        <BN6PR03MB33476ECFB3F8454CC6C67F0E99C30@BN6PR03MB3347.namprd03.prod.outlook.com>
        <CAHp75VcOxjnNRetQxUR=8Z-WA=V6rzAFwCfhjNCmjQE3hgAEEA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> ...
> 
> > > > +                       if (scaled_out_freq < 1900 || scaled_out_freq > 2100) {
> > > > +                               dev_err(dev,
> > > > +                                       "Invalid value:%u for adi,scaled-output-hz",
> > > > +                                       scaled_out_freq);  
> > >
> > > When there is no property or property has a value 0 this message can't
> > > tell the difference.
> > > Perhaps you have to check return code from device_property_read_u32()
> > > call.
> > >  
> >
> > Well, I think we don't really need to. If the sync mode is scaled, then this property is mandatory
> > (and this is stated in the bindings). So, I don't really care if the property is not there or if it's just
> > a wrong value. We should fail either way and I'm not sure an extra if with some other message will
> > give us that extra value...  
> 
> Up to maintainer (I have no strong opinion about this)

Nice to give a hint to the user about the two different cases so I'd check the
return value as Andy first suggested.

