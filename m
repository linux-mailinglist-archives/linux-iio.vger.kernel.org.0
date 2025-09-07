Return-Path: <linux-iio+bounces-23840-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A73FB47A60
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 12:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31F6189C087
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 10:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC2123ABB3;
	Sun,  7 Sep 2025 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4X5dUHQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF4821CC6A;
	Sun,  7 Sep 2025 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757239620; cv=none; b=PdLwEXJnZAQgYhtwlRWTUhWktxQbNd+JxV2PDlK7chUnnoS0wnUY4btFuFmtha8/fvjeMCXX07Z2tWSbTMJdDkpIQp3vmAVyMf6WCYjDU+z4Prw8Sp4sNZ4Rag+kMOsXXm6sVMqhYvp+nKcms/Cp9gtd+Hc8EctF4bzkN5Q2A30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757239620; c=relaxed/simple;
	bh=XUnf+qNwwLUICs5Io8Z3H1H0zXXbN6HpvHxAbpOmR88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzHkg5VP7r3a2INys9mMmhXib60aDgR1eDFVg4sKaCeujLDT3TIWOvKU/cw1T5VfvhUpc92sKvOlS5Q+DUbPfqDpVNAEpBTihLcUtd2HR/aXHKZ9e87mguAdg8zKwJHVNU524xAua6miV9iuMk6QuzSzEg4rSmnuuTzako4yFEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4X5dUHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770CDC4CEF0;
	Sun,  7 Sep 2025 10:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757239620;
	bh=XUnf+qNwwLUICs5Io8Z3H1H0zXXbN6HpvHxAbpOmR88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V4X5dUHQcM4Wv2/A8xF7i5/Coz1cVx8FFvKqJlj5ST/xTPQe2vExGXUMvN6WB2cVa
	 iX3G60g5e33sJ/G6c12jYpvgCs9i3eKIvxOOvrs1s/zbf2jdSlpO6j7vR9TN3Ni9Sk
	 Qa95vayGCIs90GtNCHb7xCs2+anu7Qe6mtr8KqTgxyhSRZ2XdDTqnP333Yv+bc7OtQ
	 0dBP3FeDuF1wuKAsB6oaESZaeSCGIs+5IoY9uVg1clnA1JW1zPVcyjtcpRRnqDfsj6
	 nInWP9DjOBtbdXf+k/grtM4mNEkLS2r6A8ws14WGTG0sJZdHIQ/RYvS+31/azpKkA/
	 en6FKMXrVnA9g==
Date: Sun, 7 Sep 2025 11:06:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: adc: ad7124: use guard(mutex) to simplify
 return paths
Message-ID: <20250907110652.295b296b@jic23-huawei>
In-Reply-To: <20250905-iio-adc-ad7124-add-filter-support-v1-3-aee3834be6a9@baylibre.com>
References: <20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com>
	<20250905-iio-adc-ad7124-add-filter-support-v1-3-aee3834be6a9@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 05 Sep 2025 13:11:58 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use guard(mutex) in a couple of functions to allow direct returns. This
> simplifies the code a bit and will make later changes easier.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Another nice improvement that stands on it's own.

Applied.

