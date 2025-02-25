Return-Path: <linux-iio+bounces-16048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D58A43BD0
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 11:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54B83AA516
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 10:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B73A26738F;
	Tue, 25 Feb 2025 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g28bDnyN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B57266F1B;
	Tue, 25 Feb 2025 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479378; cv=none; b=EMegzz+eEkwhjbrKerHDcEwDQakkr5qxWjG+4kJXWSsb/mBwpGcDRUB6Amvcc1jOp2pKGiEydkN48GQMLmM5cLxJ/n6a94Dc8WubqFHkbiNxqmI4NRDN/D0PWqpMwreivfBiRQJ8EiQOZiUzSdRHgL40OUR8D4fVxadl4xI3VLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479378; c=relaxed/simple;
	bh=czyNMmQ/7Ah76zJ4b6hYIfgvlQOfDiU6dsov2tq48tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9TcGYV0NH41i8sl5EckXHQ1Q+Kqhij9QHMI/NPPqUita0nO9z/PNA4UifdXroFGzPckpMKdFrQJAnRTdOvmodJc/sqszs+imh9YO3JAdLav7jV5uc9qEsixJUkC9wUZ0MP5LANzI3UDVxh10rgJw0H1NUzqxs6qKRQkzkR/P8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g28bDnyN; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54843052bcdso2674036e87.1;
        Tue, 25 Feb 2025 02:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740479375; x=1741084175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9FWLaiabtNirDSi5oyCbdoPFm0NWp7Jf1VqisvjNdfA=;
        b=g28bDnyNbU6jo/+bVbHztpFn2ZKNvNkiTCLWiWBbb6rtPe67DE3jylvz4h+XXPB4sB
         8eIbHRmjrfJuycHKJWmrbYOYDPog7UcjLaIo/Olid9OwrNRnpRftJpRmiZbBf1ruo4/B
         6ykn+E0XNYuWwFX5utU8Jc+bvWpMTm81xBjToHvGNJmuqQcfz1Y+UoesREBEwuLMF4VQ
         qZScmaQDtFOP0zi6Mb+psp4rZ7HkmPxSxmPfKdk9fPAfcJJsFyCPrjcuVIKadgcLV7kS
         q217PU8XfVK87lJEZa9yljRd+q80aSyt7zrRThcevv4EdVyri2U7MoC2FRh/6qgZeLZq
         MThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740479375; x=1741084175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9FWLaiabtNirDSi5oyCbdoPFm0NWp7Jf1VqisvjNdfA=;
        b=hZOFCGlfddk48M+KYn4oFHAa50J/XZvP70ozEJKxg49+QC/ArogNDVv5EgQ0l930eK
         yKsnZkKSXsaRb+RmB+6MSTEeUrl4be7OdSmixpBWHbSUMsJ15zA0OHHTPTGYAEbYdRP5
         Y7ekhj/aHUm+Lf3rRD1na28ntW8QL6RXswUUzEGCgTODLXEfUKRunTXlPHaXVbuPrH3+
         5tfnXeIYatg/2F0LUFYY9Fe9DOIU7i2rdArHYAD59Nf21cFbbDh6NJRheWrwJsdiVkfj
         S3/D7XaVc0Io+34vZ8BW8Ixt0Xif2Qbtm6U1oU22LZYD9haHcPDqIdgj0NXZVEUoxTUu
         eZgg==
X-Forwarded-Encrypted: i=1; AJvYcCU/i18uZBNweNZwJ8Ons4N1HFkVxLObprDQsx9GulG71mEtKCUZkGCr1fxAW28t64cmrq8hAG5gW719@vger.kernel.org, AJvYcCUKLmEYR5LbR8l14WU/VIBZrVHf1WYaGImlNuT4YDiB/+oqcyxvaqkSSzTZ9awW6cNqH0cOeZ0l2ncu@vger.kernel.org, AJvYcCUoZkVReAkYPQnr1QiW76PAoB4dazTyZE714YyxyxIlUZNiD0rqHMWprqgi8K1Pwf74MJ2wTGBCxqyZwQ==@vger.kernel.org, AJvYcCV/Vao4dCpUIgUnqxWt/8wZzitwMOLlJI/c/jUVA9Tujc5FpplA8CL3hG/+ImEoZFmKwOrKG233/4jFvQ6m6uMaidU=@vger.kernel.org, AJvYcCVFMaKQNI8UjaTyU8ej3FOAoK4iFWyXYsKvcMfaMlNc+eGLJS4MCwYTrgkJgsi1gYqqVYuGmGc149/dQWMs@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/RgBFpNKCEJm8W3WnxQJLpu2LuADQwd91XvOWpGur57khK0CH
	AS0np+yljiV2oMwOg43QEtx+Q28FAsaG1Kd6bo7yoDglB80EkMyxTztz2Q==
