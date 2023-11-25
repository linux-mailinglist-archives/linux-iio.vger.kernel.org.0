Return-Path: <linux-iio+bounces-345-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07837F8BF8
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 16:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13261C20311
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 15:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EEC28E0A;
	Sat, 25 Nov 2023 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L01tF9Jf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24612946F
	for <linux-iio@vger.kernel.org>; Sat, 25 Nov 2023 15:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663BCC433C7;
	Sat, 25 Nov 2023 15:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700925296;
	bh=g4MRYZCrwAzR4gcbAiWJD+UTGWXSA2J1PohiCLNeqRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L01tF9JfXbr/AXBVcy7UX+7F5ZQi7wKMcDoDw9icfrYuion+xOdd5XFSoQmGnUEwd
	 bGeVQKvJMvI/Fs7dW532kqPBwGTvVhUnZDCs2i4GfTPXJr1Tvhy5vNhKEMPs29enRe
	 r6Vx6StolVibVWQ4Ltq1HMVfcm/0EpPmXIFzzq84zIVmn7glZ4LrJn6SKRgOIZysV2
	 YCA6e0FFlQOltot57WjUO59KocIqtybXlwyba6nj4/eDGFwoWsnI8h4utvgVbBYB3K
	 k8janE1/fR1viAXR/iffqKc/GrLkY9R1cPtaJAL5V2d/hP9AtlIFfPdBjY//0ugneP
	 v0trWH2z1cTwQ==
Date: Sat, 25 Nov 2023 15:14:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Gerald Loacker <gerald.loacker@wolfvision.net>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: tmag5273: fix temperature offset
Message-ID: <20231125151449.42f2f2ed@jic23-huawei>
In-Reply-To: <9879beec-05fc-4fc6-af62-d771e238954e@wolfvision.net>
References: <9879beec-05fc-4fc6-af62-d771e238954e@wolfvision.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 06:48:39 +0100
Javier Carrasco <javier.carrasco@wolfvision.net> wrote:

> The current offset has the scale already applied to it. The ABI
> documentation defines the offset parameter as "offset to be added
> to <type>[Y]_raw prior to scaling by <type>[Y]_scale in order to
> obtain value in the <type> units as specified in <type>[Y]_raw
> documentation"
> 
> The right value is obtained at 0 degrees Celsius by the formula provided
> in the datasheet:
> 
> T = Tsens_t0 + (Tadc_t - Tadc_t0) / Tadc_res
> 
> where:
> T = 0 degrees Celsius
> Tsens_t0 (reference temperature) = 25 degrees Celsius
> Tadc_t0 (16-bit format for Tsens_t0) = 17508
> Tadc_res = 60.1 LSB/degree Celsius
> 
> The resulting offset is 16005.5, which has been truncated to 16005 to
> provide an integer value with a precision loss smaller than the 1-LSB
> measurement precision.
> 
> Fix the offset to apply its value prior to scaling.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
Applied to the fixes-togreg branch of iio.git and marked for stable. Thanks,

Jonathan

> ---
> Changes in v2:
> - Fixed typo in the offset value (16005 instead of 16605) (Jonathan Cameron)
> 
> - Link to v1:
> https://lore.kernel.org/r/20231023-topic-tmag5273x1_temp_offset-v1-1-983dca43292c@wolfvision.net
> ---
>  drivers/iio/magnetometer/tmag5273.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/tmag5273.c
> b/drivers/iio/magnetometer/tmag5273.c
> index c5e5c4ad681e..e8c4ca142d21 100644
> --- a/drivers/iio/magnetometer/tmag5273.c
> +++ b/drivers/iio/magnetometer/tmag5273.c
> @@ -356,7 +356,7 @@ static int tmag5273_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_OFFSET:
>  		switch (chan->type) {
>  		case IIO_TEMP:
> -			*val = -266314;
> +			*val = -16005;
>  			return IIO_VAL_INT;
>  		default:
>  			return -EINVAL;
> 
> ---
> base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
> change-id: 20231023-topic-tmag5273x1_temp_offset-17774cbce961
> 
> Best regards,


