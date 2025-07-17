Return-Path: <linux-iio+bounces-21753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5561B0917D
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 18:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4270E1C21060
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211FD2FA635;
	Thu, 17 Jul 2025 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gUZ5mLlO"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE192FA63A
	for <linux-iio@vger.kernel.org>; Thu, 17 Jul 2025 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768728; cv=none; b=C6TvYnBb2z7yicF0bhbMGQDshlU4loejeclgAWAflu/s996TzaWGpQPmURDLnmtwCPyiLyinvX2JfuEevVy/go1Xcg4VIxR0ZwpbmpDuN0KrAJscfbN9zg6anRSnqMG5TfYFyLJR10ZmOSL9UHx7NPJrJhTm4eh1FxocqOtyKCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768728; c=relaxed/simple;
	bh=8E/LASC1MAbiIyjg+yp4CG80+zNjBRUFj8dQa91jOeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TL2ILCgHOF+mEPdVHY8mApkzMPYN+f2idy9OfRZKoz+5sckCA3naJtAT0c9Ybr+ev/FMADtznL/HEabyOKujDOA9IT4kBXxAFYKcm9mqBIROlJ8nb0dfRrkYD6hyf6pVNfPaJTItiIsuYXrtO7RF1W1PiuPvNhbmjHi3ehP3n80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gUZ5mLlO; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3d548f70-46d8-421e-82b2-04ba60d19a29@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752768715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T8hlfLA2Ari9Q2cTq4M3Jz4AlI/LLzLa+w5HAU7rc+4=;
	b=gUZ5mLlOGAlTPRtLDYLYusGexWrXrR6+bEjZ2v+zo9WZ5YkOzq3f6LofB2TEQ/ONv5VU2d
	VAWNSlYirBymMyQAL1vNzrA7TWb1Q83I1RQ5UXJXAAahl114YuKbZYHgIg1t/ihZFbXDt0
	+r1Kp1ME5gY88CCM4ndz8FgEEY9wPSE=
Date: Thu, 17 Jul 2025 12:11:52 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6/7] hwmon: iio: Add min/max support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-7-sean.anderson@linux.dev>
 <aHYUOs25SrUb4BtD@smile.fi.intel.com>
 <05fbc6c9-0b6a-42bd-8940-242c80a79b7f@linux.dev>
 <aHd4fOCoaAYdqbMy@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aHd4fOCoaAYdqbMy@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/16/25 06:01, Andy Shevchenko wrote:
> On Tue, Jul 15, 2025 at 12:05:15PM -0400, Sean Anderson wrote:
>> On 7/15/25 04:41, Andy Shevchenko wrote:
>> > On Mon, Jul 14, 2025 at 09:20:22PM -0400, Sean Anderson wrote:
> 
> ...
> 
>> >> +	return sprintf(buf, "%d\n", result);
>> > 
>> > Mustn't be sysfs_emit() ?
>> 
>> It doesn't matter in this case (as %d can never emit more
>> than 20ish characters), but that works too.
> 
> Have you read the documentation? It uses word 'must'...
> 

Documentation for what? sysfs_emit just says it's aware of the
PAGE_SIZE buffer. Nothing about that it "must" be used.

--Sean

