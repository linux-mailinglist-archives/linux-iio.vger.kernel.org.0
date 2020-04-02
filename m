Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25E6119BD8F
	for <lists+linux-iio@lfdr.de>; Thu,  2 Apr 2020 10:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387691AbgDBIYc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Apr 2020 04:24:32 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:39176 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387574AbgDBIYc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 2 Apr 2020 04:24:32 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 60C5141252;
        Thu,  2 Apr 2020 08:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1585815868; x=1587630269; bh=Rk9xR31MTBz42inzc2zDfzMeZ
        IDUkeMnBQo9b80woiI=; b=Z1QSr1ecssngt9KsASvvvGjwjmSfwzQLU7b3urygH
        jfQ2eVzv51CZmehzgGEfVE7k2eKD4XeKdy4bNn5FuM69IJ/8R8TSMRkjdlYqLo+l
        sVv85W8lYsBXvJiVl81kD24CAMcPvG0gRCh/A7cgjEUHSWrsTiigH3W7rFQ4TQPW
        ok=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yIxdH8dGqypN; Thu,  2 Apr 2020 11:24:28 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 6E2EA41251;
        Thu,  2 Apr 2020 11:24:28 +0300 (MSK)
Received: from localhost.localdomain (10.199.3.154) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 2 Apr 2020 11:24:28 +0300
Message-ID: <1e2c9b590a3626abee330a28cca86cbae7affb39.camel@yadro.com>
Subject: Re: [PATCH v6 2/2] iio: proximity: Add driver support for vcnl3020
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
Date:   Thu, 2 Apr 2020 11:24:36 +0300
In-Reply-To: <CAHp75VcdDR-owtFuFMqNLFh_-L902fXODG14_6Dh416tTwjidA@mail.gmail.com>
References: <20200401162416.24474-1-i.mikhaylov@yadro.com>
         <20200401162416.24474-3-i.mikhaylov@yadro.com>
         <CAHp75VcdDR-owtFuFMqNLFh_-L902fXODG14_6Dh416tTwjidA@mail.gmail.com>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.3.154]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2020-04-01 at 19:35 +0300, Andy Shevchenko wrote:
> On Wed, Apr 1, 2020 at 7:24 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
> > Proximity sensor driver based on light/vcnl4000.c code.
> > For now supports only the single on-demand measurement.
> > 
> > The VCNL3020 is a fully integrated proximity sensor. Fully
> > integrated means that the infrared emitter is included in the
> > package. It has 16-bit resolution. It includes a signal
> > processing IC and features standard I2C communication
> > interface. It features an interrupt function.
> 
> Thank you for an update, my comments below.
> 
> ...
> 
> > +static int get_and_apply_property(struct vcnl3020_data *data, const char
> > *prop,
> > +                                 u32 reg)
> > +{
> > +       int rc;
> > +       u32 val;
> > +
> > +       rc = device_property_read_u32(data->dev, prop, &val);
> > +       if (rc)
> > +               return 0;
> > +
> > +       rc = regmap_write(data->regmap, reg, val);
> > +       if (rc)
> > +               dev_err(data->dev, "Error (%d) setting property (%s)",
> > +                       rc, prop);
> 
> This requires {} according to the coding style

checkpatch.pl doesn't say anything bad on this spot. Do you mean to make
something like this?

rc = regmap_write(data->regmap, reg, val);
if (rc) {
	dev_err(data->dev, "Error (%d) setting property (%s)",
                rc, prop);
}

In previous notes you said to remove them. 

> .
> 
> > +       return rc;
> > +}
> 
> ...
> 
> > +static int vcnl3020_probe(struct i2c_client *client)
> > +{
> > +       indio_dev->name = VCNL_DRV_NAME;
> 
> It's definitely not a driver name. You have to put part number here.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/light/tsl4531.c?h=v5.6#n199
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/light/max44009.c?h=v5.6#n507
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/light/vl6180.c?h=v5.6#n515


