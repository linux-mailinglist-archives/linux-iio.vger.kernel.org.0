Return-Path: <linux-iio+bounces-18726-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 274ADA9E2F2
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 14:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D893B6818
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 12:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D58246335;
	Sun, 27 Apr 2025 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuiaU9v2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CFEF9D9;
	Sun, 27 Apr 2025 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745756468; cv=none; b=ZO9DFnKp3ZlNEtqbNHG0Tv38iaXPVModblUvZ7IhnC235EBK/9FWQn48h1KbQ/cQg1EC3UKUxl0eCNj60WMPb5KXKiy8R5uNMBwTnguC87fj5WjVnw2JQei5l3nMjiPmhiwj7tieWwrPbZyCvbqLpgn6eV+HjSBr5PIgOF3/c3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745756468; c=relaxed/simple;
	bh=QBt+H1BEzbmzHl3EKfPRU+aY4iREr7uYd8M3J3wCodo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QUIccVISxrb1sw2jlfy8gdVmq6rTJs5for4xrPYTIHxOWi6c/mLZUjVWhRYs+c8J4P/Akl1zeD8bmnPHeVuCejwGs9Gtuc0LUUXWh7acA/zklX57AoeoSOx/+T7lsBm0Aqcdpo9q7fSyG2XIcjlxAjmoGopM+h3PLAiZDDcFgMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuiaU9v2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810B3C4CEE3;
	Sun, 27 Apr 2025 12:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745756467;
	bh=QBt+H1BEzbmzHl3EKfPRU+aY4iREr7uYd8M3J3wCodo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PuiaU9v2wFu+CpbCojPykOTsBuzclHhCoK1dk9CHOk7BLvxRcffMHW6BZJspc1DoL
	 xB8zbX2xYlPrQlt2iaH6v9XkE3zGLjwCni8VRE1+tfn4JucfYb7SWhzJbRXoL9Dsj8
	 zSzuIb6kqVFFEBuzMD2+Y/DvFAJA89gjC3+398UWEmluh0TxlPWVxIKE3DfuiyXIfr
	 Y40J4dhqfru9s79EjCfmRqNlQC0V0mIg6TnxWhTbEcB/sphE1Vkp1U07s4Oq/lwyne
	 ZSuKhTZYQceAdKW/bQcr5YXgb/YVV/ThFe+WYjf42uKkox0ZfJS8phozJWfCaI1pb4
	 2zxV+rsng5pAA==
Date: Sun, 27 Apr 2025 13:21:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v7 04/11] iio: accel: adxl345: set the tap suppress bit
 permanently
Message-ID: <20250427132102.58a3a65b@jic23-huawei>
In-Reply-To: <20250421220641.105567-5-l.rubusch@gmail.com>
References: <20250421220641.105567-1-l.rubusch@gmail.com>
	<20250421220641.105567-5-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Apr 2025 22:06:34 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Set the suppress bit feature to the double tap detection, whenever
> double tap is enabled. This impedes the suppress bit dangling in any
> state, and thus varying in sensitivity for double tap detection.
> 
> Any tap event is defined by a rising signal edge above threshold, i.e.
> duration time starts counting; and the falling edge under threshold
> within duration time, i.e. then the tap event is issued. This means
> duration is used individually for each tap event.
> 
> For double tap detection after a single tap, a latency time needs to be
> specified. Usually tap events, i.e. spikes above and returning below
> threshold will be ignored within latency. After latency, the window
> time starts counting for a second tap detection which has to happen
> within a duration time.
> 
> If the suppress bit is not set, spikes within latency time are ignored.
> Setting the suppress bit will invalidate the double tap function. The
> sensor will thus be able to save the window time for double tap
> detection, and follow a more strict definition of what signal qualifies
> for a double tap.
> 
> In a summary having the suppress bit set, fewer signal spikes will be
> considered as double taps. This is an optional add on to double tap,
> thus a separate patch.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
I'm already carrying to this point in the series on my togreg branch.

Jonathan

