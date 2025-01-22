Return-Path: <linux-iio+bounces-14526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED25A18BCC
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 07:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 263AE7A44A0
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 06:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4E1191F6C;
	Wed, 22 Jan 2025 06:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SL257t7a"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4CE175D47
	for <linux-iio@vger.kernel.org>; Wed, 22 Jan 2025 06:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737526463; cv=none; b=k1aWd48KGfUFlkIbWI5LH7ZKti9LvtIQNe7DOWChC7XjF/KKxPdv58MXFMFXk6qFl55AMcpE+2Z2JivBkL/QJMXoV/f3RR1UYfOqc9pMsmC/mfXcTwUHEBmowWQwVPHaE0eFkjf55ZlsrhujcX6iOCM3uN5HBDPfWqTW62Lu/nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737526463; c=relaxed/simple;
	bh=a906MVP+vbd2ay4JEofGWEqV+0TYzWsPsnOp7nj1o2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEcXHoxXCo9NSHpM2HIdFi2PGGOodStwozqCiNRWqRZuA4VrnUHgG+fILIlEyaoujtDnmaIRWSh2uLcnOUNBzaaYrX0WS5mK4QwvNBFu/J022sQobb/MVKbK8FkJH5dP/V7szJ+SmHz0Y1O+VhdcSTJKllGzpoxw0gpr1BFZP9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SL257t7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A66EC4CED6;
	Wed, 22 Jan 2025 06:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737526462;
	bh=a906MVP+vbd2ay4JEofGWEqV+0TYzWsPsnOp7nj1o2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SL257t7alcrOhDFG8aunYr9cDHY/m1A458g2xy/DQnDYU11AZH7sWicrAkCCsfoEo
	 G24Ny0IZ4fzc5BzYBjVk+1aLi97/DFEUhL9zQPJdh0f0eAWMGJBfBjlKZboj25VT2i
	 /ti67qLg3me1lGGZVu6Ltrz3RngkWAvjYLCsVLH0NkidI1qpfu4DmwlJ/zR+btrGwz
	 g4eKJyuWqR/VeM0+fMtmFukrHlFyfTDNjWuzP9HgwB8NFsKPOPmGPa/KZLf0uEUSA4
	 Jzi5K/CjSlGOreJDyWc7LYGFpGS4g/KSOws/mmvkuX0yAzkq//rf1+YVKbJaldqsXW
	 K3NDeVQsz/+/g==
Date: Wed, 22 Jan 2025 06:14:19 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4] iio: cros_ec: Trace EC sensors command
Message-ID: <Z5CMu4yIgbPgJknf@google.com>
References: <20250121232007.1020666-1-gwendal@chromium.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121232007.1020666-1-gwendal@chromium.org>

On Tue, Jan 21, 2025 at 03:20:07PM -0800, Gwendal Grignou wrote:
> For debugging, add tracing for EC_CMD_MOTION_SENSE_CMD command:
> - decode the name of the subcommand
> - provide internal information for the most common sub-commands:
>   setting range, frequency, EC probing frequency, ...
> - display return status.
> 
> When enabled, the tracing output is similar to:
> /sys/kernel/debug/tracing # echo 1 > events/cros_ec/enable ; echo 1 > tracing_on ; cat trace_pipe | grep MOTIONSENSE_CMD_SENSOR_ODR
>  SensorDeviceImp-814     [003] .....   686.176782: cros_ec_motion_host_cmd: MOTIONSENSE_CMD_SENSOR_ODR, id: 1, data: 200000, result: 4, return: 12500
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Except I can't verify the build error seen in v3, the patch looks good to me,
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

> ---
> Changes from v2 (https://patchwork.kernel.org/patch/13944028/):
> - Fix include error, based on commit a98c75fcd0e ("drm/tegra: trace: Fix path to include")

Typo, v3.

