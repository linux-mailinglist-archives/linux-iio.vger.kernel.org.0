Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5873D3CB76E
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jul 2021 14:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhGPMmQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Jul 2021 08:42:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:52873 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238678AbhGPMmQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Jul 2021 08:42:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="197987569"
X-IronPort-AV: E=Sophos;i="5.84,244,1620716400"; 
   d="scan'208";a="197987569"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 05:39:17 -0700
X-IronPort-AV: E=Sophos;i="5.84,244,1620716400"; 
   d="scan'208";a="573653461"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 05:39:15 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1m4N7U-00EE5o-Ug; Fri, 16 Jul 2021 15:39:08 +0300
Date:   Fri, 16 Jul 2021 15:39:08 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Andrea Merello <andrea.merello@iit.it>
Subject: Re: [PATCH 2/4] iio: imu: add Bosch Sensortec BNO055 core driver
Message-ID: <YPF97IvnlUDtIHar@smile.fi.intel.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20210715141742.15072-3-andrea.merello@gmail.com>
 <CAHp75Vf_Og2wjRy2j0gC37DgR0x9B_F5iSUj8VOtWkhWjgiOag@mail.gmail.com>
 <CAN8YU5NKGLO6a4wqaW07NAU-OdsdBohoXzMCBcskaFsCRtrGhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN8YU5NKGLO6a4wqaW07NAU-OdsdBohoXzMCBcskaFsCRtrGhw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 16, 2021 at 11:19:31AM +0200, Andrea Merello wrote:
> Il giorno gio 15 lug 2021 alle ore 18:50 Andy Shevchenko
> <andy.shevchenko@gmail.com> ha scritto:
> > On Thu, Jul 15, 2021 at 5:21 PM Andrea Merello <andrea.merello@gmail.com> wrote:

...

> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: linux-iio@vger.kernel.org
> >
> > Instead of polluting commit messages with this, use --to and --cc
> > parameters. You may utilize my script [1] which finds automatically to
> > whom to send (of course it allows manually to add more).
> >
> > [1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh
> 
> I thought it was a good & widespread practice, sorry. Will drop from
> future series respin.

It's good to notify people who either maintainer or involved enough. Putting
mailing lists into Cc explicitly is not good practice.

...

> > > +#define BNO055_UNIT_SEL_ANDROID BIT(7)
> >
> > Android? What does this mean?
> 
> Sensors support the so-called "Android" and "Windows" modes. They
> differs about pitch direction (CW vs CCW). I'd like to stick close to
> the datasheet names, but I can add a comment here.

Keeping as in the data sheet is okay, but since it's very confusing naming,
the comment in the is a must.

...

> > Useless parentheses. If the LEN is a plain number, use decimal, if
> > it's limited by register width, use the form of (BIT(x) - 1). In such
> > a case it's easy to see how many bits are used for it.
> 
> It's byte number, defined by how many 8-bits registers make up the
> UID. I'll go for a decimal and I'll drop the parentheses.

15 seems the right one then?

...

> > > +       int i;
> > > +       int best_idx, best_delta, delta;
> > > +       int first = 1;
> >
> > Use reversed xmas tree order.
> 
> Looks like the kernel code is plenty of declarations in random order,
> neither I can find any clue about this in coding-style.rst. Where does
> this come from?

Easier to read. Just from practice and wishes of several maintainers.

> If that's mandatory then I'll do. If that's about a mere preference,
> then I honestly prefer to put all declaration-plus-initialization
> after all declarations-olny (but I can use reversed xmas tree order
> inside each block, if you want).

I'm not a maintainer here, but for the record I do not like this style at all.

...

> > > +       if ((reg >= 0x8 && reg <= 0x3A) ||
> >
> > Use names instead of values here and in similar places elsewhere.
> 
> When I wrote this, I was actually unsure about which is best :) Do you
> have a strong opinion on this?
> 
> My point:
> Most of this is just about register areas, which are bounded by
> addresses - register meaning is of no interest here. Using numerical
> addresses here IMO is a little advantageous because it is at least
> clear which is the greatest number, and it is less prone to swapping
> by mistake start/end registers vrt greater-than/lesser-than comparison
> operators.
> 
> It's still true that when comparing address against a specific
> register address (e.g. reg == BNO055_MAG_CONFIG_REG) there is no
> advantage in using numerical addresses, and it can be better to use
> names (because e.g. you simply know that specific register is
> volatile).

Try your best here. Magic numbers in general are not good.

...

> > > +           /* when in fusion mode, config is updated by chip */
> > > +           reg == BNO055_MAG_CONFIG_REG ||
> > > +           reg == BNO055_ACC_CONFIG_REG ||
> > > +           reg == BNO055_GYR_CONFIG_REG ||
> > > +           (reg >= BNO055_CALDATA_START && reg <= BNO055_CALDATA_END))
> >
> > Please, split this to 3 or more conditionals that are easier to read
> > (logically separated).
> > Same comment to the rest of the similar functions.
> 
> Do you mean splitting into separate if statements? OK.

Yes. Several if:s.

...

