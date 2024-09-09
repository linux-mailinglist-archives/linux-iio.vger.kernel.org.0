Return-Path: <linux-iio+bounces-9406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3483972226
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 20:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7361C20C5B
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 18:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143F0189534;
	Mon,  9 Sep 2024 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhJk8dIS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A7814B06C
	for <linux-iio@vger.kernel.org>; Mon,  9 Sep 2024 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725908204; cv=none; b=S+mbfWxFNFweog1qvtYf1FjACUSd8w3wppkmo4NtMAwBT+ffq1/D67QHa9k4FsVYzol/RytBQTi97okMVUIQMdou6OknKAKx5j5fDTjfbXURWQ1AJSYycF2IDXtsCf4HV3af79k43WvjeZVA1dlpDImSNAJC/u5lVGu06YKY1Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725908204; c=relaxed/simple;
	bh=3tyTYo7Er8oqajhyjazjy5VEP59WZ4OBEf0Cp4nPyc4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBCdRyyKS5qFASLkkIkhaMoSskYKRItsB/jM3K8wlHZorecIQmz4XrMrk7b5bIY5dqDajCh8Fqbq2mIAPsskZbt4CiNTXHzYUOYUXIH3HekTh0Kr8RlmCJxrB9l80oHJqmKD+I6qtG3XKrQUw/hk1KeUznIRT6QtOVL/R0WVO4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhJk8dIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8E6C4CEC5;
	Mon,  9 Sep 2024 18:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725908204;
	bh=3tyTYo7Er8oqajhyjazjy5VEP59WZ4OBEf0Cp4nPyc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mhJk8dISFLgqpZkm1B1imUEwcqFCiWA6tVGgtEiJpIDlX6TGBm/EK52kQ+EEWqvC7
	 rCN4dpDfdG4aQyA4kdxN6TEjL7D+cBqHUzl5/r7lDmnY7Dwhyqc7f+QOeQlfoIPqPO
	 qx3hhJfeoOMriUX66Crch+Dl3/Yq7EIcxK6NfLu5ei5ir7mHRnVm4DVdlwYzqB3LDj
	 adSvfrO5W5RMzF/Xl7RkOpsXzUgSNvEwOGNcXeCgsaQy8iYd3MwevyrojsfYH8OMwf
	 68DRbSFhMOJNi+g6G28yCCRop6qHmed5h6OYfmYTFgnuJWhu2/1CqlMoRK+atzk5Ph
	 z/8vB67gniGYA==
Date: Mon, 9 Sep 2024 19:56:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: bugzilla-daemon@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: Re: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Message-ID: <20240909195638.6a234677@jic23-huawei>
In-Reply-To: <bug-219192-217253-ClcvKjR0zY@https.bugzilla.kernel.org/>
References: <bug-219192-217253@https.bugzilla.kernel.org/>
	<bug-219192-217253-ClcvKjR0zY@https.bugzilla.kernel.org/>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 09 Sep 2024 14:31:02 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=219192
> 
> Andy Shevchenko (andy.shevchenko@gmail.com) changed:
> 
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>                  CC|                            |andy.shevchenko@gmail.com
> 
> --- Comment #2 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
> Might be related (read discussion in full):
> https://lore.kernel.org/platform-driver-x86/Ztlto06GyFxLXz1y@smile.fi.intel.com/.
> 
Thanks.
https://lore.kernel.org/platform-driver-x86/20240906031601.4yodvhurcyi26qb2@treble/
Looks like the relevant info.  So current view from Josh seems to be that
it's a clang bug.  Interesting to see if that holds up if reported to clang
folk (or if there is undefined behaviour none of us are seeing!)

Jonathan




