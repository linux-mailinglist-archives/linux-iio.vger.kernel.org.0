Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E85B36A815
	for <lists+linux-iio@lfdr.de>; Sun, 25 Apr 2021 17:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhDYPx2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Apr 2021 11:53:28 -0400
Received: from www381.your-server.de ([78.46.137.84]:48872 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbhDYPx2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Apr 2021 11:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=qVCYXXALEYBXY11wg18BGx/QYuKcJVstYR8bnCDnqws=; b=PJQYXMSCtv8TMwz8Ei6Lxf2uiE
        HtxKaFWeC5REZ0zRjoJcD/ajifjLkZ0H/QuOorVp1VvejB+WM/8TqhkOawghJb4qEKY0uXPtLjeoM
        DN9lEpkjiHya7B2B8wOeQAM/NmV6Lnt4vkwU+Z1/HHM+PnmBjcmdXsBnYu47On6M+gFvbfhMmRuI8
        2lHMhAvp+cRpEfw7cd+DM5ftZ20QquUBiYQ4DbBWRTZpHJd5FwutdALekVlkOzoQqeM88nBzsh04M
        cj/oIfq54FJUKDhQ+HQP9lrAYcuDx9eEDPHcO7Ulf3/zFnEDfkedx8rbmS1AKRbGBd+O3LerIchkf
        sMYW0HAA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lah3v-000B6J-CB; Sun, 25 Apr 2021 17:52:47 +0200
Received: from [2001:a61:2a42:9501:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lah3v-000TAH-6j; Sun, 25 Apr 2021 17:52:47 +0200
Subject: Re: [PATCH 2/3] iio: sps30: add support for serial interface
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, robh+dt@kernel.org
References: <20210425135546.57343-1-tomasz.duszynski@octakon.com>
 <20210425135546.57343-3-tomasz.duszynski@octakon.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <6b00dc0d-f678-07e2-96be-35eeca90d799@metafoo.de>
Date:   Sun, 25 Apr 2021 17:52:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210425135546.57343-3-tomasz.duszynski@octakon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26151/Sun Apr 25 13:05:06 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/25/21 3:55 PM, Tomasz Duszynski wrote:
> [...]
>
> +struct sps30_serial_priv {
> +	struct completion new_frame;
> +	char buf[SPS30_SERIAL_MAX_BUF_SIZE];
The driver uses char, but the serdev API uses unsigned char. Just to 
avoid any surprises I'd use unsigned char for all the buffers in the 
driver as well.
> +	int num;
> +	unsigned int chksum;
> +	bool escaped;
> +	bool done;
> +};
> +
> +static int sps30_serial_xfer(struct sps30_state *state, const char *buf, int size)
> +{
> +	struct serdev_device *serdev = to_serdev_device(state->dev);
> +	struct sps30_serial_priv *priv = state->priv;
> +	int ret;
> +
> +	priv->num = 0;
> +	priv->chksum = 0;
> +	priv->escaped = false;
> +	priv->done = false;
Hm... no locking with regards to the serdev callback. I guess the 
assumption is that we'll never receive any data without explicitly 
requesting it.
> +
> +	ret = serdev_device_write(serdev, buf, size, SPS30_SERIAL_TIMEOUT);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != size)
> +		return -EIO;
> +
> +	ret = wait_for_completion_interruptible_timeout(&priv->new_frame, SPS30_SERIAL_TIMEOUT);
> +	if (ret < 0)
> +		return ret;
> +	if (!ret)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> [...]
> +static bool sps30_serial_frame_valid(struct sps30_state *state, const char *buf)
> +{
> +	struct sps30_serial_priv *priv = state->priv;
> +
> +	if ((priv->num < SPS30_SERIAL_FRAME_MIN_SIZE) ||
> +	    (priv->num != SPS30_SERIAL_FRAME_MIN_SIZE +
> +	     priv->buf[SPS30_SERIAL_FRAME_MISO_LEN_OFFSET])) {
> +		dev_err(state->dev, "frame has invalid number of bytes\n");
> +		return false;
> +	}
> +
> +	if ((priv->buf[SPS30_SERIAL_FRAME_ADR_OFFSET] != buf[SPS30_SERIAL_FRAME_ADR_OFFSET]) ||
> +	    (priv->buf[SPS30_SERIAL_FRAME_CMD_OFFSET] != buf[SPS30_SERIAL_FRAME_CMD_OFFSET])) {
> +		dev_err(state->dev, "frame has wrong ADR and CMD bytes\n");
> +		return false;
> +	}
> +
> +	if (priv->buf[SPS30_SERIAL_FRAME_MISO_STATE_OFFSET]) {
> +		dev_err(state->dev, "frame with non-zero state received (0x%02x)\n",
> +			priv->buf[SPS30_SERIAL_FRAME_MISO_STATE_OFFSET]);
> +		//return false;
What's with the out commented line?
> +	}
> +
> +	if (priv->buf[priv->num - 2] != priv->chksum) {
> +		dev_err(state->dev, "frame integrity check failed\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static int sps30_serial_command(struct sps30_state *state, char cmd, void *arg, int arg_size,
> +				void *rsp, int rsp_size)
> +{
> +	struct sps30_serial_priv *priv = state->priv;
> +	char buf[SPS30_SERIAL_MAX_BUF_SIZE];
> +	int ret, size;
> +
> +	size = sps30_serial_prep_frame(buf, cmd, arg, arg_size);
> +	ret = sps30_serial_xfer(state, buf, size);
> +	if (ret)
> +		return ret;
> +
> +	if (!sps30_serial_frame_valid(state, buf))
> +		return -EIO;
> +
> +	if (rsp) {
> +		rsp_size = clamp((int)priv->buf[SPS30_SERIAL_FRAME_MISO_LEN_OFFSET], 0, rsp_size);
If buf is unsigned char this can be a min_t(unsigned int, ...). And 
maybe also make rsp_size unsigned int.
> +		memcpy(rsp, &priv->buf[SPS30_SERIAL_FRAME_MISO_DATA_OFFSET], rsp_size);
> +	}
> +
> +	return rsp_size;
> +}
> +
> +static int sps30_serial_receive_buf(struct serdev_device *serdev, const unsigned char *buf,
> +				    size_t size)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);
> +	struct sps30_serial_priv *priv;
> +	struct sps30_state *state;
> +	unsigned char byte;
> +	int i;
> +
> +	if (!indio_dev)
> +		return 0;

> +
> +	state = iio_priv(indio_dev);
> +	priv = state->priv;
> +
> +	/* just in case device put some unexpected data on the bus */
> +	if (priv->done)
> +		return size;
> +
> +	/* wait for the start of frame */
> +	if (!priv->num && size && buf[0] != SPS30_SERIAL_SOF_EOF)
> +		return 1;
> +
> +	if (priv->num + size >= ARRAY_SIZE(priv->buf))
> +		size = ARRAY_SIZE(priv->buf) - priv->num;
> +
> +	for (i = 0; i < size; i++) {
> +		byte = buf[i];
> +		/* remove stuffed bytes on-the-fly */
> +		if (byte == SPS30_SERIAL_ESCAPE_CHAR) {
> +			priv->escaped = true;
> +			continue;
> +		}
> +
> +		byte = sps30_serial_get_byte(priv->escaped, byte);
> +		if (priv->escaped && !byte)
> +			dev_warn(state->dev, "unrecognized escaped char (0x%02x)\n", byte);
> +		priv->chksum += byte;
> +		/* incrementing here would complete rx just after reading SOF */
> +		priv->buf[priv->num] = byte;
> +
> +		if (priv->num++ && !priv->escaped && byte == SPS30_SERIAL_SOF_EOF) {

This is a bit to tricky for my taste.

How about.

priv->num++

if (priv->num > 1 && ...)

> +			/* SOF, EOF and checksum itself are not checksummed */
> +			priv->chksum -= 2 * SPS30_SERIAL_SOF_EOF + priv->buf[priv->num - 2];
> +			priv->chksum = (unsigned char)~priv->chksum;
To keep the whole checksum stuff simpler, maybe just compute it in 
sps30_serial_frame_valid() over the whole set of data.
> +			priv->done = true;
> +			complete(&priv->new_frame);
> +			i++;
> +			break;
> +		}
> +
> +		priv->escaped = false;
> +	}
> +
> +	return i;
> +}
> [...]
> +static int sps30_serial_probe(struct serdev_device *serdev)
> +{
> [...]
> +	return sps30_probe(dev, KBUILD_MODNAME, priv, &sps30_serial_ops);
Usually the IIO device name should just be the part number. Ideally the 
application should not care about the backend. I'd just pass "sps30" 
here for the name.
> +}


