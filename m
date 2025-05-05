Return-Path: <linux-iio+bounces-19088-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CE2AA92A1
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 14:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F673AA8E6
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 12:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197B320299B;
	Mon,  5 May 2025 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4qL4B7P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3451DFE20
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746446563; cv=none; b=eOR27Ssj7x5WyW/WLy2H0XDcUFgctoAvTH0qV3NRtHeogUyPTr8/o+Q2kKFexO4MLeYHHhi/ZapQbStAtjgaW+wQw/edTLDmDuIMs92ZgXh1DxVUi4dOVtglgDi8YjWdvMMG47RcQU9/NbmqFgXDGcIaIvNB3AR/739i6pF/lhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746446563; c=relaxed/simple;
	bh=KvveW3UlDdTpxQbnfAN3JlyArwAfdykZYAZFe6wNHg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACn1VfvirsOsPX619pmi4oyMLuzYQS9BCSpgrE6n5qeqFuMFKy4pRkU/iZpMNHOu/5vHXwNv9uRdbXl7YC4bZthaM9lh3xXL5ai7xuuZJhbuIwCsWHRDHJQ8bE4tOMZ7OunvduC2MLkdaZpHSMRlMih1ditxMC5IpN4Fw/cplkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4qL4B7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDE4C4CEE4;
	Mon,  5 May 2025 12:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746446563;
	bh=KvveW3UlDdTpxQbnfAN3JlyArwAfdykZYAZFe6wNHg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m4qL4B7PWwiSTQR7HxQ6HMVVsnsH2mfvn0iptmR9cisHR7HLpnPH7JTkeVJSKitQy
	 AvRfyNrKRT4ye47+o3JaP4bIbMLAj5y9aRVMh1b0fElyJoN4W7tLpgXRTchK3ea6T4
	 9pi/Ijbr42IobD3Fsqkd7AlVa5WeEhVawRnPiG+odKX9VnM4R4Pkzlyskqwb1clJW3
	 lpbw3Nr0/pqj1NniJBw4Ttjf2i3QexIWcWcTuuCeNNEMUdv6OYofs6wEBOFxUIxPi7
	 keJFN8hRnAWPXZE4YtZ67jEY6O4JiC9WdqiLlyKoSyblDU5waj5GQrbTPq8nWj75DI
	 Z8bysqufdB8gg==
Date: Mon, 5 May 2025 13:02:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: bugzilla-daemon@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: Re: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Message-ID: <20250505130237.394598e0@jic23-huawei>
In-Reply-To: <bug-219192-217253-VHSGhzyTgS@https.bugzilla.kernel.org/>
References: <bug-219192-217253@https.bugzilla.kernel.org/>
	<bug-219192-217253-VHSGhzyTgS@https.bugzilla.kernel.org/>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Apr 2025 06:33:42 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=219192
> 
> --- Comment #13 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
> Another thread pointed out to the `BUG()` instead of `unreacheable()` which
> should solve the issue. Can we go that direction?
> 

Ok.  Maybe replace them with something that doesn't loose readability such as
BUG(); /* Unreachable */


