Return-Path: <linux-iio+bounces-24049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8804B56116
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4041B21A8C
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 13:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712352EE273;
	Sat, 13 Sep 2025 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIKYfe9P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294262E8B6E;
	Sat, 13 Sep 2025 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757769741; cv=none; b=tUwlYi2TpKcJN/vmO+muECmYbjgDXXocs5aITdVrKDfnOhRwApCc6SFHw5y/cj6OOt/b5neK+nggUi8r+C7HLk3xAneLNLfYKbQ/wcdZnhrtyJsBRcYKlXWZenK5HFLb1d4lhpDlaKKSNuQQncihHie8MjmhjD3xFmxck6GZ9Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757769741; c=relaxed/simple;
	bh=1yirclNQYQ9pvR5iT8CCm4GJcTNKlFCoefM4BLh5Ey8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/dUf6Z26qzK+4KeuzUP0VM6laqaUB7boh3Y+5WVIF3bqpomLzHOz3UAKMU6RRtjB3QtqMU4MF2Uo3xZhcOz8HYCfKBx8pFxmETvjKeS+GaE8xIl27Lb5y4WWEPRZBaXBCgYBDxHerDTYsNAyV4kACXOG0sQ5ECp6QRx0bO4xsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIKYfe9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B7DC4CEEB;
	Sat, 13 Sep 2025 13:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757769740;
	bh=1yirclNQYQ9pvR5iT8CCm4GJcTNKlFCoefM4BLh5Ey8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nIKYfe9PPHPi/3k5qw5D4NTMg9JzZ9xSq8QBimrsvnkbQZql4E2ejAmJ3ZfqPVP7b
	 lIEhe81+58wUYA3TWc6eoD6+/RvfvwAIddUdVH/VZQvphd0jUF7bfihOBNh9D8Fy38
	 pfqG21kdQylK6zCyTrd9I7woyO9iQV+/dXgn4Q0QCqc6KryCqwgo/JVpJimSAV4htO
	 5wQKqM07srdxZEajh6t5bxrV0EFMyHKZq6Cy2plNCos3OTSbhWMXLGrtswzQThBpe4
	 19ugr36FZB4QJTbqI0pOEG+1ORMnfEr7KePo9pz03hkV8HPoHlVhzwlb+87i0O8WmL
	 1dcQUHURO7kqA==
Date: Sat, 13 Sep 2025 14:22:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 0/6] iio: adc: add support for ADE9000 Energy
 Monitoring IC
Message-ID: <20250913142212.1face3f5@jic23-huawei>
In-Reply-To: <20250908073531.3639-1-antoniu.miclaus@analog.com>
References: <20250908073531.3639-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Sep 2025 07:35:20 +0000
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> This patch series adds support for the Analog Devices ADE9000, a highly
> accurate, fully integrated, multiphase energy and power quality monitoring
> device. The ADE9000 is capable of measuring energy consumption and power
> quality parameters in industrial and commercial applications.
> 
> The series includes:
> 
> 1. New IIO modifiers for power and energy measurement devices, including
>    support for active/reactive/apparent power, RMS masurements.
> 
> 2. Device tree bindings for the ADE9000, supporting waveform buffer
>    configuration, phase configuration, and trigger settings.
> 
> 3. Complete driver implementation supporting:
>    - Multi-phase energy measurement (3-phase support)
>    - Power quality monitoring (voltage swell/dip detection)
>    - Waveform buffer capture with configurable triggering
>    - Energy accumulation with configurable time windows
>    - IIO buffer interface for continuous data streaming
>    - Event-based notifications for power quality events
> 
> The driver provides a comprehensive interface for energy monitoring
> applications through the IIO framework, enabling userspace applications
> to monitor power consumption, quality, and waveform data.
> 
> The driver will be extended in the future to support multiple parts such as
> ade9039.

Hi Antoniu,

Applied with a few changes as described in replies to individual patches.
I also called out one significant refactor that I'd like you to consider
as a follow up patch. Given it was late feedback I decided not to ask
for it before applying this.

Jonathan

