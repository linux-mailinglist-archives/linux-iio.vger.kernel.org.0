Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273ED4E88A4
	for <lists+linux-iio@lfdr.de>; Sun, 27 Mar 2022 18:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiC0QFO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Mar 2022 12:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbiC0QFN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Mar 2022 12:05:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4BBE0B9
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 09:03:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13B2D6106C
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 16:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC531C340EC;
        Sun, 27 Mar 2022 16:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648397012;
        bh=HVO0AklOw87ya2p82O6e/QG5Qk+oaFLWHj2PHbpF+Xk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iwR03V3cpbOx4Rk5M2r6BNQ7I//w5bY3ryKgC/hwlejmvTIBFz2ogP2erIpeweBPx
         jxm62hFg10Da6iXv3igB266G/tqtvnfMmDbxN8j0fxSbPcIxirfFpSnLhqmeSWfdln
         /iaoGGxTi2DbENi9xQidPGBz8NTodwMqkvJso8eO1H4b983nDKfzDAZa8bCJHDsVbg
         0BN3PjBjJ4Q7noNW3eKoMb5v1eE9TJKXfgfl/GeRwIIVcVdjtSGuTi6v5C3ikCd89Z
         gEpbDkZO1whksJsBr6MEk0PGNepsSyw/nEb5rWgiTKJ3vwr/Xi6Vuj8eS85wv+v42j
         tubGzG/7rReww==
Date:   Sun, 27 Mar 2022 17:11:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andrea Merello <andrea.merello@iit.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [v3 07/13] iio: imu: add Bosch Sensortec BNO055 core driver
Message-ID: <20220327171104.051fcbd2@jic23-huawei>
In-Reply-To: <CAN8YU5OCEBTF37hb6ozaguJ0=svPyv+fmGGsLhoBCPZA5Odgdw@mail.gmail.com>
References: <20220217162710.33615-1-andrea.merello@gmail.com>
        <20220217162710.33615-8-andrea.merello@gmail.com>
        <ba1b2d78-bf4a-ec6d-88b8-76bbf2ff5e3e@pmeerw.net>
        <20220219174141.4937297a@jic23-huawei>
        <CAN8YU5OCEBTF37hb6ozaguJ0=svPyv+fmGGsLhoBCPZA5Odgdw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 22 Mar 2022 11:27:14 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> Il giorno sab 19 feb 2022 alle ore 18:34 Jonathan Cameron
> <jic23@kernel.org> ha scritto:
> >
> > On Thu, 17 Feb 2022 22:58:14 +0100 (CET)
> > Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:
> >  
> > > On Thu, 17 Feb 2022, Andrea Merello wrote:
> > >
> > > nice work, minor comments below  
> >
> > I'll review on top of Peter to save on duplication.
> >
> > Mostly really minor stuff.  

+CC Greg for binary attribute questions.

> 
> :)
> 
> As usual, comments inline; OK for all the rest.
> 
> > Given this has crossed with the introduction of namespaces to quite
> > a few IIO drivers (I have another series to do on that once I get
> > caught up with reviews) I'd prefer it if you would move this into
> > a symbol namespace (EXPORT_SYMBOL_NS_GPL() and appropriate namespace
> > statements in the two bus modules.
> >
> > Save it being done as a follow up series.  If you prefer not to then
> > that's fine too as it'll be a trivial follow up patch.  
> 
> I'll include it in V4 directly.
> 
> [...]
> 
> > > > +   case IIO_CHAN_INFO_SCALE:
> > > > +           /* Table 3-31: 1 quaternion = 2^14 LSB */
> > > > +           if (size < 2)
> > > > +                   return -EINVAL;
> > > > +           vals[0] = 1;
> > > > +           vals[1] = 1 << 14;
> > > > +           return IIO_VAL_FRACTIONAL_LOG2;  
> >
> > This doesn't look right.  Not vals[1] = 14 given FRACTIONAL_LOG2?  
> 
> Hum.. maybe just IIO_VAL_FRACTIONAL ?

That works as well, though I'd argue FRACTIONAL_LOG2 is the
better option as it makes it clear the divisor is a power of 2
and the precision might potentially be better as a result (I've not
checked!)

> 
> > > > +   default:
> > > > +           return -EINVAL;
> > > > +   }
> > > > +}
> > > > +  
> 
> [...]
> 
> > > > +static IIO_DEVICE_ATTR_RO(sys_calibration_auto_status, 0);
> > > > +static IIO_DEVICE_ATTR_RO(in_accel_calibration_auto_status, 0);
> > > > +static IIO_DEVICE_ATTR_RO(in_gyro_calibration_auto_status, 0);
> > > > +static IIO_DEVICE_ATTR_RO(in_magn_calibration_auto_status, 0);
> > > > +static IIO_DEVICE_ATTR_RO(calibration_data, 0);  
> >
> > This is documented as providing binary data but it's not using
> > a binary attribute and that rather surprised me.
> >
> > Off the top of my head I can't recall why it matters though, so please
> > take a look at whether a bin_attribute makes more sense for this.  
> 
> As far as I can see, it seems that a non-binary attributes only
> support to be read at once while the binary attributes read()
> operation supports random access i.e. it has the file position
> parameter.
> 
> The calibration data is "dynamic", it's read from the HW every time,
> and I'm not sure it makes any sense to read it in several chunks (what
> if we read a chunk and the calibration data is updated by the HW
> before reading the second chunk?). So, despide the fitting "binary"
> name I'm tempted to stick with regular attribute. However I'm not sure
> this is the only difference related to binary attributes.

+Cc Greg.  Valid choice to use a normal attribute for this?

> 
> > > > +
> > > > +static IIO_DEVICE_ATTR_RO(serial_number, 0);
> > > > +
> > > > +static struct attribute *bno055_attrs[] = {
> > > > +   &iio_dev_attr_in_accel_range_raw_available.dev_attr.attr,  
> >
> > discussed in ABI documentation review.
> > I think these should be range_input to avoid implication they are
> > in _raw units (i.e. need _scale to be applied)  
> 
> They are raw indeed; they need scale to be applied, then they become m/s^2.
> 
> I'll fix the doc to clarify this.

Ah. Ok.

> 
> [...]
> 
> > > > +
> > > > +   priv->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> > > > +   if (IS_ERR(priv->reset_gpio))
> > > > +           return dev_err_probe(dev, PTR_ERR(priv->reset_gpio), "Failed to get reset GPIO");
> > > > +
> > > > +   priv->clk = devm_clk_get_optional(dev, "clk");
> > > > +   if (IS_ERR(priv->clk))
> > > > +           return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to get CLK");
> > > > +
> > > > +   ret = clk_prepare_enable(priv->clk);
> > > > +   if (ret)
> > > > +           return ret;
> > > > +
> > > > +   ret = devm_add_action_or_reset(dev, bno055_clk_disable, priv->clk);
> > > > +   if (ret)
> > > > +           return ret;
> > > > +
> > > > +   if (priv->reset_gpio) {
> > > > +           usleep_range(5000, 10000);
> > > > +           gpiod_set_value_cansleep(priv->reset_gpio, 1);
> > > > +           usleep_range(650000, 750000);  
> >
> > Not a toggle on the reset?  I'd expect it to be set and then unset after
> > a pulse.  
> 
> Isn't the above devm_gpiod_get_optional() call that also initialize
> the initial GPIO value (then just wait and flip here) ?

good point.  Missed that.

Jonathan

> 
> [...]

