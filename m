Return-Path: <linux-iio+bounces-14223-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18104A0AA6A
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06C93A5F0B
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 15:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AF51BBBD7;
	Sun, 12 Jan 2025 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJc1tp/2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9811B6CE9;
	Sun, 12 Jan 2025 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736695535; cv=none; b=oWP9OhXgfUQWbdN7b6wPog/nG04zguHXUGCHWfHRoR0nSJWEP5gsjOuEtCr2PvG0oDO6XLZdd8DR1Tk2ighAU++wDfloVXNsAlGSBV72gBbdS5L66olG3FCPZT2f7fWpMuAYWU3PwCgigNtMxB9yvSm8YIuTzGOhBKJY6CS3TSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736695535; c=relaxed/simple;
	bh=FTIshkSffSbfK2aLQfCvK2bhIkLqC1FqaQ9nqqc1DqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4A38ZxUdhZW4GjKc42k2/j8+szROBB9FFiS24tm5sx+8dG99JZ5v6QFuE9T/gK9ZZwI5OteMqYCg/Ym9bUyIZInSVZvAkVh5zJqRVbH7OIJ/vIA+NJ7p1n0YtbmeWLcp2TVjr5DYe54sz4M83REphhbpLBvr2YWj0qhQ2hUbPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJc1tp/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB74C4CEDF;
	Sun, 12 Jan 2025 15:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736695534;
	bh=FTIshkSffSbfK2aLQfCvK2bhIkLqC1FqaQ9nqqc1DqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HJc1tp/2eqp4i5BuWX6sbTRxIO2KrwiK+dSqSIQ0lzd/6oy920A1CpOP0c5+7nKIc
	 J5gtZBAukHqPOdmTMvdJcM6EYgr1aCr1gdKbThe432mcJbRXFBkFXJps/w6A0DN/19
	 raQogwNf4yFAW8Ru0vQMAw9Grwl95lk5jhiU4rm1dsUimiijAbuRsn5DHzl7MM1pgf
	 J0Dutbxh2lfle6n2mTY+QGppsx7+pYQ5qkTXody3e6oev6MBOioXn9peEvwi40ih34
	 YJK8o/u4RqeIXEUF2vIBzxUQqxMA7XttqTr4O7IIxejzxzgIKsRZ75jkWn/9qiXwf8
	 VkuC0T1yN1meg==
Date: Sun, 12 Jan 2025 15:25:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Ranquet <granquet@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/2] iio: adc: ad7173: add openwire detection
 support for single conversions
Message-ID: <20250112152526.135e2df2@jic23-huawei>
In-Reply-To: <20250109-ad4111_openwire-v2-2-0372c2dde0ce@baylibre.com>
References: <20250109-ad4111_openwire-v2-0-0372c2dde0ce@baylibre.com>
	<20250109-ad4111_openwire-v2-2-0372c2dde0ce@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> @@ -616,6 +625,69 @@ static int ad7173_calibrate_all(struct ad7173_state *st, struct iio_dev *indio_d
>  	return 0;
>  }
>  
> +/* Associative array of channel pairs for openwire detection

/*
 * Associative ...

Same for all other multiline comments.


