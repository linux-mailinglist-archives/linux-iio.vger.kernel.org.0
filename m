Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BA6667105
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jan 2023 12:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjALLf6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Jan 2023 06:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjALLfP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Jan 2023 06:35:15 -0500
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E10FBE1E
        for <linux-iio@vger.kernel.org>; Thu, 12 Jan 2023 03:27:06 -0800 (PST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id 324F0DF00AB; Thu, 12 Jan 2023 12:27:03 +0100 (CET)
Date:   Thu, 12 Jan 2023 12:27:04 +0100
From:   Philippe De Muyter <phdm@macq.eu>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Subject: Re: sysfs mount_matrix for st_lsm6dsx gyro
Message-ID: <20230112112704.GA17933@frolo.macqel>
References: <20230111120940.GA23351@frolo.macqel> <20230111171732.00006941@Huawei.com> <Y7/YB1CmEzbnNogP@lore-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7/YB1CmEzbnNogP@lore-desk>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Lorenzo,

On Thu, Jan 12, 2023 at 10:51:03AM +0100, Lorenzo Bianconi wrote:
> Date: Thu, 12 Jan 2023 10:51:03 +0100
> From: Lorenzo Bianconi <lorenzo@kernel.org>
> To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Philippe De Muyter <phdm@macq.eu>, linux-iio@vger.kernel.org
> Subject: Re: sysfs mount_matrix for st_lsm6dsx gyro
> 
> > On Wed, 11 Jan 2023 13:09:40 +0100
> > Philippe De Muyter <phdm@macq.eu> wrote:
> > 
> > > Hello Lorenzo and list,
> > > 
> > > I do not find a "*mount_matrix" entry in sysfs for a 'ism330dlc_gyro'
> > > iio device.
> > > Is that normal ?
> > > Is a fix available ?
> > 
> > Looks like the channel definition for the gyro does not include an
> > appropriate ext_info entry unlike the accelerometer channels which
> > have one with mount_matrix support.
> > 
> > From a quick glance looks like a simple fix. Add that entry.
> 
> I am not sure if accel and gyro can be mounted with a different orientation.
> Do you think we should have a per-sensor mount_matrix?

My chip is a 'ism330dlc'.  It's one chip containing an accel and a gyro,
so the mount_matrix should be the same for the accel and the gyro.
Unfortunately the accel and the gyro are presented in /sysfs as two
separate devices, and only the accel one has a 'mount_matrix' entry.
So a user looking for any gyro will find the gyro entry, but without
'mount_matrix'.

I have followed Jonathan's proposal and added this simple patch in
the definition of the ST_LSM6DSX_CHANNEL macro :

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index d80ba2e688ed..9d18145d5041 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -96,6 +96,7 @@ enum st_lsm6dsx_hw_id {
 		.storagebits = 16,                                      \
 		.endianness = IIO_LE,                                   \
	},                                                              \
+	.ext_info = st_lsm6dsx_accel_ext_info,                          \
 }

 struct st_lsm6dsx_reg {

Another fix would be to create only one chip entry in sysfs, but that's
above my knowledge of this driver.

Best regards

Philippe
