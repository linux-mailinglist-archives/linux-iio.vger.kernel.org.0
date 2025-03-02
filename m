Return-Path: <linux-iio+bounces-16242-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 018F4A4B1A8
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 13:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D794C189097C
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 12:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731211E47BA;
	Sun,  2 Mar 2025 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuMRNsog"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826871DBB38;
	Sun,  2 Mar 2025 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740920062; cv=none; b=eoITOD42a9FhfUc6v3SPZovg4pEWveKlzcgm+fKkJ7T7cjHIvKzPrI/lAnoheqnRqFxbrvNHBSvuH3hbyPt4lIKB5lKUS+fpviP6cwm8zXJPE4yd4ltRnCgiDQRFfGmDNvY6el/ULSHxCWixNtC5RF87ruFo6fzkgKR/bKD2Ndk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740920062; c=relaxed/simple;
	bh=VKIyH1CTs59Hr7vr+2y5gBC/sPB4SNStOV47/070Lb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MosUSVeEwwcxFckh2Uz5GNVGpYj6+D90EAkgqdBqHPxQR5EYosVOvAxD4bUAhW1ngx2ho8XSnnARuwNxbi01wLhS9YmEUVVgvFDpUZpK5YM+BoRJQ1Kqyj3zyd/QS8Ib/Wit2u9gphmJho9vSHGU8X91qOibA0u6B7RIXOF8+3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuMRNsog; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30a3092a9ebso37654411fa.1;
        Sun, 02 Mar 2025 04:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740920058; x=1741524858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phXyydY7gGfZlc5DxydLzP5lRJMditp6NpQC5fmMcrY=;
        b=SuMRNsogXWMEJ0/Fj5Hjtq8B5qhNdbEqDfVWDRtZtX0Mlz+2NAFdOahaQYjdvgyIBX
         E1QDHDsGbkT9vd0x8o5vzpNdjifhGp3s0gj0HXRCVZ+MjlItjDTZo1+3AFNPYnMQvMH8
         3yOxh9C54SS4uXJRR8kOCShUzS+rl/2/AU5DwUEcYbcLPzZNjl/28RH4yaqQMPLZ4oxQ
         vC7gYltNsvILUhMsGW+91sJNniN8EWPTJtmLc/n8WB/fWNNq9d9klTni5SUmHS0QWmsT
         DHbxsB0lq2eJCgCQk7eF0gLStr9l7xBmBB2pBDPvbgpvxzX05LtLYxFmXmVdt6j4lqAA
         WRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740920058; x=1741524858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phXyydY7gGfZlc5DxydLzP5lRJMditp6NpQC5fmMcrY=;
        b=F31OVGyJvA9+6zy3gGOur5C0NrwUxAF+BMZCIiS8TNtiFcENAaU38kVKzJkXEnL60S
         vam94livD5DlcV9y2FGWMCOCup6Mc5VUdmGLBKhgI/4B2c0JUWQxDthish/nVO+zU1ez
         yYw2VSD3X3ykHWak76nu94r+5SOh6/iD72WSYw1K6i+HHEm0XnxkqYZ3oAF8nksDft/y
         IH8FoAsGRin8wojpB/+82YHG/qi+HmiL8KfTfZMOfJZtGz8yVIisWEt4xg7PJWSFEOST
         05Vxuy1R6piZNLEGfmKTzoePm20dRsj9OzhtMM2xENY5qJXjZ4YJ7qBTB2N7hwSZYgnl
         F1+w==
X-Forwarded-Encrypted: i=1; AJvYcCUWLno0pNk7lX4HILSgVPXp1SYZa5J+QvFMMMrmMz4qmjDNhasLOZwd8uGQwgOWAU6dB290aEDbb9AFeA==@vger.kernel.org, AJvYcCVw4fNIQ4j0DCHKGXlMTBc0rtCQsZKsbANrMShg6N5evT33n+2pz5d4ur8lph2oqBjMzQTJTwM5YcUXwqtYA5Of1Cg=@vger.kernel.org, AJvYcCW3UJeSnnHsNa+vIPtCKO3G0OY+2NIHKFR3VX/jUCHqd2hao5hesVLaKUE4weV3/9ynKX46IwzggTAbQfdM@vger.kernel.org, AJvYcCX5CijtzHmp9O9HskiupWJqWuXx6PG2d9x8wMrBGwuIRXLxKk/vtIJ2xQye63DRShx8I91hsr5Pb0tq@vger.kernel.org, AJvYcCXyAGuq2IUxmTekbiPyfIpD+k7a65zqUaAB7eci7EywzpTvRU6tGQ+D573POjQFtGt9rf1T/PQNhuhZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw60wK4dhB1zzGiSWAKM43wcaKKuiguYL418rlmg2iA6Hiq6GEM
	hF5ZMXlxQQ6ZB12ZvxvEpz8+lQ/RY+fdD/6n5rVJG/tN+wsGh/y/
