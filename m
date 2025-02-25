Return-Path: <linux-iio+bounces-16057-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3F0A440EC
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 14:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0F116EBFC
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 13:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0709A26982B;
	Tue, 25 Feb 2025 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQaa1Bmp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ACF268C52;
	Tue, 25 Feb 2025 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490162; cv=none; b=rqKN+UlswhnY/z0+66gpdGxJ1HC9JdDbxtauXDOrwep3MIbgZrGBevmpiH2oj9JngpXUh5o2JzPsEseIugSK8Yi6CNpaQtfQzyvCuk1uAfzXwRN74+yEAB5g3B3sLdUTr6nRe0ollkV06YolpScsRgtPy7sKoqpLcVNX7Z/ih/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490162; c=relaxed/simple;
	bh=rHQexzBVm+h27NJGWaGxccjhnh05Li9527fFlp5jf58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XA+mvSzbl4aH4ERIQJ9y5YixNDxG5bo/c6lPlM6qP1VqJpeHvC5IDQfgDLG8m2Pl2uwXa8js4O9h7xXwi8aj+zWHYIGpb5SWvOZwkfQQz0PZXZq/S35YAyrYTd2ZuodGgdY7UtwZ/qD8ONJLe5tXFWYk1r2+YcYp7M/WijCX1u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQaa1Bmp; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-543d8badc30so6499615e87.0;
        Tue, 25 Feb 2025 05:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740490159; x=1741094959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+FbrRxOgnYTZyaA+lF8b6QjfgGK+98gNFHNL4vg+8M=;
        b=iQaa1BmpqwEtlhxZMJq69qGcoCfsj2ngBK3g6fVwyHnbuTF0+oQ6NDPWoMqvfnir9L
         pXkFAhkzxlgDruRLbi5DHj7IDFVxIoDlKFSA57hxw64WYWxd4imKCfjRDeMFcSIqlBSe
         uoWgGHYuLZndPcYHL+az9678E5uEbQJcyXJSPWAC8Fz6m5+UkcoM9QN+Qut8pnKhzl/F
         tTUNG+Z4ZVeaW+9WKL6L4G3t1OgvWEWyCdq5+CKB4xhTEiuDtUtIX2X2ZGRwV5npkKqY
         dfdH1KSOz+S86DxTDfdX9v3vXcunOlu6i3nMJQBMw693W3OG/0o5NmlA9qnN9cegRmHR
         p8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740490159; x=1741094959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+FbrRxOgnYTZyaA+lF8b6QjfgGK+98gNFHNL4vg+8M=;
        b=QEDAXNqkbABnjIBPoQZ88KzhNIpeeye7fpyGKho/pDU+jBD70SQrHK12DixapvKIvD
         yEagVq3L4uhf/t9rz4RpHPGHAYeLmEI5+x7vlpnMl3elojXyxgmsYBG5cPcNONybmDmu
         S5pQqWuaBq9KyabYb+6MzxAfFgaSkrYMse8bM6NTD8A3ZI2sJoa3m+2GJba+TsA+xJml
         Kez6CUntlp7js6HBW4fAjIW95GWkIAGAKmq5Es3irV7ryfY8GiHfbdIdxeeLUQfcQH8H
         V2YtDYAkoY+wSoNOSyXKoc9jQItN3xQHjA2mLbFfjef/ZYtKqGZ0V1IkTeSnQlP2RUcs
         Tbqg==
