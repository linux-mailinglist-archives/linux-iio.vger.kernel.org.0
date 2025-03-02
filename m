Return-Path: <linux-iio+bounces-16240-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF938A4B184
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 13:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E733A84E1
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 12:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155BE1E285A;
	Sun,  2 Mar 2025 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRnSCYk9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397832594;
	Sun,  2 Mar 2025 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740918087; cv=none; b=OFo3DsymrQ8+/Jrm0TZJKe+rPzm8RC0VC9MVejBjZCGMj8s18S7LSG8aJ8Ccutw3crVgELW4K7gZgG0iXr6zJ8w91NWuz0m2/nDL1y2N+6BeNFfsmdpQFo/OEV80R18pospkhbvuot+y+Na0xUhjOVZpqqLl/QobfU3FaH4vnmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740918087; c=relaxed/simple;
	bh=VXo9YiQuucOHzzLu2O9MNDIOz3v9HB4UDsRrEQnruDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fIAPzhA4VKHGBdE4bvtmUi+yEcLuz51+tlFhdr+eGODdlZiXRMsu94irGnJA73gsgYs9GQ2kg80BGVUZW3pOD4nucwg1J1oK8ne2NSc5zAa6XFj4XZlb2MuotqN5gBPW2b2FLcOhInQWM+4aiBdJFLkia1TPwmVcFgscUXPOENg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRnSCYk9; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54954fa61c8so2046276e87.1;
        Sun, 02 Mar 2025 04:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740918084; x=1741522884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qtblm0i8462d3luljoT5Tnt+0dpoW1Tx169HXsD42sU=;
        b=IRnSCYk9ZvP+GWZEMVEIYgOaVh1f7VGQ0xmQ3Vak7qfUfVvAV+R3PQ0SoGbjTI9xk9
         bMTqb0exgC6MFsGmxyIfQ4ZfOn1ENyyWzGISyfI1Uj0oHNnPsvzfFJo2tG1dFlpbb09y
         1GnyLm/w98rfHssXZYWVpQ05XCI31f4FABlpgcL03yHXFbtefcIdDzgBDndmELw/nT4H
         4jIo6qIPks5WztdrW+KjcUltJw04RganFVsb7LVckW0TovcoD+xjc+IwtlejDQw1aq/H
         IUNPq4OTd8+L0o9sxhhqE3Q+nQ5dGDcbP8eMnNdnEtYFBjhdR6fyLv+svDObC6ZOldgZ
         lhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740918084; x=1741522884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qtblm0i8462d3luljoT5Tnt+0dpoW1Tx169HXsD42sU=;
        b=UE8eJ3B9CMt51Fkrx5fqnME3E4h2jWTDR38Hw+EIyPrOATn7gnMpNJZLlBy7HFv3bf
         KNkja39kVlOHV9N4JwI+OiSM25IDw2Xpkvn0DKzo9GlNIqmy22CKhQHepqPPWM2bvnUa
         7YKSMu+y0Ptm4oOlxi7IKjTAyoNmLlQT83y3A8xbqgUzSwFoz9gGfdi+k4HGotV4axGW
         55Vm12IANkpjQra5fjhbtwN9zZcbFxXQ35MRgoMrcSSm2Cg5rUH9itGO/q2GXlHVhnl2
         Qy8ZgLqUqXxYCi9rwlcCSvb1j/C8DgXSNKQjFh5ylYu3COhVzYaWTKL4LUGXxXOq5IPF
         u1KQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/hqz+0WsrRmy59WoalRL/5hiJwgzVF/Kxs7UgorMxe/CJ06j5pdT6Kv/KNaSTCKXjwFm2KXrOAtxM@vger.kernel.org, AJvYcCVJqTGJo6SyPrBBum0c2A12tFtkvpxhB+Rk/k6tAf46ugWvCBx9esgBzYm1nLWvLJY8cK4zGJqY8HwN4tue@vger.kernel.org, AJvYcCXF2mhPoXTl3YLkTMu3VDi89k2VI86fqB1x5gDjrPCFz3AB2TXiANEcFC6ESArFQGYnIJieAvKgGaJZH7NvTz00Fh4=@vger.kernel.org, AJvYcCXIg6o6ebypHF9Pxg7ltsWuT3X3TVSA30gKyImdA9VuVXS3O0vilJ9gN8GQ5mYQcwOpEOP9OklQ4GTd@vger.kernel.org, AJvYcCXwcyLGLVADEIRl9ha8WRiPzlcvkQJahXPmqX0EOApeHugN68vFqYn4yRKHCkZGw95O9FG7D86XS9V2WA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmT7EGQWoSrNtWD7+E4M6cSGYELqAAZTAX6Tj3dzT6bYjQ9AyU
	Vrqf3tAr48JPQwLJytaFF+MIaHbNfyWfQdDccPZ68zfJxPeGoSHT
