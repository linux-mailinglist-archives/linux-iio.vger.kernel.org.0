Return-Path: <linux-iio+bounces-17419-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20BCA764AF
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 13:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A54216652D
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 11:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4099D1E00B4;
	Mon, 31 Mar 2025 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NobZKWzj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD88187550;
	Mon, 31 Mar 2025 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743418850; cv=none; b=UjQYoSox1NY38qVcBPtIwFkOUYkXmEL7muT4fP/XfHYDWFvnSvKaxw8pLDclyYHQFaxwuKS6YAiznOs6YokYl3WuYUpiBKlF5Km/jtHgwYiOnnWVAWv7HfWbYNTV0J20JsyBKsGFKsIq2CiDFP3xW2r4lhSh6cNyphYXB2j81Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743418850; c=relaxed/simple;
	bh=hJr4QpKH1LU3ceS6tQ4gA/jKycBCVrwSUd5EO94VrcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hng2kVsvs44GtbHat7nbaHt2B/0kpOnZYljmK89BSe5x1ydg/A6JDVTAlf0wimuADu4aByDaO8p+52URQFolxVF/q5BC5q/X5L438C5bjv1ddsmnVOExi2IDFTnzUWFkbYfs4ucdfqx2DP04b28YtM7xmnf/IJyKOBl0bCSRmSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NobZKWzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD0FC4CEE3;
	Mon, 31 Mar 2025 11:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743418849;
	bh=hJr4QpKH1LU3ceS6tQ4gA/jKycBCVrwSUd5EO94VrcQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NobZKWzjIpu2P0mGmJXOGO2mDlGccUHMUuVrbE2rWE7LVP3ALHz38Mt6qGT8MT8st
	 u+R/jKwLmKQZKdcdSKzLtsLgH4yiJV2j4rz7rhKM3HfVdNZEpRyhUksqlIazmtghsL
	 IQImdkr+tDWcQTt+D3ozOc5+4LY+XyOzbRftODL79gcre/o9gGnKwitkdyHQqIzo5v
	 DYeV/3p9n+GYSuTPPi/AvE1oigS6mSdsYA8uFMm/V6RE0Ao47THUiPKqOw4SSf7rNZ
	 tj3IXTP/w7gTdePUgvaP9/20hDjngHvJqAgIyOfyn2T0QcUIDcIXEfEvV+pGKDsXuI
	 JC3tpW7zEmkcA==
Date: Mon, 31 Mar 2025 12:00:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Zhang Lixu <lixu.zhang@intel.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, jikos@kernel.org,
 srinivas.pandruvada@linux.intel.com, peterz@infradead.org,
 gregkh@linuxfoundation.org, ribalda@chromium.org,
 archana.patni@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, even.xu@intel.com
Subject: Re: [PATCH 0/3] iio: hid-sensor-prox: fix SCALE and OFFSET
 calculation
Message-ID: <20250331120040.75d0577e@jic23-huawei>
In-Reply-To: <20250331055022.1149736-1-lixu.zhang@intel.com>
References: <20250331055022.1149736-1-lixu.zhang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 13:50:19 +0800
Zhang Lixu <lixu.zhang@intel.com> wrote:

> This patch series addresses issues in the hid-sensor-prox driver related to
> SCALE and OFFSET calculations. The changes include restoring lost scale
> assignments, supporting multi-channel SCALE calculation, and fixing incorrect
> OFFSET calculation.
> 
Hi.

Generally I prefer to see review tags (Srinivas' Acks here) given on list
but in I trust Srinivas to have done a thorough review (or to shout when he
sees this!) and the changes look correct to me, applied to the fixes-togreg-testing
branch of iio.git.

Odd point in merge cycle hence the odd temporary branch.

Jonathan

> 
> Zhang Lixu (3):
>   iio: hid-sensor-prox: Restore lost scale assignments
>   iio: hid-sensor-prox: support multi-channel SCALE calculation
>   iio: hid-sensor-prox: Fix incorrect OFFSET calculation
> 
>  .../hid-sensors/hid-sensor-attributes.c       |  4 ++++
>  drivers/iio/light/hid-sensor-prox.c           | 22 ++++++++++++-------
>  2 files changed, 18 insertions(+), 8 deletions(-)
> 
> 
> base-commit: e21edb1638e82460f126a6e49bcdd958d452929c


