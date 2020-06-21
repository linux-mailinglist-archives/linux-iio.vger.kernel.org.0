Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC47B202B71
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jun 2020 17:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbgFUPnF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jun 2020 11:43:05 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:56875 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730356AbgFUPnF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2020 11:43:05 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.143.237])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 0C88D63E478B;
        Sun, 21 Jun 2020 17:43:02 +0200 (CEST)
Received: from localhost (89.70.180.118) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 21 Jun
 2020 17:43:01 +0200
Date:   Sun, 21 Jun 2020 17:40:37 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH v5 1/4] iio: chemical: scd30: add core driver
Message-ID: <20200621154037.GA13809@arch>
References: <20200607175812.95777-2-tomasz.duszynski@octakon.com>
 <20200620172502.0d532081@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200620172502.0d532081@archlinux>
X-Originating-IP: [89.70.180.118]
X-ClientProxiedBy: DAG2EX1.emp2.local (172.16.2.11) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 9225060887347813458
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudektddgleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkfhggtggujghisehttdertddttdejnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecuggftrfgrthhtvghrnheptdehveethfffudetjeeftdekueehjeegjedvteffgfevkefffeegffeugeehgfejnecukfhppedtrddtrddtrddtpdekledrjedtrddukedtrdduudeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtohepphhmvggvrhifsehpmhgvvghrfidrnhgvth
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jun 20, 2020 at 05:25:02PM +0100, Jonathan Cameron wrote:
> On Sun, 7 Jun 2020 19:58:09 +0200
> Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:
>
> > Add Sensirion SCD30 carbon dioxide core driver.
> >
> > Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
>
> A few things I'd missed showed up in warnings when I applied this and
> ran a sparse check.  Please fix up and send a v6.
> Also sanity check the rest with sparse. Note if I'd missed this 0-day
> would have sent use these warnings.
>

Ah, forgot to add C=2 to prior building. Thanks for catching this.

> Thanks,
>
> Jonathan
>
> > +
> > +static int scd30_read_meas(struct scd30_state *state)
> > +{
> > +	int i, ret;
> > +
> > +	ret = state->command(state, CMD_READ_MEAS, 0, state->meas, sizeof(state->meas));
> > +	if (ret)
> > +		return ret;
> > +
> > +	be32_to_cpu_array(state->meas, state->meas, ARRAY_SIZE(state->meas));
>
> The type of the input to the above has the wrong endian markings.
>
> CHECK   drivers/iio/chemical/scd30_core.c
> drivers/iio/chemical/scd30_core.c:123:40: warning: incorrect type in argument 2 (different base types)
> drivers/iio/chemical/scd30_core.c:123:40:    expected restricted __be32 const [usertype] *src
> drivers/iio/chemical/scd30_core.c:123:40:    got int *
>
> Whilst you could use a cast, it would be tidier to use an array of __be32.
>

Here's the only place where it's a __be32. All other places assume
cpu endianess which means changing array type generates a few other warnings
here and there. So I'd prefer to be lazy here and use a cast :).

> > +
> > +	for (i = 0; i < ARRAY_SIZE(state->meas); i++)
> > +		state->meas[i] = scd30_float_to_fp(state->meas[i]);
> > +
> > +	/*
> > +	 * co2 is left unprocessed while temperature and humidity are scaled
> > +	 * to milli deg C and milli percent respectively.
> > +	 */
> > +	state->meas[SCD30_TEMP] *= 10;
> > +	state->meas[SCD30_HR] *= 10;
> > +
> > +	return 0;
> > +}
> > +
>
> ...
>
> > +
> > +static irqreturn_t scd30_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct scd30_state *state = iio_priv(indio_dev);
> > +	struct {
> > +		int data[SCD30_MEAS_COUNT];
> > +		s64 ts __aligned(8);
> > +	} scan = { 0, };
> should be scan = { {0, }, }; or something like that
> as first element happens to be an array.
>
> Actually there is padding in here you need to zero I think.
> So memset is a better bet.
>

Sure.

> > +	int ret;
> > +
> > +	mutex_lock(&state->lock);
> > +	if (!iio_trigger_using_own(indio_dev))
> > +		ret = scd30_read_poll(state);
> > +	else
> > +		ret = scd30_read_meas(state);
> > +	memcpy(scan.data, state->meas, sizeof(state->meas));
> > +	mutex_unlock(&state->lock);
> > +	if (ret)
> > +		goto out;
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
> > +out:
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +	return IRQ_HANDLED;
> > +}
> > +
> ...
