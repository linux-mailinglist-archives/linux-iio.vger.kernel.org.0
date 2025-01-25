Return-Path: <linux-iio+bounces-14564-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9A0A1C306
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 13:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C503A6663
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 12:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B822063CC;
	Sat, 25 Jan 2025 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpJjAxY+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022E51E7C2D
	for <linux-iio@vger.kernel.org>; Sat, 25 Jan 2025 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737807348; cv=none; b=YwiI2/ICIkWMkGEFaWiNQeRCKkWrG6XsFqEVP7HFp+nT+xFdYdb2QqKyE88xKBQZnzOs6zIB7NmBtTpfhKEPAa+cmIvAKDN7Hw0T3PjFo5cHW8iiVfXJq3NrBIQ3kVpyL6wJ2Dxf/s787ZWUzh8F8T7nCv6HYSD28khHvoCx9Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737807348; c=relaxed/simple;
	bh=5zd7XCK/vkFQH4WSBfOfDUGELjmGE7lCmtd7Ic4fi8o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IA3Kd/p7IOm4FfJ65t+J3qr33P/XF5pbYUQaLE3m1bYju5Zg7bd8qupbfV/HjPa4y5IPppwAls92vfM3sLJ5Mz0xfr2fwzaUyRZxgNqGZiHO5V1tKbHfUUZtiZTQnIglEYZ2+0Xq+k+sKuq57QqIfKVHLDuShCt+LtL0GrZKS4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpJjAxY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32143C4CED6;
	Sat, 25 Jan 2025 12:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737807347;
	bh=5zd7XCK/vkFQH4WSBfOfDUGELjmGE7lCmtd7Ic4fi8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UpJjAxY+vP/eMewOOYVk+hzDeywdEcM6ZKzSQUd6WQ6wjxLuBK6xJ5aa670q925P2
	 1MbcD+qWypSiAdyLxPYM0jjXuqL8UFyV5tE7r2Z6axVal8cl4X+s0btHtpxDcA0U+x
	 H+xRYQ1fo97J8SYuwvTuWTZciL0iDN3fixE34sDbq8i+AULLvs9I5VYmzUrYvrRXLL
	 woqZ4ZSE1f2bEqds8MJl8tJEQQdD7DpEma6inE2sD7M7sO1PXjWTW96/erRfZ8ApII
	 kv12A3WHiGEV/vmqALYEoZTEsUNiVklKa4QRrzVdGW0e6eiwKeMbZImSZ2SehALijm
	 WHz9p1IDYNVDw==
Date: Sat, 25 Jan 2025 12:15:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4] iio: cros_ec: Trace EC sensors command
Message-ID: <20250125121541.1b74f33b@jic23-huawei>
In-Reply-To: <Z5CMu4yIgbPgJknf@google.com>
References: <20250121232007.1020666-1-gwendal@chromium.org>
	<Z5CMu4yIgbPgJknf@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 06:14:19 +0000
Tzung-Bi Shih <tzungbi@kernel.org> wrote:

> On Tue, Jan 21, 2025 at 03:20:07PM -0800, Gwendal Grignou wrote:
> > For debugging, add tracing for EC_CMD_MOTION_SENSE_CMD command:
> > - decode the name of the subcommand
> > - provide internal information for the most common sub-commands:
> >   setting range, frequency, EC probing frequency, ...
> > - display return status.
> > 
> > When enabled, the tracing output is similar to:
> > /sys/kernel/debug/tracing # echo 1 > events/cros_ec/enable ; echo 1 > tracing_on ; cat trace_pipe | grep MOTIONSENSE_CMD_SENSOR_ODR
> >  SensorDeviceImp-814     [003] .....   686.176782: cros_ec_motion_host_cmd: MOTIONSENSE_CMD_SENSOR_ODR, id: 1, data: 200000, result: 4, return: 12500
> > 
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>  
> 
> Except I can't verify the build error seen in v3, the patch looks good to me,
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> 
> > ---
> > Changes from v2 (https://patchwork.kernel.org/patch/13944028/):
> > - Fix include error, based on commit a98c75fcd0e ("drm/tegra: trace: Fix path to include")  
> 
> Typo, v3.

Applied thanks.

I'll be rebasing on rc1 once available. Until then only pushed out as testing.

