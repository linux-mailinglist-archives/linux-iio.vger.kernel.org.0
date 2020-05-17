Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB431D6C1B
	for <lists+linux-iio@lfdr.de>; Sun, 17 May 2020 21:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgEQTJ3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 May 2020 15:09:29 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:52875 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbgEQTJ3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2020 15:09:29 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.156.173])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 40D6B5E1A4CF;
        Sun, 17 May 2020 21:09:27 +0200 (CEST)
Received: from localhost (34.99.246.4) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Sun, 17 May
 2020 21:09:26 +0200
Date:   Sun, 17 May 2020 21:07:28 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: Re: [PATCH 10/11] iio:chemical:sps30: Fix timestamp alignment
Message-ID: <20200517190728.GB18033@arch>
References: <20200517173000.220819-1-jic23@kernel.org>
 <20200517173000.220819-11-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200517173000.220819-11-jic23@kernel.org>
X-Originating-IP: [34.99.246.4]
X-ClientProxiedBy: DAG3EX2.emp2.local (172.16.2.22) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 10081026291751214162
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddtfedgudefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujghisehttdertddttdejnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecuggftrfgrthhtvghrnheptdehveethfffudetjeeftdekueehjeegjedvteffgfevkefffeegffeugeehgfejnecukfhppedtrddtrddtrddtpdefgedrleelrddvgeeirdegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtohepthguuhhsiiihnhhssehgmhgrihhlrdgtohhm
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 17, 2020 at 06:29:59PM +0100, jic23@kernel.org wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
>
> Fixes: 232e0f6ddeae ("iio: chemical: add support for Sensirion SPS30 sensor")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  drivers/iio/chemical/sps30.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
> index acb9f8ecbb3d..a88c1fb875a0 100644
> --- a/drivers/iio/chemical/sps30.c
> +++ b/drivers/iio/chemical/sps30.c
> @@ -230,15 +230,18 @@ static irqreturn_t sps30_trigger_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct sps30_state *state = iio_priv(indio_dev);
>  	int ret;
> -	s32 data[4 + 2]; /* PM1, PM2P5, PM4, PM10, timestamp */
> +	struct {
> +		s32 data[4]; /* PM1, PM2P5, PM4, PM10 */
> +		s64 ts;
> +	} scan;
>
>  	mutex_lock(&state->lock);
> -	ret = sps30_do_meas(state, data, 4);
> +	ret = sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));
>  	mutex_unlock(&state->lock);
>  	if (ret)
>  		goto err;
>
> -	iio_push_to_buffers_with_timestamp(indio_dev, data,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
>  					   iio_get_time_ns(indio_dev));
>  err:
>  	iio_trigger_notify_done(indio_dev->trig);
> --
> 2.26.2
>

Thanks for the fix.
Acked-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
