Return-Path: <linux-iio+bounces-11806-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EEC9B9688
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 18:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B505F1F21C4C
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 17:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128811CBE8C;
	Fri,  1 Nov 2024 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMVzLLq+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD461CB51D;
	Fri,  1 Nov 2024 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482175; cv=none; b=KBxF2tlqshjAkhT/IFqQ00cKYXZ8V0tP+ACSqK0MwMGwoEEHqp/NpY2TmAU95M1nSHmmgMKVm0DldlxwXxOxapwVkLbCcRaTpE7aiQfRx0j6RRUE9/vFiVdmQQLaEpwibApXMh/1fL4y0iBaVW/PBXrcUaLYFO2DQu7YvB1G6ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482175; c=relaxed/simple;
	bh=1mHaFtM2LMEKH9W0OjPOy/ovE4mnUoO/9wQfrj54upo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8nNrzyKndbVMJ3XnfX1K1wgRjsAXvAJ5d0cUpxVemreiRVNDi+m+K9Yoe8pe8M4Kb77oShfudjQm+5EqnGvG+l3ffB0exyLMnP2iCnSYd1qBUaqpQvxnC4vHPfzrTVlU7UeB7im4TfQRCu5didfwHPj7heMl6ZXFplWRovjLFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMVzLLq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA72DC4CECD;
	Fri,  1 Nov 2024 17:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730482173;
	bh=1mHaFtM2LMEKH9W0OjPOy/ovE4mnUoO/9wQfrj54upo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gMVzLLq+X+h+Tx1VGB0GTmAwuanvippLgvx6g8+e1JIezuowN+1rlAfBX4vLHPoWQ
	 EroCE10P0ofg/0812y36oFsu3lVmS52yXz2GEjFsnKwaFH8OuH9rQIe0PvU5yUcqVg
	 Ks7+Ai6szMmjj4c3m9EFR+coAxB7uFve0WwhrYkotVsUjG0z2lQrEIqSGzAptWJ6/1
	 SAAsxCeahMqpE3T2NPlfRwBH0MQKY6g9j9mu2p+B+MQy2DHUPGADLljdbiLLYKcmg4
	 DUJ+U0c5Dpo+FD/bqSQSqpEgioCovjBNWcslskikcSvmwQntK5sj93FH8uVwhZg+Tb
	 cFMO6WMACwqHA==
Date: Fri, 1 Nov 2024 17:29:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: liambeguin@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, xiaopeitux@foxmail.com
Subject: Re: [PATCH] iio: test : check null return of kunit_kmalloc in
 iio_rescale_test_scale
Message-ID: <20241101172926.4e8e3f43@jic23-huawei>
In-Reply-To: <ecd56a85e54a96c2f0313c114075a21a76071ea2.1730259869.git.xiaopei01@kylinos.cn>
References: <ecd56a85e54a96c2f0313c114075a21a76071ea2.1730259869.git.xiaopei01@kylinos.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 11:48:54 +0800
Pei Xiao <xiaopei01@kylinos.cn> wrote:

> kunit_kmalloc may fail, return value might be NULL and will cause
> NULL pointer dereference.Add KUNIT_ASSERT_NOT_ERR_OR_NULL fix it.
Can it be an error?  If not why not use KUNIT_ASSERT_NOT_NULL?
> 
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> Fixes: 8e74a48d17d5 ("iio: test: add basic tests for the iio-rescale driver")
> ---
>  drivers/iio/test/iio-test-rescale.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/test/iio-test-rescale.c b/drivers/iio/test/iio-test-rescale.c
> index 31ee55a6faed..11bfff6636a3 100644
> --- a/drivers/iio/test/iio-test-rescale.c
> +++ b/drivers/iio/test/iio-test-rescale.c
> @@ -652,6 +652,8 @@ static void iio_rescale_test_scale(struct kunit *test)
>  	int rel_ppm;
>  	int ret;
>  
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buff);
> +
>  	rescale.numerator = t->numerator;
>  	rescale.denominator = t->denominator;
>  	rescale.offset = t->offset;
> @@ -681,6 +683,8 @@ static void iio_rescale_test_offset(struct kunit *test)
>  	int values[2];
>  	int ret;
>  
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buff_off);
> +
>  	rescale.numerator = t->numerator;
>  	rescale.denominator = t->denominator;
>  	rescale.offset = t->offset;


