Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A980B4003A0
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 18:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350132AbhICQni (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 12:43:38 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:38449 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350010AbhICQni (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 12:43:38 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 97F036000A;
        Fri,  3 Sep 2021 16:42:35 +0000 (UTC)
Date:   Fri, 3 Sep 2021 18:43:24 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] iio: chemical: Add Senseair Sunrise 006-0-007
 driver
Message-ID: <20210903164324.5n7xfo2qw5etwm3c@uno.localdomain>
References: <20210903144828.497166-1-jacopo@jmondi.org>
 <20210903144828.497166-3-jacopo@jmondi.org>
 <CAHp75VdX0=JCGDQaqCU5fDGe7vJBNTDTJHu=QOqd_YtGK4Rgdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VdX0=JCGDQaqCU5fDGe7vJBNTDTJHu=QOqd_YtGK4Rgdg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On Fri, Sep 03, 2021 at 06:36:44PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 3, 2021 at 5:50 PM Jacopo Mondi <jacopo@jmondi.org> wrote:
> >
> > Add support for the Senseair Sunrise 006-0-0007 driver through the
> > IIO subsystem.
>
> ...
>
> > +static int sunrise_read_byte(struct sunrise_dev *sunrise, u8 reg)
> > +{
> > +       unsigned int val;
> > +       int ret;
> > +
> > +       /*
> > +        * Lock the 'wakeup' session.
> > +        *
> > +        * If another read/write call sneaks in between the wakeup message
> > +        * and the i2c transaction, the chip goes back in sleep state.
> > +        */
>
> > +       mutex_lock(&sunrise->wakeup_lock);
> > +       sunrise_wakeup(sunrise);
> > +       ret = regmap_read(sunrise->regmap, reg, &val);
> > +       mutex_unlock(&sunrise->wakeup_lock);
>
> Seems to me that you may redefine ->read() for regmap (but double
> check this, esp. in regard to bulk transfers) with wakeup implied and
> in that case you probably can use regmap's lock only.
>

Can you point me to an example where regmap's read is redefined ? I
failed to find one at a quick look.

> > +       if (ret) {
>
> > +               dev_err(&sunrise->client->dev,
> > +                       "Read byte failed: reg 0x%2x (%d)\n", reg, ret);
>
> With the same LOCs I slightly prefer temporary variable
>
> struct device *dev = ...;
>   ...
> dev_err(dev, ...); // on a single line
>
> Ditto everywhere.

Ugh! I initially had a *dev pointer for the sake of line length in
error messages in the driver's struct, then I'm asked to remove it,
then I'm asked to take a pointer to re-shorten the lines.

>
> > +               return ret;
> > +       }
> > +
> > +       return val;
> > +}
>
> ...
>
> > +static int sunrise_read_word(struct sunrise_dev *sunrise, u8 reg, u16 *val)
> > +{
> > +       __be16 be_val;
> > +       int ret;
> > +
> > +       mutex_lock(&sunrise->wakeup_lock);
> > +       sunrise_wakeup(sunrise);
>
> > +       ret = regmap_bulk_read(sunrise->regmap, reg, &be_val, 2);
>
> sizeof(be_val)
>

ack

> > +       mutex_unlock(&sunrise->wakeup_lock);
> > +       if (ret) {
> > +               dev_err(&sunrise->client->dev,
> > +                       "Read word failed: reg 0x%2x (%d)\n", reg, ret);
> > +               return ret;
> > +       }
> > +
> > +       *val = be16_to_cpu(be_val);
> > +
> > +       return 0;
> > +}
>
> ...
>
> > +static int sunrise_write_word(struct sunrise_dev *sunrise, u8 reg, u16 data)
> > +{
> > +       __be16 be_data = cpu_to_be16(data);
> > +       int ret;
> > +
> > +       mutex_lock(&sunrise->wakeup_lock);
> > +       sunrise_wakeup(sunrise);
> > +       ret = regmap_bulk_write(sunrise->regmap, reg, &be_data, 2);
> > +       mutex_unlock(&sunrise->wakeup_lock);
> > +       if (ret) {
> > +               dev_err(&sunrise->client->dev,
> > +                       "Write word failed: reg 0x%2x (%d)\n", reg, ret);
>
> > +               return ret;
> > +       }
> > +
> > +       return 0;
>
> return ret;
>

I can return a positive value for success and change the checks around
return code to if (ret < 0) but that's driver internal stuff after
all, does it really matter ? Is this more consistent with the Linux
i2c API maybe ?  I can change it if it's the case.


> > +}
>
> ...
>
> > +       /* Write a calibration command and poll the calibration status bit. */
> > +       ret = sunrise_write_word(sunrise, SUNRISE_CALIBRATION_COMMAND_REG,
> > +                                data->cmd);
>
> Dunno how long it is, but to me seems one line is okay.
>

This is getting frustrating, and that's not completely on you.

In other subsystems I get asked to stay in the 80-cols limits no
matter what. Here there's an arbitrary limit according to the
reviewers' tastes. I feel when we had the strict 80-cols limits it was
easier as I didn't have to please each one preferences.

If I read this
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bdc48fa11e46f867ea4d75fa59ee87a7f48be144
it seems that the only relevant thing is not to break user visible
messages (which was kind of implied before), everything else goes, up
to 100-cols where you should ask yourself "what are you doing",
according to Linus words.

I've been suggested "up to 90 is probably fine", then I read 100 in
the commit message, but 80 is still _preferred_ according to the
commit message again.

I wish I could count how many characters we have typed to discuss
about this just during the review of this small driver. Seems like a
lot of churn and time to me.

> > +       if (ret)
> > +               return ret;
>
> ...
>
> > +static ssize_t sunrise_cal_read(const char *buf, size_t len)
> > +{
> > +       bool enable;
> > +       int ret;
> > +
> > +       ret = kstrtobool(buf, &enable);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (!enable)
> > +               return len;
> > +
> > +       return 0;
>
> Why is this a separate function to begin with?

Because it is called from two places where I should have duplicated
the code otherwise ?

>
> Not sure I have got the logic behind. If enable is true you return 0?!
>

Yes, so I can
        if (ret)
                return ret;
in the caller.

> > +}
>
> ...
>
> > +static ssize_t sunrise_cal_factory_write(struct iio_dev *iiodev,
> > +                                        uintptr_t private,
> > +                                        const struct iio_chan_spec *chan,
> > +                                        const char *buf, size_t len)
> > +{
> > +       struct sunrise_dev *sunrise = iio_priv(iiodev);
> > +       int ret;
> > +
> > +       mutex_lock(&sunrise->lock);
> > +       ret = sunrise_cal_read(buf, len);
>
> > +       if (ret) {
> > +               mutex_unlock(&sunrise->lock);
> > +               return ret;
> > +       }
>
> Possibly
>
>   if (ret)
>     goto out_unlock;
>

ack

> > +       ret = sunrise_calibrate(sunrise,
> > +                               &calib_data[SUNRISE_CALIBRATION_FACTORY]);
>
> One line?
>
> out_unlock:
>
> > +       mutex_unlock(&sunrise->lock);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return len;
> > +}
>
> ...
>
> > +       errors = value;
> > +       for_each_set_bit(i, &errors, ARRAY_SIZE(sunrise_error_statuses))
> > +               len += sysfs_emit_at(buf, len, "%s ", sunrise_error_statuses[i]);
>
> > +
>
> Can drop this (up to you).
>
> > +       if (len)
> > +               buf[len - 1] = '\n';
>
> ...
>
> > +                       ret = sunrise_read_word(sunrise, SUNRISE_CO2_FILTERED_COMP_REG,
> > +                                               &value);
>
> One line?
>

Ufff :)

> ...
>
> > +                       ret = sunrise_read_word(sunrise, SUNRISE_CHIP_TEMPERATURE_REG,
> > +                                               &value);
>
> Ditto.
>
> ...
>
> > +               /* x10 to comply with IIO scale (1/1000 degress celsius). */
>
> 1/1000 -->  millidegrees
> (Also note spelling)

Thanks for the spelling warning. I'll fix.

Thanks
   j

>
> --
> With Best Regards,
> Andy Shevchenko
