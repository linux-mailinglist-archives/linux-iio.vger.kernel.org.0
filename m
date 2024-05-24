Return-Path: <linux-iio+bounces-5269-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 119B58CE6C3
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 16:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E945B21BE9
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 14:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0329612C47E;
	Fri, 24 May 2024 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a26KhZTH"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BCA12C52E;
	Fri, 24 May 2024 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560081; cv=none; b=H624D163D3I58NlltNaV0HqQtCFj3mt7IL4KT37pByVt/6vVR/TK2vTsyjb2N4svoOeRBzSXsDSKIryp+ELwpCBQV9zp1VWemWxRCvYrZrDT6p0XhKdmapaBDpmDT8FtKVLGc6rEU6YP1G8CS9JM8X1ILkPRPuQouznM1TwXKsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560081; c=relaxed/simple;
	bh=/iCSwYFpPpnWKrk7OTbEJ2X5LrFGQnqRxn/p12z43c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NiLG12Zy+TDk75DZ4DuXVrLaAeRsf7Yx1okDL7569ldWxC0mKW7kw7Sa4DzwqLmERMKqRoq/3lrkYYldROL2iLIacLmWUHgVDeVN13VgBbXxw35npMl2cZGIFqFfFtocJK/c0GYQG72cgGa76n1pUic+e8NfxARCVG140O0803M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a26KhZTH; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44OEDgwW096179;
	Fri, 24 May 2024 09:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716560022;
	bh=JI2PXYUUtgJy4L/iAwhj/g1y9I44a0am6XbwNhHJQ7o=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=a26KhZTHL5qHOOYNEiH75TcYqpvWhZfY3PB+h1CC6ppZ1Fjxna4Yr5bfB8LWN0CHG
	 aU+dNUzlXKNaehwkFkmhfG12qbK2R6CzjmwSNa/Rt5e+EspHOH7WgRNW7DXH3gj+ZB
	 X+Lf6ivw1XPD4dmi0h8BDbtFE6uy1rpwTA9bajbc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44OEDgn5026390
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 09:13:42 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 09:13:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 09:13:41 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44OEDfjc067963;
	Fri, 24 May 2024 09:13:41 -0500
Message-ID: <ddcab8c0-3772-4134-a3bb-27729e864627@ti.com>
Date: Fri, 24 May 2024 09:13:41 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] arm64: defconfig: Enable TI eQEP Driver
To: Nishanth Menon <nm@ti.com>
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
References: <20240523231516.545085-1-jm@ti.com>
 <20240523231516.545085-9-jm@ti.com>
 <20240524055923.zyfthiwcsbwbjg5k@undecided>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240524055923.zyfthiwcsbwbjg5k@undecided>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nishanth,

On 5/24/24 12:59 AM, Nishanth Menon wrote:
> On 18:15-20240523, Judith Mendez wrote:
>> TI K3 SoC's support eQEP hardware, so enable TI eQEP driver
>> to be built as a module.
> 
> All the nodes seem to be only in disabled mode, is there even a single
> board that is actually using this? if so, why isn't it enabled?

I will add pinmux and enable in the board level dts file.

~ Judith

> 
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>> Changes since v1:
>> - No change
>> ---
>>   arch/arm64/configs/defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 2c30d617e1802..23d11a1b20195 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -1593,6 +1593,7 @@ CONFIG_INTERCONNECT_QCOM_SM8550=y
>>   CONFIG_INTERCONNECT_QCOM_SM8650=y
>>   CONFIG_INTERCONNECT_QCOM_X1E80100=y
>>   CONFIG_COUNTER=m
>> +CONFIG_TI_EQEP=m
>>   CONFIG_RZ_MTU3_CNT=m
>>   CONFIG_HTE=y
>>   CONFIG_HTE_TEGRA194=y
>> -- 
>> 2.45.1
>>
> 


