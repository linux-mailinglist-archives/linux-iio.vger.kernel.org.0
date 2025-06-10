Return-Path: <linux-iio+bounces-20355-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6015AD38E7
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 15:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0243BFA45
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 13:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A662BEC2E;
	Tue, 10 Jun 2025 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="UEMuYlp+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD54C29A31B;
	Tue, 10 Jun 2025 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560859; cv=none; b=t4x56pGt5tlt2heGBWy1t0bDCAFoYmmssq//8ic6tfcwuh+puph9u0/DOUULd2iRluKMgiTuCIr3qzcqbbo28fL6BzdTZVf/NlmQjZ+wAMMDVlKhxpNqEp341svPmOR5HHdyd2FC9vm8iFTcKd4yhhzaskgKMfF2LnGEFJc18tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560859; c=relaxed/simple;
	bh=ONQ20WSo2iLU/YthpeVb/ES8q9AMIB38pz3ZihJVZaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MXL0Dp6MbB/TbLMKOhBQt3KloPE9tM9Scn/xbH9IASdnHNnXEiUK3xsCgHJdPi/8aBBrFUEJBVsagDzAivOrJ+Vnk6Cz3wMrmnJPefmW4JUMrd8V/+4RFja8Kk37hibPjZJsKQjRidcu+h6IOod3pQqrjIWexdUWXMcwqv4zFIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=UEMuYlp+; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ACLEST010654;
	Tue, 10 Jun 2025 15:07:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	DtcBme5y82g1iX3JOWuW4cw1f7KDTGODNU0eHjTQyxs=; b=UEMuYlp+93bahNMn
	MIPEMHsPeA1qE9MAnJVpzOb9L6y1jcKGkJRIzeUhyIcWCXgxVS81Vh5aEQJPXxuH
	Jj9K5EL4abjAOGE33hiromZtvvEeKVAAGTk/732gEiptuZk+oBcqUs3Ee7M2twcV
	jHSyl3ounjWxF8mAS5BCbFAzqE91D/cIB6RkW4+NgHjZeCemBnVGJHXs7L4SowGR
	0wB4sPOsWNkXz1do8iVYMEC+Iz7GBJFlb4NUfPhEpgDxXCWCl9z+1/r0+CO1huAV
	auZT0R/v1tx8dpTWgWWRH5UNIunT1KXKBrZYJ0CpOlCRQ0qubfP1zULSBqRWsX3L
	Tkqpcg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 474y052mmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 15:07:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id F11A140051;
	Tue, 10 Jun 2025 15:06:13 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A93B4B3141F;
	Tue, 10 Jun 2025 15:05:18 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Jun
 2025 15:05:18 +0200
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Jun
 2025 15:05:17 +0200
Message-ID: <7600b151-0487-4cb9-ab6e-3cc9c6012bdf@foss.st.com>
Date: Tue, 10 Jun 2025 15:05:16 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] iio: adc: stm32-dfsdm: Fix build warnings about
 export.h
To: Antonio Borneo <antonio.borneo@foss.st.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andy@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Gatien Chevallier
	<gatien.chevallier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>, "Lee
 Jones" <lee@kernel.org>,
        <linux-iio@vger.kernel.org>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>
References: <20250610124855.269158-1-antonio.borneo@foss.st.com>
 <20250610124855.269158-3-antonio.borneo@foss.st.com>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20250610124855.269158-3-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01

On 6/10/25 14:48, Antonio Borneo wrote:
> After commit a934a57a42f6 ("scripts/misc-check: check missing #include
> <linux/export.h> when W=1") and commit 7d95680d64ac ("scripts/misc-check:
> check unnecessary #include <linux/export.h> when W=1") we get the build
> warnings with W=1:
> 
> drivers/iio/adc/stm32-dfsdm-adc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> drivers/iio/adc/stm32-dfsdm-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> 
> Fix them.
> 
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>

Hi Antonio,

You can add my:
Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Fabrice
> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c  | 1 +
>  drivers/iio/adc/stm32-dfsdm-core.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index f583924eb16bb..c2d21eecafe79 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/export.h>
>  #include <linux/iio/adc/stm32-dfsdm-adc.h>
>  #include <linux/iio/backend.h>
>  #include <linux/iio/buffer.h>
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index 041dc9ebc0482..47e2d1338e9e6 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
> +#include <linux/export.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/interrupt.h>

