Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 615DB190CC5
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 12:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgCXLwb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 07:52:31 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:35964 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727400AbgCXLwb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 24 Mar 2020 07:52:31 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id EFA3241286;
        Tue, 24 Mar 2020 11:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1585050747; x=1586865148; bh=r/+JpB/tzVggc5+uUHeVaa6fh
        /sE674WIfm1mQzEXGE=; b=Ca64qgUokGK2sYLawspct1XYaPuroDblVruX3BjtG
        s/bWrsVasOqeFifGlhcXXYeyBR7+Y03KBxOwUTNqh65RgPkdxYCRZBZ9hdFOOZIn
        Bpb01eb6sFlx0VpvgNi8EnP45mAtJxrZ654Bt9qIV3L1AlzXrPaC1G5+/voM0nEk
        gc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lmXVjV-HORA3; Tue, 24 Mar 2020 14:52:27 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 1286441259;
        Tue, 24 Mar 2020 14:52:27 +0300 (MSK)
Received: from localhost.localdomain (10.199.1.182) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 24 Mar 2020 14:52:27 +0300
Message-ID: <321453af40ca49839bc7b9d1c65b828841492f72.camel@yadro.com>
Subject: Re: [PATCH 2/2] iio: proximity: Add driver support for vcnl3020
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
Date:   Tue, 24 Mar 2020 14:52:30 +0300
In-Reply-To: <CAHp75Ve4rejBKjG+mioRL3S7i3meyy=_4TtW1fr2aGvnVn2tBA@mail.gmail.com>
References: <20200323103926.21271-1-i.mikhaylov@yadro.com>
         <20200323103926.21271-3-i.mikhaylov@yadro.com>
         <CAHp75Ve4rejBKjG+mioRL3S7i3meyy=_4TtW1fr2aGvnVn2tBA@mail.gmail.com>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.199.1.182]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2020-03-23 at 14:10 +0200, Andy Shevchenko wrote:
> On Mon, Mar 23, 2020 at 12:41 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
> > Proximity sensor driver based on light/vcnl4000.c code.
> > For now supports only the single on-demand measurement.
> > 
> > The VCNL3020 is a fully integrated proximity sensor. Fully
> > integrated means that the infrared emitter is included in the
> > package. It has 16-bit resolution. It includes a signal
> > processing IC and features standard I2C communication
> > interface. It features an interrupt function.
> 
> Thank you for a patch, my comments below.
> 
> > Datasheet available at:
> > http://www.vishay.com/docs/84150/vcnl3020.pdf
> 
> I'm thinking that we may simple introduce new tag, called Datesheet:
> to put such links.
> 
> > Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> 
> ...
> 
> >  obj-$(CONFIG_SRF08)            += srf08.o
> >  obj-$(CONFIG_SX9500)           += sx9500.o
> >  obj-$(CONFIG_VL53L0X_I2C)      += vl53l0x-i2c.o
> > +obj-$(CONFIG_VCNL3020)         += vcnl3020.o
> 
> Perhaps keep ordered?

Oops.

> 
> ...
> 
> > +static int32_t vcnl3020_init(struct vcnl3020_data *data)
> 
> int32_t...
> 
> > +{
> > +       s32 rc;
> 
> ...s32?!
> 
> Applies to entire code.

checkpatch.pl --strict doesn't show anything bad in it but I can change from
int32_t/s32 into int easily, it's not a problem for me.

> 
> > +       u32 led_current;
> > +       struct device *dev = &data->client->dev;
> 
> Reversed xmas tree order looks better.
> 
> > +       rc = i2c_smbus_read_byte_data(data->client, VCNL_PROD_REV);
> 
> Can you use regmap I²C API?
> 

That's a nice idea.

> ...
> 
> > +       dev_info(&client->dev, "Proximity sensor, Rev: %02x\n",
> > +                data->rev);
> 
> Noise.

Doesn't it help to determine the presence of driver to a common user?

> 
> > +               goto out;
> > +
> > +       return rc;
> > +out:
> > +       devm_iio_device_free(&client->dev, indio_dev);
> > +       return rc;
> 
> Managed resources are exactly for this not to be appeared in the code.

I can do something like this:
return devm_iio_device_register(&client->dev, indio_dev);

Would it suffice?

> 
> > +}
> 
> ...
> 
> > +static const struct of_device_id vcnl3020_of_match[] = {
> > +       {
> > +               .compatible = "vishay,vcnl3020",
> > +       },
> 
> Missed terminator. How did you test this?

All works fine with real hw, I'll add terminator.
Agree with everything else.

Thanks. 

