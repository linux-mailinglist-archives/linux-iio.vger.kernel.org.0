Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9232768C027
	for <lists+linux-iio@lfdr.de>; Mon,  6 Feb 2023 15:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjBFOdm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Feb 2023 09:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjBFOdh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Feb 2023 09:33:37 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C5F23DB1
        for <linux-iio@vger.kernel.org>; Mon,  6 Feb 2023 06:33:34 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P9TCm5W3Qz6J7d7;
        Mon,  6 Feb 2023 22:29:08 +0800 (CST)
Received: from localhost (10.81.207.58) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 6 Feb
 2023 14:33:31 +0000
Date:   Mon, 6 Feb 2023 14:33:28 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Philippe De Muyter <phdm@macq.eu>,
        <linux-iio@vger.kernel.org>
Subject: Re: st_lsm6dsx : first two values of ism330dlc_gyro are wrong
Message-ID: <20230206143328.000056cc@Huawei.com>
In-Reply-To: <Y+DPMBFHo9UxU+fK@lore-desk>
References: <20230205101223.GA10729@frolo.macqel>
        <20230205141342.10dbc447@jic23-huawei>
        <Y+DPMBFHo9UxU+fK@lore-desk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.207.58]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Mon, 6 Feb 2023 10:58:08 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > On Sun, 5 Feb 2023 11:12:23 +0100
> > Philippe De Muyter <phdm@macq.eu> wrote:
> >   
> > > Hello Lorenzo and list,
> > > 
> > > I use the imu/st_lsm6dsx (i2c) driver to drive a ism330dlc imu.
> > > 
> > > Every time I start a new acquisition of gyro values, the first two
> > > values read are wrong, as can be see here :
> > > 
> > >  $ sudo ./iio_generic_buffer -n ism330dlc_gyro -g -c 10 -a
> > >  iio device number being used is 1
> > >  trigger-less mode selected
> > >  No channels are enabled, enabling all channels
> > >  Enabling: in_anglvel_z_en
> > >  Enabling: in_timestamp_en
> > >  Enabling: in_anglvel_y_en
> > >  Enabling: in_anglvel_x_en
> > >  -0.138924 -0.915246 0.470628 1675591514696125669
> > >  -0.012699 -0.362151 0.143208 1675591514772675669
> > >  0.001989 -0.076500 0.035190 1675591514849250669
> > >  0.002295 -0.076194 0.035343 1675591514925825669
> > >  0.002142 -0.076041 0.035343 1675591515002400669
> > >  0.001989 -0.076041 0.035343 1675591515078975669
> > >  0.001836 -0.076347 0.035649 1675591515155525669
> > >  0.001836 -0.076500 0.035649 1675591515232075669
> > >  0.001989 -0.076500 0.035649 1675591515308625669
> > >  0.001989 -0.076347 0.035649 1675591515385200669
> > >  Disabling: in_anglvel_z_en
> > >  Disabling: in_timestamp_en
> > >  Disabling: in_anglvel_y_en
> > >  Disabling: in_anglvel_x_en
> > >  $
> > > 
> > > Is that a normal behaviour for a gyro in that family or is it be caused
> > > by a software or hardware bug ?  
> > 
> > So, some random thoughts on what might be going on...
> > 1) Stale data in the fifo.  Could you run this experiment twice whilst being
> >    careful not to move the device between the runs.  If we still see the wrong
> >    values at the start then it's not that...  
> 
> When the device is powered-down we set the FIFO in bypass mode and in-flight
> samples are discarded.
> 
> > 
> > 2) Device takes a little whilst to stabilize. Possibly this is down to the
> >    low pass filters requiring a few samples before they deliver stable output.
> >    From a quick glance I don't think we provide any userspace control of those
> >    filters and I think LPR1 is left in default state of disabled.  
> 
> I would say this issue is related to the "Accelerometer and gyroscope
> turn-on/off time" (section 3.9 in the sensor application note).
> 
> https://www.st.com/resource/en/application_note/an5125-ism330dlc-3d-accelerometer-and-3d-gyroscope-with-digital-output-for-industrial-applications-stmicroelectronics.pdf
> 
> @Jonathan: do you think we should discard these sample in the driver or in the
> user-space app? I would say this can be a general issue. What do you think?

In driver.  This isn't an uncommon problem for sensors and userspace would in 
general have no idea how many samples to drop.  Also dependent on the sampling
rates etc so if we support control of those, we'll want to have the driver
drop the right number of samples.  Though yikes at the top end. You can have
to drop 540 samples... Ah well. That is at 6kHz sampling so still not very long.

The only alternative would be to expose the current number to drop to userspace
but then existing userspace code would not drop them.  Hence I think it needs
to be in driver.

Jonathan


> 
> Regards,
> Lorenzo
> 
> > 
> > You could try messing with the sampling frequency as that may affect the number
> > of bad samples you see and give us more of a clue (it affects lpf2 directly).
> > 
> > Jonathan
> >   
> > > 
> > > Best regards
> > > 
> > > Philippe
> > >   
> >   
> 

