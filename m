Return-Path: <linux-iio+bounces-17130-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3329FA69C2B
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 23:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51693B63F4
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 22:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ACC21CA18;
	Wed, 19 Mar 2025 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="eRaHw7mW"
X-Original-To: linux-iio@vger.kernel.org
Received: from p00-icloudmta-asmtp-us-central-1k-60-percent-2.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (p-east1-cluster1-host11-snip4-5.eps.apple.com [57.103.91.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C121B196
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.91.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423899; cv=none; b=ljHzviPpCeAiIzTlCyQJ0Iag/628PTDyK3MkRYxU/pICNNz9iKThl+YmhIuXHG6i56acF4C21usG2sp5LCNot5MuzyDWiy/stNUZNpODz6qmTMfJ/blYls4nzcx32YOludbH1sdXUB7MTvGAnam1EQwAkmsygBYqvzsGCkNOO4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423899; c=relaxed/simple;
	bh=8a2f3FlRvG/pzDdRtKaKlroKGdKCT2odwaou3DMDvmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PcSsuafGOEujpZmxy6a7YyeGCNCp6us2XJdleVLwKXXEm12NVmiNVtzQlM0QkdP4EOeSWFuazYfnyos8ZnKSC7mNBFM4+GZN0xIgzZVQqQvd3K5vGaLGd3PoUkj3YPl2ceNpIppZASV5D5GlW00con+yieufFO8NqC5qLK/MWyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=eRaHw7mW; arc=none smtp.client-ip=57.103.91.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=D4tLwEtvyuAMs9vaw3UQSpGv6BpebpU0va3SYfZMuQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=eRaHw7mWCl7vStM7eB3wsmJN7N/xHsH1KjuWQkADW6RmbmF+/OdotDGZOeY43wudK
	 NW5JjX2u1mFTEK2xevW0yNtivYLD8Pi7U43F/hjdGK8yIp9vEX9rqlhArJxEI+rJA4
	 YgXc8TtqDD7lA14bLRdBZ7j325xIddXW69hJ8ojSlq3dkE3SWjEophLQKEewz9iatS
	 m4vTekkDZo4/MJFo/mLmKs0946maKZG2hNJbo5KZpIDkpCwPqMi828eliExG+47Yvl
	 OusKCDGi+Z7FbaELeflxdgcO0unBJc2zdmk9R7n/N45Socqa/C87B+HoKqKqRWMqzE
	 VtQt+UpbRjtDA==
Received: from [192.168.1.28] (ci-asmtp-me-k8s.p00.prod.me.com [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-2.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (Postfix) with ESMTPSA id D72DF18000B7;
	Wed, 19 Mar 2025 22:38:12 +0000 (UTC)
Message-ID: <96c44905-0725-4c68-91a5-1c6cea6a7f4a@pereznus.es>
Date: Wed, 19 Mar 2025 23:38:09 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: light: bh1750: Add reset-gpios
 property
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Tomasz Duszynski <tduszyns@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250319161117.1780-1-sergio@pereznus.es>
 <61d55149-1955-4d5c-84de-d8644727b87f@kernel.org>
Content-Language: es-ES, en-US, ca
From: =?UTF-8?Q?Sergio_P=C3=A9rez?= <sergio@pereznus.es>
In-Reply-To: <61d55149-1955-4d5c-84de-d8644727b87f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SUd8x49W4pG6fMgPf4kgXRWwy085DXog
X-Proofpoint-ORIG-GUID: SUd8x49W4pG6fMgPf4kgXRWwy085DXog
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_08,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1030 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2503190152


El 19/03/2025 a las 20:12, Krzysztof Kozlowski escribió:
> On 19/03/2025 17:11, Sergio Perez wrote:
>> Some BH1750 sensors require a hardware reset via GPIO before they can
>> be properly detected on the I2C bus. Add a new reset-gpios property
>> to the binding to support this functionality.
>>
>> The reset-gpios property allows specifying a GPIO that will be toggled
>> during driver initialization to reset the sensor.
>>
>> Signed-off-by: Sergio Perez <sergio@pereznus.es>
>> ---
>>   Documentation/devicetree/bindings/iio/light/bh1750.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
> You just sent v3, while v4 was already on the lists, without improving
> and without responding to review.
>
> NAK.
>
> You keep repeating the same mistakes: not reading and responding
> feedback and it is getting tiresome.
I apologize for the confusion with patch versions. You're right that I 
sent v3
after v4 was already on the list. I was trying to follow your exact 
instructions from:
"git add ...
git commit --signed-off
git format-patch -v3 -2
scripts/chekpatch.pl v3*
scripts/get_maintainers.pl --no-git-fallback v3*
git send-email *"

Regarding the binding I've modified for next v5 the YAML description to 
remove "active low" to avoid confusion and modified the example to:

examples:
   - |
     i2c {
       #address-cells = <1>;
       #size-cells = <0>;

       light-sensor@23 {
         compatible = "rohm,bh1750";
         reg = <0x23>;
         reset-gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
       };
     };

That is the original version and is the configuration running on my machine.

> Best regards,
> Krzysztof

