Return-Path: <linux-iio+bounces-24726-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EB7BB8F62
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 17:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD20189E80C
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 15:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2126B274FFC;
	Sat,  4 Oct 2025 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuDVsFtA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D74274B5E
	for <linux-iio@vger.kernel.org>; Sat,  4 Oct 2025 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759592237; cv=none; b=lqQGBVzu7uIgOBf0jWvPOs50GPhxsJk6ZyckcKICFCoPUpymYKM6Xv+Pij6e7vYnRUU7JSgyZUdEGyYGkTK8xaUvj19TtdnHtf/wF8Y8+UUsd+715An9vc4m/YgVpbD2wyatwqHqWS6gcV41ZY/YweweaOgSXe54tXAXWv2fPvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759592237; c=relaxed/simple;
	bh=xwCt2HL0GupfBkRj5/rZIzkqW91Q8JVamsCyZd7eiUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwQZngLZ7iq+06tTk5DxBddtAbnkniJ80uB/lC5pbR1WQadaCe7ICxQiNXYsxFycwicG+FF3xQZW9VQ4Kr3jTp2zH+FRnUMkAjJkUU8L7fWFD9s5tNr+OMyniS7+ju7mJv7+KZty0zJRdSsI3BUYu4Sc5Zt2aPf5OYz3wuw1N2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuDVsFtA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE57BC4CEF1;
	Sat,  4 Oct 2025 15:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759592237;
	bh=xwCt2HL0GupfBkRj5/rZIzkqW91Q8JVamsCyZd7eiUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AuDVsFtA3g3pSzynsJSQwtmF+Ppzd7wcU4olxceYXsIq+RudMi9SrJ+gjl0/kRA5A
	 SlV70a2RAi9dQwaBloJlNcc0CP9+IMNJIVmcqxovd4LOhiaLuonhlKa3CD4DgdCSDE
	 9VTqtTV6eMRDBjJ/edc0R6tt4OAV3mm2zFcz3HiSUeWt9+E9Lt8ze3085FzMi6b71e
	 iPJs5ROCrWrr+AQ/GMjD1EsymIkAf0jjU9WyVlVY5ZM+z8ZQKf7P4s2VJHBCdC23ue
	 oEID4+OJCcmMaUJ3Frxv6ugWgvmCfGe7iJSIYKw7Dmu5/CI2AzpCg+x5bZ1/up/LG6
	 GMTOW+NS2bCJA==
Date: Sat, 4 Oct 2025 16:37:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Achim Gratz <Achim.Gratz@Stromeko.DE>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH v3 8/9] iio: pressure: bmp280: implement
 sampling_frequency calculation for BMx280
Message-ID: <20251004163712.30e6c9ff@jic23-huawei>
In-Reply-To: <20250928172637.37138-10-Achim.Gratz@Stromeko.DE>
References: <20250928172637.37138-1-Achim.Gratz@Stromeko.DE>
	<20250928172637.37138-10-Achim.Gratz@Stromeko.DE>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Sep 2025 19:26:36 +0200
Achim Gratz <Achim.Gratz@Stromeko.DE> wrote:

> Report of the actual sampling frequency via sysfs is implemented based
> on the maximum measurement cycle time, depending on oversampling_ratio
> and t_standby settings.  If the device dependent table for the
> t_standby values is missing, the reported value is taken from the ODR
> table as before, which enables the support for the BMx[35]80 devices
> to be unchanged.
> 
> Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
Ah. I see now (question in previous patch) that this is doing single point
(read of sampling_frequency) report rather than calculating the data
for sampling_frequency_available.

Fair enough as a start.  Trying to represent the many effective control
dimensions for sampling frequency is challenging.

If we aren't providing read_avail for it that is fine.

I am a little confused wrt to controlling it though.
How do we adjust sampling frequency? 

Jonathan