> > > +       if (res && res != -ERESTARTSYS) {
> >
> > Shouldn't RESTARTSYS be handled on a regmap level?
> 
> Can you please elaborate on this?

I meant if you need to take care about this it seems to me that it has to be
thought of on regmap level. I.o.w. what is the rationale behind this additional
check?

...

> > Sounds like NIH hex2bin().
> 
> Indeed.. I've failed to find out this helper. Looking at the code it
> seems it wouldn't work as drop-in replacement here, because of spaces
> in the HEX string. But I might just decide to format the HEX string
> without spaces in order to being able to use hex2bin().

I'm not even sure why it's in ASCII instead being directly binary file.

...

> > > +               for (i = 0; i < 4; i++)
> > > +                       vals[i] = (s16)le16_to_cpu(raw_vals[i]);
> >
> > Extract this to be a helper like there are for u32 and u64.
> 
> Could you please point me to those helpers? I don't know what you are
> referring to.

Read include/linux/byteorder/generic.h to the end.

...

> > > +               vals[1] = 1 << 14;
> >
> > BIT(14) But still magic.
> 
> Why magic? there is a comment a few line above explaining this - maybe
> I can move it a couple of LOCs below. And BTW conceptually it is about
> math (2^14), it has nothing to do with BITs.

I see. Up to you then.

...

> > IIO core should do this, besides the fact that it must use sysfs_emit().
> > Ditto for the similar.
> 
> Ok for sysfs_emit(), thanks. But what do you mean with "IIO core
> should do this"? Can you please elaborate?

I believe that IIO has a generic method to print tables via sysfs. AFAIR it is
done via "_avail".

...

> > > +       static const char * const calib_status[] = {"bad", "barely enough",
> > > +                                                  "fair", "good"};
> >
> > Please use better indentation
> >
> >     static char ... foo[] = {
> >         { a, b, c, d, }
> >     };
> 
> OK, but why nested parentheses?

In this case is not needed, just typed as more often seen pattern :)

...

> > Isn't it better to use the request_firmware() interface or something similar?
> 
> No: I already use request_firmware() for getting the initial
> calibration data (if any), but the IMU sometimes (re)calibrates. This
> function is for getting current IMU calibration, so we need to read it
> from registers (especially you want to get it the 1st time, in order
> to create the calibration file that request_firmware() will fetch next
> time you boot).
> 
> > If IIO doesn't provide the common attributes for this it probably
> > should and it has to be a binary one.
> 
> I couldn't find anything for it. I wasn't sure whether exposing
> calibration data using IIO attribute is something that other drivers
> might need to do, hence whether it could make sense to make it generic
> or not.. I wasn't even sure that an IIO attribute is the right place
> to expose it, indeed :)

Okay, this is for maintainers to decide.

...

> > > +        * that is made up 4 16-bit values.
> > > +        * For us the quaternion CH is just like 4 regular CHs.
> > > +        * If out read starts past the quaternion make sure to adjust the
> > > +        * starting offset; if the quaternion is contained in our scan then
> > > +        * make sure to adjust the read len.
> >
> > Your lines here like a drunk person. use the space more monotonically.
> 
> Do you mean: Assuming you are sticking to the old 80-cols-long lines
> (which is still do, unless in few cases), then some lines still have
> room for more words, and you could reflow the text ?

Yes.

...

> > > +       while (!finish) {
> > > +               end = find_next_zero_bit(iio_dev->active_scan_mask,
> > > +                                        iio_dev->masklength, start);
> > > +               if (end == iio_dev->masklength) {
> > > +                       finish = true;
> >
> > NIH for_each_clear_bit().
> 
> Not sure it is convenient to use for_each_clear_bit(): Here we're
> searching for contiguous blocks of set-bits, and we only want indexes
> of first and last set-bit in a block; alternate calls to
> find_next_zero_bit() and find_next_bit() seem appropriate here to me.
> 
> Do you have in mind a better/simpler implementation using or_each_clear_bit() ?

bitmap_find_next_zero_area(buf, len, pos, n, mask)	Find bit free area
bitmap_find_next_zero_area_off(buf, len, pos, n, mask, mask_off)
bitmap_next_clear_region(map, &start, &end, nbits)	Find next clear region
bitmap_next_set_region(map, &start, &end, nbits)	Find next set region
bitmap_for_each_clear_region(map, rs, re, start, end)	Iterate over all clear regions
bitmap_for_each_set_region(map, rs, re, start, end)

...

> > > +       /* base name + separator + UID + ext + zero */
> > > +       char fw_name_buf[sizeof(BNO055_FW_NAME BNO055_FW_EXT) +
> > > +                        BNO055_UID_LEN * 2 + 1 + 1];
> >
> > Perhaps devm_kasprintf()?
> 
> Wouldn't this keep the buffer allocated until the device is removed?
> We just need this buffer while probing.

You free to call devm_kfree() when appropriate.

...

> > > +       sprintf(fw_name_buf, BNO055_FW_NAME "-%*phN" BNO055_FW_EXT,
> >
> > Simply define a format string as FW_FMT somewhere above and use it here.
> 
> OK (but BNO055_FW_NAME and BNO055_FW_EXT contribute to build up two
> different strings, so they will not go away, rather they will be used
> in both FW_FMT and the other one definitions)

#define _FW_FMT \
	_FW_NAME "..." _FW_EXT

?

> > > +               BNO055_UID_LEN, priv->uid);

...

> > > +#include <linux/device.h>
> >
> > No user of this.
> 
> Will drop this

I think you will need to replace it with a forward declaration.

> > > +int bno055_probe(struct device *dev, struct regmap *regmap, int irq,
> > > +                int xfer_burst_break_thr);

-- 
With Best Regards,
Andy Shevchenko


