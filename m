Return-Path: <linux-iio+bounces-17108-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07413A694EC
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 17:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73D919C4A84
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 16:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C771DF996;
	Wed, 19 Mar 2025 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="PfJvWWpe"
X-Original-To: linux-iio@vger.kernel.org
Received: from p00-icloudmta-asmtp-us-central-1k-60-percent-6.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (p-east1-cluster3-host12-snip4-10.eps.apple.com [57.103.91.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4611A316D
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.91.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401629; cv=none; b=uXELtkHOvXRUyJUtK6c3RttlD+fNC6NtNtnANVYV5rHfR0y29vrkOLWxsyiaFNkMSQUXqUSRpNl8SRCBaCNTaKIsiKRG4SCfr3a5CKD7nDxpKb26wvXMeZZuihdQ3J66MXoRoXpPcq30rcpuuPyNg7K0UdYKd5cKVkr2wRw+hzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401629; c=relaxed/simple;
	bh=R/AqNGF+n1Pr/1jORJcVIU6MI0bPeDE9FByo14rxmf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+ypNK8U8MYrCDBP5fUXUH4nFwz6rB3G8lOYHFEP787lVXux7qbL/NV0W5OQQVf8VXrn0cfwHr5tLjMvmsIXkQIOjht+Sb+JUu7x0Y9/X7hjPWWD88wXQOXaO3QQ9bTKPMFhf3kElGCS8fKEzGz9hQvPW7Qnr0ZOpck3kM4Qt7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=PfJvWWpe; arc=none smtp.client-ip=57.103.91.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=zuaUt4WDVbRPvE3zxuUy5lHsR+yMR2v2V90gWAZfcOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=PfJvWWpeANC4tLpfcas09TbhS0LFGlp/mjT0TwR1vWt7B8peUejOhj6pyB5OMGeSi
	 hVK/fIlAR60reiD14WfrLA/iTWCfJqqiJN2ygZxxYUMNjjMe0qw3MhKKzKeUB9rI5e
	 rrezCRiCNu6BQ7jSD7GJ1sPaNqRZD0Ze3qNrqe1R/CG4Uwh0QLxMvNr6UGpGawpFpn
	 2q+kWt8dn/1wDUJzeH7CgRO1tdcm/RpGU+FUI9KgYjM2n2nLeuf97g5ZrNhcy/TWFw
	 RyHIwJwBtuc+IlRQqrHnk1fr1L8zNi7U+S9FXZGrhG/bEnjHU74/27hvWW/wsAXxlp
	 b/KFniFo71O7g==
Received: from [192.168.1.28] (ci-asmtp-me-k8s.p00.prod.me.com [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-6.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (Postfix) with ESMTPSA id BA8C1180085D;
	Wed, 19 Mar 2025 16:27:01 +0000 (UTC)
Message-ID: <4474831c-a8f6-496e-8348-a10e3fb7c798@pereznus.es>
Date: Wed, 19 Mar 2025 17:26:59 +0100
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
 <0507608a-91fd-4206-b921-942677c5f8d3@kernel.org>
Content-Language: es-ES, en-US, ca
From: =?UTF-8?Q?Sergio_P=C3=A9rez?= <sergio@pereznus.es>
In-Reply-To: <0507608a-91fd-4206-b921-942677c5f8d3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qCxJwGjxhIgel5iamZq8_k5btd4RoIaL
X-Proofpoint-ORIG-GUID: qCxJwGjxhIgel5iamZq8_k5btd4RoIaL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 clxscore=1030
 adultscore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2503190111


El 19/03/2025 a las 9:46, Krzysztof Kozlowski escribió:
> On 18/03/2025 18:37, Krzysztof Kozlowski wrote:
>>> I've now run the tool correctly on my patch file and have fixed the
>>> identified issues:
>>> - Removed trailing whitespace
>>> - Fixed lines exceeding 79 characters
>>> - Fixed the inconsistency between the description and example for
>>> reset-gpios
>>> - Modified the existing example instead of adding a new one
>>> - Ensured proper line endings and formatting
>>> - Used proper get_maintainers.pl to include all recipients
>>>
>> Please read the guides carefully. The process is extremely simple as:
>>
>> git add ...
>> git commit --signed-off
>> git format-patch -v3 -2
>> scripts/chekpatch.pl v3*
>> scripts/get_maintainers.pl --no-git-fallback v3*
>> git send-email *
> Please read this again. I gave you detailed instruction which you still
> decided not to follow. The instructions are quite precise on purpose,
> because other method leads to wrong patchset - broken that or other way.
>
I transcribe exactly the commands I have executed:

$ git add Documentation/devicetree/bindings/iio/light/bh1750.yaml

$ git commit --signed-off

$ git add drivers/iio/light/bh1750.c

$ git commit --signed-off

$ git format-patch -v3 -2

$ scripts/checkpatch.pl v3*
---------------------------------------------------------------
v3-0001-dt-bindings-iio-light-bh1750-Add-reset-gpios-prop.patch
---------------------------------------------------------------
total: 0 errors, 0 warnings, 17 lines checked

v3-0001-dt-bindings-iio-light-bh1750-Add-reset-gpios-prop.patch has no obvious style problems and is ready for submission.
---------------------------------------------------------------
v3-0002-iio-light-bh1750-Add-hardware-reset-support-via-G.patch
---------------------------------------------------------------
total: 0 errors, 0 warnings, 47 lines checked

v3-0002-iio-light-bh1750-Add-hardware-reset-support-via-G.patch has no obvious style problems and is ready for submission.

$ scripts/get_maintainer.pl --no-git-fallback v3*
Tomasz Duszynski <tduszyns@gmail.com> (maintainer:ROHM BH1750 AMBIENT 
LIGHT SENSOR DRIVER,in file)
Jonathan Cameron <jic23@kernel.org> (maintainer:IIO SUBSYSTEM AND DRIVERS)
Lars-Peter Clausen <lars@metafoo.de> (reviewer:IIO SUBSYSTEM AND DRIVERS)
Rob Herring <robh@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED 
DEVICE TREE BINDINGS)
Krzysztof Kozlowski <krzk+dt@kernel.org> (maintainer:OPEN FIRMWARE AND 
FLATTENED DEVICE TREE BINDINGS)
Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND 
FLATTENED DEVICE TREE BINDINGS)
linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE 
TREE BINDINGS)
linux-kernel@vger.kernel.org (open list)

$ git_send_email v3*
v3-0001-dt-bindings-iio-light-bh1750-Add-reset-gpios-prop.patch
v3-0002-iio-light-bh1750-Add-hardware-reset-support-via-G.patch
(mbox) Adding cc: Sergio Perez <sergio@pereznus.es> from line 'From: 
Sergio Perez <sergio@pereznus.es>'
(body) Adding cc: Sergio Perez <sergio@pereznus.es> from line 
'Signed-off-by: Sergio Perez <sergio@pereznus.es>'

From: Sergio Perez <sergio@pereznus.es>
To: Tomasz Duszynski <tduszyns@gmail.com>,
         Jonathan Cameron <jic23@kernel.org>,
         Lars-Peter Clausen <lars@metafoo.de>,
         Rob Herring <robh@kernel.org>,
         Krzysztof Kozlowski <krzk+dt@kernel.org>,
         Conor Dooley <conor+dt@kernel.org>,
         linux-iio@vger.kernel.org,
         devicetree@vger.kernel.org,
         linux-kernel@vger.kernel.org
Cc: Sergio Perez <sergio@pereznus.es>
Subject: [PATCH v3 1/2] dt-bindings: iio: light: bh1750: Add reset-gpios 
property
Date: Wed, 19 Mar 2025 17:11:16 +0100
Message-ID: <20250319161117.1780-1-sergio@pereznus.es>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

     The Cc list above has been expanded by additional
     addresses found in the patch commit message. By default
     send-email prompts before sending whenever this occurs.
     This behavior is controlled by the sendemail.confirm
     configuration setting.

     For additional information, run 'git send-email --help'.
     To retain the current behavior, but squelch this message,
     run 'git config --global sendemail.confirm auto'.

Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): y
OK. Log says:
Server: smtp.mail.me.com
MAIL FROM:<sergio@pereznus.es>
RCPT TO:<tduszyns@gmail.com>
RCPT TO:<jic23@kernel.org>
RCPT TO:<lars@metafoo.de>
RCPT TO:<robh@kernel.org>
RCPT TO:<krzk+dt@kernel.org>
RCPT TO:<conor+dt@kernel.org>
RCPT TO:<linux-iio@vger.kernel.org>
RCPT TO:<devicetree@vger.kernel.org>
RCPT TO:<linux-kernel@vger.kernel.org>
RCPT TO:<sergio@pereznus.es>
From: Sergio Perez <sergio@pereznus.es>
To: Tomasz Duszynski <tduszyns@gmail.com>,
         Jonathan Cameron <jic23@kernel.org>,
         Lars-Peter Clausen <lars@metafoo.de>,
         Rob Herring <robh@kernel.org>,
         Krzysztof Kozlowski <krzk+dt@kernel.org>,
         Conor Dooley <conor+dt@kernel.org>,
         linux-iio@vger.kernel.org,
         devicetree@vger.kernel.org,
         linux-kernel@vger.kernel.org
