Return-Path: <linux-iio+bounces-22290-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E28B1A88F
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 19:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6439E3BF7E3
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 17:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A607225A354;
	Mon,  4 Aug 2025 17:20:13 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B1D26FA67
	for <linux-iio@vger.kernel.org>; Mon,  4 Aug 2025 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754328013; cv=none; b=Q0BkAD4KwKVfsqyAiuGm5gDzoogqUAb8f7BYnI2lWBNYGDsJJZN41d+FU8bFOMV2l+w+mT1Pl1MGlyRi9xZb0Qa4F2TtvIDRTe0FIoY+383HF4ZAnVEpoP40I4YjhOdYLjStdGi+veTI+WzWQfRQ+8apXVNAgoBd/W3NhTb1iqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754328013; c=relaxed/simple;
	bh=oUXHllmLeaB54QSkc+fuPO34LPB9vG5X/W5IArYILLQ=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=Bj6q79QMcyr6UQMknbeyC/z7gpvBwANDIrCX4DZbn3w5ra/GgzHkqxcrYON12ncR95meDu32hAtX2kj6bgTOMFpwrYBg8A4EjXUVL0wyznBbuzBotqRtb8YywuCXwCRQw+l4R4pHOlOi09WxY7qEUVp9j6pXPVAn+K+gT5eWYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1uiym4-00030p-Q4
	for linux-iio@vger.kernel.org; Mon, 04 Aug 2025 19:15:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [bmp280 v1 4/6] iio: pressure: bmp280: enable filter settings for BMx280
Date: Mon, 04 Aug 2025 19:14:56 +0200
Organization: Linux Private Site
Message-ID: <87cy9bknzj.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
	<20250803140802.36888-5-Achim.Gratz@Stromeko.DE>
	<CAHp75VfB0+aZKLmYYq3dYirQE0gXJeqNC2OkMR3s2PEzkT4uLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:ZqasnLnXJ24R5bjofLH0P+f8Au0=

Andy Shevchenko writes:
> On Sun, Aug 3, 2025 at 4:09 PM Achim Gratz <Achim.Gratz@stromeko.de> wrote:
>>         ret = regmap_update_bits(data->regmap, BMP280_REG_CONFIG,
>> -                                BMP280_FILTER_MASK |
>> -                                BMP280_TSTBY_MASK,
>
>
>> +                                BMP280_TSTBY_MASK |
>> +                                BMP280_FILTER_MASK,
>
> What's the point of this change, please?

Keeping the arguments in the order of the bitfields in the device, just
like the other occurences of this pattern in the surrounding code.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+



