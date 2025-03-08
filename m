Return-Path: <linux-iio+bounces-16548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF69A57A83
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 14:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F3B1890EAF
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 13:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D3E1C701F;
	Sat,  8 Mar 2025 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bovy6NMX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67441B87D7;
	Sat,  8 Mar 2025 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741440838; cv=none; b=UNk4LYd6FLoCK0pPhHUHm3hRdORS7SpOdsg7JOdcf9HTWeLl6j/6YKLIG1PGI9iOB/PyIc1C59ilqVHaWzAd+NujWIWGoW0kwOhaMo/bubxrFuQztaP0rdXsbrCBVSg87f3TTy7YHiqHpY4Uz2xiMmZziiT8R74pieVks3wO7Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741440838; c=relaxed/simple;
	bh=HeYm3/t6U/TxiBbqUq5YiUiybfnvy0dnybaj4ECl29E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwfgUR40NDZ4s3WyMY/lm7Cg54ZmqdF7aBC4D7Dr4Qb6OKdwHEAg0OY5D7sRN/a1q8iuQDM5yMfSCmLuohshuZDIt04FWFJI6IsDiQhidLFUkiEfrBoEEKwdPnYuA5WJwLSXGnfu2Kn9QF18nFj+TQyRUBNWaX1I2AaoUhHjinY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bovy6NMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19CDC4CEE0;
	Sat,  8 Mar 2025 13:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741440838;
	bh=HeYm3/t6U/TxiBbqUq5YiUiybfnvy0dnybaj4ECl29E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bovy6NMXpZw6+tnjtb/fZ5GN8u7RYMRrWgn16lhWRTUxei0v2C2UdrxpL6TG018GH
	 Ys9s/Z4LUz68VzBXw0kUG7iu6JDJKyZ3haw74FBAgo0Cn8OW69kBSSfqqToxT+w3Zd
	 hicTNirMGFuYiMC3RKQVpt2Y2QRp7ybdJRR46Rh5+DRPlTHfXCKvnfQONsGjPZPDI/
	 OmPg3NYrHrsoXlzZo+nk3jikHnr4k0zQZvYpfDPvv3rPzwpsQ2Ip2uJBWmoUXly9t+
	 Avfz9rqcNn1X7ixIojh7rL9+yDYEZPel62MfuK+LhU6bYLDj77qfUc/rYDSYkItlyc
	 W0uqzThezYGag==
Date: Sat, 8 Mar 2025 13:33:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>, Sergiu
 Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <dlechner@baylibre.com>,
 <marcelo.schmitt1@gmail.com>, <jonath4nns@gmail.com>
Subject: Re: [PATCH v4 10/17] iio: adc: ad7768-1: Move buffer allocation to
 a separate function
Message-ID: <20250308133335.68b49c6f@jic23-huawei>
In-Reply-To: <d078cdcf3a8bdd60ec3b9b6822e9705bf3f98bfa.1741268122.git.Jonathan.Santos@analog.com>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
	<d078cdcf3a8bdd60ec3b9b6822e9705bf3f98bfa.1741268122.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 18:02:46 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> This change moves the buffer allocation in a separate function, making
> space for adding another type of iio buffer if needed.

Moving the trigger allocation etc as well.  I'd mention that.
Otherwise this looks fine.

> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>

