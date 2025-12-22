Return-Path: <linux-iio+bounces-27322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8DCCD6AFE
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 17:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C018301398F
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 16:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A98A32D42D;
	Mon, 22 Dec 2025 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="mkcttAng"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707DD10E3;
	Mon, 22 Dec 2025 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766421586; cv=none; b=Y0s71NghG4ZowBsa3JLcVsF/7Bi8p7xmtIxNZkMd9xSHvoHzLgf75HEitwTteq3ozaRHD4Yqwn3ikQDof/aGFlu5ikVv7BIi7PsLfBb9cvvSjfQHyuU0K02voiypQ05rs6EZPii+54kQnZ+vjMBGvxnVXcsXLy26wxKL1gxpfSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766421586; c=relaxed/simple;
	bh=K49OvOpuue/TmCtRWjAoDLoic5PDcebSwxVXKzQyYKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ReT7U3ZVQdZIGTVQpFhuDUxt9tjPrKt4ZTJ8C+VkSNEFZAbEhuQdYkWcywXd635HrVNcMu9mNcrfIr9RFZkkMNBQzCyRszAEvx1N7mP8VC+nhHOaAkPtctkx35MTssB7JZaXvfmq7t1iH9qiaoFuPYPfoha1Cucts5JfN2v3WDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=mkcttAng; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1766421577; x=1767026377; i=fiona.klute@gmx.de;
	bh=K49OvOpuue/TmCtRWjAoDLoic5PDcebSwxVXKzQyYKY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mkcttAng9oQkDno7+DyHJgvYo61LAJSsSJys6fhlIvm9E46dvseAwzXxyqF3LRBn
	 w/t/bkgwCtalr0jyVjZGbvKsh3vMt1WxSIdEmZmWksOnKqakIAsQYen3oGDqoy+zX
	 13HPGMhQ6SDL/W/4aUrRX7BMThVMRS8Gv4AOsrMrVxep4SvqMV/mIEX8FpH7nmBid
	 UrcRvIbkJVuMpvUSikBvUyO7n4P8L2pND7KZJajYRuhVWxBZGYj3A4ojdMpjYlQYA
	 DSyLSst2gfwDiCqDrMsddMqhYi5MPktO7NwFlRW495iYib1w6jqaCDEEd1rRloa46
	 Y6lDF1EfJXqm/J5uVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.123.109]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnJhO-1wGv8P11qG-00nKcB; Mon, 22
 Dec 2025 17:39:37 +0100
Message-ID: <08059e1e-4e6c-4493-8c00-294b50fad821@gmx.de>
Date: Mon, 22 Dec 2025 17:39:35 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: chemical: scd4x: expose timestamp channel
To: Jonathan Cameron <jic23@kernel.org>
Cc: Roan van Dijk <roan@protonic.nl>, linux-iio@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20251218151205.1301792-1-fiona.klute@gmx.de>
 <20251221180508.252bd6d9@jic23-huawei>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <20251221180508.252bd6d9@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:abVOIutORZFCooCS4RuvgBvQInmO1z1ZbZtaFkLQQiPpZ4gJjbF
 BP8zHiAB3OOXeuXGVL7PF+af3wtNU7h/Z27H9LBOwgzLTIxnQRfgsh8UvkFhhwW2kpOZv1O
 uTC7Py7NwOHQwpk7JtC57Kh9iYNwWkRrW9kuwBmjM8izrR08nbk19hwSAEF5/iEKi4WAPcW
 XUGmcLgHuwYSP8Ciz5Gtg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jfCe3ibrKMU=;+qQaWm1Yn6qt4hb5LK3Cc9cPnq9
 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
 IUA231FmIV67yHmbpG8PpgTc2p4kT

Am 21.12.25 um 19:05 schrieb Jonathan Cameron:
> On Thu, 18 Dec 2025 16:12:05 +0100
> Fiona Klute <fiona.klute@gmx.de> wrote:
>=20
>> Timestamps were already written to the buffer in
>> scd4x_trigger_handler(), this patch makes them available as a channel.
>>
>> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> Applied to the togreg branch of iio.git. Initially pushed out as testing
> to let 0-day have a brief look at it.
Thank you! Could you also pick my channel endianness fix for the scd4x=20
driver [1]? The patches apply independently, but timestamps aren't going=
=20
to be very useful as long as the data that goes with them is incorrect.=20
Or does that need to go via a different tree as a bugfix?

Best regards,
Fiona


[1]=20
https://lore.kernel.org/linux-iio/20251213163226.1678707-1-fiona.klute@gmx=
.de/T/


