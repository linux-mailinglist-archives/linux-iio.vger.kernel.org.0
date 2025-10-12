Return-Path: <linux-iio+bounces-24961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBEFBD045A
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 16:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496F9189626F
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 14:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F3428D8E8;
	Sun, 12 Oct 2025 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dz2C0dIr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6038927380A;
	Sun, 12 Oct 2025 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760280861; cv=none; b=nhy9NvL58HFw9HASZgMjwfFQcRGozHCdLx2AGIp25FUlXfIetOH6J2ox1rtvEunsoUa0xAutYenlVZy9a7i40qbJVL+AqIHfSKZsErDB+iB3rCbfCkpQJnLCsZiucj0guafxU2Na4VC6k2EH2jdivkc574bdbeIOUJPvX1rG6+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760280861; c=relaxed/simple;
	bh=LKOKDuwVG2h4y76Ee49aIveWeG0pyO6gvjKiP6xWeHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUwH7BKzkBkDDoFC1uLIJR907dj1oQ/K9TDSGWbC3LtMBMIS3XthAYKZ/BhkQQBgSJL3kfM17DMQuC+5BZATcWo9ipfugFcLnJ93sfTrVxHCmeQ3gApr54egxS+BpvMfkzPuvEc3i/MAXayLpGm7jjesc0fIk9mtoXlVL5HRwjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dz2C0dIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A53C4CEE7;
	Sun, 12 Oct 2025 14:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760280861;
	bh=LKOKDuwVG2h4y76Ee49aIveWeG0pyO6gvjKiP6xWeHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dz2C0dIrSB5Gm8MzY5/PgPFSzZ/vezht3icDan/GxsVUTA6B+ommFpfZR0ho0f54d
	 TAMBEeMwe98levgnLbGbHmpIZFs9AFw4hHekSuwpmy1vOLoP274uWo8+ys6mVC1p8y
	 /mf3XQHe8ltW7GzzqzDhpSIsSKU49n0UdGyMO6tjlwCTcNEcf0ZBlPNfDfXQXTBMJv
	 Tjcb5w3lrwXX/wRPcI1OVjHHY1EPhghpo8iYnqL/d7gEyQ2qVToZ6cyn95M5bQ4nsu
	 9DTgfpq71oda93pynZWZkYfFNwg0kOxXeTNQ82gm4CpoP9bIu5K3J2LBfEvQxJfzaO
	 5qqFmW6KUQtNA==
Date: Sun, 12 Oct 2025 15:54:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/19] iio: accel: bma220: add open firmware table
Message-ID: <20251012155412.6d70af61@jic23-huawei>
In-Reply-To: <20251005-b4-bma220_improvements-v4-8-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
	<20251005-b4-bma220_improvements-v4-8-0f449ba31585@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Oct 2025 16:12:17 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Add open firmware entry to the spi driver.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
Applied. Thanks!

