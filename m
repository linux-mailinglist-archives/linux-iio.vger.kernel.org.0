Return-Path: <linux-iio+bounces-24111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8005B57A21
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 14:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B02417431E
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 12:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DED8306B01;
	Mon, 15 Sep 2025 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jxhmbybD"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B341321CC47;
	Mon, 15 Sep 2025 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938407; cv=none; b=bRne+Tb0BaCT6HlFRoFBbOSjODNQAEa8rwmfZ5ek3jhv2Vmh3Y1C8KKz5+M7Iy98FC7pDCzW94seaEZh6P6oQrVIGUGjMLPsk5rigMpXF4pCoXgoROLvJo4D1TSe+qSr8TanUY+EnjLoxFTw70EteEO6Eol8HRHf98boeI8BOSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938407; c=relaxed/simple;
	bh=RnaQPEpAFGE+FmHs1ujCADBWdRDqnxSUnXW7zkovLnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dUjR6phRnEtimIMRB/g/Oi6IyIMr6b4D2CW2bov8L/fIt42N7piAw5RsNldS6COIamF3ChaGWQQ97oIrJE9ZFkz9yDKQm3VZmNW9r0PizerL4zaXXukP2hTXXtu5UFX/oiagKorxbSCIdpM510JHrjgZBFPrmP4FlvOqPJhaMM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jxhmbybD; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58FCDIrV1553311;
	Mon, 15 Sep 2025 07:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757938398;
	bh=fOPm7DPa44haQ5Kh6Z0KE9NG3VWd3hMZ47EgCDyDjFA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=jxhmbybDH1VCsp3EWS3EZnSqckVvrYM4dbg0iG1N9VbrLBG00j2pMJmSSS8ibGptO
	 uedHLOpljz4XbDVZexkY8nct0O4toYGj8MmLSrrdbz8TqC4w9ZtjwP5ToIVRRxt8y/
	 +HRoOrb/tjjtGL6M4JdhrkKkD48qwBTlE/OuBDJw=
Received: from DLEE206.ent.ti.com (dlee206.ent.ti.com [157.170.170.90])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58FCDID73381010
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Sep 2025 07:13:18 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Sep
 2025 07:13:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Sep 2025 07:13:18 -0500
Received: from [10.250.32.255] ([10.250.32.255])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58FCDIUI3747341;
	Mon, 15 Sep 2025 07:13:18 -0500
Message-ID: <4333d98d-3f6c-4c22-8dee-e4349a7b4046@ti.com>
Date: Mon, 15 Sep 2025 07:13:18 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] iio: health: afe4403: Use devm_regulator_get_enable()
 helper
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
CC: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250813225840.576305-1-afd@ti.com>
 <20250813225840.576305-2-afd@ti.com>
 <4e109905-347d-4830-aea6-a93d88252481@baylibre.com>
 <20250913152052.134a4059@jic23-huawei>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250913152052.134a4059@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 9/13/25 9:20 AM, Jonathan Cameron wrote:
> On Wed, 13 Aug 2025 18:12:26 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 8/13/25 5:58 PM, Andrew Davis wrote:
>>> This takes care of both getting and enabling the regulator in one
>>> function, it also handles the devm action, so remove that. Also
>>> do not disable the regulator on suspend, this will be handled for
>>
>> I didn't know that this worked automatically. What is the mechanism
>> that makes it work? I've seen lots of drivers doing the disable/
>> enable in suspend/resume, so I just always assumed that was how one
>> is supposed to do it.
>>
> Hi Andrew
> 
> This question is still open, so I'll not pick the reset of the series
> up until it's resolved.  I'm going to mark these in patchwork as
> changes requested so will need a v2 now.
> 

Sounds good, I'm still working on tracking down the answer to the
question. I think it involves the regulator suspend path but
will sort it out fully for v2.

Thanks,
Andrew

> 
> Jonathan
> 
>>> us. We now do not need to track the regulator at all, so drop it
>>> from the device struct.
>>>
>>> Signed-off-by: Andrew Davis <afd@ti.com>
> 


