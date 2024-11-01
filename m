Return-Path: <linux-iio+bounces-11758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738A99B8FD7
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 11:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2A11F22A1D
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 10:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374C0176FA2;
	Fri,  1 Nov 2024 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dbAjmW5C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7801714BC;
	Fri,  1 Nov 2024 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730458625; cv=none; b=VrlYo5ct5UYoFJZb0Lh27sCoCExzg+92BrpqBiGHfRgi+BClnRe1Xp/3xTwNVaFuNxk1LB9EtID9nWNZxEUJwIrb4Kb4zuqNXyxyY0ALvxJJr3VOMdR2P6ZeV8ZW9Zl6oZ/dZyBTumIyE5Uuv0Fs0JSZ4TFH0s/kezhdKRrKPq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730458625; c=relaxed/simple;
	bh=in+hn4D17+str9yWgKks8piJDUKpP4SgZMTxn5xT41g=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ioFranc2e50lOW1UlqxkmEKBDO9ks714niKd4xM68OZXaBpgOMLygnaRkcYuB8L/GwqM3lqLSklPF3PVD0LdyvbAHN8SSDbLNwZS5vDz277KxlSfiNOcIyTkyZEFpdevUcvASRSGTu2AVM1ZycyVjvkIuboQFl5c8tmBgDzuwsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dbAjmW5C; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730458561; x=1731063361; i=markus.elfring@web.de;
	bh=in+hn4D17+str9yWgKks8piJDUKpP4SgZMTxn5xT41g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dbAjmW5CHzvdNrIFLygErgLmbeBdtghdhG8383EIgVzY8YNk34w3ZBvbr20610v3
	 2BVwMwPC/07v92MZHz76oukcLbswvtIByKk3kdEjUDbyI/kn1dIpnSignD71Ef53A
	 Zpy9ejCRFTK6d56ZIKKoQkdt/uaXnsEXXgAqxwYN9bdipmVKkJq1xflFPIs9tc/ib
	 MsVPDWuINLhIJkw43kF/R31unIpLB4e+OaSL6ZMZigIzzceYQEOfbpNK30FBIDP1X
	 Rkt6YzoYmRlIgu2LU3Rmc3TYB7Ytic77w2cmRK92pPq1HPZv4P7DVuGFvlXKpTHkY
	 +wr41/I+2xWDA0cM2w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4eGT-1toRjK27SJ-00vtmg; Fri, 01
 Nov 2024 11:56:01 +0100
Message-ID: <568c32d4-c555-4512-8b93-637cde04d0d3@web.de>
Date: Fri, 1 Nov 2024 11:56:00 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
References: <20241101081203.3360421-2-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/4] iio: light: ltr501: Assing ddata to NULL
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241101081203.3360421-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NlV6rrsWjeuUspjnIvOegbcU/y9LP6vJyl+59v+9NCfgfnmsy9c
 /3YjV7irkODux1aZ5Eh/taHG7b4NkWVCsncU4+RN7CpMrNXwnvureSI+PHrZD+3QAr6ELvn
 JJAiOuV+r6yODkgxjYWycajnSNcdhDJaKbS37JD00Dn+L44R1jX9hPckMjrWVloO8Jppr3t
 QRhHGRw6j+hRg2NhNbNIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I/X1U8sCkqw=;LP4VVBfK7LAVgpDtLofSop8GMl6
 bJEwNL5Xg//dCgIRwzyUR/n1R/MskXSC9h1a7SfPR665W0SJJgMLOhouxxMM7Si4ULxBovomH
 1BzAJo4RfcL1DfxAjmvwSxjvGNlwXEEngngBi8q5kB+9atxQO804SbTJI68Evd94bPhtqRKsi
 eaVpL4Q+Ujy3B3o+2Fmqaz77LCuh5kv4sBUJBXi637rZ8GHWgbMM7TtFkzQ1JcmQaOrxr1M1Z
 DPET7KCro3SXOfdChiu59JmTBr8u7HYyMwG1Is/1pAfBz/sbO92U2ucjdmBmt9sMWKOymP1vE
 xExEpKxjcWmgI7yzJ3l07drX1+7i2OHmCiqydngrXlWfQzYtNDzwyL4oMneZ3iCFGNYgPuuxU
 H6lmicuxaoc3ibZcWJGm0NtVZeCLrTeP2XTZ0l59SiAqTb7G7OS3BPqhS7Q72PxKvA0aDdADB
 ycBndIpgNNal8hpBfITwbnex/3tSIfMPbDTAqGAYF+7hpGVHDeUid7TYDTP/zRPMhJnUZyvqa
 O64oik5J2GHx7LFG76ifpj2mKusGbpM/IFrZaAzlh/Z2FRtfpEWTRMD+BQx9121+qAG9xafr2
 mmp4s4PN9tWZ+j/V6x7A1KuaRrT4K/nLLifu4e32lgcsTX7RMeot4kbNpYK20o58+xt7GBBJk
 wuPZNGrEzfgHG8lYAFVigtxKUWR0bmtmyvuYR1TUJ4NCQw4AmGoBtsGxG4KSh1cegSDQcl24J
 ar5KMnQMRhWPl8S1IkYRPln1xHsxT6nSabqu0X6zW0ok+kxxsDLUw4QPmzUouhEvdTTlLOJeq
 ODAvLwPAmLnuJCyml4EwpBqA==

> When iio_get_acpi_device_name_and_data() fails, the ddata may be left
> uninitialised. Initialise it to NULL.

Would you like to use the summary phrase =E2=80=9CAssign NULL to ddata in =
ltr501_probe()=E2=80=9D accordingly?

Regards,
Markus

