Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD21BAEBC1
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2019 15:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfIJNkC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 10 Sep 2019 09:40:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57790 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727815AbfIJNkC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Sep 2019 09:40:02 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0879F4319584078F2FDD;
        Tue, 10 Sep 2019 21:39:58 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 10 Sep 2019
 21:39:54 +0800
Date:   Tue, 10 Sep 2019 14:39:46 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/8] add magnetometer support for MPU925x
Message-ID: <20190910143946.00002324@huawei.com>
In-Reply-To: <MN2PR12MB337376A70BB66E8F7A3997D2C4B70@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <20190829151801.13014-1-jmaneyrol@invensense.com>
        <20190908124242.21669f1f@archlinux>
        <MN2PR12MB337376A70BB66E8F7A3997D2C4B70@MN2PR12MB3373.namprd12.prod.outlook.com>
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

On Mon, 9 Sep 2019 09:55:59 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hi Jonathan,
> 
> we could add a check on the DT for i2c-gate node.
> We also need to add a check on the ACPI configuration used by the ASUS T100TA device.

Great.

> 
> In this case, do you think it is still valuable to have a Kconfig option? (this can still help to reduce driver footprint)

It's less painful if the only reason is tinyfication, but then I want
numbers in the patch to show it makes a significant difference.

Kconfig options are just more things to test so generally prefer
to avoid them for little additions like this.

Thanks,

Jonathan
> 
> Thanks.
> JB
> 
> 
> From: Jonathan Cameron <jic23@kernel.org>
> 
> Sent: Sunday, September 8, 2019 13:42
> 
> To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
> 
> Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
> 
> Subject: Re: [PATCH 0/8] add magnetometer support for MPU925x
> 
>  
> 
> 
>  CAUTION: This email originated from outside of the organization. Please make sure the sender is who they say they are and do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> 
> On Thu, 29 Aug 2019 15:18:33 +0000
> 
> Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:
> 
> 
> 
> > This serie of patches adds support of magnetometer inside MPU925x chips.  
> 
> > It is using the MPU i2c master to drive the integrated magnetometer and  
> 
> > read data into the MPU FIFO.  
> 
> >   
> 
> > Beware that this is disabling access to the i2c auxiliary bus. Since this  
> 
> > can break existing setup, it is an optional feature requiring to enable  
> 
> > the corresponding Kconfig option.  
> 
> 
> 
> That's not great... People will fail to set that correctly for their
> 
> setup even if there is a 'correct' setting.
> 
> 
> 
> So we need more information to risk that breakage + discussions of
> 
> ways to avoid it.  Can we for example check if the auxiliary bus is
> 
> in use? (DT binding for example - check for the i2c-gate node?)
> 
> 
> 
> Jonathan
> 
> 
> 
> >   
> 
> > Jean-Baptiste Maneyrol (8):  
> 
> >   iio: imu: inv_mpu6050: disable i2c mux for 925x under Kconfig  
> 
> >   iio: imu: inv_mpu6050: add header include protection macro  
> 
> >   iio: imu: inv_mpu6050: add defines for supporting 9-axis chips  
> 
> >   iio: imu: inv_mpu6050: fix objects syntax in Makefile  
> 
> >   iio: imu: inv_mpu6050: helpers for using i2c master on auxiliary bus  
> 
> >   iio: imu: inv_mpu6050: add magnetometer implementation for MPU925x  
> 
> >   iio: imu: inv_mpu6050: add magnetometer support inside mpu driver  
> 
> >   iio: imu: inv_mpu6050: add fifo support for magnetometer data  
> 
> >   
> 
> >  drivers/iio/imu/inv_mpu6050/Kconfig           |   9 +  
> 
> >  drivers/iio/imu/inv_mpu6050/Makefile          |   8 +-  
> 
> >  .../iio/imu/inv_mpu6050/inv_mpu9250_magn.c    | 239 ++++++++++++++++++  
> 
> >  .../iio/imu/inv_mpu6050/inv_mpu9250_magn.h    |  27 ++  
> 
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c     | 191 ++++++++++++++  
> 
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h     |  46 ++++  
> 
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 141 ++++++++++-  
> 
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |   5 +  
> 
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  79 +++++-  
> 
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c    | 120 +++++++++  
> 
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h    | 107 ++++++++  
> 
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  14 +-  
> 
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  90 ++++++-  
> 
> >  13 files changed, 1055 insertions(+), 21 deletions(-)  
> 
> >  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.c  
> 
> >  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.h  
> 
> >  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c  
> 
> >  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h  
> 
> >  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c  
> 
> >  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h  
> 
> >   
> 
> 
> 


