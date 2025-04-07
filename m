Return-Path: <linux-iio+bounces-17781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ED2A7EC4C
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 21:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475C5447BF8
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 19:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5EC1FC7D2;
	Mon,  7 Apr 2025 18:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFaHYDu3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5DF2550D6;
	Mon,  7 Apr 2025 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051243; cv=none; b=rfiEPx+HowIzKxJhSOCB8UJkSsrbmA3o9OaWlefAiaQIQtYmVJ2SeP2oNgrisF89AYHk9u4l2wIb7hEHDHRpF+UvRvVI9X55gUquHxUg1ST2w0egNtmQhfsrerPtSrXl9wWo6WBof8yk3BAd/aNuNTsgnWbOWmoj/EfCziNYtI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051243; c=relaxed/simple;
	bh=yrAXHErqb6ACtl3GEjEsf5n4rRGKN9FywKDVn6D9Wb4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3gGlLdrggiDkt6OBd35+StnlzuIPL4KzI1YMoR/+pfhwQfVKtRIlLBn/dJosQEwsmWgYEXOWwmznGvGmwzXb3OFcEXwSXl0uhNqE135ZOkAjfd+di0B5fLM0CtA45OZfMMGnh9zKGysFsrHgUCxIWmZ1nhpam4p9zrJWgA5t5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFaHYDu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BC5C4CEE9;
	Mon,  7 Apr 2025 18:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744051243;
	bh=yrAXHErqb6ACtl3GEjEsf5n4rRGKN9FywKDVn6D9Wb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TFaHYDu3545gtGxDWNy0onwV+OVOahmzSHMZmRihKvOd2R+YZyYvQunputO1WJt6k
	 UUqVufwniTpNc+J42ePhQp5T6i8xiiHi2SaI5NY8P8xRemlCcoX0YWrG6OtEsLPXC1
	 dkYY7UsUsFULwiFOuuUYBOdiCeQMnxTODtbxwWRzLdHs0QBiPwPic1QN04bU2gxFc+
	 etHErn5K55zsR6cerUQBp6p+wT1p30mIBpTGCRMcmKNyc2ZwiahBNZQfIpAzWbzSND
	 l2q8vHLQna0h0Nc6Py/iVXKLR5DmQvwC3K/z+0bkjV3uGktAlYuCD4PtLuLM49ZC4D
	 0T7M7mAuqPLww==
Date: Mon, 7 Apr 2025 19:40:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <gastmaier@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Jorge Marques
 <jorge.marques@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: ABI: add oversampling frequency in
 sysfs-bus-iio
Message-ID: <20250407194035.6c7802a1@jic23-huawei>
In-Reply-To: <c53je4hfe76lergtxq2fhoouuer5upla34jd2sq5sdg3kw3rsk@6pjgmuevotnc>
References: <20250321-abi-oversampling-events-frequency-v1-0-794c1ab2f079@analog.com>
	<20250321-abi-oversampling-events-frequency-v1-2-794c1ab2f079@analog.com>
	<20250330181320.0ec4351c@jic23-huawei>
	<3ad6f137-5f67-4448-b0c9-2e760bd935a7@baylibre.com>
	<20250330185353.150fc33a@jic23-huawei>
	<hf5dwxs62oof3gom43c6rkdsq3gky6eplxej627t46ktt5blfr@kpmjpxku4inc>
	<20e8538f-7a73-42a5-87b1-0c04b54375c6@baylibre.com>
	<pzqfq3w3phov244vnuxpl3t3bololdb3uqyx25ekvg3wzvbco3@jrokyjyc57fl>
	<20250406112551.62dab974@jic23-huawei>
	<c53je4hfe76lergtxq2fhoouuer5upla34jd2sq5sdg3kw3rsk@6pjgmuevotnc>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> 
> All things considered, I believe the appropriate ABI documentation is the following
> 
> 
>   What:                /sys/bus/iio/devices/iio:deviceX/oversampling_frequency
>   KernelVersion:       6.15
>   Contact:     linux-iio@vger.kernel.org
>   Description:
>            Some devices have internal clocks for oversampling.
>            Sets the resulting frequency to trigger a conversion used by the
>            oversampling filter.
>            If the device has a fixed internal clock or is computed based on
>            the sampling frequency parameter, the parameter is read only.
> 
> If that's ok I'll resubmit the patch including only this commit,
> and then focus on submitting AD4052 driver V2 series.

Looks good to me with one addition.  Mention the units (Hz)

Jonathan

> 
> Jorge


