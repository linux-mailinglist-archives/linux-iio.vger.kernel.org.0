Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88964F0F62
	for <lists+linux-iio@lfdr.de>; Mon,  4 Apr 2022 08:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbiDDGc7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Apr 2022 02:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbiDDGc7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Apr 2022 02:32:59 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FD8237E7
        for <linux-iio@vger.kernel.org>; Sun,  3 Apr 2022 23:31:03 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id w128so4377476vkd.3
        for <linux-iio@vger.kernel.org>; Sun, 03 Apr 2022 23:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=McC1OcuV2dGo7Vna5nBl+Vv5GiawQEwarrshvnUiJtY=;
        b=dXYt5xmNvyLMLRvesd2WysLalRwWNq9+VssKmJe+vxTcnMzOwAUKCsGXjVkA4RAMSM
         1/76Wvwjcw4a4Puc+uLFmu42yDV8j1zMrav3gkvbtNh+nTkLaIeanLsk1tGjG9ocaQcL
         1xh/YSXgto8UM2i61yWvhaNk2+dodEaRpL1/lc8kXJglp28kyUP4h2kmaBe+fKIF4/qX
         p1dpB9PfrqcCygRDcGP4NSubssC4ocOUPxE7rpJx+CF8Ecl/mjTTEenBTtJYQWy4QZQi
         X1n0+v0fb5KlzRL1iURfssruygN4z1uhMuiG85FQ3W1bu2/D/GJxKzYzz/JK3O9v1Ogo
         OptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=McC1OcuV2dGo7Vna5nBl+Vv5GiawQEwarrshvnUiJtY=;
        b=g33QYyRpe0qrHgRg3qwfj8jjLmDFzexUPGmsWmE7zIwA3keNYqG7NBD/+oohxGLblW
         BpEkcNQd4DDK6OZ1KFCzhh4rWVr3n4WbWOefFD23XucTOFItpSSA5BqQe53RoO3GMLXN
         Vp0wpYuo+vdjqy3qBNtR9qyuVOQAOM/uCCfiQFvMfdVn8LUfOVW32pTtMQmczszxXlbf
         BKBpfgKpX6WSGKsudnMQ0qhWHmnDJolt+7ETT79QaASrgPde5n+injfEyGY0LjYuIqHe
         VfJJyBEif1lMTRgXTIq0K01w9OA4TmjkFfDRqXj3b6rp9YuxBU1acULgDOZpzQIO6j6I
         kukQ==
X-Gm-Message-State: AOAM533qBcXLEm1Ur+LptpVVvcNq3YfApAK1flUZhmp7eUVqbnPInOrS
        2/wSM2ZLPsatrkr4ffAwTd4+Iu6YpOZXPyLzSckKUZh8ybs=
X-Google-Smtp-Source: ABdhPJxoQhzUOYmJGCcLvQluxDwiYlSLEzAjUZahvzbioQklzXDe6H8siZkjP4eKdpWADipeh6Xj2BYx/jzh8b2o2Oo=
X-Received: by 2002:a1f:a3d5:0:b0:33d:facd:41b0 with SMTP id
 m204-20020a1fa3d5000000b0033dfacd41b0mr7169439vke.18.1649053862783; Sun, 03
 Apr 2022 23:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220217162710.33615-1-andrea.merello@gmail.com>
 <20220217162710.33615-8-andrea.merello@gmail.com> <ba1b2d78-bf4a-ec6d-88b8-76bbf2ff5e3e@pmeerw.net>
 <20220219174141.4937297a@jic23-huawei> <CAN8YU5OCEBTF37hb6ozaguJ0=svPyv+fmGGsLhoBCPZA5Odgdw@mail.gmail.com>
 <20220327171104.051fcbd2@jic23-huawei> <YkGx76vJUuKj2hVC@kroah.com>