X-Gm-Gg: ASbGnctLuay6ta0mY4BmjrVuBc46AxSs2PUUFCjP8pytR8dXZuml04X9bmP4DtXZJUQ
	qTga6STlBLLsJUzdELxLuMb5XoaY/5PTSSAdMsk0htCNiZTcXKiqiVXyoTQN8DcrqFcoO85wcRr
	BY9pPRomL+pXZBiuGS1sXL5Obsps5XBCvfsU3aLds8RaqbJ5d2BAbCUd9gXB81dACEDHQRtiQnL
	6WbwRBtgXYgXL84QmoQpOyybwQVNq0ueS+dGRAf620ZbeluA5fuFXTIMTXMaHJelbdGjnB8GgX7
	EegsPs9kAHvTNAys0F6qaCCYxrhnMzbvb4E5WbiiyplyIA2bOuj7jCouzCwBi9JwUiB9Bnaci54
	PQdrSpUg/Kv7X9PI2s9NrgCVl4g==
X-Google-Smtp-Source: AGHT+IFo9Y9R+GJf/hvtgnPwl3vpc/B4svOJilmVq9Mn0xTVT2iqrfrmQOieXp0GoaVbPJJmjudwkw==
X-Received: by 2002:a05:6512:3042:b0:545:fad:a757 with SMTP id 2adb3069b0e04-5494c335f2emr3260926e87.29.1740918083926;
        Sun, 02 Mar 2025 04:21:23 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495dcba076sm272177e87.119.2025.03.02.04.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 04:21:23 -0800 (PST)
Message-ID: <863ce320-c5cd-47f6-a66b-c43fac98a4b0@gmail.com>
Date: Sun, 2 Mar 2025 14:21:20 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] property: Add
 device_get_child_node_count_named()
To: Rob Herring <robh@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Daniel Scally <djrscally@gmail.com>,
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
References: <29ec24f1498392cafbecc0e0c0e23e1ce3289565.1740421248.git.mazziesaccount@gmail.com>
 <Z72QAOA9xXbP16K-@kuha.fi.intel.com> <Z72Zp8tpnvlFGdQ_@smile.fi.intel.com>
 <ad39b453-7e5b-49bd-a4fd-6a4988636130@gmail.com>
 <Z72d7TzZ21WITW3f@smile.fi.intel.com>
 <893a3c45-537e-47ad-afbd-1e5d3b9abe2c@gmail.com>
 <Z73M3Ua6u1FpgBEK@smile.fi.intel.com>
 <720f9c69-ca1f-45cb-9f6e-c8e4703c9aad@gmail.com>
 <Z78g_uiXumn4mvET@smile.fi.intel.com>
 <d7982b76-3da7-47ff-b2b2-f964610af1f7@gmail.com>
 <Z8B7h4_IWz43gFhO@smile.fi.intel.com>
 <c9424f3e-1ff0-4c01-823a-19801cc3e7a7@gmail.com>
 <CAL_Jsq+tkXAAVK2D_AtENuXJZOF2eK=sUnjv3=7PM8nAyAB7Xw@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAL_Jsq+tkXAAVK2D_AtENuXJZOF2eK=sUnjv3=7PM8nAyAB7Xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/02/2025 18:59, Rob Herring wrote:
> On Thu, Feb 27, 2025 at 9:06 AM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
>>
>>>
> Sigh. This is not that hard.
> 
> - unsigned int num_grps = gfar_of_group_count(np);
> + unsigned int num_grps =
> device_get_child_node_count_named(&ofdev->dev, "queue-groups");
> 
> And remove gfar_of_group_count() of course.

Thanks Rob. That's what I (already twice) wrote I'll do:

 >>>> alter the gianfar code by dropping the gfar_of_group_count(),

and

 >>  I prefer killing whole
 >> gfar_of_group_count().

I just wanted to understand what Andy suggested.

Yours,
	-- Matti

