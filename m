Return-Path: <linux-iio+bounces-17312-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B5AA748AE
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 11:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B4747A6C37
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 10:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45F01F583D;
	Fri, 28 Mar 2025 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="RDyuBwEi"
X-Original-To: linux-iio@vger.kernel.org
Received: from p00-icloudmta-asmtp-us-east-2d-10-percent-1.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-east-2d.k8s.cloud.apple.com (p-east3-cluster6-host1-snip4-10.eps.apple.com [57.103.85.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074FF1DE2C3
	for <linux-iio@vger.kernel.org>; Fri, 28 Mar 2025 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.85.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743158979; cv=none; b=iSOta44qRN3xtmQp7lexgzJlWGo4m0XQqnZHOKVgYq0MtOACxD0uYCjQayZ7HXx3BgekbbdWMVSt5AToMOtndlqkM2EBcevoz0GpEJ3ViyykWyKxa+RTeoCHENr5A0QeVs+NInomFPDfQhwo4/CF+7m45u5WP71h1eO8cCv8P6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743158979; c=relaxed/simple;
	bh=7NAEPAX6m8dKJDfn+6jbCMWo5spDoAoaB7FaHgS8niY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdPPkBJT13ze87Kmve1GZn82bYP2FYGWkkyqIcLM/b0StFSIL83s3vpixnq2XRP5HKfCcqFKSorbsudaLtC2Uhne8CKLYpd/vnIKMFedKZxDlJf5BSC24IZG+Y5eelMieoKBig3SXF2fTy55Zm93xO3MhcArXTe80VNNoRLAiqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=RDyuBwEi; arc=none smtp.client-ip=57.103.85.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=fvG19Ay+E96nIa+spIyHiWWlBnSI38cW9OJJz+SbdYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=RDyuBwEilAEbMBwO891hmRqrPo+ocYMFAlUOUMqEoMOlAT0vAjLJfnXCvQubLcT+4
	 UiaO5ViyKWUllCUUOKgeteEWgTFPZZTEGQCQnAegvZ7qDngcioK+mE/n1amPwyO9Rc
	 7lsyqlOXyoXCFwWQfBA6nEtBHLYYqQimQjpxcnyPYZz4WyXwhxZOLhJURpVtbhyQhP
	 rJVtixcDXG2sOPuyD6OcbGczzu2lfRCY7uyghQ/ISXtgPjFZehCVW0EgOh0FTqxaOK
	 tYm7PM+mZi2K6vvl7I2cMnEA6DZ9zF4LG+xPsqOth7uzbps5Nb6l8UNEjhVkPDKb0z
	 NdKyHa0TpUIDg==
Received: from [192.168.1.28] (qs-asmtp-me-k8s.p00.prod.me.com [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-1.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-east-2d.k8s.cloud.apple.com (Postfix) with ESMTPSA id 397EF180311E;
	Fri, 28 Mar 2025 10:49:32 +0000 (UTC)
Message-ID: <4c6c2096-4f30-41d5-ad18-74436e8d48a5@pereznus.es>
Date: Fri, 28 Mar 2025 11:49:30 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: light: bh1750: Add reset-gpios
 property
To: Jonathan Cameron <jic23@kernel.org>
Cc: Tomasz Duszynski <tduszyns@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250324135920.6802-1-sergio@pereznus.es>
 <20250328094904.06ce0c96@jic23-huawei>
Content-Language: es-ES, en-US, ca
From: =?UTF-8?Q?Sergio_P=C3=A9rez?= <sergio@pereznus.es>
In-Reply-To: <20250328094904.06ce0c96@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Cu-FzO0OvO7mrghDlTHVXQu5Uu2xAf_U
X-Proofpoint-ORIG-GUID: Cu-FzO0OvO7mrghDlTHVXQu5Uu2xAf_U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1030 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2503280074


El 28/03/2025 a las 10:49, Jonathan Cameron escribió:
> On Mon, 24 Mar 2025 14:59:19 +0100
> Sergio Perez <sergio@pereznus.es> wrote:
>
>> Some BH1750 sensors require a hardware reset via GPIO before they can
>> be properly detected on the I2C bus. Add a new reset-gpios property
>> to the binding to support this functionality.
>>
>> The reset-gpios property allows specifying a GPIO that will be toggled
>> during driver initialization to reset the sensor.
>>
>> Signed-off-by: Sergio Perez <sergio@pereznus.es>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Series applied to the testing branch of iio.git. I'll rebase that
> on rc1 once available and push out as my togreg branch.
>
> Thanks,
>
> Jonathan
Thank you very much, I remain attentive in case anything needs to be done.
>> ---
>> Revision history:
>> v5 => v6:
>>   - Fixed include placement as commented by Krzysztof Kozlowski
>> v4 => v5:
>>   - Update description to reflect "active low" on reset signal as indicated by Krzysztof Kozlowski
>>   - Update description to clarify what pin of sensor is used to do reset (DVI) as mentioned by Krzysztof Kozlowski
>>   - Edit example to be coherent with "active low" as informed by Krzysztof Kozlowski
>>   - Added necessary include on example
>> v3 => v4:
>>   - No changes
>> v2 => v3:
>>   - Split in two patches: dtbinding and code
>>   - Ensure list off mantainers following instructions by Krzysztof Kozlowski
>>   - Delete redundant details on description as suggested by Jonathan Cameron
>>   - Added related example to existing one as suggested by Jonathan Cameron
>> v1 => v2:
>>   - Ensure check tests as commented by Rob Herring
>>   - Fixes some whitespaces and end lines
>> ---
>>   Documentation/devicetree/bindings/iio/light/bh1750.yaml | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.yaml b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
>> index 1a88b3c253d5..9df81c271411 100644
>> --- a/Documentation/devicetree/bindings/iio/light/bh1750.yaml
>> +++ b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
>> @@ -24,6 +24,10 @@ properties:
>>     reg:
>>       maxItems: 1
>>   
>> +  reset-gpios:
>> +    description: GPIO connected to the DVI reset pin (active low)
>> +    maxItems: 1
>> +
>>   required:
>>     - compatible
>>     - reg
>> @@ -32,6 +36,7 @@ additionalProperties: false
>>   
>>   examples:
>>     - |
>> +    #include <dt-bindings/gpio/gpio.h>
>>       i2c {
>>         #address-cells = <1>;
>>         #size-cells = <0>;
>> @@ -39,6 +44,7 @@ examples:
>>         light-sensor@23 {
>>           compatible = "rohm,bh1750";
>>           reg = <0x23>;
>> +        reset-gpios = <&gpio2 17 GPIO_ACTIVE_LOW>;
>>         };
>>       };
>>   

