Return-Path: <linux-iio+bounces-17023-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E2DA67617
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 15:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53F487A33B5
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 14:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AAD20DD43;
	Tue, 18 Mar 2025 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="GnhUtpgh"
X-Original-To: linux-iio@vger.kernel.org
Received: from qs51p00im-qukt01072501.me.com (qs51p00im-qukt01072501.me.com [17.57.155.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E6C20D512
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307380; cv=none; b=DDN/GOSmHUAhq/rYkc1TsTw1ilsElBqOziI41hFSyjpRQjzzLpI6tH/G/gwtW6e0jRmd6XJwL1a6aMGrHa4mYkJaQotvOvSa0DmCD/M2HsBAhSQjCv2uF2LGr3CzibBUuRW+MmsRBbdxwz5+UCMCf5y0sk/Xg4akxYMZ04CGRlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307380; c=relaxed/simple;
	bh=F3zEloayFB59tG2uFVl0zt9z5egeQR6/DV0bXFcOQLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSJgNMBWOKR4g+i1rH0BwMt9YxJ9UTkcoCpm6ViJh/UPHvk9j/wxwgr+BDVLvk7KxbFSxxhTo0IGkS4Bn6KWpHyxWe6nh6HwXGMdhfA9tMpOivvn9yeeYhAr2lPz3FONDWSqDbkToZ4W3KekcIaBaKH6yqAtTRIWwFNZuKEcmCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=GnhUtpgh; arc=none smtp.client-ip=17.57.155.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=+lYMfzE0EBEBAFrPAVdWndmMr4naYIrNNaZlMxmulcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=GnhUtpghvvJflEdu/RYrZ/RTl3tlTEUXwFypQ9mUKi31Ycr/w9o7XmCM2SNFiHFey
	 5NsHtVYq5ll+adWSLPB9Obb2W0XwKnUJtrPTzeE+T8AyOK1soaS/+zLDuiN2ScQfIu
	 FZ1VdWJmFF+ouixxQr6BQ9MZotP9rKDxDnDRztNoOGgrxxJNjlUgV4wPCN9HhYkUb4
	 irCW4AiMizoOQfjxDAZ1MzJ7ktmJCAr87PyATLDipO3XE0Ue98UdUCzni42ZiCXVM5
	 JHVbwciOLZTX5L7HqLJaAi9llrvUKswf3LmpTQb2fvqShC8cLfMen9x3rSnLn8TsAA
	 SbJ2Sh95RLWNA==
Received: from [192.168.1.28] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072501.me.com (Postfix) with ESMTPSA id 9BD99440167;
	Tue, 18 Mar 2025 14:16:14 +0000 (UTC)
Message-ID: <f0536d74-5433-4086-9dfc-1ce6aeeebe00@pereznus.es>
Date: Tue, 18 Mar 2025 15:16:12 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: bh1750: Add hardware reset support via GPIO
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org
Cc: tduszyns@gmail.com, jic23@kernel.org, lars@metafoo.de, robh@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250316145514.627-1-sergio@pereznus.es>
 <01f48f6d-55a4-4dbe-b1ae-ef8c54dcc1ff@kernel.org>
Content-Language: es-ES, en-US, ca
From: =?UTF-8?Q?Sergio_P=C3=A9rez?= <sergio@pereznus.es>
In-Reply-To: <01f48f6d-55a4-4dbe-b1ae-ef8c54dcc1ff@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mnMBvqOoHvusoZdA_rhYCAZzB9-6Rs4a
X-Proofpoint-ORIG-GUID: mnMBvqOoHvusoZdA_rhYCAZzB9-6Rs4a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 clxscore=1030
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2503180105

Hello,

El 17/03/2025 a las 8:24, Krzysztof Kozlowski escribió:
> On 16/03/2025 15:55, Sergio Perez wrote:
>> Some BH1750 sensors require a hardware reset before they can be
>> detected on the I2C bus. This patch adds support for an optional
>> reset GPIO that can be specified in the device tree.
>>
>> The reset sequence pulls the GPIO low and then high before
>> initializing the sensor, which enables proper detection with
>> tools like i2cdetect.
>>
>> Update the devicetree binding documentation to include the new
>> reset-gpios property with examples.
>>
>> Signed-off-by: Sergio Perez <sergio@pereznus.es>
> Please run scripts/checkpatch.pl and fix reported warnings. After that,
> run also `scripts/checkpatch.pl --strict` and (probably) fix more
> warnings. Some warnings can be ignored, especially from --strict run,
> but the code here looks like it needs a fix. Feel free to get in touch
> if the warning is not clear.
>
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
>
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
>
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.
>
> Please kindly resend and include all necessary To/Cc entries.
> </form letter>
>

Sorry, I had run the scripts/get_maintainer.pl tool and got fewer 
recipients than necessary.  I have redone everything in a clean 
installation and now I have obtained more recipients.

Any fixes I make in the patch I send to this same thread or should I 
send it with git send-mail? I say this because perhaps I have done it 
incorrectly and possibly created 3 versions, I apologize. My latest 
version (v3) includes all the suggestions mentioned but due to my 
ignorance of the procedure I thought they should be sent to the list 
again as before. Can I delete v2 and v3 and keep only the first version?

>> ---
>>   .../devicetree/bindings/iio/light/bh1750.yaml |  20 +++-
>>   drivers/iio/light/bh1750.c                    | 113 ++++++++++++------
>
> ... and please go through your patch and see what happened there.
>>   2 files changed, 95 insertions(+), 38 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.yaml b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
>> index 1a88b3c253d5..d53b221eb84b 100644
>> --- a/Documentation/devicetree/bindings/iio/light/bh1750.yaml
>> +++ b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
>> @@ -11,6 +11,9 @@ maintainers:
>>   
>>   description: |
>>     Ambient light sensor with an i2c interface.
>> +
>> +  Some BH1750 sensors require a hardware reset before being properly detected
>> +  on the I2C bus. This can be done using the optional reset-gpios property.
>>   
>>   properties:
>>     compatible:
>> @@ -23,6 +26,10 @@ properties:
>>   
>>     reg:
>>       maxItems: 1
>> +
>> +  reset-gpios:
>> +    description: GPIO connected to the sensor's reset line (active low)
>> +    maxItems: 1
>>   
>>   required:
>>     - compatible
>> @@ -41,5 +48,16 @@ examples:
>>           reg = <0x23>;
>>         };
>>       };
>> +  - |
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      light-sensor@23 {
>> +        compatible = "rohm,bh1750";
>> +        reg = <0x23>;
>> +        reset-gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
>> +      };
>> +    };
>>   
>> -...
>> +...
>> \ No newline at end of file
> You have unrelated changed all over the place.
>
>
> Best regards,
> Krzysztof

Yes, in the patch I have prepared I have solved this problem, it only 
adds the exact lines and does not modify anything else.


