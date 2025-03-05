Return-Path: <linux-iio+bounces-16410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29460A4FCB9
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 11:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB8467A23E3
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 10:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01FE214818;
	Wed,  5 Mar 2025 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="cdOFHZh9"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6F021577C;
	Wed,  5 Mar 2025 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171840; cv=none; b=b+NQfEti2orWdMknc2WEH6bQ2WMgDiSXX8O/+n8N/wsaH5wIAnQ++M34oa18AR2mmGi3FMNJ6GByiod8ZT4KdhQhCq+qNCx3lNm5lhK5iztAHHQxjO3pJgpN+4KyjslmS+JnYKUiVm51Ov9FfEtQA5bnLV3fQFg80GXkeVkdWAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171840; c=relaxed/simple;
	bh=y6IQTm/wFI3JULHY3gyjeTxFRdN7WOA8P4kaewwA7HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O58LA6yY8+u2xiDcN3mnGwV9GTpjr45migxzfyD4ZGgzNvwFwom0oOOGfvd2LF0LVFauo7SHdepkMT4/NeoDDu+qVp2cLDZ2rHXv9AikhJFqkDzgSiJryWrYfYVQWt51YJ0WJnS15vi6cBfMyvt6Q8vcQCW72dbfWNPqkj1oLx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=cdOFHZh9; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 6033EA0A17;
	Wed,  5 Mar 2025 11:50:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=T7un43lbel7mKoax4H54
	SGCUpO7TSRceePp36dvszoA=; b=cdOFHZh99rGVM1sM8QuDv5R3kyaOh7HarjnF
	2Uk3GvTuA6nMgAvWverUak1vcWMlNSQuVoat5zyNOWSIY/aLVLWJYgLrf0wiMZeK
	R+FMUq+YoLHkRsRmpZF8qMgDcQ0W20fxzkOedgvKH3Pgubfm0sQaE8reTq1ZaFRd
	HLsiF00eoatIpkjREbC+xM7EIFZsSlSKyEYE5ri0dhyxL1QmRCEQRlzi5/yArL0y
	03Q0aXQqCBPW5pXT8T1uwrpztTZC8g8+tRBGAg8Xh2ABH3duLXPWW2VbD/ZE8Dar
	gE73ZZEPWU7yEjTGMcgxruJj7rUDqzLTP4i1EqnT72MdMb68mXcjYrRg7pUOO2f8
	ETByJwjviTWH/P0EsFCM/NSuyk+bdwuxQ9ZaFy9LCLTGB5rMGHl0WZpzWbIGOC0o
	4LUillFcFmL3nE/mZtRkXpEd+SLzBSEqVWXxXqmUa44OyGW3t+Q5roexu8Y8Bhul
	K1jZ1e+NrlxBsK3miDLoBtAUy3f5Lu/Pt0PzZ/2mjax4zpaLUBIGxJW4XJsuKyWu
	BrxhY5CgZ79SUlhZG+3wZNefo/j/bmiIhosSIa0u1twFf/t+pznyhXuxmTp7YH/7
	KXmRSa2wizhO/r1lUXcO615G32hiQK4wTbY1T79Sp4lXi9TivMGzgBDvQxv7J5vW
	Qu6SEeE=
Message-ID: <93ce1511-53f6-42a3-b1a5-b6732105e87d@prolan.hu>
Date: Wed, 5 Mar 2025 11:50:27 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] counter: microchip-tcb-capture: Fix undefined counter
 channel state on probe
To: William Breathitt Gray <wbg@kernel.org>, Kamel Bouhara
	<kamel.bouhara@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250305-preset-capture-mode-microchip-tcb-capture-v1-1-632c95c6421e@kernel.org>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20250305-preset-capture-mode-microchip-tcb-capture-v1-1-632c95c6421e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852637D66

Hi,

thanks for fixing this up!

On 2025. 03. 05. 11:01, William Breathitt Gray wrote:
> Hardware initialize of the timer counter channel does not occur on probe
> thus leaving the Count in an undefined state until the first
> function_write() callback is executed. Fix this by performing the proper
> hardware initialization during probe.
> 
> Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
> Reported-by: Csókás Bence <csokas.bence@prolan.hu>
> Closes: https://lore.kernel.org/all/bfa70e78-3cc3-4295-820b-3925c26135cb@prolan.hu/
> Signed-off-by: William Breathitt Gray <wbg@kernel.org>
> ---
> This should fix the issue where a user needs to set the count function
> before they can use the counter. I don't have this hardware in person,
> so please test this patch and let me know whether it works for you.
> ---
>   drivers/counter/microchip-tcb-capture.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
> index 2f096a5b973d18edf5de5a2b33f2f72571deefb7..c391ac38b990939c6764a9120a4bd03289f68469 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -368,6 +368,25 @@ static int mchp_tc_probe(struct platform_device *pdev)
>   			channel);
>   	}
>   
> +	/* Disable Quadrature Decoder and position measure */
> +	ret = regmap_update_bits(regmap, ATMEL_TC_BMR, ATMEL_TC_QDEN | ATMEL_TC_POSEN, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Setup the period capture mode */
> +	ret = regmap_update_bits(regmap, ATMEL_TC_REG(priv->channel[0], CMR),
> +				 ATMEL_TC_WAVE | ATMEL_TC_ABETRG | ATMEL_TC_CMR_MASK |
> +				 ATMEL_TC_TCCLKS,
> +				 ATMEL_TC_CMR_MASK);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable clock and trigger counter */
> +	ret = regmap_write(regmap, ATMEL_TC_REG(priv->channel[0], CCR),
> +			   ATMEL_TC_CLKEN | ATMEL_TC_SWTRG);
> +	if (ret)
> +		return ret;
> +

This duplicates a lot of `mchp_tc_count_function_write()`. I'd much 
rather have this code in a separate function called something like 
`mchp_tc_setup_channels()`, that, depending on `priv->qdec_mode`, sets 
up the BMR, CCR and CMRs, and then have both probe() and 
function_write() call it. Or alternatively, have probe() call 
function_write() at the end, but that's not as nice.

> ---
> base-commit: 8744dcd4fc7800de2eb9369410470bb2930d4c14
> change-id: 20250305-preset-capture-mode-microchip-tcb-capture-fa31550ef594
> 
> Best regards,

Bence


