Return-Path: <linux-iio+bounces-11776-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 925409B92D9
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 15:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 184D3B221B5
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 14:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A1C1A0BCA;
	Fri,  1 Nov 2024 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WBVTfzp5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0A5168DA;
	Fri,  1 Nov 2024 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730470267; cv=none; b=StMsvykmNOyv8Fyn+doGw35DoGm1KqPW3XYQwEvbxZdOSFANisr5vsk+8CmLTty+b4t4cVNQc4g5CXXiejwFrzSKAe2q0kVWQIi8ZI0fXpc0wt/GRNnUzyshlhIjut2oiWLCBh5gidM6AoKcgQbgPR4adqHGPio5iAoCnSeaEfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730470267; c=relaxed/simple;
	bh=nFTE0md2plR/u8DmQpPb/sZJfUQKp333ZysPDV7a+wo=;
	h=Message-ID:Date:MIME-Version:To:References:Subject:From:Cc:
	 In-Reply-To:Content-Type; b=fVcWYFT6pAQYQEGBv5pO6ipEXnaLpBq/58Rxc6/uZScc0a4wnOxWM+qgdp7/CHn/XYVLt8zyXPdIHVXQB41BNRtkdMeFn222QG9bB+lcxcW3N0Wll44pcHpEEGRuydX7Tv0kwjanf1e1M/F9ZLPamGrlpkuerD3ayXG1roI1Cv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WBVTfzp5; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730470240; x=1731075040; i=markus.elfring@web.de;
	bh=IUN+21XUdx0D7TRFSW4Xqcgxad6GqKaepgiFnelIDWU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:References:
	 Subject:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WBVTfzp5MvhSNEk00Vorr4qm3bdw0rNIeZ+43NBpHQ4Di9wlKwYUBsNJ72SGcisM
	 0JR2MAmQeGrUhDUYMHwom64VMAei9g427jA6U8nwh5zqKD6iIX9mgYsCxNkpC7T4d
	 ILPfFf+xHiUle9mmkQrSAUUsRXoddlH6mm8F88cTJcMZgcMPJiy61zms59luL3Bbo
	 i6dQ1ZvdFnK6elxzfFb8D+2kqrw4EcsUvfFOWi554qmuxnKuUOJwJhv2WQUsoO/95
	 7dQDXLHAc84VB87azSNod1ounV2wXI/KWIMR0PhSRe37TauDnqxklOA97ArIDSaFe
	 T4ZcrJ/lIqlRhq8F7g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgRM5-1tmIBz0yVj-00iw9e; Fri, 01
 Nov 2024 15:10:40 +0100
Message-ID: <c8405b33-8c7a-47c3-afd5-2e6c7e951cb4@web.de>
Date: Fri, 1 Nov 2024 15:10:38 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>, linux-iio@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <54fac4a7-b601-40ce-8c00-d94807f5e214@stanley.mountain>
Subject: Re: [bug report] iio: light: isl29018: Replace a variant of
 iio_get_acpi_device_name_and_data()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <54fac4a7-b601-40ce-8c00-d94807f5e214@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6q34kpsCcpA5Ye04U3KFQUXXNwEFjFKdmiMeR9SBS4Q+4CzznAe
 Zzi/S9PoYutlJk1c7gmBFn5BZIhkOVJhEQaDoXuc5Q92fVEDxVT8CMrdn40B1AnHABOrhLx
 2qWq95hCd2Td7GuOr2tHZQQsZlAP7ng8LGKxeyvqRvwszfFx9A23hECBSckMnnJq0xePm6s
 U9NoSplcGyFcePb2RipKA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5iGr9/A8ZhY=;i1AqHaC3Tf81p4DZ+pmB/D7MNkI
 vxlUEaPQ+iMA/WvE/hfjghQrbxv1lykZvHalwb05WNjUp+I2TIWcZSgbdUKrkpGZlyOMqhnSX
 2Zg0PNAaWYJGErlfBscwyyL1NO83ocCOB5xyZdK6hpmTF+X5BzldSNr6+r8XO3hQhAX1BUlQO
 oYWNSRk/sBGRuNAnck/ds0pmvYdjMEk8jyWTmErM5VK2qmcBhMVs61Eo+TZtj7tgXW1LFi38+
 0/VRXL7LR4/AxNuK6IuLmNyNFkb8N9Dn9SHEPg+UHnmP8Ga2IA4cvNo0soEbnd4RWSef09KDn
 XkFIkRummcj9Dk/nhD6qKq8TNMEtK5ZU0UcP6oXMiqBkPq1pHtPO1+6ubYQcJmGjDgiYuT0YD
 yc9bsUTdI+XMaLbnnlFhKXuCVmI3AHu03Y4BpRKqCwnBSRh7GQH9SLtkvWwLgCzaU/Od5wwEU
 KEa9/L8dFIguajOhCwHd34sE1Th7DcRQZ5n/q7U4chgNRBjcHae2CSiI5EG2WCSFZKcGb0aps
 CoRr1FLaYAgOlEIVROq+BFxnuDggG51XoP+LWEhtoT4HgWAoF6vjlBFLJ9CprIGRWABtDjlBP
 /Z5v3QvUeqR5ryp7+FslSDF0cx9kGR1cjXFfEPfnXF0+x9a2aiSzAonjfFcgTMGxQM1+vLI3D
 7eQ6P7ITrJzw1WQo+j69f3RfSJnk1xmh71nh1q9AuUis5YN5/CY7gR3jxbWM/a5EcZ5vuoI6B
 0mqaE+6/Uj9rFffsYcKoMg0/zQgoBIrqDOBC7zDyedHhOcPkbxStkm9/z/x4C4OHHmqF2tKuR
 VQ5PLtpJO8yyPHqTlWdNkbdg==

> Commit 14686836fb69 ("iio: light: isl29018: Replace a variant of
> iio_get_acpi_device_name_and_data()") from Oct 24, 2024 (linux-next),
> leads to the following Smatch static checker warning:
>
>     drivers/iio/light/isl29018.c:724 isl29018_probe() error: uninitializ=
ed symbol 'ddata'.
>     drivers/iio/light/ltr501.c:1514 ltr501_probe() error: uninitialized =
symbol 'ddata'.
=E2=80=A6

How do you think about to extend the mentioned source code analysis tool a=
ny more?

See also further development ideas:
* ltr501_probe()
  https://lore.kernel.org/linux-kernel/8c7a5bcc-1fdb-45af-8f0c-1f9b6f0cf05=
8@web.de/
  https://lkml.org/lkml/2024/11/1/745

* isl29018_probe()
  Is there a need to perform a null pointer check also with the local vari=
able =E2=80=9Cname=E2=80=9D

Regards,
Markus

