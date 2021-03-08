Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5203314C7
	for <lists+linux-iio@lfdr.de>; Mon,  8 Mar 2021 18:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhCHR0E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 12:26:04 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2665 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhCHRZl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 12:25:41 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DvQ5K5bPKz67wjT;
        Tue,  9 Mar 2021 01:17:41 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 18:25:39 +0100
Received: from localhost (10.47.81.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 8 Mar 2021
 17:25:38 +0000
Date:   Mon, 8 Mar 2021 17:24:27 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Philippe De Muyter <phdm@macq.eu>
CC:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: invensense mpu9250 ak8963 and devicetree
Message-ID: <20210308172427.000032d2@Huawei.com>
In-Reply-To: <20210308130630.GA3363@frolo.macqel>
References: <20210303153145.GA30260@frolo.macqel>
        <BL0PR12MB501190F3812AA541BDBEF625C4979@BL0PR12MB5011.namprd12.prod.outlook.com>
        <20210308130630.GA3363@frolo.macqel>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.81.42]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 8 Mar 2021 14:06:30 +0100
Philippe De Muyter <phdm@macq.eu> wrote:

> Hello Jean-Baptiste,
> 
> On Thu, Mar 04, 2021 at 10:08:10AM +0000, Jean-Baptiste Maneyrol wrote:
> > You can try to cherry-pick the corresponding commits inside Linux 5.10.
> > 
> > Or just copy the driver files and made the change to have them working properly.
> >   
> 
> I have integrated in my kernel the patches up to v5.11.
> 
> My DT entry now is :
> 
>                 mpu9250@68 {
>                         compatible = "invensense,mpu9250";
>                         reg = <0x68>;
>                         interrupt-parent = <&tegra_main_gpio>;
>                         interrupts = <TEGRA_MAIN_GPIO(P, 3) GPIO_ACTIVE_HIGH>;
>                 };
> 
> But probing fails with :
> 
> [    6.989291] inv-mpu6050-i2c 0-0068: mounting matrix not found: using identity...
> [    6.989312] inv-mpu6050-i2c 0-0068: Failed to get vdd regulator -19
> 
> The "Failed to get vdd regulator" seems to come from those lines in
> drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> 
>         st->vdd_supply = devm_regulator_get(dev, "vdd");
>         if (IS_ERR(st->vdd_supply)) {
>                 if (PTR_ERR(st->vdd_supply) != -EPROBE_DEFER)
>                         dev_err(dev, "Failed to get vdd regulator %d\n",
>                                 (int)PTR_ERR(st->vdd_supply));
> 
>                 return PTR_ERR(st->vdd_supply);
>         }

That's odd because you should get a stub regulator... For simple cases
where the regulator is always on, there is no need to specify a regulator,
you can just rely on the regulator framework giving you one that basically
does nothing.

Could you have a look at why you aren't getting a dummy_regulator from the code
just below here?

https://elixir.bootlin.com/linux/latest/source/drivers/regulator/core.c#L1948

Jonathan

> 
> Should I turn off those lines ?
> 
> Philippe
> 
> > Best regards,
> > JB
> > ________________________________
> > From: Philippe De Muyter <phdm@macq.eu>
> > Sent: Thursday, March 4, 2021 10:31
> > To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
> > Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
> > Subject: Re: invensense mpu9250 ak8963 and devicetree
> > 
> >  CAUTION: This email originated from outside of the organization. Please make sure the sender is who they say they are and do not click links or open attachments unless you recognize the sender and know the content is safe.
> > 
> > Hello Jean-Baptiste,
> > 
> > thank you for your answer
> > 
> > I work actually with a nvidia-provided 4.9 kernel that I cannot change.
> > Up to now I have incorporated the mpu9250 related patches up to v4.12.
> > 
> > Do you think I should simply replace the inv_mpu6050 driver files of v4.9
> > by their v5.11 (or newer) counterparts ?
> > 
> > Thanks
> > 
> > Philippe
> > 
> > On Thu, Mar 04, 2021 at 09:12:47AM +0000, Jean-Baptiste Maneyrol wrote:  
> > > Hello Philippe,
> > >
> > > I would recommend letting mpu9250 chip drives the magnetometer instead of using the ak8963 driver.
> > >
> > > This is simpler to use and guarantees a good synchronization between all sensors and no possible latency coming from kernel scheduling when polling the magnetometer. And it enables the use of spi bus for connecting the device.
> > >
> > > You just need to define mpu9250 dts without an i2c-gate, and delete all definition of ak8963 chip.
> > >
> > > Best regards,
> > > JB
> > >
> > >
> > > From: Philippe De Muyter <phdm@macq.eu>
> > > Sent: Wednesday, March 3, 2021 16:31
> > > To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
> > > Subject: invensense mpu9250 ak8963 and devicetree
> > >
> > > Hello,
> > >
> > > I am trying to use a mpu9250 imu, but I have trouble with the ak8963 part.
> > >
> > > Currently, ak8975_probe fails in this code :
> > >
> > >         /* Fetch the regulators */
> > >         data->vdd = devm_regulator_get(&client->dev, "vdd");
> > >         if (IS_ERR(data->vdd))
> > >                 return PTR_ERR(data->vdd);
> > >         data->vid = devm_regulator_get(&client->dev, "vid");
> > >         if (IS_ERR(data->vid))
> > >                 return PTR_ERR(data->vid);
> > >
> > > but Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> > > says :
> > >
> > >   vdd-supply:
> > >     description: |
> > >       an optional regulator that needs to be on to provide VDD power to
> > >       the sensor.
> > >
> > > I have no vdd or vdd-supply property in my ak8963 description.
> > >
> > > Is that unrelated ?
> > >
> > > What should I write in my dts file for this ak8963 embedded in a mpu9250 ?
> > >
> > > Thanks in advance
> > >
> > > Philippe  

