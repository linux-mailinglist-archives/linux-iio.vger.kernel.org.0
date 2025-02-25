Return-Path: <linux-iio+bounces-16046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007D5A43AEE
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 11:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5BB188F254
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 10:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59ED263895;
	Tue, 25 Feb 2025 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+659pig"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF4D263C7C;
	Tue, 25 Feb 2025 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478064; cv=none; b=Vmq2hEm1GTDiBUWOepdsZdrK75vi+hLEXIrv4qO1C59EnMk7DlhHz5cidIQbEnDTMoTRCnn1j7ibgh8xqsn/Y6sEb0nDOO6L0FzFxs2W6+uqqoX0urdkyux8M6r13pOq+QWBMDpgvcHxLBvX8/Dx1gciY/xvVBfcWRv8jYZ9V/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478064; c=relaxed/simple;
	bh=YTqMj4ps1llscSuDb/2p+FJjVauDFbLTY2iu1MZb15U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bu0weg1qmANcnOtlBT7uhsFBEEkEmvDCdV6awaJALy8K/owPg4k2wSeHxhCr8O9xlsHEbtoDpjhti8QEvQi0+65jfPkxiNG6t7EZe8v2mzwM9F3HJTc6k3winkeBvCbUEpWXN1y7nqhMTSLuVPP5VgBG0fwx4lZZeiA9ZAYWSU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+659pig; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3098088c630so50618121fa.1;
        Tue, 25 Feb 2025 02:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740478061; x=1741082861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lAEbqPgmBi60dC78J9e9TaRL3Bq8nEEXaJp+eattnt8=;
        b=B+659pigkcKaGAcqZYaxlphQIvHwA+vMv/vgSHMs/OkmA4REnPXOh/HSfGCwrP643e
         yXvAHCFLY53ESkVtj2pS8q5tHUNhEOz0/Xl2SzLuwFMcyoAIO9H9LEYUCBpuKhvq3i1/
         INYfaYxPvXMy0t8Hu1DBvaSdhLGXtkvabSDdUwNo5zZ+ARGdntuPojCOGKkXN1G9Eqga
         hMcgoL8bjzVHzBi6B/4QLRQYcMBynXIQ3oISq1bQcGt47yPxliz9ye3nkgXpAM2Bmudc
         y7jYnJ1lzW9BddfdpppaL1XEsl5TvGUBMIK2aMBOg4botv9ijMd70eL+4qvMp4tqdZDm
         3CaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740478061; x=1741082861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAEbqPgmBi60dC78J9e9TaRL3Bq8nEEXaJp+eattnt8=;
        b=f+8wsbDU4163gXr2Ou33xEQbgCLxie1hBobJz+1QqfG3nVwR7auHL7Zv8xKKFH4odO
         hgGfpwXa2fDiR5BWZpkljPGo7HF9VChwzuv//1M5OxqwYRAzz5Eb3pXSN+TvAvwXrEfu
         MdVKWepbACj2L2zvYgEUr7W8gc8Yy3ndoRXQ3veiHiF/zzu/lBN8OAy5Zi9IfamZuTzW
         wg0cu9xTRhHNmE/eczF2nbLq65AfeLqqtrcxjUCzAkAEJTNliNu9o2BM0awQ33ONUII8
         eCW6Suah4kbpdAFrlrzLHyQI8C7c8Ihm/WOweuHtxmC2Q/7bRQ8FNuvGUyidbj5B3ubG
         kHHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVegutySvs7ZMwAUmjigu53aRJ7a7FWZhlkksoidle9P9V7vZXR3jmFgBjnbZniPlryLoxcvm96hgO8@vger.kernel.org, AJvYcCVsv1nnd2byJUH81vyjiOCU1LoTBLQwStTm03sX09bGujfyBFk/TpSO786U5obYW4tE7pUxVXsgbBcwl4TTRu2/68w=@vger.kernel.org, AJvYcCW0kBesrTh212qJXJjbS8cvO5FKHBZ0EyK2y1WkrBHfks8wYwRb750O/5cN4T3vI8ahLr50CrJng7xsGg==@vger.kernel.org, AJvYcCXiyFqXxycxjuFLnuqRmcVsLNv86qTvQu2RUcWA34VRtVT2/TNQFvZ2BQf3gipazYhdHbICb1Red748@vger.kernel.org, AJvYcCXuEKEvpAMdllMOsm0nKN7cj+ms3MmE3U1XsyU04Ujp05TzDeh8c5C645hShI5Yu1oGEOZgTV/Y/Q0qWpvG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/kD06mV1RCY97r7GdddtKuavgL75kdCDBwJJRVDytgDaISuJS
	lp64fCWtCy3mGhaJliAu+UA/McBX7yBCcaSzAqy70f4OwsHBxgNl
