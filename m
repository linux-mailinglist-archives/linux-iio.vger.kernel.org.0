Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B41936B1DB
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 12:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhDZKu4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 06:50:56 -0400
Received: from smtpout1.mo3004.mail-out.ovh.net ([79.137.123.219]:54701 "EHLO
        smtpout1.mo3004.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232422AbhDZKuz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Apr 2021 06:50:55 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.156.180])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id 36AE823D295;
        Mon, 26 Apr 2021 10:50:12 +0000 (UTC)
Received: from localhost (89.70.221.198) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 26 Apr
 2021 12:50:11 +0200
Date:   Mon, 26 Apr 2021 12:46:06 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jic23@kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH 2/3] iio: sps30: add support for serial interface
Message-ID: <YIaZ7rfniLVgMHMh@arch>
References: <20210425135546.57343-1-tomasz.duszynski@octakon.com>
 <20210425135546.57343-3-tomasz.duszynski@octakon.com>
 <6b00dc0d-f678-07e2-96be-35eeca90d799@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <6b00dc0d-f678-07e2-96be-35eeca90d799@metafoo.de>
X-Originating-IP: [89.70.221.198]
X-ClientProxiedBy: DAG1EX1.emp2.local (172.16.2.1) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 11161045780033068116
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvddukedgfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjihesthdtredttddtjeenucfhrhhomhepvfhomhgrshiiucffuhhsiiihnhhskhhiuceothhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtheevtefhffduteejfedtkeeuheejgeejvdetfffgveekffefgeffueeghefgjeenucfkpheptddrtddrtddrtddpkeelrdejtddrvddvuddrudelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehrohgshhdoughtsehkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 25, 2021 at 05:52:47PM +0200, Lars-Peter Clausen wrote:
> On 4/25/21 3:55 PM, Tomasz Duszynski wrote:
> > [...]
> >
> > +struct sps30_serial_priv {
> > +	struct completion new_frame;
> > +	char buf[SPS30_SERIAL_MAX_BUF_SIZE];
> The driver uses char, but the serdev API uses unsigned char. Just to avoid
> any surprises I'd use unsigned char for all the buffers in the driver as
> well.

Sure, will use unsigned variant consistently then.

> > +	int num;
> > +	unsigned int chksum;
> > +	bool escaped;
> > +	bool done;
> > +};
> > +
> > +static int sps30_serial_xfer(struct sps30_state *state, const char *buf, int size)
> > +{
> > +	struct serdev_device *serdev = to_serdev_device(state->dev);
> > +	struct sps30_serial_priv *priv = state->priv;
> > +	int ret;
> > +
> > +	priv->num = 0;
> > +	priv->chksum = 0;
> > +	priv->escaped = false;
> > +	priv->done = false;
> Hm... no locking with regards to the serdev callback. I guess the assumption
> is that we'll never receive any data without explicitly requesting it.

Correct, sensor shouldn't put anything on the bus without explicic
request. Nonetheless I added some flag just in case.

> > +
> > +	ret = serdev_device_write(serdev, buf, size, SPS30_SERIAL_TIMEOUT);
> > +	if (ret < 0)
> > +		return ret;
> > +	if (ret != size)
> > +		return -EIO;
> > +
> > +	ret = wait_for_completion_interruptible_timeout(&priv->new_frame, SPS30_SERIAL_TIMEOUT);
> > +	if (ret < 0)
> > +		return ret;
> > +	if (!ret)
> > +		return -ETIMEDOUT;
> > +
> > +	return 0;
> > +}
> > [...]
> > +static bool sps30_serial_frame_valid(struct sps30_state *state, const char *buf)
> > +{
> > +	struct sps30_serial_priv *priv = state->priv;
> > +
> > +	if ((priv->num < SPS30_SERIAL_FRAME_MIN_SIZE) ||
> > +	    (priv->num != SPS30_SERIAL_FRAME_MIN_SIZE +
> > +	     priv->buf[SPS30_SERIAL_FRAME_MISO_LEN_OFFSET])) {
> > +		dev_err(state->dev, "frame has invalid number of bytes\n");
> > +		return false;
> > +	}
> > +
> > +	if ((priv->buf[SPS30_SERIAL_FRAME_ADR_OFFSET] != buf[SPS30_SERIAL_FRAME_ADR_OFFSET]) ||
> > +	    (priv->buf[SPS30_SERIAL_FRAME_CMD_OFFSET] != buf[SPS30_SERIAL_FRAME_CMD_OFFSET])) {
> > +		dev_err(state->dev, "frame has wrong ADR and CMD bytes\n");
> > +		return false;
> > +	}
> > +
> > +	if (priv->buf[SPS30_SERIAL_FRAME_MISO_STATE_OFFSET]) {
> > +		dev_err(state->dev, "frame with non-zero state received (0x%02x)\n",
> > +			priv->buf[SPS30_SERIAL_FRAME_MISO_STATE_OFFSET]);
> > +		//return false;
> What's with the out commented line?

Good catch. This shouldn't be commented - not sure how that two slashes
got here.

> > +	}
> > +
> > +	if (priv->buf[priv->num - 2] != priv->chksum) {
> > +		dev_err(state->dev, "frame integrity check failed\n");
> > +		return false;
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > +static int sps30_serial_command(struct sps30_state *state, char cmd, void *arg, int arg_size,
> > +				void *rsp, int rsp_size)
> > +{
> > +	struct sps30_serial_priv *priv = state->priv;
> > +	char buf[SPS30_SERIAL_MAX_BUF_SIZE];
> > +	int ret, size;
> > +
> > +	size = sps30_serial_prep_frame(buf, cmd, arg, arg_size);
> > +	ret = sps30_serial_xfer(state, buf, size);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!sps30_serial_frame_valid(state, buf))
> > +		return -EIO;
> > +
> > +	if (rsp) {
> > +		rsp_size = clamp((int)priv->buf[SPS30_SERIAL_FRAME_MISO_LEN_OFFSET], 0, rsp_size);
> If buf is unsigned char this can be a min_t(unsigned int, ...). And maybe
> also make rsp_size unsigned int.

Okay.

> > +		memcpy(rsp, &priv->buf[SPS30_SERIAL_FRAME_MISO_DATA_OFFSET], rsp_size);
> > +	}
> > +
> > +	return rsp_size;
> > +}
> > +
> > +static int sps30_serial_receive_buf(struct serdev_device *serdev, const unsigned char *buf,
> > +				    size_t size)
> > +{
> > +	struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);
> > +	struct sps30_serial_priv *priv;
> > +	struct sps30_state *state;
> > +	unsigned char byte;
> > +	int i;
> > +
> > +	if (!indio_dev)
> > +		return 0;
>
> > +
> > +	state = iio_priv(indio_dev);
> > +	priv = state->priv;
> > +
> > +	/* just in case device put some unexpected data on the bus */
> > +	if (priv->done)
> > +		return size;
> > +
> > +	/* wait for the start of frame */
> > +	if (!priv->num && size && buf[0] != SPS30_SERIAL_SOF_EOF)
> > +		return 1;
> > +
> > +	if (priv->num + size >= ARRAY_SIZE(priv->buf))
> > +		size = ARRAY_SIZE(priv->buf) - priv->num;
> > +
> > +	for (i = 0; i < size; i++) {
> > +		byte = buf[i];
> > +		/* remove stuffed bytes on-the-fly */
> > +		if (byte == SPS30_SERIAL_ESCAPE_CHAR) {
> > +			priv->escaped = true;
> > +			continue;
> > +		}
> > +
> > +		byte = sps30_serial_get_byte(priv->escaped, byte);
> > +		if (priv->escaped && !byte)
> > +			dev_warn(state->dev, "unrecognized escaped char (0x%02x)\n", byte);
> > +		priv->chksum += byte;
> > +		/* incrementing here would complete rx just after reading SOF */
> > +		priv->buf[priv->num] = byte;
> > +
> > +		if (priv->num++ && !priv->escaped && byte == SPS30_SERIAL_SOF_EOF) {
>
> This is a bit to tricky for my taste.
>

Less than ideal but didn't come up with anything better which is why I
put extra comment a few lines above.

> How about.
>
> priv->num++
>
> if (priv->num > 1 && ...)
>

Makes sense.

> > +			/* SOF, EOF and checksum itself are not checksummed */
> > +			priv->chksum -= 2 * SPS30_SERIAL_SOF_EOF + priv->buf[priv->num - 2];
> > +			priv->chksum = (unsigned char)~priv->chksum;
> To keep the whole checksum stuff simpler, maybe just compute it in
> sps30_serial_frame_valid() over the whole set of data.

Okay that fits there as well. Advantage here is chksum is computed on
the fly though.

> > +			priv->done = true;
> > +			complete(&priv->new_frame);
> > +			i++;
> > +			break;
> > +		}
> > +
> > +		priv->escaped = false;
> > +	}
> > +
> > +	return i;
> > +}
> > [...]
> > +static int sps30_serial_probe(struct serdev_device *serdev)
> > +{
> > [...]
> > +	return sps30_probe(dev, KBUILD_MODNAME, priv, &sps30_serial_ops);
> Usually the IIO device name should just be the part number. Ideally the
> application should not care about the backend. I'd just pass "sps30" here
> for the name.

Fair enough.

Thanks for review.

> > +}
>
>
