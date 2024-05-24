Return-Path: <linux-iio+bounces-5246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001C18CE0D9
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 08:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00AB282D86
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 06:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD848062B;
	Fri, 24 May 2024 06:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HPP8AMFv"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAD2171C2;
	Fri, 24 May 2024 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716530431; cv=none; b=OU8EQkaYVYKFK7tWxXwzJuKjfxr7xd7M5KJoKOqAqL1hRZNHXYt3XWvHgAYeOZsBu5q7f1ui3+fAZ1kxKgSIaKPMSfX0ipGeTHRKjzhhPnJN13fFjr5A+NhYVlzmCykErf7URmiPIkSR+SiszW982ypkY13ESCxJUkBlyMMOTEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716530431; c=relaxed/simple;
	bh=h3DPcH3nqszTSQLImkPREVGYC10eSHYvLxBFTuJQemk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTIxR1RXBJu9fWgUObqvY9A1sohdRZ/DoO+2sGF9fA4fDxxX/S8kkkoBFctXS11I/G90fy25aiKoMqrrHUET8LflobFGDP4sAGDtRsG2sv/g4sJp/DAhiLZZESGxuY0ZT16w5z9UW0jnSC37q80XOWtFoSeCIVvz10pPyxOAMgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HPP8AMFv; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O5xO9A107299;
	Fri, 24 May 2024 00:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716530364;
	bh=iQC/0BEZNrJ1lheHo6uC05vFCh09I+f8KhdjFHCuPdU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=HPP8AMFvVTROUnKrLUVcDjy+5UmyJkR6lrMROTtB0tnwSUdyHiZd2FRF16mt0/5sl
	 WA57aVfNoHeP5X/XNkTA3Rb6MKGKWtjEy83l4tndsXbbu1fExKLyU05uTm9E/y/EHw
	 Y30QusD+1+HXepOtNiLltuEETDKdplIt6Ouml/C0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O5xOhj019892
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 00:59:24 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 00:59:23 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 00:59:23 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O5xN6i107587;
	Fri, 24 May 2024 00:59:23 -0500
Date: Fri, 24 May 2024 00:59:23 -0500
From: Nishanth Menon <nm@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        David Lechner
	<david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2 8/8] arm64: defconfig: Enable TI eQEP Driver
Message-ID: <20240524055923.zyfthiwcsbwbjg5k@undecided>
References: <20240523231516.545085-1-jm@ti.com>
 <20240523231516.545085-9-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240523231516.545085-9-jm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 18:15-20240523, Judith Mendez wrote:
> TI K3 SoC's support eQEP hardware, so enable TI eQEP driver
> to be built as a module.

All the nodes seem to be only in disabled mode, is there even a single
board that is actually using this? if so, why isn't it enabled?

> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
> Changes since v1:
> - No change
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 2c30d617e1802..23d11a1b20195 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1593,6 +1593,7 @@ CONFIG_INTERCONNECT_QCOM_SM8550=y
>  CONFIG_INTERCONNECT_QCOM_SM8650=y
>  CONFIG_INTERCONNECT_QCOM_X1E80100=y
>  CONFIG_COUNTER=m
> +CONFIG_TI_EQEP=m
>  CONFIG_RZ_MTU3_CNT=m
>  CONFIG_HTE=y
>  CONFIG_HTE_TEGRA194=y
> -- 
> 2.45.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

