Return-Path: <linux-iio+bounces-6972-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB719187B0
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 18:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44B1DB27141
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 16:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B956A18F2F2;
	Wed, 26 Jun 2024 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="4JkEpz0Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC98918EFCA;
	Wed, 26 Jun 2024 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420117; cv=none; b=SNDXuSRx4FChX9YH854fQkKlI1LeIhH2H1py9qpXgxr6koqfbkiKtochJXkBYtylPS6ecwxcA+ngYL6Ab4S3FRRiQsIjg941JunoDtzYVqtsW2peVuge4I6jKaFpV43Mss86zDYI6uerxK3yCPN9b0xKCVAi2nS5xYs7yXPuYzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420117; c=relaxed/simple;
	bh=KzKcv4a2vveGFKQF+gsNjD7NpPRR28fxKC5mX4CO4M8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=opDS1kwv8cK+cbKsE6DRkIq1iTYpexpP4GsO7LTc+vHXycYqGH3EI47TJzdghoUYmKw5assqjwOPAtQwJ1PW8m7FCYEaFlyh5ws6vjonX7n5w0q2MDhIsHIV1zDXpgf7FV1X/S4y+ReMiKP/8q+98OuggjVmt+/4ew2yQN5zKwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=4JkEpz0Y; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QDUWLJ024438;
	Wed, 26 Jun 2024 18:41:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	FBVn3RGmQ5EII4oizLSos5vvLk3lXaI9WnLsWvo9+jc=; b=4JkEpz0YYrI3Elrl
	9OjV+2a7KhXDbeV3kr7SdDYUAJurJ+AWZtMbvXRu7EIpUE3jkVvaJSSBhLB8nGqd
	mPfrvPusmmcwmQxgtPnBBrb0Dy/1S5Kmx43+azLJG/MWyQSsAHKC0d7vEgAvcM/Y
	Qs+lw167kEeFfUCafLjs2IfizLT/YoQlXTzU0DUzry0OTFyowkHODyeYr12mzLZi
	YFoMvuGwkzpJDlN2Cq6JRsoyhzJpPiqS46ydo1qebDbPIC+0W1nRmHeWHhLwPeEi
	BC7SME2cZS+xU5bLNk7NhI45qyu5Z2v/sjxuFn4WUP83JJLH+7FplkAqQ4fWa78k
	tK8iKg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yx9jjev2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 18:41:41 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3D59B4002D;
	Wed, 26 Jun 2024 18:41:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 71D72229A91;
	Wed, 26 Jun 2024 18:40:59 +0200 (CEST)
Received: from [10.252.26.2] (10.252.26.2) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 26 Jun
 2024 18:40:58 +0200
Message-ID: <eefc746a-2181-41da-b777-b077a4c19b77@foss.st.com>
Date: Wed, 26 Jun 2024 18:40:58 +0200
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
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20240625-babied-skies-0722dbdfc524@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01

Hi Conor,

On 6/25/24 17:34, Conor Dooley wrote:
> On Tue, Jun 25, 2024 at 05:07:13PM +0200, Olivier Moysan wrote:
>> Add documentation of device tree bindings to support
>> sigma delta modulator backend in IIO framework.
>>
>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> 
> I don't review bindings for a job, I can only reliably get to look at
> my mail queue in the evenings, please give me a chance to reply to you
> before you submit a new version.
> 

Sorry, the short review delay.

>> +$id: http://devicetree.org/schemas/iio/adc/sd-modulator-backend.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sigma delta modulator backend
> 
> Same comments about filename and title apply here as the previous
> version. "TI $foo Sigma Delta Modulator" and drop the reference to back
> ends or the pretence of being generic.
> 

The logic here is the same as for the former sigma delta modulator 
driver. (see discussion [1])
I mean introducing a generic and minimalist driver to support sd 
modulators, but not dedicated to a specific modulator. The ads1201 is 
chosen as a basic modulator here. But it is rather an arbitrary choice.

I agree "backend" reference is not really relevant here. I have to think 
about a way to manage the coexistence of this sigma delta modulator 
driver with its former version.

[1] https://lore.kernel.org/all/6943aaf5-b580-0fd1-7a2e-b99f7a266388@st.com/

BRs
Olivier

> Thanks,
> Conor.

