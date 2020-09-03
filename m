Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40BA25C8B4
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 20:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgICS3z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 14:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgICS3y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 14:29:54 -0400
Received: from saturn.retrosnub.co.uk (saturn.retrosnub.co.uk [IPv6:2a00:1098:86::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5021C061244
        for <linux-iio@vger.kernel.org>; Thu,  3 Sep 2020 11:29:53 -0700 (PDT)
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id EC6D19E0224;
        Thu,  3 Sep 2020 19:29:44 +0100 (BST)
Date:   Thu, 3 Sep 2020 19:29:42 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] iio: accel: adxl372: Add support for FIFO peak
 mode
Message-ID: <20200903192942.0af6e8e8@archlinux>
In-Reply-To: <20200901194003.13b2b38f@archlinux>
References: <20200810093257.65929-1-alexandru.tachici@analog.com>
        <20200810093257.65929-2-alexandru.tachici@analog.com>
        <20200829184350.5ee8c3db@archlinux>
        <20200901194003.13b2b38f@archlinux>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 1 Sep 2020 19:40:03 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 29 Aug 2020 18:43:50 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Mon, 10 Aug 2020 12:32:56 +0300
> > <alexandru.tachici@analog.com> wrote:
> >   
> > > From: Stefan Popa <stefan.popa@analog.com>
> > > 
> > > By default, if all three channels (x, y, z) are enabled, sample sets of
> > > concurrent 3-axis data is stored in the FIFO. This patch adds the option
> > > to configure the FIFO to store peak acceleration (x, y and z) of every
> > > over-threshold event. When pushing to iio buffer we push only enabled
> > > axis data.
> > > 
> > > Currently the driver configures adxl372 to work in loop mode.
> > > The inactivity and activity timings  decide how fast the chip
> > > will loop through the awake and waiting states and the
> > > thresholds on x,y,z axis decide when activity or inactivity
> > > will be detected.
> > > 
> > > This patch adds standard events sysfs entries for the inactivity
> > > and activity timings: thresh_falling_period/thresh_rising_period
> > > and for the in_accel_x_thresh_falling/rising_value.
> > > 
> > > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > > Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>    
> > 
> > Hi Alexandru,
> > 
> > This didn't go in remotely cleanly because of fuzz from moving the
> > pollfunc attach / detach into the core which seems to have crossed with it.
> > 
> > I think I have it correct, but please check and let me know if there
> > are any problems.
> > 
> > Pushed out as testing for the autobuilders to poke at it as well.
> > 
> > thanks,
> > 
> > Jonathan

Round we go again, this time with a rather undocumented (at least I can't
find any docs) with set_mask_bits.  That only works with unsigned long types.

It blows up on riscv builds as this 0-day report states.

I think we are fine just making the two variables unsigned long and have
done so, please check and get back to me if this is a problem.

Pushed out as testing for the autobuilders to try it yet again and
see what new issue they turn up.  This one had me scratching my head
for some time.



> Subject: [iio:testing 75/96] include/linux/compiler_types.h:319:38: error: call to '__compiletime_assert_229' declared with attribute error: BUILD_BUG failed
> 
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
> head:   4b2f9499f323905a09734380d4b80800df1a5a50
> commit: da7a2605058e13d1e5a1bdacab6d89897086ab65 [75/96] iio: accel: adxl372: Add support for FIFO peak mode
> config: riscv-randconfig-r011-20200901 (attached as .config)
> compiler: riscv32-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout da7a2605058e13d1e5a1bdacab6d89897086ab65
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from <command-line>:
>    drivers/iio/accel/adxl372.c: In function 'adxl372_write_event_config':
> >> include/linux/compiler_types.h:319:38: error: call to '__compiletime_assert_229' declared with attribute error: BUILD_BUG failed    
>      319 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                      ^
>    include/linux/compiler_types.h:300:4: note: in definition of macro '__compiletime_assert'
>      300 |    prefix ## suffix();    \
>          |    ^~~~~~
>    include/linux/compiler_types.h:319:2: note: in expansion of macro '_compiletime_assert'
>      319 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |  ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>          |                     ^~~~~~~~~~~~~~~~
>    arch/riscv/include/asm/cmpxchg.h:335:3: note: in expansion of macro 'BUILD_BUG'
>      335 |   BUILD_BUG();      \
>          |   ^~~~~~~~~
>    arch/riscv/include/asm/cmpxchg.h:344:23: note: in expansion of macro '__cmpxchg'
>      344 |  (__typeof__(*(ptr))) __cmpxchg((ptr),    \
>          |                       ^~~~~~~~~
>    include/linux/bitops.h:269:11: note: in expansion of macro 'cmpxchg'
>      269 |  } while (cmpxchg(ptr, old__, new__) != old__);  \
>          |           ^~~~~~~
>    drivers/iio/accel/adxl372.c:949:3: note: in expansion of macro 'set_mask_bits'
>      949 |   set_mask_bits(&st->int1_bitmask, ADXL372_INT1_MAP_ACT_MSK,
>          |   ^~~~~~~~~~~~~
>    include/linux/compiler_types.h:319:38: error: call to '__compiletime_assert_231' declared with attribute error: BUILD_BUG failed
>      319 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                      ^
>    include/linux/compiler_types.h:300:4: note: in definition of macro '__compiletime_assert'
>      300 |    prefix ## suffix();    \
>          |    ^~~~~~
>    include/linux/compiler_types.h:319:2: note: in expansion of macro '_compiletime_assert'
>      319 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |  ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>          |                     ^~~~~~~~~~~~~~~~
>    arch/riscv/include/asm/cmpxchg.h:335:3: note: in expansion of macro 'BUILD_BUG'
>      335 |   BUILD_BUG();      \
>          |   ^~~~~~~~~
>    arch/riscv/include/asm/cmpxchg.h:344:23: note: in expansion of macro '__cmpxchg'
>      344 |  (__typeof__(*(ptr))) __cmpxchg((ptr),    \
>          |                       ^~~~~~~~~
>    include/linux/bitops.h:269:11: note: in expansion of macro 'cmpxchg'
>      269 |  } while (cmpxchg(ptr, old__, new__) != old__);  \
>          |           ^~~~~~~
>    drivers/iio/accel/adxl372.c:953:3: note: in expansion of macro 'set_mask_bits'
>      953 |   set_mask_bits(&st->int1_bitmask, ADXL372_INT1_MAP_INACT_MSK,
>          |   ^~~~~~~~~~~~~
> 
> # https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=da7a2605058e13d1e5a1bdacab6d89897086ab65
> git remote add iio https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> git fetch --no-tags iio testing
> git checkout da7a2605058e13d1e5a1bdacab6d89897086ab65
> vim +/__compiletime_assert_229 +319 include/linux/compiler_types.h
> 
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  305  
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  306  #define _compiletime_assert(condition, msg, prefix, suffix) \
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  307  	__compiletime_assert(condition, msg, prefix, suffix)
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  308  
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  309  /**
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  310   * compiletime_assert - break build and emit msg if condition is false
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  311   * @condition: a compile-time constant condition to check
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  312   * @msg:       a message to emit if condition is false
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  313   *
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  314   * In tradition of POSIX assert, this macro will break the build if the
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  315   * supplied condition is *false*, emitting the supplied error message if the
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  316   * compiler has support to do so.
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  317   */
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  318  #define compiletime_assert(condition, msg) \
> eb5c2d4b45e3d2d Will Deacon 2020-07-21 @319  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  320  
> 
> :::::: The code at line 319 was first introduced by commit
> :::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h
> 
> :::::: TO: Will Deacon <will@kernel.org>
> :::::: CC: Will Deacon <will@kernel.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

> >   
> > > ---
> > >  drivers/iio/accel/adxl372.c | 302 +++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 294 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> > > index 67b8817995c0..4cad16e2f7b7 100644
> > > --- a/drivers/iio/accel/adxl372.c
> > > +++ b/drivers/iio/accel/adxl372.c
> > > @@ -5,6 +5,7 @@
> > >   * Copyright 2018 Analog Devices Inc.
> > >   */
> > >  
> > > +#include <linux/bitfield.h>
> > >  #include <linux/bitops.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/irq.h>
> > > @@ -113,6 +114,11 @@
> > >  #define ADXL372_STATUS_1_AWAKE(x)		(((x) >> 6) & 0x1)
> > >  #define ADXL372_STATUS_1_ERR_USR_REGS(x)	(((x) >> 7) & 0x1)
> > >  
> > > +/* ADXL372_STATUS_2 */
> > > +#define ADXL372_STATUS_2_INACT(x)		(((x) >> 4) & 0x1)
> > > +#define ADXL372_STATUS_2_ACT(x)			(((x) >> 5) & 0x1)
> > > +#define ADXL372_STATUS_2_AC2(x)			(((x) >> 6) & 0x1)
> > > +
> > >  /* ADXL372_INT1_MAP */
> > >  #define ADXL372_INT1_MAP_DATA_RDY_MSK		BIT(0)
> > >  #define ADXL372_INT1_MAP_DATA_RDY_MODE(x)	(((x) & 0x1) << 0)
> > > @@ -131,8 +137,17 @@
> > >  #define ADXL372_INT1_MAP_LOW_MSK		BIT(7)
> > >  #define ADXL372_INT1_MAP_LOW_MODE(x)		(((x) & 0x1) << 7)
> > >  
> > > +/* ADX372_THRESH */
> > > +#define ADXL372_THRESH_VAL_H_MSK	GENMASK(10, 3)
> > > +#define ADXL372_THRESH_VAL_H_SEL(x)	FIELD_GET(ADXL372_THRESH_VAL_H_MSK, x)
> > > +#define ADXL372_THRESH_VAL_L_MSK	GENMASK(2, 0)
> > > +#define ADXL372_THRESH_VAL_L_SEL(x)	FIELD_GET(ADXL372_THRESH_VAL_L_MSK, x)
> > > +
> > >  /* The ADXL372 includes a deep, 512 sample FIFO buffer */
> > >  #define ADXL372_FIFO_SIZE			512
> > > +#define ADXL372_X_AXIS_EN(x)			((x) & BIT(0))
> > > +#define ADXL372_Y_AXIS_EN(x)			((x) & BIT(1))
> > > +#define ADXL372_Z_AXIS_EN(x)			((x) & BIT(2))
> > >  
> > >  /*
> > >   * At +/- 200g with 12-bit resolution, scale is computed as:
> > > @@ -222,6 +237,20 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
> > >  	{ BIT(0) | BIT(1) | BIT(2), ADXL372_XYZ_FIFO },
> > >  };
> > >  
> > > +static const struct iio_event_spec adxl372_events[] = {
> > > +	{
> > > +		.type = IIO_EV_TYPE_THRESH,
> > > +		.dir = IIO_EV_DIR_RISING,
> > > +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> > > +		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD) | BIT(IIO_EV_INFO_ENABLE),
> > > +	}, {
> > > +		.type = IIO_EV_TYPE_THRESH,
> > > +		.dir = IIO_EV_DIR_FALLING,
> > > +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> > > +		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD) | BIT(IIO_EV_INFO_ENABLE),
> > > +	},
> > > +};
> > > +
> > >  #define ADXL372_ACCEL_CHANNEL(index, reg, axis) {			\
> > >  	.type = IIO_ACCEL,						\
> > >  	.address = reg,							\
> > > @@ -238,6 +267,8 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
> > >  		.storagebits = 16,					\
> > >  		.shift = 4,						\
> > >  	},								\
> > > +	.event_spec = adxl372_events,					\
> > > +	.num_event_specs = ARRAY_SIZE(adxl372_events)			\
> > >  }
> > >  
> > >  static const struct iio_chan_spec adxl372_channels[] = {
> > > @@ -251,8 +282,10 @@ struct adxl372_state {
> > >  	struct device			*dev;
> > >  	struct regmap			*regmap;
> > >  	struct iio_trigger		*dready_trig;
> > > +	struct iio_trigger		*peak_datardy_trig;
> > >  	enum adxl372_fifo_mode		fifo_mode;
> > >  	enum adxl372_fifo_format	fifo_format;
> > > +	unsigned int			fifo_axis_mask;
> > >  	enum adxl372_op_mode		op_mode;
> > >  	enum adxl372_act_proc_mode	act_proc_mode;
> > >  	enum adxl372_odr		odr;
> > > @@ -264,6 +297,8 @@ struct adxl372_state {
> > >  	u8				int2_bitmask;
> > >  	u16				watermark;
> > >  	__be16				fifo_buf[ADXL372_FIFO_SIZE];
> > > +	bool				peak_fifo_mode_en;
> > > +	struct mutex			threshold_m; /* lock for threshold */
> > >  };
> > >  
> > >  static const unsigned long adxl372_channel_masks[] = {
> > > @@ -275,6 +310,45 @@ static const unsigned long adxl372_channel_masks[] = {
> > >  	0
> > >  };
> > >  
> > > +static ssize_t adxl372_read_threshold_value(struct iio_dev *indio_dev, unsigned int addr,
> > > +					    u16 *threshold)
> > > +{
> > > +	struct adxl372_state *st = iio_priv(indio_dev);
> > > +	__be16 raw_regval;
> > > +	u16 regval;
> > > +	int ret;
> > > +
> > > +	ret = regmap_bulk_read(st->regmap, addr, &raw_regval, sizeof(raw_regval));
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	regval = be16_to_cpu(raw_regval);
> > > +	regval >>= 5;
> > > +
> > > +	*threshold = regval;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static ssize_t adxl372_write_threshold_value(struct iio_dev *indio_dev, unsigned int addr,
> > > +					     u16 threshold)
> > > +{
> > > +	struct adxl372_state *st = iio_priv(indio_dev);
> > > +	int ret;
> > > +
> > > +	mutex_lock(&st->threshold_m);
> > > +	ret = regmap_write(st->regmap, addr, ADXL372_THRESH_VAL_H_SEL(threshold));
> > > +	if (ret < 0)  
> 0-day pointed this out. You are missing a lock here. I've fixed by using
> goto unlock;
> > > +		return ret;
> > > +
> > > +	ret = regmap_update_bits(st->regmap, addr + 1, GENMASK(7, 5),
> > > +				 ADXL372_THRESH_VAL_L_SEL(threshold) << 5);
> > > +  
> unlock:
> 
> > > +	mutex_unlock(&st->threshold_m);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  static int adxl372_read_axis(struct adxl372_state *st, u8 addr)
> > >  {
> > >  	__be16 regval;
> > > @@ -522,6 +596,39 @@ static int adxl372_get_status(struct adxl372_state *st,
> > >  	return ret;
> > >  }
> > >  
> > > +static void adxl372_arrange_axis_data(struct adxl372_state *st, __be16 *sample)
> > > +{
> > > +	__be16	axis_sample[3];
> > > +	int i = 0;
> > > +
> > > +	memset(axis_sample, 0, 3 * sizeof(__be16));
> > > +	if (ADXL372_X_AXIS_EN(st->fifo_axis_mask))
> > > +		axis_sample[i++] = sample[0];
> > > +	if (ADXL372_Y_AXIS_EN(st->fifo_axis_mask))
> > > +		axis_sample[i++] = sample[1];
> > > +	if (ADXL372_Z_AXIS_EN(st->fifo_axis_mask))
> > > +		axis_sample[i++] = sample[2];
> > > +
> > > +	memcpy(sample, axis_sample, 3 * sizeof(__be16));
> > > +}
> > > +
> > > +static void adxl372_push_event(struct iio_dev *indio_dev, s64 timestamp, u8 status2)
> > > +{
> > > +	unsigned int ev_dir = IIO_EV_DIR_NONE;
> > > +
> > > +	if (ADXL372_STATUS_2_ACT(status2))
> > > +		ev_dir = IIO_EV_DIR_RISING;
> > > +
> > > +	if (ADXL372_STATUS_2_INACT(status2))
> > > +		ev_dir = IIO_EV_DIR_FALLING;
> > > +
> > > +	if (ev_dir != IIO_EV_DIR_NONE)
> > > +		iio_push_event(indio_dev,
> > > +			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X_OR_Y_OR_Z,
> > > +						  IIO_EV_TYPE_THRESH, ev_dir),
> > > +			       timestamp);
> > > +}
> > > +
> > >  static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
> > >  {
> > >  	struct iio_poll_func *pf = p;
> > > @@ -535,6 +642,8 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
> > >  	if (ret < 0)
> > >  		goto err;
> > >  
> > > +	adxl372_push_event(indio_dev, iio_get_time_ns(indio_dev), status2);
> > > +
> > >  	if (st->fifo_mode != ADXL372_FIFO_BYPASSED &&
> > >  	    ADXL372_STATUS_1_FIFO_FULL(status1)) {
> > >  		/*
> > > @@ -553,8 +662,12 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
> > >  			goto err;
> > >  
> > >  		/* Each sample is 2 bytes */
> > > -		for (i = 0; i < fifo_entries; i += st->fifo_set_size)
> > > +		for (i = 0; i < fifo_entries; i += st->fifo_set_size) {
> > > +			/* filter peak detection data */
> > > +			if (st->peak_fifo_mode_en)
> > > +				adxl372_arrange_axis_data(st, &st->fifo_buf[i]);
> > >  			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
> > > +		}
> > >  	}
> > >  err:
> > >  	iio_trigger_notify_done(indio_dev->trig);
> > > @@ -722,6 +835,129 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
> > >  	}
> > >  }
> > >  
> > > +static int adxl372_read_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
> > > +				    enum iio_event_type type, enum iio_event_direction dir,
> > > +				    enum iio_event_info info, int *val, int *val2)
> > > +{
> > > +	struct adxl372_state *st = iio_priv(indio_dev);
> > > +	unsigned int addr;
> > > +	u16 raw_value;
> > > +	int ret;
> > > +
> > > +	switch (info) {
> > > +	case IIO_EV_INFO_VALUE:
> > > +		switch (dir) {
> > > +		case IIO_EV_DIR_RISING:
> > > +			addr = ADXL372_X_THRESH_ACT_H + 2 * chan->scan_index;
> > > +			ret = adxl372_read_threshold_value(indio_dev, addr, &raw_value);
> > > +			if (ret < 0)
> > > +				return ret;
> > > +			*val = raw_value * ADXL372_USCALE;
> > > +			*val2 = 1000000;
> > > +			return IIO_VAL_FRACTIONAL;
> > > +		case IIO_EV_DIR_FALLING:
> > > +			addr = ADXL372_X_THRESH_INACT_H + 2 * chan->scan_index;
> > > +			ret =  adxl372_read_threshold_value(indio_dev, addr, &raw_value);
> > > +			if (ret < 0)
> > > +				return ret;
> > > +			*val = raw_value * ADXL372_USCALE;
> > > +			*val2 = 1000000;
> > > +			return IIO_VAL_FRACTIONAL;
> > > +		default:
> > > +			return -EINVAL;
> > > +		}
> > > +	case IIO_EV_INFO_PERIOD:
> > > +		switch (dir) {
> > > +		case IIO_EV_DIR_RISING:
> > > +			*val = st->act_time_ms;
> > > +			*val2 = 1000;
> > > +			return IIO_VAL_FRACTIONAL;
> > > +		case IIO_EV_DIR_FALLING:
> > > +			*val = st->inact_time_ms;
> > > +			*val2 = 1000;
> > > +			return IIO_VAL_FRACTIONAL;
> > > +		default:
> > > +			return -EINVAL;
> > > +		}
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > > +static int adxl372_write_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
> > > +				     enum iio_event_type type, enum iio_event_direction dir,
> > > +				     enum iio_event_info info, int val, int val2)
> > > +{
> > > +	struct adxl372_state *st = iio_priv(indio_dev);
> > > +	unsigned int val_ms;
> > > +	unsigned int addr;
> > > +	u16 raw_val;
> > > +
> > > +	switch (info) {
> > > +	case IIO_EV_INFO_VALUE:
> > > +		raw_val = DIV_ROUND_UP(val * 1000000, ADXL372_USCALE);
> > > +		switch (dir) {
> > > +		case IIO_EV_DIR_RISING:
> > > +			addr = ADXL372_X_THRESH_ACT_H + 2 * chan->scan_index;
> > > +			return adxl372_write_threshold_value(indio_dev, addr, raw_val);
> > > +		case IIO_EV_DIR_FALLING:
> > > +			addr = ADXL372_X_THRESH_INACT_H + 2 * chan->scan_index;
> > > +			return adxl372_write_threshold_value(indio_dev, addr, raw_val);
> > > +		default:
> > > +			return -EINVAL;
> > > +		}
> > > +	case IIO_EV_INFO_PERIOD:
> > > +		val_ms = val * 1000 + DIV_ROUND_UP(val2, 1000);
> > > +		switch (dir) {
> > > +		case IIO_EV_DIR_RISING:
> > > +			return adxl372_set_activity_time_ms(st, val_ms);
> > > +		case IIO_EV_DIR_FALLING:
> > > +			return adxl372_set_inactivity_time_ms(st, val_ms);
> > > +		default:
> > > +			return -EINVAL;
> > > +		}
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > > +static int adxl372_read_event_config(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
> > > +				     enum iio_event_type type, enum iio_event_direction dir)
> > > +{
> > > +	struct adxl372_state *st = iio_priv(indio_dev);
> > > +
> > > +	switch (dir) {
> > > +	case IIO_EV_DIR_RISING:
> > > +		return FIELD_GET(ADXL372_INT1_MAP_ACT_MSK, st->int1_bitmask);
> > > +	case IIO_EV_DIR_FALLING:
> > > +		return FIELD_GET(ADXL372_INT1_MAP_INACT_MSK, st->int1_bitmask);
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > > +static int adxl372_write_event_config(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
> > > +				      enum iio_event_type type, enum iio_event_direction dir,
> > > +				      int state)
> > > +{
> > > +	struct adxl372_state *st = iio_priv(indio_dev);
> > > +
> > > +	switch (dir) {
> > > +	case IIO_EV_DIR_RISING:
> > > +		set_mask_bits(&st->int1_bitmask, ADXL372_INT1_MAP_ACT_MSK,
> > > +			      ADXL372_INT1_MAP_ACT_MODE(state));
> > > +		break;
> > > +	case IIO_EV_DIR_FALLING:
> > > +		set_mask_bits(&st->int1_bitmask, ADXL372_INT1_MAP_INACT_MSK,
> > > +			      ADXL372_INT1_MAP_INACT_MODE(state));
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	return adxl372_set_interrupts(st, st->int1_bitmask, 0);
> > > +}
> > > +
> > >  static ssize_t adxl372_show_filter_freq_avail(struct device *dev,
> > >  					      struct device_attribute *attr,
> > >  					      char *buf)
> > > @@ -798,7 +1034,8 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
> > >  	if (ret < 0)
> > >  		return ret;
> > >  
> > > -	ret = adxl372_set_interrupts(st, ADXL372_INT1_MAP_FIFO_FULL_MSK, 0);
> > > +	st->int1_bitmask |= ADXL372_INT1_MAP_FIFO_FULL_MSK;
> > > +	ret = adxl372_set_interrupts(st, st->int1_bitmask, 0);
> > >  	if (ret < 0)
> > >  		goto err;
> > >  
> > > @@ -815,13 +1052,22 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
> > >  	}
> > >  
> > >  	st->fifo_format = adxl372_axis_lookup_table[i].fifo_format;
> > > +	st->fifo_axis_mask = adxl372_axis_lookup_table[i].bits;
> > >  	st->fifo_set_size = bitmap_weight(indio_dev->active_scan_mask,
> > >  					  indio_dev->masklength);
> > > +
> > > +	/* Configure the FIFO to store sets of impact event peak. */
> > > +	if (st->peak_fifo_mode_en) {
> > > +		st->fifo_set_size = 3;
> > > +		st->fifo_format = ADXL372_XYZ_PEAK_FIFO;
> > > +	}
> > > +
> > >  	/*
> > >  	 * The 512 FIFO samples can be allotted in several ways, such as:
> > >  	 * 170 sample sets of concurrent 3-axis data
> > >  	 * 256 sample sets of concurrent 2-axis data (user selectable)
> > >  	 * 512 sample sets of single-axis data
> > > +	 * 170 sets of impact event peak (x, y, z)
> > >  	 */
> > >  	if ((st->watermark * st->fifo_set_size) > ADXL372_FIFO_SIZE)
> > >  		st->watermark = (ADXL372_FIFO_SIZE  / st->fifo_set_size);
> > > @@ -831,7 +1077,8 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
> > >  	ret = adxl372_configure_fifo(st);
> > >  	if (ret < 0) {
> > >  		st->fifo_mode = ADXL372_FIFO_BYPASSED;
> > > -		adxl372_set_interrupts(st, 0, 0);
> > > +		st->int1_bitmask &= ~ADXL372_INT1_MAP_FIFO_FULL_MSK;
> > > +		adxl372_set_interrupts(st, st->int1_bitmask, 0);
> > >  		goto err;
> > >  	}
> > >  
> > > @@ -846,7 +1093,8 @@ static int adxl372_buffer_predisable(struct iio_dev *indio_dev)
> > >  {
> > >  	struct adxl372_state *st = iio_priv(indio_dev);
> > >  
> > > -	adxl372_set_interrupts(st, 0, 0);
> > > +	st->int1_bitmask &= ~ADXL372_INT1_MAP_FIFO_FULL_MSK;
> > > +	adxl372_set_interrupts(st, st->int1_bitmask, 0);
> > >  	st->fifo_mode = ADXL372_FIFO_BYPASSED;
> > >  	adxl372_configure_fifo(st);
> > >  
> > > @@ -863,12 +1111,11 @@ static int adxl372_dready_trig_set_state(struct iio_trigger *trig,
> > >  {
> > >  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> > >  	struct adxl372_state *st = iio_priv(indio_dev);
> > > -	unsigned long int mask = 0;
> > >  
> > >  	if (state)
> > > -		mask = ADXL372_INT1_MAP_FIFO_FULL_MSK;
> > > +		st->int1_bitmask |= ADXL372_INT1_MAP_FIFO_FULL_MSK;
> > >  
> > > -	return adxl372_set_interrupts(st, mask, 0);
> > > +	return adxl372_set_interrupts(st, st->int1_bitmask, 0);
> > >  }
> > >  
> > >  static int adxl372_validate_trigger(struct iio_dev *indio_dev,
> > > @@ -876,7 +1123,7 @@ static int adxl372_validate_trigger(struct iio_dev *indio_dev,
> > >  {
> > >  	struct adxl372_state *st = iio_priv(indio_dev);
> > >  
> > > -	if (st->dready_trig != trig)
> > > +	if (st->dready_trig != trig && st->peak_datardy_trig != trig)
> > >  		return -EINVAL;
> > >  
> > >  	return 0;
> > > @@ -887,6 +1134,25 @@ static const struct iio_trigger_ops adxl372_trigger_ops = {
> > >  	.set_trigger_state = adxl372_dready_trig_set_state,
> > >  };
> > >  
> > > +static int adxl372_peak_dready_trig_set_state(struct iio_trigger *trig,
> > > +					      bool state)
> > > +{
> > > +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> > > +	struct adxl372_state *st = iio_priv(indio_dev);
> > > +
> > > +	if (state)
> > > +		st->int1_bitmask |= ADXL372_INT1_MAP_FIFO_FULL_MSK;
> > > +
> > > +	st->peak_fifo_mode_en = state;
> > > +
> > > +	return adxl372_set_interrupts(st, st->int1_bitmask, 0);
> > > +}
> > > +
> > > +static const struct iio_trigger_ops adxl372_peak_data_trigger_ops = {
> > > +	.validate_device = &iio_trigger_validate_own_device,
> > > +	.set_trigger_state = adxl372_peak_dready_trig_set_state,
> > > +};
> > > +
> > >  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("400 800 1600 3200 6400");
> > >  static IIO_DEVICE_ATTR(in_accel_filter_low_pass_3db_frequency_available,
> > >  		       0444, adxl372_show_filter_freq_avail, NULL, 0);
> > > @@ -906,6 +1172,10 @@ static const struct iio_info adxl372_info = {
> > >  	.attrs = &adxl372_attrs_group,
> > >  	.read_raw = adxl372_read_raw,
> > >  	.write_raw = adxl372_write_raw,
> > > +	.read_event_config = adxl372_read_event_config,
> > > +	.write_event_config = adxl372_write_event_config,
> > > +	.read_event_value = adxl372_read_event_value,
> > > +	.write_event_value = adxl372_write_event_value,
> > >  	.debugfs_reg_access = &adxl372_reg_access,
> > >  	.hwfifo_set_watermark = adxl372_set_watermark,
> > >  };
> > > @@ -934,6 +1204,8 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
> > >  	st->regmap = regmap;
> > >  	st->irq = irq;
> > >  
> > > +	mutex_init(&st->threshold_m);
> > > +
> > >  	indio_dev->channels = adxl372_channels;
> > >  	indio_dev->num_channels = ARRAY_SIZE(adxl372_channels);
> > >  	indio_dev->available_scan_masks = adxl372_channel_masks;
> > > @@ -965,13 +1237,27 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
> > >  		if (st->dready_trig == NULL)
> > >  			return -ENOMEM;
> > >  
> > > +		st->peak_datardy_trig = devm_iio_trigger_alloc(dev,
> > > +							       "%s-dev%d-peak",
> > > +							       indio_dev->name,
> > > +							       indio_dev->id);
> > > +		if (!st->peak_datardy_trig)
> > > +			return -ENOMEM;
> > > +
> > >  		st->dready_trig->ops = &adxl372_trigger_ops;
> > > +		st->peak_datardy_trig->ops = &adxl372_peak_data_trigger_ops;
> > >  		st->dready_trig->dev.parent = dev;
> > > +		st->peak_datardy_trig->dev.parent = dev;
> > >  		iio_trigger_set_drvdata(st->dready_trig, indio_dev);
> > > +		iio_trigger_set_drvdata(st->peak_datardy_trig, indio_dev);
> > >  		ret = devm_iio_trigger_register(dev, st->dready_trig);
> > >  		if (ret < 0)
> > >  			return ret;
> > >  
> > > +		ret = devm_iio_trigger_register(dev, st->peak_datardy_trig);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +
> > >  		indio_dev->trig = iio_trigger_get(st->dready_trig);
> > >  
> > >  		ret = devm_request_threaded_irq(dev, st->irq,    
> >   
> 

