Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFF761E1F5
	for <lists+linux-iio@lfdr.de>; Sun,  6 Nov 2022 13:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiKFMBT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Nov 2022 07:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKFMBT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2022 07:01:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6229FB7D8
        for <linux-iio@vger.kernel.org>; Sun,  6 Nov 2022 04:01:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BA553CE0B7F
        for <linux-iio@vger.kernel.org>; Sun,  6 Nov 2022 12:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E62FC433C1;
        Sun,  6 Nov 2022 12:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667736074;
        bh=ZPBjd5PzZSfhA//VcdXs9XQN9Lv6kj+b9OvK5ReiQtg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nl/JvgiEltbRtCmQ/T5rCUpGuvOkZi9HOJvXumwLOitFGinNbaj1DQT0hs5sOvpms
         wUwpufegJ+EiOyzQpk78aaVBt+Q15ZtaaRZMeJapG0BVztJFn+xYhOjzABVv7Mgivz
         amfey2P4B5YkBXzLrelWShvjtOz1dkAK3ItiGLxlzeJ0E5CxdPQ9kP9nU+O+NqgN+L
         cpcpo1XP8+qJKayKmtCdsrCGvnVT4m1CnC0dY8WdNK4zyz4mv72VEcUgt4ffd5G4Lr
         C8Xy4d1gVIhjpwOETLXTMJZa04G+NflRMPuBpRG367DPB3jDMOPJhSgOoLio6cwzSq
         /W2Zx8kG3oIjA==
Date:   Sun, 6 Nov 2022 12:01:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        mario.tesi@st.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: introduce sw trigger support
Message-ID: <20221106120107.00a73102@jic23-huawei>
In-Reply-To: <Y11wZ9yGCmOMAf/x@lore-desk>
References: <93ae6ff1150b531a9d7a4d3d1b1adb8383613717.1666955685.git.lorenzo@kernel.org>
        <20221029162029.31f8291a@jic23-huawei>
        <Y11wZ9yGCmOMAf/x@lore-desk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

...

> > > +static irqreturn_t st_lsm6dsx_sw_trigger_handler_thread(int irq,
> > > +							void *private)
> > > +{
> > > +	struct iio_poll_func *pf = private;
> > > +	struct iio_dev *iio_dev = pf->indio_dev;
> > > +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> > > +	struct st_lsm6dsx_hw *hw = sensor->hw;
> > > +
> > > +	if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
> > > +	    sensor->id == ST_LSM6DSX_ID_EXT1 ||
> > > +	    sensor->id == ST_LSM6DSX_ID_EXT2)
> > > +		st_lsm6dsx_shub_read_output(hw,
> > > +					    (u8 *)hw->scan[sensor->id].channels,
> > > +					    sizeof(hw->scan[sensor->id].channels));  
> > 
> > Are we guaranteed this particular size of readback?  I'm guessing a bit
> > as it's been a long time since I looked at this driver in detail, but could
> > we have sensors with either a different number of axes or different number
> > of registers per axis?
> > 
> > It might be neater to have two handlers, one for the EXTN cases and one
> > for the main sensors.  That would push this conditional down to the
> > point of registration.  I'm not sure it's worth it however so up to you...  
> 
> Hi Jonathan,
> 
> so far we support just magnetometers on sensor-hub (LIS2MDL and LIS3MDL).
> Both LIS2MDL and LIS3MDL have 3 axis, each of them is le16, so it is fine as it
> is for the moment. Do you prefer to be more generic and take into account new
> possible sensors? I am not sure when they will arrive :)

Fine as it stands.  You've thought about it and decided to postpone such a
change until it is necessary and that's fine by me.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to poke at the tree and see if we missed anything.

Thanks,

Jonathan
