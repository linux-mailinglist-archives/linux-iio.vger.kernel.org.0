Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E551CC980
	for <lists+linux-iio@lfdr.de>; Sun, 10 May 2020 10:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgEJIhk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 10 May 2020 04:37:40 -0400
Received: from tarvos.retrosnub.co.uk ([93.93.130.7]:48340 "EHLO
        tarvos.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgEJIhk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 May 2020 04:37:40 -0400
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 May 2020 04:37:38 EDT
Received: from [192.168.0.10] (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by tarvos.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id DD222C03DA;
        Sun, 10 May 2020 09:27:47 +0100 (BST)
Date:   Sat, 09 May 2020 16:44:04 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <61e9c83b910b3df44291a49b5587b772d4145036.camel@yadro.com>
References: <20200507132600.8801-1-i.mikhaylov@yadro.com> <20200507132600.8801-2-i.mikhaylov@yadro.com> <20200508155050.0000008e@Huawei.com> <61e9c83b910b3df44291a49b5587b772d4145036.camel@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v13 1/2] dt-bindings: proximity: provide vcnl3020 device tree binding document
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <DC81C6F6-5510-4477-B9D2-29CB3DBCA9F3@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 9 May 2020 11:38:46 BST, Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
>On Fri, 2020-05-08 at 15:51 +0100, Jonathan Cameron wrote:
>> On Thu, 7 May 2020 16:25:59 +0300
>> Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
>> 
>> > Mostly standard i2c driver with some additional led-current option
>> > for vcnl3020.
>> > 
>> > Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
>> > ---
>> >  .../iio/proximity/vishay,vcnl3020.yaml        | 65
>+++++++++++++++++++
>> >  1 file changed, 65 insertions(+)
>> >  create mode 100644
>> >
>Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
>> > 
>> > diff --git
>> >
>a/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
>> >
>b/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
>> > new file mode 100644
>> > index 000000000000..408dee17cdf5
>> > --- /dev/null
>> > +++
>b/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
>> > @@ -0,0 +1,65 @@
>> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> > +%YAML 1.2
>> > +---
>> > +$id:
>http://devicetree.org/schemas/iio/proximity/vishay,vcnl3020.yaml#
>> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> > +
>> > +title: Integrated Proximity Sensor With Infrared Emitter
>> > +
>> > +maintainers:
>> > +  - Ivan Mikhaylov <i.mikhaylov@yadro.com>
>> > +
>> > +description: |
>> > +  The VCNL3020 is a fully integrated proximity sensor. Fully
>integrated
>> > means
>> > +  that the infrared emitter is included in the package. It has
>16-bit
>> > +  resolution. It includes a signal processing IC and features
>standard I2C
>> > +  communication interface. It features an interrupt function.
>> > +
>> > +  Specifications about the devices can be found at:
>> > +  https://www.vishay.com/docs/84150/vcnl3020.pdf
>> > +
>> > +properties:
>> > +  compatible:
>> > +    enum:
>> > +      - vishay,vcnl3020
>> > +
>> > +  reg:
>> > +    maxItems: 1
>> > +
>> > +  interrupts:
>> > +    maxItems: 1
>> > +
>> > +  vdd-supply:
>> > +    description: Regulator that provides power to the sensor
>> > +
>> > +  vddio-supply:
>> > +    description: Regulator that provides power to the bus
>> > +
>> > +  vishay,led-current-microamp:
>> > +    description:
>> > +      IR LED current value with valid Range = 0 to 20d. e.g. 0 = 0
>mA,
>> > +      1 = 10 mA, 20 = 200 mA. LED Current is limited to 200 mA for
>values
>> > +      higher than decimal 20. The drive current for the LED used
>in
>> > proximity
>> > +      sensing.
>> 
>> This text is really confusing. Just let the enum speak for itself and
>leave
>> text as
>> something short like
>> 
>> "The driver current for the LED used in proximity sensing. "
>> 
>> Units and values are clear already.
>> 
>
>Jonathan, just to double check, for preventing further problems with
>misunderstanding, is that what you want?
>
>  vishay,led-current-microamp:
>    description:
>        The driver current for the LED used in proximity sensing.
>
>    enum: [0..200000] <- just for shortening
>    default: 20000
>
>Thanks.

Yes

J

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
