Return-Path: <linux-iio+bounces-20358-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BE7AD38FD
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 15:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5BDA20CF2
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 13:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F5B2C3768;
	Tue, 10 Jun 2025 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ngrdcVOc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB1E29A33F;
	Tue, 10 Jun 2025 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560890; cv=none; b=uQUTr7t2YItjipoyGlbRhEOGdSip0NdYRyvr8KdfJevKp6TcZTtA5Y+4wBMjLu6gkB4qZYpVQgXCVHnRaCQOtSc4jbFE/eMzfwus59Z4tQ1+IgaKkj/T+lZxLxmVpLR39diENA7QQJ7Gm0sbDHHXPnVekLF36KrgRC7hT0qa8Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560890; c=relaxed/simple;
	bh=6sZzQJep3auti0AOv+a5fgqhhkPTzy2KMG1ZbXcuoKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dEP9uvAYTWor4UzB3cTUNvSE3XMefId7spxJJe+yD6OTM0UeCQzi0xikixu9fzxhRcm5awmguqDC8tnDgKGh5uiWd2H3wjDycA7AwOAJ91rRiol/E9PVLsRvNKAjl/rfp3h1PXauouNBLwbax8dhwC6bmka0f772Cz0bbvf7JVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ngrdcVOc; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ACLKIb000488;
	Tue, 10 Jun 2025 15:07:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	mCaZx9gJ+o3Q94P6ZYIvia/cHH4I4d89mREiVwWUrpM=; b=ngrdcVOc68Hp75Pu
	+jEX2wmlvTg2ujcw/Zr8WDxPRt6nV6WfaoUS0QDY9k7Xlf3fLKPutBi3yrXZJsz4
	ZAn375f4uVFmhk4AJy72NgWyVaBwaaIhZaqgOrb4DQwfK81OeX8mNNPc7jTJ5RGu
	XzMi86tzlDEpDtbE15JPr1ayK3pIpOIg/LyV0s+XTsVtlc15bxENm+za6CPnFZme
	hm2T2SH+F8O39zOBcfqGeu9sUYKX4G5ZNGZj7IGaLtWlhqOTEYIp3aTBqxX6rcmB
	b6LYMPJsb+oGNIQBmIp1c6hQFVgMohQ0FOYmjxJsh5zxF4rbLK9yVJ4Nqyz2RsyB
	AqhVNA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4750cnsxrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 15:07:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1F9554004B;
	Tue, 10 Jun 2025 15:06:49 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B46C1B525F3;
	Tue, 10 Jun 2025 15:06:07 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Jun
 2025 15:06:07 +0200
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Jun
 2025 15:06:06 +0200
Message-ID: <afda753a-47b2-417d-82a1-b166fc601f8f@foss.st.com>
Date: Tue, 10 Jun 2025 15:06:06 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] mfd: stm32-timers: Fix build warnings about export.h
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
 <20250610124855.269158-6-antonio.borneo@foss.st.com>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20250610124855.269158-6-antonio.borneo@foss.st.com>
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
> warning with W=1:
> 
> drivers/mfd/stm32-timers.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> 
> Fix it.
> 
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>

Hi Antonio,

You can add my:
Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Fabrice

> ---
>  drivers/mfd/stm32-timers.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
> index e3c116ee4034a..b3dbc02aaf798 100644
> --- a/drivers/mfd/stm32-timers.c
> +++ b/drivers/mfd/stm32-timers.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/export.h>
>  #include <linux/mfd/stm32-timers.h>
>  #include <linux/module.h>
>  #include <linux/of_platform.h>