X-Gm-Gg: ASbGncsmbiXNBMIYpEpkn8XEqWHcKLOnVWSoxIyFlzX5JVVjg8Ij+1Z9pFxHRbnLcKb
	BLmK6FY7Xp97bADTWaj7clavF9B/UV1qPzAwdNCaWykwpJLUk5bOutEbzKCFZoev6I2GgqNhVIQ
	YPZ4HX1lV2cIxaDd27YTOv+CIXJCQF0PbhqHpFnqzG8Vul3mkQaY4wBdn3A83aQ5SfrY9jtUE6L
	qxmRRffeJ3/958SBtwJVyive9nVnejGCR3mhvMOS2jcGJ2rrArFrOKdqbeSexSuUlqsrvEJNK58
	pwKdTmZcWcZRgx8E3xnl0PRjKr/Yt86yVtuteTE=
X-Google-Smtp-Source: AGHT+IE9LtSoTYOkptRbtvW+Pr2kFGMFaZQ0FPl+alwBphqqI58uxcxrb6TXfUP19MarHnVygwrw5w==
X-Received: by 2002:a05:6512:b8d:b0:545:2950:5360 with SMTP id 2adb3069b0e04-548510d7323mr856574e87.22.1740478060709;
        Tue, 25 Feb 2025 02:07:40 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514f477esm130333e87.187.2025.02.25.02.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 02:07:38 -0800 (PST)
Message-ID: <c3cc7f2a-ea0c-42a0-940c-95735d008989@gmail.com>
Date: Tue, 25 Feb 2025 12:07:37 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] property: Add
 device_get_child_node_count_named()
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
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
 linux-sunxi@lists.linux.dev
References: <cover.1740421248.git.mazziesaccount@gmail.com>
 <29ec24f1498392cafbecc0e0c0e23e1ce3289565.1740421248.git.mazziesaccount@gmail.com>
 <Z72QAOA9xXbP16K-@kuha.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z72QAOA9xXbP16K-@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/02/2025 11:40, Heikki Krogerus wrote:
> Hi,
> 
>> +/**
>> + * device_get_child_node_count_named - number of child nodes with given name
>> + *
>> + * Scan device's child nodes and find all the nodes with a specific name and
>> + * return the number of found nodes. Potential '@number' -ending for scanned
>> + * names is ignored. Eg,
>> + * device_get_child_node_count(dev, "channel");
>> + * would match all the nodes:
>> + * channel { }, channel@0 {}, channel@0xabba {}...
>> + *
>> + * @dev: Device to count the child nodes for
>> + *
>> + * Return: the number of child nodes with a matching name for a given device.
>> + */
>> +unsigned int device_get_child_node_count_named(const struct device *dev,
>> +					       const char *name)
>> +{
>> +	struct fwnode_handle *child;
>> +	unsigned int count = 0;
>> +
>> +	device_for_each_child_node(dev, child)
>> +		if (fwnode_name_eq(child, "channel"))
> 
> s/"channel"/name/ ?

Thanks Heikki for spotting this brainfart! :)

> 
>> +			count++;
>> +
>> +	return count;
>> +}
>> +EXPORT_SYMBOL_GPL(device_get_child_node_count_named);
> 
> I did not check how many users are you proposing for this, but if
> there's only one, then IMO this should not be a global function yet.

I have no strong opinion on this. It starts with just 1 user (IIO ADC 
channel stuff), but I've a feeling there are other areas which do 
look-up nodes by name. I suppose "channels" are looked-up in other areas 
of IIO as well. Lookups are probably done outside the IIO as well. I 
haven't audited this, but I wouldn't be surprized if at least LEDs (and 
perhaps clks/regulators?) could find this useful too.

> It just feels to special case to me. But let's see what the others
> think.

Yeah :) And thanks for spotting the "channel" -thing :)

Yours,
	-- Matti