In-Reply-To: <YkGx76vJUuKj2hVC@kroah.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 4 Apr 2022 08:30:51 +0200
Message-ID: <CAN8YU5NyLvcNXZOQrKaK_CxN5M61pRX4Qpb-aNT18vvedh+JrA@mail.gmail.com>
Subject: Re: [v3 07/13] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno lun 28 mar 2022 alle ore 15:02 Greg Kroah-Hartman
<gregkh@linuxfoundation.org> ha scritto:
>
> On Sun, Mar 27, 2022 at 05:11:04PM +0100, Jonathan Cameron wrote:
> > On Tue, 22 Mar 2022 11:27:14 +0100
> > Andrea Merello <andrea.merello@gmail.com> wrote:
> >
> > > Il giorno sab 19 feb 2022 alle ore 18:34 Jonathan Cameron
> > > <jic23@kernel.org> ha scritto:
> > > >
> > > > On Thu, 17 Feb 2022 22:58:14 +0100 (CET)
> > > > Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:
> > > >
> > > > > On Thu, 17 Feb 2022, Andrea Merello wrote:
> > > > >
> > > > > nice work, minor comments below
> > > >
> > > > I'll review on top of Peter to save on duplication.
> > > >
> > > > Mostly really minor stuff.
> >
> > +CC Greg for binary attribute questions.
> >
> > >
> > > :)
> > >
> > > As usual, comments inline; OK for all the rest.
> > >
> > > > Given this has crossed with the introduction of namespaces to quite
> > > > a few IIO drivers (I have another series to do on that once I get
> > > > caught up with reviews) I'd prefer it if you would move this into
> > > > a symbol namespace (EXPORT_SYMBOL_NS_GPL() and appropriate namespace
> > > > statements in the two bus modules.
> > > >
> > > > Save it being done as a follow up series.  If you prefer not to then
> > > > that's fine too as it'll be a trivial follow up patch.
> > >
> > > I'll include it in V4 directly.
> > >
> > > [...]
> > >
> > > > > > +   case IIO_CHAN_INFO_SCALE:
> > > > > > +           /* Table 3-31: 1 quaternion = 2^14 LSB */
> > > > > > +           if (size < 2)
> > > > > > +                   return -EINVAL;
> > > > > > +           vals[0] = 1;
> > > > > > +           vals[1] = 1 << 14;
> > > > > > +           return IIO_VAL_FRACTIONAL_LOG2;
> > > >
> > > > This doesn't look right.  Not vals[1] = 14 given FRACTIONAL_LOG2?
> > >
> > > Hum.. maybe just IIO_VAL_FRACTIONAL ?
> >
> > That works as well, though I'd argue FRACTIONAL_LOG2 is the
> > better option as it makes it clear the divisor is a power of 2
> > and the precision might potentially be better as a result (I've not
> > checked!)
> >
> > >
> > > > > > +   default:
> > > > > > +           return -EINVAL;
> > > > > > +   }
> > > > > > +}
> > > > > > +
> > >
> > > [...]
> > >
> > > > > > +static IIO_DEVICE_ATTR_RO(sys_calibration_auto_status, 0);
> > > > > > +static IIO_DEVICE_ATTR_RO(in_accel_calibration_auto_status, 0);
> > > > > > +static IIO_DEVICE_ATTR_RO(in_gyro_calibration_auto_status, 0);
> > > > > > +static IIO_DEVICE_ATTR_RO(in_magn_calibration_auto_status, 0);
> > > > > > +static IIO_DEVICE_ATTR_RO(calibration_data, 0);
> > > >
> > > > This is documented as providing binary data but it's not using
> > > > a binary attribute and that rather surprised me.
> > > >
> > > > Off the top of my head I can't recall why it matters though, so please
> > > > take a look at whether a bin_attribute makes more sense for this.
> > >
> > > As far as I can see, it seems that a non-binary attributes only
> > > support to be read at once while the binary attributes read()
> > > operation supports random access i.e. it has the file position
> > > parameter.
> > >
> > > The calibration data is "dynamic", it's read from the HW every time,
> > > and I'm not sure it makes any sense to read it in several chunks (what
> > > if we read a chunk and the calibration data is updated by the HW
> > > before reading the second chunk?). So, despide the fitting "binary"
> > > name I'm tempted to stick with regular attribute. However I'm not sure
> > > this is the only difference related to binary attributes.
> >
> > +Cc Greg.  Valid choice to use a normal attribute for this?
>
> binary attributes are to ONLY be used for data that flows to/from a
> device without the kernel ever modifying the data at all.  The kerneln
> is just a pass-through here.
>
> There are a few minor exceptions, but they were exceptions, please don't
> use them as a valid reason to use a binary attribute.
>
> does that help?

Thanks. Here the driver doesn't modify the data, so no probl here about this.

Would it be valid to restrict usage to only complete reads from the
start to the end on calibration data i.e. returning -EINVAL when
read() function is called with pos != 0 or count < actual data size ?


>
> greg k-h
