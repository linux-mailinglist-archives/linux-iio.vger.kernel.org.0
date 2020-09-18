Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B0526F801
	for <lists+linux-iio@lfdr.de>; Fri, 18 Sep 2020 10:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIRIUQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 18 Sep 2020 04:20:16 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2886 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726064AbgIRIUQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Sep 2020 04:20:16 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id D6418949A7C7C550C067;
        Fri, 18 Sep 2020 09:04:59 +0100 (IST)
Received: from localhost (10.52.125.116) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 18 Sep
 2020 09:04:59 +0100
Date:   Fri, 18 Sep 2020 09:03:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gene Chen <gene.chen.richtek@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>, <Wilma.Wu@mediatek.com>,
        <shufan_lee@richtek.com>, <cy_huang@richtek.com>,
        <benjamin.chao@mediatek.com>,
        Cristian Pop <cristian.pop@analog.com>
Subject: Re: [PATCH v4 2/3] Documentation: ABI: testing: mt6360: Add ADC
 sysfs guideline
Message-ID: <20200918090321.00007f70@Huawei.com>
In-Reply-To: <CAE+NS35Pw-6UqcHPNOsUtW0GABPVEHfPineF81+qrS6A18HiyA@mail.gmail.com>
References: <1600191369-28040-1-git-send-email-gene.chen.richtek@gmail.com>
        <1600191369-28040-3-git-send-email-gene.chen.richtek@gmail.com>
        <20200917184256.71328701@archlinux>
        <CAE+NS35Pw-6UqcHPNOsUtW0GABPVEHfPineF81+qrS6A18HiyA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.125.116]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Sep 2020 15:21:44 +0800
Gene Chen <gene.chen.richtek@gmail.com> wrote:

> Jonathan Cameron <jic23@kernel.org> 於 2020年9月18日 週五 上午1:43寫道：
> >
> > On Wed, 16 Sep 2020 01:36:08 +0800
> > Gene Chen <gene.chen.richtek@gmail.com> wrote:
> >  
> > > From: Gene Chen <gene_chen@richtek.com>
> > >
> > > Add ABI documentation for mt6360 ADC sysfs interfaces.
> > >
> > > Signed-off-by: Gene Chen <gene_chen@richtek.com>  
> > Would you consider using the proposed label attribute for channels?
> >
> > https://lore.kernel.org/linux-iio/20200916132115.81795-1-cristian.pop@analog.com/T/#u
> >
> > I'm hoping that will remove the need to have ext name used in the majority of
> > cases and would like to know if it would work for you?
> > It may not work for this particular case of course.
> >
> > Other comments inline.
> >  
> 
> because of ADC layout is fixed, I can't switch channel to specific
> purpose for userspace.

That patch set doesn't allow userspace to change the purpose. It provides
a *_label attribute for each channel to allow for identification of the channel.
That can be provided by ACPI / DT or can be provided by the driver itself.
The advantage is that it removes the nasty freeform parsing that is needed
to work out the filenames.

> 
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360 | 83 ++++++++++++++++++++++
> > >  1 file changed, 83 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360 b/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360
> > > new file mode 100644
> > > index 0000000..4b1c270
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360
> > > @@ -0,0 +1,83 @@
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_USBID_input  
> >
> >
> > The mixture of case is a bit ugly.  Could we do
> > in_voltage_usbin_input?
> >  
> 
> ACK
> 
> > > +KernelVersion:       5.8.0
> > > +Contact:     gene_chen@richtek.com
> > > +Description:
> > > +             Indicated MT6360 USBID ADC which connected to connector ID pin.
> > > +             Reading returns voltage in uV
> > > +
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_VBUSDIV5_input  
> >  
> > > +KernelVersion:       5.8.0
> > > +Contact:     gene_chen@richtek.com
> > > +Description:
> > > +             Indicated MT6360 VBUS ADC with high accuracy
> > > +             Reading returns voltage in uV  
> >
> > Why would we ever read the low accuracy version?
> >  
> > > +
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_VBUSDIV2_input
> > > +KernelVersion:       5.8.0
> > > +Contact:     gene_chen@richtek.com
> > > +Description:
> > > +             Indicated MT6360 VBUS ADC with low accuracy
> > > +             Reading returns voltage in uV
> > > +
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_VSYS_input
> > > +KernelVersion:       5.8.0
> > > +Contact:     gene_chen@richtek.com
> > > +Description:
> > > +             Indicated MT6360 VSYS ADC
> > > +             Reading returns voltage in uV
> > > +
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_VBAT_input
> > > +KernelVersion:       5.8.0
> > > +Contact:     gene_chen@richtek.com
> > > +Description:
> > > +             Indicated MT6360 VBAT ADC
> > > +             Reading returns voltage in uV
> > > +
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_current_IBUS_input
> > > +KernelVersion:       5.8.0
> > > +Contact:     gene_chen@richtek.com
> > > +Description:
> > > +             Indicated MT6360 IBUS ADC
> > > +             Reading returns current in uA  
> > Given voltage and current are already clear from the channel type,
> > could we avoid the repetition?
> >
> > in_current_bus_input perhaps?
> >  
> 
> ACK
> 
> > > +
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_current_IBAT_input
> > > +KernelVersion:       5.8.0
> > > +Contact:     gene_chen@richtek.com
> > > +Description:
> > > +             Indicated MT6360 IBAT ADC
> > > +             Reading returns current in uA
> > > +
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_CHG_VDDP_input
> > > +KernelVersion:       5.8.0
> > > +Contact:     gene_chen@richtek.com
> > > +Description:
> > > +             Indicated MT6360 CHG_VDDP ADC
> > > +             Reading returns voltage in uV
> > > +
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_temp_TEMP_JC_input
> > > +KernelVersion:       5.8.0
> > > +Contact:     gene_chen@richtek.com
> > > +Description:
> > > +             Indicated MT6360 IC junction temperature
> > > +             Reading returns temperature in degree
> > > +
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_VREF_TS_input
> > > +KernelVersion:       5.8.0
> > > +Contact:     gene_chen@richtek.com
> > > +Description:
> > > +             Indicated MT6360 VREF_TS ADC
> > > +             Reading returns voltage in uV
> > > +
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_TS_input
> > > +KernelVersion:       5.8.0
> > > +Contact:     gene_chen@richtek.com
> > > +Description:
> > > +             Indicated MT6360 TS ADC
> > > +             Reading returns voltage in uV
> > > +
> > > +What:                /sys/bus/iio/devices/iio:deviceX/timestamp
> > > +KernelVersion:       5.8.0
> > > +Contact:     gene_chen@richtek.com
> > > +Description:
> > > +             Indicated MT6360 timestamp
> > > +             Reading returns current timestamp in ms  
> >
> > That's an odd bit of ABI.  Why would we want to read the current timestamp from
> > sysfs?  Timestamps in IIO also tend to be in nano seconds.
> >
> >
> >
> >  
> 
> ACK, I will remove this.


