Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFAE813F1A8
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2020 19:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392161AbgAPS3u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jan 2020 13:29:50 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2277 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388537AbgAPS3s (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 16 Jan 2020 13:29:48 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id E89599E2EB67A39F47B4;
        Thu, 16 Jan 2020 18:29:45 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 16 Jan 2020 18:29:45 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 18:29:45 +0000
Date:   Thu, 16 Jan 2020 18:29:43 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
CC:     "Bia, Beniamin" <Beniamin.Bia@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "biabeniamin@outlook.com" <biabeniamin@outlook.com>
Subject: Re: [PATCH 1/3] iio: amplifiers: hmc425a: Add support for HMC425A
 step attenuator with gpio interface
Message-ID: <20200116182943.000000de@Huawei.com>
In-Reply-To: <5925b4f1d47306ec4376a296a1146ff024239044.camel@analog.com>
References: <20200113141555.16117-1-beniamin.bia@analog.com>
        <5ae63616-5749-da51-b0b2-85cdcaa948f3@metafoo.de>
        <5925b4f1d47306ec4376a296a1146ff024239044.camel@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Jan 2020 07:27:08 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Mon, 2020-01-13 at 21:57 +0100, Lars-Peter Clausen wrote:
> > [External]
> > 
> > On 1/13/20 3:15 PM, Beniamin Bia wrote:
> > [...]  
> > > +static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
> > > +{
> > > +	struct hmc425a_state *st = iio_priv(indio_dev);
> > > +	int i, *values;
> > > +
> > > +	values = kmalloc_array(st->chip_info->num_gpios, sizeof(int),
> > > +			       GFP_KERNEL);
> > > +	if (!values)
> > > +		return -ENOMEM;
> > > +
> > > +	for (i = 0; i < st->chip_info->num_gpios; i++)
> > > +		values[i] = (value >> i) & 1;
> > > +
> > > +	gpiod_set_array_value_cansleep(st->gpios->ndescs, st->gpios->desc,
> > > +				       values);  
> > 
> > This API got changed a while ago in upstream, see
> > https://github.com/analogdevicesinc/linux/commit/b9762bebc6332b40c33e03dea03e30fa12d9e3ed
> >   
> > > +	kfree(values);
> > > +	return 0;
> > > +}  
> > [...]  
> > > +static int hmc425a_probe(struct platform_device *pdev)
> > > +{  
> > [...]  
> > > +
> > > +	platform_set_drvdata(pdev, indio_dev);  
> > 
> > drvdata is never accessed, no need to set it.
> >   
> > > +	mutex_init(&st->lock);
> > > +
> > > +	indio_dev->dev.parent = &pdev->dev;
> > > +	indio_dev->name = np->name;  
> > 
> > I know ADI likes to do this in its non upstream drivers, but the above
> > is not IIO ABI compliant. The name is supposed to identify the type of
> > the device, which means for this driver should be static "hmc425a".
> > Maybe consider adding a field to the hmc425a_chip_info for this.  
> 
> We've actually [recently] had a discussion about this internally regarding
> the 'indio_dev->name'.
> 
> Maybe it's a good time to ask here (now).
> A lot of our userspace stuff have been searching IIO devices via the 'name'
> field in sysfs, which is the name assigned here.
> That creates a problem when you have multiple devices with the same driver.
> Which is why, one 
> 
> So, then some questions would be:
> Is a searching for IIO devices [in userspace] based on IIO device-name not
> recommended? If not, what would be? Or what would be a better idea?
> 
> The ABI reads [hopefully I pulled up the right field]:
> What:           /sys/bus/iio/devices/iio:deviceX/name
> KernelVersion:  2.6.35
> Contact:        linux-iio@vger.kernel.org
> Description:
>                 Description of the physical chip / device for device X.
>                 Typically a part number.
> 
> The text in description is a bit open to interpretation, so I can't make an
> assessment of what is correct.
> In case there was a discussion about this, sorry for repeating some things
> now.

So I can speak to the 'intent' of that documentation.  It's meant to be the part
number.

Now, we have recently added
indio_dev->label which is retrieved from generic device tree property 'label'
to solve the problem of multiple devices of the same type (note that
driver but different device shouldn't matter as name reflects the part number
not the driver).  It lets you provide any name you like the DT blob.

I appreciate this is a 'new' feature and so a bit of a problem for old userspace.

For a long time I pushed back against this because it's easy to tell which device
is which, just look at the parent.  I got convinced in the end that sometimes
that answer isn't very user friendly :)

Jonathan


> 
> 
> >   
> > > +	indio_dev->info = &hmc425a_info;
> > > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > > +
> > > +	return devm_iio_device_register(&pdev->dev, indio_dev);
> > > +}  


