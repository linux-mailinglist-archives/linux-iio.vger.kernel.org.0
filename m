Return-Path: <linux-iio+bounces-15605-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA89A37662
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 18:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7DC3AAD28
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6E118DF6B;
	Sun, 16 Feb 2025 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww1CS+nS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471D6405F7;
	Sun, 16 Feb 2025 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739728037; cv=none; b=X1q1OCtUMeTxBgFq34khStcZQQllEBfVc9/S30eJNuWYc44WfjwHcxXFfDIJlzNS8ceKW21AeqM+mgvzOpV4WhkHTj79mwoj6gzex6F43Yo0elAxRllOZVhdqfEMMUntYYI0pnh0A/IKtvuatK6BCH6AxNwtzR8fxA6G+5nTg1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739728037; c=relaxed/simple;
	bh=BuGzOO1oasV+jexDVpsDSNPhZMW2r5PgM3V8hlhAHNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIgBzBsjhqRu3wmQKM0gA/zhqY9isU9UW9Yw8PmWY7iUKrLzJTmSFYC9y2HXD2K8IKW+TLidS117XvlHmaGd54UB7SMuBgv+tNxZ3tZJnsZFfB15bByDY3fSuf9/PU2G0UXTKWu3C5UnS1/SUITMNBUOBQgkX7hacfV5BVF/ZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ww1CS+nS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145A3C4CEDD;
	Sun, 16 Feb 2025 17:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739728034;
	bh=BuGzOO1oasV+jexDVpsDSNPhZMW2r5PgM3V8hlhAHNQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ww1CS+nSBBQQIpNAkzrzrQKzGY4WHPQzcoa3p11IunF1jRoIcpaodcEWTN/ZXzRLK
	 em7CfBwpbyQrq6vHIosiPNPaCiT9KmiBS6SCE2weVjdcKeYsXPFDxpEl3lQ870myXV
	 8Hsf5LCO64YN17kl+Mz2t/SK7crZ3+vhgp12ebQm7EwTWEhHinzJlmHDj1lGRYT7J8
	 JaIKP3Gt5ryuSOy7Ffhei2+lidKll7m8BpsGl8Gj6owczROC4KdWHcGrAy3bLsBDwe
	 6KaIjoBJ2eJlCmK6tn2hAQopMbblPsaWwQvWTjgrh+G8AsbqEx/R5uqiscsy7g6IQ1
	 goAOSH0DlfnzQ==
Date: Sun, 16 Feb 2025 17:47:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 12/14] iio: accel: adxl345: add inactivity feature
Message-ID: <20250216174705.712beaeb@jic23-huawei>
In-Reply-To: <20250210110119.260858-13-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
	<20250210110119.260858-13-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 11:01:17 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the inactivity feature of the sensor. When activity and inactivity
> is enabled, a link bit will be set linking activity and inactivity

are enabled, a link...

> handling. Additionally, the auto-sleep mode will be enabled. Due to the
> link bit the sensor is going to auto-sleep when inactivity was
> detected.
> 
> Inactivity detection needs a threshold to be configured, and a time
> after which it will go into inactivity state if measurements under
> threshold.
> 
> When a ODR is configured this time for inactivity is adjusted with a
> corresponding reasonable default value, in order to have higher
> frequencies and lower inactivity times, and lower sample frequency but
> give more time until inactivity. Both with reasonable upper and lower
> boundaries, since many of the sensor's features (e.g. auto-sleep) will
> need to operate beween 12.5 Hz and 400 Hz. This is a default setting
> when actively changing sample frequency, explicitly setting the time
> until inactivity will overwrite the default.
> 
> Similarly, setting the g-range will provide a default value for the
> activity and inactivity thresholds. Both are implicit defaults, but
> equally can be overwritten to be explicitly configured.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
A few things follow through from earlier patches (I'll assume you'll
apply those throughout).  Otherwise LGTM. 

