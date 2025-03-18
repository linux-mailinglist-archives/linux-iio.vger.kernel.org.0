Return-Path: <linux-iio+bounces-17029-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D94A678B5
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 17:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A043B2D5A
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 16:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E1E20F062;
	Tue, 18 Mar 2025 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="AyVtlEtl"
X-Original-To: linux-iio@vger.kernel.org
Received: from qs51p00im-qukt01080102.me.com (qs51p00im-qukt01080102.me.com [17.57.155.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A96617A2F5
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314006; cv=none; b=bENIK+/9iAyor2nmA+9hEJ/c1CWkwXowlU0d0pBIjhc9WaZi1Oc49BR1I14gIekeuWWDYZ33S4i51WFHCyK8C4K+Iy0jB71nSZVHMl6RwY/aFsTOEY2gCXRlkqj34zSfefLpwTmwLqlUiw1GGvA431iMbDlZG6Wv0t/VsdeSbuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314006; c=relaxed/simple;
	bh=2jIBY1R7tzCCurKOJGv+KWgN60q+TYJ/tFrE9+rZKt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DT4xdYbIdcVumDO11cWOZVRBgq1ELRuJGs181lAadqe014l/GOmedDus9gpKIkBZ8smgRGIGiINb+WLpbxZg/edfRgyrxPUuPmhR1oLDl7w7V//Q04yhRRY34paiUz+/FiThaMElE1EVWIXGHB2irGrzQ8L2iioZH7ckLgrRxPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=AyVtlEtl; arc=none smtp.client-ip=17.57.155.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=ZNlivktpTSg+Q5P7DU3PZB7PXUhQiyzowd0Rx7fsAcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=AyVtlEtlw1qirrosBPb99eWNswO3d+8KyybNl4r4Pfl/ko7Nh4YwJpXphRvF7oUwV
	 iD8RjRGGUkEJ9ciUAB7rxFhVDTxMx+U56XlHqfwssOL7vv182mL+4feN7eHPFQHdsY
	 D3vNvIeNx13NZCmOW8Jls8WrMiTjA+4epOXBU0UsTU7O0dodI6TA8DDcMXG1Pm0n3j
	 /FHDHA94O4ewtz8ZzCHwRZ9inSzKSsjk4V5imDu1Mpjvc7RRPW6+G0/h7AhOwS0xJZ
	 3yS7MmkaxEU8pPhZeGbv8XVfn3BykywfCSY9Qg9fhSphLOQZU5A8ZMqGG6ozv3V9cO
	 /QKyW7l5LDFWQ==
Received: from [192.168.1.28] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080102.me.com (Postfix) with ESMTPSA id 276221CC038A;
	Tue, 18 Mar 2025 16:06:39 +0000 (UTC)
Message-ID: <144b5c43-f8c6-44d1-bcff-83158ac29781@pereznus.es>
Date: Tue, 18 Mar 2025 17:06:37 +0100
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
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250316145514.627-1-sergio@pereznus.es>
 <01f48f6d-55a4-4dbe-b1ae-ef8c54dcc1ff@kernel.org>
 <f0536d74-5433-4086-9dfc-1ce6aeeebe00@pereznus.es>
 <8992a79d-0859-4d7f-9b47-52e20b11260a@kernel.org>
Content-Language: es-ES, en-US, ca
From: =?UTF-8?Q?Sergio_P=C3=A9rez?= <sergio@pereznus.es>
In-Reply-To: <8992a79d-0859-4d7f-9b47-52e20b11260a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pCEdN61Hmnmlb2DI6gjNshQHagOu22FO
X-Proofpoint-ORIG-GUID: pCEdN61Hmnmlb2DI6gjNshQHagOu22FO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1030 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2503180118


El 18/03/2025 a las 16:16, Krzysztof Kozlowski escribió:
> On 18/03/2025 15:16, Sergio Pérez wrote:
>> Hello,
>>
>> El 17/03/2025 a las 8:24, Krzysztof Kozlowski escribió:
>>> On 16/03/2025 15:55, Sergio Perez wrote:
>>>> Some BH1750 sensors require a hardware reset before they can be
>>>> detected on the I2C bus. This patch adds support for an optional
>>>> reset GPIO that can be specified in the device tree.
>>>>
>>>> The reset sequence pulls the GPIO low and then high before
>>>> initializing the sensor, which enables proper detection with
>>>> tools like i2cdetect.
>>>>
>>>> Update the devicetree binding documentation to include the new
>>>> reset-gpios property with examples.
>>>>
>>>> Signed-off-by: Sergio Perez <sergio@pereznus.es>
>>> Please run scripts/checkpatch.pl and fix reported warnings. After that,
>>> run also `scripts/checkpatch.pl --strict` and (probably) fix more
>>> warnings. Some warnings can be ignored, especially from --strict run,
>>> but the code here looks like it needs a fix. Feel free to get in touch
>>> if the warning is not clear.
> You keep ignoring paragraphs. Did you read this?

I pass this check several times and every time I do any step to make 
sure I am well.

scripts/checkpatch.pl -f drivers/iio/light/bh1750.c
total: 0 errors, 0 warnings, 354 lines checked

drivers/iio/light/bh1750.c has no obvious style problems and is ready 
for submission.
(patches) sergio@ultron:/mnt/c/Users/sergio/source/pr/linux$ 
scripts/checkpatch.pl --strict -f drivers/iio/light/bh1750.c

and:

scripts/checkpatch.pl --strict -f drivers/iio/light/bh1750.c
CHECK: struct mutex definition without comment
#44: FILE: drivers/iio/light/bh1750.c:44:
+       struct mutex lock;

CHECK: Alignment should match open parenthesis
#194: FILE: drivers/iio/light/bh1750.c:194:
+static ssize_t bh1750_show_int_time_available(struct device *dev,
+               struct device_attribute *attr, char *buf)

total: 0 errors, 0 warnings, 2 checks, 354 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

drivers/iio/light/bh1750.c has style problems, please review.

NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.


The two CHECKS on lines 44 and 194 are not part of my contribution, but 
I can solve them if you want. Do I solve them too? I thought that I 
should not modify anything that exists.

>
>>> <form letter>
>>> Please use scripts/get_maintainers.pl to get a list of necessary people
>>> and lists to CC. It might happen, that command when run on an older
>>> kernel, gives you outdated entries. Therefore please be sure you base
>>> your patches on recent Linux kernel.
>>>
>>> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
>>> people, so fix your workflow. Tools might also fail if you work on some
>>> ancient tree (don't, instead use mainline) or work on fork of kernel
>>> (don't, instead use mainline). Just use b4 and everything should be
>>> fine, although remember about `b4 prep --auto-to-cc` if you added new
>>> patches to the patchset.
>>>
>>> You missed at least devicetree list (maybe more), so this won't be
>>> tested by automated tooling. Performing review on untested code might be
>>> a waste of time.
>>>
>>> Please kindly resend and include all necessary To/Cc entries.
>>> </form letter>
>>>
>> Sorry, I had run the scripts/get_maintainer.pl tool and got fewer
>> recipients than necessary.  I have redone everything in a clean
>> installation and now I have obtained more recipients.
> Please work on latest mainline tree, not some old clones. The cleanness
> of tree does not matter here.

I get the latest versión doing: git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

I checked versión doing:

$ make kernelversion
6.14.0-rc7

The list I got is where I'm sending the patch, 9 recipients. The same 
ones to whom I have sent this email.

>
>> Any fixes I make in the patch I send to this same thread or should I
>> send it with git send-mail? I say this because perhaps I have done it
>> incorrectly and possibly created 3 versions, I apologize. My latest
>> version (v3) includes all the suggestions mentioned but due to my
> Not sure, maybe some, but not all. You still did not acknowledge the
> first feedback I repeated here and v3 makes the same mistake.
>
>
>> ignorance of the procedure I thought they should be sent to the list
>> again as before. Can I delete v2 and v3 and keep only the first version?
> You cannot delete things sent to people. That's why you should check
> things prior sending. Everything you send is archives and available for
> everyone, publicly.
>
>>>> ---
>>>>    .../devicetree/bindings/iio/light/bh1750.yaml |  20 +++-
>>>>    drivers/iio/light/bh1750.c                    | 113 ++++++++++++------
>>> ... and please go through your patch and see what happened there.
>>>>    2 files changed, 95 insertions(+), 38 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.yaml b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
>>>> index 1a88b3c253d5..d53b221eb84b 100644
>>>> --- a/Documentation/devicetree/bindings/iio/light/bh1750.yaml
>>>> +++ b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
>>>> @@ -11,6 +11,9 @@ maintainers:
>>>>    
>>>>    description: |
>>>>      Ambient light sensor with an i2c interface.
>>>> +
>>>> +  Some BH1750 sensors require a hardware reset before being properly detected
>>>> +  on the I2C bus. This can be done using the optional reset-gpios property.
>>>>    
>>>>    properties:
>>>>      compatible:
>>>> @@ -23,6 +26,10 @@ properties:
>>>>    
>>>>      reg:
>>>>        maxItems: 1
>>>> +
>>>> +  reset-gpios:
>>>> +    description: GPIO connected to the sensor's reset line (active low)
>>>> +    maxItems: 1
>>>>    
>>>>    required:
>>>>      - compatible
>>>> @@ -41,5 +48,16 @@ examples:
>>>>            reg = <0x23>;
>>>>          };
>>>>        };
>>>> +  - |
>>>> +    i2c {
>>>> +      #address-cells = <1>;
>>>> +      #size-cells = <0>;
>>>> +
>>>> +      light-sensor@23 {
>>>> +        compatible = "rohm,bh1750";
>>>> +        reg = <0x23>;
>>>> +        reset-gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
>>>> +      };
>>>> +    };
>>>>    
>>>> -...
>>>> +...
>>>> \ No newline at end of file
>>> You have unrelated changed all over the place.
>>>
>>>
>>> Best regards,
>>> Krzysztof
>> Yes, in the patch I have prepared I have solved this problem, it only
>> adds the exact lines and does not modify anything else.
> OK, so this one is solved, what about all the rest?
I think I have everything right, just tell me if you prefer me to solve 
the 2 strict checks of the existing code and I will do it.
>
>
> Best regards,
> Krzysztof

