Return-Path: <linux-iio+bounces-10033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE0898EE9F
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 13:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6706B23F15
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 11:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B5D156F2B;
	Thu,  3 Oct 2024 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="sP1xdodL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00176a03.pphosted.com (mx0a-00176a03.pphosted.com [67.231.149.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548A1154458;
	Thu,  3 Oct 2024 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956637; cv=none; b=ODM06436stMLC++5JT4OxVp1wknBgO7K4q/Cf5kuDePwpRsu/TwX8q3+DJ/bjuAMvGkZ1xWeyYY4/lyOWzgPmoGHDKFCW0g8OsbwofFKLmEIhke+CpIZmESLkMwVTBRlf6Dq84gnLIeyZQUy1/HuxplvpKF6mTeUMDDO9Lkc3pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956637; c=relaxed/simple;
	bh=kSsKT4Ts0zz1Pb5ziwbIfRAB3TG9JtXKyP/RgjKGvG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhEuDKIYAlvsY4VWwqwG/OCRuhiqiFkAm5j3tvORYGQd+HoF7gfcam6G7lDckadL3MtAG4ngNau7gBaGLgtps/K5Gek4LTRA7pUnQTLqT7Rtysl2ogG6bMEBcEeF+SlrGN1Bieqa+l/Mr9MFYoJYI1/dXXcAhUOYIx9zshQ53CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=sP1xdodL; arc=none smtp.client-ip=67.231.149.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
Received: from pps.filterd (m0048275.ppops.net [127.0.0.1])
	by m0048275.ppops.net-00176a03. (8.18.1.2/8.18.1.2) with ESMTP id 493BkPY2045080;
	Thu, 3 Oct 2024 07:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	gehealthcare.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=outbound; bh=P
	Ve91XkqXFVeRh2L7sQ6UYeiIxmc1JrvQ2vvN/kkfSc=; b=sP1xdodLKZadXU4eQ
	9ZtDYpLJLp0yyzAQq6zK8kWx9IPmIhYiOOL4kG1mE869b283hbC1lmQAGb79xC3+
	sGUpXFULNrZWva5+TpLCw4VEY21b7Gp90HMbca5DztY7N7LMULMHGPkyxb4TyMdo
	iDiAFGYakkVDRy/fpbJpfAgQrVmiNDf8ejfyXoUwU303X8uujH/EEmiqh6LkxNna
	f5wM1WMSPbDVcqNvHCcy/R3XO/DB7yxhesIq8J3gtgtH83iinr6Sp8xXaR9ghd8h
	ynczttJa5J4UYNZxS7WlPeB2wCsWqAtyzAaUJK+KRaNNLFY07JJrxFcbasR7EM+K
	a0Ltg==
Date: Thu, 3 Oct 2024 14:56:57 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 4/4] MAINTAINERS: add the GE HealthCare PMC ADC driver
 entry
Message-ID: <Zv6GifDRLZ_-wfZ7@852ed68de471>
References: <20241003114641.672086-1-herve.codina@bootlin.com>
 <20241003114641.672086-5-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003114641.672086-5-herve.codina@bootlin.com>
X-Proofpoint-ORIG-GUID: Mm8jjpvb0LM9eZRZf8KL0ndKsp7jVJ__
X-Proofpoint-GUID: Mm8jjpvb0LM9eZRZf8KL0ndKsp7jVJ__
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=941 phishscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410030087

On Thu, Oct 03, 2024 at 01:46:41PM +0200, Herve Codina wrote:
> 
> After contributing the driver, add myself as the maintainer for the
> GE HealthCare PCM ADC IIO driver.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Tested-by: Ian Ray <ian.ray@gehealthcare.com>

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bd288a97c770..6cccbe4e3d72 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9459,6 +9459,14 @@ M:       Kieran Bingham <kbingham@kernel.org>
>  S:     Supported
>  F:     scripts/gdb/
> 
> +GE HEALTHCARE PMC ADC DRIVER
> +M:     Herve Codina <herve.codina@bootlin.com>
> +L:     linux-iio@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/iio/adc/gehc,pmc-adc.yaml
> +F:     drivers/iio/adc/gehc-pmc-adc.c
> +F:     include/dt-bindings/iio/adc/gehc,pmc-adc.h
> +
>  GEMINI CRYPTO DRIVER
>  M:     Corentin Labbe <clabbe@baylibre.com>
>  L:     linux-crypto@vger.kernel.org
> --
> 2.46.1
> 
> 

