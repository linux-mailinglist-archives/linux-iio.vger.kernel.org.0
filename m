Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFD1F13871E
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2020 17:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbgALQyn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jan 2020 11:54:43 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:21745 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730190AbgALQyn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Jan 2020 11:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1578848071;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=2c3/3xA2ZatMHApvASZ8XnN0dHDatSdqujBqetHF2Ak=;
        b=gOzTjobrQl/lEzHbmRhk/m4b9qrsvablWNiI7JOFmyOD0qRlYWpMVoULWNO8t+Ncv8
        PSM041QDMXX1DCTsHnD6ZrjpYAjWmDg0ySWe4nB2zYfgr3jHKnX7mmDqBrDJgDtvzcrZ
        sGXmH6Nu6StNIYrPAFsJzSsPCKSeQynvcCvr7f9+yyHTtnueVbNehanst8cb5NGA9ltI
        T82I74oz0OhjvpzvkBMueqnwBsUc5EQ4bwTd+D7zg22OIf0y0IeR2YmqcklyTiN5cetE
        VrZ5Duj8PIhjCZbZt+A/KfZ3hZT+llfMeZELKOODnb6eyHO7jIYreda6+UjfTSeMGKxC
        j6Xw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJErz630OCm"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.1.4 AUTH)
        with ESMTPSA id h048a6w0CGs9Jd5
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 12 Jan 2020 17:54:09 +0100 (CET)
Date:   Sun, 12 Jan 2020 17:54:04 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org, Minkyu Kang <mk7.kang@samsung.com>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Oskar Andero <oskar.andero@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2 v4] iio: light: Add a driver for Sharp GP2AP002x00F
Message-ID: <20200112165404.GA72221@gerhold.net>
References: <20200112111341.21388-1-linus.walleij@linaro.org>
 <20200112111341.21388-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200112111341.21388-2-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 12, 2020 at 12:13:41PM +0100, Linus Walleij wrote:
> This driver handles two different Sharp sensors that have been
> proposed for merging to the mainline kernel over the years, and
> already has a limited proximity-only driver in the input
> subsystem.
> 
> These components are completely different from the confusingly
> similarly named Sharp GP2AP020A00F, for which we have a driver
> in drivers/iio/light/gp2ap020a00f.c
> 
> The two components GP2AP002A00F and GP2AP002S00F are
> distinctively different but similar: they share the same set of
> registers but differ slightly in the I2C protocol.
> 
> Instead of the approach by the previous input driver, we create
> a combined IIO proximity and light sensor driver.
> 
> The plan is to merge this driver and delete the input driver.
> 
> The pieces for the driver are picked all over the place after
> researching and grepping through a few different vendor trees
> and driver submissions.
> 
> We merge it under the light sensors because:
> 
> - It has similarities with the Capella CM3605 light sensor and
>   proximity driver which is there.
> 
> - It is related to the GP2AP020A00F driver which is also there.
> 
> This driver was tested with the Samsung GT-S7710 mobile phone
> which has the GP2AP002S00F proximity sensor mounted.
> 
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Minkyu Kang <mk7.kang@samsung.com>
> Cc: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> Cc: Jonathan Bakker <xc-racer2@live.ca>
> Cc: Oskar Andero <oskar.andero@gmail.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for all the work on the driver!

It seems to work fine on samsung,golden with gp2ap002s00f.
There are interrupts being sent when something moves in front of the
sensor and iio-event-monitor looks good too:

Tested-by: Stephan Gerhold <stephan@gerhold.net>

Out of curiosity: I'm not so familiar with the IIO subsystem,
is it intended that the sensor is active the whole time?
Wouldn't it be better to activate it only when something is reading
/dev/iio:device2?

There is one problem I noticed, although I'm not sure if it is a problem
in this driver. Reading one of the files in the sysfs results in:

$ cat /sys/bus/iio/devices/iio\:device2/events/in_proximity_thresh_either_en 
Segmentation fault

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = cf50bdd4
*pgd=00000000
Internal error: Oops: 80000005 [#1] SMP ARM
Modules linked in: hci_uart btbcm brcmfmac brcmutil
CPU: 0 PID: 1419 Comm: cat Not tainted 5.5.0-rc5-postmarketos-novathor #1
Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Support)
PC is at 0x0
LR is at iio_ev_state_show+0x38/0x54
pc : [<00000000>]    lr : [<c05774f0>]    psr: a0000013
sp : ee21fc70  ip : c0860a74  fp : ee7d1178
r10: ee5bdf00  r9 : ee718600  r8 : ee465410
r7 : ee3db000  r6 : c084704c  r5 : 00000000  r4 : ee3db000
r3 : 00000000  r2 : 00000000  r1 : c0860ab8  r0 : ee465400
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5787d  Table: 2e73c04a  DAC: 00000051
Process cat (pid: 1419, stack limit = 0x2726a873)
Stack: (0xee21fc70 to 0xee220000)
fc60:                                     ee7d1160 eebb7280 c084704c c0467788
fc80: ee7d1160 00001000 c084704c c028f790 ee7d1160 ee21fdb8 ee21fd24 00000000
fca0: 00400cc0 00000001 ee5bdf00 c0238db4 ee718580 00001000 ee6ec000 ee7d1190
fcc0: ee21fdb8 00000000 00000000 00000000 ee5bdf00 ee21fd24 00001000 ee21fdb8
fce0: 00000001 c028e438 00000040 c0210924 00010000 ee21fcf8 00010000 ee5bdf00
fd00: ee21fdb8 ee21fd24 ffffe000 bf000000 00001000 c0211dcc ee21fd20 ee21fd24
fd20: ee718580 00000008 00000000 00010000 ee718580 00000010 c0c37200 00010000
fd40: 00000000 ee21fdb4 ee21fdb0 0000000f ee718500 ef0f3e00 00000000 c038763c
fd60: efff21c0 80000113 00000010 c0c03e48 ef1e2840 00010000 00000000 c0c03e48
fd80: 00001000 00000000 00000000 00000010 ee21fddc c0241678 00000000 00080040
fda0: 00080060 ee21fea0 ee5bdf00 ee21fddc ef0f3e00 00000000 00000000 00000000
fdc0: 2ec75000 00000020 00000000 00010000 ee718500 00000000 00000000 ee6ec000
fde0: 00001000 ee1a9000 00001000 ee1aa000 00001000 ee052000 00001000 ee020000
fe00: 00001000 ee71a000 00001000 ee008000 00001000 ee7f9000 00001000 ee637000
fe20: 00001000 ee1a4000 00001000 ee7fa000 00001000 ee00a000 00001000 ee70f000
fe40: 00001000 ee62f000 00001000 ee705000 00001000 ee6fd000 00001000 c0c03e48
fe60: ee21fea0 ee718500 ee21fed8 01000000 00000000 ee5bdf00 00000000 00000000
fe80: 00000000 c02403f8 00000000 edc31088 eec19260 00000000 c023fd30 00000000
fea0: 00000000 00000000 ee21ff70 c0c03e48 fffff000 00000000 00000000 ee21ff30
fec0: ee5bdf00 ee6b9e40 ee6b9e40 7fffffff 00000000 c0240670 01000000 01000000
fee0: 00000000 ee6b9e40 00000000 00000000 ee21ff38 00000000 00000000 00000000
ff00: 00000000 c0c03e48 00000000 ee5bdf00 00000000 01000000 ee5bdf00 c0210f34
ff20: 01000000 00000000 00000001 edc62eb0 00000000 00000000 00000009 00000000
ff40: 00000400 c0c03e48 00000003 00000000 00000000 00000001 000000ef c0101204
ff60: ee21e000 000000ef 00000000 c02122c0 7fffffff 00000000 00000004 00000100
ff80: 00000001 c0c03e48 00000000 00000003 00000001 000000ef c0101204 ee21e000
ffa0: 000000ef c0101000 00000000 00000003 00000001 00000003 00000000 01000000
ffc0: 00000000 00000003 00000001 000000ef 00000003 01000000 01000000 00000000
ffe0: beab8c10 beab8c00 0047219d b6edaa6c 60000030 00000001 00000000 00000000
[<c05774f0>] (iio_ev_state_show) from [<c0467788>] (dev_attr_show+0x18/0x48)
[<c0467788>] (dev_attr_show) from [<c028f790>] (sysfs_kf_seq_show+0x88/0xf0)
[<c028f790>] (sysfs_kf_seq_show) from [<c0238db4>] (seq_read+0x15c/0x544)
[<c0238db4>] (seq_read) from [<c0210924>] (do_iter_read+0x168/0x198)
[<c0210924>] (do_iter_read) from [<c0211dcc>] (vfs_readv+0x60/0x94)
[<c0211dcc>] (vfs_readv) from [<c0241678>] (default_file_splice_read+0x17c/0x2b0)
[<c0241678>] (default_file_splice_read) from [<c02403f8>] (splice_direct_to_actor+0xd4/0x2ac)
[<c02403f8>] (splice_direct_to_actor) from [<c0240670>] (do_splice_direct+0xa0/0xe0)
[<c0240670>] (do_splice_direct) from [<c0210f34>] (do_sendfile+0x19c/0x354)
[<c0210f34>] (do_sendfile) from [<c02122c0>] (sys_sendfile64+0x124/0x138)
[<c02122c0>] (sys_sendfile64) from [<c0101000>] (ret_fast_syscall+0x0/0x54)
Exception stack(0xee21ffa8 to 0xee21fff0)
ffa0:                   00000000 00000003 00000001 00000003 00000000 01000000
ffc0: 00000000 00000003 00000001 000000ef 00000003 01000000 01000000 00000000
ffe0: beab8c10 beab8c00 0047219d b6edaa6c
Code: bad PC value
---[ end trace 82be3175d71f73f1 ]---

