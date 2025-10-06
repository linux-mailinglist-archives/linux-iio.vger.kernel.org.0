Return-Path: <linux-iio+bounces-24774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD1ABBE356
	for <lists+linux-iio@lfdr.de>; Mon, 06 Oct 2025 15:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8264C189760A
	for <lists+linux-iio@lfdr.de>; Mon,  6 Oct 2025 13:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EAB2D24A9;
	Mon,  6 Oct 2025 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J49OC6wj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC6299947;
	Mon,  6 Oct 2025 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759758340; cv=none; b=G7OgbG26y9PDbxCh/CXCjYEJPpAldf2RjnC/7SOnJE3YCUDW1uqV0fvyo3x8noaYbMpnYhEhy2FZqTfUkbxsj2WGP04guCyxshVVTt8BZx2+oBubFgbREJk0ekn6N1z/C3p7d1KIvbl6ntZS/pjwoNjpS9qRLOmN44wTZdY5g1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759758340; c=relaxed/simple;
	bh=kpW8AkihWKxBWqqlr/6/hy32oKR+fx3a/p8liHYP3Zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwczs8zgtG3XSwD4pXN5IgnReWXHSaaFUMCudXePvdV6jAapqKi6mdMf6P9om/ZM8PQvMS9Y6UEgynqXlu/7WnLV3NnVN2BoVxAzM6Xf0BNrDhIZanEf1+q9EduuvDIKYNkPgNL5Kmdc/tn2H0wtiZ0CQzraoHlZNWtw6FoD55o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J49OC6wj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596B0cgv030070;
	Mon, 6 Oct 2025 13:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aH3eyr
	2iMrs8pijaLdoabns1MCGmnbJaq59cYFAEH10=; b=J49OC6wjMC+KuKfQq2PKOU
	RGgDxqZTk5IX8AYDTbzcIotpTUVZBVxrNVYqVEbxtzNEsgD9DfEr/WkH855rEHu+
	GeelF75sRoEC+HKcwtA54IZkyF1exsaL0A++PWjpkTlcsvTfQ/iDxqeuxQeYpduZ
	+zBf3ykI7b/3cl5ZjeTys77xDnK51iv26hSRlhD4jw+5JX+WH9nciOswylViBlMm
	abg1J5PzWFLSxqL4rPh9MShssrFJtSySC4k6g1S7NbfGGFXpbsBDn3QwsIo04uCv
	0lcuYAuplR+d+67WKu4RWYHtedWQq3AHtJshyub2Coos+v1uIHtj+6jUqQc1EMVg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju3gsnj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Oct 2025 13:44:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 596CbUxG000886;
	Mon, 6 Oct 2025 13:44:57 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49ke9xxcp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Oct 2025 13:44:57 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 596Div0l9110128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Oct 2025 13:44:57 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DB3D5805B;
	Mon,  6 Oct 2025 13:44:57 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58F5B58058;
	Mon,  6 Oct 2025 13:44:56 +0000 (GMT)
Received: from [9.61.74.248] (unknown [9.61.74.248])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Oct 2025 13:44:56 +0000 (GMT)
Message-ID: <8ab87732-71e1-4101-9aed-14f68c27fea1@linux.ibm.com>
Date: Mon, 6 Oct 2025 08:44:55 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 RESEND 3/7] dt-bindings: iio: Add Infineon DPS310
 sensor documentation
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
        linux@roeck-us.net, chanh@os.amperecomputing.com, jic23@kernel.org,
        dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
