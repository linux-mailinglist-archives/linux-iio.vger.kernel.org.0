Return-Path: <linux-iio+bounces-22091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD97B1391C
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 12:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49D5175244
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 10:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB0D24A061;
	Mon, 28 Jul 2025 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PzhI0zNV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84C0248F67;
	Mon, 28 Jul 2025 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753699165; cv=none; b=A0HiHy4u5Cl7EhEJBleGjrcJydzVIyhm6/nilpc9ChC2zjco28yLft7imgwegmihGe11E3nDVBGEi+mnx0m3vn7CDqEU5Jv8dwB5tfhg52MjakpKcUUXUVO6CazeVxS/+iC1946sRn/WFNnX53R/RFtVKKpc+eUpuPGjNLGu4rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753699165; c=relaxed/simple;
	bh=QkXdsf3bej8sdCy1H+iqKmavFYLwulEByam8In92J/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4YkvD5h+P5MRKbeMGjgp6RCBW5D2Yq+kjEIBiJRsPL3ruXLPZ4ZRLVkjMUEk7BjcqZ9mRpfRzEKEwzGaAhtLMBR2hTgwCJqSPXkdOm/UA9WARe2FzULom06/YNj8Qt5ETTn7IxUQ79LVLaNvAIrl41n1XMLq30VuGc7M60p2bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PzhI0zNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85674C4CEE7;
	Mon, 28 Jul 2025 10:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753699165;
	bh=QkXdsf3bej8sdCy1H+iqKmavFYLwulEByam8In92J/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PzhI0zNVdN80jcE8glpiKvRm8F/yacw3llfsJnuFzXBnr01ETsitbWFRa0RB3n+B5
	 Evyw+gD+v9wGzqdpnKmhrq2XKgk2px1rCacshmzCx+ewZ0Jo+AbNvXKq9M66Ek7/iK
	 4c0IN0iIdYDVjsVIPbJ3umLENE0/fshv5P3okt2o=
Date: Mon, 28 Jul 2025 12:39:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com, gshahrouzi@gmail.com,
	hridesh699@gmail.com, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: Re: [PATCH] staging: iio: ad5933: Fix implicit fall-through in
 switch()
Message-ID: <2025072835-singer-penny-a421@gregkh>
References: <aIdKAJVnskdAVUMi@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIdKAJVnskdAVUMi@bhairav-test.ee.iitb.ac.in>

On Mon, Jul 28, 2025 at 03:29:28PM +0530, Akhilesh Patil wrote:
> Add default case in switch() codeblock in ad5933_read_raw().
> Convert implicit error return due to switch fallthrough to explicit return
> to make intent clear. Follow kernel switch fall-thorugh guidelines at
> Documentation/process/deprecated.rst
> 
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---
> Checked build for 6.16.0 kernel with ad5933
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 85a4223295cd..6547a259b8a0 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -533,9 +533,10 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
>  		*val = 1000;
>  		*val2 = 5;
>  		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;

What tool is requiring this to be added?  It's totally redundant and
needs to have the tool fixed instead.

sorry,

greg k-h

