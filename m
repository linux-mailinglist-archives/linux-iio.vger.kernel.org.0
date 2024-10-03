Return-Path: <linux-iio+bounces-10031-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 770CF98EE92
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 13:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B5D1C2120F
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 11:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE783155757;
	Thu,  3 Oct 2024 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="RTpFfyLy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00176a03.pphosted.com (mx0a-00176a03.pphosted.com [67.231.149.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230DB1B969;
	Thu,  3 Oct 2024 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956584; cv=none; b=WqWwldnR3r5yAvW55BgRUaux/iS31B2rB5zrrr5d0f1KyTgjPy8cF3d7Qvp2sX6fTDgd0tE+u/3ZhQ/ryVEVpFaMS/ky0uN3l3nWDYG6GBd3Dvbv37LMemnTfJj7a0nVLUp7tYrRmk79cypLcfX2p/ebra+DUTLxJVKRLjbDF5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956584; c=relaxed/simple;
	bh=qvJ4aMTs7hQDseC6W2nGcltdqn3q1yo9I6eIkdcMw6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEM/0PV/2OXSCd6NmE19tv6pSg+AL7pMUAig+c0VSFW3uyu2Oy6tZx51B/CEfolYJuicwfScSJ00W1Gb+1hBvTC6jm+xJWGvweobdYav6HPlB1Rcr/gPV360LbC7CZ38pm2snPmA8B8ANpDhOZx8xkloJpGltbJBTjc9YdhDoz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=RTpFfyLy; arc=none smtp.client-ip=67.231.149.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
Received: from pps.filterd (m0047963.ppops.net [127.0.0.1])
	by m0047963.ppops.net-00176a03. (8.18.1.2/8.18.1.2) with ESMTP id 493AvQ1E043314;
	Thu, 3 Oct 2024 07:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	gehealthcare.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=outbound; bh=a
	XIor8SRr/MI6vJWWph9qTeA4bGfuSCP+EK7NLdxfD4=; b=RTpFfyLyEfCWFv67s
	R3LM8WHkefN+i6vdkb4iirKxX/hsbelYNpya7ENLyLhpNNp4L9WLe/dg1SbD2o6Y
	2e175LwFxy9KoPY5DxYQUj3F8FMub47sl4guir/2bxok9dRYR0NA8xfHBK9QiguQ
	4QsAV1Jc/7yopG+X8CYXzmSntm+pab+6b1sv9XsHmhVU4vjnl0p08wpSguPY98cj
	9thg2pCulKJOZaluM/Jv1jKlzWIZL47oS3103LVyVRyHdMUMclEIvEfSDie6vUra
	7tiritQVFinccP1U1pDtzo7I5IaZsv31nxyHKNhZnRBnlS6CGEsFQRGSmd1cCks6
	czQdA==
Date: Thu, 3 Oct 2024 14:55:54 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add an entry for GE
 HealthCare
Message-ID: <Zv6GSiK6ojqdI7eF@852ed68de471>
References: <20241003114641.672086-1-herve.codina@bootlin.com>
 <20241003114641.672086-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003114641.672086-2-herve.codina@bootlin.com>
X-Proofpoint-GUID: 2-njoepT9RFrh2eB8RUiVX1YslxUqiKx
X-Proofpoint-ORIG-GUID: 2-njoepT9RFrh2eB8RUiVX1YslxUqiKx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=828 lowpriorityscore=0 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410030087

On Thu, Oct 03, 2024 at 01:46:38PM +0200, Herve Codina wrote:
> 
> WARNING: This email originated from outside of GE HealthCare. Please validate the sender's email address before clicking on links or attachments as they may not be safe.
> 
> Add the "gehc" entry for GE HealthCare.
> https://www.gehealthcare.com
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Tested-by: Ian Ray <ian.ray@gehealthcare.com>

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index b320a39de7fe..15877574a417 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -561,6 +561,8 @@ patternProperties:
>      description: GE Fanuc Intelligent Platforms Embedded Systems, Inc.
>    "^GEFanuc,.*":
>      description: GE Fanuc Intelligent Platforms Embedded Systems, Inc.
> +  "^gehc,.*":
> +    description: GE HealthCare
>    "^gemei,.*":
>      description: Gemei Digital Technology Co., Ltd.
>    "^gemtek,.*":
> --
> 2.46.1
> 
> 

