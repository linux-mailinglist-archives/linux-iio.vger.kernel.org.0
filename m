Return-Path: <linux-iio+bounces-10520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CD399B5D7
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 17:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790C41F225CC
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 15:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B420517C7C;
	Sat, 12 Oct 2024 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDe1IezR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8F0E55B;
	Sat, 12 Oct 2024 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728746209; cv=none; b=rCUo7XyjJIQQ62FhnY1uwByBt6mBiyhcGyOfF67UFZFzdaMCvsW8GQPuJFFMKu3otH3zB59ExIJI0m5w+8LlAO5or2+jMpOfx6NHL63/7cNxFxcpKuHt3d+FmvKPJLkdAkUNhCVQXuMyTMgH5vllE3sSG02ciTZ/Kulkgi9lieY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728746209; c=relaxed/simple;
	bh=wm/2nXx1K8X3lwtDntDm70d/iRhIi/dbF902mhTF7pI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UbHvigOXekfvMx1iqK6da4Q6pZvFkH1ml9NHZ9GNJukUMlBizzTO03E5ACPfN3oBzg8eiC8uaEYSzVaPc77gnMedUuf6qC+/ARZul1QwNStZ4RFkDwTFp6iCVCXLe9q49VnSkZ+zt8jX10Bzja9Ja9jkXGCw7rDgHIKzkeZROa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDe1IezR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B68BC4CEC6;
	Sat, 12 Oct 2024 15:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728746209;
	bh=wm/2nXx1K8X3lwtDntDm70d/iRhIi/dbF902mhTF7pI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KDe1IezRkTeFyBnXBDCAI2L9teyPQ2ExnbgjYtbrpy0Zbh8sckZRJxA3HYUVR2duo
	 oRNFgnRkdNjNmCeOpc6xLYNEzIXatjo/nDssO/4PbqAnkO1issRRDUlmgauIHDxx0h
	 ev6ueuMGCNl5l//KF7s44MvkWV89VQvkWI4DVC9MRPCdYStSmTxWp3XEaKcxH9NtD6
	 2jcOWOso+hH6u9EQOFbOpRpQRK+0HPTC1TCsOKHfQnfob5lAvRy5NytjZdqscJdsN0
	 DhVziACuPfzhpd/I7gZr1mJxPc78gdUQ/b/mDR2Tuf/9TIRdeGD98ACgAcfO0hjE5e
	 Q2tJV7WUwJ5QA==
Date: Sat, 12 Oct 2024 16:16:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Interrupt and Continuous mode support for VL6180
Message-ID: <20241012161641.4a2d4af6@jic23-huawei>
In-Reply-To: <20241007152223.59008-1-abhashkumarjha123@gmail.com>
References: <20241007152223.59008-1-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Oct 2024 20:52:20 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Sending v3 again because I accidently sent it without a subject.
> Apologies from my side.
> 
> Hello,
> 
Series applied to the togreg branch of iio.git and pushed out as testing for
0-day to have a first look at it.

Thanks,

Jonathan

> The first patch adds support for configuring the Sampling frequency
> (inter-measurement period) of the sensor. The values should be provided
> in milihertz. The default value for the inter-measurement period for
> ALS is 10ms or 100000 mHz and for Range is 50ms or 20000 mHz.
> 
> The second patch adds support for interrupt based single shot reading.
> We registered an irq_handler that fires everytime the data is ready.
> And then we read the appropriate value in the `vl6180_measure` routine.
> 
> The third patch adds support for continuous mode in the sensor by using
> buffers. We enable the sensor's continuous mode in the buffer_postenable
> function depending on the `active_scan_mask`.
> The continuous mode can be disabled by disabling the buffer.
> Added a trigger to the device for the continuous mode. Also validating that
> the device uses the internal trigger provided by us.
> 
> Changes in v2:
> - Fixed `label followed by a declaration is a C23 extension [-Wc23-extensions]`
>   by moving the guard(mutex)(&data->lock) above the switch statement.
> 
> - The above error was pointed out during testing by kernel-test-robot
> 
> Changes in v3:
> - Fixed race condition related to `reinit_completion`
> - Used `iio_for_each_active_channel` instead of manually accessing `masklength`
> - Accepting sampling frequency values in milihertz instead of miliseconds.
> - Minor code refactoring.
> 
> Thanks,
> Abhash Jha
> 
> Abhash Jha (3):
>   iio: light: vl6180: Add configurable inter-measurement period support
>   iio: light: vl6180: Added Interrupt support for single shot access
>   iio: light: vl6180: Add support for Continuous Mode
> 
>  drivers/iio/light/vl6180.c | 255 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 238 insertions(+), 17 deletions(-)
> 


