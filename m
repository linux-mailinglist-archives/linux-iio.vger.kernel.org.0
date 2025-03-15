Return-Path: <linux-iio+bounces-16882-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC236A631F9
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 19:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B05174F19
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 18:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685591990AB;
	Sat, 15 Mar 2025 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSaINZgb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FA1189916;
	Sat, 15 Mar 2025 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742064917; cv=none; b=iZmSVy3BWgbKL+icA4W8oDjay1/Lqdb3mh7f+3twe4C/Jdxsqsu9wmvu+eM+P0sqK/dpJ8zUYxrQn5HDUC/Qo6DJs4d7tYNlxYtnOrWpA4MBkxN55bzcH417PPoybBjUwnJvFJPEy+Suzh3HL7HX8Y0+DWzXw4G5BI4eaPcIbsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742064917; c=relaxed/simple;
	bh=5vA8XtN2p8J55g2czLdjKOjsF4zA2c2ijUOq3nZOfLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUWYO4nIUKR9JoxzKOcmqe8RZ9GGz8zUVv0SPYtvxOVF2Yr8i4oNLVMubxey/VyRe7ritAmifDTMk8t3lNn+wzAAuEVhMxtWIeY+oDkGuIKm2HOnqzhJ1Ap4xLBjE+gNwziJQsCndIrBY1DzGKuDlQSM9X9j71tWaw0uaPvjTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSaINZgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438D2C4CEE5;
	Sat, 15 Mar 2025 18:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742064916;
	bh=5vA8XtN2p8J55g2czLdjKOjsF4zA2c2ijUOq3nZOfLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eSaINZgbcmEleoPprA5AuY8V87mGTnB+icLPa7WQPn871whhfhtTlCuGk0+y8hdXf
	 kWQWtcpo9oQv/V+eXxd82MQ39xk6Z18ZMcnc2fZzYB7AAr7/hOBOXLAQW8xXLPy2R0
	 0+2loMZ9ILepdnpw4HKQ0t9MXHSMTser1uo60m+FstpedX38/DtrvvXcdVL28Tr31M
	 9RChewxn/j9jfOy5EKe89Ylwz5dQdE42KR9249NNk91aLdAIHSDLwddrao4Yz42203
	 2/pJ8ZyeL/qYC+tbep8CLLIfG/z6K2NaKiD+htvehA5BrYSCplQX5LPJNOEotV22or
	 7umUmF1XAMqlA==
Date: Sat, 15 Mar 2025 18:55:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Alexandru Ardelean <aardelean@baylibre.com>,
 Beniamin Bia <beniamin.bia@analog.com>, Stefan Popa
 <stefan.popa@analog.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] iio: adc: ad7606: fix kernel-doc comments
Message-ID: <20250315185508.526cbec6@jic23-huawei>
In-Reply-To: <20250312-iio-adc-ad7606-improvements-v1-6-d1ec04847aea@baylibre.com>
References: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
	<20250312-iio-adc-ad7606-improvements-v1-6-d1ec04847aea@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Mar 2025 20:15:44 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Fix several issues with kernel-doc comments in ad7606.h:
> * Add missing ":" to @param names.
> * Add some missing parameters.
> * Remove some non-existent parameters.
> * Fix alignment and wrapping.
> * Fix some spelling.
> 
> `./scripts/kernel-doc -v -none drivers/iio/adc/ad7606*` is happy now.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ad7606.h | 90 ++++++++++++++++++++++++------------------------
>  1 file changed, 45 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index 71a30525eaab512fa811f28fa79268a1a976bc8c..3da78488c8a247dccbff930023f98717d540081a 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -120,17 +120,17 @@ typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
>  /**
>   * struct ad7606_chip_info - chip specific information
>   * @channels:		channel specification
> - * @max_samplerate:	maximum supported samplerate
> - * @name		device name
> + * @max_samplerate:	maximum supported sample rate
> + * @name:		device name
>   * @num_channels:	number of channels
> - * @num_adc_channels	the number of channels the ADC actually inputs.
> + * @num_adc_channels:	the number of channels the ADC actually inputs.

What does that mean?  ADCs don't input channels, they have channels which
are inputs.  Turns out I don't read the docs closely enough whilst reviewing ;)




