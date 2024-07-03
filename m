Return-Path: <linux-iio+bounces-7215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF6092548B
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 09:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE29C1C24C30
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 07:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C3B136678;
	Wed,  3 Jul 2024 07:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="6BKzlxMG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C721131BDD;
	Wed,  3 Jul 2024 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719991394; cv=none; b=mPMRnClop3my7RcDS04C6sSSCvgorPW/6Czcsr1dZ8t8NU/L+lDMZMLcnmkf8KZMQlSyhGglrNXXs1maSrNgUp0o0ei4b5+AlRxMMWTXj0C0CAlldkV7bezIDG+EzOzncAQiXq27XoE7Rz8xcskyCkqyHQOP8uqul3vjcm9Nye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719991394; c=relaxed/simple;
	bh=LMG0Hk9HWoesEQBaKPnUAzUolPD1IIQjdRRRL3Ahrz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rIVyMCkzn7EVCo+Gvz3/NjzfJPhkoIktLuTHmbVqRZOGEIBXpZXwIXpnlyID8cJpkg//OZ1iqFHa6TyViEZkmbogIoVL5agLLpPGbx+WIq9Xkbs8/6e04f5Am6dwBcoQBnc15uOGYkMw7SmLw/VRNIULwl4J3jZ9J4zOPSYde5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=6BKzlxMG; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4630KYv2022258;
	Wed, 3 Jul 2024 09:22:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	lP6a1UtKqsjM5BY6HprJY0SpXdmd34uScXaSFUlCRhY=; b=6BKzlxMG7Fploan6
	Q7z0BOpwXEuvAGiU2TVP5rXpARzGmn0Dle39WcqH8QzD8+/GI5HR1TA0Emcod90H
	oH0G35YmCvszC48t8KcMUIbFtdkdeJMhsrKkYncaw5paxDnOr5nxd15pY7LdOsUT
	X59lLZYT8PbNsuoeG+CARYpi7/zrXMYdiWh3hJ0EObPW/YJ9lpQPGhRmkt/4YqxD
	HBKIO/FmatfpN+VOJ6AV3GcEK72iS3nO7xZI8BOFzuS71+5lwV4Nr68sLc+QetQ5
	nQUCUwK+Et6SovgNcHdKOI0HM4XmR9kaba4EVp4rdKYDUBWhlJ0pXd8O0VkaQmTc
	xBbrAw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 402uu0vp0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 09:22:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BEAC94004F;
	Wed,  3 Jul 2024 09:22:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0BEA9214526;
	Wed,  3 Jul 2024 09:22:17 +0200 (CEST)
Received: from [10.252.27.110] (10.252.27.110) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Jul
 2024 09:22:16 +0200
Message-ID: <7e7c0e37-cb5d-4c2e-93a5-708cf0f82f44@foss.st.com>
Date: Wed, 3 Jul 2024 09:22:15 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] dt-bindings: iio: add sigma delta modulator
 backend
To: Conor Dooley <conor@kernel.org>
CC: <fabrice.gasnier@foss.st.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
 <20240625150717.1038212-6-olivier.moysan@foss.st.com>
 <20240625-babied-skies-0722dbdfc524@spud>
 <eefc746a-2181-41da-b777-b077a4c19b77@foss.st.com>
 <20240627-identity-enviable-4fda0b3a09c0@spud>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20240627-identity-enviable-4fda0b3a09c0@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_03,2024-07-02_02,2024-05-17_01

Hi Conor,

On 6/27/24 18:13, Conor Dooley wrote:
> On Wed, Jun 26, 2024 at 06:40:58PM +0200, Olivier MOYSAN wrote:
>> Hi Conor,
>>
>> On 6/25/24 17:34, Conor Dooley wrote:
>>> On Tue, Jun 25, 2024 at 05:07:13PM +0200, Olivier Moysan wrote:
>>>> Add documentation of device tree bindings to support
>>>> sigma delta modulator backend in IIO framework.
>>>>
>>>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>>>
>>> I don't review bindings for a job, I can only reliably get to look at
>>> my mail queue in the evenings, please give me a chance to reply to you
>>> before you submit a new version.
>>>
>>
>> Sorry, the short review delay.
>>
>>>> +$id: http://devicetree.org/schemas/iio/adc/sd-modulator-backend.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Sigma delta modulator backend
>>>
>>> Same comments about filename and title apply here as the previous
>>> version. "TI $foo Sigma Delta Modulator" and drop the reference to back
>>> ends or the pretence of being generic.
>>>
>>
>> The logic here is the same as for the former sigma delta modulator driver.
>> (see discussion [1])
>> I mean introducing a generic and minimalist driver to support sd modulators,
>> but not dedicated to a specific modulator. The ads1201 is chosen as a basic
>> modulator here. But it is rather an arbitrary choice.
>>
>> I agree "backend" reference is not really relevant here. I have to think
>> about a way to manage the coexistence of this sigma delta modulator driver
>> with its former version.
> 
> To be blunt, I don't care about drivers! Well I do, but not in this
> particular context. You can absolutely have a driver that supports
> multiple backends or sigma delta modulators, but right now we are
> talking about a binding and this binding supports exactly one sigma
> delta modulator - and with an explicit compatible. In that context,
> presenting the binding as generic makes little sense.
> 
>> [1] https://lore.kernel.org/all/6943aaf5-b580-0fd1-7a2e-b99f7a266388@st.com/
> 
> Looking at this though, I question the binding more... The programming
> model of the device is identical as a backend or otherwise, so it
> shouldn't be getting a new compatible. Isn't this actually as simple as
> adding #io-backend-cells to the existing binding and using that to
> determine whether the device is being used as a backend or in isolation?
> 

For sure. I came to the same conclusion. My first idea was to isolate 
the deprecated binding. However, I agree that the best approach is to 
adapt the existing binding. I prepared a v3 like this.

BRs
Olivier

> Thanks,
> Conor.