> ---
> ChangeLog v3->v4:
> - Realized I had to fix also the last two users of
>   of_property_read_u32(). Replaced with
>   device_property_read_u8(). Dropped unsigned byte check
>   because it can't be anything else.
> - Change warnings about properties to "failed to obtain.."
> - Return the actual error code instead of -EINVAL
> - Move interpolation message to dev_dbg()
> - Return with error if we fail to enable regulators on
>   the resume path.
> ChangeLog v2->v3:
> - Use the device property accessors to read the compatible
>   string and drop the dependency on <linux/of.h> making the
>   driver reusable with ACPI.
> - Add a paragraph with comments on the hysteresis values.
> ChangeLog v1->v2:
> - Drop ifdef CONFIG_OF and of_match_ptr() to encourage
>   reuse with other OF-compliant hardware descriptions such
>   as ACPI PRP001
> - Convert success print to dev_dbg()
> - Drop leftover debug read of VDD voltage
> - Create two different regmap buses for the two component variants
>   and select the one we want depending on detected component
> - Use if (ret) on all regmap accesses
> - Fix up error handling in interrupt routine for proximity
> - Provide some rationale for the 20-30 ms delay in the irq handler
> - Use GENMASK() where applicable
> - Prefix all defines with GP2AP002_*
> - Drop buffer infrastructure from Kconfig
> - Staticize gp2ap002_illuminance_table
> ---
>  MAINTAINERS                  |   8 +
>  drivers/iio/light/Kconfig    |  11 +
>  drivers/iio/light/Makefile   |   1 +
>  drivers/iio/light/gp2ap002.c | 729 +++++++++++++++++++++++++++++++++++
>  4 files changed, 749 insertions(+)
>  create mode 100644 drivers/iio/light/gp2ap002.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1372b4139ebd..dbd4236fc7f5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14893,6 +14893,14 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
>  S:	Supported
>  F:	net/smc/
>  
> +SHARP GP2AP002A00F/GP2AP002S00F SENSOR DRIVER
> +M:	Linus Walleij <linus.walleij@linaro.org>
> +L:	linux-iio@vger.kernel.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> +S:	Maintained
> +F:	drivers/iio/light/gp2ap002.c
> +F:	Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
> +
>  SHARP RJ54N1CB0C SENSOR DRIVER
>  M:	Jacopo Mondi <jacopo@jmondi.org>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 9968f982fbc7..307412c79c53 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -159,6 +159,17 @@ config IIO_CROS_EC_LIGHT_PROX
>  	  To compile this driver as a module, choose M here:
>  	  the module will be called cros_ec_light_prox.
>  
> +config GP2AP002
> +	tristate "Sharp GP2AP002 Proximity/ALS sensor"
> +	depends on I2C
> +	select REGMAP
> +	help
> +	  Say Y here if you have a Sharp GP2AP002 proximity/ALS combo-chip
> +	  hooked to an I2C bus.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called gp2ap002.
> +
>  config GP2AP020A00F
>  	tristate "Sharp GP2AP020A00F Proximity/ALS sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index c98d1cefb861..264a76039006 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_CM3323)		+= cm3323.o
>  obj-$(CONFIG_CM3605)		+= cm3605.o
>  obj-$(CONFIG_CM36651)		+= cm36651.o
>  obj-$(CONFIG_IIO_CROS_EC_LIGHT_PROX) += cros_ec_light_prox.o
> +obj-$(CONFIG_GP2AP002)		+= gp2ap002.o
>  obj-$(CONFIG_GP2AP020A00F)	+= gp2ap020a00f.o
>  obj-$(CONFIG_HID_SENSOR_ALS)	+= hid-sensor-als.o
>  obj-$(CONFIG_HID_SENSOR_PROX)	+= hid-sensor-prox.o
> diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
> new file mode 100644
> index 000000000000..96016c3c03ef
> --- /dev/null
> +++ b/drivers/iio/light/gp2ap002.c
> @@ -0,0 +1,729 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * These are the two Sharp GP2AP002 variants supported by this driver:
> + * GP2AP002A00F Ambient Light and Proximity Sensor
> + * GP2AP002S00F Proximity Sensor
> + *
> + * Copyright (C) 2019 Linaro Ltd.
> + * Author: Linus Walleij <linus.walleij@linaro.org>
> + *
> + * Based partly on the code in Sony Ericssons GP2AP00200F driver by
> + * Courtney Cavin and Oskar Andero in drivers/input/misc/gp2ap002a00f.c
> + * Based partly on a Samsung misc driver submitted by
> + * Donggeun Kim & Minkyu Kang in 2011:
> + * https://lore.kernel.org/lkml/1315556546-7445-1-git-send-email-dg77.kim@samsung.com/
> + * Based partly on a submission by
> + * Jonathan Bakker and Paweł Chmiel in january 2019:
> + * https://lore.kernel.org/linux-input/20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com/
> + * Based partly on code from the Samsung GT-S7710 by <mjchen@sta.samsung.com>
> + * Based partly on the code in LG Electronics GP2AP00200F driver by
> + * Kenobi Lee <sungyoung.lee@lge.com> and EunYoung Cho <ey.cho@lge.com>
> + */
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/consumer.h> /* To get our ADC channel */
> +#include <linux/iio/types.h> /* To deal with our ADC channel */
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/bits.h>
> +#include <linux/math64.h>
> +#include <linux/pm.h>
> +
> +#define GP2AP002_PROX_CHANNEL 0
> +#define GP2AP002_ALS_CHANNEL 1
> +
> +/* ------------------------------------------------------------------------ */
> +/* ADDRESS SYMBOL             DATA                                 Init R/W */
> +/*                   D7    D6    D5    D4    D3    D2    D1    D0           */
> +/* ------------------------------------------------------------------------ */
> +/*    0      PROX     X     X     X     X     X     X     X    VO  H'00   R */
> +/*    1      GAIN     X     X     X     X  LED0     X     X     X  H'00   W */
> +/*    2       HYS  HYSD HYSC1 HYSC0     X HYSF3 HYSF2 HYSF1 HYSF0  H'00   W */
> +/*    3     CYCLE     X     X CYCL2 CYCL1 CYCL0  OSC2     X     X  H'00   W */
> +/*    4     OPMOD     X     X     X   ASD     X     X  VCON   SSD  H'00   W */
> +/*    6       CON     X     X     X OCON1 OCON0     X     X     X  H'00   W */
> +/* ------------------------------------------------------------------------ */
> +/* VO   :Proximity sensing result(0: no detection, 1: detection)            */
> +/* LED0 :Select switch for LED driver's On-registence(0:2x higher, 1:normal)*/
> +/* HYSD/HYSF :Adjusts the receiver sensitivity                              */
> +/* OSC  :Select switch internal clocl frequency hoppling(0:effective)       */
> +/* CYCL :Determine the detection cycle(typically 8ms, up to 128x)           */
> +/* SSD  :Software Shutdown function(0:shutdown, 1:operating)                */
> +/* VCON :VOUT output method control(0:normal, 1:interrupt)                  */
> +/* ASD  :Select switch for analog sleep function(0:ineffective, 1:effective)*/
> +/* OCON :Select switch for enabling/disabling VOUT (00:enable, 11:disable)  */
> +
> +#define GP2AP002_PROX				0x00
> +#define GP2AP002_GAIN				0x01
> +#define GP2AP002_HYS				0x02
> +#define GP2AP002_CYCLE				0x03
> +#define GP2AP002_OPMOD				0x04
> +#define GP2AP002_CON				0x06
> +
> +#define GP2AP002_PROX_VO_DETECT			BIT(0)
> +
> +/* Setting this bit to 0 means 2x higher LED resistance */
> +#define GP2AP002_GAIN_LED_NORMAL		BIT(3)
> +
> +/*
> + * These bits adjusts the proximity sensitivity, determining characteristics
> + * of the detection distance and its hysteresis.
> + */
> +#define GP2AP002_HYS_HYSD_SHIFT		7
> +#define GP2AP002_HYS_HYSD_MASK		BIT(7)
> +#define GP2AP002_HYS_HYSC_SHIFT		5
> +#define GP2AP002_HYS_HYSC_MASK		GENMASK(6, 5)
> +#define GP2AP002_HYS_HYSF_SHIFT		0
> +#define GP2AP002_HYS_HYSF_MASK		GENMASK(3, 0)
> +#define GP2AP002_HYS_MASK		(GP2AP002_HYS_HYSD_MASK | \
> +					 GP2AP002_HYS_HYSC_MASK | \
> +					 GP2AP002_HYS_HYSF_MASK)
> +
> +/*
> + * These values determine the detection cycle response time
> + * 0: 8ms, 1: 16ms, 2: 32ms, 3: 64ms, 4: 128ms,
> + * 5: 256ms, 6: 512ms, 7: 1024ms
> + */
> +#define GP2AP002_CYCLE_CYCL_SHIFT	3
> +#define GP2AP002_CYCLE_CYCL_MASK	GENMASK(5, 3)
> +
> +/*
> + * Select switch for internal clock frequency hopping
> + *	0: effective,
> + *	1: ineffective
> + */
> +#define GP2AP002_CYCLE_OSC_EFFECTIVE	0
> +#define GP2AP002_CYCLE_OSC_INEFFECTIVE	BIT(2)
> +#define GP2AP002_CYCLE_OSC_MASK		BIT(2)
> +
> +/* Analog sleep effective */
> +#define GP2AP002_OPMOD_ASD		BIT(4)
> +/* Enable chip */
> +#define GP2AP002_OPMOD_SSD_OPERATING	BIT(0)
> +/* IRQ mode */
> +#define GP2AP002_OPMOD_VCON_IRQ		BIT(1)
> +#define GP2AP002_OPMOD_MASK		(BIT(0) | BIT(1) | BIT(4))
> +
> +/*
> + * Select switch for enabling/disabling Vout pin
> + * 0: enable
> + * 2: force to go Low
> + * 3: force to go High
> + */
> +#define GP2AP002_CON_OCON_SHIFT		3
> +#define GP2AP002_CON_OCON_ENABLE	(0x0 << GP2AP002_CON_OCON_SHIFT)
> +#define GP2AP002_CON_OCON_LOW		(0x2 << GP2AP002_CON_OCON_SHIFT)
> +#define GP2AP002_CON_OCON_HIGH		(0x3 << GP2AP002_CON_OCON_SHIFT)
> +#define GP2AP002_CON_OCON_MASK		(0x3 << GP2AP002_CON_OCON_SHIFT)
> +
> +/**
> + * struct gp2ap002 - GP2AP002 state
> + * @map: regmap pointer for the i2c regmap
> + * @dev: pointer to parent device
> + * @vdd: regulator controlling VDD
> + * @vio: regulator controlling VIO
> + * @alsout: IIO ADC channel to convert the ALSOUT signal
> + * @is_gp2ap002s00f: this is the GP2AP002F variant of the chip
> + */
> +struct gp2ap002 {
> +	struct regmap *map;
> +	struct device *dev;
> +	struct regulator *vdd;
> +	struct regulator *vio;
> +	struct iio_channel *alsout;
> +	enum iio_event_direction dir;
> +	u8 hys_far;
> +	u8 hys_close;
> +	bool is_gp2ap002s00f;
> +};
> +
> +static irqreturn_t gp2ap002_prox_irq(int irq, void *d)
> +{
> +	struct iio_dev *indio_dev = d;
> +	struct gp2ap002 *gp2ap002 = iio_priv(indio_dev);
> +	u64 ev;
> +	int val;
> +	int ret;
> +
> +	ret = regmap_read(gp2ap002->map, GP2AP002_PROX, &val);
> +	if (ret) {
> +		dev_err(gp2ap002->dev, "error reading proximity\n");
> +		goto err_retrig;
> +	}
> +
> +	if (val & GP2AP002_PROX_VO_DETECT) {
> +		/* Close */
> +		dev_dbg(gp2ap002->dev, "close\n");
> +		ret = regmap_write(gp2ap002->map, GP2AP002_HYS,
> +				   gp2ap002->hys_far);
> +		if (ret)
> +			dev_err(gp2ap002->dev,
> +				"error setting up proximity hysteresis\n");
> +		ev = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, GP2AP002_PROX_CHANNEL,
> +					IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING);
> +	} else {
> +		/* Far */
> +		dev_dbg(gp2ap002->dev, "far\n");
> +		ret = regmap_write(gp2ap002->map, GP2AP002_HYS,
> +				   gp2ap002->hys_close);
> +		if (ret)
> +			dev_err(gp2ap002->dev,
> +				"error setting up proximity hysteresis\n");
> +		ev = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, GP2AP002_PROX_CHANNEL,
> +					IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING);
> +	}
> +	iio_push_event(indio_dev, ev, iio_get_time_ns(indio_dev));
> +
> +	/*
> +	 * After changing hysteresis, we need to wait for one detection
> +	 * cycle to see if anything changed, or we will just trigger the
> +	 * previous interrupt again. A detection cycle depends on the CYCLE
> +	 * register, we are hard-coding ~8 ms in probe() so wait some more
> +	 * than this, 20-30 ms.
> +	 */
> +	usleep_range(20000, 30000);
> +
> +err_retrig:
> +	ret = regmap_write(gp2ap002->map, GP2AP002_CON,
> +			   GP2AP002_CON_OCON_ENABLE);
> +	if (ret)
> +		dev_err(gp2ap002->dev, "error setting up VOUT control\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +struct gp2ap002_illuminance {
> +	unsigned int curr;
> +	unsigned int lux;
> +};
> +
> +/*
> + * This array maps current and lux.
> + *
> + * Ambient light sensing range is 3 to 55000 lux.
> + *
> + * This mapping is based on the following formula.
> + * illuminance = 10 ^ (current / 10)
> + */
> +static const struct gp2ap002_illuminance gp2ap002_illuminance_table[] = {
> +	{ .curr		= 5, .lux	= 3 },
> +	{ .curr		= 6, .lux	= 4 },
> +	{ .curr		= 7, .lux	= 5 },
> +	{ .curr		= 8, .lux	= 6 },
> +	{ .curr		= 9, .lux	= 8 },
> +	{ .curr		= 10, .lux	= 10 },
> +	{ .curr		= 11, .lux	= 12 },
> +	{ .curr		= 12, .lux	= 16 },
> +	{ .curr		= 13, .lux	= 20 },
> +	{ .curr		= 14, .lux	= 25 },
> +	{ .curr		= 15, .lux	= 32 },
> +	{ .curr		= 16, .lux	= 40 },
> +	{ .curr		= 17, .lux	= 50 },
> +	{ .curr		= 18, .lux	= 63 },
> +	{ .curr		= 19, .lux	= 79 },
> +	{ .curr		= 20, .lux	= 100 },
> +	{ .curr		= 21, .lux	= 126 },
> +	{ .curr		= 22, .lux	= 158 },
> +	{ .curr		= 23, .lux	= 200 },
> +	{ .curr		= 24, .lux	= 251 },
> +	{ .curr		= 25, .lux	= 316 },
> +	{ .curr		= 26, .lux	= 398 },
> +	{ .curr		= 27, .lux	= 501 },
> +	{ .curr		= 28, .lux	= 631 },
> +	{ .curr		= 29, .lux	= 794 },
> +	{ .curr		= 30, .lux	= 1000 },
> +	{ .curr		= 31, .lux	= 1259 },
> +	{ .curr		= 32, .lux	= 1585 },
> +	{ .curr		= 33, .lux	= 1995 },
> +	{ .curr		= 34, .lux	= 2512 },
> +	{ .curr		= 35, .lux	= 3162 },
> +	{ .curr		= 36, .lux	= 3981 },
> +	{ .curr		= 37, .lux	= 5012 },
> +	{ .curr		= 38, .lux	= 6310 },
> +	{ .curr		= 39, .lux	= 7943 },
> +	{ .curr		= 40, .lux	= 10000 },
> +	{ .curr		= 41, .lux	= 12589 },
> +	{ .curr		= 42, .lux	= 15849 },
> +	{ .curr		= 43, .lux	= 19953 },
> +	{ .curr		= 44, .lux	= 25119 },
> +	{ .curr		= 45, .lux	= 31623 },
> +	{ .curr		= 46, .lux	= 39811 },
> +	{ .curr		= 47, .lux	= 50119 },
> +};
> +
> +static int gp2ap002_get_lux(struct gp2ap002 *gp2ap002)
> +{
> +	const struct gp2ap002_illuminance *ill1;
> +	const struct gp2ap002_illuminance *ill2;
> +	int ret, res;
> +	int i;
> +
> +	ret = iio_read_channel_processed(gp2ap002->alsout, &res);
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_dbg(gp2ap002->dev, "read %d mA from ADC\n", res);
> +
> +	ill1 = &gp2ap002_illuminance_table[0];
> +	if (res < ill1->curr) {
> +		dev_dbg(gp2ap002->dev, "total darkness\n");
> +		return 0;
> +	}
> +	for (i = 0; i < ARRAY_SIZE(gp2ap002_illuminance_table) - 1; i++) {
> +		ill1 = &gp2ap002_illuminance_table[i];
> +		ill2 = &gp2ap002_illuminance_table[i + 1];
> +
> +		if (res > ill2->curr)
> +			continue;
> +		if ((res <= ill1->curr) && (res >= ill2->curr))
> +			break;
> +	}
> +	if (res > ill2->curr) {
> +		dev_info_once(gp2ap002->dev, "max current overflow\n");
> +		return ill2->curr;
> +	}
> +	/* Interpolate and return */
> +	dev_dbg(gp2ap002->dev, "interpolate index %d and %d\n", i, i + 1);
> +	/* How many steps along the curve */
> +	i = res - ill1->curr; /* x - x0 */
> +	/* Linear interpolation */
> +	return ill1->lux + i *
> +		((ill2->lux - ill1->lux) / (ill2->curr - ill1->curr));
> +}
> +
> +static int gp2ap002_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct gp2ap002 *gp2ap002 = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			ret = gp2ap002_get_lux(gp2ap002);
> +			if (ret < 0)
> +				return ret;
> +			*val = ret;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info gp2ap002_info = {
> +	.read_raw = gp2ap002_read_raw,
> +};
> +
> +static const struct iio_event_spec gp2ap002_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static const struct iio_chan_spec gp2ap002_channels[] = {
> +	{
> +		.type = IIO_PROXIMITY,
> +		.event_spec = gp2ap002_events,
> +		.num_event_specs = ARRAY_SIZE(gp2ap002_events),
> +	},
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.channel = GP2AP002_ALS_CHANNEL,
> +	},
> +};
> +
> +/*
> + * We need a special regmap because this hardware expects to
> + * write single bytes to registers but read a 16bit word on some
> + * variants and discard the lower 8 bits so combine
> + * i2c_smbus_read_word_data() with i2c_smbus_write_byte_data()
> + * selectively like this.
> + */
> +static int gp2ap002a00f_regmap_i2c_read(void *context, unsigned int reg,
> +					unsigned int *val)
> +{
> +	struct device *dev = context;
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(i2c, reg);
> +	if (ret < 0)
> +		return ret;
> +	*val = ret & 0xff;
> +
> +	return 0;
> +}
> +
> +static int gp2ap002s00f_regmap_i2c_read(void *context, unsigned int reg,
> +					unsigned int *val)
> +{
> +	struct device *dev = context;
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +	int ret;
> +
> +	ret = i2c_smbus_read_word_data(i2c, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = (ret >> 8) & 0xFF;
> +
> +	return 0;
> +}
> +
> +static int gp2ap002_regmap_i2c_write(void *context, unsigned int reg,
> +				     unsigned int val)
> +{
> +	struct device *dev = context;
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +
> +	return i2c_smbus_write_byte_data(i2c, reg, val);
> +}
> +
> +static struct regmap_bus gp2ap002a00f_regmap_bus = {
> +	.reg_read = gp2ap002a00f_regmap_i2c_read,
> +	.reg_write = gp2ap002_regmap_i2c_write,
> +};
> +
> +static struct regmap_bus gp2ap002s00f_regmap_bus = {
> +	.reg_read = gp2ap002s00f_regmap_i2c_read,
> +	.reg_write = gp2ap002_regmap_i2c_write,
> +};
> +
> +static int gp2ap002_init(struct gp2ap002 *gp2ap002)
> +{
> +	int ret;
> +
> +	/* Set up the IR LED resistance */
> +	ret = regmap_write(gp2ap002->map, GP2AP002_GAIN,
> +			   GP2AP002_GAIN_LED_NORMAL);
> +	if (ret) {
> +		dev_err(gp2ap002->dev, "error setting up LED gain\n");
> +		return ret;
> +	}
> +	ret = regmap_write(gp2ap002->map, GP2AP002_HYS, gp2ap002->hys_far);
> +	if (ret) {
> +		dev_err(gp2ap002->dev,
> +			"error setting up proximity hysteresis\n");
> +		return ret;
> +	}
> +
> +	/* Disable internal frequency hopping */
> +	ret = regmap_write(gp2ap002->map, GP2AP002_CYCLE,
> +			   GP2AP002_CYCLE_OSC_INEFFECTIVE);
> +	if (ret) {
> +		dev_err(gp2ap002->dev,
> +			"error setting up internal frequency hopping\n");
> +		return ret;
> +	}
> +
> +	/* Enable chip and IRQ, disable analog sleep */
> +	ret = regmap_write(gp2ap002->map, GP2AP002_OPMOD,
> +			   GP2AP002_OPMOD_SSD_OPERATING |
> +			   GP2AP002_OPMOD_VCON_IRQ);
> +	if (ret) {
> +		dev_err(gp2ap002->dev, "error setting up operation mode\n");
> +		return ret;
> +	}
> +
> +	/* Interrupt on VOUT enabled */
> +	ret = regmap_write(gp2ap002->map, GP2AP002_CON,
> +			   GP2AP002_CON_OCON_ENABLE);
> +	if (ret)
> +		dev_err(gp2ap002->dev, "error setting up VOUT control\n");
> +
> +	return ret;
> +}
> +
> +static int gp2ap002_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct gp2ap002 *gp2ap002;
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &client->dev;
> +	enum iio_chan_type ch_type;
> +	static const struct regmap_config config = {
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +		.max_register = GP2AP002_CON,
> +	};
> +	struct regmap_bus *rbus;
> +	struct regmap *regmap;
> +	int num_chan;
> +	const char *compat;
> +	u8 val;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*gp2ap002));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	gp2ap002 = iio_priv(indio_dev);
> +	gp2ap002->dev = dev;
> +
> +	/*
> +	 * Check the device compatible like this makes it possible to use
> +	 * ACPI PRP0001 for registering the sensor using device tree
> +	 * properties.
> +	 */
> +	ret = device_property_read_string(dev, "compatible", &compat);
> +	if (ret) {
> +		dev_err(dev, "cannot check compatible\n");
> +		return ret;
> +	}
> +	gp2ap002->is_gp2ap002s00f = !strcmp(compat, "sharp,gp2ap002s00f");
> +
> +	if (gp2ap002->is_gp2ap002s00f)
> +		rbus = &gp2ap002s00f_regmap_bus;
> +	else
> +		rbus = &gp2ap002a00f_regmap_bus;
> +
> +	regmap = devm_regmap_init(dev, rbus, dev, &config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "Failed to register i2c regmap %d\n",
> +			(int)PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +	gp2ap002->map = regmap;
> +
> +	/*
> +	 * The hysteresis settings are coded into the device tree as values
> +	 * to be written into the hysteresis register. The datasheet defines
> +	 * modes "A", "B1" and "B2" with fixed values to be use but vendor
> +	 * code trees for actual devices are tweaking these values and refer to
> +	 * modes named things like "B1.5". To be able to support any devices,
> +	 * we allow passing an arbitrary hysteresis setting for "near" and
> +	 * "far".
> +	 */
> +
> +	/* Check the device tree for the IR LED hysteresis */
> +	ret = device_property_read_u8(dev, "sharp,proximity-far-hysteresis",
> +				      &val);
> +	if (ret) {
> +		dev_err(dev, "failed to obtain proximity far setting\n");
> +		return ret;
> +	}
> +	dev_dbg(dev, "proximity far setting %02x\n", val);
> +	gp2ap002->hys_far = val;
> +
> +	ret = device_property_read_u8(dev, "sharp,proximity-close-hysteresis",
> +				      &val);
> +	if (ret) {
> +		dev_err(dev, "failed to obtain proximity close setting\n");
> +		return ret;
> +	}
> +	dev_dbg(dev, "proximity close setting %02x\n", val);
> +	gp2ap002->hys_close = val;
> +
> +	/* The GP2AP002A00F has a light sensor too */
> +	if (!gp2ap002->is_gp2ap002s00f) {
> +		gp2ap002->alsout = devm_iio_channel_get(dev, "alsout");
> +		if (IS_ERR(gp2ap002->alsout)) {
> +			if (PTR_ERR(gp2ap002->alsout) == -ENODEV) {
> +				dev_err(dev, "no ADC, deferring...\n");
> +				return -EPROBE_DEFER;
> +			}
> +			dev_err(dev, "failed to get ALSOUT ADC channel\n");
> +			return PTR_ERR(gp2ap002->alsout);
> +		}
> +		ret = iio_get_channel_type(gp2ap002->alsout, &ch_type);
> +		if (ret < 0)
> +			return ret;
> +		if (ch_type != IIO_CURRENT) {
> +			dev_err(dev,
> +				"wrong type of IIO channel specified for ALSOUT\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	gp2ap002->vdd = devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(gp2ap002->vdd)) {
> +		dev_err(dev, "failed to get VDD regulator\n");
> +		return PTR_ERR(gp2ap002->vdd);
> +	}
> +	gp2ap002->vio = devm_regulator_get(dev, "vio");
> +	if (IS_ERR(gp2ap002->vio)) {
> +		dev_err(dev, "failed to get VIO regulator\n");
> +		return PTR_ERR(gp2ap002->vio);
> +	}
> +
> +	/* Operating voltage 2.4V .. 3.6V according to datasheet */
> +	ret = regulator_set_voltage(gp2ap002->vdd, 2400000, 3600000);
> +	if (ret) {
> +		dev_err(dev, "failed to sett VDD voltage\n");
> +		return ret;
> +	}
> +
> +	/* VIO should be between 1.65V and VDD */
> +	ret = regulator_get_voltage(gp2ap002->vdd);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get VIO voltage\n");
> +		return ret;
> +	}
> +	ret = regulator_set_voltage(gp2ap002->vio, 1650000, ret);
> +	if (ret) {
> +		dev_err(dev, "failed to set VIO voltage\n");
> +		return ret;
> +	}
> +
> +	ret = regulator_enable(gp2ap002->vdd);
> +	if (ret) {
> +		dev_err(dev, "failed to enable VDD regulator\n");
> +		return ret;
> +	}
> +	ret = regulator_enable(gp2ap002->vio);
> +	if (ret) {
> +		dev_err(dev, "failed to enable VIO regulator\n");
> +		goto out_disable_vdd;
> +	}
> +
> +	msleep(20);
> +
> +	ret = gp2ap002_init(gp2ap002);
> +	if (ret) {
> +		dev_err(dev, "initialization failed\n");
> +		goto out_disable_vio;
> +	}
> +
> +	ret = devm_request_threaded_irq(dev, client->irq, NULL,
> +					gp2ap002_prox_irq, IRQF_ONESHOT,
> +					"gp2ap002", indio_dev);
> +	if (ret) {
> +		dev_err(dev, "unable to request IRQ\n");
> +		goto out_disable_vio;
> +	}
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->info = &gp2ap002_info;
> +	indio_dev->name = "gp2ap002";
> +	indio_dev->channels = gp2ap002_channels;
> +	/* Skip light channel for the proximity-only sensor */
> +	num_chan = ARRAY_SIZE(gp2ap002_channels);
> +	if (gp2ap002->is_gp2ap002s00f)
> +		num_chan--;
> +	indio_dev->num_channels = num_chan;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto out_disable_vio;
> +	dev_dbg(dev, "Sharp GP2AP002 probed successfully\n");
> +
> +	return 0;
> +
> +out_disable_vio:
> +	regulator_disable(gp2ap002->vio);
> +out_disable_vdd:
> +	regulator_disable(gp2ap002->vdd);
> +	return ret;
> +}
> +
> +static int gp2ap002_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct gp2ap002 *gp2ap002 = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	regulator_disable(gp2ap002->vio);
> +	regulator_disable(gp2ap002->vdd);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused gp2ap002_pm_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct gp2ap002 *gp2ap002 = iio_priv(indio_dev);
> +	int ret;
> +
> +	/* Disable chip and IRQ, everything off */
> +	ret = regmap_write(gp2ap002->map, GP2AP002_OPMOD, 0x00);
> +	if (ret) {
> +		dev_err(gp2ap002->dev, "error setting up operation mode\n");
> +		return ret;
> +	}
> +	/*
> +	 * As these regulators may be shared, at least we are now in
> +	 * sleep even if the regulators aren't really turned off.
> +	 */
> +	regulator_disable(gp2ap002->vio);
> +	regulator_disable(gp2ap002->vdd);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused gp2ap002_pm_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct gp2ap002 *gp2ap002 = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regulator_enable(gp2ap002->vdd);
> +	if (ret) {
> +		dev_err(dev, "failed to enable VDD regulator in resume path\n");
> +		return ret;
> +	}
> +	ret = regulator_enable(gp2ap002->vio);
> +	if (ret) {
> +		dev_err(dev, "failed to enable VIO regulator in resume path\n");
> +		return ret;
> +	}
> +
> +	msleep(20);
> +
> +	ret = gp2ap002_init(gp2ap002);
> +	if (ret) {
> +		dev_err(dev, "re-initialization failed\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops gp2ap002_dev_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(gp2ap002_pm_suspend,
> +				gp2ap002_pm_resume)
> +};
> +
> +static const struct i2c_device_id gp2ap002_id_table[] = {
> +	{ "gp2ap002", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, gp2ap002_id);
> +
> +static const struct of_device_id gp2ap002_of_match[] = {
> +	{ .compatible = "sharp,gp2ap002a00f" },
> +	{ .compatible = "sharp,gp2ap002s00f" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, gp2ap002_of_match);
> +
> +static struct i2c_driver gp2ap002_driver = {
> +	.driver = {
> +		.name = "gp2ap002",
> +		.of_match_table = gp2ap002_of_match,
> +		.pm = &gp2ap002_dev_pm_ops,
> +	},
> +	.probe = gp2ap002_probe,
> +	.remove = gp2ap002_remove,
> +	.id_table = gp2ap002_id_table,
> +};
> +module_i2c_driver(gp2ap002_driver);
> +
> +MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
> +MODULE_DESCRIPTION("GP2AP002 ambient light and proximity sensor driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.21.0
> 
