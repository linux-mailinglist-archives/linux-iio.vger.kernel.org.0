Return-Path: <linux-iio+bounces-14900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55795A256BF
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 11:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B901619AE
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 10:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE45120011F;
	Mon,  3 Feb 2025 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpADL48e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7725138F83;
	Mon,  3 Feb 2025 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738577816; cv=none; b=LKN+RqMg4GgmxsuwY3CX4+QhjR9Hu+aHOco1Pk4YHnkYzp523Z8vKmOv631Q8CANPukw3FgujbwyMfI1X65wFTWCzjpWkKowE6nNcONml54iexkR0jtYpVR4YFzbt2dWItgRkB+CdIHWZHg0QWsdnI32rSf3uDiFiaIHuolXqHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738577816; c=relaxed/simple;
	bh=jEQEXcJrA+AyTpm1UhRXvi87pn7txfzFbDoxW5r1xw8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=a3T9J3mE+kqPTMznYSbVorWd4Nwp3Fx0D5THXPmDXAXQsANe4oGAXpmrWRVAza4ImnXV9DuIUCCNw3gt4gkREkDGfTq+Bwb6VnduhHNx/1nBah266cwZXZwwyNtpcEEurxBiNj04iCDRTmkkyUOMqR6KJRcitqnp8R4ozJfsYIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpADL48e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEF9C4CED2;
	Mon,  3 Feb 2025 10:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738577816;
	bh=jEQEXcJrA+AyTpm1UhRXvi87pn7txfzFbDoxW5r1xw8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=lpADL48e+QhQVJlwEE+zihafuoiQX3d2DQHaQImZcegIU+we6DWn1tHN7Inljqqtn
	 u/DjdLbjVzAuHInSuJpDxoiFRgTRcKrkoEwO6jF+LRkQVgJl3Y9yw0xahsDUNg1aMY
	 wDefi/QdkTqJq0hHjut/QfISx1YY8ReOGK4eSgLlWHRq5Jn5lDTp0KGaUs7RBOiV7P
	 eYE7Kk4O7vy5KBoVsls+U8gMzlQyAgeHWeE0BX75nl6xvc+n3eeptZT18TtSgE/NBt
	 Uv4/8ofQCX230SRZdlkMB4KNcJB68vbir2x9Vu6mCrTOQQmydjj5gFp58vs6qKAyEl
	 GGfBat1bWCGVQ==
Date: Mon, 3 Feb 2025 11:16:53 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
    Peter Zijlstra <peterz@infradead.org>, 
    Greg KH <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: quirks: ignore non-functional sensor in HP 5MP
 Camera
In-Reply-To: <20250115070020.2777721-1-acelan.kao@canonical.com>
Message-ID: <q316oqno-q188-n7o4-90s0-pn9p2p47sso2@xreary.bet>
References: <20250115070020.2777721-1-acelan.kao@canonical.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 15 Jan 2025, Chia-Lin Kao (AceLan) wrote:

> The HP 5MP Camera (USB ID 0408:5473) reports a HID sensor interface that
> is not actually implemented. Attempting to access this non-functional
> sensor via iio_info causes system hangs as runtime PM tries to wake up
> an unresponsive sensor.
> 
>   [453] hid-sensor-hub 0003:0408:5473.0003: Report latency attributes: ffffffff:ffffffff
>   [453] hid-sensor-hub 0003:0408:5473.0003: common attributes: 5:1, 2:1, 3:1 ffffffff:ffffffff
> 
> Add this device to the HID ignore list since the sensor interface is
> non-functional by design and should not be exposed to userspace.
> 
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs


