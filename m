Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153751B7E85
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 21:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgDXTFf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 15:05:35 -0400
Received: from smtpout1.mo803.mail-out.ovh.net ([79.137.123.219]:53699 "EHLO
        smtpout1.mo803.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728943AbgDXTFf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 15:05:35 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.138.47])
        by mo803.mail-out.ovh.net (Postfix) with ESMTPS id 48FE14F9D0A6;
        Fri, 24 Apr 2020 21:05:31 +0200 (CEST)
Received: from localhost (89.70.31.203) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 24 Apr
 2020 21:05:30 +0200
Date:   Fri, 24 Apr 2020 21:04:13 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/6] iio: chemical: scd30: add core driver
Message-ID: <20200424190413.GA2731@arch>
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
 <20200422141135.86419-2-tomasz.duszynski@octakon.com>
 <CAHp75VcbaGYj76qkDJnTnuG5SM215qVmFo7FLR6YzHA37PgF_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAHp75VcbaGYj76qkDJnTnuG5SM215qVmFo7FLR6YzHA37PgF_g@mail.gmail.com>
X-Originating-IP: [89.70.31.203]
X-ClientProxiedBy: DAG2EX1.emp2.local (172.16.2.11) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 4069846691092716703
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdduvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjihesthdtredttddtjeenucfhrhhomhepvfhomhgrshiiucffuhhsiiihnhhskhhiuceothhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmqeenucffohhmrghinhepshgvnhhsihhrihhonhdrtghomhdpsghoohhtlhhinhdrtghomhenucfkpheptddrtddrtddrtddpkeelrdejtddrfedurddvtdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvghlrdhorhhg
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 22, 2020 at 10:49:44PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 22, 2020 at 5:22 PM Tomasz Duszynski
> <tomasz.duszynski@octakon.com> wrote:
> >
> > Add Sensirion SCD30 carbon dioxide core driver.
>
> And DocLink tar of Datasheet: with a link?
>

I never do this. These files change their location way too often to be
worthwhile putting here. Nobody has that much time to fallow all this
and keep respective files up to date.

But that doesn't mean I can't drop a link here.
https://developer.sensirion.com/fileadmin/user_upload/customers/sensirion/Dokumente/9.5_CO2/Sensirion_CO2_Sensors_SCD30_Interface_Description.pdf

> ...
>
> > +static SIMPLE_DEV_PM_OPS(scd30_pm_ops, scd30_suspend, scd30_resume);
>
> Would it be used in every module? You will get a compiler warning per
> each module that is not using it.
>

Good point.

> ...
>
> > +int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
> > +               int (*command)(struct scd30_state *state, enum scd30_cmd cmd,
> > +                              u16 arg, char *rsp, int size));
>
> My gosh.
> Please, supply proper structure member in priv or alike.
>

Not sure it's worth the fuss. Wrapping all into structure means either
copying respective members or more dereferences later on.

> ...
>
> > + * Copyright (c) Tomasz Duszynski <tomasz.duszynski@octakon.com>
>
> Year?
>

Okay.

> ...
>
> > +#include <asm/byteorder.h>
>
> asm goes after linux.

Right.

>
> > +#include <linux/bits.h>
> > +#include <linux/compiler.h>
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/errno.h>
> > +#include <linux/export.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/types.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irqreturn.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/string.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/types.h>
>
> Are you sure you need all of them?!
>

Generally each exports something referenced throught the code.

> ...
>
> > +/* pressure compensation in millibars */
> Put the unit as a suffix to each definition and drop useless comment.

Okay.

>
> > +/* measurement interval in seconds */
>
> Ditto.
>
> > +/* reference CO2 concentration in ppm */
>
> Ditto.
>
> > +enum {
> > +       CONC,
> > +       TEMP,
> > +       HR,
> > +};
>
> Way too generic names for anonymous enum.

I'd argue that they are pretty well understood abbreviations in iio generally
and here specifically. But adding some prefix won't harm.

