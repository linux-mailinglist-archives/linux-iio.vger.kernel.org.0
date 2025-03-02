Return-Path: <linux-iio+bounces-16247-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82006A4B1CD
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 14:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF963B274F
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 13:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7E51E5B6C;
	Sun,  2 Mar 2025 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9KzrJON"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CA01EB3D;
	Sun,  2 Mar 2025 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740921353; cv=none; b=gnO0TC/5Kq+zXJkfgYxTPVOJl3fDHX50k80qgt3fWI8srB2vt1tv4XOfrURTxOcfTxm+/LukwttuT6oxi1CNOjYdtyRaSDwUvXZBj3bRqAPOn+Pg2A+ahZpeiZwRLSmxielXWOJ+oSfAzXq6Jq24XbWHzEiBpvthMPt6NytB4w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740921353; c=relaxed/simple;
	bh=E+tf5gJ3h3w6HycF9ratLCSZSX3tCmqhgj6Hu+c132g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VU6VHz7QHmHJ8+4slBH13+tMDvfr8kIkZRJYz787jm12CkmbwFwJpLCSxZHQxtuXp/KiatRZDJ0/V7O2ClWgcRoTTJuzx5wU9whQ8vebMBtGgqtmf4zmZV54mU1I40iTlFPUXrh9/d6+r8sOQJ9C0NQBwHFanB+hjC1okd0ngjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9KzrJON; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5496301c6afso430207e87.0;
        Sun, 02 Mar 2025 05:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740921349; x=1741526149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOHZ9RwHYzXMQ8jAnz//sM4ODepJhiFxm1L6Ef+fj6g=;
        b=O9KzrJON0LzVM31vgWB8WQ3c5Brf2G/3wH2LEHYGvPa+BQS8ZX9LbyU3bVspGnUTJ8
         ZznodpclX5qfIwRQ70z62i7wsuJ7Sds7KZeTYj58Mv+3KvV9Oa4pvVIJ2PRq3Ktsqj4L
         5CIK4A+REn6YmDDVcNtpbXcDYOb73klHUPqGJ0+hgCdxH80aQRbsROoGMWeeNleuZYEN
         zmGXZ0LxfvdlLpIZyfY2WiYYxTMINm5RuKK9OnAw3peKE8nQgoSm36eovte8CwciNz6G
         oAVYD8vNW7+YLrEdVtMy0Ui/cX580VjgHp+M8OFUVIqU4yY3G4S0k68m5QF3Pqjms0ys
         x1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740921349; x=1741526149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOHZ9RwHYzXMQ8jAnz//sM4ODepJhiFxm1L6Ef+fj6g=;
        b=oF0GnePiJ9Q6pI2JQ1hric0NAZc3l1xcHtF/mYxFoLf9iiIjzbYCSo7Gvrsy/15nRQ
         98rUqOj+cmeFaaYC8JGO7aVx2t2zo/iMqcZeD7zA0ubc1cTJOKVshNI5956MXbTpj3zo
         uq4hQATm21q3aaL/Yoi41lmSlqP9G7uUgAGY0bqbnjYBXq91zQk3F8CC1WQ8YUhjCiWe
         ON27P2iYOi4ulPs/PRH1VDTLBYqWZZGbHwCxyp73Qj5/RMIZNgCNmXQuaBuMOf6bVLsT
         5v9mWDIeDrrbDuK8q0j4KPtlp/gyGjjngyGOs7N7MuwmFAWGpOBzBHDdjcAZDKJElHPH
         WJBg==
X-Forwarded-Encrypted: i=1; AJvYcCU1JuJJdPFXYJoUFybw3iJKfSFwp7FlpgYW+ieIstDzAyKRVTjf8hIk+5WaAKouhtnSjlt9nCLNIlIN5sSr@vger.kernel.org, AJvYcCUraNMxFgpCGzKgFLpVWHk4zOt9mmnc2fUJ9ZO2ApI04u7AqxlCmx+QwW3Kv4eQi8X4YxOzLvjATiEvkXtz+P4kjuA=@vger.kernel.org, AJvYcCViX9XTffEhUw5lEnGhLIlLAtCNs/yoynmFuI68Cua3SNIP/R4O3kr6NEPhZ09yHBQRjNa/++P/HrLr@vger.kernel.org, AJvYcCVwnOAS8ui9Gg4Rjy672a4g4L7QnyvFP/zI3fkPVKGajFxBJ1jLZvLJRSdEN3dROOyGueiucUCKrhdO@vger.kernel.org, AJvYcCWZtcz/m9DX2ut8nkN0MzWRKwZpvUAj09YPw+QE9BoKwcSK0J6KlTt0tykh9GNC7FO05jK8FOtt5uqqMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt+r1TbGKLg1+JdqUFmwk8m6d8wkt7OFY1932FSo3E2iZLmzdz
	0kqZCFQRueXQZnh1eFw1tBo4bfS6H8YpOkHj0m/pH1Rp753VzjZg