X-Forwarded-Encrypted: i=1; AJvYcCUXDDbQGCoaDGD7bk7upmD3DgsLqYvExaYdpJxBgjm9eDdURgpFYPAlXLtKNVDoUaotT+ginpUZDd4x@vger.kernel.org, AJvYcCVzadywxTL2eSBTBT8iQLWz7VrGxjvZUqnRfmvEXni1BHRQu428Hddqg1dfaDVJMSzvXxCeFxAhGr5PL+07@vger.kernel.org, AJvYcCW0drSk5cxtXogapboWqhvEJekh22+Ldt5GUmdEXBs9jldIvl1OZuDWHXQuttdvCNP00VEo/9h5jn3fgtw66+1Eu54=@vger.kernel.org, AJvYcCXU8Yn8XpliQGWEmjf3n4kImvfY4bdB/c1L4g1WkkzqpwDanUY/5/7gci1rWe3pi5n3HrekegZkwKVkDQ==@vger.kernel.org, AJvYcCXt2sGPma7zSGmJEn+foyQrNRwIGaLSLFRQVgjbfdd6a0NueUDKPnT21qZ1FRaPXZ17dteX1T0HPrsS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0MVaZS5TGjqxHA1xkhMTyOQA9gvuh7fZY1mpym/SeM8dC2R22
	26QazjA1UMp2PuK1Y05RLyAkdDp8bU1hMfo2GW6oaUGJH80uWKuk
X-Gm-Gg: ASbGncsoVszor2AjrItl39iAY2lHCQLAZRyIvOWgu4n3p48vXeKqb3KNQKUa5g43ZVT
	WJMWlJrHgeSzUS5bohJrRc36RdvORvqOGsWUuJue5/AVnRyvQHuT7EkGhu+a/AcY0vs5oMs8+ZM
	otSj6Hz6GWs7Z5hSKyIfW5VCGtxcNfOrnkrnVUNG8Djxnag4UpapII5EWYblN0owBopZZbq6NCq
	DcJYy3k7kvJv31c9sWzVaLTATkcmWrqbxUIiGcwimJ+L+63j87lfV8+OImmamv/oizERbawjPbt
	pnsJBmIXKUubTtf7DysWdyTzuqHrFCNq0OQMPNU=
X-Google-Smtp-Source: AGHT+IGjIiZRQoCqQpRaub+un/XzTU053MAFUSi2TNm85/fj9TbmZ/3TfRa1taLP4aGsaQej3mQfPg==
X-Received: by 2002:a05:6512:224b:b0:545:54b:6a05 with SMTP id 2adb3069b0e04-548510eebcdmr1461663e87.45.1740490158959;
        Tue, 25 Feb 2025 05:29:18 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b9db3sm181711e87.88.2025.02.25.05.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 05:29:18 -0800 (PST)
Message-ID: <893a3c45-537e-47ad-afbd-1e5d3b9abe2c@gmail.com>
Date: Tue, 25 Feb 2025 15:29:17 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] property: Add
 device_get_child_node_count_named()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
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
 <ad39b453-7e5b-49bd-a4fd-6a4988636130@gmail.com>
 <Z72d7TzZ21WITW3f@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z72d7TzZ21WITW3f@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/02/2025 12:39, Andy Shevchenko wrote:
> On Tue, Feb 25, 2025 at 12:29:31PM +0200, Matti Vaittinen wrote:
>> On 25/02/2025 12:21, Andy Shevchenko wrote:
>>> On Tue, Feb 25, 2025 at 11:40:16AM +0200, Heikki Krogerus wrote:

...

>>>>
>>>> I did not check how many users are you proposing for this, but if
>>>> there's only one, then IMO this should not be a global function yet.
>>>> It just feels to special case to me. But let's see what the others
>>>> think.
>>>
>>> The problem is that if somebody hides it, we might potentially see
>>> a duplication in the future. So I _slightly_ prefer to publish and
>>> then drop that after a few cycles if no users appear.
>>
>> After taking a very quick grep I spotted one other existing place where we
>> might be able to do direct conversion to use this function.
>>
>> drivers/net/ethernet/freescale/gianfar.c
>>
>> That'd be 2 users.
> 
> I haven't checked myself, I believe your judgement,

I took a better look and you obviously shouldn't believe :) The gianfar 
used of_node instead of the fwnode. So, it'd be a single caller at starters.

Yours,
	-- Matti

