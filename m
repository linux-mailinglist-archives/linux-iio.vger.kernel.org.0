Return-Path: <linux-iio+bounces-25697-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8A2C2192A
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 18:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20631AA00CD
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 17:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7387E36C252;
	Thu, 30 Oct 2025 17:55:17 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E8A365D39;
	Thu, 30 Oct 2025 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846917; cv=none; b=evVs4EhEBkjaQBrVMaRJbOrtO//nqCgT6BuW69f3Fdw8URtke/1t0z+7Pb4R5pYmudPou79783tUBiqIVUjblCRlIsppFKOBqDAK56+diwjzSa9zPtAWML6mAAQOqB7qwmJAcXw7dP8VFzR7dd3PJDuFCdm6UEiVgzWwRGKwSXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846917; c=relaxed/simple;
	bh=n03Kkd8B9lkuPGGTD2/aS2js141OYFeGO2LxnTibEvA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W88UfAWvKnxTXS66if50YtNJ36Wx0ZNYcVLNzCCuzatAsM7n5B82VbnIxd00UvXsaFJ/ON5Q/a8GBYmD+W8Sgqc7SVgdDfdpF7Q/fm3rgM1CpcOeOHseSwB02RKuLUnHkUfT29QO26bdKggI6oAw3B0xMqzvheVCryiQ3lI1rD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cyBVw1ddfz6M4qj;
	Fri, 31 Oct 2025 01:51:20 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id C480F140370;
	Fri, 31 Oct 2025 01:55:12 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 17:55:12 +0000
Date: Thu, 30 Oct 2025 17:55:10 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ajith Anandhan <ajithanandhan0406@gmail.com>
CC: <linux-iio@vger.kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/3] MAINTAINERS: Add entry for TI ADS1120 ADC
 driver
Message-ID: <20251030175510.00005af8@huawei.com>
In-Reply-To: <20251030163411.236672-4-ajithanandhan0406@gmail.com>
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
	<20251030163411.236672-4-ajithanandhan0406@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 30 Oct 2025 22:04:11 +0530
Ajith Anandhan <ajithanandhan0406@gmail.com> wrote:

> Add a new MAINTAINERS entry for the Texas Instruments ADS1120
> ADC driver and its device tree binding.
blank line before tag block.
> Signed-off-by: Ajith Anandhan <ajithanandhan0406@gmail.com>

Just bring this in along with the code, it doesn't need a separate
commit.

Thanks,

Jonathan
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3da2c26a7..1efe88fc9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25613,6 +25613,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
>  F:	drivers/iio/adc/ti-ads1119.c
>  
> +TI ADS1120 ADC DRIVER
> +M:	Ajith Anandhan <ajithanandhan0406@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
> +F:	drivers/iio/adc/ti-ads1120.c
> +
>  TI ADS7924 ADC DRIVER
>  M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
>  L:	linux-iio@vger.kernel.org


