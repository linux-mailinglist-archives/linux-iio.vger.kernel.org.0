Return-Path: <linux-iio+bounces-11348-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DB39B18DB
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 16:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6C0AB21376
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 14:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055BA1CD0C;
	Sat, 26 Oct 2024 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ansari.sh header.i=@ansari.sh header.b="Dn5TBkiO"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767442746C
	for <linux-iio@vger.kernel.org>; Sat, 26 Oct 2024 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729954739; cv=none; b=BARVkzb32hlvfNhiCtQ05Yo/IIZvtbqXH++2Js0+2vzS2Up7SLlWx7fxZOoGH9HHqjA1ewLaPBwD+Vzv/uV/uEtrJLh/ow/oKpL1bHkKB6KFrRMLtcHHuwNwyZrm8zvq7upBIlT9u6Yxxg0j8AyhFA/W4lTq4/SGM2zWeyVcZVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729954739; c=relaxed/simple;
	bh=cKZz6m+Be2jRP++M064nr+ktpt5GpWCWvuKBYflV8FU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kw8oOSuiQFrBbkMXbB7xBDJtp0fjy8237SGJCF/hyROoaK4MyCPNiXYcGRNYDmgeUxf6eQj8HmyGxc9Vsphk0arEeieiGxbH8fnnHSE6sbhG07kCSgECMCe+iWM7QtH1xD11/vmrfuiovkYHO2zy1zDgFIiaBsq2hoY49D/k9/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ansari.sh; spf=pass smtp.mailfrom=ansari.sh; dkim=pass (1024-bit key) header.d=ansari.sh header.i=@ansari.sh header.b=Dn5TBkiO; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ansari.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ansari.sh
Message-ID: <fc87c8d8-db22-41f8-9594-4687f89881f9@ansari.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
	t=1729954735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHnOAbVcncqUjR3SFOoAO2bokF8DOuZvDVUBBaC+170=;
	b=Dn5TBkiO4xqeZ6BAAAg6/62c4Yl1f1jUiHU9bVlq3UZMM8rcC30VRVicwOHunjp7CrmUJo
	v51RGuUz/wkrI2kcEbCympnx4wKNSCuRnTWXFCG+9VI6Nz+0e+JikYVnPlyFjnLpL88BM3
	NyHoWVPGnD+MqlQfYjUCRi4IEGPKGVA=
Date: Sat, 26 Oct 2024 15:58:52 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 07/24] iio: accel: kxcjk-1013: Revert "Add support for
 KX022-1020"
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
 <20241024191200.229894-8-andriy.shevchenko@linux.intel.com>
 <20241026121619.668d07d7@jic23-huawei>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Rayyan Ansari <rayyan@ansari.sh>
In-Reply-To: <20241026121619.668d07d7@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/10/2024 12:16, Jonathan Cameron wrote:
> On Thu, 24 Oct 2024 22:04:56 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> The mentioned change effectively broke the ODR startup timeouts
>> settungs for KX023-1025 case. Let's revert it for now and see
>> how we can handle it with the better approach after switching
>> the driver to use data structure instead of enum.
>>
>> This reverts commit d5cbe1502043124ff8af8136b80f93758c4a61e0.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> I'll take this the slow way as I don't think there is time to chase the revert
> through the various trees and still get the dependent patches in.
> Hopefully we will fairly quickly get the missing table data and can
> bring this back again.
> 
> For now, applied to the togreg branch of iio.git.
> I have tagged it as a fix though. and +CC Rayyan
> (I'm guessing maybe that will bounce as you rarely miss people you should
> CC!)
Hi,
Sorry for not replying earlier, I've just caught up with the discussion.

I don't fully understand why this is breaking KX023-1025, but you know 
more than I do here.
Does this not mean that the use of KX022-1020 in the 3 devices (Lumia 
640, 640 XL, 735) using this from qcom-msm8226-microsoft-common.dtsi 
will now be broken?

Thanks,
Rayyan

