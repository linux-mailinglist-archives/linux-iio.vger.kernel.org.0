Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C441B4552
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 14:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgDVMpg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 08:45:36 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:58626 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbgDVMpf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Apr 2020 08:45:35 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 48A2049D84;
        Wed, 22 Apr 2020 12:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1587559531; x=1589373932; bh=3Boojm22l1zq6QYU+FAZ0NpY8
        IA6JtvffhCU4SLSarw=; b=nGrKVZX8tegtRQ4PAuBnwdGDpdGcPbB2qNRlVC7Ty
        DIEbqU8e6GN4Hsq9HZH0ivBOyh6kcbbl3QtTG3z+U5+7VBkuFyLaz8ChJO9AjZEf
        pVPEXq0Cj7ODtySGCfDV8fj7DOYeJG067Kty6c0TPv2mSsL1zjrf1BFxSo7H+wXJ
        zM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O-qQfpQr9xQJ; Wed, 22 Apr 2020 15:45:31 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id CF34F49D57;
        Wed, 22 Apr 2020 15:45:30 +0300 (MSK)
Received: from localhost.localdomain (10.199.3.42) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 22
 Apr 2020 15:45:31 +0300
Message-ID: <cbed77d750ee2b6fc72cd65daf57f2e3839b69db.camel@yadro.com>
Subject: Re: [PATCH v10 2/2] iio: proximity: Add driver support for vcnl3020
 proximity sensor
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Wed, 22 Apr 2020 15:46:09 +0300
In-Reply-To: <CAHp75VdZ=jmQFt68+iniDbhGY9Q-ueT6QzrL82mLmsoGwftxFg@mail.gmail.com>
References: <20200421194005.6295-1-i.mikhaylov@yadro.com>
         <20200421194005.6295-3-i.mikhaylov@yadro.com>
         <CAHp75VdZ=jmQFt68+iniDbhGY9Q-ueT6QzrL82mLmsoGwftxFg@mail.gmail.com>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.3.42]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2020-04-21 at 23:23 +0300, Andy Shevchenko wrote:
> On Tue, Apr 21, 2020 at 10:39 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
> > Proximity sensor driver based on light/vcnl4000.c code.
> > For now supports only the single on-demand measurement.
> > 
> > The VCNL3020 is a fully integrated proximity sensor. Fully
> > integrated means that the infrared emitter is included in the
> > package. It has 16-bit resolution. It includes a signal
> > processing IC and features standard I2C communication
> > interface. It features an interrupt function.
> 
> ...
> 
> > +static int vcnl3020_get_and_apply_property(struct vcnl3020_data *data,
> > +                                          const char *prop, u32 reg)
> > +{
> > +       int rc;
> > +       u32 val;
> > +
> > +       rc = device_property_read_u32(data->dev, prop, &val);
> > +       if (rc)
> > +               return 0;
> > +
> > +       /* An example of conversion from uA to reg val:
> > +        * 200000 uA == 200 mA == 20
> > +        */
> > +       if (!strcmp(prop, "vishay,led-current-microamp"))
> > +               val /= 10000;
> 
> I probably missed the point why this function is needed at all, since
> we always call only for a single property.

Andy, I'm planning to add more properties but not for now, this driver the
placeholder for upcoming work what I've. And I wanted something like:

rc = vcnl3020_get_and_apply_property(option1);
if (rc)
	return rc;

rc = vcnl3020_get_and_apply_property(option2);
if (rc)
	return rc;
etc.

And all other work about conversion will be hidden in get_and_apply_property. 

> On top of that, why do we have this nasty strcmp()? Can't we simple do
> something like
> static int vcnl3020_get_and_apply_property(struct vcnl3020_data *data,
> const char *prop, u32 reg, u32 div)
> {
> ...
>   val /= div;
> ...
> }
> 
> static int vcnl3020_get_and_apply_led_current_property(struct
> vcnl3020_data *data)
> {
>   /*
>    * An example of conversion from uA to reg val:
>    * 200000 uA == 200 mA == 20
>    */
> // Note by the way comments style
>   return vcnl3020_get_and_apply_property(data, "vishay,led-current-microamp",
>                                               VCNL_LED_CURRENT, 10000);
> }
> 
> ?

I think your approach with wrapper is better, I'll think how I can do that
without additional 'div' param.

Thanks.

