Return-Path: <linux-iio+bounces-16243-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B99A4B1B0
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 14:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCB33B263C
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 13:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4981E3DD0;
	Sun,  2 Mar 2025 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6775vvM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56AF1BD00C;
	Sun,  2 Mar 2025 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740920428; cv=none; b=se2lqOpg6NnA1mR1L49dRwS70scXWbTuCiP7gd5C63/XHyaUQIkB799JC8BUusa1QN8hWu3h/jastsEFpCVbcvcuAXM0nUtj8mc4t4WtRoCEe42YGS60K9Njy7yhj0XfTdf+5g3rRgILhZ2D2s5ABVQD08eUn06boPUjNZNoVVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740920428; c=relaxed/simple;
	bh=F2oW1i7xFQ5yaNfg8aSg4BfxUAemyDWnFE4Dx9ylQcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4YzJxItOvb6YPpWZLw05FfFVcDfgjzzuYkMBSRruF23RpiFlTJkIFXUUkFiOQEJVRt7OmktVprr1T4785BSy9oxpMb2SEVPPvMFMo/TFXuvC9xi6zGhNLPH9JZqA/UdY6+PAwpe7pE3gYL5P2sh2Grm68qtmbeCmt9c+Elx2+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6775vvM; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-307325f2436so37568901fa.0;
        Sun, 02 Mar 2025 05:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740920425; x=1741525225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XfGXlQMIJZXRSzz9b3y/679wpg6DJoBY9Odmd3DiDb8=;
        b=j6775vvMdKNv0C2lE4kMEGORMN7l3EjJ4xRahIy1G2H4zPngBxYIrq2A6+8uuK3A/J
         V6czhtZq1suZvKwyp5G1pBQS5fpoD9Yn0dy0imXtwznrTuEcoeIeI5PXPb4Ty65nIGLo
         BtNOAC4wodPrnoh3WreLUbxTOs6G/pYiWX0HXcsbwDh61Nk6inEL960oG1FT2zQWanvI
         NQLgzpqy6ko0DTynIY62bJFg2OXZ1gt9JWs5hELAKRAZ8QOa2pqDnz0qqx6XQMJ/CHW2
         0m+zmpzrgyg1PidijTfFwXAW87OsV32i1AVzJjOZFyCnNottaxwRcRrFGZ/8Aa00LheB
         6wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740920425; x=1741525225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XfGXlQMIJZXRSzz9b3y/679wpg6DJoBY9Odmd3DiDb8=;
        b=gD1WdXvB09304uS39UCjMSN8Ax+QI7tJV2UVMD96Wxp/Heavr9U+RXToBx4hBNOurw
         SUVSDOxK1xrXQlml2SmBFPoD87tbisJFn8l4HPweGCKA/CkVu8yBo1VdPGpme6KF9pbB
         Q+9Hcq9WgsYKk5swOob25oSKnrjiAfI6uW3f/b8mqDDGbpKuRIQRMXgFw62jEBn66U9y
         wH79iSulhvmeg5gm45bt/4VJN8APSRQcSdS2brWan6ZNg9KTTL/OVY8mMzIgXT735lZv
         RqESDJUppl4MHxhjn2G+zI4VWWEMFfmu6Bf5Q6blgSnI9fR3cHjNCSn4y+NcPy6JzDok
         sYLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7rISCkbvhMA6Dbn/NfPpdDgy5Ci26dlFHF99XTKprtZ/DMbOZzujMwvTu/m10Oi0c8bVHlJnoo9H/@vger.kernel.org, AJvYcCUSGbrQT10A+46cNZIKB4HU8aZ6bwgdZZTUXm2/TBArvBxdTxs2HviyMv1XWpz5MQQ5vLRAoXHQTqkhGw==@vger.kernel.org, AJvYcCVRETr/YXS36A0Wp5dOmF3nEU18jsVx95Ex6fs/Azmuzdt8vSR/TEEQJgqnQQe9d/yO2s/6lVjJ6fYm5jnW@vger.kernel.org, AJvYcCVxuB0ojyt9EYwlGKtoPlJjM32LhCQGPglD1TIE9pNEAvQ7mJbJn0aEfOnNSlASJhs8Ztr2tDJdTH5ltmhrA5B9yB4=@vger.kernel.org, AJvYcCWCpxEjQ7+8ziWulx/Lt4M/pzZ6wcjYERiJ6Pj1xm1d5/MAxzbIJO4LI114iprwXLxO1UUMPSmCOQjc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvw/O/fCAEoYR5WXKAZKvTsLNe8jNVmBujEtc3e0lz+0hgrr7Z
	hA1KXnZYhmYBOCEMF2VmCy4I+5fi+cwKAhO0n4xoUeSYZQNNMt7w
