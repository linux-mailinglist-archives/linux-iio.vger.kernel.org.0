Return-Path: <linux-iio+bounces-6596-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FCC90F4F6
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 19:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61D61B22526
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 17:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1374914EC56;
	Wed, 19 Jun 2024 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Dor1pG4Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE8152166
	for <linux-iio@vger.kernel.org>; Wed, 19 Jun 2024 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718817873; cv=none; b=k52FJla0wmL1QCA/edzmVErAvrTh7zeda04dGebZCSfgyocHyWc3GUoFBbCULQ43R+ZIkieFGAC+PiAMQHrVxRsgr4B2SIR9O8AdwgOLEOpEbXrfDJSTWPg82XtcVlTpA0nGMWMntP+w+5xhy7k5TaCkA7ZEWXOq2q2pjE56wyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718817873; c=relaxed/simple;
	bh=pHGHrMlLeKjI1/up7Rrmj+CZx30fzhzHLvJvS34Vm1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZoDbXnD+Fj4uKpiwyim1zU/3gusve84Dz08jtQ3HpEdpV0mYFIwaUQFwOQuzMRVGFZXZUExdJX8+a7TjkyEELfsfUdZvUiBFJY/ZdDzByEWXk984RGLmUgup/uqJTag8CWOa6kGlsSsoLc+c5Zv3JzetsxhbhWWGtxw0I4SCG9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Dor1pG4Q; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b9706c84e5so1181eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 19 Jun 2024 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718817870; x=1719422670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WW/sGpONNf0gL3cR4b4skPpNC8NQNbXJ/sZFcTqP6DY=;
        b=Dor1pG4Qu+/1feuIJb5xH9E1dRiL/pF4P/tuzZCw02844zQYFW4t6pejHri09PnSsg
         ZYh6A4QbVIO9g16Dt4sVW3/owtrYOfO8G9q0gaKu3Q0hcuFATbB+mL/k/bhbU+0xhKWk
         gYpkAhSQ5dJfyhQgHPtmFafJkfXDOVqXGS1GOnY/n/5EQjW7PYxnGZ9AqZJs1R7XRcx2
         PM+1Ja2iZ5eE0HrUe+8K3T6/qCMggorIBLkI6wrsbuBfpzKjq0MxLd65PULuFYa2UDVm
         vrpqYZKVg21F38RWVaJjqqmU7xWJxbahWaFamP6Q6XtJoScqsoV2i8dnwZ75SgrYupD/
         gdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718817870; x=1719422670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WW/sGpONNf0gL3cR4b4skPpNC8NQNbXJ/sZFcTqP6DY=;
        b=YROTRqJ+0w0AtylIat6oIpn5vwdpqD0Yc5z2l4ylW0CZyYfyqY1U6eKLZXduq6DoHm
         A9SHtXzYV+lobSFg8bnjbZGfHvx7Ghi3esRPdUI77bOItnZ1dwoUoAHl7MMSz4qSrNEG
         9TkpsfKosiDncprBlhuKM2g0SKDMtIiGfXYO+jqvjZ+xHaAd1so/0xBKH92mUvqcCXVs
         XTb/A2Too5cwFLvDMEBJxnqTZ1TB4biSdj8nRXMYrFsXXeHq1IPnMLbblg6ZaSWVLQmB
         BZ1tMUHXXyQPjzr4ucTpDzFNe7wkw0WqsWlx0rPbdKdMe7FhT6D3EK+P8umSna1ybMqb
         C/Vg==
X-Gm-Message-State: AOJu0YzSIDDgKD6PIdS9zRvW+f5MnWHM49t+8lRbroDporF4ty8Cp0Ks
	m2QZS4+q8wvvQn9CrRZ/ar9yIELGcYy+se+56IcfzPxwnA04jS0XPHMHNdCSb5g=
X-Google-Smtp-Source: AGHT+IHR54HXcr7/yjcrsiJmtUghksi74ROiI+fCbYFFhArdAwoof+CXH2w8urjUZ7OSSXvEzQS16w==
X-Received: by 2002:a05:6870:1716:b0:258:44b7:b842 with SMTP id 586e51a60fabf-25c94991633mr3524648fac.13.1718817870065;
        Wed, 19 Jun 2024 10:24:30 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a94e375sm3804185fac.4.2024.06.19.10.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 10:24:29 -0700 (PDT)
Message-ID: <e3c12062-9bb3-40fd-8b55-5cecbd2fda4b@baylibre.com>
Date: Wed, 19 Jun 2024 12:24:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] spi: Enable controllers to extend the SPI protocol
 with MOSI idle configuration
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
 <36eefb860f660e2cadb13b00aca04b5a65498993.1718749981.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <36eefb860f660e2cadb13b00aca04b5a65498993.1718749981.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/24 6:10 PM, Marcelo Schmitt wrote:

...

> @@ -3928,7 +3934,8 @@ int spi_setup(struct spi_device *spi)
>  	 * so it is ignored here.
>  	 */
>  	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD |
> -				 SPI_NO_TX | SPI_NO_RX);
> +				 SPI_NO_TX | SPI_NO_RX | SPI_MOSI_IDLE_LOW |
> +				 SPI_MOSI_IDLE_HIGH);

This looks wrong to me. Adding flags here causes them to be ignored
rather than to be checked.

I also did a runtime check with a random driver and a SPI controller
that does not have the flag.

	spi->mode |= SPI_MOSI_IDLE_LOW;
	ret = spi_setup(spi);
	if (ret)
		return ret;

It incorrectly passes when used with this change but correctly fails
without this change.

>  	ugly_bits = bad_bits &
>  		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
>  		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL);


