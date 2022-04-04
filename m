Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F334F105A
	for <lists+linux-iio@lfdr.de>; Mon,  4 Apr 2022 09:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347106AbiDDH4h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Apr 2022 03:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiDDH4g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Apr 2022 03:56:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C119A3B286
        for <linux-iio@vger.kernel.org>; Mon,  4 Apr 2022 00:54:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 475966128D
        for <linux-iio@vger.kernel.org>; Mon,  4 Apr 2022 07:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222DDC2BBE4;
        Mon,  4 Apr 2022 07:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649058879;
        bh=HCDbBuldk57lyunh2sQw4SaJNufKK7hrTf7G8J96eFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bLK0nZmPc1AHw1bDPLvHml1GsefFaf1lXujaSZDCbAKsz5Do7IhrJhJqFyyjm1Kma
         vjk2VtQDhw+AiqnWvV/jj7UDAwguJqyj8pHj+FPDywYswqsewcUKiHnz0agAWpg79m
         +wtu80Nbdk/ri+0HglbUSCbqjWEsx9bJdsnVTERY=
Date:   Mon, 4 Apr 2022 09:54:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v3 07/13] iio: imu: add Bosch Sensortec BNO055 core driver
Message-ID: <YkqkPBlc9jt+jzph@kroah.com>
References: <20220217162710.33615-1-andrea.merello@gmail.com>
 <20220217162710.33615-8-andrea.merello@gmail.com>
 <ba1b2d78-bf4a-ec6d-88b8-76bbf2ff5e3e@pmeerw.net>
 <20220219174141.4937297a@jic23-huawei>
 <CAN8YU5OCEBTF37hb6ozaguJ0=svPyv+fmGGsLhoBCPZA5Odgdw@mail.gmail.com>
 <20220327171104.051fcbd2@jic23-huawei>
 <YkGx76vJUuKj2hVC@kroah.com>
 <CAN8YU5NyLvcNXZOQrKaK_CxN5M61pRX4Qpb-aNT18vvedh+JrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN8YU5NyLvcNXZOQrKaK_CxN5M61pRX4Qpb-aNT18vvedh+JrA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 04, 2022 at 08:30:51AM +0200, Andrea Merello wrote:
> Il giorno lun 28 mar 2022 alle ore 15:02 Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> ha scritto:
> >
> > On Sun, Mar 27, 2022 at 05:11:04PM +0100, Jonathan Cameron wrote:
> > > On Tue, 22 Mar 2022 11:27:14 +0100
> > > Andrea Merello <andrea.merello@gmail.com> wrote:
> > >
> > > > Il giorno sab 19 feb 2022 alle ore 18:34 Jonathan Cameron
> > > > <jic23@kernel.org> ha scritto:
> > > > >
> > > > > On Thu, 17 Feb 2022 22:58:14 +0100 (CET)
> > > > > Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:
> > > > >
> > > > > > On Thu, 17 Feb 2022, Andrea Merello wrote:
> > > > > >
> > > > > > nice work, minor comments below
> > > > >
> > > > > I'll review on top of Peter to save on duplication.
> > > > >
> > > > > Mostly really minor stuff.
> > >
> > > +CC Greg for binary attribute questions.
> > >
> > > >
> > > > :)
> > > >
> > > > As usual, comments inline; OK for all the rest.
> > > >
> > > > > Given this has crossed with the introduction of namespaces to quite
> > > > > a few IIO drivers (I have another series to do on that once I get
> > > > > caught up with reviews) I'd prefer it if you would move this into
> > > > > a symbol namespace (EXPORT_SYMBOL_NS_GPL() and appropriate namespace
> > > > > statements in the two bus modules.
> > > > >
> > > > > Save it being done as a follow up series.  If you prefer not to then
> > > > > that's fine too as it'll be a trivial follow up patch.
> > > >
> > > > I'll include it in V4 directly.
> > > >
> > > > [...]
> > > >
> > > > > > > +   case IIO_CHAN_INFO_SCALE:
> > > > > > > +           /* Table 3-31: 1 quaternion = 2^14 LSB */
> > > > > > > +           if (size < 2)
> > > > > > > +                   return -EINVAL;
> > > > > > > +           vals[0] = 1;
> > > > > > > +           vals[1] = 1 << 14;
> > > > > > > +           return IIO_VAL_FRACTIONAL_LOG2;
> > > > >
> > > > > This doesn't look right.  Not vals[1] = 14 given FRACTIONAL_LOG2?
> > > >
> > > > Hum.. maybe just IIO_VAL_FRACTIONAL ?
> > >
> > > That works as well, though I'd argue FRACTIONAL_LOG2 is the
> > > better option as it makes it clear the divisor is a power of 2
> > > and the precision might potentially be better as a result (I've not
> > > checked!)
> > >
> > > >
> > > > > > > +   default:
> > > > > > > +           return -EINVAL;
> > > > > > > +   }
> > > > > > > +}
> > > > > > > +
> > > >
> > > > [...]
> > > >
> > > > > > > +static IIO_DEVICE_ATTR_RO(sys_calibration_auto_status, 0);
> > > > > > > +static IIO_DEVICE_ATTR_RO(in_accel_calibration_auto_status, 0);
> > > > > > > +static IIO_DEVICE_ATTR_RO(in_gyro_calibration_auto_status, 0);
> > > > > > > +static IIO_DEVICE_ATTR_RO(in_magn_calibration_auto_status, 0);
> > > > > > > +static IIO_DEVICE_ATTR_RO(calibration_data, 0);
> > > > >
> > > > > This is documented as providing binary data but it's not using
> > > > > a binary attribute and that rather surprised me.
> > > > >
> > > > > Off the top of my head I can't recall why it matters though, so please
> > > > > take a look at whether a bin_attribute makes more sense for this.
> > > >
> > > > As far as I can see, it seems that a non-binary attributes only
> > > > support to be read at once while the binary attributes read()
> > > > operation supports random access i.e. it has the file position
> > > > parameter.
> > > >
> > > > The calibration data is "dynamic", it's read from the HW every time,
> > > > and I'm not sure it makes any sense to read it in several chunks (what
> > > > if we read a chunk and the calibration data is updated by the HW
> > > > before reading the second chunk?). So, despide the fitting "binary"
> > > > name I'm tempted to stick with regular attribute. However I'm not sure
> > > > this is the only difference related to binary attributes.
> > >
> > > +Cc Greg.  Valid choice to use a normal attribute for this?
> >
> > binary attributes are to ONLY be used for data that flows to/from a
> > device without the kernel ever modifying the data at all.  The kerneln
> > is just a pass-through here.
> >
> > There are a few minor exceptions, but they were exceptions, please don't
> > use them as a valid reason to use a binary attribute.
> >
> > does that help?
> 
> Thanks. Here the driver doesn't modify the data, so no probl here about this.
> 
> Would it be valid to restrict usage to only complete reads from the
> start to the end on calibration data i.e. returning -EINVAL when
> read() function is called with pos != 0 or count < actual data size ?

That's up to you.
