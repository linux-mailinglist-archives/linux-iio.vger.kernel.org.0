Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF54C78DA82
	for <lists+linux-iio@lfdr.de>; Wed, 30 Aug 2023 20:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbjH3Sg0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Aug 2023 14:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343810AbjH3RCn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Aug 2023 13:02:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E1219A
        for <linux-iio@vger.kernel.org>; Wed, 30 Aug 2023 10:02:37 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RbVpf4Wrmz6K5st;
        Thu, 31 Aug 2023 00:57:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 30 Aug
 2023 18:02:34 +0100
Date:   Wed, 30 Aug 2023 18:02:34 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nuno Sa <nuno.sa@analog.com>
CC:     <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [RFC PATCH 1/3] iio: addac: add new converter framework
Message-ID: <20230830180234.00007437@Huawei.com>
In-Reply-To: <20230804145342.1600136-2-nuno.sa@analog.com>
References: <20230804145342.1600136-1-nuno.sa@analog.com>
        <20230804145342.1600136-2-nuno.sa@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 4 Aug 2023 16:53:39 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

Hi Nuno,


One general comment is that you could have stripped this back a fair bit
for ease of understanding.  At this stage we don't care about things
like debug or control of test patterns.  Bring those in as extra patches.

I haven't fully gotten my head around the ordering constraints on removal.
Are there other users of the component framework that have similar problems?

Also, I don't yet understand how a multiple front end, single backend setup
would work.  Or indeed single front end, multiple backend...  Maybe we don't
need those cases, but if we want this to be useful beyond adi-axi we
probably at least want an outline of how they work.

Jonathan

> ---
>  drivers/iio/addac/converter.c       | 547 ++++++++++++++++++++++++++++
>  include/linux/iio/addac/converter.h | 485 ++++++++++++++++++++++++
>  2 files changed, 1032 insertions(+)
>  create mode 100644 drivers/iio/addac/converter.c
>  create mode 100644 include/linux/iio/addac/converter.h
> 
> diff --git a/drivers/iio/addac/converter.c b/drivers/iio/addac/converter.c
> new file mode 100644
> index 000000000000..31ac704255ad
> --- /dev/null
> +++ b/drivers/iio/addac/converter.c
> @@ -0,0 +1,547 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Framework to handle complex IIO aggregate devices
> + *
> + * A note on some of the design expectations with regards to lifetimes and
> + * devices bringup/removal.
> + *
> + * The Framework is using, under the wood, the component API which makes it to
> + * easy treat a bunch of devices as one aggregate device. This means that the
> + * complete thing is only brought to live when all the deviced are probed. To do

devices

> + * this, two callbacks are used that should in fact completely replace .probe()
> + * and .remove(). The formers should only be used the minimum needed. Ideally,

I don't follow the sentence in the middle of the line above.

> + * only to call the functions to add and remove frontend annd backend devices.
Spell check...

> + *
> + * It is advised for frontend and backend drivers to use their .remove()

I'd not 'advise' things. I'd say the 'use' them.

> + * callbacks (to use devres API during the frontend and backends initialization).
> + * See the comment in @converter_frontend_bind().
> + *
> + * It is also assumed that converter objects cannot be accessed once one of the
> + * devices of the aggregate device is removed (effectively bringing the all the

bringing all the devices down

> + * devices down). Based on that assumption, these objects are not refcount which

recounted

> + * means accessing them will likely fail miserably.

I hope that doesn't mean there will be no protection.  I don't mind if nothing works
but breaking the kernel isn't an option.

> + *
> + * Copyright (C) 2023 Analog Devices Inc.
> + */
> +
> +#define dev_fmt(fmt) "Converter - " fmt
> +
> +#include <linux/component.h>
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/iio/addc/converter.h>
> +#include <linux/iio/iio.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +struct converter_backend {
> +	struct list_head entry;
> +	struct device *dev;
> +	const struct converter_ops *ops;
> +	const char *name;
> +	void *drvdata;
> +
> +	struct regmap *regmap;
> +	unsigned int cached_reg_addr;
> +};
> +
> +struct converter_frontend {
> +	struct list_head list;
> +	const struct frontend_ops *ops;
> +	struct device *dev;
> +};



