Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039CE1D6C19
	for <lists+linux-iio@lfdr.de>; Sun, 17 May 2020 21:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgEQTIv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 May 2020 15:08:51 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:49675 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbgEQTIv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2020 15:08:51 -0400
Received: from pro2.mail.ovh.net (unknown [10.108.1.143])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 3B9835E1A4B8;
        Sun, 17 May 2020 21:08:48 +0200 (CEST)
Received: from localhost (34.99.246.4) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Sun, 17 May
 2020 21:08:47 +0200
Date:   Sun, 17 May 2020 21:06:55 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: Re: [PATCH 11/11] iio:chemical:pms7003: Fix timestamp alignment and
 prevent data leak.
Message-ID: <20200517190655.GA18033@arch>
References: <20200517173000.220819-1-jic23@kernel.org>
 <20200517173000.220819-12-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200517173000.220819-12-jic23@kernel.org>
X-Originating-IP: [34.99.246.4]
X-ClientProxiedBy: DAG1EX1.emp2.local (172.16.2.1) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 10070048767487466578
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddtfedgudefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujghisehttdertddttdejnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecuggftrfgrthhtvghrnheptdehveethfffudetjeeftdekueehjeegjedvteffgfevkefffeegffeugeehgfejnecukfhppedtrddtrddtrddtpdefgedrleelrddvgeeirdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtohepthguuhhsiiihnhhssehgmhgrihhlrdgtohhm
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 17, 2020 at 06:30:00PM +0100, jic23@kernel.org wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable structure in the iio_priv() data with alignment
> explicitly requested.  This data is allocated with kzalloc so no
> data can leak appart from previous readings.
>
> Fixes: a1d642266c14 ("iio: chemical: add support for Plantower PMS7003 sensor")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  drivers/iio/chemical/pms7003.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
> index 23c9ab252470..07bb90d72434 100644
> --- a/drivers/iio/chemical/pms7003.c
> +++ b/drivers/iio/chemical/pms7003.c
> @@ -73,6 +73,11 @@ struct pms7003_state {
>  	struct pms7003_frame frame;
>  	struct completion frame_ready;
>  	struct mutex lock; /* must be held whenever state gets touched */
> +	/* Used to construct scan to push to the IIO buffer */
> +	struct {
> +		u16 data[3]; /* PM1, PM2P5, PM10 */
> +		s64 ts;
> +	} scan;
>  };
>
>  static int pms7003_do_cmd(struct pms7003_state *state, enum pms7003_cmd cmd)
> @@ -104,7 +109,6 @@ static irqreturn_t pms7003_trigger_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct pms7003_state *state = iio_priv(indio_dev);
>  	struct pms7003_frame *frame = &state->frame;
> -	u16 data[3 + 1 + 4]; /* PM1, PM2P5, PM10, padding, timestamp */
>  	int ret;
>
>  	mutex_lock(&state->lock);
> @@ -114,12 +118,15 @@ static irqreturn_t pms7003_trigger_handler(int irq, void *p)
>  		goto err;
>  	}
>
> -	data[PM1] = pms7003_get_pm(frame->data + PMS7003_PM1_OFFSET);
> -	data[PM2P5] = pms7003_get_pm(frame->data + PMS7003_PM2P5_OFFSET);
> -	data[PM10] = pms7003_get_pm(frame->data + PMS7003_PM10_OFFSET);
> +	state->scan.data[PM1] =
> +		pms7003_get_pm(frame->data + PMS7003_PM1_OFFSET);
> +	state->scan.data[PM2P5] =
> +		pms7003_get_pm(frame->data + PMS7003_PM2P5_OFFSET);
> +	state->scan.data[PM10] =
> +		pms7003_get_pm(frame->data + PMS7003_PM10_OFFSET);
>  	mutex_unlock(&state->lock);
>
> -	iio_push_to_buffers_with_timestamp(indio_dev, data,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &state->scan,
>  					   iio_get_time_ns(indio_dev));
>  err:
>  	iio_trigger_notify_done(indio_dev->trig);
> --
> 2.26.2
>

Thanks for the fix.
Acked-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>

