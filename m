Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B710C31B193
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 18:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhBNRcz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 12:32:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhBNRcz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Feb 2021 12:32:55 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C518760235;
        Sun, 14 Feb 2021 17:32:10 +0000 (UTC)
Date:   Sun, 14 Feb 2021 17:32:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v8 13/22] counter: Internalize sysfs interface code
Message-ID: <20210214173207.19fc810b@archlinux>
In-Reply-To: <3fc2580af0efd6312a64a0e107bd6fa758f0d466.1613131238.git.vilhelm.gray@gmail.com>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
        <3fc2580af0efd6312a64a0e107bd6fa758f0d466.1613131238.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Feb 2021 21:13:37 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This is a reimplementation of the Generic Counter driver interface.
> There are no modifications to the Counter subsystem userspace interface,
> so existing userspace applications should continue to run seamlessly.
> 
> The purpose of this patch is to internalize the sysfs interface code
> among the various counter drivers into a shared module. Counter drivers
> pass and take data natively (i.e. u8, u64, etc.) and the shared counter
> module handles the translation between the sysfs interface and the
> device drivers. This guarantees a standard userspace interface for all
> counter drivers, and helps generalize the Generic Counter driver ABI in
> order to support the Generic Counter chrdev interface (introduced in a
> subsequent patch) without significant changes to the existing counter
> drivers.
> 
> Note, Counter device registration is the same as before: drivers
> populate a struct counter_device with components and callbacks, then
> pass the structure to the devm_counter_register function. However,
> what's different now is how the Counter subsystem code handles this
> registration internally.
> 
> Whereas before callbacks would interact directly with sysfs data, this
> interaction is now abstracted and instead callbacks interact with native
> C data types. The counter_comp structure forms the basis for Counter
> extensions.
> 
> The counter-sysfs.c file contains the code to parse through the
> counter_device structure and register the requested components and
> extensions. Attributes are created and populated based on type, with
> respective translation functions to handle the mapping between sysfs and
> the counter driver callbacks.
> 
> The translation performed for each attribute is straightforward: the
> attribute type and data is parsed from the counter_attribute structure,
> the respective counter driver read/write callback is called, and sysfs
> I/O is handled before or after the driver read/write function is called.
> 
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: David Lechner <david@lechnology.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

A few minor comments inline.

This set is still huge, so I've only looked at the core code
for this version.  Hopefully driver maintainers will do the thorough
review of how it effects the individual drivers!

Jonathan

> ---
>  MAINTAINERS                             |    1 -
>  drivers/counter/104-quad-8.c            |  449 +++----
>  drivers/counter/Makefile                |    1 +
>  drivers/counter/counter-core.c          |  153 +++
>  drivers/counter/counter-sysfs.c         |  833 +++++++++++++
>  drivers/counter/counter-sysfs.h         |   13 +
>  drivers/counter/counter.c               | 1496 -----------------------
>  drivers/counter/ftm-quaddec.c           |   56 +-
>  drivers/counter/microchip-tcb-capture.c |   87 +-
>  drivers/counter/stm32-lptimer-cnt.c     |  164 ++-
>  drivers/counter/stm32-timer-cnt.c       |  142 +--
>  drivers/counter/ti-eqep.c               |  211 ++--
>  include/linux/counter.h                 |  631 +++++-----
>  include/linux/counter_enum.h            |   45 -
>  14 files changed, 1816 insertions(+), 2466 deletions(-)
>  create mode 100644 drivers/counter/counter-core.c
>  create mode 100644 drivers/counter/counter-sysfs.c
>  create mode 100644 drivers/counter/counter-sysfs.h
>  delete mode 100644 drivers/counter/counter.c
>  delete mode 100644 include/linux/counter_enum.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d858582c917b..94a19606d947 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4543,7 +4543,6 @@ F:	Documentation/ABI/testing/sysfs-bus-counter
>  F:	Documentation/driver-api/generic-counter.rst
>  F:	drivers/counter/
>  F:	include/linux/counter.h
> -F:	include/linux/counter_enum.h
>  
>  CPMAC ETHERNET DRIVER
>  M:	Florian Fainelli <f.fainelli@gmail.com>
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index eca3f6482719..41fdbd228be3 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -116,7 +116,7 @@ static int quad8_signal_read(struct counter_device *counter,
...

> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
> new file mode 100644
> index 000000000000..52513a213cc5
> --- /dev/null
> +++ b/drivers/counter/counter-sysfs.c
> @@ -0,0 +1,833 @@

...

> +
> +static ssize_t counter_comp_u8_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	const struct counter_attribute *const a = to_counter_attribute(attr);
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	int err;
> +	u8 data = 0;
> +
> +	switch (a->scope) {
> +	case COUNTER_SCOPE_DEVICE:
> +		err = a->comp.device_u8_read(counter, &data);
> +		break;
> +	case COUNTER_SCOPE_SIGNAL:
> +		err = a->comp.signal_u8_read(counter, a->parent, &data);
> +		break;
> +	case COUNTER_SCOPE_COUNT:
> +		err = a->comp.count_u8_read(counter, a->parent, &data);
> +		break;

I'd add a default in here just to make it obvious anything else is
an error.  Same in other similar cases that follow.

> +	}
> +	if (err < 0)
> +		return err;
> +
> +	if (a->comp.type == COUNTER_COMP_BOOL)
> +		data = !!data;
> +
> +	return sprintf(buf, "%u\n", (unsigned int)data);
> +}
> +


...

> +
> +static int counter_name_attr_create(struct device *const dev,
> +				    struct counter_attribute_group *const group,
> +				    const char *const name)
> +{
> +	struct counter_attribute *counter_attr;
> +
> +	/* Allocate Counter attribute */
> +	counter_attr = devm_kzalloc(dev, sizeof(*counter_attr), GFP_KERNEL);
> +	if (!counter_attr)
> +		return -ENOMEM;
> +
> +	/* Configure Counter attribute */
> +	counter_attr->comp.name = name;
> +
> +	/* Configure device attribute */
> +	sysfs_attr_init(&counter_attr->dev_attr.attr);
> +	counter_attr->dev_attr.attr.name = "name";
> +	counter_attr->dev_attr.attr.mode = 0444;
> +	counter_attr->dev_attr.show = counter_comp_name_show;
> +
> +	/* Store list node */
> +	list_add(&counter_attr->l, &group->attr_list);
> +	group->num_attr++;
> +
> +	return 0;
> +}

Trivial but one too many blank lines.

> +
> +
> +static struct counter_comp counter_signal_comp = {
> +	.type = COUNTER_COMP_SIGNAL_LEVEL,
> +	.name = "signal",
> +};

...


>  static struct counter_synapse ti_eqep_position_synapses[] = {
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index d16ce2819b48..76b0b06dd5db 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -6,42 +6,184 @@
>  #ifndef _COUNTER_H_
>  #define _COUNTER_H_
>  
...