>
> ...
>
> > +static int scd30_command(struct scd30_state *state, enum scd30_cmd cmd, u16 arg,
> > +                        char *rsp, int size)
> > +{
>
> > +       /*
> > +        * assumption holds that response buffer pointer has been already
> > +        * properly aligned so casts are safe
> > +        */
> > +       while (size >= sizeof(u32)) {
>
> > +               *(u32 *)rsp = be32_to_cpup((__be32 *)rsp);
>
> Seems like rsp should be void * rather than char *.
>

Might be. That would save a few casts.

> > +               rsp += sizeof(u32);
> > +               size -= sizeof(u32);
> > +       }
>
> NIH of https://elixir.bootlin.com/linux/v5.7-rc2/ident/be32_to_cpu_array ?

Okay.

>
> > +       if (size)
>
> It can be done before even while loop with an immediate bail out.
>

Okay.

> > +               *(u16 *)rsp = be16_to_cpup((__be16 *)rsp);
> > +
> > +       return 0;
> > +}
>
> ...
>
> > +/* simplified float to fixed point conversion with a scaling factor of 0.01 */
> > +static int scd30_float_to_fp(int float32)
> > +{
> > +       int fraction, shift,
> > +           mantissa = float32 & GENMASK(22, 0),
> > +           sign = float32 & BIT(31) ? -1 : 1,
> > +           exp = (float32 & ~BIT(31)) >> 23;
> > +
> > +       /* special case 0 */
> > +       if (!exp && !mantissa)
> > +               return 0;
> > +
> > +       exp -= 127;
> > +       if (exp < 0) {
> > +               exp = -exp;
>
> > +               /* return values ranging from 1 to 99 */
> > +               return sign * ((((BIT(23) + mantissa) * 100) >> 23) >> exp);
>
>   shift = 23 + exp;
>   ... >> shift);
>
> > +       }
> > +
> > +       /* return values starting at 100 */
> > +       shift = 23 - exp;
> > +       float32 = BIT(exp) + (mantissa >> shift);
> > +       fraction = mantissa & GENMASK(shift - 1, 0);
> > +
> > +       return sign * (float32 * 100 + ((fraction * 100) >> shift));
> > +}
>
> Sounds like a candidate to IIO library or even lib/math/*.c.
>

I really doubt it could prove useful to any driver except maybe a few
specific ones which tend to return results as a float (here I mean this
sensors and sps30).

But still with the above reasoning put aside that helper would need
substantial rework to handle rounding errors, precision, etc. before
actual inclusion.

> ...
>
> > +static int scd30_wait_meas_irq(struct scd30_state *state)
> > +{
> > +       int ret, timeout = msecs_to_jiffies(state->meas_interval * 1250);
>
> Magic number.
>

Okay.

> > +       reinit_completion(&state->meas_ready);
> > +       enable_irq(state->irq);
> > +       ret = wait_for_completion_interruptible_timeout(&state->meas_ready,
> > +                                                       timeout);
> > +       if (ret > 0)
> > +               ret = 0;
> > +       else if (!ret)
> > +               ret = -ETIMEDOUT;
> > +
> > +       disable_irq(state->irq);
> > +
> > +       return ret;
> > +}
>
> ...
>
> > +static int scd30_wait_meas_poll(struct scd30_state *state)
> > +{
> > +       int tries = 5;
> > +
> > +       while (tries--) {
> > +               int ret;
> > +               u16 val;
> > +
> > +               ret = scd30_command(state, CMD_MEAS_READY, 0, (char *)&val,
> > +                                   sizeof(val));
> > +               if (ret)
> > +                       return -EIO;
> > +
> > +               /* new measurement available */
> > +               if (val)
> > +                       break;
> > +
> > +               msleep_interruptible(state->meas_interval * 250);
> > +       }
> > +
> > +       if (tries == -1)
> > +               return -ETIMEDOUT;
>
> unsigned int tries = ...;
>
> do {
>  ...
> } while (--tries);
> if (!tries)
>   return ...;
>
> looks better and I guess less code in asm.
>

You mean that one extra branch in case of while? But it comes to code
itself it looks more compact. And I am okay with that.

> > +       return 0;
> > +}
>
> ...
>
> > +       if (kstrtou16(buf, 0, &val))
> > +               return -EINVAL;
>
> Shadowed error code. Don't do like this.
>

Integer parsing either returns EINVAL or ERANGE. Passing the latter to
the user is not worth the trouble, especially because majority of writable attrs
have a fellow _available attr.

> > +       if (kstrtou16(buf, 0, &val))
> > +               return -EINVAL;
>
> Ditto.
>
> > +       if (kstrtou16(buf, 0, &val))
> > +               return -EINVAL;
>
> Ditto.
>
> > +       val = !!val;
>
> kstrtobool()?
>

That would need casting to u16 anyway. So both approaches are more or
less equivalent.

> ...
>
> > +       if (kstrtou16(buf, 0, &val))
> > +               return -EINVAL;
>
> No shadowed error code, please. Check entire code.
>
> > +static IIO_DEVICE_ATTR_RW(pressure_comp, 0);
> > +static IIO_DEVICE_ATTR_RO(pressure_comp_available, 0);
> > +static IIO_DEVICE_ATTR_RW(meas_interval, 0);
> > +static IIO_DEVICE_ATTR_RO(meas_interval_available, 0);
> > +static IIO_DEVICE_ATTR_RW(asc, 0);
> > +static IIO_DEVICE_ATTR_RW(frc, 0);
> > +static IIO_DEVICE_ATTR_RO(frc_available, 0);
> > +static IIO_DEVICE_ATTR_RW(temp_offset, 0);
> > +static IIO_CONST_ATTR(temp_offset_available, "[0 1 65535]");
> > +static IIO_DEVICE_ATTR_WO(reset, 0);
>
> Do you need all of them? Doesn't  IIO core provides a tons of helpers for these?
> Btw, where is ABI documentation? It's a show stopper.

They are sensor specific and none falls into a category of iio generic
attrs. Maybe, except the measurement interval which could be represented as
a SAMP_FREQ. But given that measurement interval spans from 2s to 1800s
it becomes a little bit awkward to have it in Hz. As for ABI that's in
a separate patch.


Thanks for review.

>
> --
> With Best Regards,
> Andy Shevchenko
