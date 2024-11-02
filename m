Return-Path: <linux-iio+bounces-11844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A1C9BA116
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 16:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F221C21220
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 15:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3CE19F43A;
	Sat,  2 Nov 2024 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZphQmlR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1599185936;
	Sat,  2 Nov 2024 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730560875; cv=none; b=ZUB1SMxa+iBiaSbBPDsbrmH9TEl0lWnuBw4CL6Bm7ix7t1nptdqm2xBgN+TRThfFh65Km2urx7ArC6J/dDW2x8VyCHVjH5Yluzu0jKXUe6J1RRJE2mUuXrYp4Aco1BzotSP4zueI6ZbH1ZUWL9KhSgyAziIo4ntj1GGQU3mYYJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730560875; c=relaxed/simple;
	bh=c48xrv7SXWSlyNw9zBeH61uTx+IQzvAC/zSLip/G0Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bcdy13z/zviNeT9Yi9HKmfoMvocq1qJRwr3DtUbCpDQ24aOASkIxW3FueZzv5b8CZGsOnrLzpAlp+3H4FPmgXuq8Pn9Gdr7nv3VBjFzylPWBWD3fvabLqcH4aXLhN131p7oPTP77RZFysXCIjqgcSFcCTb5zdAPdlmytd3Ptvdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZphQmlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09539C4CEC3;
	Sat,  2 Nov 2024 15:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730560875;
	bh=c48xrv7SXWSlyNw9zBeH61uTx+IQzvAC/zSLip/G0Sg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tZphQmlRjs1GzXQmMY4CZt0k5Gt6FeSzBKWxBUJsRhFPVd6HdD3kdrz3WdR/NFv7f
	 fbM1/wO4MYp8LMqz+ow6/zaoGjLh4lXu5dLfVQqvSAu5/31QTT4j2ihxP5872eK/KU
	 os28qUTeP/RY8i4WxGrpX2uDd9vO3FKO0EpmHc/OxPDFLBnNYGiXLhJt4Jyx/U8BMT
	 OSXuHiKjHQA2sM8e+2skLZvdaL82KqVNovxy1m+D5LFA6YjTJfWutHOsOZhTxI4tNQ
	 c1hSwrJVvlUBIFfKZOoPO/0uOK6ivsFUFhTVsmtJiCU9SryVU9skhY9jIrel+8eaI+
	 bvgXJiw6t0gOQ==
Date: Sat, 2 Nov 2024 15:21:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 anshulusr@gmail.com, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] iio: chemical: bme680: refactorize set_mode()
 mode
Message-ID: <20241102152106.0b81d7d7@jic23-huawei>
In-Reply-To: <20241102131311.36210-2-vassilisamir@gmail.com>
References: <20241102131311.36210-1-vassilisamir@gmail.com>
	<20241102131311.36210-2-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  2 Nov 2024 14:13:05 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Refactorize the set_mode() function to use an external enum that
> describes the possible modes of the BME680 device instead of using
> true/false variables for selecting SLEEPING/FORCED mode.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied and pushed out as testing to see if 0-day can find anything we missed.

Thanks,

J

