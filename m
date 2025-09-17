Return-Path: <linux-iio+bounces-24203-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EC1B7EB49
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 14:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90791B28226
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 09:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736B3299AA3;
	Wed, 17 Sep 2025 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L2Xmnn24"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404981E51F6;
	Wed, 17 Sep 2025 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100543; cv=none; b=KD7tLpFoA9fREMRT1OE7Bt8Hyw08LxyLMF+ZwaFaQ8B5TseXaa7OPjZ/HvOw704GMtREx126ErvxTWPwkrvf1ine6Q68DNzchIbCTh3ZboOM1obUGZRPcbIgFP7mjODveoy9uHXXtZrIpZ3cYQ259foJWbgjCW/XqJd5aLi7AQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100543; c=relaxed/simple;
	bh=XXSmMhiIJwxEgzQuWSUYkqPOP5y8v9qGIfTlmLL2PFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jieGIh+LvVLg1G1BIAFTL6haMoeddKeuf5ZN3dbjhcb4q5KZRjS4w+rdIn/26OOEV5eduP/Ovu0UVOre9SnmilpiOHPBSXk+YSV5oPU0sArFBrCx0O/+sr7UQPe88OgUFJSWqJ4UfS/YV4gemNmQy0MVr4kGdrcmlWJmoBxM5WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L2Xmnn24; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758100539;
	bh=XXSmMhiIJwxEgzQuWSUYkqPOP5y8v9qGIfTlmLL2PFI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L2Xmnn24q18lCp584jc3DJ3aArQTX0Q97EwLeCn3gjtunVHCT+VCz8J59OyoRJRXb
	 J6E2VIIP+SpjyRvytPAkuXuBab8plMjreqyXG4r62yWvFYC/GgVKew8qFVTN8wqEi7
	 cHLBtuaXLQ49gL79nfIC1DQSkd5BKuibCrHrBtIp1ozBC/55FV50OsL4lsJ/9d/G+R
	 D+xinyMOJga2aTtZJrHpRahN2aHbzA5KD76lgmLrcSiwQOcG91iCfs3R06RXp/ujG/
	 XOjr2a4cuI9zpH7lYnDdCoE40xrh9yjYtRCU50u0SAIN0qhgTGb4XYkT5eQm6kQCJ/
	 0Q4fjPfECOKnQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8555E17E0109;
	Wed, 17 Sep 2025 11:15:38 +0200 (CEST)
Message-ID: <a10685e2-e4af-4097-b432-778e83e0b3bf@collabora.com>
Date: Wed, 17 Sep 2025 11:15:37 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, sboyd@kernel.org,
 jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 srini@kernel.org, vkoul@kernel.org, kishon@kernel.org, sre@kernel.org,
 krzysztof.kozlowski@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 kernel@collabora.com, wenst@chromium.org, casey.connolly@linaro.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20250916084445.96621-1-angelogioacchino.delregno@collabora.com>
 <20250916084445.96621-3-angelogioacchino.delregno@collabora.com>
 <t3uk3k4h3l53yajoe3xog2njmdn3jhkmdphv3c4wnpvcqniz4n@opgigzazycot>
 <aMlnp4x-1MUoModr@smile.fi.intel.com>
 <mknxgesog6aghc6cjzm63g63zqbqvysxf6ktmnbrbtafervveg@uoiohk3yclso>
 <CAHp75Vf7KrsN7Ec9zOvJoRuKvkbrJ5sMv7pVv6+88tPX-j_9ZA@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAHp75Vf7KrsN7Ec9zOvJoRuKvkbrJ5sMv7pVv6+88tPX-j_9ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 16/09/25 18:20, Andy Shevchenko ha scritto:
> On Tue, Sep 16, 2025 at 6:11 PM Uwe Kleine-König
> <u.kleine-koenig@baylibre.com> wrote:
>> On Tue, Sep 16, 2025 at 04:35:35PM +0300, Andy Shevchenko wrote:
>>> On Tue, Sep 16, 2025 at 03:24:56PM +0200, Uwe Kleine-König wrote:
>>>> On Tue, Sep 16, 2025 at 10:44:40AM +0200, AngeloGioacchino Del Regno wrote:
> 
> ...
> 
>>>>> +MODULE_IMPORT_NS("SPMI");
>>>>
>>>> If it's exactly the files that #include <linux/spmi.h> should have that
>>>> namespace import, you can put the MODULE_IMPORT_NS into that header.
>>>
>>> Which makes anyone to import namespace even if they just want to use some types
>>> out of the header.
>>
>> Notice that I carefully formulated my suggestion to cope for this case.
> 
> And I carefully answered. Your proposal won't prevent _other_ files to
> use the same header in the future without needing a namespace to be
> imported.
> 
>>> This is not good solution generally speaking. Also this will
>>> diminish one of the purposes of _NS variants of MODULE*/EXPORT*, i.e. make it
>>> invisible that some of the code may become an abuser of the API just by someone
>>> include the header (for a reason or by a mistake).
>>
>> Yeah, opinions differ. In my eyes it's quite elegant.
> 
> It's not a pure opinion, it has a technical background that I
> explained. The explicit usage of MODULE_IMPORT_NS() is better than
> some header somewhere that might even be included by another and be
> proxied to the code that doesn't need / want to have this namespace to
> be present. Puting MODULE_IMPORT_NS() into a _header_ is a minefield
> for the future.
> 

Uwe, thanks for your review - much appreciated.

Even though I get your point... Sorry, but here I do agree with Andy, and I think
he explained some of the reasons pretty well.

Cheers,
Angelo



