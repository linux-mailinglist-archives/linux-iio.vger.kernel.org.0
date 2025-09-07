Return-Path: <linux-iio+bounces-23863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A831B47B85
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 15:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B08200964
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 13:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43D22737FD;
	Sun,  7 Sep 2025 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTtkXe6M"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC73266EE7;
	Sun,  7 Sep 2025 13:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757250924; cv=none; b=d8nVE0U3OXLF3uNBI4OYzmcj4hhP7ngBwnfPkEUkIAqmE9PucrO8juOtNTgawBwTgbgjX0uU6szm/+5bkL67r7mp0mQdhIZ1M1t656EuSmb+uaSwJco/qqeiDVttUoi3IblwIMos+ficutgGjOa0zTeCyq5n/WwXthUs/W7wAQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757250924; c=relaxed/simple;
	bh=xCVkByE4VsK5p61XTsHdJ9rLcKon1b7VyGrbTb1e37Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fibwgwYR7SERjJ5i8EtHHg8nxOd5VjvJPZaijj3dxGgRsEACC/FpnNb9xfoOnkUSZFPa1t7/2RuP/NPjzd0q8YH28Pu3W6Eav2K+Ca6R1y7xKmF8IdQ3lqrg+FX1q/BMGzbFNJnT/6nmQYH2bvnSv49P/Dj3m0renO2a5Z08q9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTtkXe6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADB0C4CEF0;
	Sun,  7 Sep 2025 13:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757250923;
	bh=xCVkByE4VsK5p61XTsHdJ9rLcKon1b7VyGrbTb1e37Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sTtkXe6MO+fxnQSRE/ekmGmjy7izpbRulY9xi6Ar839GhcrEcQPpKBmUV65pfl4Vp
	 rTrteL4nNMRSXJGwlrL/g9/6+tndthJZ7DO3glAIWP89sLOggndqFnfZ7U88iKV33G
	 MvS5smBT17+VgihMvzbaA+GArKi6yuWEHTc1IvRPOIo/zf2lsLIGme+KyF+pXaOn8n
	 WlFRGWBIFPk2ssJEnTLMLKJ4cCxTpWok7SW7ODkLIsTWUig7UUH4xuWonTM/xiGsKG
	 zO02caxeX84Hyz1NSSBsofuaiyj+AnG3OXmcd/gW1XPO2iawfV+tKfF69WRF8KFc4K
	 FQvTj2IbMItPg==
Date: Sun, 7 Sep 2025 14:15:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 09/10] iio: accel: BMA220 add event attrs
Message-ID: <20250907141515.0b49012a@jic23-huawei>
In-Reply-To: <20250901194742.11599-10-petre.rodan@subdimension.ro>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
	<20250901194742.11599-10-petre.rodan@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Sep 2025 22:47:35 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Add event attributes not directly covered by the IIO API.

These must be accompanied by ABI documentation in
Documentation/ABI/testing/sysfs-bus-iio-...

We need to pull out of the datasheet generic descriptions of what
they are so we can consider if they make sense as general new ABI
or perhaps map to something existing.  In some cases it is more
appropriate just to set a reasonable default and not provide a
userspace ABI at all.

Key point is that custom ABI is effectively unused ABI because most
software is written against a bunch of devices and has no idea what
the new ABI is. 

Jonathan

> 


