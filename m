Return-Path: <linux-iio+bounces-24629-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BFABB0C20
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 16:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B74189E2F7
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 14:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3383C25A343;
	Wed,  1 Oct 2025 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="m68wZtvJ";
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="m68wZtvJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from h2.cmg2.smtp.forpsi.com (h2.cmg2.smtp.forpsi.com [81.2.195.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D622686A0
	for <linux-iio@vger.kernel.org>; Wed,  1 Oct 2025 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.2.195.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329778; cv=none; b=Y6zNd46OSndf5IXsbjB58llGCvYX1Ur3xDXhoopo/8lAQ8W/pSqiE8KLjkCb7yQJSVfoy4xCiIDqsxaCNJmPA2jEDF+aiEBSgS3NAYMVx923RqRDLdoMz7BMKCcbBs1Id2kuuFidJizsTMMKFJMbQFvPOOBdcBWcuKK8H6BbcnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329778; c=relaxed/simple;
	bh=Fzdt491G0bQkcMF36b+uxdUR7tXQvpCfoJ2sb6gR3eE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iwt9+S0K+wkDumZFp4Gy+s8WcoMDEpltaiMjpLN2h+AkVKlClysyRz3CZZsyMsCEZS6c4xM/+bY41B5MPC5hV/HAt+YOcc2/kgrE+egatcxutb7dhiLc0nKqbK3i3ts9ZdDK6hFn9cml+qQFc+Gb0p9JcT8O+8Jfcz2bO8hUNlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu; spf=none smtp.mailfrom=skyrain.eu; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=m68wZtvJ; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=m68wZtvJ; arc=none smtp.client-ip=81.2.195.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=skyrain.eu
Received: from [192.168.10.89] ([92.180.235.211])
	by cmgsmtp with ESMTPSA
	id 3y2XvWCf8C4IT3y2XvzJpX; Wed, 01 Oct 2025 16:42:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1759329766; bh=HffN2JKM12HNyB31P3t988otbP4OjkwLQMeTuvlH7xY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=m68wZtvJ0Xc48Lp88iSdD1XePb87l/JqckFZXJoht3P0y54jgqSlUTaAxFqusdqf6
	 7KxkkEE/t2cGBTFBwrDDtBJ15R9F+oXEZVSaCinC7P5xVWqnE7oYhyeHlc9+pgDHSL
	 bC3SBu5D507MG3PjSyTWi22VnikzASG8+Tnv7Vv/AKH3jW4ALcR2eAF4Nz+rPf2v2s
	 EoRLX06aIx/y0OFrkN/5dy4Q20eJDnlEu/JHdHqlmZYyxw6IunZlkTtsw1qUJZ2fOy
	 Iti3Nn/i4NITKt3vsAC+xhfB2UVVgw81GRJ4/nse8WLB4kgwbKVA6P96PAcT+7UmrH
	 pf42nIciJJv0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1759329766; bh=HffN2JKM12HNyB31P3t988otbP4OjkwLQMeTuvlH7xY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=m68wZtvJ0Xc48Lp88iSdD1XePb87l/JqckFZXJoht3P0y54jgqSlUTaAxFqusdqf6
	 7KxkkEE/t2cGBTFBwrDDtBJ15R9F+oXEZVSaCinC7P5xVWqnE7oYhyeHlc9+pgDHSL
	 bC3SBu5D507MG3PjSyTWi22VnikzASG8+Tnv7Vv/AKH3jW4ALcR2eAF4Nz+rPf2v2s
	 EoRLX06aIx/y0OFrkN/5dy4Q20eJDnlEu/JHdHqlmZYyxw6IunZlkTtsw1qUJZ2fOy
	 Iti3Nn/i4NITKt3vsAC+xhfB2UVVgw81GRJ4/nse8WLB4kgwbKVA6P96PAcT+7UmrH
	 pf42nIciJJv0A==
Message-ID: <75c1c820-d1bb-4053-8b51-ec6f409a3e3c@skyrain.eu>
Date: Wed, 1 Oct 2025 16:42:45 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: iio: accel: fix ADX355 startup race condition
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Puranjay Mohan <puranjay@kernel.org>,
 Kessler Markus <markus.kessler@hilti.com>
References: <20250909085528.68966-1-andrej.v@skyrain.eu>
 <20250910193049.145aa79e@jic23-huawei>
 <6ee57754-4fa0-4694-b997-5f4c627b567b@skyrain.eu>
 <20250912151259.00006fd5@huawei.com>
 <b709ac66-d0f2-4eb9-a66b-be557b4fe2be@skyrain.eu>
 <20250915165313.000041fa@huawei.com>
 <722b91bc-fce7-4e1f-811f-aea30e130f15@skyrain.eu>
 <e4ac030c-8ce1-4b71-9b37-a2d304defdfa@skyrain.eu>
 <CAMknhBFSG8B+yJNAjeFpFC+K8iRkQrWczy1FPyxsQrxxdDCudg@mail.gmail.com>
Content-Language: en-US
From: Andrej Valek <andrej.v@skyrain.eu>
In-Reply-To: <CAMknhBFSG8B+yJNAjeFpFC+K8iRkQrWczy1FPyxsQrxxdDCudg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFao/+zQ3/x7U+tKb7xbluS/J2QdAhmu7hOCUoyryN2WCdafw5X7M3Y2fw77lGyf8eMwMMj7qy1amDcj6NLdo/r+0vW5Jz9/B6mM6ay+XZax1l+2rkc6
 6VplMCz46F/iPo05JvcEDlNtL995vJ0gwPmZ3tiILGeyMNf6NSqrOHQrI3A2Kun8Pp8nAJx/pvv0AdFF012UhrjgrZBcBosghviFrHuPqkTNvQ/Jd6HVUFr3
 RijcEnMJRw70R46Ihqqik+gPolbdJ1u2q9Fp+dJYpzmlsuohSJHpkwZ0nHcJVj9/+TYO+Pe98DMyqzhTZgmIPVBem+IGVc0HRYujwT0ci9rgQujnyyClmoRm
 j2i6jmmzUdvCp3grFZxrBgS/TWCoSuhuwVgr8YBvGIMGNXQoz63/aVH8W+h32JqhBrzkS72aeVqaOGNhSTYaHrL+ElflnA==

Hello David,

Ah, my fault, I overlooked the response from him. Should be applied in 
version 3.

BR,
Andy

On 01.10.2025 15:29, David Lechner wrote:
> On Mon, Sep 29, 2025 at 8:24 AM Andrej Valek <andrej.v@skyrain.eu> wrote:
>> Hello Jonathan,
>>
>> Just a friendly reminder :).
>>
>> Is there anything blocking before going to be merged?
>>
> There were some changes requested already [1] to add a Fixes tag and
> use a DMA-safe buffer. There is already such a buffer we can use in
> struct adxl355_data..
>
> [1]: https://lore.kernel.org/linux-iio/20250927145515.26692e60@jic23-huawei/
>