X-Gm-Gg: ASbGncuGi7YL8Aqh0BVpMRa2lRnV42DqRFDsVW2Ay26nZxitu4nEGYFRIU4LFIhI9yz
	X4JmGDlwtcFlUmkGZQ99DKtINqcSA/wG9oIrtc3YLt6Gi6zzJ0s9nDMRMkiq5Oe99tGT/qUqrJj
	Wmc9qwnUF+TWe/XpQag71hVcAjFlO8pf6K3x7z8F34Dk7/8inqujgSi7z/kvsQwyw0TbdrNdlf6
	M8dtPVJ2ZZMu95K8tDouKr3cs3j0CRIkBCSRl3GFkGNhua/cI1/mWM5r+5IdBGiysPSROl8T14/
	vAK3UA9PQRqYSl6echjj00JYsqzvYjfARcIh7eKWwE3AiLuLSuRZCDuug/qg871nyuVfraqskXb
	X7QZ6bVrKknLULqBLkxyzX/tUjQ==
X-Google-Smtp-Source: AGHT+IGHFptw3pHDNvEkh6S8B9YASLA7Mxg1Ob35UR3qFEC4CECgPhwErw/f4EuhZrqOLOxsFMYCdA==
X-Received: by 2002:a05:6512:3a90:b0:545:a70:74c5 with SMTP id 2adb3069b0e04-5494c320d67mr3708996e87.13.1740921348639;
        Sun, 02 Mar 2025 05:15:48 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495bc78d51sm353840e87.27.2025.03.02.05.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 05:15:48 -0800 (PST)
Message-ID: <ccac509c-d063-42f4-a092-bee4014ec9da@gmail.com>
Date: Sun, 2 Mar 2025 15:15:45 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] iio: adc: Support ROHM BD79124 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
 <4d1bf5df8f3b0f760422b6b67fcc8245ebf520e0.1740421249.git.mazziesaccount@gmail.com>
 <20250302041046.7fde3c68@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250302041046.7fde3c68@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/03/2025 06:10, Jonathan Cameron wrote:
> On Mon, 24 Feb 2025 20:34:30 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
>> an automatic measurement mode, with an alarm interrupt for out-of-window
>> measurements. The window is configurable for each channel.
>>
>> The I2C protocol for manual start of the measurement and data reading is
>> somewhat peculiar. It requires the master to do clock stretching after
>> sending the I2C slave-address until the slave has captured the data.
>> Needless to say this is not well suopported by the I2C controllers.
>>
>> Thus the driver does not support the BD79124's manual measurement mode
>> but implements the measurements using automatic measurement mode relying
>> on the BD79124's ability of storing latest measurements into register.
>>
>> The driver does also support configuring the threshold events for
>> detecting the out-of-window events.
>>
>> The BD79124 keeps asserting IRQ for as long as the measured voltage is
>> out of the configured window. Thus the driver masks the received event
>> for a fixed duration (1 second) when an event is handled. This prevents
>> the user-space from choking on the events
>>
>> The ADC input pins can be also configured as general purpose outputs.
>> Those pins which don't have corresponding ADC channel node in the
>> device-tree will be controllable as GPO.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Some minor stuff inline.

...

>> +#define BD79124_INTERVAL_075 0
> 
> Can we make these units in these explicit?
> #define BD79124_INTERVAL_MS_0_75
> maybe?  Nice to avoid need for comments on what the units are where
> you use these.
> 

Sure, thanks.

>> +#define BD79124_INTERVAL_150 1
>> +#define BD79124_INTERVAL_300 2
>> +#define BD79124_INTERVAL_600 3

...

> 
>> +static void bd79124_re_enable_hi(struct bd79124_data *data, unsigned int channel)
>> +{
>> +	int ret, evbit = BIT(IIO_EV_DIR_RISING);
>> +
>> +	if (!(data->alarm_suppressed[channel] & evbit))
>> +		return;
>> +
>> +	data->alarm_suppressed[channel] &= (~evbit);
> 
> No brackets around the ~evbit.
> Check for other cases of this.
> Otherwise we'll get some script written 'cleanup'.

Sigh. I had a lengthy discussion about this with Andy explaining why I 
like having the parenthesis to avoid any confusion. Well, I suppose I 
have no options if you're strongly opposing them.

...

>> +static void bd79124_alm_enable_worker(struct work_struct *work)
>> +{
>> +	int i;
>> +	struct bd79124_data *data = container_of(work, struct bd79124_data,
>> +						 alm_enable_work.work);
>> +
>> +	guard(mutex)(&data->mutex);
>> +	/*
>> +	 * We should not re-enable the event if user has disabled it while
>> +	 * rate-limiting was enabled.
>> +	 */
> 
> Is this comment suggesting something that isn't done or referring to specific
> code?  I think it wants to be in the function above where the decision is made.

I have to take another look but it seems it got misplaced during the 
road. Thanks!

Agreeing with all the rest, thanks!

Yours,
	-- Matti

