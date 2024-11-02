Return-Path: <linux-iio+bounces-11849-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE13D9BA140
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 16:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 443C8B21468
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 15:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EE31A0BE0;
	Sat,  2 Nov 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmXxQE6j"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA9A189BAD;
	Sat,  2 Nov 2024 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730561721; cv=none; b=a7pvw+mpow0xZ+w6J5xjjm/SEclZJknwNyVS2bjp3nFKRKkeM0Of6kcUtVaxo7jq7qxucvyIcW8mdfLkBqmDoTCT6v1I0743gYdD9TVAkqQY+7PFG9GoXypx5llOXtQMTgbdpvyU7PmpfgTz0DcjwrhSEFL95h8i3auw0Ncxfzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730561721; c=relaxed/simple;
	bh=yA/5ua0zU0ff/tb3Kqg+Th+aH6YaqODB4YjcrlYYDzo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhPJUTro4PJjQUyZzBV/SuVpBLW/F/+/Fe4pwGNI/VxrJhbreTSiR83mAvhp6Ujv6jSvD5KMN73/xg3Rn+MPKgdXzvPFfYOKlfbklXJTYvV029KFQNuYZBeVvVLnI/4TkPd+IUKONPkI2vYjisEHD1q1eI+ynuXnX+a4yJc4U7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmXxQE6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6385DC4CEC3;
	Sat,  2 Nov 2024 15:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730561720;
	bh=yA/5ua0zU0ff/tb3Kqg+Th+aH6YaqODB4YjcrlYYDzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dmXxQE6j7DbGOp1oFQG+d3Kh1Fg1Hl80uqLhFcKVU0MKsMPEjMDBx+SmZsEGP6eRA
	 LG0pI9OOvNzOK3iz+WGBc5hM8zMsIvuOyTjt3kJyYeeyLGpdZ0uuhBc5GSOuSLHZk3
	 Vyz6hvdPvIUo1fN9OlSz8WOU60YEydGflXPE8rmUMaqAS0yCS3bdA8qqACTv4wlVZd
	 1ZDyC1f2CpkQ/RQW6C5zIkUTrghRMXL2B0mfv5raQBp29kfwLcwKQchM9Ej1+D3Dga
	 aVL5ZAvMD0UxMOILndKds39IhEJH9/y3dYjBUzitN7JaSuBLJl80xWuSD6KzgVaVo3
	 35LK4QSEf+fvw==
Date: Sat, 2 Nov 2024 15:35:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 anshulusr@gmail.com, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] iio: chemical: bme680: add power management
Message-ID: <20241102153512.5b93efa7@jic23-huawei>
In-Reply-To: <20241102131311.36210-8-vassilisamir@gmail.com>
References: <20241102131311.36210-1-vassilisamir@gmail.com>
	<20241102131311.36210-8-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  2 Nov 2024 14:13:11 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Add runtime power management to the device.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
This and previous patch look fine to me.  Just need to clean up that
dt-binding patch and hopefully get a clear direction on whether to require the
supplies or not.

Thanks,

Jonathan

