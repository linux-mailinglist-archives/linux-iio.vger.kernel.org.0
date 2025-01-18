Return-Path: <linux-iio+bounces-14469-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB1CA15E44
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 18:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23433A7E8E
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 17:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C001619F489;
	Sat, 18 Jan 2025 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFZWVu2a"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C26D42070;
	Sat, 18 Jan 2025 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737220366; cv=none; b=AMIfXw9FdemWPjd5oni9MQjMnAeFKtaFMZyR8S72kx9iESqHepM+gqW79A5nXsxUrTXRfmEhxIm5Mo5q9geXnVC48eR+G4YNqlPje9HNtvjtRmEN7MdXzp7aQyUUCObtE0ZwlftbSDLQwfalYdBThDqh/4FbV/4MN0cGhlV3/lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737220366; c=relaxed/simple;
	bh=J+P5FAdYBflhbeDYweCfbuaTX5OX8oK17mwElCdYiqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZc+G96TWGDOgnkzHXJyBzyHvqyrypKeQ19PgnXSIIG9RXrhu0oafgrA/kwGnLjlZ4AgL/Um1t1coerfvz2sPMzTpED0GzzZOqGt/Gx1gQX4r13VpxwClqG16MG8D0HZa5Im5z2gjzXSwh0OBjdNHvqZYTjtKthzD1IjiHA2oG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFZWVu2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAAFC4CED1;
	Sat, 18 Jan 2025 17:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737220364;
	bh=J+P5FAdYBflhbeDYweCfbuaTX5OX8oK17mwElCdYiqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dFZWVu2aquSs+5zgswbBNCQ9YbCcu4ZfitFvVfFSZmurwkCr+GPADY8VoYLt+L2RM
	 eI4UOPenwIfqUxMogsF0s17ZwqIPENp3tT6A1aYplChli4Av4u3egIcn+aWIa1aEjY
	 qwmNWT09fP1UkINcx/OBIZXQjjeRCgdt7mmUrc/s8Qn+mu4iMXEQ8W4RCH3e4c/tGr
	 SJXV7PMpKNBm/A1vvUAJkE3rZDS5vBNVCZlqnpO8kvmUkInIEwf1DBJQmrjCsTIGYa
	 CA17S8LWK7PIZHKgqz2sZi4Bctn7GGu8Oux3IAXTDzRtcQn85G7skDJ1SsplRy+EB/
	 1a8YR4qdWklTQ==
Date: Sat, 18 Jan 2025 17:12:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: ad4695: make
 ad4695_exit_conversion_mode() more robust
Message-ID: <20250118171236.782bcb0b@jic23-huawei>
In-Reply-To: <20241113-tgamblin-ad4695_improvements-v2-2-b6bb7c758fc4@baylibre.com>
References: <20241113-tgamblin-ad4695_improvements-v2-0-b6bb7c758fc4@baylibre.com>
	<20241113-tgamblin-ad4695_improvements-v2-2-b6bb7c758fc4@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 15:52:59 -0500
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> Ensure that conversion mode is successfully exited when the command is
> issued by adding an extra transfer beforehand, matching the minimum CNV
> high and low times from the AD4695 datasheet. The AD4695 has a quirk
> where the exit command only works during a conversion, so guarantee this
> happens by triggering a conversion in ad4695_exit_conversion_mode().
> Then make this even more robust by ensuring that the exit command is run
> at AD4695_REG_ACCESS_SCLK_HZ rather than the bus maximum.
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Applied 2 and 3 to the testing branch of iio.git.
I'll be rebasing that on rc1 once available.

Thanks,

Jonathan

