Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEB4667937
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jan 2023 16:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjALP2V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Jan 2023 10:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240325AbjALP06 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Jan 2023 10:26:58 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8064A44C73
        for <linux-iio@vger.kernel.org>; Thu, 12 Jan 2023 07:19:41 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nt7WR334vz6J9gt;
        Thu, 12 Jan 2023 23:19:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 15:19:38 +0000
Date:   Thu, 12 Jan 2023 15:19:37 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Philippe De Muyter <phdm@macq.eu>, <linux-iio@vger.kernel.org>
Subject: Re: sysfs mount_matrix for st_lsm6dsx gyro
Message-ID: <20230112151937.0000505a@Huawei.com>
In-Reply-To: <Y7/vu7IwRmQS7CSf@lore-desk>
References: <20230111120940.GA23351@frolo.macqel>
        <20230111171732.00006941@Huawei.com>
        <Y7/YB1CmEzbnNogP@lore-desk>
        <20230112112704.GA17933@frolo.macqel>
        <Y7/vu7IwRmQS7CSf@lore-desk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 12 Jan 2023 12:32:11 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > Hello Lorenzo,
> > 
> > On Thu, Jan 12, 2023 at 10:51:03AM +0100, Lorenzo Bianconi wrote:  
> > > Date: Thu, 12 Jan 2023 10:51:03 +0100
> > > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > > To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Philippe De Muyter <phdm@macq.eu>, linux-iio@vger.kernel.org
> > > Subject: Re: sysfs mount_matrix for st_lsm6dsx gyro
> > >   
> > > > On Wed, 11 Jan 2023 13:09:40 +0100
> > > > Philippe De Muyter <phdm@macq.eu> wrote:
> > > >   
> > > > > Hello Lorenzo and list,
> > > > > 
> > > > > I do not find a "*mount_matrix" entry in sysfs for a 'ism330dlc_gyro'
> > > > > iio device.
> > > > > Is that normal ?
> > > > > Is a fix available ?  
> > > > 
> > > > Looks like the channel definition for the gyro does not include an
> > > > appropriate ext_info entry unlike the accelerometer channels which
> > > > have one with mount_matrix support.
> > > > 
> > > > From a quick glance looks like a simple fix. Add that entry.  
> > > 
> > > I am not sure if accel and gyro can be mounted with a different orientation.
> > > Do you think we should have a per-sensor mount_matrix?  
> > 
> > My chip is a 'ism330dlc'.  It's one chip containing an accel and a gyro,
> > so the mount_matrix should be the same for the accel and the gyro.
> > Unfortunately the accel and the gyro are presented in /sysfs as two
> > separate devices, and only the accel one has a 'mount_matrix' entry.
> > So a user looking for any gyro will find the gyro entry, but without
> > 'mount_matrix'.
> > 
> > I have followed Jonathan's proposal and added this simple patch in
> > the definition of the ST_LSM6DSX_CHANNEL macro :
> > 
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > index d80ba2e688ed..9d18145d5041 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -96,6 +96,7 @@ enum st_lsm6dsx_hw_id {
> >  		.storagebits = 16,                                      \
> >  		.endianness = IIO_LE,                                   \
> > 	},                                                              \
> > +	.ext_info = st_lsm6dsx_accel_ext_info,                          \
> >  }  
> 
> I am fine with this approach, probably having a per-sensor mount_matrix is
> unnecessary. Can you please just rename st_lsm6dsx_accel_ext_info in
> st_lsm6dsx_ext_info?
> 
> Regards,
> Lorenzo
> 
> > 
> >  struct st_lsm6dsx_reg {
> > 
> > Another fix would be to create only one chip entry in sysfs, but that's
> > above my knowledge of this driver.

We can't make that change. It would be ABI breakage - userspace code would
stop working.  

Jonathan

> > 
> > Best regards
> > 
> > Philippe  
> 