X-Gm-Gg: ASbGncsQbTS3hNXxS2WE9W+VYH6ymWrYJTKgpzH4jpgUBULhVyUxoZBrm8YmSW3ncyU
	7qftEj2/PK5A8Mboqlmu9cknQkdyjqVAacR7Efr9cu427dnrXbVaEvU1ziuP2norZyspoaB7dW/
	nSkZijwCiBpbFdAbHS5W2L05kbiIXR9o9WwW2N2q4218HbT+rBYOvJtwv8htqkWRQuX96J+GieS
	1ea9mwEjCEAzzKReC/N9LsDU6peIhyn+Qq1abvYcZ3ZgOIe8m6vMKyK4UIN5bup8Taf9TSTBm4+
	R0UlG1wqjNT+qSmptfth+/dEBJPbbRUvmpO3wyfeka/thHXUknGAnnJKYJpgysp3zi8D/iGdBHv
	pdjAwo6OVHacqy+uXraJOYXPgBQ==
X-Google-Smtp-Source: AGHT+IEJN/8WgRnH6T4J4ZG7JcpCuAO5jHwOEQHkq0uxIoxZ3O+QiARmgECict5SIiXPtktkXgM2tQ==
X-Received: by 2002:a05:651c:501:b0:30b:b28d:f0a6 with SMTP id 38308e7fff4ca-30bb28df3f5mr7934721fa.8.1740920058224;
        Sun, 02 Mar 2025 04:54:18 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bae88c37dsm2568041fa.37.2025.03.02.04.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 04:54:17 -0800 (PST)
Message-ID: <eaede287-658d-4c23-b217-5bc8053e64ed@gmail.com>
Date: Sun, 2 Mar 2025 14:54:16 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] iio: adc: add helpers for parsing ADC nodes
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
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
 <0de7b0ac-eca5-49ba-b1b3-f249655f3646@baylibre.com>
 <1b308a10-9622-47f9-b489-bd969fbdfc34@gmail.com>
 <6f6e6550-5246-476f-9168-5e24151ab165@baylibre.com>
 <9180ff11-888b-453d-9617-4b3a0fb38d91@gmail.com>
 <20250302032054.1fb8a011@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250302032054.1fb8a011@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/03/2025 05:20, Jonathan Cameron wrote:
> On Thu, 27 Feb 2025 09:46:06 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 26/02/2025 18:10, David Lechner wrote:
>>> On 2/26/25 12:28 AM, Matti Vaittinen wrote:

...

> So today the situation is we have all the options in tree and we aren't
> really in a position to drop any of them:

Sure. I am only really interested whether we want to prefer some 
approach for (majority of) new drivers. Furthermore, I believe there 
will always be corner cases and oddities which won't fit to the 'de 
facto' model. That doesn't mean we shouldn't help those which don't have 
such 'oddities' to work with some generic code.

> Hindsight is a wonderful thing.  I'm not sure on what policy we should have
> gone for, but now we are kind of stuck with this slightly messy situation.

Sorry if my comments came out as criticism. It was not intention, I just 
try to justify the helpers by trying to think what new drivers should 
prefer.

> Helper wise if it expands usefulness we may want a bool parameter to say
> if we skip the missing or not + make sure a max expected channel is provided
> (might already be - I didn't check!)

This far it only had (optional) maximum channel ID for sanity checking 
(useful for callers which use the ID to index an array). The bool 
parameter would also require a parameter specifying the number of 
expected channels. That'd make 3 parameters which may be used or unused.

I don't think I saw existing code which would have used these 
parameters. It might be cleaner to add new APIs when we get such 
use-cases. That should simplify the use for current cases.

Thank You for the long explanation of current system + the history :) I 
appreciate your guidance!

Yours,
	-- Matti