X-Gm-Gg: ASbGnctU9rT1Q4VRsDOnongtUPSK2t13yKwxWN62FffdtMQFoG7Jgy9vxZN1KSo7kCW
	TbNvfvn5blpTE0tbQAxyNe5FoqSZ210EjzmRePesOeuwbLFEXxZNa/qNe/lGLL1ldG3xvGlaKym
	FzWnGQNt2364GpLVkTI8CtbM7E3s4iHuvfEG5mup2oaPT/+VhLECY10z8iBHMprrjn5lJUJSrP1
	9hJQGN7Z3l3la3p2zJTXphl7XGfg3aHoVml6lNqNEp6JAuERwIIMfFQlX9S/xnkQwdP5WDzZViB
	kNScUBs7FelsWJ+61AhJM8cNtbtc01OQykb/Z0fn9Fa1baI4dalDQ1Q3+LjT2KBGv9YfwAI23yN
	XJgcHCiZjikLsxZV5oo5rZ2OD+g==
X-Google-Smtp-Source: AGHT+IEJBMocHt2Jgr18dEspZ7moKiOE2FRAdMPLkXLThDcOzKqgxp1X7Z/SUDkFQeJFZlY+0pzPtA==
X-Received: by 2002:a2e:be15:0:b0:300:26bc:4311 with SMTP id 38308e7fff4ca-30b9326afc7mr48040971fa.18.1740920424456;
        Sun, 02 Mar 2025 05:00:24 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30ba19df7a0sm5519091fa.34.2025.03.02.05.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 05:00:23 -0800 (PST)
Message-ID: <f8f7154b-460a-4ca5-b31b-746bd23a3d61@gmail.com>
Date: Sun, 2 Mar 2025 15:00:21 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] iio: adc: add helpers for parsing ADC nodes
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
 linux-sunxi@lists.linux.dev
References: <cover.1740421248.git.mazziesaccount@gmail.com>
 <23f5ee3e3bf7179930d66c720d5c4c33cdbe8366.1740421248.git.mazziesaccount@gmail.com>
 <20250302033507.7c166743@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250302033507.7c166743@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/03/2025 05:35, Jonathan Cameron wrote:
> On Mon, 24 Feb 2025 20:33:16 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> There are ADC ICs which may have some of the AIN pins usable for other
>> functions. These ICs may have some of the AIN pins wired so that they
>> should not be used for ADC.
>>
>> (Preferred?) way for marking pins which can be used as ADC inputs is to
>> add corresponding channels@N nodes in the device tree as described in
>> the ADC binding yaml.
> I think it's worth exploring if we can tweak this slightly to make
> that something a driver specifies.  Either skip the unspecified or
> fill them with default values depending on a parameter.
> 
> Would make this code cover the existing cases better.
> Might be a little fiddly as we'd want to maintain ordering so
> the code would need to index slightly differently. I've not tried it
> so maybe not worth it for now.

Thanks for the review!

I don't remember seeing users which would have benefited from this (but 
maybe I just quickly discarded them as unsuitable for this API and 
forgot them). Anyways, I think it might be cleaner (from the caller's 
perspective) to have own function for supporting such cases.


>> +
>> +int iio_adc_device_num_channels(struct device *dev)
>> +{
>> +	return device_get_child_node_count_named(dev, "channel");
>> +}
>> +EXPORT_SYMBOL_GPL(iio_adc_device_num_channels);
> 
> Maybe one to promote to a static inline in the header and avoid need for
> the export given it is very simple.

Makes sense, thanks.

...

>> +
>> +		if (max_chan_id != -1)
>> +			if (ch > max_chan_id)
>> +				return -ERANGE;
> 
> Might as well combine.
> 		if (max_chan_id != -1 && ch > max_chan_id)
> 			return -ERANGE;

Ack.

Yours,
	-- Matti


