Return-Path: <linux-iio+bounces-5622-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FE48D757B
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 14:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D011C21120
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 12:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D2E3AC1F;
	Sun,  2 Jun 2024 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJtRp7kE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73826328DB;
	Sun,  2 Jun 2024 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717333159; cv=none; b=SGAdbWiI5u3+ETfe+onQGWUpNRODHqj6vg1j+jQ78BAJJ13pW3eoJO0Y4zJex8kCkdcoRWu5cr+gZlUi56zG8lSrVxbByeDe4Mggq0tTUpU7SONs6VopjB+wgWdte+BOLIKC2XM2EkWS09aZXvNVWt6z8hTJ+fSplwyyIxi49SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717333159; c=relaxed/simple;
	bh=YViQqRewT4rh/cNeS6fZyLZzXxHkfxYtefPXiS+rd4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fauZ4qaFi7+syumoUnODGrOYM9XzWUV1X+iNfDK171fDsdWUrX80gh3RSViLdS/QYYF6KMNsSBgbIas0zLDxNRbuKAb/tz7awhsI1oIdQXvpv+G0WQKQKYUJJGibMmSGwpypRmi1u9RqrvQCVyXrVpmWZnJqe/mvqfP/0nBnLM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJtRp7kE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAB5C2BBFC;
	Sun,  2 Jun 2024 12:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717333159;
	bh=YViQqRewT4rh/cNeS6fZyLZzXxHkfxYtefPXiS+rd4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NJtRp7kE/2dLjZKtnpUPXlVdL4pR4Zmh2SZkjWs/SdppzdVM9iU8axjDciriswqLU
	 T5SI/jt5oIB4WUZCFMwrwHe3G01PKq4rJH+GpuXOlkUA2fkpMBSoi+RAAjahiUkU8z
	 DUEMv0nt76Dls+OXaTykCCPMJ29k52ryzASyrDG2/4pSRaqO/ksPJTCCoMxE3lgRjG
	 sIAnGdeIwtOk6Q5MsQQq6/bM2nhO+Z8oL6qr9fBIYGXDeMeCchLMX/HT8crSm2NVaF
	 zxtC5Xw55hXm3M+QXbBwWBxn5WuLF9xnyp5cZah4kxm+Zevr5uPgUuXHuMiUjQ+NTZ
	 VL6plWeNEAA0Q==
Date: Sun, 2 Jun 2024 13:59:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 13/17] iio: chemical: bme680: Add read buffers in DMA
 safe region
Message-ID: <20240602135908.7e4183a2@jic23-huawei>
In-Reply-To: <20240527183805.311501-14-vassilisamir@gmail.com>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
	<20240527183805.311501-14-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 20:38:01 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Move the buffers that are used in order to read data from the
> device in a DMA-safe region. Also create defines for the number
> of bytes that are being read from the device and don't use
> magic numbers.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

Same response as previous.  I don't think it's necessary because
of the custom regmap implementation.

My first instinct was the same as yours though!

Jonathan



