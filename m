Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8001EB654
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jun 2020 09:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgFBHPp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Jun 2020 03:15:45 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:59539 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbgFBHPp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jun 2020 03:15:45 -0400
Received: from pro2.mail.ovh.net (unknown [10.108.1.149])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 9B4386059ACD;
        Tue,  2 Jun 2020 09:15:40 +0200 (CEST)
Received: from localhost (34.103.240.103) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 2 Jun 2020
 09:15:41 +0200
Date:   Tue, 2 Jun 2020 09:13:28 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 1/4] iio: chemical: scd30: add core driver
Message-ID: <20200602071328.GA2668@arch>
References: <20200530213630.87159-1-tomasz.duszynski@octakon.com>
 <20200530213630.87159-2-tomasz.duszynski@octakon.com>
 <20200531105840.27e17f3d@archlinux>
 <20200531192152.GC27246@arch>
 <20200601113604.00002d70@Huawei.com>
 <20200601113006.GA28560@arch>
 <20200601144120.000038ba@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200601144120.000038ba@Huawei.com>
X-Originating-IP: [34.103.240.103]
X-ClientProxiedBy: DAG2EX2.emp2.local (172.16.2.12) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 18202423796053400822
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudefiedgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujghisehttdertddttdejnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecuggftrfgrthhtvghrnheptdehveethfffudetjeeftdekueehjeegjedvteffgfevkefffeegffeugeehgfejnecukfhppedtrddtrddtrddtpdefgedruddtfedrvdegtddruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehpmhgvvghrfiesphhmvggvrhifrdhnvght
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 01, 2020 at 02:41:20PM +0100, Jonathan Cameron wrote:
> ...
>
> > > > > > +
> > > > > > +	return ret;
> > > > > > +}
> > > > > > +
> > > > > > +int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
> > > > > > +		scd30_command_t command)
> > > > > > +{
> > > > > > +	static const unsigned long scd30_scan_masks[] = { 0x07, 0x00 };
> > > > > > +	struct scd30_state *state;
> > > > > > +	struct iio_dev *indio_dev;
> > > > > > +	int ret;
> > > > > > +	u16 val;
> > > > > > +
> > > > > > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
> > > > > > +	if (!indio_dev)
> > > > > > +		return -ENOMEM;
> > > > > > +
> > > > > > +	state = iio_priv(indio_dev);
> > > > > > +	state->dev = dev;
> > > > >
> > > > > Doesn't seem to be used.
> > > > >
> > > > > > +	state->priv = priv;
> > > > >
> > > > > What's this for?  At least at first glance I can't find it being used
> > > > > anywhere.
> > > > >
> > > > > > +	state->irq = irq;
> > > > > > +	state->pressure_comp = SCD30_PRESSURE_COMP_DEFAULT;
> > > > > > +	state->meas_interval = SCD30_MEAS_INTERVAL_DEFAULT;
> > > > > > +	state->command = command;
> > > > > > +	mutex_init(&state->lock);
> > > > > > +	init_completion(&state->meas_ready);
> > > > > > +
> > > > > > +	dev_set_drvdata(dev, indio_dev);
> > > > > > +
> > > > > > +	indio_dev->dev.parent = dev;
> > > > >
> > > > > Side note that there is a series moving this into the core under revision at
> > > > > the moment.  Hopefully I'll remember to fix this up when applying your patch
> > > > > if that one has gone in ahead of it.
> > > > >
> > > > > > +	indio_dev->info = &scd30_info;
> > > > > > +	indio_dev->name = name;
> > > > > > +	indio_dev->channels = scd30_channels;
> > > > > > +	indio_dev->num_channels = ARRAY_SIZE(scd30_channels);
> > > > > > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > > > > > +	indio_dev->available_scan_masks = scd30_scan_masks;
> > > > > > +
> > > > > > +	state->vdd = devm_regulator_get(dev, "vdd");
> > > > > > +	if (IS_ERR(state->vdd)) {
> > > > > > +		if (PTR_ERR(state->vdd) == -EPROBE_DEFER)
> > > > > > +			return -EPROBE_DEFER;
> > > > > > +
> > > > > > +		dev_err(dev, "failed to get regulator\n");
> > > > > > +		return PTR_ERR(state->vdd);
> > > > > > +	}
> > > > > > +
> > > > > > +	ret = regulator_enable(state->vdd);
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	ret = devm_add_action_or_reset(dev, scd30_disable_regulator, state);
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > >
> > > > > A comment here on why it makes sense to register this here.  What
> > > > > started mesurement? It seems that happens well below here so
> > > > > we should really call this after that start all.
> > > > >
> > > >
> > > > Sensor after being powered up starts in mode it was left in.
> > > > Chances are it was continuous mode and we want to shut it down.
> > >
> > > That's fine.  The question is why 'here' as opposed to after the below where you
> > > put it into continuous mode.
> > >
> >
> > Let's suppose sensor got energized and started measuring. Then without
> > registering action which stops measurement we jump to device reset etc.
> >
> > Now if reset failed for whatever reason (same applies to everything
> > below reset) devm will gracefully unwind previous actions but sensor
> > will continue doing his job. But there's no point. Better to save some
> > milliaps for later.
>
> I'm not convinced. Note that in your example, the sensor was already on.
> If we never loaded the driver it would stay on.  We should
> deal with only problems we have potentially created.
>

Fair enough.

> If reset fails, it shouldn't 'enable' the sensor hence we are just in
> the same state as if the driver hadn't loaded at all.  Also if reset
> fails the chance of a disable succeeding is very low.
>
> The code is much more logical with this being done immediately after
> the action to enable thing we are disabling.  So please put it down
> there.
>
>
>
> >
> > In case we have real regulator then there's no real issue because
> > power gets cut off during cleanup.
> >
> > Quite often though there's only a dummy one which does nothing useful
> > except making regulator framework happy.
> >
> > So my thinking here is that we're slightly better off registering
> > scd30_stop_meas() action earlier to prevent such scenario from happening.
> >
> > > >
> > > > > > +	ret = devm_add_action_or_reset(dev, scd30_stop_meas, state);
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	ret = scd30_reset(state);
> > > > > > +	if (ret) {
> > > > > > +		dev_err(dev, "failed to reset device: %d\n", ret);
> > > > > > +		return ret;
> > > > > > +	}
> > > > > > +
> > > > > > +	if (state->irq > 0) {
> > > > > > +		ret = scd30_setup_trigger(indio_dev);
> > > > > > +		if (ret) {
> > > > > > +			dev_err(dev, "failed to setup trigger: %d\n", ret);
> > > > > > +			return ret;
> > > > > > +		}
> > > > > > +	}
> > > > > > +
> > > > > > +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > > > > > +					      scd30_trigger_handler, NULL);
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	ret = scd30_command_read(state, CMD_FW_VERSION, &val);
> > > > > > +	if (ret) {
> > > > > > +		dev_err(dev, "failed to read firmware version: %d\n", ret);
> > > > > > +		return ret;
> > > > > > +	}
> > > > > > +	dev_info(dev, "firmware version: %d.%d\n", val >> 8, (char)val);
> > > > > > +
> > > > > > +	ret = scd30_command_write(state, CMD_MEAS_INTERVAL,
> > > > > > +				  state->meas_interval);
> > > > > > +	if (ret) {
> > > > > > +		dev_err(dev, "failed to set measurement interval: %d\n", ret);
> > > > > > +		return ret;
> > > > > > +	}
> > > > > > +
> > > > > > +	ret = scd30_command_write(state, CMD_START_MEAS, state->pressure_comp);
> > > > > > +	if (ret) {
> > > > > > +		dev_err(dev, "failed to start measurement: %d\n", ret);
> > > > > > +		return ret;
> > > > > > +	}
> Here is where we should register that cleanup handler.
>
> Jonathan
>
> > > > > > +
> > > > > > +	return devm_iio_device_register(dev, indio_dev);
> > > > > > +}
> > > > > > +EXPORT_SYMBOL(scd30_probe);
> > > > > > +
> > > > > > +MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
> > > > > > +MODULE_DESCRIPTION("Sensirion SCD30 carbon dioxide sensor core driver");
> > > > > > +MODULE_LICENSE("GPL v2");
> > > > > > --
> > > > > > 2.26.2
> > > > > >
> > > > >
> > >
> > >
>
>