> +static int converter_bind(struct device *dev, struct device *aggregate,
> +			  void *data)
> +{
> +	struct converter_frontend *frontend = dev_get_drvdata(aggregate);
> +	struct converter_backend *conv = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = conv->ops->backend_init(conv, dev);
> +	if (ret)
> +		return ret;
> +
> +	list_add_tail(&conv->entry, &frontend->list);
> +
> +	return 0;
> +}
> +
> +static void converter_unbind(struct device *dev, struct device *aggregate,
> +			     void *data)
> +{
> +	struct converter_backend *conv = dev_get_drvdata(dev);
> +
> +	if (conv->ops->backend_close)
> +		conv->ops->backend_close(conv);
> +
> +	/* after this point the converter should not be used anymore */
> +	converter_set_drvdata(conv, NULL);
> +}
> +
> +static const struct component_ops converter_component_ops = {
> +	.bind = converter_bind,
> +	.unbind = converter_unbind,
> +};
> +
> +static int converter_frontend_bind(struct device *dev)
> +{
> +	struct converter_frontend *frontend = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = component_bind_all(dev, NULL);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * We open a new group so that we can control when resources are
> +	 * released and still use device managed (devm_) calls. The expectations
> +	 * are that on probe, backend resources are allocated first followed by
> +	 * the frontend resources (where registering the IIO device must happen)
> +	 * Naturally we want the reverse order on the unbind path and that would
> +	 * not be possible without opening our own devres group.
> +
> +	 * Note that the component API also opens it's own devres group when
> +	 * calling the .bind() callbacks for both the aggregate device
> +	 * (our frontend) and each of the components (our backends). On the
> +	 * unbind path, the aggregate .unbind() function is called
> +	 * (@converter_frontend_unbind()) which should be responsible to tear
> +	 * down all the components (effectively releasing all the resources
> +	 * allocated on each component devres group) and only then the aggregate
> +	 * devres group is released. Hence, the order we want to maintain for
> +	 * releasing resources would not be satisfied because backend resources
> +	 * would be freed first. With our own group, we can control when
> +	 * releasing the resources and we do it before @component_unbind_all().
> +	 *
> +	 * This also relies that internally the component API is releasing each
> +	 * of the component's devres group. That is likely not to change, but
> +	 * maybe we should not trust it and also open our own groups for backend
> +	 * devices?!
> +	 *
> +	 * Another very important thing to keep in mind is that this is only
> +	 * valid if frontend and backend driver's are implementing their
> +	 * .remove() callback to call @converter_frontend_del() and
> +	 * @converter_backend_del(). Calling those functions from
> +	 * devm_add_action* and use devm APIs in .frontend_init() and
> +	 * .backend_init() is not going to work. Not perfect but still better
> +	 * than having to tear everything down in .frontend_close() and
> +	 * .backend_close()

That last bit is nasty and will be non obvious to driver authors.

I wonder if we can come up with some means to make it hard to do.

> +	 */
> +	if (!devres_open_group(dev, frontend, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	ret = frontend->ops->frontend_init(frontend, dev);
> +	if (ret) {
> +		devres_release_group(dev, frontend);
> +		return ret;
> +	}
> +
> +	devres_close_group(dev, NULL);
> +	return 0;
> +}
> +
> +static void converter_frontend_unbind(struct device *dev)
> +{
> +	struct converter_frontend *frontend = dev_get_drvdata(dev);
> +
> +	if (frontend->ops->frontend_close)
> +		frontend->ops->frontend_close(frontend);
> +
> +	devres_release_group(dev, frontend);
> +	component_unbind_all(dev, NULL);
> +	list_del_init(&frontend->list);
> +}
> +
> +static const struct component_master_ops frontend_component_ops = {
> +	.bind = converter_frontend_bind,
> +	.unbind = converter_frontend_unbind,
> +};


> diff --git a/include/linux/iio/addac/converter.h b/include/linux/iio/addac/converter.h
> new file mode 100644
> index 000000000000..09d9d491b2b8
> --- /dev/null
> +++ b/include/linux/iio/addac/converter.h
> @@ -0,0 +1,485 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _CONVERTER_H
> +#define _CONVERTER_H
> +
> +struct converter_frontend;
> +struct converter_backend;
> +struct iio_dev;
> +struct device;
> +struct regmap;
> +
> +enum converter_test_pattern {
> +	CONVERTER_PRBS_7,
> +	CONVERTER_PRBS_15,
> +	CONVERTER_PRBS_23,
> +	CONVERTER_PRBS_31,
> +	CONVERTER_RAMP_NIBBLE,
> +	CONVERTER_RAMP_16,
> +	/* vendor specific from 32 */
> +	CONVERTER_ADI_PRBS_9A = 32,
> +	CONVERTER_ADI_PRBS_23A,
> +	CONVERTER_ADI_PRBS_X,
> +	CONVERTER_TEST_PATTERN_MAX
> +};
> +
> +enum converter_data_type {
> +	CONVERTER_TWOS_COMPLEMENT,
> +	CONVERTER_OFFSET_BINARY,
> +	CONVERTER_DATA_TYPE_MAX
> +};
> +
> +enum converter_edge {
> +	CONVERTER_RISING_EDGE_SAMPLE,
> +	CONVERTER_FALLING_EDGE_SAMPLE,
> +	CONVERTER_EDGE_MAX
> +};
> +
> +struct converter_chan_status {
> +	bool errors;
> +};
> +
> +/**
> + * struct converter_data_fmt - Backend data format
> + * @type:		Data type.
> + * @sign_extend:	Bool to tell if the data is sign extended.
> + * @enable:		Enable/Disable the data format module. If disabled,
> + *			not formatting will happen.
> + */
> +struct converter_data_fmt {
> +	enum converter_data_type type;
> +	bool sign_extend;
> +	bool enable;
> +};
> +
> +/**
> + * struct converter_test_pattern_xlate - Helper struct for test pattern handling
> + * @pattern:	Pattern to configure.
> + * @reg_val:	Register value for the pattern to configure.
> + */
> +struct converter_test_pattern_xlate {
> +	enum converter_test_pattern pattern;
> +	unsigned int reg_val;
> +};
> +
> +/**
> + * struct converter_ops - Backend supported operations
> + * @backend_init:	Mandatory function to initialize the backend device. It
> + *			should be a replacement for .probe() where the latest

just say .probe() again as 'the latest' is a fiddly bit of English

> + *			should only have to care about doing @converter_add().
> + * @backend_close:	Optional function to tear down the device.
> + * @enable:		Enable the backend device.
> + * @disable:		Disable the backend device.
> + * @data_format_set:	Configure the data format for a specific channel.
> + * @chan_enable:	Enable one channel.
> + * @chan_disable:	Disable one channel.
> + * @iodelay_set:	Controls the IO delay for all the lanes at the interface
> + *			(where data is actually transferred between frontend and
> +			backend) level.
> + * @test_pattern_set:	Set's a test pattern to be transmitted/received by the
> + *			backend. Typically useful for debug or interface
> + *			purposes calibration.
> + */
> +struct converter_ops {
> +	int (*backend_init)(struct converter_backend *conv, struct device *dev);
> +	void (*backend_close)(struct converter_backend *conv);
> +	int (*enable)(struct converter_backend *conv);
> +	void (*disable)(struct converter_backend *conv);
> +	int (*data_format_set)(struct converter_backend *conv,
> +			       unsigned int chan,
> +			       const struct converter_data_fmt *data);
> +	int (*chan_enable)(struct converter_backend *conv, unsigned int chan);
> +	int (*chan_disable)(struct converter_backend *conv, unsigned int chan);
> +	int (*iodelay_set)(struct converter_backend *conv,
> +			   unsigned int num_lanes, unsigned int delay);
> +	int (*test_pattern_set)(struct converter_backend *conv,
> +				unsigned int chan,
> +				enum converter_test_pattern pattern);
> +	int (*chan_status)(struct converter_backend *conv, unsigned int chan,
> +			   struct converter_chan_status *status);
> +	int (*sample_edge_select)(struct converter_backend *conv,
> +				  enum converter_edge edge);
> +};
> +
> +/**
> + * struct frontend_ops - Frontend supported operations
> + * @frontend_init:	Mandatory function to initialize the frontend device. It
> + *			should be a replacement for .probe() where the latest

As above.


> + *			should only have to care about doing @frontend_add().
> + * @frontend_close:	Optional function to tear down the device.
> + */
> +struct frontend_ops {
> +	int (*frontend_init)(struct converter_frontend *frontend,
> +			     struct device *dev);
> +	void (*frontend_close)(struct converter_frontend *frontend);
> +};
> +
> +/**
> + * converter_test_pattern_xlate() - Helper macro for translatting test patterns
> + * @pattern:	Pattern to translate.
> + * @xlate:	List of @struct converter_test_pattern_xlate pairs.
> + *
> + * Simple helper to match a supported pattern and get the register value. Should
> + * only be called by backend devices. Automatically computes the number of
> + * @xlate entries.
> + */
> +#define converter_test_pattern_xlate(pattern, xlate)	\
> +	__converter_test_pattern_xlate(pattern, xlate, ARRAY_SIZE(xlate));
> +
> +#if IS_ENABLED(CONFIG_IIO_CONVERTER)

Why?  I'd expect any driver that uses this framework to be useless without
it, so we shouldn't need protections. Handle that with Kconfig select / depends

> +
> +/**
> + * converter_get_drvdata - Get driver private data
> + * @conv:	Converter device.

Comments should be next to implementation (I got this wrong in original IIO
code and still haven't pushed them all down).  One reason is that people often
change the internals without realizing there is a comment on them in a header
that also needs updating. Much harder to do that if it's right in front of
you in the c file.

> + */
> +void *converter_get_drvdata(const struct converter_backend *conv);
> +
> +/**
> + * converter_set_drvdata - Set driver private data
> + * @conv:	Converter device.
> + * @drvdata:	Driver private data.
> + */
> +void converter_set_drvdata(struct converter_backend *conv, void *drvdata);
> +
> +/**
> + * converter_set_regmap - Add a regmap object to a converter
> + * @conv:	Converter device.
> + * @regmap:	Regmap object.
> + */
> +void converter_set_regmap(struct converter_backend *conv,
> +			  struct regmap *regmap);
> +
> +/**
> + * __converter_test_pattern_xlate - Helper macro for translatting test patterns
> + * @pattern:	Pattern to translate.
> + * @xlate:	List of @struct converter_test_pattern_xlate pairs.
> + * @n_matches:	Number of entries in @xlate.
> + *
> + * Simple helper to match a supported pattern and get the register value. Should
> + * only be called by backend devices.
> + */
> +int __converter_test_pattern_xlate(unsigned int pattern,
> +				   const struct converter_test_pattern_xlate *xlate,
> +				   int n_matches);
> +
> +/**
> + *
> + */
> +int converter_add(struct device *dev, const struct converter_ops *ops);
> +
> +/**
> + * converter_del - Remove the converter device
> + * @dev:	device to remove from the aggregate
> + *
> + * Removes the converter from the aggregate device. This tears down the frontend
> + * and all the converters.
> + *
> + * Ideally, this should be called from the backend driver .remove() callback.
> + * This means that all the converters (and the frontend) will be tear down before
> + * running any specific devres cleanup (at the driver core level). What this all
> + * means is that we can use devm_ apis in @backend_init() and being sure those
> + * resources will be released after the backend resources and before any devm_*
> + * used in @probe(). If that is not the case, one should likely not use any
> + * devm_ API in @backend_init(). That means .backend_close() should be
> + * provided to do all the necessary cleanups.
> + */
> +void converter_del(struct device *dev);
> +
> +/**
> + * converter_enable - Enable the device
> + * @conv:	Converter device.
> + *
> + * Enables the backend device.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int converter_enable(struct converter_backend *conv);
> +
> +/**
> + * converter_disable - Disable the device
> + * @conv:	Converter device.
> + *
> + * Disables the backend device.
> + */
> +void converter_disable(struct converter_backend *conv);
> +
> +/**
> + * converter_test_pattern_set - Set a test pattern
> + * @conv:	Converter device.
> + * @chan:	Channel number.
> + * @pattern:	Pattern to set.
> + *
> + * Set's a test pattern to be transmitted/received by the backend. Typically
> + * useful for debug or interface calibration purposes. A backend driver can
> + * call the @converter_test_pattern_xlate() helper to validate the pattern
> + * (given an array of @struct converter_test_pattern_xlate).
> + *
> + * Note that some patterns might be frontend specific. I.e, as far as the
> + * backend is concerned the pattern is valid (from a register point of view) but
> + * the actual support for the pattern is not implemented in the device for this
> + * specific frontend. It's up to the frontend to ask for a proper pattern
> + * (as it should know better).
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int converter_test_pattern_set(struct converter_backend *conv,
> +			       unsigned int chan,
> +			       enum converter_test_pattern pattern);
> +
> +int converter_chan_status_get(struct converter_backend *conv,
> +			      unsigned int chan,
> +			      struct converter_chan_status *status);
> +
> +/**
> + * converter_data_format_set - Configure the data format
> + * @conv:	Converter device.
> + * @chan:	Channel number.
> + * @data:	Data format.
> + *
> + * Properly configure a channel with respect to the expected data format. A
Configure a channel ...

We won't do it improperly ;)

> + * @struct converter_data_fmt must be passed with the settings.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int converter_data_format_set(struct converter_backend *conv,
> +			      unsigned int chan,
> +			      const struct converter_data_fmt *data);
> +
> +int converter_sample_edge_select(struct converter_backend *conv,
> +				 enum converter_edge edge);
> +
> +static inline int
> +converter_sample_on_falling_edge(struct converter_backend *conv)
> +{
> +	return converter_sample_edge_select(conv, CONVERTER_RISING_EDGE_SAMPLE);
> +}
> +
> +static inline int
> +converter_sample_on_rising_edge(struct converter_backend *conv)
> +{
> +	return converter_sample_edge_select(conv, CONVERTER_FALLING_EDGE_SAMPLE);
> +}
> +
> +/**
> + * converter_chan_enable - Enable a backend channel
> + * @conv:	Converter device.
> + * @chan:	Channel number.
> + *
> + * Enables a channel on the backend device.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int converter_chan_enable(struct converter_backend *conv, unsigned int chan);
> +
> +/**
> + * converter_chan_disable - Disable a backend channel
> + * @conv:	Converter device.
> + * @chan:	Channel number.
> + *
> + * Disables a channel on the backend device.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int converter_chan_disable(struct converter_backend *conv, unsigned int chan);
> +
> +/**
> + * converter_iodelay_set - Set's the backend data interface IO delay
> + * @conv:	Converter device.
> + * @num_lanes:	Number of lanes in the data interface.
> + * @delay:	Delay to set.
> + *
> + * Controls the IO delay for all the lanes at the data interface (where data is
> + * actually transferred between frontend and backend) level.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int converter_iodelay_set(struct converter_backend *conv,
> +			  unsigned int num_lanes, unsigned int delay);
> +
> +/**
> + * converter_frontend_del - Remove the frontend device
> + * @dev:	Device to remove from the aggregate
> + *
> + * Removes the frontend from the aggregate device. This tears down the frontend
> + * and all the converters.
> + *
> + * Ideally, this should be called from the frontend driver .remove() callback.
> + * This means that all the converters (and the frontend) will be tear down
torn down 
> + * before running any specific devres cleanup (at the driver core level). What
> + * this all means is that we can use devm_ apis in .frontend_init() and being
> + * sure those resources will be released after the backend resources and before
> + * any devm_* used in .probe(). If that is not the case, one should likely not
> + * use any devm_ API in .frontend_init(). That means .frontend_close() should be
> + * provided to do all the necessary cleanups.

You can force a driver remove to tear down another driver binding first though it all
gets fiddly.  Take a look at how device_release_driver() is used.  May well not
help you here though - I've not thought it through properly.

> + */
> +void converter_frontend_del(struct device *dev);
> +
> +/**
> + * converter_frontend_add - Allocate and add a frontend device
> + * @dev:	Device to allocate frontend for.
> + * @ops:	Frontend callbacks.
> + *
> + * This allocates the frontend device and looks for all converters needed
> + * so that, when they are available, all of the devices in the aggregate can be
> + * initialized.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int converter_frontend_add(struct device *dev, const struct frontend_ops *ops);
> +
> +/**
> + * converter_get - Get a converter object
> + * @frontend:	Frontend device.
> + * @name:	Converter name.
> + *
> + * Get's a pointer to a converter device. If name is NULL, then it is assumed
> + * that only one backend device is bond with the frontend and the first element
> + * in the list is retrieved. Should only be called from the .frontend_init()
> + * callback.
> + *
> + * RETURNS:
> + * A converter pointer, negative error pointer otherwise.
> + */
> +struct converter_backend *__must_check
> +converter_get(const struct converter_frontend *frontend, const char *name);
> +
> +/**
> + * converter_add_direct_reg_access - Add debugfs direct register access
> + * @conv: Coverter device
> + * @indio_dev: IIO device
> + *
> + * This is analogous to the typical IIO direct register access in debugfs. The
> + * extra converter file will be added in the same debugs dir as @indio_dev.
> + * Moreover, if @conv->name is NULL, the file will be called
> + * converter_direct_reg_access. Otherwise, will be
> + * @conv->name_converter_direct_reg_access.
> + */
> +void converter_add_direct_reg_access(struct converter_backend *conv,
> +				     struct iio_dev *indio_dev);
> +
...
/

