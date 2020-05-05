Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F6B1C553A
	for <lists+linux-iio@lfdr.de>; Tue,  5 May 2020 14:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgEEMPF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 May 2020 08:15:05 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:58174 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728180AbgEEMPE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 5 May 2020 08:15:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 6CBCC4C841;
        Tue,  5 May 2020 12:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1588680898; x=1590495299; bh=ANGqABoxpaoVIMQlJL1z+IGhr
        ujff4M+QnnNKn0vtsw=; b=LCS42HtBGeGat701v4jxDGuHa2e33+KVuVTVbQfep
        sR90lOF2snNcyiBDH8v5VrrEkUSSMsXnRzgdlBdSExnDWQxVOBznnBfy4p8r1wSM
        lZzyOl9ijKM/5z7I6KyNH7jHXybCAteIli2WHqvPK30bA87O521XMVPtODMKXQzH
        M0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l9jgWv9Gon2w; Tue,  5 May 2020 15:14:58 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id EAC764C83F;
        Tue,  5 May 2020 15:14:57 +0300 (MSK)
Received: from localhost.localdomain (10.199.2.222) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 5 May 2020 15:14:58 +0300
Message-ID: <fbbf971e895694f90c3626ec9fb7a08c5485c6ee.camel@yadro.com>
Subject: Re: [PATCH v11 1/2] iio: proximity: provide device tree binding
 document
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Date:   Tue, 5 May 2020 15:15:52 +0300
In-Reply-To: <20200426103441.6d822c7c@archlinux>
References: <20200422160509.7117-1-i.mikhaylov@yadro.com>
         <20200422160509.7117-2-i.mikhaylov@yadro.com>
         <20200426103441.6d822c7c@archlinux>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.2.222]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2020-04-26 at 10:34 +0100, Jonathan Cameron wrote:
> On Wed, 22 Apr 2020 19:05:08 +0300
> Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
> 
> > Mostly standard i2c driver with some additional led-current option
> > for vcnl3020.
> > 
> > Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> Hm. I missed on previous versions that the title of this patch doesn't
> match the dt-bindings standard.  Please look at other bindings patches.
> 
> e.g. dt-bindings: proximity: Add docs for vcnl3020 
> 
> One other comment inline from me.
> > ---
> >  .../bindings/iio/proximity/vcnl3020.yaml      | 64 +++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
> > b/Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
> > new file mode 100644
> > index 000000000000..ac47770609d2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
> > @@ -0,0 +1,64 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/proximity/vcnl3020.yaml#
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
> > +      higher than decimal 20.
> The text doesn't add anything to the enum which fully defines the values.
> I'd go with something simple like:
> 
> 	 The drive current for the LED used in proximity sensing.
> 
> > +    enum: [0, 10000, 20000, 30000, 40000, 50000, 60000, 70000, 80000,
> > 90000,
> > +          100000, 110000, 120000, 130000, 140000, 150000, 160000, 170000,
> > +          180000, 190000, 200000]
> > +    default: 20000
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        proximity@13 {
> > +              compatible = "vishay,vcnl3020";
> > +              reg = <0x13>;
> > +              vishay,led-current-microamp = <200000>;
> > +        };
> > +    };

Rob, do you have anything to add?

Thanks.

