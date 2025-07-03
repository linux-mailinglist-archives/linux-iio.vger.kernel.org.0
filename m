Return-Path: <linux-iio+bounces-21311-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E62AF77CB
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 16:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C9F564382
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 14:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF222ED86F;
	Thu,  3 Jul 2025 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WGwT7TQM"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF15D2ED846;
	Thu,  3 Jul 2025 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553643; cv=none; b=jALVzJSNe0iqIepN3zdm8SEuliF3RsPAhJDxZnhCpBqY1TGIU0MQBAf5PRxQvbmq8FWpQenfY7RF4aUUNAtJkxSB4eGkP8CvZp2dlGEFiVuD2tnoIkc0rk5E9dpA2EY4q0C3CxcsIkWdCGCJRJQq0SwDeOawHUQz/eicpOnMq80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553643; c=relaxed/simple;
	bh=pge19sZrf0PUvRXmEe9xEQSZDWyU6lnUwOcQUIu4hQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgbyBFO4zqXSb2LORGSyXWUsAjD55ODrvIka4J/ICxAM6PSC0I+QJkIkUN8wad5BZr7THis/ezjVqtK7VHHWgNLayNTe4Hjro/KKqwz5T/ZAGFQ/YyLsdUAuWlak85PCtpWCt4ufphW6zSl3W+e9foVzJR29zwZ4NR03q98tGLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WGwT7TQM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751553639;
	bh=pge19sZrf0PUvRXmEe9xEQSZDWyU6lnUwOcQUIu4hQA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WGwT7TQMUCYTum1QY1ogt/jyEc0WTdGqMnWxcE7uq45SwYmTgRjqhwa6lBd+S/fOp
	 FFJx495wQGsH10vrUJb/k2uZhIbsvcE21Oi4vPRHgjCHilVNND8vqo2vKsQP5U1wl3
	 Mj3XwG1dieAd2Dc+3n6K5zTEwCiM2CbOBvyNXYmCgs0CBBsiGP0jeu9S9Dz4k1aQkC
	 Iv+RoSPp93uQPi5wYl0nhCsPEyHYXlEEoEHspOsnXIxM6u8B3OkfKXVDQL9KW9x6Fy
	 WeZYklF7A1JPCqmzErZNUUbpYGWx/TZu02f+yuKzo2wKUXHZ3sle1VyQko66pMQP3J
	 DCtgk3I1XjsgQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1C65117E0636;
	Thu,  3 Jul 2025 16:40:39 +0200 (CEST)
Message-ID: <cbd79481-474e-4c9f-bbe8-367917115ccd@collabora.com>
Date: Thu, 3 Jul 2025 16:40:38 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] iio: adc: mt6359: Move reference voltage to
 platform data
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20250703141146.171431-1-angelogioacchino.delregno@collabora.com>
 <20250703141146.171431-5-angelogioacchino.delregno@collabora.com>
 <aGaThTSAriz46D7T@smile.fi.intel.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <aGaThTSAriz46D7T@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/07/25 16:28, Andy Shevchenko ha scritto:
> On Thu, Jul 03, 2025 at 04:11:44PM +0200, AngeloGioacchino Del Regno wrote:
>> In preparation to add support for new PMICs, add a `vref_mv`
> 
> I still think that the vref_mV is a better naming.
> 

Ouch, I think I missed that comment; if there's nothing else to change,
I wonder if the capital V can be fixed while applying?

Otherwise I can send a v3...

Cheers,
Angelo

>> the AUXADC_VOLT_FULL definition.
>>
>> As a consequence, the definition was also removed.
> 


