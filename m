Return-Path: <linux-iio+bounces-9904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005819899B5
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 06:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7501C20C32
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 04:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466D3558BC;
	Mon, 30 Sep 2024 04:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mLh/ikgm"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B02F2B9B7;
	Mon, 30 Sep 2024 04:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727669325; cv=none; b=pQVY1YpOfH/Dl7bQ9Qh0Q72imENxQqF8DDlkSp208L4pl/9agYZop9JLtwJMn7tE8mIgcSSBimiiiXPHkhzusAYXBb/UcTvqpr9DVDUadRanzzdvJ6b+jgpjL3yn6ojuQKVenPeNp821soeBs31AWPX/Z7VYRmtce1nXEpsvOUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727669325; c=relaxed/simple;
	bh=jFJiBIlKG5iAu6aSb94TTGluLjqwGP+YTAvZMFAi0Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YPMPEEwpuLDfVQ7+hkXWYhDVtmMd53gU59+wDC+5+XPJhQ3qK69tHFV8htCh46wiOWrMOEgsgfZ+7OrgV3W3XXqjfZ9fQ0g84KrnCk2sqYuoNZrvdH8VR7fIg0RUYfeKnzsBvd5n1xHR8gzPSJ6AdEoJlGPPldEdOUAmpXQXG8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mLh/ikgm; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48U47ePr032940;
	Sun, 29 Sep 2024 23:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727669260;
	bh=IRnFksIazCvtlxm01gJxM9VDgeuMl9UTgV21jwVSfn4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=mLh/ikgmZBhv99UDhiiGEPeyHUoGyVbTatefX2slWMnAlpL4FusX0s+FATXrKW+xv
	 0do5GSjYHV5yU+1+dUpzZyRHqyn3RUI8eCsBEVYGcKnw4wEBGH0vqpFHNd76xzmuNP
	 OwJRj1WRejtwV249P2q7WQAbD1abH4WfFpnvIXXc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48U47el2019554
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 29 Sep 2024 23:07:40 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 29
 Sep 2024 23:07:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 29 Sep 2024 23:07:39 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48U47Z7R032236;
	Sun, 29 Sep 2024 23:07:36 -0500
Message-ID: <3b53797b-f2c6-437b-93f1-8b5c22c836e5@ti.com>
Date: Mon, 30 Sep 2024 09:37:35 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] Enable eQEP DT support for Sitara K3 platforms
To: William Breathitt Gray <wbg@kernel.org>, Judith Mendez <jm@ti.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, David Lechner <david@lechnology.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
References: <20240924220700.886313-1-jm@ti.com> <ZvkwOwjnmDD8qKL7@ishi>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <ZvkwOwjnmDD8qKL7@ishi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi,

On 29/09/24 16:17, William Breathitt Gray wrote:
> On Tue, Sep 24, 2024 at 05:06:55PM -0500, Judith Mendez wrote:
>> Git rebased the series since due to merge conflicts, part of the
>> series was not merged. Also dropped the patches that were already
>> merged.
>>
>> This patch series adds eQEP DT nodes for K3 Sitara devices:
>> - AM62x
>> - AM62ax
>> - AM62px
>> - AM64x
>>
>> Changes since v5:
>> - Drop patch 1/8, 2/8, 8/8 since they have been merged
>>
>> v5: https://lore.kernel.org/linux-devicetree/20240612135538.2447938-1-jm@ti.com/
>> v4: https://lore.kernel.org/linux-devicetree/20240610144637.477954-1-jm@ti.com/
>> v3: https://lore.kernel.org/linux-devicetree/20240607162755.366144-1-jm@ti.com/
>> v2: https://lore.kernel.org/linux-devicetree/20240523231516.545085-1-jm@ti.com/
>> v1: https://lore.kernel.org/linux-devicetree/20240418221417.1592787-1-jm@ti.com/
>>
>> Judith Mendez (5):
>>   arm64: dts: ti: k3-am62-main: Add eQEP nodes
>>   arm64: dts: ti: k3-am62a-main: Add eQEP nodes
>>   arm64: dts: ti: k3-am62p-main: Add eQEP nodes
>>   arm64: dts: ti: k3-am64-main: Add eQEP nodes
>>   arm64: dts: ti: k3-am64x-sk: Enable eQEP
>>
>>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi      | 27 +++++++++++++++++++
>>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     | 27 +++++++++++++++++++
>>  .../dts/ti/k3-am62p-j722s-common-main.dtsi    | 27 +++++++++++++++++++
>>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi      | 27 +++++++++++++++++++
>>  arch/arm64/boot/dts/ti/k3-am642-sk.dts        | 17 ++++++++++++
>>  5 files changed, 125 insertions(+)
>>
>> -- 
>> 2.46.0
>>
> 
> I recall last time these needed to go via the TI SoC/arm64 tree [^1].

Yes, I will queue this up now to 6.12-rc1 is out. Feel free to ignore
the series

> Is that still the case, or do you want me to pick these up now via the
> Counter tree?
> 
> William Breathitt Gray
> 
> [^1]: https://lore.kernel.org/all/d595b624-ef18-4aac-ab2c-bd36a8c4de3d@ti.com/


Regards
Vignesh

-- 
Regards
Vignesh

