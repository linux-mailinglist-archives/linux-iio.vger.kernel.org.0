Return-Path: <linux-iio+bounces-11766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA45B9B914B
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 13:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8248F1F2219D
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 12:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17556158DD0;
	Fri,  1 Nov 2024 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="arSkomw8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB459F9D9;
	Fri,  1 Nov 2024 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730465335; cv=none; b=mtfeicfWgWHplKKi1R0x0HfdGcxrZgWnIm02lKHVXytjhfvaawoVcF01HN6k6Zjgvuzpy1CzPGlMdkXRZgybJXZiVubkUclZen2zTEEfoULdIcWDZIWQTSPesukNPD91kWwwnkHPXr0pjM9s+pRssMJb/OnxwmeWDR5RNdHXlwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730465335; c=relaxed/simple;
	bh=t6MOPlAFLeix/1c7rFrh7y0ZxRC8o+cTFGNYkWdBSF4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=cUMCvk3ThwAzGsIDvtZnZL26rH1nSaxfEbW9fh96VYg+FmMGRkOokOnciIeuZ2IPSc0W0txrVuwPvSVfH+gRrT0FREjj6Rog5PxSBc5HRo12/9f3XPdJxz+jCvRp2gcbnoATiKlJLeQ9sUS5NcX18DUl6MZkJXP0bMy7Ep88K+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=arSkomw8; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730464991; x=1731069791; i=markus.elfring@web.de;
	bh=wC6WwKWnhI299rVfj7xX/miU/prcrbdI5Rd6yT/vKLg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=arSkomw8bsI+nNP//y/cuEP5WVFZgcivYOYB/OOo5NclW286/y/ewY6Iv5mKQnq4
	 RABBihg0yesZVZDy+nmwdFzInw4M1AQAnAIEbJk7FDf1Mfpj//RTkt5DVR1yQ8YIM
	 YF/BQEleimA8nz4+lN5ScyrxLtiHqO/WkvjKN52kxxkyOhqy3zL4zxxGY1V89FFRm
	 15z/t9W2JPv5VxqMGw+99tOAjL9Q3eC4u3e7/PZ/pXZ7+oKlbNI/vCsAWJRDAfWEP
	 W5ieFluaphewatZhB20DNBaTVsTnJiYANlaOjkOBk9Q6ZXf1CFfMH/Bnsvx96LO+t
	 hwqOxhFz3YJMEUUvfg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDMvE-1sxXKq3amE-005IGv; Fri, 01
 Nov 2024 13:43:10 +0100
Message-ID: <8c7a5bcc-1fdb-45af-8f0c-1f9b6f0cf058@web.de>
Date: Fri, 1 Nov 2024 13:43:06 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
References: <20241101081203.3360421-2-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/4] iio: light: ltr501: Assing ddata to NULL
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241101081203.3360421-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0NMoCiaEoR2Qle64Ww0/lEfZ7OUQnbY7y7k5caHPwgeIESC6aSw
 nukqSpEJnzmCoJFCQhIBOrHhLe6rlKThC59jSIBAiXlf4zifql/HPq6KFx5sDgPxwYpwzui
 jIg1BHfPd5AiMEQIY+gkvF2T1to56ub17bb6HWpSa+pX2m+miINs4Jth+YtBNT6SQqptxJk
 7VSEpIMac4nccF88d7Now==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KhywX60mZHU=;JH6165shfRPTr6Ef7sCjRBvj+ga
 fo5DmQfOJBMZuczQpJyGn8/4kwK/wifVGur0kKnYujKsPppKZOy2F4os1Ph4CicULk/fMtmkX
 TDG4kOBRKbk2Z8bWXpvFvC/vwz17BgVfx/c0kP5bThdvafAQmKgOIgU+lHa3SLxEY9MAl3Prs
 yHJFStd/o0JjzG+kDZvtmB5m03SLyVwXiPcR3KpD7WKJmiE/yCDfDFexsHwjBI+5LEeR0xS7H
 /McjpN5VvkBZMOiVq2VehEguipMWIgKL7nfHLhbYqrGw1ufoO84Jrp4rVqBBrFYP0cHAcjrQq
 QCzDWHuw4EOSwFKxs/ICaxsy4Kj1pde2U+COyHWB8tZTCxPTF9cLYkkdVwIY90kdmWvIXyTQa
 wHxZZB8tslVIlbm6xNo6xxJTDw5JS92VwjPhzyC9B46gdM3bbUg0T+11+6jDmImBphnFv2pTq
 DbRH4lUmHLAdR5YfBaFSG/FPD5Kg2tvrM9cOJ9W6B0+W+VBTr8XC3xFCfTZFlHKLMk/8hajHR
 wnZijKjXuoo01Ag/DeoAVcwEMucli8vmprGfOhX5K3Jlzfub71bDCqDgAHac7Re5d9gx6t3uh
 b9emX9csvl04EzjBmFgPpv1zZ9W7Of0TH1Legq+a/llSazGNNn4vpVGGj4DxEqyS0mVb85C2M
 MA0m+YqAr8LRJxU1ObmHZa6B6LNdVriOInh2mwm8/kMDpiEhFpWnQsnvkxLzsOLAHMWjG2iPl
 5Q+/aHtoc+EKOz3B5fRpoc/DSAyfhn0jaG1p0DvV6KkHygbZwPrxJYblrgEn6ze6ILv/Hcafg
 tw6BbHRBM+yrNvwsL3TmoTvQ==

> When iio_get_acpi_device_name_and_data() fails, the ddata may be left
> uninitialised. Initialise it to NULL.

How do you think about to perform the variable assignment only in
a corresponding else branch?

Can it be that this adjustment does not really matter here because of
the following statement?

	if (!name)
		return -ENODEV;


Regards,
Markus

