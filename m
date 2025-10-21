Return-Path: <linux-iio+bounces-25307-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D181BF527C
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 10:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA353BEB58
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 08:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A66C2D7DE2;
	Tue, 21 Oct 2025 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QA2jFApg"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B88B26CE39;
	Tue, 21 Oct 2025 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761034027; cv=none; b=ANFQ+hGtDVzR6b0Mt9bS9KfXJiyjL/Sd2leStzZD1dH56xGETYhOtjOlc0eHMAobrHeaUqQFW4C99Q5tkNyt6Fg+NkXm9f/hkUW/4VPqLoPSeLEoey8zyjxoq6ZAezQHn/YucAUKPmkG1y/bEqRK44O+vybPV+8fBYUW/mVPsCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761034027; c=relaxed/simple;
	bh=Rehk/1A9fRtUYg+F9et0A0RhHwPHQZv605r7G7w8Cx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNcqYpIO9T10KYtSDQXvmmHUJN4PNi4lkW+szi1bLpFN/1igIjyKwF0VKh47DbyWH4gCJ0SqhLP3TBQrjS5UXykHFurnS1isVJ/K6HyWEZiWEE0zO97jVtBZsT7KIMw8X893zykYvMFV9x5ecJ9JTLW93LUNvqZfOAdmwDgISAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QA2jFApg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761034023;
	bh=Rehk/1A9fRtUYg+F9et0A0RhHwPHQZv605r7G7w8Cx8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QA2jFApgIehSOhr+h6MU72RM5sk8wy+gDqp4D4uIO82/Yr/3kBj51T+4Oha1Cc0p9
	 kjxb7ouJev91hZ81J4yCDLPdur+TjgIiDT1Pq4PjfomHCYmmQ+elrkVe/7KzjK4sH+
	 XPmyDcRL2w7eU5MFAdG2GmD9bqqEeBZEDEUa5X0m/IGmnMwlPtnxLBEWfeYDyxo0Eh
	 VpgR0Dl1vcoOHNLU0xJNFAWm1lm+71bOIdhQnfKYA5klxWxhZDiNxVUKeJAsTyda8/
	 T1FPwtnAJ/YQabb+3XUSL29xzHoz8TAQMyES7vlDWJjT96rA9wQFUzAa8kWByhQ513
	 cRY+m5/uwPLmw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AE38E17E0CA3;
	Tue, 21 Oct 2025 10:07:02 +0200 (CEST)
Message-ID: <1a5f4081-191f-49a5-b3a0-419656b04bf4@collabora.com>
Date: Tue, 21 Oct 2025 10:07:02 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] spmi: Print error status with %pe format
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org,
 kishon@kernel.org, sre@kernel.org, krzysztof.kozlowski@linaro.org,
 u.kleine-koenig@baylibre.com, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 kernel@collabora.com, wenst@chromium.org, casey.connolly@linaro.org,
 AngeloGioacchino Del Regno <angleogioacchino.delregno@collabora.com>
References: <20251016104402.338246-1-angelogioacchino.delregno@collabora.com>
 <20251016104402.338246-2-angelogioacchino.delregno@collabora.com>
 <aPPmsBHnmKQ1sa3O@ashevche-desk.local>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <aPPmsBHnmKQ1sa3O@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/10/25 21:12, Andy Shevchenko ha scritto:
> On Thu, Oct 16, 2025 at 12:43:55PM +0200, AngeloGioacchino Del Regno wrote:
>> Instead of printing just a number, use the %pe format for error
>> status, increasing readability of error prints.
> 
> ...
> 
>>   	err = device_add(&sdev->dev);
>>   	if (err < 0) {
>> -		dev_err(&sdev->dev, "Can't add %s, status %d\n",
>> -			dev_name(&sdev->dev), err);
>> +		dev_err(&sdev->dev, "Can't add %s, status %pe\n",
>> +			dev_name(&sdev->dev), ERR_PTR(err));
> 
> LOL, I only now noticed that the parameter to dev_err() and dev_name() is the
> same. For christ's sake, why do we need dev_name()?
> 

Just only for consistency and having the exact same message as function
spmi_device_add() and nothing else.

I agree that it's not really needed; if you want I can just change the
error message in both spmi_device_add() and in the new function that I
am introducing here.

Cheers,
Angelo

>>   		goto err_device_add;
>>   	}
> 


