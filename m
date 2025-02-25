Return-Path: <linux-iio+bounces-16051-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7800AA43C62
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 11:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62215172D32
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 10:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40B9267B0D;
	Tue, 25 Feb 2025 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmtOnomg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99751267AF1;
	Tue, 25 Feb 2025 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481022; cv=none; b=S6owzvO4wiDgiilFnnmAid+l1V2AfXzOGHaw5c9UhSdO1mdce0s0TaD4S+mxjGx3id0YrkdjrosW7ELWN60me0j/7bWNkun2/OAnVQfIrZz08vlPey+lY8GaQ/gtXjGgWEN2aSxsSkr6bH0CoQiAhPhRp4sfzJSuvdZoo9+tVZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481022; c=relaxed/simple;
	bh=2YozzQHz8w8HrGbTyvr5eXnrPoFj0GWuc89p5e2auWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWWoTzG11xsTGGIfnaGFRn2aA8J/ayBgLNOWtiAHKmQz01stiVbFYyu3MD2J4mXArzc1l1TxemhLaS+N5KGyxG51xbVGukupvSisDDmT79510p3FAGqAiohTrCw4vaiWFAElhajudNX9m+0aAXuQri0201e4FH9bxg4AqJ257eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmtOnomg; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30a2cdb2b98so54619451fa.0;
        Tue, 25 Feb 2025 02:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740481019; x=1741085819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7/fHdL9OxTBfJ/OtLlF+A8QVXV0YakMI11nkG7r9zEY=;
        b=AmtOnomgimrsh+JSqPKhw5JK9ZUgi4WKi4e7lshvrOVz4CDy/LR8MZiZuN12MvGeYt
         kHEs1CQepDJDivhRX+EpzlH4guuRxck3iH0tZyizsmv+5TfYkIOO39iDF79VVyvvpx70
         mCs4NrVXlis604mjsef+5grqX8+DviTDjHwBQWRdyweOZ/djRtvWoIhCUOsDwTjaLGJ+
         ptCmfKczWq6JBxyLObjSn8j8GdBOzLxhxiOIK5RpJ1hflcQJ1cPE49PYkmT6iZnrTWJ9
         nJjcO6QnTsg3K9lUt71piJGZIB+vfxDZzwAcpYe/QHhaBT0UgZ6k8huxLTDZqJiHSCTk
         zSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481019; x=1741085819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/fHdL9OxTBfJ/OtLlF+A8QVXV0YakMI11nkG7r9zEY=;
        b=NRiIf3ZKr1r6CmFnrs+zSP+RddIrY+DkvzA25lcGrRNQaaApPklEV30kN+/40m1//q
         Ng3Wloz10jqHdIREMI5yKXy5gU2vzMo4E9ZmGWSBDEGI4n4wYePT+nJe+DhoCQxbpcri
         nfTmr/qL86Kay3OpFSJxGqw6q0BFkFG+Ug6Z4w34wD6N418qfebU0WJeFBwLGssyqfIi
         dvQPcRkj1PCuushD3JhQtwHUlFP4uq/HXFJee/4apKXW+PdldcUUJu5Vg4KkT5X0V8h7
         lPTFtBxfnpDARzhcTwgd1jxMXmNMx6NlGeeclbqJHBzHjqOelGsP2KJ2lWZXFh9DVhaR
         uxJw==
X-Forwarded-Encrypted: i=1; AJvYcCWNiXnu3j9rfCF29jgZpKv4ivIHsfoqAUwVWRejOEnmSvT9Sb0p2/WiDoU6l8v7HhgclJbhaed3hw+j@vger.kernel.org, AJvYcCWYZK6cMig4vBOfob6YTpBkoUTR+qEgynzg1shPul2h4v3fh3dYZBHLsYR2idnnNxpfnpHU76wMfFQabT4d@vger.kernel.org, AJvYcCWiUmxNQEHehTW6LR6iT8keSANbpBQPHHJfOjKmaG0k2QN9Ffen5Z7Fpb1O00VnF3ArPgA67qG+ZG6n7Q==@vger.kernel.org, AJvYcCXpaRy3sDLMnJ589OHQy+9XTo52mjYN+QKxoEAlUrBPrRLeXiznbPq0qE1vt8t0bgULvLsSp2PQq3z3l+ccQm/+uXk=@vger.kernel.org, AJvYcCXxbuy1/K7kiDZQOtGEP+oXDkeLh/q5uenQ8VpEbAhojI0YBMRY+DDw9gfiIggftkyl+3WpIAjfKFZG@vger.kernel.org
X-Gm-Message-State: AOJu0YwEy0zFQn6+SxLT8BbqPgPxSWMKyV7qM5ttZWpA8J6ax+Gb3+eS
	dnSCM4MrL5QRqVOUjHpum7eCQ6yIDjmDOPaVdg+50bt1tUlaKvan
X-Gm-Gg: ASbGnctCbTNCdH/iMEx2QNAwaR3hmJaySAXhVlVCsNWvAYkRSC93fpMIgNkl7ZCBqyF
	spLlBv7rUoeCNSq22/FTkwy6+bk9oRNlNLh+IsK3wEgBCe1zPjVTAGhaz/klEEfkfZ9iQQhq0AT
	7H74eiAqbdGFJxuO/mWOnxHDrlS77MF20kooMCwBqbw0nJdVw2n2YXpg3EVCNDfUscJXqTb4/GM
	+mYY1xJfIh9zMFusa37TxkwL4MO3YiJELjKYfg5TIgOjpxed0+TezzoHwJ8mRgIK5B76VkAg4Uq
	aEAgr+Q6dy1xdGSlWjAF5y/XfQCs5k4VxMitlT0=
X-Google-Smtp-Source: AGHT+IH2/CKNaTosFs8GlS0XdmUzabLuIWWzOTmpp5OU7F/me7OdOFzkGeicuNnt7xucX157I9qrZQ==
X-Received: by 2002:a05:651c:22e:b0:308:f75f:457 with SMTP id 38308e7fff4ca-30a5b18ae70mr54123081fa.12.1740481018475;
        Tue, 25 Feb 2025 02:56:58 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a81ae80besm1961621fa.93.2025.02.25.02.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 02:56:57 -0800 (PST)
Message-ID: <1e0a9915-fe52-4569-9da0-b0761ba8fedb@gmail.com>
Date: Tue, 25 Feb 2025 12:56:56 +0200
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

Hmm. I'll take a look at the differences for v5.

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
> 
> Also this misses the test cases.

I'll also take a look at the tests, but I have a bit of an attitude 
problem what comes to unit testing. Adding tests for the sake of having 
tests just hinders the development. It makes improving functions less 
appealing (as tests need to be changed as well) and adds bunch of 
inertia & maintenance cost. Sure, on complex functions having tests 
increases the confidence that changes work - but I don't see much value 
here.

Do we have tests for all the property.h functions?

Yours,
	-- Matti

