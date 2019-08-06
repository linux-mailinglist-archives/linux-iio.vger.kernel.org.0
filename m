Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8EC82E80
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2019 11:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbfHFJQH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 6 Aug 2019 05:16:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36474 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728845AbfHFJQH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Aug 2019 05:16:07 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2F694C01BE73E5489AC0;
        Tue,  6 Aug 2019 17:16:05 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 6 Aug 2019
 17:16:01 +0800
Date:   Tue, 6 Aug 2019 10:15:53 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
CC:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: add header include protection
 macro
Message-ID: <20190806101553.00004245@huawei.com>
In-Reply-To: <BYAPR12MB3366E1F9CA2A951762E4C726C4D50@BYAPR12MB3366.namprd12.prod.outlook.com>
References: <20190805122513.8399-1-jmaneyrol@invensense.com>
        <20190805173226.71757a05@archlinux>
        <BYAPR12MB3366E1F9CA2A951762E4C726C4D50@BYAPR12MB3366.namprd12.prod.outlook.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 6 Aug 2019 08:05:09 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hi Jonathan,
> 
> this is required for further patches coming soon.
> 
> I am planning to add support for full 9-axis on MPU9250, using the chip i2c master to drive the integrated magnetometer and retrieve all data in the MPU FIFO. It will be behind a kernel config option to not break existing support driving the magnetometer from the kernel.
> 
> Hope to have this cleaned-up and ready soon.

OK. Just send this one as a precursor in that series as then the purpose
should be obvious.

Thanks,

Jonathan

> 
> Best regards,
> JB
> 
> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> on behalf of Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
> 
> Sent: Monday, August 5, 2019 18:32
> 
> To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
> 
> Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
> 
> Subject: Re: [PATCH] iio: imu: inv_mpu6050: add header include protection macro
> 
>  
> 
> 
>  CAUTION: This email originated from outside of the organization. Please make sure the sender is who they say they are and do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> 
> On Mon, 5 Aug 2019 12:25:43 +0000
> 
> Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:
> 
> 
> 
> > Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>  
> 
> No problem with adding this,  but why specifically did you do so?
> 
> 
> 
> Thanks,
> 
> 
> 
> Jonathan
> 
> 
> 
> > ---  
> 
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h | 6 ++++++  
> 
> >  1 file changed, 6 insertions(+)  
> 
> >   
> 
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  
> 
> > index db1c6904388b..e64eb978e810 100644  
> 
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  
> 
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  
> 
> > @@ -2,6 +2,10 @@  
> 
> >  /*  
> 
> >  * Copyright (C) 2012 Invensense, Inc.  
> 
> >  */  
> 
> > +  
> 
> > +#ifndef INV_MPU_IIO_H_  
> 
> > +#define INV_MPU_IIO_H_  
> 
> > +  
> 
> >  #include <linux/i2c.h>  
> 
> >  #include <linux/i2c-mux.h>  
> 
> >  #include <linux/mutex.h>  
> 
> > @@ -342,3 +346,5 @@ void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);  
> 
> >  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,  
> 
> >                int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type);  
> 
> >  extern const struct dev_pm_ops inv_mpu_pmops;  
> 
> > +  
> 
> > +#endif  
> 
> 
> 


