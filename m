Return-Path: <linux-iio+bounces-5749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B1E8FB18F
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 13:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536981C224CE
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 11:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53E9145A1D;
	Tue,  4 Jun 2024 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hIgWr2/k"
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A2A144D21;
	Tue,  4 Jun 2024 11:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502279; cv=none; b=Nhvt5TOJEp76dbKsMQOxQhJs/3nn1v/xv0wODOqxyjjsqkwr2IrtLf7dvqhzuflfmMxlefAtyBEqSC7Wfw8bbrt6qQdw7gLqgiiCpfGznxDMWfH/uWzDZ59aR/QkRpDL5900yipr6zNyEFieeaJgOBXuKdaTcehKlFB73bOTiKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502279; c=relaxed/simple;
	bh=56062WNHk69vFRqNKez1ZJ1vLNNKXi2bStApeOpZP7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ObwgTb2jNUWVJVw7ilOWTjw39e5EDpQz7hxELGaTX9lp3bayor3jLH61g4TIz1F+864KMFjnQ3+z6usoJupCTt6tlKaL+3K48Htr/UYzf3qOHaZzIv0v0CpDk+/c5WawXxLXeZHJua08xkJuszUrQT9QGlWogpi6iL+LV58M4hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hIgWr2/k; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717502276;
	bh=56062WNHk69vFRqNKez1ZJ1vLNNKXi2bStApeOpZP7g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hIgWr2/k1iqL5wvZ12nj8yXRxSrrlg5e8poWaVTErsNd9V1SqVxaBN4bgBCT8VmB4
	 pZhLvQQxHfkjVu7Oji8axJFgpwAUPWXj+NlNJIATSxaytE4YgEzPlhhOuIMttnEqbR
	 DXt9+almqD59l7ygrhH0Aglgu7AGfCI0aJO4ZKCMTJ0xKmCTQ9Qw8GtUw9PSpnf+Jw
	 mMdVEtG8LcvUePuCQL45fOf4GZFXtKf+CSZg1Zz3OFCOs1/ISjoNokxi/Cvscnwuzx
	 nNOSTiEElWrd86s0H5RleZ070LQXtIgCsl8MDKFF2N7rMNhlqTu64EZyAYx2GsWXPK
	 BX8k84AVfCalw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F11453782199;
	Tue,  4 Jun 2024 11:57:54 +0000 (UTC)
Message-ID: <630d943e-3bf3-46ab-b3b8-cc44a86cab64@collabora.com>
Date: Tue, 4 Jun 2024 13:57:54 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] iio: adc: Add support for MediaTek MT6357/8/9
 Auxiliary ADC
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 lee@kernel.org, andy@kernel.org, nuno.sa@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, marius.cristea@microchip.com,
 marcelo.schmitt@analog.com, fr0st61te@gmail.com, mitrutzceclan@gmail.com,
 mike.looijmans@topic.nl, marcus.folkesson@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20240530093410.112716-1-angelogioacchino.delregno@collabora.com>
 <20240530093410.112716-3-angelogioacchino.delregno@collabora.com>
 <20240602111141.0058f39e@jic23-huawei>
 <60e55919-2a8c-4d83-89a1-6e4ae156d34d@collabora.com>
 <CAHp75Vf5a8VVyOXQRt9P1QnM6GHZ3rLuvnBF63H_83QBHOTJ9w@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAHp75Vf5a8VVyOXQRt9P1QnM6GHZ3rLuvnBF63H_83QBHOTJ9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 04/06/24 12:55, Andy Shevchenko ha scritto:
> On Tue, Jun 4, 2024 at 12:42 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>> Il 02/06/24 12:11, Jonathan Cameron ha scritto:
>>> On Thu, 30 May 2024 11:34:08 +0200
>>> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:
> 
> ...
> 
>>> What are IMP channels?
>>
>> Honestly? Well, it's called like that. I don't have any clear description of that
>> and not even datasheets are unrolling the meaning of "IMP". So.. I don't know.
>>
>> What I know is what I wrote in the driver, and this is:
>> * IMP has IBAT and VBAT ADCs
>> * It needs different handling from the other ADCs, as shown.
>>
>> ...and nothing else :-(
> 
> I could speculate with confidence that this means IMPedance (since it's ADC).
> 
>  From MTK6329  datasheet:
> "The hardware also includes necessary modes to allow for simultaneous
> current and voltage measurement
> which can be utilized to estimate the battery impedance."
> And googling in vendor trees also suggests the same.
> 

That does make a lot of sense. Thanks for that, I don't have the 6329 datasheet.

Great, one more piece added to the puzzle!

Cheers,
Angelo