X-Gm-Gg: ASbGncvsheVNIfNdebokd8opYRYmszCUopDn8nIPZvnf3JTEWZc8a11Yom8ix2WxVKE
	o7g1tVojZo0Vf2IsEy49yfxRSzvlj8+LI6CKpm+OH38dxb1yVUe7cNy7du+G8+YOizi5S1XIA3G
	6uZ0fn7aRiHpQTferEW2EBB9y56Sjm305SLm6MzeJegFge5i8l+42dIKi6Hm5eJ/WggShgOtRHq
	R6WoLCmoBvSR+iU4So3ZBGYe1AOI7g8Rv0/NvfnObI/rUJqn4ITY3mELI9kQHajGI1ueg10uHgx
	LtFpBGohFRYWa5u8iwT6v5p5/Yw7IdsEJP8+E3g=
X-Google-Smtp-Source: AGHT+IEOX4SAkVcbCaNkIS5Eiz9jLOGMD6nDNsNIgWnc9c9zZ4J1lGJhqX/FRtQ2oyAHuj6SZ749OA==
X-Received: by 2002:a05:6512:128b:b0:545:ee3:f3be with SMTP id 2adb3069b0e04-548510ce69dmr991958e87.10.1740479374858;
        Tue, 25 Feb 2025 02:29:34 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514f742fsm133919e87.205.2025.02.25.02.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 02:29:33 -0800 (PST)
Message-ID: <ad39b453-7e5b-49bd-a4fd-6a4988636130@gmail.com>
Date: Tue, 25 Feb 2025 12:29:31 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] property: Add
 device_get_child_node_count_named()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Daniel Scally <djrscally@gmail.com>,
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
 <Z72QAOA9xXbP16K-@kuha.fi.intel.com> <Z72Zp8tpnvlFGdQ_@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z72Zp8tpnvlFGdQ_@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/02/2025 12:21, Andy Shevchenko wrote:
> On Tue, Feb 25, 2025 at 11:40:16AM +0200, Heikki Krogerus wrote:
>>> +/**
>>> + * device_get_child_node_count_named - number of child nodes with given name
>>> + *
>>> + * Scan device's child nodes and find all the nodes with a specific name and
>>> + * return the number of found nodes. Potential '@number' -ending for scanned
>>> + * names is ignored. Eg,
>>> + * device_get_child_node_count(dev, "channel");
>>> + * would match all the nodes:
>>> + * channel { }, channel@0 {}, channel@0xabba {}...
>>> + *
>>> + * @dev: Device to count the child nodes for
> 
> This has an inconsistent kernel doc structure in comparison to the rest in this
> file.
> 
>>> + * Return: the number of child nodes with a matching name for a given device.
>>> + */
>>> +unsigned int device_get_child_node_count_named(const struct device *dev,
>>> +					       const char *name)
>>> +{
>>> +	struct fwnode_handle *child;
>>> +	unsigned int count = 0;
>>> +
>>> +	device_for_each_child_node(dev, child)
>>> +		if (fwnode_name_eq(child, "channel"))
>>
>> s/"channel"/name/ ?
>>
>>> +			count++;
>>> +
>>> +	return count;
>>> +}
>>> +EXPORT_SYMBOL_GPL(device_get_child_node_count_named);
>>
>> I did not check how many users are you proposing for this, but if
>> there's only one, then IMO this should not be a global function yet.
>> It just feels to special case to me. But let's see what the others
>> think.
> 
> The problem is that if somebody hides it, we might potentially see
> a duplication in the future. So I _slightly_ prefer to publish and
> then drop that after a few cycles if no users appear.

After taking a very quick grep I spotted one other existing place where 
we might be able to do direct conversion to use this function.

drivers/net/ethernet/freescale/gianfar.c

That'd be 2 users.

While I looked at it, it seems that a 
'device_for_each_named_child_node()' -construct would have a few users.

Yours,
	-- Matti

