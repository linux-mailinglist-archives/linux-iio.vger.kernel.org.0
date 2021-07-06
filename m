Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF9F3BC7D1
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jul 2021 10:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhGFI3N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 6 Jul 2021 04:29:13 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3365 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhGFI3N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jul 2021 04:29:13 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GJwNk2bDrz6GCVg;
        Tue,  6 Jul 2021 16:15:50 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 6 Jul 2021 10:26:33 +0200
Received: from localhost (10.47.82.155) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Tue, 6 Jul 2021
 09:26:33 +0100
Date:   Tue, 6 Jul 2021 09:26:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lotfi FEJRI <fejri.lotfi@gmail.com>
CC:     <linux-iio@vger.kernel.org>
Subject: Re: Question about BMI160 drivers (Xilinx)
Message-ID: <20210706092617.00007406@Huawei.com>
In-Reply-To: <CAH-J=mcEQAbVtFoe8vvw-38dDZi_1=AHaA==+GN-=u_0gvfSug@mail.gmail.com>
References: <CAH-J=mcHGBY0cDFpv5H53xPEghP6qoMuQVomVH907mmcoL2O8g@mail.gmail.com>
        <CAH-J=mcEQAbVtFoe8vvw-38dDZi_1=AHaA==+GN-=u_0gvfSug@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.82.155]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 5 Jul 2021 17:13:44 +0200
Lotfi FEJRI <fejri.lotfi@gmail.com> wrote:

> Le lun. 5 juil. 2021 à 17:11, Lotfi FEJRI <fejri.lotfi@gmail.com> a écrit :
> >
> > Hello,
> >
> > I am trying to run your BMI160 (available on the Xilinx github) on the
> > Xilinx ZedBoard, through I2C.
> > I'm able to build the drivers with Petalinux (v2019.1) and to run
> > (modprobe ***.ko) them without issues on the ZedBoard:
> >
> > - bmi160_core.ko
> > - bmi160_i2c.ko
> > - bmi160_spi.ko
> >
> >
> >
> > here is the device-tree I added for the sensor:
> >
> >
> >
> >
> > When I run "i2cdetect -y -r 0" I can see that the device and the i2c
> > interface is recognized. I can see "UU" inside 0x68 (which seems to be
> > the I2C address), nothing more than this.
> >
> > My question is: How is it possible to read and save the data in a txt
> > file? I don't see which function I have to call to read the data.
> > The only one related to getting the data is "bmi160_get_data" from
> > bmi160_core.c but I don't know how to call this function...
> >
> > Please, can you help me on this?
> >
> > Thank you!
> >
> > Kind regards,
> >
> > Lotfi  
> 

Images are going to reach the list, so stick to text.

Do you have any indication the driver successfully bound to the device? 
Look to see what you have in
/sys/bus/iio/devices/

If the driver is connected you can just cat from the relevant files
under the deviceX directory.

Interrupt driven approaches also possible.  Take a look at the tools
under tools/iio/ in the kernel source tree.  The generic buffer code
should dump a pretty formatted version of what is being read form the
device and you can pipe that to a file.

Jonathan
