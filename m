Return-Path: <linux-iio+bounces-17035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C7BA67B13
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 18:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80CF73B11E7
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 17:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6206120F091;
	Tue, 18 Mar 2025 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crlMW7EN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F8A191F92;
	Tue, 18 Mar 2025 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319433; cv=none; b=oDwGRppWLZNJrnNexAQByavzamKHoudPW4UFjkzPmwWBxO/inFzttZh2P4OSj1+6QOuObGrJEUt5oFJdm1nhqL/YVqMBcTfNkjkzqNYCiBzNb7V/N1d5x0OKxXGVAUbMTAwSdE+6hzmC2Ie3IOzIrYVsIYgqctv6F1kgRmEKhVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319433; c=relaxed/simple;
	bh=gXlZ04TNi6BdAORunw0TRVBZrqAfCSgdDt4ZyQnX1q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4wX/nuwZwD6lYY/bB6XAHGqBJnZv2Q0NZHXhdMxjeGi8aQN0Z2ryj32/RY8a4z7YGTOTBMQLdOlIavb6JPAi1zfaU8kg0r7RvmLoZZiXtn0ehBzJRP+VDk41fOHr/ibGcIoJuJ2ESs/8uBPNGyuJ7Xi8fiJoRpyM5FfH/0V9zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crlMW7EN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11453C4CEDD;
	Tue, 18 Mar 2025 17:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742319432;
	bh=gXlZ04TNi6BdAORunw0TRVBZrqAfCSgdDt4ZyQnX1q4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=crlMW7ENkmfw0zyiiFapwi+F95vb+3xLrvOW4RYDL7JiP/f3ZslD0IW909i0gsPgv
	 3k/SqYBJlmKRy6qWWZKwW76mSwKmQfRh2HbLg8YX/2Spg+9KCIwgvlb2LU6m3qGjWg
	 H63jAvquT1VF7ekMVF8tnGluKezEXONBKI3AHHo3Y1upORCKFRmUOp1dOc1xt/sfEW
	 RzijJkhWhzh2L7qxehX9XG8Hm9ndHtGbFmC7e5XrOnX1wh5OPN2V49zwKOt6bLzNev
	 eSugsVoKr0x5YXJC2GMOXjrTPEyDWQXTQI4m3L5A3vU64p927vO3HvSiGv4UdeDYAU
	 NBWy2t61bmnPg==
Message-ID: <ac008fb8-7c82-4b9c-9d24-52ea38b920e5@kernel.org>
Date: Tue, 18 Mar 2025 18:37:06 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: bh1750: Add hardware reset support via GPIO
To: =?UTF-8?Q?Sergio_P=C3=A9rez?= <sergio@pereznus.es>,
 linux-iio@vger.kernel.org
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <bf16371c-189c-4e51-91e5-129f1dcad317@pereznus.es>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/03/2025 18:26, Sergio Pérez wrote:
> 
> El 18/03/2025 a las 17:23, Krzysztof Kozlowski escribió:
>> On 18/03/2025 17:21, Krzysztof Kozlowski wrote:
>>> On 18/03/2025 17:06, Sergio Pérez wrote:
>>>> El 18/03/2025 a las 16:16, Krzysztof Kozlowski escribió:
>>>>> On 18/03/2025 15:16, Sergio Pérez wrote:
>>>>>> Hello,
>>>>>>
>>>>>> El 17/03/2025 a las 8:24, Krzysztof Kozlowski escribió:
>>>>>>> On 16/03/2025 15:55, Sergio Perez wrote:
>>>>>>>> Some BH1750 sensors require a hardware reset before they can be
>>>>>>>> detected on the I2C bus. This patch adds support for an optional
>>>>>>>> reset GPIO that can be specified in the device tree.
>>>>>>>>
>>>>>>>> The reset sequence pulls the GPIO low and then high before
>>>>>>>> initializing the sensor, which enables proper detection with
>>>>>>>> tools like i2cdetect.
>>>>>>>>
>>>>>>>> Update the devicetree binding documentation to include the new
>>>>>>>> reset-gpios property with examples.
>>>>>>>>
>>>>>>>> Signed-off-by: Sergio Perez <sergio@pereznus.es>
>>>>>>> Please run scripts/checkpatch.pl and fix reported warnings. After that,
>>>>>>> run also `scripts/checkpatch.pl --strict` and (probably) fix more
>>>>>>> warnings. Some warnings can be ignored, especially from --strict run,
>>>>>>> but the code here looks like it needs a fix. Feel free to get in touch
>>>>>>> if the warning is not clear.
>>>>> You keep ignoring paragraphs. Did you read this?
>>>> I pass this check several times and every time I do any step to make
>>>> sure I am well.
>>>>
>>>> scripts/checkpatch.pl -f drivers/iio/light/bh1750.c
>>>> total: 0 errors, 0 warnings, 354 lines checked
>>>
>>> That's not how you run checkpatch. Read the submitting patches. Just
>>> like the name tells you, check the patch, you run it on the patch.
>> BTW, I wonder which guideline told you to run it on the file? Because
>> checkpatch description and submitting patches tell about running it on
>> the patches, so I wonder where did you get suggestion to run it like that?
> You're absolutely right. I misunderstood how to use checkpatch.pl and 
> was incorrectly running it on the source files instead of the patch 
> file. Thank you for pointing this out.
> 
> $ scripts/checkpatch.pl --strict -f 

No '-f'. Don't use such argument. Almost never. Read the help:

" -f
Treat FILE as a regular source file. This option must be used when
running checkpatch on source files in the kernel."

so why do you want a patch file to be a regular source file? How would
it ever work?

> 0001-iio-light-bh1750-Add-hardware-reset-support-via-GPIO.patch
> total: 0 errors, 0 warnings, 0 checks, 102 lines checked
> 
> 0001-iio-light-bh1750-Add-hardware-reset-support-via-GPIO.patch has no 
> obvious style problems and is ready for submission.

You have clear examples how to run it inside:

https://docs.kernel.org/dev-tools/checkpatch.html

"./scripts/checkpatch.pl mypatch.patch --types EMAIL_SUBJECT,BRACES"

So:
checkpatch.pl mypatch

> 
> I've now run the tool correctly on my patch file and have fixed the 
> identified issues:
> - Removed trailing whitespace
> - Fixed lines exceeding 79 characters
> - Fixed the inconsistency between the description and example for 
> reset-gpios
> - Modified the existing example instead of adding a new one
> - Ensured proper line endings and formatting
> - Used proper get_maintainers.pl to include all recipients
> 

Please read the guides carefully. The process is extremely simple as:

git add ...
git commit --signed-off
git format-patch -v3 -2
scripts/chekpatch.pl v3*
scripts/get_maintainers.pl --no-git-fallback v3*
git send-email *
(or just use my git_send_email for last two)
(or just use b4 for last four)

The burden of reading the contributing guides is on you. We documented
all this on purpose, so we will not have to repeat this on every email.


[1]
https://github.com/search?q=repo%3Akrzk%2Ftools%20git_send_email&type=code

Best regards,
Krzysztof

