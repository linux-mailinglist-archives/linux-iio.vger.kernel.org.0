Return-Path: <linux-iio+bounces-18006-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64306A86D07
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 14:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E5F1B67746
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 12:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333C71E991D;
	Sat, 12 Apr 2025 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIT1qZ1T"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2AB19F41C;
	Sat, 12 Apr 2025 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744462209; cv=none; b=HnXxA2OVNi2Wt6Vb8X0nWTR3R7bK063CmnqZhoSyZDxhde2DmauBmiO5iuXczQ3RFOcXnD7UJThYhR8iirvfvV/eHoCYsZtOfHX6OB+YJfXI8gTOphM1t8ukCSf1G/OJIZETi2bb9Jn8JY9i5LfjdkmLMSk6q3EVB9YPx4yF/t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744462209; c=relaxed/simple;
	bh=M92R1sA/oaQWHhu9rd2suZHFanauK8ygZLX96I1zQRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PlabFmQ121IaVj1Q7OcRFyuezHJxW7OVxbxy8tCED6UVNh0NllUpMymTVnsUngZ+dm+9JlNLKHmtCagUZxiffT+6OytoZNckAQ6MXVEdXoWpB+XqJO75e4c6IMhybq8biG9LoP1s4/1C6xPNhBbpmU3xc4FsjiOGn9b09URJ+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIT1qZ1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96209C4CEE3;
	Sat, 12 Apr 2025 12:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744462208;
	bh=M92R1sA/oaQWHhu9rd2suZHFanauK8ygZLX96I1zQRc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PIT1qZ1TjFW+TkZPQAfbPOFCRytrnJWL7NTue0aJuoS0nTm7fhpZIqg/syJrPgzDe
	 arnYhlGoq3gBLLPnqCtc0YY9nlwnmFL7kJvkW8x/sZfMfXducQ9GJf62i2gaUi7FW0
	 5EWYJekcvdHEe4I6zDHgUOI2rNWieQhYyqNhuclIHDSmb75+hdenGaYfWSHUq7Akj2
	 vABlVfrfgPfaqT4F0r6kkFC4Z5A6hm/P/hNmAMJrVOTD9NVY12FUS0qNcGghEt6p2s
	 oLLWo6qMBo00wRKY75jqDwfKysVguTFIAfeeiYQFWOX6A9I3Y1lAD6NLb1SU5RQhks
	 yBCZWZPBVyrZw==
Date: Sat, 12 Apr 2025 13:50:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] iio: imu: inv_icm42600: switch to use generic
 name irq get
Message-ID: <20250412135001.7a8489e6@jic23-huawei>
In-Reply-To: <20250410-iio-imu-inv-icm42600-rework-interrupt-using-names-v4-0-19e4e2f8f7eb@tdk.com>
References: <20250410-iio-imu-inv-icm42600-rework-interrupt-using-names-v4-0-19e4e2f8f7eb@tdk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 17:39:39 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> The purpose of this series is to switch to fwnode_irq_get_by_name()
> in the core module instead of using irq from the bus parsing.
> 
> Add in dt binding interrupt naming and up to 2 interrupts support.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Applied to the togreg branch of iio.git. Initially pushing that out as
testing for 0-day to poke at it.

Thanks,

Jonathan

> ---
> Changes in v4:
> - Change dt-binding commit message to be more explicit about interrupt
>   support.
> - Simplify fwnode usage, NULL checking is already done automatically.
> - Link to v3: https://lore.kernel.org/r/20250409-iio-imu-inv-icm42600-rework-interrupt-using-names-v3-0-dab85a0a7c2b@tdk.com
> 
> Changes in v3:
> - Update dt-binding to report support of the 2 interrupts and delete
>   remark about driver feature support.
> - Link to v2: https://lore.kernel.org/r/20250407-iio-imu-inv-icm42600-rework-interrupt-using-names-v2-0-c278acf587b2@tdk.com
> 
> Changes in v2:
> - Add INT2 in interrupt-names enum and fix enum
> - Add fallback to first interrupt if naming is not here to ensure
>   backward compatibility
> - Link to v1: https://lore.kernel.org/r/20250404-iio-imu-inv-icm42600-rework-interrupt-using-names-v1-0-72ed5100da14@tdk.com
> 
> ---
> Jean-Baptiste Maneyrol (2):
>       dt-bindings: iio: imu: icm42600: add interrupt naming support
>       iio: imu: inv_icm42600: switch to use generic name irq get
> 
>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml   | 13 ++++++++++++-
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h                |  2 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c           | 14 ++++++++++++--
>  drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c            |  2 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c            |  2 +-
>  5 files changed, 27 insertions(+), 6 deletions(-)
> ---
> base-commit: 1c2409fe38d5c19015d69851d15ba543d1911932
> change-id: 20250325-iio-imu-inv-icm42600-rework-interrupt-using-names-b397ced72835
> 
> Best regards,


