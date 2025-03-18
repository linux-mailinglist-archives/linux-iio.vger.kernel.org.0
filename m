Return-Path: <linux-iio+bounces-17043-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B58BA67D58
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 20:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36DF27AC4DF
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 19:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22181212F8F;
	Tue, 18 Mar 2025 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="LIq175dW"
X-Original-To: linux-iio@vger.kernel.org
Received: from p00-icloudmta-asmtp-us-central-1k-100-percent-10.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (p-east1-cluster2-host3-snip4-5.eps.apple.com [57.103.88.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845C620F07C
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.88.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327485; cv=none; b=NB9SXiQn4OjKMbXQ3QZhDVCRcWsHW3d8/nWBhLRgUi2Z/MEcUGX4c98MfYBo5Jlg0RNGSc/B8+uv2TmsJkM6tV8xCGcgVq/x18G1U6uJlMOy+TqS23Ip6FZcdIWEl8lEvO7Oy/Hq4f3odTQe/ouee3WIrpBtm6E4a6UuBKCWW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327485; c=relaxed/simple;
	bh=piAebpfHUgpZreSe00cHDN4fuYNqfovsnGGr55TVFfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uY3zQBwK+KWOFj9bRSEFK9i4YECEYy25yAbZA4HrUcHWBeQ1zd3A7a+QprK/96p7Jdjc2nTjS1l0MNOa7KZWPlRpwDoAtTlN9NB/kb+4u/XOzVnDuzYBoTeGTZtBiYX1+/zU3iT36PmjKQg6kwo3D/ZpxBSU7XgmoIQuK6q6BJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=LIq175dW; arc=none smtp.client-ip=57.103.88.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=6IAXkIqRwylnS10Eetdm58moBb5/qqlwz9Ii+q7zpls=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=LIq175dWvC27mUZNWwJcfB3r4qjm6T+x4MmJdAKDvqwCmKMASXeI7vTsET4ANMKgL
	 g+n6zRLq8fGUE8ktWHrI8j6d89MQ/Xkxrsw/ST/jMGF342Ha3n6p5/QQ9Kp7tVFThv
	 6ZLhC2c59BJO0qedXfYyIkvpCtE5RFjtf09q6o/LuJvvMERGiHGsJr+UtvPrPNhOZy
	 ZM6K239R6ptv3MGBjW/PAmpmNFoFIKw+WsSwg1lX6vCJpRRt9JLpyAy/KZuHYyvb2P
	 u0sLm6+7kBW2s4r85K+bW1+1+N1oI9a26h1SZiS0VSZVqejCoa4H1wgo2kEB3TAY9c
	 UI0eqHqXWTzhg==
Received: from [192.168.1.28] (ci-asmtp-me-k8s.p00.prod.me.com [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-10.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (Postfix) with ESMTPSA id 9E1B418000BA;
	Tue, 18 Mar 2025 19:51:16 +0000 (UTC)
Message-ID: <22b70f84-0918-43e7-92f5-c8bdb4a68363@pereznus.es>
Date: Tue, 18 Mar 2025 20:51:14 +0100
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
 <144b5c43-f8c6-44d1-bcff-83158ac29781@pereznus.es>
 <202b4446-0ce4-4288-8588-6edfc32125d1@kernel.org>
 <bde38364-5c20-4030-ad7d-9ae38971b260@kernel.org>
 <bf16371c-189c-4e51-91e5-129f1dcad317@pereznus.es>
 <ac008fb8-7c82-4b9c-9d24-52ea38b920e5@kernel.org>
Content-Language: es-ES, en-US, ca
From: =?UTF-8?Q?Sergio_P=C3=A9rez?= <sergio@pereznus.es>
In-Reply-To: <ac008fb8-7c82-4b9c-9d24-52ea38b920e5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TlpjAaSb_haVx-e86dPkVYKTN84pQ3sC
X-Proofpoint-GUID: TlpjAaSb_haVx-e86dPkVYKTN84pQ3sC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_09,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1030 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2503180143


El 18/03/2025 a las 18:37, Krzysztof Kozlowski escribió:
> On 18/03/2025 18:26, Sergio Pérez wrote:
>> El 18/03/2025 a las 17:23, Krzysztof Kozlowski escribió:
>>> On 18/03/2025 17:21, Krzysztof Kozlowski wrote:
>>>> On 18/03/2025 17:06, Sergio Pérez wrote:
>>>>> El 18/03/2025 a las 16:16, Krzysztof Kozlowski escribió:
>>>>>> On 18/03/2025 15:16, Sergio Pérez wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> El 17/03/2025 a las 8:24, Krzysztof Kozlowski escribió:
>>>>>>>> On 16/03/2025 15:55, Sergio Perez wrote:
>>>>>>>>> Some BH1750 sensors require a hardware reset before they can be
>>>>>>>>> detected on the I2C bus. This patch adds support for an optional
>>>>>>>>> reset GPIO that can be specified in the device tree.
>>>>>>>>>
>>>>>>>>> The reset sequence pulls the GPIO low and then high before
>>>>>>>>> initializing the sensor, which enables proper detection with
>>>>>>>>> tools like i2cdetect.
>>>>>>>>>
>>>>>>>>> Update the devicetree binding documentation to include the new
>>>>>>>>> reset-gpios property with examples.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Sergio Perez <sergio@pereznus.es>
>>>>>>>> Please run scripts/checkpatch.pl and fix reported warnings. After that,
>>>>>>>> run also `scripts/checkpatch.pl --strict` and (probably) fix more
>>>>>>>> warnings. Some warnings can be ignored, especially from --strict run,
>>>>>>>> but the code here looks like it needs a fix. Feel free to get in touch
>>>>>>>> if the warning is not clear.
>>>>>> You keep ignoring paragraphs. Did you read this?
>>>>> I pass this check several times and every time I do any step to make
>>>>> sure I am well.
>>>>>
>>>>> scripts/checkpatch.pl -f drivers/iio/light/bh1750.c
>>>>> total: 0 errors, 0 warnings, 354 lines checked
>>>> That's not how you run checkpatch. Read the submitting patches. Just
>>>> like the name tells you, check the patch, you run it on the patch.
>>> BTW, I wonder which guideline told you to run it on the file? Because
>>> checkpatch description and submitting patches tell about running it on
>>> the patches, so I wonder where did you get suggestion to run it like that?
>> You're absolutely right. I misunderstood how to use checkpatch.pl and
>> was incorrectly running it on the source files instead of the patch
>> file. Thank you for pointing this out.
>>
>> $ scripts/checkpatch.pl --strict -f
> No '-f'. Don't use such argument. Almost never. Read the help:
>
> " -f
> Treat FILE as a regular source file. This option must be used when
> running checkpatch on source files in the kernel."
>
> so why do you want a patch file to be a regular source file? How would
> it ever work?
>
>> 0001-iio-light-bh1750-Add-hardware-reset-support-via-GPIO.patch
>> total: 0 errors, 0 warnings, 0 checks, 102 lines checked
>>
>> 0001-iio-light-bh1750-Add-hardware-reset-support-via-GPIO.patch has no
>> obvious style problems and is ready for submission.
> You have clear examples how to run it inside:
>
> https://docs.kernel.org/dev-tools/checkpatch.html
>
> "./scripts/checkpatch.pl mypatch.patch --types EMAIL_SUBJECT,BRACES"
>
> So:
> checkpatch.pl mypatch
>
>> I've now run the tool correctly on my patch file and have fixed the
>> identified issues:
>> - Removed trailing whitespace
>> - Fixed lines exceeding 79 characters
>> - Fixed the inconsistency between the description and example for
>> reset-gpios
>> - Modified the existing example instead of adding a new one
>> - Ensured proper line endings and formatting
>> - Used proper get_maintainers.pl to include all recipients
>>
> Please read the guides carefully. The process is extremely simple as:
>
> git add ...
> git commit --signed-off
> git format-patch -v3 -2
> scripts/chekpatch.pl v3*
> scripts/get_maintainers.pl --no-git-fallback v3*
> git send-email *
> (or just use my git_send_email for last two)
> (or just use b4 for last four)
>
> The burden of reading the contributing guides is on you. We documented
> all this on purpose, so we will not have to repeat this on every email.
Thank you very much, I have followed the instructions with total 
precision and carefully read all the documentation. I have submitted 
both patches as v4 version.
Apologies for the inconvenience.
>
> [1]
> https://github.com/search?q=repo%3Akrzk%2Ftools%20git_send_email&type=code
>
> Best regards,
> Krzysztof

