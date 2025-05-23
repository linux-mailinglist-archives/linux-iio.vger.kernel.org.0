Return-Path: <linux-iio+bounces-19818-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFD1AC1BBD
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 07:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495FCA2392A
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 05:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3872222590;
	Fri, 23 May 2025 05:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXOmy7xP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFB31FF1CF;
	Fri, 23 May 2025 05:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747977281; cv=none; b=Zc0XsR8k9bLTHx7pbZRZ8RMdKd06qk0HLjI44fGzSzxrWZaZwzXzFVQUM3UFGb5n6H0JwAhLSnW9BAICF1AlbyOiAjNKXNEw3NYBi83NZS5ZiVN+so8bxunErbrh+Wr744fyQr51PhksnlqSUp1HxMktMO+hcsrwR+BBPmPS8Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747977281; c=relaxed/simple;
	bh=CVemUjoSii7g5xGaLL4Hnvf0OKQ5kBV7Bvg7jSGaTC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJAjBXybL1xY/ODsz3Qcflv6YRwNhTBnx0wHtGeuM/z3bHcmRuVvcIiDv8w/b5FIvx0U3ZlaaUJ3QR5OtO1bYmK3OSXqms+4O8JwZgPNIrcGtk/y+28QMrjJpEXsai/vLtT5yh49cRLgq2ZIMqWKoUVEeEKdQdhTXiWE2Tau2yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXOmy7xP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07761C4CEE9;
	Fri, 23 May 2025 05:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747977280;
	bh=CVemUjoSii7g5xGaLL4Hnvf0OKQ5kBV7Bvg7jSGaTC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mXOmy7xP2YZu2JkVdf6JgcerCETmMU+SunaDPuZwI2Ivi1nXNlMyHgKsUE+J0a/e3
	 ksBRGeomflxoTxnYuNIzzD0AhpHLtLnZi8nyyQiIksRjYSXtQTg/Rok2kN4QxOFqup
	 bqBsU1wjAXTrwK9WOwPKUDaO+UMAlBPuTIll7d+yiRuPj+evv2ecVUk7PZxbslZNLm
	 wG6bGG+6A/gw5ezikERidqQs0NxT742IujAokyhFGaCilKf6xqWiPhKTAooseOhxxQ
	 jx7EVhLrzXMVCOETb6ryaVqoS4AaIkx1roZBP46yNPytTTrF/ZWNP7vgb5cIwt6SfB
	 scRMJfU9G8QCQ==
Date: Fri, 23 May 2025 05:14:37 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: jic23@kernel.org, chrome-platform@lists.linux.dev,
	linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH v3] iio: cros_ec_sensors: add cros_ec_activity driver
Message-ID: <aDAEPcpWHps3l3Fc@google.com>
References: <20250523031849.1479851-1-gwendal@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523031849.1479851-1-gwendal@google.com>

On Thu, May 22, 2025 at 08:18:49PM -0700, Gwendal Grignou wrote:
> ChromeOS EC can report activity information derived from the
> accelerometer:
> - Reports on-body/off-body as a proximity event.
> - Reports significant motion as an activity event.
> 
> This new sensor is a virtual sensor, included only when the EC firmware
> is compiled with the appropriate module.
> 
> Signed-off-by: Gwendal Grignou <gwendal@google.com>

Looks neat to me.  With removing a nit,
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c b/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
> [...]
> +static int cros_ec_write_event_config(struct iio_dev *indio_dev,
> [...]
> +	st->core.param.set_activity.enable = state;
> +	if (ret == 0)
> +		ret = cros_ec_motion_send_host_cmd(&st->core, 0);

The assignment of `set_activity.enable` should be in the if-branch too.

