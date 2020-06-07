Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C67E1F0D92
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 20:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgFGSFc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 14:05:32 -0400
Received: from smtpout1.mo803.mail-out.ovh.net ([79.137.123.219]:58515 "EHLO
        smtpout1.mo803.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726714AbgFGSFb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2020 14:05:31 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.138.11])
        by mo803.mail-out.ovh.net (Postfix) with ESMTPS id 91ED555D9CBB;
        Sun,  7 Jun 2020 20:05:29 +0200 (CEST)
Received: from localhost (89.70.180.118) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Sun, 7 Jun 2020
 20:05:29 +0200
Date:   Sun, 7 Jun 2020 20:03:13 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 21/32] iio:pressure:ms5611 Fix buffer element alignment
Message-ID: <20200607180313.GA95841@arch>
References: <20200607155408.958437-1-jic23@kernel.org>
 <20200607155408.958437-22-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200607155408.958437-22-jic23@kernel.org>
X-Originating-IP: [89.70.180.118]
X-ClientProxiedBy: DAG3EX2.emp2.local (172.16.2.22) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 3200370488883895378
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudegledguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujghisehttdertddttdejnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecuggftrfgrthhtvghrnheptdehveethfffudetjeeftdekueehjeegjedvteffgfevkefffeegffeugeehgfejnecukfhppedtrddtrddtrddtpdekledrjedtrddukedtrdduudeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtoheplhgrrhhssehmvghtrghfohhordguvg
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 07, 2020 at 04:53:57PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> Here there is no data leak possibility so use an explicit structure
> on the stack to ensure alignment and nice readable fashion.
>
> The forced alignment of ts isn't strictly necessary in this driver
> as the padding will be correct anyway (there isn't any).  However
> it is probably less fragile to have it there and it acts as
> documentation of the requirement.
>

Looks good.
Acked-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>

> Fixes: 713bbb4efb9dc ("iio: pressure: ms5611: Add triggered buffer support")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/pressure/ms5611_core.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index d451bb9dffc8..214b0d25f598 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -212,16 +212,21 @@ static irqreturn_t ms5611_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ms5611_state *st = iio_priv(indio_dev);
> -	s32 buf[4]; /* s32 (pressure) + s32 (temp) + 2 * s32 (timestamp) */
> +	/* Ensure buffer elements are naturally aligned */
> +	struct {
> +		s32 channels[2];
> +		s64 ts __aligned(8);
> +	} scan;
>  	int ret;
>
>  	mutex_lock(&st->lock);
> -	ret = ms5611_read_temp_and_pressure(indio_dev, &buf[1], &buf[0]);
> +	ret = ms5611_read_temp_and_pressure(indio_dev, &scan.channels[1],
> +					    &scan.channels[0]);
>  	mutex_unlock(&st->lock);
>  	if (ret < 0)
>  		goto err;
>
> -	iio_push_to_buffers_with_timestamp(indio_dev, buf,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
>  					   iio_get_time_ns(indio_dev));
>
>  err:
> --
> 2.26.2
>
