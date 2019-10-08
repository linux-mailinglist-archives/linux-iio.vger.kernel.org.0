Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACA61CF9C7
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2019 14:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfJHMaF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Oct 2019 08:30:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3223 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730301AbfJHMaF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Oct 2019 08:30:05 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 625A471954B1507DF561;
        Tue,  8 Oct 2019 20:30:01 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 8 Oct 2019
 20:29:57 +0800
Date:   Tue, 8 Oct 2019 13:29:40 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
CC:     "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Add binding for ADUX1020
Message-ID: <20191008132940.00000eca@huawei.com>
In-Reply-To: <b03c8de71e6d568d54ddfd07758c07c03c0eb89d.camel@analog.com>
References: <20191007101027.8383-1-manivannan.sadhasivam@linaro.org>
        <20191007101027.8383-2-manivannan.sadhasivam@linaro.org>
        <a60fb9ea8922c1eb532e0b7ef0a69abcc9306255.camel@analog.com>
        <4EC23AB5-B8BE-4E45-8E5B-FCCD5B1508BA@linaro.org>
        <b03c8de71e6d568d54ddfd07758c07c03c0eb89d.camel@analog.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 7 Oct 2019 13:21:50 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Mon, 2019-10-07 at 18:10 +0530, Manivannan Sadhasivam wrote:
> > [External]
> > 
> > Hi Ardelean, 
> > 
> > On 7 October 2019 3:51:16 PM IST, "Ardelean, Alexandru" <  
> > alexandru.Ardelean@analog.com> wrote:
> > > On Mon, 2019-10-07 at 15:40 +0530, Manivannan Sadhasivam wrote:  
> > > > [External]
> > > > 
> > > > Add devicetree binding for Analog Devices ADUX1020 Photometric
> > > > sensor.
> > > >   
> > > 
> > > Hey,
> > > 
> > > Thanks for the patches.
> > > 
> > > This dt-binding docs is in text format.
> > > dt-binding docs now need to be in YAML format.
> > >   
> > 
> > Sure. I can convert to YAML binding. 
> >   
> > > Also, patches for dt-bindings docs usually come after the driver is
> > > added.
> > > So, this patch should be the second in the series, not the first.
> > >   
> > 
> > I don't think so. The convention is to put dt-bindings patch upfront for
> > all subsystems. Not sure if IIO differs here.   
> 
> Now that you mention, I'm not sure either.
> We typically sent the dt-bindings one last, so I assumed it was the
> default.

I don't care either way so never comment on it :)

Jonathan

> 
> > 
> > Thanks, 
> > Mani  
> > > Alex
> > >   
> > > > Signed-off-by: Manivannan Sadhasivam  
> > > <manivannan.sadhasivam@linaro.org>  
> > > > ---
> > > >  .../bindings/iio/light/adux1020.txt           | 22  
> > > +++++++++++++++++++  
> > > >  1 file changed, 22 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/iio/light/adux1020.txt
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/iio/light/adux1020.txt
> > > > b/Documentation/devicetree/bindings/iio/light/adux1020.txt
> > > > new file mode 100644
> > > > index 000000000000..e896dda30e36
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/light/adux1020.txt
> > > > @@ -0,0 +1,22 @@
> > > > +Analog Devices ADUX1020 Photometric sensor
> > > > +
> > > > +Link to datasheet: 
> > > >   
> > > https://www.analog.com/media/en/technical-documentation/data-sheets/ADUX1020.pdf  
> > > > +
> > > > +Required properties:
> > > > +
> > > > + - compatible: should be "adi,adux1020"
> > > > + - reg: the I2C address of the sensor
> > > > +
> > > > +Optional properties:
> > > > +
> > > > + - interrupts: interrupt mapping for IRQ as documented in
> > > > +    
> > > Documentation/devicetree/bindings/interrupt-controller/interrupts.txt  
> > > > +
> > > > +Example:
> > > > +
> > > > +adux1020@64 {
> > > > +	compatible = "adi,adux1020";
> > > > +	reg = <0x64>;
> > > > +	interrupt-parent = <&msmgpio>;
> > > > +	interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
> > > > +};  


