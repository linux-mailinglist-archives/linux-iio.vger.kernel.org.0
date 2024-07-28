Return-Path: <linux-iio+bounces-8012-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0748C93E8BF
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 19:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A731F21796
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 17:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E95161674;
	Sun, 28 Jul 2024 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbT3KJFU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A67157333;
	Sun, 28 Jul 2024 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722186347; cv=none; b=UHjybbIx2GYsy7V4ZoLA+aEsmoalfQ4Pyb/oPV2XHplojPJ6yS8VpU8bPBn/ifdhtFqkwOyA0mNVBLHt2c7XFJ6C8hsUhwtIGufvC7VF5/f9MtslivRdxLHP9m69l1QM3AMRqO/FWu1jSWqeQWuKiKNy5FIA4V4ela8DWUesyjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722186347; c=relaxed/simple;
	bh=QKJk+c2O3Jw4S0812ZXaWb0JNoGZSMaEm/HW36Sh8/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aoeGkhDGhETDrnONGAaQBUomJs03zybJVBNElSPcBuj8hsm0T03XaoKFTIj6posSv6oiVD7hqQiEohf5XNCH3As5BI9+A+A6bEnXJrfKERSI7o0Iyitovg4YO0NbjF1YQNlkvu0SpWznuHtJ+pRnpKjHevzPEh3wXHvFz9ZAtRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbT3KJFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D983FC116B1;
	Sun, 28 Jul 2024 17:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722186346;
	bh=QKJk+c2O3Jw4S0812ZXaWb0JNoGZSMaEm/HW36Sh8/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PbT3KJFUScgue678YEFigvlUBOTMmuQr8VkaOcWmtL41MyDenudZuDhU/jG1YETul
	 EQ5kUQKHSLenRcIuN3EWareaAI7H0axPPcxKGGt0nMCWBdnVogdt8cn0yj4YfkhGFa
	 r7kk4tHHF0feN+TzCZ9hL1/k6eXhS8UUO95aNBGJxJSyeeYg57pYU4ulhar2okeCAj
	 NwKV27k/ntxJqw9Bv/G+u7DkcGBmY+bnDZscI9NkpEIExKJUwZEM/Fu92kHGHzi7ML
	 ope+fAIWLYFeOqyFDbNGv61UDpVl0+WGb2SWNQfmxHzcAZQkvlUJiOwu2NjUSUpCsb
	 OIlETIgR5isBg==
Date: Sun, 28 Jul 2024 18:05:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Conor Dooley <conor@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/3] iio: light: stk3310: stk3013 support
Message-ID: <20240728180541.3aff18e1@jic23-huawei>
In-Reply-To: <20240727-stk3310-v4-0-02497b1407ba@disroot.org>
References: <20240727-stk3310-v4-0-02497b1407ba@disroot.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jul 2024 00:23:30 +0530
Kaustabh Chakraborty <kauschluss@disroot.org> wrote:

> STK3013 is a part manufactured by Sensortek which is marketed as a [1]
> "Proximity Sensor". This part is available in several consumer mobile
> devices, including, but not limited to, Samsung Galaxy J7 Prime and
> Samsung Galaxy A2 Core.
> 
> The existing ambient light sensor seemed suitable for this chip, and on
> enabling the driver, it was discovered that these "Proximity Sensors" had
> ambient light sensing capabilities as well.
> 
> The downstream kernel driver shipped with this phone by Samsung [2] exposes
> a sysfs interface for proximity sensing, but leaves out the light sensing
> features, hence there's no such functionality in userspace.
> 
> The following patch series aims to add support for STK3013 as an
> ambient light/proximity sensor.
> 
> [1] https://www.sensortek.com.tw/index.php/en/products/optical-sensor/
> [2] https://github.com/samsungexynos7870/android_kernel_samsung_exynos7870/blob/master/drivers/sensors/stk3013.c
Series LGTM. I'll leave it on list for a few more days though for other
review to come in.

Thanks,

Jonathan

