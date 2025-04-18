Return-Path: <linux-iio+bounces-18290-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4D5A93D1F
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 20:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272171B66178
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 18:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FA421B9E7;
	Fri, 18 Apr 2025 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ptas1FDr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31598186E2E;
	Fri, 18 Apr 2025 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745001518; cv=none; b=RRIVjIH9KdEo3yeSkmKoz0XIGGHQ+1i81WN+7aXhSTakb/AsR6JCuevZtd6lk4EHXyAYflpUVxxb8SfaemrOXdncjeWWwVhdWD1fZzQGdPO79vY5oE32Qh4c95zPf+yhrR7IywZBRYf1ypPQc3jHuGhafbz/lMZnoliaeQN+AVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745001518; c=relaxed/simple;
	bh=KIEAi98BD+qjAVHkk83Yz+i/dryDdHS6TdY07osfnIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nA649kGqz93EQER4omtfYW+OTpaZSrdqj0IXnFuatqVbH+LN0YXdDKrJk+QOc/Bc4sg8XhtWz28SnARHYrQWni8GG0dmc6aV+Hf7CClMOCe4oafAgBKd4MpTth9FEVGQBx7CHD3UuM9Rn96zTVbpD0WAuOAqadao6vVe1yT2RVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ptas1FDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EBAC4CEE2;
	Fri, 18 Apr 2025 18:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745001517;
	bh=KIEAi98BD+qjAVHkk83Yz+i/dryDdHS6TdY07osfnIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ptas1FDrUuNnx3a1mIybs+XY8+bXCzfdzkSsQ6vfwsQr9jR1LBvOqVICJ3NaaYt1G
	 fUqDm6jY81py3F5qGXHUQF53re0gSjyp4OenYJ+yOudOa7lw1aMICc5yp1e3Z0NsF1
	 z8PtCxp/qf0rzTKMklBTuG83LHwmDOyCZ+zewj7bJZzzxGr4MOCxDByC/BOrh9xxfL
	 gxZbQBqjRY2fifQIp0PZTytJA/hHO8L/pus/ft5RRwtTRGiKotUWth3p0UrTGUK1sF
	 NL+kVB2+Z17tPu5w4+vNx/DyqhD7Ok6D3g4rOEslJwXlWTZjpqUCEf16ZkbndRfc/j
	 Ni46Mt5mpDqyw==
Date: Fri, 18 Apr 2025 19:38:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v6 11/11] docs: iio: add documentation for adxl345
 driver
Message-ID: <20250418193833.4abe05e7@jic23-huawei>
In-Reply-To: <20250414184245.100280-12-l.rubusch@gmail.com>
References: <20250414184245.100280-1-l.rubusch@gmail.com>
	<20250414184245.100280-12-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 18:42:45 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> The documentation describes the ADXL345 driver, IIO interface,
> interface usage and configuration.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

This probably wants updating to reflect the subtle _all_ vs _any_
definitions for the various events.

> +When **activity** and **inactivity** events are enabled, the driver automatically
> +will implement its hysteresis solution by setting link bit and autosleep bit.
> +The link bit serially links the activity and inactivity functions. On the other
> +side, the autosleep function switches the sensor to sleep mode if the
> +inactivity function is enabled. This will reduce current consumption to the
> +sub-12.5Hz rate. Inactivity time can be configured between 1s and 255s. When 0
> +is configured as inactivity time, the driver will define a reasonable value
> +depending on a heuristic approach to optimize power consumption.

> +A **free fall** event will be detected if the signal goes below the configured
> +threshold, for the configured time [us].
> +
Also the examples later in the document will change with the introduction of
a pseudo channel for freefall (where there is only one set of parameters for
all channels). For activity / inactivity the per channel enables mean we keep
those on the individual channels.  It's always a bit odd to report an event
for a compound channel that doesn't have it to enable, but we've never found
a better way to handle that.

Jonathan

