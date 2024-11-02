Return-Path: <linux-iio+bounces-11847-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 448C09BA130
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 16:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A031F214CD
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 15:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FA11A071C;
	Sat,  2 Nov 2024 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0BqIcXx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA39185936;
	Sat,  2 Nov 2024 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730561169; cv=none; b=S/IRUUMYQGRH2fgXs1MsdNwoy4NnmHkFQEAYoBia4tzqg8qv4Jf7GzVVtG3/XEkI5yCJrgrGwB/T9h6vynJVmKdHMH2w/UTIQ1OBGSI8olocGXGQSXURWTIVQljeiy7CtXDrV1RQVsJuIHwvGX7u3u+GtgNTdQA9omfrJUpzdAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730561169; c=relaxed/simple;
	bh=oMP50D/czsxB5H6q2e4mnnk6HHyg5lTI6jMQVU7Pl/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLczFxv+/68fGm1ZxAb4g+1sTu9xq+w9kGfT3wFyptMI71gD/8x31AbWqU0TGo81DDz8TNDQfaxvk2smwAAqVQjN6QvCSFynHoQXtjiwm+q9rS4j4Hu+Gb8+KAsD6piZ3riN30uWgntP4lPW9KoUiS9ndWkA2OY9Z7gqpZzFRk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0BqIcXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B75C4CEC3;
	Sat,  2 Nov 2024 15:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730561168;
	bh=oMP50D/czsxB5H6q2e4mnnk6HHyg5lTI6jMQVU7Pl/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R0BqIcXxJ6uewWADhz4E42uiJeu/YXW3yc4NsGO5L+iWtHZDz9wgug2joB38wuDjQ
	 SzgsjPnhgCmMMwMdvHCOeZcYTXJgNmW660xrEuZWWz1AXNzA1ktkU+qA+U4spioDtg
	 sz/JS/ynAfmu5vLPBe+iFPzBs810Bh2Zi/szzkOs0rug5bw+Ewd9w39H35DJvE6Mnw
	 qVpQ38hCzzsrXVQPGeWc7pMIptddBB9+sJfHslwvT4uQzNuFGeikC1wrbhjRdp78fj
	 DaxewEC1HhcmGgsaGdPTlwXSIAkzeqMomvIbm5uJm8Yv36Fz0CZGjgjMSv+oALl3m1
	 hFmlOrDwW50Xg==
Date: Sat, 2 Nov 2024 15:26:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 anshulusr@gmail.com, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] iio: chemical: bme680: Add support for preheat
 current
Message-ID: <20241102152600.76561c66@jic23-huawei>
In-Reply-To: <20241102131311.36210-5-vassilisamir@gmail.com>
References: <20241102131311.36210-1-vassilisamir@gmail.com>
	<20241102131311.36210-5-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  2 Nov 2024 14:13:08 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Add functionality to inject a specified amount of current to the heating
> plate before the start of the gas measurement to allow the sensor to reach
> faster to the requested temperature.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied.

Thanks,

Jonathan

