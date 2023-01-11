Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2195666194
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jan 2023 18:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbjAKRRk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 11 Jan 2023 12:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjAKRRi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Jan 2023 12:17:38 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740C032183
        for <linux-iio@vger.kernel.org>; Wed, 11 Jan 2023 09:17:35 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NsZ5l3dYyz6J7Ts;
        Thu, 12 Jan 2023 01:13:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 17:17:32 +0000
Date:   Wed, 11 Jan 2023 17:17:32 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Philippe De Muyter <phdm@macq.eu>
CC:     <lorenzo@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: sysfs mount_matrix for st_lsm6dsx gyro
Message-ID: <20230111171732.00006941@Huawei.com>
In-Reply-To: <20230111120940.GA23351@frolo.macqel>
References: <20230111120940.GA23351@frolo.macqel>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Wed, 11 Jan 2023 13:09:40 +0100
Philippe De Muyter <phdm@macq.eu> wrote:

> Hello Lorenzo and list,
> 
> I do not find a "*mount_matrix" entry in sysfs for a 'ism330dlc_gyro'
> iio device.
> Is that normal ?
> Is a fix available ?

Looks like the channel definition for the gyro does not include an
appropriate ext_info entry unlike the accelerometer channels which
have one with mount_matrix support.

From a quick glance looks like a simple fix. Add that entry.
> 
> Some more info :
> 
> I have backported  drivers/iio/imu/st_lsm6dsx to linux-4.9 in order
> to drive a ism330dlc imu on a custom board.  The chip is correctly
> detected and two devices are created in /sys/bus/iio/devices/
> 
> the first one (where name is 'ism330dlc_gyro') has the following entries :
> 
>  me@proto4:~$ ls /sys/bus/iio/devices/iio\:device1/
>  buffer                      in_anglvel_x_raw  sampling_frequency
>  current_timestamp_clock     in_anglvel_y_raw  sampling_frequency_available
>  dev                         in_anglvel_z_raw  scan_elements
>  in_anglvel_scale            name              subsystem
>  in_anglvel_scale_available  power             uevent
>  me@proto4:~$
> 
> the second one (where name is 'ism330dlc_accel') has those entries :
> 
>  me@proto4:~$ ls /sys/bus/iio/devices/iio\:device2
>  buffer                    in_accel_x_raw  sampling_frequency
>  current_timestamp_clock   in_accel_y_raw  sampling_frequency_available
>  dev                       in_accel_z_raw  scan_elements
>  events                    mount_matrix    subsystem
>  in_accel_scale            name            uevent
>  in_accel_scale_available  power
>  me@proto4:~$
> 
> The 'mount_matrix' entry is only present in the 'ism330dlc_accel' device
> but not in the 'ism330dlc_gyro' device.
> 
> On a similar board, but with mpu9250 imu, I get only one iio:deviceX
> entry but with two *mount_matrix entries : 
> 
> 	in_accel_mount_matrix
> 	in_anglvel_mount_matrix
> 
> In both cases, I would have expected only one 'iio:deviceX' entry with
> only one 'mount_matrix' entry.

There are multiple devices because the driver predates the addition
of multiple buffer support to IIO and IIRC is capable of producing data
at different sampling rates for the accelerometer and the gyros.
Hence when it was implemented the only choice was to register multiple
devices in order to get the multiple buffers. It's ABI now so we can't
fix it in an old driver unfortunately.  We'd do this differently today..

The double mount_matrix for the mpu9250 is a little odd and I can't
immediately spot why that one is happening.


> 
> Best regards
> 
> Philippe
> 

