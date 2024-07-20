Return-Path: <linux-iio+bounces-7757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FAB938217
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 18:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A82F1C20D8B
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 16:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38715145B00;
	Sat, 20 Jul 2024 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPISnTN1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FB4146A9A;
	Sat, 20 Jul 2024 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721492986; cv=none; b=SESatU+AkrGxyDlQBStyFaoVmQybvKUplUsWshGH2VJ0PfmMXbiSSnNwQxbQd1lx7ctf61zAQipeVbEpfeh8AWgO7w9oP+NkIEMYZHHbbghAsrPjteLGOCO71Q4LT1Asr3xhe+deQyGXRH/aAQKKT9RayDqv2V+qADd8rwN0710=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721492986; c=relaxed/simple;
	bh=gQAyzRDNgGMdptTRgt7JqtA/m21hfwIwvqB/asm9gPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LxwGTII3RPJx/4ahtLPf0s9KWigA/hp/wZ9NSm/yGhVvjcqYXHI+O7//HP/5WW6/EaRAzvS70oYw7p8Pc54LidZlM7TuQzClzoPOdkw47JOsplmBsBNd42Ke+Ud5P+PlHFVdtVPWtmvQT+/fMqt7XxoTgjTWST25rPjPEEUFbLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPISnTN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A0EC4AF0C;
	Sat, 20 Jul 2024 16:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721492985;
	bh=gQAyzRDNgGMdptTRgt7JqtA/m21hfwIwvqB/asm9gPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pPISnTN14Noih2Eq5pVeHCeJ1Pg5g7/z5MbscLsRKkxXlezJPBt6VWnrAh1MSwZNb
	 TwxLi8VDZ9CGpVHttsP+ef2EE342WErTJ4HDEX8ixnNHdFnMoWT7IkOFp6Y+rp+jOF
	 dXMt4//umlv1Bn8rRE2p0IsZpLWL/EjQXFWN6x4ky+qNdabLB9g3mchcxj/K9Rppxo
	 68f3niYsToE7o/ORMeTsB/W6DmHPCQsTK2zQxQTJAaciNefXWykHMFNqrhIS7jwCDf
	 y+HzbIw9T7RmPEHlins+MCfp9p+10maCCz9OvwG66IseAM24JjnuANXtTrraoipwqN
	 tdIxuDD7fBSmw==
Date: Sat, 20 Jul 2024 17:29:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mudit Sharma <muditsharma.info@gmail.com>
Cc: lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org, linux-kernel@vger.kernel.org, mazziesaccount@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Ivan Orlov
 <ivan.orlov0322@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v8 2/2] iio: light: ROHM BH1745 colour sensor
Message-ID: <20240720172936.3a406f0c@jic23-huawei>
In-Reply-To: <20240718220208.331942-2-muditsharma.info@gmail.com>
References: <20240718220208.331942-1-muditsharma.info@gmail.com>
	<20240718220208.331942-2-muditsharma.info@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 23:02:06 +0100
Mudit Sharma <muditsharma.info@gmail.com> wrote:

> Add support for BH1745, which is an I2C colour sensor with red, green,
> blue and clear channels. It has a programmable active low interrupt
> pin. Interrupt occurs when the signal from the selected interrupt
> source channel crosses set interrupt threshold high or low level.
> 
> Interrupt source for the device can be configured by enabling the
> corresponding event. Interrupt latch is always enabled when setting
> up interrupt.
> 
> Add myself as the maintainer for this driver in MAINTAINERS.
> 
> Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
> Reviewed-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Hi Mudit.

Rather than go around again, I've applied a few things I noticed
and changes Javier suggests whilst picking this up.

I also tweaked a few long lines.

Anyhow, applied to the testing branch of iio.git which will be rebased
on rc1 once available and pushed out as togreg for linux-next to
pick up.

Thanks,

Jonathan


> +
> +static irqreturn_t bh1745_trigger_handler(int interrupt, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +	struct {
> +		u16 chans[4];
> +		s64 timestamp __aligned(8);
> +	} scan;
> +	u16 value;
> +	int ret;
> +	int i;
> +	int j = 0;
> +
> +	for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength) {

Nuno's new helper iio_for_each_active_channel()
cleans this up. I'll switch to that whilst applying rather than adding another driver
for him to convert over.


> +		ret = regmap_bulk_read(data->regmap, BH1745_RED_LSB + 2 * i, &value, 2);
> +		if (ret)
> +			goto err;
> +
> +		scan.chans[j++] = value;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
> +
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}

> +
> +static int bh1745_probe(struct i2c_client *client)
> +{
> +	int ret;
> +	int value;
> +	int part_id;
> +	struct bh1745_data *data;
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &client->dev;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, indio_dev);
Trivial, but is this ever used?  I couldn't figure out where it if is.
So I've dropped it. Shout if it needs to be here.

Jonathan



