Return-Path: <linux-iio+bounces-3042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C278629E6
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 11:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DE35B2125E
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 10:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FE0E556;
	Sun, 25 Feb 2024 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="LctiBb6D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A97F7460
	for <linux-iio@vger.kernel.org>; Sun, 25 Feb 2024 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708855253; cv=none; b=iuVaTOYPqgi61qArgF7AGy20ANIQvuD+0SkfDEaoX5/Bv47lNQ7B/U7U311DS/YsuGnEmgd5w6GFnaENMsaTInMw1SMGAPj8qnC4QiS2vo+553bfTDfnBbkc3IXUp+MrSMtIgrQiA/tlPpJkrfZywqHjyLR5e98FH9ARTheb8dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708855253; c=relaxed/simple;
	bh=/7ROqcMSn7+eefwRCGL5v8cIELANz7UrqEWv2EQRSpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHWqaYpu1rX/T1MPM7qWeGkkhcFOz+3jumgjnx5fnN1O0alSxvSrDrb/xBckffZLUwEsWhJIbMN0wQcG7zMpNbipJNiBTupOUhxDYyhV5q36tiDiUo0qqIXxGJbaJ0ixh8PeJBSmu4H6AanRx8g4Vi5ScIIrtAYoDd1uSMrm6d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=LctiBb6D; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ce2aada130so2067033a12.1
        for <linux-iio@vger.kernel.org>; Sun, 25 Feb 2024 02:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1708855250; x=1709460050; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jfognGjDDICd8wr8gaW7qWbOVoXyCLnVM/vY1jjtmwI=;
        b=LctiBb6Do0PG99kHGlzLufGn+AGO4NJmDxbXXNalLtcrjRYWNAhKq8lwWH+JIF5iMB
         9rdlse/uRdJaaet1O/dFuWvTKpySXBlqxB5LI3tdWN3yUUgXyQ2X+DUEfLZXBO1YRK53
         nC8EzbgbXjNTHozE5LGSrMBZNnPkdh29Mc1+IY4TwkHS4JOfUjXbMWv7txPQ+mXjl6lc
         acOLGd+5wNIQsGP1ALYszRVysImPGxkbPmRRMT8yBMO5En4VNS2wdiTqh968Za/cCnb+
         4uOVH3Ev/kE//LLxxOuU7QCDHv9PM8n90huBxeDdWo8bJhVmy1Dr76tqJz1wsJXd0GBT
         +0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708855250; x=1709460050;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jfognGjDDICd8wr8gaW7qWbOVoXyCLnVM/vY1jjtmwI=;
        b=I/TJrpPKofI8aplRKfst238g+jLcwFvkbmsBQu4fvy/otREUVOXTmhq84s5+vxO9XM
         /g/iolaQMNBOe9uxiu/RPLyPvWG1O8mYeBIR1SQSC5kuiGF+UKWzaPw1glX3VC/20lul
         j/GKvnsy8vwJ99peeQWStvQ5iiC/4nxegOvPX9hbkmGsgweT9zgIEokh2BPfrDFgmfxi
         vxQ6idxFJ1gbAI08R6IlbipueXkV+gkNTMXorDHxKR84DvweLjnt64EdrnzKtK+DvxTg
         4yzjkgt0PAv0FAb9M+1sOh/LtdbGM3OD6tBT6z8oJVCkDPYVCfvqHVSI4YzrQaHcSe5v
         Jf4A==
X-Forwarded-Encrypted: i=1; AJvYcCWgXs3mqRa93HYTtvRKG9KeZYuvtVrAdu0sYFqh+TQnf94N8EWezf/bquXtzSuywCOlwRmhwObcSOsVpaH5j09GxI0zfAZUarJR
X-Gm-Message-State: AOJu0YxiEMkVDUS8/5DCN+cJrKRAs3Dav+uSc5rG/SHgrcRQ3CjN9xB5
	QJ+bGk7YI6CUaBbiQBCNEOE0ariLlVQ1rOE5+3vZJzNcnDCs3/6MYeseJUWuILg=
X-Google-Smtp-Source: AGHT+IGIJYCYE8Yhoths6NxLp99D7So38TByNErxBWK/xxaGu9NWcpLIJpHsaH+tfVnpRg5rIRsdmA==
X-Received: by 2002:a05:6a20:c90a:b0:1a0:d3a8:6dfb with SMTP id gx10-20020a056a20c90a00b001a0d3a86dfbmr3930340pzb.19.1708855249665;
        Sun, 25 Feb 2024 02:00:49 -0800 (PST)
Received: from [192.168.20.11] ([180.150.112.31])
        by smtp.gmail.com with ESMTPSA id jb14-20020a170903258e00b001d8fe6cd0f0sm2042175plb.150.2024.02.25.02.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 02:00:49 -0800 (PST)
Message-ID: <15a46491-d126-4998-88f0-1720316f0a6c@tweaklogic.com>
Date: Sun, 25 Feb 2024 20:30:40 +1030
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] iio: light: Add support for APDS9306 Light Sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240218054826.2881-1-subhajit.ghosh@tweaklogic.com>
 <20240218054826.2881-6-subhajit.ghosh@tweaklogic.com>
 <20240224151340.3f2f51e8@jic23-huawei>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20240224151340.3f2f51e8@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/2/24 01:43, Jonathan Cameron wrote:
> On Sun, 18 Feb 2024 16:18:26 +1030
> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
> 
>> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.
>> It has two channels - ALS and CLEAR. The ALS (Ambient Light Sensor)
>> channel approximates the response of the human-eye providing direct
>> read out where the output count is proportional to ambient light levels.
>> It is internally temperature compensated and rejects 50Hz and 60Hz flicker
>> caused by artificial light sources. Hardware interrupt configuration is
>> optional. It is a low power device with 20 bit resolution and has
>> configurable adaptive interrupt mode and interrupt persistence mode.
>> The device also features inbuilt hardware gain, multiple integration time
>> selection options and sampling frequency selection options.
>>
>> This driver also uses the IIO GTS (Gain Time Scale) Helpers Namespace for
>> Scales, Gains and Integration time implementation.
>>
>> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> I applied this but then got some build warnings that made me look
> more closely at the int_src handling.
> 
> This is confusing because of the less than helpful datasheet defintion
> of a 2 bit register that takes values 0 and 1 only.
> 
> I thought about trying to fix this up whilst applying but the event code
> issue is too significant to do without a means to test it.
> 
> Jonathan
Appreciate that you tried to fix all the issues for me.
> 
...
> ...
> 
>> +
>> +static irqreturn_t apds9306_irq_handler(int irq, void *priv)
>> +{
>> +	struct iio_dev *indio_dev = priv;
>> +	struct apds9306_data *data = iio_priv(indio_dev);
>> +	struct apds9306_regfields *rf = &data->rf;
>> +	int ret, status, int_ch;
>> +
>> +	/*
>> +	 * The interrupt line is released and the interrupt flag is
>> +	 * cleared as a result of reading the status register. All the
>> +	 * status flags are cleared as a result of this read.
>> +	 */
>> +	ret = regmap_read(data->regmap, APDS9306_MAIN_STATUS_REG, &status);
>> +	if (ret < 0) {
>> +		dev_err_ratelimited(data->dev, "status reg read failed\n");
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	ret = regmap_field_read(rf->int_src, &int_ch);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if ((status & APDS9306_ALS_INT_STAT_MASK))
>> +		iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
>> +			       int_ch, IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER),
>> +			       iio_get_time_ns(indio_dev));
> 
> As commented on elsewhere I'm not seeing the relationship between the event
> pushed here and the channels this device provides (one of which is modified
> for starters).
Yes, I will check which interrupt channel is enabled then push appropriate
event. Earlier versions wrongly had both channels as IIO_LIGHT which were fixed in
later revisions. I forgot to change the event part!
> 
>> +
>> +	/*
>> +	 * If a one-shot read through sysfs is underway at the same time
>> +	 * as this interrupt handler is executing and a read data available
>> +	 * flag was set, this flag is set to inform read_poll_timeout()
>> +	 * to exit.
>> +	 */
>> +	if ((status & APDS9306_ALS_DATA_STAT_MASK))
>> +		data->read_data_available = 1;
>> +
>> +	return IRQ_HANDLED;
>> +}
> 
> ...
> 
>> +static int apds9306_read_event_config(struct iio_dev *indio_dev,
>> +				      const struct iio_chan_spec *chan,
>> +				      enum iio_event_type type,
>> +				      enum iio_event_direction dir)
>> +{
>> +	struct apds9306_data *data = iio_priv(indio_dev);
>> +	struct apds9306_regfields *rf = &data->rf;
>> +	int int_en, event_ch_is_light, ret;
>> +
>> +	switch (type) {
>> +	case IIO_EV_TYPE_THRESH:
>> +		guard(mutex)(&data->mutex);
>> +
>> +		ret = regmap_field_read(rf->int_src, &event_ch_is_light);
> 
> Call the local value int_src - it's not obvious to a reviewer what
> relationship between that and int_src is. I had to go read the datasheet
> to find out.
This unique name was suggested in a previous review:
https://lore.kernel.org/all/20240121152332.6b15666a@jic23-huawei/
I will change it next version. int_src is logical.
> 
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = regmap_field_read(rf->int_en, &int_en);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (chan->type == IIO_LIGHT)
>> +			return int_en & event_ch_is_light;
>> +
>> +		if (chan->type == IIO_INTENSITY)
>> +			return int_en & !event_ch_is_light;
> This is the specific line the compiler doesn't like
> drivers/iio/light/apds9306.c:1036:39: warning: dubious: x & !y
I am using gcc 12.2.0 for cross compiling. I definitely do not want to send
patches with warnings in them. Can you please let me know the gcc version
or flags using which you got the above warning? Should I always use the
latest released version?
> 
> I would match int_src against specific values rather than using tricks
> based on what those values happen to be.
> 
> 			return int_en && (int_src == APDS9306_INT_SRC_CLEAR);
I will implement this.


Thank you for taking time to review the code in detail and also appreciate
your suggestions.

Regards,
Subhajit Ghosh

