Return-Path: <linux-iio+bounces-11526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACEA9B3C16
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 21:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4AB1F22BCF
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 20:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255B61E009E;
	Mon, 28 Oct 2024 20:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="V4msOG75"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDBA18E03D;
	Mon, 28 Oct 2024 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148290; cv=none; b=piIKLYl1MdhntgopAiWXR0lbaXWxsWrENWZNv5c7ORYBTwVg6HFWYaMRYhhYRnMcIlCNO/Wr6oGeasHGPx9bKsL9VXrX2IspVkQbmB6x+j4hnwJhR9U9Hw0K61QdH0G29kau8gjFoXzQPr2XXCj057ccV+pn4rd6Ha9ldVqtat8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148290; c=relaxed/simple;
	bh=6TnCRjPA3Ba+zxlsnQDMZsAXdvK66rr2MUy4e6J0U2c=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Q9/+LVjMW8lWr9qGLgqWL63BwJ2KoKJE2TAnUpuVBNV36QEMQUMSjweMiK85Ic21VT8VQmF3UI1jg0Z42+7j3jY6Gs3dovNJXz1SbY1J3lY3OySpgp91kFbPuBVd5QU3JToWob+vt+Ty1ytL7MWrFHKExuvLdRHaoioDhp2QQ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=V4msOG75; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1730148280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CY+XwZ0fuc1pJBzr3ZbrtC3qPygvT+6N7jxEZ8PMcdI=;
	b=V4msOG75IkYLOHuvX3IjHDPHm/gxy4ZUnk0PDBO8WsGVwRNG0V3ymYOSNTwnkjqkg02iRH
	zA0RtCZwy9wwafaGfqKwnI/d+o1keEyBbYQS5k3q9iNnp3zzLB/9g0HvCd1YZpyOLX9qVE
	YHMg0moOoeDHs9MrGBLMBmrLn3t3UKairICOMRfmWE10lwkQT18Ma7ChZORbYgT4lo7OJt
	rxp9UV/5Z3v3xW4LV/y0c7vmb/rB+d6sBpj9PkGVyL8NCjMPO1vauLAMJAOaTCcoRlfbLf
	NfZuGHCgrPppLYL8OgVJB+q9FtNP46+UerKpV0ISmjaSsZgh6LBYZdHT76YIHQ==
Date: Mon, 28 Oct 2024 21:44:37 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Aren Moynihan <aren@peacevolution.org>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Kaustabh
 Chakraborty <kauschluss@disroot.org>, =?UTF-8?Q?Barnab=C3=A1s_Cz=C3=A9?=
 =?UTF-8?Q?m=C3=A1n?= <trabarni@gmail.com>, Ondrej Jirman <megi@xff.cz>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: light: stk3310: Implement vdd and leda
 supplies
In-Reply-To: <Zx-h7QUnCKwtu8iC@smile.fi.intel.com>
References: <20241028142000.1058149-1-aren@peacevolution.org>
 <20241028142000.1058149-4-aren@peacevolution.org>
 <Zx-h7QUnCKwtu8iC@smile.fi.intel.com>
Message-ID: <98dd3fbf970559de8b7559da312e22fc@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Aren,

On 2024-10-28 15:38, Andy Shevchenko wrote:
> On Mon, Oct 28, 2024 at 10:19:57AM -0400, Aren Moynihan wrote:
>> The vdd and leda supplies must be powered on for the chip to function
>> and can be powered off during system suspend.
>> 
>> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> 
> Missing SoB. Please, read Submitting Patches documentation for 
> understanding
> what has to be done here.
> 
>> Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> 
> ...
> 
>> Notes:
>>     I'm not sure what the proper way to handle attribution for this 
>> patch
>>     is. It was origionally based on a patch by Ondrej Jirman[1], but I 
>> have
>>     rewritten a large portion if it. I have included a Co-developed-by 
>> tag
>>     to indicate this, but haven't sent him this patch, so I'm not sure 
>> what
>>     to do about a Signed-off-by.
> 
> Ah, seems you already aware of this issue. So, either drop 
> Co-developed-by
> (and if you wish you may give a credit in a free form inside commit 
> message)
> or make sure you get his SoB tag.

Perhaps the best and also easiest solution would be to provide an
Originally-by tag for Ondrej, because that's what it is.  The patch
was written originally by Ondrej, but you've changed many parts of
the patch while upstreaming it.

