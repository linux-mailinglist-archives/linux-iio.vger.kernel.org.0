Return-Path: <linux-iio+bounces-27592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E59CD0EC2F
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 12:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55D5D3015A86
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 11:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BCB33AD8D;
	Sun, 11 Jan 2026 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XY6jqKfQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685C633984D;
	Sun, 11 Jan 2026 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768132682; cv=none; b=ipARAHpXXmkX72fsNyJB1PsaoXXQwwZK+EK7KHfWiPTOElnUKPr54s05YKIv9KAAhZ23/fcJdEOA2ldCw/WLDY72vOtrBuXGuEfd3l37B+aNODaDgIExXFiLu8M7jFFznl8XUeEYGxv3MZikyL/f24Eh7N7mB1pYufIHpeRCaoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768132682; c=relaxed/simple;
	bh=E2NMgVvln16lOoF3BfhbRAY3DUGq/OulfaKkTjoxB2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HbSy/bsBYmF4hK9Qr+x+FvTL32l31H6PEQo+DtPXCo/rRpO7+KvIGu+1h637H9Sf0tEkq8MVMQeDtI6kIX3YdN/PlHsSzCwEnMXx+7qs5F45sQZxwMPuP3MbmsaXNCzvEdpmSV20nKqPM8qq57Gehc7KbPCvz8yoi8c26md9vLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XY6jqKfQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B043C19423;
	Sun, 11 Jan 2026 11:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768132682;
	bh=E2NMgVvln16lOoF3BfhbRAY3DUGq/OulfaKkTjoxB2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XY6jqKfQsjWYPZa38ZPB33NlU2ScDi/PCttT4lh4GtWssvbbdJ6Pg2WJbraC5ZNbS
	 TqKbUybV8ewvcNjf1JV6a4gsMa/2v2c5Jsk9yIpyU98Le6RiIv+hEo818fdnSbx2s1
	 F7w3vMXGxPQENcpw08i+tKnw2q9n6iPGHSlf5UO45Pu/jY8hg6cXGCR4Kr7SHMLgMu
	 9hvQcQHvpOQdUMoL77SChPgQFSz1vmxYdpfSGyph/fTp+tPaI9roBf+TfVCVe5rJF1
	 GPES1x1tYtBTxbK0Y1hMlOv7TApN6ui6iYhjfNGXXs0s9RTpJgbbffcX97WEKh54md
	 GnJ7ZRX4tN18g==
Date: Sun, 11 Jan 2026 11:57:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Sean Anderson
 <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 0/9] spi: add multi-lane support
Message-ID: <20260111115751.7269c7b0@jic23-huawei>
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Dec 2025 15:32:08 -0600
David Lechner <dlechner@baylibre.com> wrote:

> This series is adding support for SPI controllers and peripherals that
> have multiple SPI data lanes (data lanes being independent sets of
> SDI/SDO lines, each with their own serializer/deserializer).
> 
This seems to be in a pretty good state now, so I'm guessing v5 will merge.
So with that in mind, add something to cover letter of v5 saying how you
think that is best done.  I'm thinking probably Mark does an immutable branch
with 1-7 and I merge that + 8 and 9 via IIO.

Thanks,

Jonathan

