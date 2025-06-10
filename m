Return-Path: <linux-iio+bounces-20357-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C145AD38B8
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 15:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E514C1896714
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 13:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923342C030D;
	Tue, 10 Jun 2025 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Ah5qJO47"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C3C2BEC4E;
	Tue, 10 Jun 2025 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560869; cv=none; b=hJQX8yC19DrIcIHltIh56LxvsnOyz8xZEeLxKplLmA4kprC+F8uImDZAaHO1CHSpyO+6NXx+JPFE0Q5h83fhOwaxJYLShJnVclJidDQFeeKbHBU5u/ibr/DhwXGLC/UhFTfA2LSYuDZOqXOIkaajHATyX4cNLE+2HvimMXIOmXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560869; c=relaxed/simple;
	bh=+Of5yhWqkazrxAEo95fHpiZ/Z1ilypVHO1CygTEP3kE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=muTGCT7Lfw7OMddahqIvdnZPhgZKozGK7jDe47GYqzJLcDl3VHs6W4sxZEJqxOTV4BWdLjScraN+Xy69f5wJ4ruWzQlDM8dtqwrE8nLaqvw75mk5BU8iIF3Q/6qfOQN+jfMkpLSJq+ma+rfNR4NV7fKLOkDVFV84/jsP+3UZUgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Ah5qJO47; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ACLHgj028206;
	Tue, 10 Jun 2025 15:07:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	QSgipYKqp0kOgt1O9r0wM8rI8E4qQZhum6IEt85BDZo=; b=Ah5qJO47IrhpAkLC
	lMyoCnO4m8wU3iebWoCbw5p102hb7BBpdzBTwkaKJTrIBDS0IjZerdkJre8c+a8W
	kxLmRrLj6BWw0i3+QUod7iBd7glJkumZnLz07sgxuraasFldoGu6pe7qLMxHmxG9
	4+3EUeXbqCMeJqxU8paAxEj1rsw4F6A7kK/5qW+V2n3QFmnu3oLuQYFJtzfhrdju
	L3uI+1A1acN4XTtkeNkRYbVb8uS/BloauMkgqZbOY17ieZiOepLKrEL2rmaLMsO8
	N9GAIo4NXZvKQPqebAdGK4cieNqRNFPMML8kVGdRNzmPh0J63Tk+yeQERrFO74u2
	o33gMg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 474cs2n23s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 15:07:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E566A4002D;
	Tue, 10 Jun 2025 15:06:33 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5AA8AAE5347;
	Tue, 10 Jun 2025 15:05:52 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Jun
 2025 15:05:52 +0200
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Jun
 2025 15:05:51 +0200
Message-ID: <ccde5e45-9541-499f-b248-08cd6fad9a19@foss.st.com>
Date: Tue, 10 Jun 2025 15:05:50 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] iio: trigger: stm32-lptimer: Fix build warnings about
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
 <20250610124855.269158-5-antonio.borneo@foss.st.com>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20250610124855.269158-5-antonio.borneo@foss.st.com>
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
> drivers/iio/trigger/stm32-lptimer-trigger.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
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
>  drivers/iio/trigger/stm32-lptimer-trigger.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/trigger/stm32-lptimer-trigger.c b/drivers/iio/trigger/stm32-lptimer-trigger.c
> index 2505ace440b46..c7bab18221c70 100644
> --- a/drivers/iio/trigger/stm32-lptimer-trigger.c
> +++ b/drivers/iio/trigger/stm32-lptimer-trigger.c
> @@ -9,6 +9,7 @@
>   * Inspired by Benjamin Gaignard's stm32-timer-trigger driver
>   */
>  
> +#include <linux/export.h>
>  #include <linux/iio/timer/stm32-lptim-trigger.h>
>  #include <linux/mfd/stm32-lptimer.h>
>  #include <linux/mod_devicetable.h>

