Return-Path: <linux-iio+bounces-5760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947EF8FB39A
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 15:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C662288019
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 13:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650EC146A72;
	Tue,  4 Jun 2024 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="s2PbKEy/"
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6163143755;
	Tue,  4 Jun 2024 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507477; cv=none; b=uMKqgk4t0ho1dqjf0WkRWhiV9DUhcFgjrgmzOYJVOIUk/PrKUdo1EiRtjfuOKFiY9KeUCgjwbWxuHvXdqFTjbHeBsmCyeVYMx42Ts/LN9mj4sQUGcKP1f36N+lr1FB91WpUMwakssnxMPVE541RcggJF+4ccvvjgmbwY0PxpSWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507477; c=relaxed/simple;
	bh=6etJFa5Sva7AQexf4AoKIy5woS+LE9rtDwzdEoCFtz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2vAQ5641o8oUqm2h4F7oLgXyRAlV+1jMAn0KMndZ9Q/KXybBnFspHH6Aakze0DGhyKfZCz6qjANbjfxJtMpu3KuJ867XazVtLcYRN4s9K/XxixBLs2InjYj8h84Y57SE54n2lAEt4cDE2YFjHG5J7LTHHg+vHgwiMspql9SkqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=s2PbKEy/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717507473;
	bh=6etJFa5Sva7AQexf4AoKIy5woS+LE9rtDwzdEoCFtz4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s2PbKEy/cyegC6j7YNWE+OP9hHBb6SwLPuKfEZTZjSgl03lyr4WXTa6F9XwjxSs6o
	 6G57MIlfusafrur0ikXYiXPiH6ClwiODBwtLXLPLfhYwDC8SaRNbaMvGKulSe5yspN
	 tgH305TZLAUqKlLiFhqJ8XSfxwJC2uS8XRLWT1ABUgQ86Lqx+dQzPR6q0Uf/0jZEDs
	 t5F6WKKVHl4g+Rzgxuw6XRXkCmMYatXsibr8694It+UHb5Xay/46M+kXJ0Vg3tne1I
	 NsY2VE6zP+I59iHUZdlbaQeu4eq1p/s8lF7cH3b9TJiA45SkmDhWNUF2iUz61ANb7c
	 AHwezedUr5Ubw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4717B37820A7;
	Tue,  4 Jun 2024 13:24:32 +0000 (UTC)
Message-ID: <575186dc-8a4a-4d93-98f0-d2271b0aa1fb@collabora.com>
Date: Tue, 4 Jun 2024 15:24:31 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] iio: adc: Add support for MediaTek MT6357/8/9
 Auxiliary ADC
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, lee@kernel.org,
 andy@kernel.org, nuno.sa@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, marius.cristea@microchip.com,
 marcelo.schmitt@analog.com, fr0st61te@gmail.com, mitrutzceclan@gmail.com,
 mike.looijmans@topic.nl, marcus.folkesson@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20240604123008.327424-1-angelogioacchino.delregno@collabora.com>
 <20240604123008.327424-5-angelogioacchino.delregno@collabora.com>
 <CAHp75Ve8qPLu+gS8o5Q5A20j_+AP_UVkOzdKqcnhUawA_sW+VA@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAHp75Ve8qPLu+gS8o5Q5A20j_+AP_UVkOzdKqcnhUawA_sW+VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 04/06/24 15:22, Andy Shevchenko ha scritto:
> On Tue, Jun 4, 2024 at 3:30 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Add a driver to support reading the Auxiliary ADC IP found in the
>> MediaTek MT6357, MT6358 and MT6359 Power Management ICs, featuring
>> a different register layout, configurationm reset and ADC reading
> 
> configuration
> 

Oh, oops! If there's no further comment to address, can this be fixed while
applying, please?

Otherwise I can send a v3 :-)

>> sequence from the other already supported MediaTek SoC or PMIC
>> (aux)ADC HW.
>>
>> This driver provides multiple ADC channels for system monitoring,
>> such as battery voltage, PMIC temperature, PMIC-internal voltage
>> regulators temperature, and others.
> 
> Seems all my concerns were addressed, so
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 

Thanks!
Angelo

