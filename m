Return-Path: <linux-iio+bounces-13443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7C79F1E4A
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 12:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF03D1885FF9
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 11:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A90E18D622;
	Sat, 14 Dec 2024 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="YIIe+e5X"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAD8187FE4;
	Sat, 14 Dec 2024 11:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734176086; cv=none; b=nbjUzQTGU2a8emzcAKPdHPSMj0FVT61MLf/MjwetnPBQcyeQXFXmVSHetpG6kPpSWFWsCEO1k4w2UWFcN07Y21Vp5q89lL6Pxb8mUbYFSvgrM39sma83KdZpDe9qVtGWJZu9W9RqRo/X4NcQae994yiqEuEhS5YWtugMuO97uHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734176086; c=relaxed/simple;
	bh=QGxPA2Z8w4bT8Nx4145f6RlyjJFWG7P8cnc3HcqOyh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNUgB5Slr9W8JHMfYIkV49CUF/PCITXpHgi/FDXK97GJDAiA5o0iBN4JARxRS4dt+OWlLT9hOyKcUSZwsP7YXuAEVKPNNYwruaSs6wmbAsU2yJMh/PVKs6m6utHtBGF5eQbRDjRYliTG7TccmCQwI7HU4iUNsEGwRzK4C0SAbEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=YIIe+e5X; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id MQOmt72lRkTMYMQOntHrWZ; Sat, 14 Dec 2024 12:33:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1734176010;
	bh=Gw75nHpU5weP3nyqjDky6dBdLXhFOK8aL3/PM8WREb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=YIIe+e5Xbbt14M3Z9IG1aGbdwEB8hEAAnGZBOnvWbND71wM0QVRcUUwhSqlGE+jxI
	 w65tR4YZBz4jXS30qQjuwmpFV7tzqJv9CtjaDRGaI0MyZg/2W2/MGKg7nLVEPfdjQk
	 VLs3/omEzJFdQU+oMwrEdFPdBeGw90NYlzN9CJ5WC8vI/H/1LGaD49r75jeFOQRs9q
	 HXw9Af3jf5Ghoi3eZHzuXAMVlQb3vmqyzRhb72J4gg2E+8hrRDC5sqdmi1GpxbMzOw
	 MgiWPIrAoQEsdsvHh6WdFyzdlU/UDJ37tVhKvVOLb0vYG88TReLWH5pG+d6fqHUonL
	 f51uZ4MOvObmg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 14 Dec 2024 12:33:30 +0100
X-ME-IP: 90.11.132.44
Message-ID: <80b5d56d-b16f-4a93-8868-0a23b10f6ab8@wanadoo.fr>
Date: Sat, 14 Dec 2024 12:33:27 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] iio: accel: adxl345: add function to switch
 measuring mode
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com, l.rubusch@gmail.com,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
References: <20241213211909.40896-1-l.rubusch@gmail.com>
 <20241213211909.40896-2-l.rubusch@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241213211909.40896-2-l.rubusch@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 13/12/2024 à 22:19, Lothar Rubusch a écrit :
> Replace the powerup / powerdown functions by a generic function to put
> the sensor in STANDBY, or MEASURE mode. When configuring the FIFO for
> several features of the accelerometer, it is recommended to put
> measuring in STANDBY mode.

...

> +static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
> +{
> +	unsigned int val = 0;

Nitpick: useless init

> +
> +	val = (en) ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;

Nitpick: useless () around en.

> +	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
> +}

...

