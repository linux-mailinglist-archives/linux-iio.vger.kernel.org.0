Return-Path: <linux-iio+bounces-16244-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21B4A4B1B6
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 14:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE7516C300
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 13:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EA31E4929;
	Sun,  2 Mar 2025 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9lG+8nA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459871BD00C;
	Sun,  2 Mar 2025 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740920517; cv=none; b=rSU5oy05exMKYlJV2A3Oa31eUeX71k41KqcVwYCYgokLqLDr4AUdG9Bmya6anRreNVkOoOW7Om46da1xqDCyRglQPwsjeU0KXk6+UGsAlrQ4yYb2V2PE5U+1OM0zxt8sB4rdvdHwop2qN9abrSDzvF02MNIphNps6SOCHZCtUO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740920517; c=relaxed/simple;
	bh=VuF9nBfwzbT9nOVFfJnCaaKblH68O1S1/g9fD+tpvp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHhv1WEnqRpcQgdifh2UHf7TJA3C4aGKJbbuVRRIx/zq9U68vGvCCaG7+wYbK1jWwRL2skNIvZKLw6DIXBj7KbJjbyTvM6PvB0iHVcWPvAK/o48lZL/FivKDK/U7VEtSXzb58EeCrRAsYB6y5WQKdXrXi2NFqb0TJmMhIXGHJZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9lG+8nA; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5452efeb87aso3803236e87.3;
        Sun, 02 Mar 2025 05:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740920514; x=1741525314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKMpELokI1Izo5JKWkdqhyiLCCqSlpg1TEXyzHNbP8w=;
        b=B9lG+8nAESVMyrRuv7vKyqNoUR7oZZ9BR+2zqc/mpCNzIgxSy2pG3fLgJn9ievJ8ac
         KzOPTTyP6+xakflDxbvjXIzwyAGOTl5Yjh5UfLIzwXhniydh2OF/sBVTKshbgEfiXbvu
         y5kF+071/+YQ4OSH+3F6A5jLGy/2EajZOcabZ6SmFUf/9Cfe97GD7WdSdS7qnmEj69ZC
         P4xhKfX3aaQkDJqTlIb1ezbakXhZehilyN0uDDbvq4Jjl+QvYYIxp+4S+9Ov7nPqWfPI
         O5N+c29c0iEtRmpoIwjAmBuULC4ZaHJwX1xc+8ZGJ/P8UkwnnClwb3UJl+fX1A+Xwvwl
         f9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740920514; x=1741525314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKMpELokI1Izo5JKWkdqhyiLCCqSlpg1TEXyzHNbP8w=;
        b=tHq5jxLceL49TCIt5wUDLWDb3Uq5FIWNI5dPRsQKEbmsl4gTaqAJBRClOnNFul8r3D
         Uott85lbkoSMkPiyvCH28zbIKRyySkXqRhz//Bx/CFhyU/kIJRybeE9fCCAIQGNhx94F
         a5oDWhY+JwU6MYzkeuPKZxomwbjfjWHkqMMi2Lgs+uxm1nNfpmDKFLxswQ9cWmS8glDD
         6bOQX0ZVB03/gkErKPAsHBMDJjTwWJyii5sVn9N0bFM4DDGBYnpJcIT+nuWpzjrEHKsP
         lT4x6aw1c0Qy20yKRhma92K42azhpwNnQSADOAemEMNLUaMYPbAYlV/SzQf6RDaAhHQx
         PqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFS7Cl2yS7pHqhcJ0l8MC7io4SZiIPLsWdQxaMTjnQ0tT4326HiRu/OYmv4a2jKg289/VzTJyZWsxk@vger.kernel.org, AJvYcCUieIesL7MwEf95PWgnAusxsPaw8M7klLhtIbYJd9nSiILg9gV4+yPw6gbUBmniIAXj/yQJqlvndZg2LJ8a@vger.kernel.org, AJvYcCVCoUR7SFwROh77xdRkdZIn4xZqSkZ7qry/cxq8/2By2OvlabJrRcaL7mZONXCzg4UR/8eaei1mDf8vtg==@vger.kernel.org, AJvYcCVQbz90+q0mbWxPRBbQC/DKNgqURjO8mjkvkcU7RTocVodOdoNDwyb6j1+OHMJf2xLTOFelzxu9+kDh@vger.kernel.org, AJvYcCXqSfJ2tTuVACOZ3fifbwwEmX0YsjVE50e3RrUh/3jVKZSefjwSoEjISfZWfp14xn5EVW+i0ertt+4G35aih3YRd6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YybJSJDkY2ZEXN622t1wk6CfzWlZClCqdthakgWNy8KaWLgkr8i
	M9fsqTRJVEpeysVOCLiDcLwSTy9UY53vG/JpA9Vm5ZU83rNmyLJT
X-Gm-Gg: ASbGnct3BZdbDKxJbPpO5Mo9CbADgx9Quu9beVixVxG7+0AP9mk8GvN2xRKvzRDZpuj
	aethbT1NXX7KfDxVTdBMMD2Gmbo25KnL7Ggo56Uw6c4lsvcVINYvTVdtjnNT3YirdAt+nLZm66y
	y9tli2UuJISitUe1KfhMkAfsVtxIypGy07a+rlWmijEPjFIj0nKBp/9RE12eqfXqOEekPDGHRe/
	Wxmos7iGMm9IUPAUdTy0fmm0ZD5l+4/IHVolMk8vH4CsaR+zsZF6WHBJq53W43LfbuIdK6Fx/3E
	L9SXCH69aan8fCDai2VQUDaE4TSz3qpauzKCcX22VwrCwFignkh0Ki1AwMJWggE9RfsrGo0cHJJ
	RhkK9jTgTWVC6i5Ow60KnAwoRwQ==
X-Google-Smtp-Source: AGHT+IFLfMqcH2cw9dr7pix/TGEb+jliFWHuNuFd3kEBSDMMDq3K44UkAX694UgEITw4mLC34ErNXA==
X-Received: by 2002:a05:6512:b90:b0:545:a2f:22b4 with SMTP id 2adb3069b0e04-5494c37d8e6mr3183877e87.40.1740920514146;
        Sun, 02 Mar 2025 05:01:54 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5496094e126sm201622e87.51.2025.03.02.05.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 05:01:52 -0800 (PST)
Message-ID: <023c8a59-55df-4484-a2c2-f629b237e21f@gmail.com>
Date: Sun, 2 Mar 2025 15:01:49 +0200
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
 <20250302034807.680a3971@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250302034807.680a3971@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/03/2025 05:48, Jonathan Cameron wrote:
> On Mon, 24 Feb 2025 20:33:16 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 

...

>> +int iio_adc_device_num_channels(struct device *dev)
>> +{
>> +	return device_get_child_node_count_named(dev, "channel");
>> +}
>> +EXPORT_SYMBOL_GPL(iio_adc_device_num_channels);
> Just noticed, this isn't namespaces which is a bit odd.  I'd drop
> the export anyway in favour of static inline but if you don't match
> the namespace of the next one.

Indeed, thanks. I'll inline this in v5.

Yours,
	-- Matti

