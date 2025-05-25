Return-Path: <linux-iio+bounces-19874-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE4AAC3483
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 14:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6662E189618C
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 12:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B59A1E8345;
	Sun, 25 May 2025 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pne1JyhB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468791388;
	Sun, 25 May 2025 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748175586; cv=none; b=EUNZ7in08pfL2p1FfUsrt7R4tUR+su9F6isGcmirkqsx9rUV6A1Rq6RaC6fUR3kjw502rDtYhdN8zgi3C4mvCaBYbG/dGS34UZ7O04rt+FgdyCFJJZeht3X57XmApCp+iD7qyvkGRD1G1gQXObYyFCdk0MAyN7LGxxFN7mlQlpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748175586; c=relaxed/simple;
	bh=W/GId1S3W2leYBT/9h8AM/IvHXYRLHn83MmYqKdInqk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhTwDrUv1b4xo7HSK8cQvFQBU6ZgthFm5kdnljtxYTxuPLUI4iyyOQ+QnfbnMSXBoRwlsKoQ/h7EAJnSWTeOBfbo2GRL8WHgHf4rRveTNXqlMFACdx0jYtdqigx0DX7B3boYMwJ03ujNWyDJK8kjNQ4EivoZFdmAGlRUUrKNoLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pne1JyhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7B8C4CEEA;
	Sun, 25 May 2025 12:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748175585;
	bh=W/GId1S3W2leYBT/9h8AM/IvHXYRLHn83MmYqKdInqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pne1JyhBTCtJb/LccwALfFO28dnDWmeIppoo4IJmWtL8nf4AtWWstcBJNt87m0X0R
	 mEaxcV2wbFSrQZjYeEMN6IlfnM5f9GLckOkZnFcInRWREOVEgPgMY2u9s3cdqN/+o1
	 HOwNEjBe8TSrESJ4j9fc35ZaKhssnU5xixZflOX6N6eTsCbeSOziz4XiPOJxoxpHSx
	 vHzJSTPflA5+h/dqHY+cRx/fu5Ovr6ntyxBGcjJNpXXV2S00UMGVDj4OhxwQjDMr9V
	 RQ1x1VW4Gdkkjf0UF/vZUSOQJu/yP8B9gi7jgGCouh3AJ9I/rK9U02odNZek1tgoVM
	 Zaj/SUMtdFHdA==
Date: Sun, 25 May 2025 13:19:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/12] iio: accel: adxl313: configure scan type for
 buffer
Message-ID: <20250525131937.54c4d0e5@jic23-huawei>
In-Reply-To: <20250523223523.35218-4-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
	<20250523223523.35218-4-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 22:35:14 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> According to the datasheet the ADXL313 uses 13 bit in full resolution.
> Also, add signedness, storage bits and endianness.

Another one to squash with the patch that introduces buffered support.

> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl313_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> index 9c2f3af1d19f..06a771bb4726 100644
> --- a/drivers/iio/accel/adxl313_core.c
> +++ b/drivers/iio/accel/adxl313_core.c
> @@ -184,7 +184,10 @@ static const int adxl313_odr_freqs[][2] = {
>  	.info_mask_shared_by_type_available =				\
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
>  	.scan_type = {							\
> +		.sign = 's',						\
>  		.realbits = 13,						\
> +		.storagebits = 16,					\
> +		.endianness = IIO_BE,					\
>  	},								\
>  }
>  


