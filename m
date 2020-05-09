Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CFB1CC060
	for <lists+linux-iio@lfdr.de>; Sat,  9 May 2020 12:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgEIKhx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 May 2020 06:37:53 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:35020 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726877AbgEIKhx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 May 2020 06:37:53 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 6DBC847CF8;
        Sat,  9 May 2020 10:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1589020667; x=1590835068; bh=NjhSBdUtDpt27vc8z49oMLxZ6
        nUA0857EPFame8QyLY=; b=BytHNatf8D2MlXUX0ul4BsFW63pzDKhHPFn0ipZy5
        AxboSGEY6an84cMvWfbykJfvNX3h6kLNgBTb7ojUKwCnOew6YwpLxwNWIRhOGJ4G
        KIxjicj25TeZZ33PqAOXyi92V7oG2JjjVlJjdSqHJtZodFVplpS9RJfXnk/ay0lc
        6E=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id E1ied5mhQ_dK; Sat,  9 May 2020 13:37:47 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 1E96F412CE;
        Sat,  9 May 2020 13:37:47 +0300 (MSK)
Received: from localhost.localdomain (10.199.3.114) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Sat, 9 May 2020 13:37:48 +0300
Message-ID: <61e9c83b910b3df44291a49b5587b772d4145036.camel@yadro.com>
Subject: Re: [PATCH v13 1/2] dt-bindings: proximity: provide vcnl3020 device
 tree binding document
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 9 May 2020 13:38:46 +0300
In-Reply-To: <20200508155050.0000008e@Huawei.com>
References: <20200507132600.8801-1-i.mikhaylov@yadro.com>
         <20200507132600.8801-2-i.mikhaylov@yadro.com>
         <20200508155050.0000008e@Huawei.com>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.3.114]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2020-05-08 at 15:51 +0100, Jonathan Cameron wrote:
> On Thu, 7 May 2020 16:25:59 +0300
> Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
> 
> > Mostly standard i2c driver with some additional led-current option
> > for vcnl3020.
> > 
> > Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> > ---
> >  .../iio/proximity/vishay,vcnl3020.yaml        | 65 +++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
> > b/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
> > new file mode 100644
> > index 000000000000..408dee17cdf5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
> > @@ -0,0 +1,65 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/proximity/vishay,vcnl3020.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Integrated Proximity Sensor With Infrared Emitter
> > +
> > +maintainers:
> > +  - Ivan Mikhaylov <i.mikhaylov@yadro.com>
> > +
> > +description: |
> > +  The VCNL3020 is a fully integrated proximity sensor. Fully integrated
> > means
> > +  that the infrared emitter is included in the package. It has 16-bit
> > +  resolution. It includes a signal processing IC and features standard I2C
> > +  communication interface. It features an interrupt function.
> > +
> > +  Specifications about the devices can be found at:
> > +  https://www.vishay.com/docs/84150/vcnl3020.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - vishay,vcnl3020
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  vdd-supply:
> > +    description: Regulator that provides power to the sensor
> > +
> > +  vddio-supply:
> > +    description: Regulator that provides power to the bus
> > +
> > +  vishay,led-current-microamp:
> > +    description:
> > +      IR LED current value with valid Range = 0 to 20d. e.g. 0 = 0 mA,
> > +      1 = 10 mA, 20 = 200 mA. LED Current is limited to 200 mA for values
> > +      higher than decimal 20. The drive current for the LED used in
> > proximity
> > +      sensing.
> 
> This text is really confusing. Just let the enum speak for itself and leave
> text as
> something short like
> 
> "The driver current for the LED used in proximity sensing. "
> 
> Units and values are clear already.
> 

Jonathan, just to double check, for preventing further problems with
misunderstanding, is that what you want?

  vishay,led-current-microamp:
    description:
        The driver current for the LED used in proximity sensing.

    enum: [0..200000] <- just for shortening
    default: 20000

Thanks.

