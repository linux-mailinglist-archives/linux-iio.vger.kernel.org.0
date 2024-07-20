Return-Path: <linux-iio+bounces-7756-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AAB938215
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 18:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6EC1F2153B
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 16:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA1A13DDA8;
	Sat, 20 Jul 2024 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="otOsN3cz"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA4C1DDF6
	for <linux-iio@vger.kernel.org>; Sat, 20 Jul 2024 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721492554; cv=none; b=i31jXyZoDfoXWAyEmlJ7+dg5NTMWu7PYyHRfXlxgFqQh2/rKXBDp/aKjahna9G3tKyjE9qPQCXAJVNbBd4Bc0E7b/FAzQDqBBjTb+PTVPsv8Wc4X8ANJI8CFSvOdRI4yPqunkuaa6n60Pzz/+FNWcqhljnIbAmt57j3U0+I1WSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721492554; c=relaxed/simple;
	bh=Q+FRww8lMVvgUN4jlKgDnjk28Mc/z3098gxjt4z3iHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwG8izw4NgniZditVt9uxMXSp57LqilR3uXsvGiOEW7MmqTUJ1PdD+pkWoC22gIxwZvIlrRj8DbXMYy8Kkrzc/o9ng+eFJxNsHAdiG/P2UryBeSXwcouTLo4JBFg1RxbKX9Tbh1aKAiwgPNMYAqMXDE3gvMlZcrhLiSqc1tllJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=otOsN3cz; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 6BB23886B3;
	Sat, 20 Jul 2024 18:22:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721492544;
	bh=miKU7LtSpPcKmy1J0MPamCTU/IjDnOhJOe9UCOTOG40=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=otOsN3cz4b+LhLqA1NwVWJ4J2O7MM2oScqD35fcBOi6YpZ+YelsqfAgCScScDtCaQ
	 rBZvgBiX2kWUuNkGOLp6A2rwGNv8V7bdGKk3AbmJzSUaA+etlGd471Fji5fcQVNGtu
	 77LAZiRXrZAH8tZell+ZQ6jwoT7i1oEqfFKJi2qxWRpLQJlCaAPdIq1JcOrlfzTUYs
	 PyqFcFsbKRQz6MpVsoXEav5q/HQZqpeaB6IQBKSkZ4GItEIw8h8zl0z7Ungo/rf54Q
	 KIe3LyXkelY5aO35ceYdNuAQ6VmYucCdueYGbXs75+lp5oxMSdMVVAr3EshGZR2fhg
	 EpUY1MOn0I6oQ==
Message-ID: <28fadb46-acbd-47d6-906d-2ac4b99db79d@denx.de>
Date: Sat, 20 Jul 2024 18:22:23 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] iio: light: noa1305: Simplify noa1305_read_raw()
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Lars-Peter Clausen <lars@metafoo.de>
References: <20240715183120.143417-1-marex@denx.de>
 <20240720142928.7a913229@jic23-huawei>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240720142928.7a913229@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 7/20/24 3:29 PM, Jonathan Cameron wrote:
> On Mon, 15 Jul 2024 20:28:55 +0200
> Marek Vasut <marex@denx.de> wrote:
> 
>> The only channel this hardware supports is IIO_LIGHT, if the channel
>> is anything else, exit right away. The 'ret' variable is now always
>> only assigned by noa1305_measure(), do not initialize it anymore.
>> Update function parameter indent. No functional change.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> Hi Marek,
> 
> One minor thing - please use a cover letter.
> Provides an obvious place for me to reply when picking things up and
> gives the whole series a meaningful title in patchwork.

I will keep that in mind, thanks for the reminder.

