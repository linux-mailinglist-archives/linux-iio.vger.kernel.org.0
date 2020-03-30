Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 603AE19859A
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 22:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgC3UlL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 16:41:11 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:36862 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728481AbgC3UlL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Mar 2020 16:41:11 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 1FB5041272;
        Mon, 30 Mar 2020 20:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1585600867; x=1587415268; bh=OU3hBGEfOQcxytxHcUWUuI35b
        IUOuu3HXbM3CIo0vkY=; b=QBfuYm3KLrYd59pO8C9CwBNFTPOk4X8UTiGOig9Wm
        Z7B8plOFw6gX2yjVllCSjZieFXOvzDK7dy+MgAMKHBPJKszLMI7Ctqpm3rwOri63
        DCSnh79H/0yeWSYnN/Abx0Y4omtl8GyavEyFxODtjeB8PARjXkdT2MUNnYKNTl1v
        Q8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id e8APibuRPKhO; Mon, 30 Mar 2020 23:41:07 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 77DC84126E;
        Mon, 30 Mar 2020 23:41:07 +0300 (MSK)
Received: from localhost.localdomain (10.199.0.226) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Mon, 30 Mar 2020 23:41:07 +0300
Message-ID: <5cb43513906e1175801ea4e753c855623fcd11d1.camel@yadro.com>
Subject: Re: [PATCH v5 2/2] iio: proximity: Add driver support for vcnl3020
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
Date:   Mon, 30 Mar 2020 23:41:15 +0300
In-Reply-To: <CAHp75VeLtPkb0e4uNP+1LGgtquBXkb5=bPi54O1U92uaO5jqvw@mail.gmail.com>
References: <20200330152711.8769-1-i.mikhaylov@yadro.com>
         <20200330152711.8769-3-i.mikhaylov@yadro.com>
         <CAHp75VeLtPkb0e4uNP+1LGgtquBXkb5=bPi54O1U92uaO5jqvw@mail.gmail.com>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.0.226]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2020-03-30 at 22:07 +0300, Andy Shevchenko wrote:
> On Mon, Mar 30, 2020 at 6:27 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
> > Proximity sensor driver based on light/vcnl4000.c code.
> > For now supports only the single on-demand measurement.
> > 
> > The VCNL3020 is a fully integrated proximity sensor. Fully
> > integrated means that the infrared emitter is included in the
> > package. It has 16-bit resolution. It includes a signal
> > processing IC and features standard I2C communication
> > interface. It features an interrupt function.
> 
> Still my tag applies, but
> I have few more comments below.
> 
> ...
> 
> > +#define VCNL_DRV_NAME          "vcnl3020"
> > +#define VCNL_REGMAP_NAME       "vcnl3020_regmap"
> 
> I'm wondering why you need the second one.

For regmap initialize as name in 
static const struct regmap_config vcnl3020_regmap_config = {
       .name           = VCNL_REGMAP_NAME,

I can get rid of it from struct with name definition.

> > +       rc = device_property_read_u32(data->dev, "vishay,led-current-
> > milliamp",
> > +                                     &led_current);
> > +       if (rc == 0) {
> > +               rc = regmap_write(data->regmap, VCNL_LED_CURRENT,
> > led_current);
> > +               if (rc)
> > +                       dev_err(data->dev,
> > +                               "Error (%d) setting LED current", rc);
> > +       }
> > +
> > +       return rc;
> 
> Why not to use standard pattern, i.e.
> 
>   if (rc)
>     return rc;
>   ...
>   rc = regmap_write(...);
> 
> ?

Optional parameter. There exists a lot of ways to do it:

rc = device_property_read_u32(dev, "milliamp", &led_current);
rc = regmap_write(regmap, VCNL_LED_CURRENT, (!rc) : led_current ? 0);
or

rc = regmap_write(regmap, VCNL_LED_CURRENT, (!rc) : led_current ?
VCNL_LED_CURRENT_DEFAULT);
or even maybe make a function like get_led_current:

rc = regmap_write(regmap, VCNL_LED_CURRENT, get_led_curent(dev));
where 
static u32 get_led_current(dev) {
	u32 led_current;
	rc = device_property_read_u32(dev, "milliamp", &led_current);
	return (!rc) : led_current ? VCNL_LED_CURRENT_DEFAULT;
}
Which one would be more preferable?

> ...
> 
> > +       if (rc) {
> > +               dev_err(data->dev,
> > +                       "vcnl3020_measure() failed with error (%d)", rc);
> 
> Perhaps you keep same pattern for error messages as in previous function(s).

Sure.

> 
> > +               goto err_unlock;
> > +       }
> > +       rc = regmap_bulk_read(data->regmap, VCNL_PS_RESULT_HI, &res, 2);
> 
> sizeof(res)

Oops.


