Return-Path: <linux-iio+bounces-22032-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86993B12CEF
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 00:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A591C20DFA
	for <lists+linux-iio@lfdr.de>; Sat, 26 Jul 2025 22:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8314C28727E;
	Sat, 26 Jul 2025 22:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="HeMyujIy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AD6246781;
	Sat, 26 Jul 2025 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753567993; cv=none; b=ZrYO8Sm5HGLE0mZwrRTxUJtS691GBoWIeAHivlzHTH3p3Mc5YMz5TT47bOs3AyUAHns6EAjs4Pbcr9mytpJt2H4G3izFEmWC+RZh5/EcBzETfaXY/67C0V5lczCDuxPo55/CJZdW81V+zpyGYU1NfXbtJ7SBncrX17hIdUnVJ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753567993; c=relaxed/simple;
	bh=fHf8RDEc2Z5+hJMnjg/XLLN6eE6tNIoWmvz+X7SYzpM=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=B9kZmhXbFjm333ZYxQrTZlY4ElQpagxi/5uM4Xo34ilbqVMSjNnjZIefnLE2VDXVjfafhluSD5U4N9g80eOK5xbpgT6W73da1Qjmk56ViwpjSC0hrFFNinFT08qIevNmJHVJRcJqdVxSaar7xiFlt/nkVXII0ICk9wO8I0bpDuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=HeMyujIy; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id fmznuEsvCFkrkfmznuZVeq; Sun, 27 Jul 2025 00:04:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753567440;
	bh=0/4AUjFZluFTi1IBUmeceD+DKVSmrjOL/Y0uIEFcQBM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=HeMyujIysG/oDbFOpEZeCM1L2J39XXylDL9I1oLvJ38R4Lif/mYGZj5I6B4dmyb83
	 +kEBJ26KFlbfREhuAozUCBFqHqcdR66Dnad6SrN+D4lvVmEi8Ih+LG3SaUCaJg/Qfk
	 PKry4NSGn1bHbeFf9JVIYmCH/kmjgJFOKQNQHB30PqIjZTmqeqIle0wArNioaeMxu1
	 kaI8BW/n/1DOSKS4aSKeFW7D3KYmFSeIm+uQchemAVRSMbE2JcG6ib3QddkTbY4lN6
	 ryH8/qcZP2nH9kXm+tIjiNYzOH6Iwwl/3kCse+7IR94isLqjNgcunlUDk9ebsypmEh
	 N52V/aywHpiAA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 27 Jul 2025 00:04:00 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <cc69ced8-7a20-49a5-a550-64050cf04e7f@wanadoo.fr>
Date: Sun, 27 Jul 2025 00:03:59 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magentic sensor
References: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
 <20250726-tlv493d-sensor-v6_16-rc5-v1-1-deac027e6f32@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: dixitparmar19@gmail.com
Cc: andy@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dlechner@baylibre.com, jic23@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 robh@kernel.org
In-Reply-To: <20250726-tlv493d-sensor-v6_16-rc5-v1-1-deac027e6f32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 26/07/2025 à 11:37, Dixit Parmar a écrit :
> The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
> applications includes joysticks, control elements (white goods,
> multifunction knops), or electric meters (anti tampering) and any
> other application that requires accurate angular measurements at
> low power consumptions.

Hi,

> +	ret = read_poll_timeout(regmap_bulk_read, err, err ||
> +			FIELD_GET(TLV493D_VAL_CHANNEL, buff[TLV493D_RD_REG_TEMP]) == 0,
> +			mode->sleep_us, (3 * mode->sleep_us), false, data->map, TLV493D_RD_REG_BX,
> +			buff, ARRAY_SIZE(buff));
> +	if (ret) {
> +		dev_err(data->dev, "read poll timeout, error:%d", ret);

Nitpick: missing trailing \n

> +		goto out;
> +	}
> +	if (err) {
> +		dev_err(data->dev, "read data failed, error:%d\n", ret);
> +		ret = err;
> +		goto out;
> +	}

...

> +	ret = tlv493d_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialized\n");

Nitpick: to initialize (without a d)

> +
> +	indio_dev->info = &tlv493d_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;

...

CJ

