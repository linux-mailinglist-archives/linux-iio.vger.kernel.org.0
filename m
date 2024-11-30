Return-Path: <linux-iio+bounces-12853-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD439DF11C
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 15:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 026DCB20D48
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 14:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5CB15A86B;
	Sat, 30 Nov 2024 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZIUBds8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E3A22066;
	Sat, 30 Nov 2024 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732976243; cv=none; b=KwGDmoNMnZZiU3sOt3VBTx6OGVEDmmgcCrG4gknc8TrRNWw3kC+ETge+yEEh+otX/YTnswHokChgQLUiblMbA5h96aGOvnOem7tu1Xv1Sls2eJMEvdhty1qGzcbtlGB6QtvyschaQV+NrLiEqZYUE4G3bdk5UaPaHbo/QUq3A9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732976243; c=relaxed/simple;
	bh=keq1fj17YGKkaMLYkvdWE8QAKY7I2GxLdVVzbjy7hMM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVAGsDB35udNMbrhoUfMth3YVmldeQPOlttriKJLraNvIry+VUlxLCEpwm+p9EdJADiMKHMeEl+hU04MEPiRnyOG8+8l8CyN3RQLYFWYOVsZCwGyUOZfYf7VegpUi7fMXby7lmpYvdQ5L2zxZcldkiKz1CIS6ZoL6JOHqipRqGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZIUBds8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6507AC4CECC;
	Sat, 30 Nov 2024 14:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732976242;
	bh=keq1fj17YGKkaMLYkvdWE8QAKY7I2GxLdVVzbjy7hMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AZIUBds8kTaxjr/vdiVkzP8JLZJr3SZoEPiA3gFKdAih2mIq6FNxlY8KnE9jWclcB
	 htutKykRPY3r9x/hUNdIvBVhZ1bVoGbZNZfwibR409Xv80nCtTwVHhIv7KdwQ3mcWg
	 4uK2QdyPoa2BOi+wgtrmsPEa+BsrHSe13xXi/XIOZLHZwr4Wt32P2ZEnRh6F5gN0n0
	 0+Nf9FwH3L/z3tr3TilblXEn8emS1CGojPusvdQVwnSFkXETZa2F6ONMerF7rIpX6F
	 jO4QIYaPutcsES7TP7CqWEpvpSXjijIw+kz4rvI1VRL7xKQ0AyDIevWBRWy2sPeWXd
	 itq1zJ18WqSxw==
Date: Sat, 30 Nov 2024 14:17:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, krzysztof.kozlowski@linaro.org, nuno.sa@analog.com,
 u.kleine-koenig@baylibre.com, abhashkumarjha123@gmail.com,
 jstephan@baylibre.com, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 5/6] iio: common: ssp_sensors: make use of
 iio_is_soft_ts_enabled()
Message-ID: <20241130141714.7ef99a77@jic23-huawei>
In-Reply-To: <20241130002710.18615-6-vassilisamir@gmail.com>
References: <20241130002710.18615-1-vassilisamir@gmail.com>
	<20241130002710.18615-6-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Nov 2024 01:27:09 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Use the iio_is_soft_ts_enabled() accessor to access the value of the
> scan_timestamp. This way, it can be marked as __private when there
> are no direct accessors of it.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

> ---
>  drivers/iio/common/ssp_sensors/ssp_iio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
> index 88b8b56bfa51..c38bf1dfb7bd 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_iio.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
> @@ -82,7 +82,7 @@ int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
>  	 */
>  	memcpy(spd->buffer, buf, len);
>  
> -	if (indio_dev->scan_timestamp) {
> +	if (iio_is_soft_ts_enabled(indio_dev)) {

It might be simpler to just drop this conditional in favour of always computing the
value.



>  		memcpy(&time, &((char *)buf)[len], SSP_TIME_SIZE);
>  		calculated_time =
>  			timestamp + (int64_t)le32_to_cpu(time) * 1000000;

Good to replace this with something more modern like.

		calculated_time =
			timestamp + get_unaligned_le32(buf + len) * MEGA;

Jonathan


