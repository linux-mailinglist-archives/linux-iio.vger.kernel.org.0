Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8606669B25
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jan 2023 15:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjAMO7E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Jan 2023 09:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjAMO6S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Jan 2023 09:58:18 -0500
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 092BA983DA
        for <linux-iio@vger.kernel.org>; Fri, 13 Jan 2023 06:45:46 -0800 (PST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id 44526DF00AB; Fri, 13 Jan 2023 15:45:43 +0100 (CET)
Date:   Fri, 13 Jan 2023 15:45:44 +0100
From:   Philippe De Muyter <phdm@macq.eu>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Subject: Re: sysfs mount_matrix for st_lsm6dsx gyro
Message-ID: <20230113144544.GA32740@frolo.macqel>
References: <20230111120940.GA23351@frolo.macqel> <20230111171732.00006941@Huawei.com> <Y7/YB1CmEzbnNogP@lore-desk> <20230112112704.GA17933@frolo.macqel> <Y7/vu7IwRmQS7CSf@lore-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7/vu7IwRmQS7CSf@lore-desk>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jan 12, 2023 at 12:32:11PM +0100, Lorenzo Bianconi wrote:
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

The compilation fails because there is already something different with
that same name in drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:715:30: error: conflicting type qualifiers for ‘st_lsm6dsx_ext_info’
  static const struct iio_info st_lsm6dsx_ext_info = {
                               ^~~~~~~~~~~~~~~~~~~
 In file included from drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:31:0:
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h:498:46: note: previous definition of ‘st_lsm6dsx_ext_info’ was here
 struct iio_chan_spec_ext_info __maybe_unused st_lsm6dsx_ext_info[] = {


Best regards

Philippe
