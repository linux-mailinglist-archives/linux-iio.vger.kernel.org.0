Return-Path: <linux-iio+bounces-5019-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BE68C4764
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 21:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0B11F22B0D
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 19:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AA045016;
	Mon, 13 May 2024 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="NYdS4kIK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DE041C69;
	Mon, 13 May 2024 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715627599; cv=none; b=oRMaN4ZdhUCJX2NCZTGo1Tn9g6unencB1W7QF2repV1iT01LOzWRHtc1ExLS8yPL1ofta9R8shqGWvL3Rsv7Tq7d7wBfrdqQr91QQb6Epcn6cGsad4Ti7Qa+t+L/TwySuer7gjWTgbfSn/obsEsF0qmT/VpDbTUF5Blo8WzWRyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715627599; c=relaxed/simple;
	bh=uIbsp2QLTS/4UFJ/Ts1tt/H6fK2vbIIglImZI9ojMlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XC9MoP/AGIhcJBqftIkH0k5PghcSjTp6/kwfK+DGTJpC5+9ZL8q19O2MgLC8iVxVgzqezMcl3teSYJU6ZGEwf5MOMLhQBs3LzFo6mPfjcqhYl++VtS2xAzRluChmSj/TNR14Ii4X7SCGk8BeXgp94AbWXIKVkDiz28GoIvTBghE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=NYdS4kIK; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 6b6hsPIMRk6QC6b6hs06Ki; Mon, 13 May 2024 21:13:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1715627588;
	bh=eT5RrKZ8UjQZeT6lOaFG+0LG59v6V5t6BhYb55z7aGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=NYdS4kIK8NGPpW3SflYBxPTJTBHh/O+9NabllL0ZyfBnYVfEIxoRT76dUU3OYgePz
	 6NXS+ulFy+StqykUpgt239nPYI2qKGk7Akc2RcsTEbREAhenYYD8MCNHnMgPCgFyVw
	 aLtBDGaPUI3kD3dfRSshQOQGKnx6iY4M6+2JICmVUYNtNdmu/fiTCXZTWmgbsCj7o8
	 /nXcDpD9Vy+D7wAU2+n5pJWae/NtHhu1pcvfi+L074vni/hoL+NaEy9ssRua+y8578
	 vUef1Qjwkvtv7UDj1R6NAl2+VDsvI4sgYDa/yAFDmybXoH9RlIH0t2hAM9776dNmN9
	 CLd76J+wiXTBA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 13 May 2024 21:13:08 +0200
X-ME-IP: 86.243.17.157
Message-ID: <b8775460-5519-4294-9218-d8e814e05305@wanadoo.fr>
Date: Mon, 13 May 2024 21:13:07 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] iio: chemical: ens160: add triggered buffer support
To: Gustavo Silva <gustavograzs@gmail.com>, jic23@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, gerald.loacker@wolfvision.net, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240512210444.30824-1-gustavograzs@gmail.com>
 <20240512210444.30824-5-gustavograzs@gmail.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240512210444.30824-5-gustavograzs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 12/05/2024 à 23:04, Gustavo Silva a écrit :
> ENS160 supports a data ready interrupt. Use it in combination with
> triggered buffer for continuous data readings.
> 
> Signed-off-by: Gustavo Silva <gustavograzs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---

...

> +static irqreturn_t ens160_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ens160_data *data = iio_priv(indio_dev);
> +	__le16 val;
> +	int ret, i, j = 0;
> +
> +	mutex_lock(&data->mutex);
> +
> +	for_each_set_bit(i, indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {
> +		ret = regmap_bulk_read(data->regmap,
> +				       ENS160_REG_DATA_TVOC + 2 * i, &val, 2U);
> +		if (ret)
> +			goto err;
> +
> +		data->scan.chans[j++] = val;

Is it safe? How can we know if it has been only *partly* updated? Does 
it matter to know?

CJ

> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> +					   pf->timestamp);
> +err:
> +	mutex_unlock(&data->mutex);
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}

...

