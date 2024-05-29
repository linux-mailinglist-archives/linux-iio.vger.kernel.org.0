Return-Path: <linux-iio+bounces-5466-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C2F8D3D55
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 19:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 105A9B23B69
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 17:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600101A0B1F;
	Wed, 29 May 2024 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jY3e22WL"
X-Original-To: linux-iio@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C75C19DF78;
	Wed, 29 May 2024 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717003249; cv=none; b=PdHxrUkD4Iz1zp9A7cD5jx7sEMiVb25/HkpG/a+cYpy4dJmecW52G5XiFhuICwT5CqA8jUCzmlzl2a3N1SqH7pJU/VFUfLB+iV6YtIiR/Hp1kA//qAKwU1cOQxGQkvciqFIEd4vAlo1ViGvAhErruEwTbk2kmTdohTVQBgx7ZBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717003249; c=relaxed/simple;
	bh=6op9aP1HVmzyG+C85+rhjJ60b1XUCq/6cWTD4G15NhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VIwgB1PnSS7HsfY4AsLpVZFAWGg4fjn3lFemq4mgVz07JJqMJiijjpNtHb4ckZWjCYeCs4Qfuwd9Ytcs5MI0IWHpuLKOkw3Lor52jyLxwQtzZDtDqZO9fTnEVO/QAHKK1s0LvrMOje7mj3SdpDkqz9J+HJXynF57l+Zo/rfihkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jY3e22WL; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44THJogj124014;
	Wed, 29 May 2024 12:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717003190;
	bh=AuBUGle0djl+XDtipQHjTVnybdvyAQCUf4F3ToP1+yQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=jY3e22WLdWpR2oXGbMwsRofdEsP9no/g8KcXqdVoLjjlu8yqxDN03cUEM7Ifl+sms
	 qtfpOAPfjAZg0a4L8ZcoyCOgiO2IhSFi5fpmMaVihjzCRAlvAoby5HTfMCQabZ9C/T
	 r1vpjg7H0pKJm/XDRRyxSF1SvMz1qlsFVGUNvp/w=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44THJoWj089849
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 May 2024 12:19:50 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 12:19:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 12:19:50 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44THJnHg116710;
	Wed, 29 May 2024 12:19:49 -0500
Message-ID: <c2c58229-8623-4765-90ab-9cbc6964ca85@ti.com>
Date: Wed, 29 May 2024 12:19:49 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: counter: Add new ti,am62-eqep
 compatible
To: Conor Dooley <conor@kernel.org>
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
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
References: <20240523231516.545085-1-jm@ti.com>
 <20240523231516.545085-3-jm@ti.com>
 <20240524-wrecker-busybody-2c082b87ddef@spud>
 <57e4f7b1-2955-4dd5-b9d9-f3b1f27aab75@ti.com>
 <20240525-tall-cultural-1a3f181d39ac@spud>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240525-tall-cultural-1a3f181d39ac@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Conor,

On 5/25/24 10:23 AM, Conor Dooley wrote:
> On Fri, May 24, 2024 at 04:30:32PM -0500, Judith Mendez wrote:
>> On 5/24/24 1:38 PM, Conor Dooley wrote:
>>> On Thu, May 23, 2024 at 06:15:10PM -0500, Judith Mendez wrote:
>>>> Add new compatible ti,am62-eqep for TI K3 devices. If a device
>>>> uses this compatible, require power-domains property.
>>>>
>>>> Since there is only one functional and interface clock for eqep,
>>>> clock-names is not really required. The clock-name also changed
>>>> for TI K3 SoCs so make clock-names optional for the new compatible
>>>> since there is only one clock that is routed to the IP.
>>>
>>> Really the clock should be named after the function it has in the IP
>>> block - it looks like "sysoutclk" is more likely the name of the clock
>>> routed to the IP rather than the role it has?
>>
>> It is the name of the clock, though id like to keep sysclkout for
>> backwards compatibility, even though the name is confusing.
> 
> FWIW, I was not suggesting that it be renamed.

Understood, thanks.

> 
> Thanks,
> Conor.


