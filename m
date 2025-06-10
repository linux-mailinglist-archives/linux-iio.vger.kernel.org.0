Return-Path: <linux-iio+bounces-20360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE48AD3981
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 15:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9799C359F
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 13:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5059223ABAC;
	Tue, 10 Jun 2025 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="o+EB4CWt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F21246BD2;
	Tue, 10 Jun 2025 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749562441; cv=none; b=QXXMbsgne9kma+KRccTcCA99y2LxzP9eij2ROuwYWzxuxVzSO8Kkdm2GNC9WpYgez4scdHqNgK3/gdAQB2lbx1YNJ6UrfKn4npwuoQBbtJf9tSxGrFrbsbend6pn5D3VYWYndYi0GqmrFOLL3XEeSaOiY7dY5aWBcwo8d9nsZl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749562441; c=relaxed/simple;
	bh=KaHtuz6Jy0j4QGrttxWUw2TvpREuQsqVMUivA5X6Z7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JmQsauaciEfnJJ2cG95Uq6D9snrgQ32aGSYiSdqOSYbkdSDEFV4XqSHQFGmUfexH1k1/mN1AQn5Xy+mSCDGep1MDayvRCZRnQHm1owJRhf7KxipHl9g+vp5sjWMJJaimWPTwm/Kni6hbwiG0TYTJq937yxLZqqTF+dAZzvLtxow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=o+EB4CWt; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ACLDDB012936;
	Tue, 10 Jun 2025 15:32:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	RCL3m+BGQL1ykNkUPx8ukHa4dw+bT4XFblDrGhiUwp8=; b=o+EB4CWtEwJNHNA9
	47yfz4pD6ymBIVNAWLkRok+DgsQK+ETE9yatSF56TkUXp7QWC9xcoRnEbM5oZzol
	FeICd0c9ZUAV/OaYvWb04+Hc2EMFNT6y/EpwYVs17+EfDSK5R0PoBKYxYal0x2LW
	biIWKpgGJ31RnbDqU335sMOajdTd0W3fa+r0EThHmxIuq4fD1oihi0GIUm8gOV4w
	nwNYupJp/Nnb2W+631HmNr4kJjExcBf4PGTd+aBZTCOOC8cAyf7yS08dL5ZWA5VI
	0Uc6UJeVeJhPmf9FfDLMHTsckifctfgc5tdR7LZT8Nvl0XfM4K2GYCWcE++zasF8
	T3sLqg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 474aumdg7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 15:32:32 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C7C7F40055;
	Tue, 10 Jun 2025 15:31:21 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5C13BB5D859;
	Tue, 10 Jun 2025 15:30:09 +0200 (CEST)
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Jun
 2025 15:30:08 +0200
Message-ID: <24110be7-2a42-4283-8ca6-1c9a2c96043b@foss.st.com>
Date: Tue, 10 Jun 2025 15:30:03 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] bus: stm32_firewall: Fix build warnings about
 export.h
To: Antonio Borneo <antonio.borneo@foss.st.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andy@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>, Lee Jones
	<lee@kernel.org>,
        <linux-iio@vger.kernel.org>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>
References: <20250610124855.269158-1-antonio.borneo@foss.st.com>
 <20250610124855.269158-2-antonio.borneo@foss.st.com>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <20250610124855.269158-2-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01

Hello Antonio,

On 6/10/25 14:48, Antonio Borneo wrote:
> After commit a934a57a42f6 ("scripts/misc-check: check missing #include
> <linux/export.h> when W=1") and commit 7d95680d64ac ("scripts/misc-check:
> check unnecessary #include <linux/export.h> when W=1") we get the build
> warning with W=1:
> 
> drivers/bus/stm32_firewall.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> 
> Fix it.
> 
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> ---
>   drivers/bus/stm32_firewall.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bus/stm32_firewall.c b/drivers/bus/stm32_firewall.c
> index 2fc9761dadecf..3ff5b5b6add45 100644
> --- a/drivers/bus/stm32_firewall.c
> +++ b/drivers/bus/stm32_firewall.c
> @@ -8,6 +8,7 @@
>   #include <linux/bus/stm32_firewall_device.h>
>   #include <linux/device.h>
>   #include <linux/err.h>
> +#include <linux/export.h>
>   #include <linux/init.h>
>   #include <linux/io.h>
>   #include <linux/kernel.h>

Thank you,

Acked-by: Gatien Chevallier <gatien.chevallier@foss.st.com>

BR,
Gatien