References: <20251001144441.310950-1-eajames@linux.ibm.com>
 <20251001144441.310950-4-eajames@linux.ibm.com>
 <20251003150102.00007dae@huawei.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20251003150102.00007dae@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOCBTYWx0ZWRfX4KDcePseopNg
 eDkuwDWumPITZpBbmp/fN6p/RmRbs4/e9ENwGJMN91Nk1lg9t549Dgc510d9aRxeZjcQ61Lc1e9
 nzBwSgUXb5km72VrqizxHvnAn8XQSlewSVwDFSFzeLaCfr+L9CyOb6xqMbcVefnoLxdGOQPhFJJ
 GIJA38dp7DA72oNJRuFKEmfCm+9gBvhiBT65sESxQPNLCnX+cIYNuGoAk1B3dPljRqapDmgty8w
 RNnPa9M/9U6/wSd+0OFEfdPIC6t1obHI8Nz1HOa+rWxeIYzDPfMFVfB81XA5HVif/qRjbmGsmC3
 FRRF+/J087GMuWnOEnjMTi7z6k59R+EOOhKx2UHwUKQJ9D4wTLj7H3jtemrymnPHc9XsdwXdJR8
 hn/5u2tawh4YIjaQmk+LP3JG0VtUaw==
X-Authority-Analysis: v=2.4 cv=I4dohdgg c=1 sm=1 tr=0 ts=68e3c7db cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=gEfo2CItAAAA:8 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=cY1baSEh5ss2YjGIKrwA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: zrOExJCPVknGmCmy8eQX-JXXsaTETfWZ
X-Proofpoint-ORIG-GUID: zrOExJCPVknGmCmy8eQX-JXXsaTETfWZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040018


On 10/3/25 9:01 AM, Jonathan Cameron wrote:
> On Wed,  1 Oct 2025 09:44:37 -0500
> Eddie James <eajames@linux.ibm.com> wrote:
>
>> The DPS310 is a barometric pressure and temperature sensor with
>> an I2C interface. Remove it from trivial-devices.yaml and add its
>> own documentation.
> Hi Eddie,
>
> Why?  I guess you need the #io-channel-cells which trivial devices
> doesn't allow because you have a consumer driver?


Correct.


>
> Obviously the binding patch shouldn't mention that, but it could call
> out that there can be such consumers.


OK, I can add that.


>
> I'd also expect to see some supplies even if the driver doesn't yet
> explicitly handle them.


You mean in the example section? Sure. I'll send a patch separately 
since the rest is merged


Thanks,

Eddie


>
> Jonathan
>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> ---
>>   .../iio/pressure/infineon,dps310.yaml         | 44 +++++++++++++++++++
>>   .../devicetree/bindings/trivial-devices.yaml  |  2 -
>>   MAINTAINERS                                   |  1 +
>>   3 files changed, 45 insertions(+), 2 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
>> new file mode 100644
>> index 0000000000000..7c0782e2a821b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
>> @@ -0,0 +1,44 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/pressure/infineon,dps310.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Infineon DPS310 barometric pressure and temperature sensor
>> +
>> +maintainers:
>> +  - Eddie James <eajames@linux.ibm.com>
>> +
>> +description:
>> +  The DPS310 is a barometric pressure and temperature sensor with an I2C
>> +  interface.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - infineon,dps310
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#io-channel-cells":
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        pressure-sensor@76 {
>> +          compatible = "infineon,dps310";
>> +          reg = <0x76>;
>> +          #io-channel-cells = <0>;
>> +        };
>> +    };
>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>> index 7609acaa752d5..a72b7fabc7034 100644
>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>> @@ -127,8 +127,6 @@ properties:
>>             - ibm,cffps2
>>               # IBM On-Chip Controller hwmon device
>>             - ibm,p8-occ-hwmon
>> -            # Infineon barometric pressure and temperature sensor
>> -          - infineon,dps310
>>               # Infineon IR36021 digital POL buck controller
>>             - infineon,ir36021
>>               # Infineon IRPS5401 Voltage Regulator (PMIC)
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0c8281ea4cc64..92b9854a0e07d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -12191,6 +12191,7 @@ INFINEON DPS310 Driver
>>   M:	Eddie James <eajames@linux.ibm.com>
>>   L:	linux-iio@vger.kernel.org
>>   S:	Maintained
>> +F:	Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
>>   F:	drivers/iio/pressure/dps310.c
>>   
>>   INFINEON PEB2466 ASoC CODEC
>

