Return-Path: <linux-iio+bounces-15967-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431FAA40A2D
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08AC3BD94D
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 16:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEC020B80B;
	Sat, 22 Feb 2025 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jve7SOdm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323AA20B7F9;
	Sat, 22 Feb 2025 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740242625; cv=none; b=aQ50cOolM349btMzOoldQHAqUiohNrlI0eWVajfFwUOxXCRevAvjTHIyqSMGeoJbvF64fEEM6l3xOCTa1AX35mCQN/zaCUaL1YFBesid1rStELVWH/QZJxd4XQEleUlYh3yAmzBJaPj5X69XAL0N/cf8Grv1bHWavkbbcgkH1NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740242625; c=relaxed/simple;
	bh=GMd6Z/VOUwSptv1nfxzSMtHR/r8XyJvXtoxSAStk3rY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mx7ADzZz5jg1j94WWJ2CPT3KaaUWDYuKH0G1rv1XfVLqdQzZeN4FwOf/kMLwd0hAGQcVYhOFXtbRKZ9tpx9XujCpzaeYUUVLbLceQlC9bNKm+sLDg6xNG5j/Qm6ZihGHGqgGHA8c8e4iE8uMq/ykQ2rGnguITmGN4MG8GsgwSzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jve7SOdm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A787C4CEE8;
	Sat, 22 Feb 2025 16:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740242625;
	bh=GMd6Z/VOUwSptv1nfxzSMtHR/r8XyJvXtoxSAStk3rY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jve7SOdmYQDbiu9LbIYA2ITKCyFb9pMNIc0YuDr5AwdkK+t/mKSmgDUGDz9fZ4TiQ
	 UssUXBKZ4GaSnDLS+E/QjULboz801+1Tt5Ypip/PSDa1lY2kYY0MLU5wgfLXS4S3J5
	 NrxxlAKtm0fV/hA69G7tR/DAvSMTL3UQWn5jfHEkz7yvvGaG6Bs4d1rc6yqJMCyBKl
	 ixsvTA4kF8mwU6aeegc6t1vWhIl9DVzXLoBxfZbdrHYPE+H/uNiA6qlztqUsVtjM+Y
	 k2LBvZAAYQsvKhKS2IvQzzFORWE7UVaCemCw+NkZaugMFau+zlJOsQvIH61gFfMgC5
	 8vyFMqz+VH/Bg==
Date: Sat, 22 Feb 2025 16:43:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3] iio: light: Add check for array bounds in
 veml6075_read_int_time_ms
Message-ID: <20250222164337.0372fb58@jic23-huawei>
In-Reply-To: <Z7dnrEpKQdRZ2qFU@Emma>
References: <Z7dnrEpKQdRZ2qFU@Emma>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 17:34:36 +0000
Karan Sanghavi <karansanghvi98@gmail.com> wrote:

> The array contains only 5 elements, but the index calculated by
> veml6075_read_int_time_index can range from 0 to 7,
> which could lead to out-of-bounds access. The check prevents this issue.
> 
> Coverity Issue
> CID 1574309: (#1 of 1): Out-of-bounds read (OVERRUN)
> overrun-local: Overrunning array veml6075_it_ms of 5 4-byte
> elements at element index 7 (byte offset 31) using
> index int_index (which evaluates to 7)
> 
> Fixes: 3b82f43238ae ("iio: light: add VEML6075 UVA and UVB light sensor driver")
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> ---
Superficially this looks hardening against malicious or broken hardware.
That is fine to add, but not worth backporting or (in my opinion) adding a fixes
tag.

>  drivers/iio/light/veml6075.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
> index 05d4c0e9015d..5dd951f6e989 100644
> --- a/drivers/iio/light/veml6075.c
> +++ b/drivers/iio/light/veml6075.c
> @@ -201,7 +201,12 @@ static int veml6075_read_int_time_index(struct veml6075_data *data)
>  	if (ret < 0)
>  		return ret;
>  
> -	return FIELD_GET(VEML6075_CONF_IT, conf);
> +	int int_index = FIELD_GET(VEML6075_CONF_IT, conf);
> +
> +	if (int_index >= ARRAY_SIZE(veml6075_it_ms))
> +		return -EINVAL;
> +
> +	return int_index;
>  }
>  
>  static int veml6075_read_int_time_ms(struct veml6075_data *data, int *val)