Cc: Sergio Perez <sergio@pereznus.es>
Subject: [PATCH v3 1/2] dt-bindings: iio: light: bh1750: Add reset-gpios 
property
Date: Wed, 19 Mar 2025 17:11:16 +0100
Message-ID: <20250319161117.1780-1-sergio@pereznus.es>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: 250
(mbox) Adding cc: Sergio Perez <sergio@pereznus.es> from line 'From: 
Sergio Perez <sergio@pereznus.es>'
(body) Adding cc: Sergio Perez <sergio@pereznus.es> from line 
'Signed-off-by: Sergio Perez <sergio@pereznus.es>'

From: Sergio Perez <sergio@pereznus.es>
To: Tomasz Duszynski <tduszyns@gmail.com>,
         Jonathan Cameron <jic23@kernel.org>,
         Lars-Peter Clausen <lars@metafoo.de>,
         Rob Herring <robh@kernel.org>,
         Krzysztof Kozlowski <krzk+dt@kernel.org>,
         Conor Dooley <conor+dt@kernel.org>,
         linux-iio@vger.kernel.org,
         devicetree@vger.kernel.org,
         linux-kernel@vger.kernel.org
Cc: Sergio Perez <sergio@pereznus.es>
Subject: [PATCH v3 2/2] iio: light: bh1750: Add hardware reset support 
via GPIO
Date: Wed, 19 Mar 2025 17:11:17 +0100
Message-ID: <20250319161117.1780-2-sergio@pereznus.es>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319161117.1780-1-sergio@pereznus.es>
References: <20250319161117.1780-1-sergio@pereznus.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): y
OK. Log says:
Server: smtp.mail.me.com
MAIL FROM:<sergio@pereznus.es>
RCPT TO:<tduszyns@gmail.com>
RCPT TO:<jic23@kernel.org>
RCPT TO:<lars@metafoo.de>
RCPT TO:<robh@kernel.org>
RCPT TO:<krzk+dt@kernel.org>
RCPT TO:<conor+dt@kernel.org>
RCPT TO:<linux-iio@vger.kernel.org>
RCPT TO:<devicetree@vger.kernel.org>
RCPT TO:<linux-kernel@vger.kernel.org>
RCPT TO:<sergio@pereznus.es>
From: Sergio Perez <sergio@pereznus.es>
To: Tomasz Duszynski <tduszyns@gmail.com>,
         Jonathan Cameron <jic23@kernel.org>,
         Lars-Peter Clausen <lars@metafoo.de>,
         Rob Herring <robh@kernel.org>,
         Krzysztof Kozlowski <krzk+dt@kernel.org>,
         Conor Dooley <conor+dt@kernel.org>,
         linux-iio@vger.kernel.org,
         devicetree@vger.kernel.org,
         linux-kernel@vger.kernel.org
Cc: Sergio Perez <sergio@pereznus.es>
Subject: [PATCH v3 2/2] iio: light: bh1750: Add hardware reset support 
via GPIO
Date: Wed, 19 Mar 2025 17:11:17 +0100
Message-ID: <20250319161117.1780-2-sergio@pereznus.es>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319161117.1780-1-sergio@pereznus.es>
References: <20250319161117.1780-1-sergio@pereznus.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: 250

>> (or just use my git_send_email for last two)
>> (or just use b4 for last four)
>>
>> The burden of reading the contributing guides is on you. We documented
>> all this on purpose, so we will not have to repeat this on every email.
>>
>>
>> [1]
>> https://github.com/search?q=repo%3Akrzk%2Ftools%20git_send_email&type=code
>>
>> Best regards,
>> Krzysztof
>
> Best regards,
> Krzysztof

