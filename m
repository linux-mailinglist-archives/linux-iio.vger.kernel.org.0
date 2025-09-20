Return-Path: <linux-iio+bounces-24320-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A31B8C6EF
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 13:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E3B7C8342
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 11:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE262FC88A;
	Sat, 20 Sep 2025 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjSk6N/P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DC81FC104;
	Sat, 20 Sep 2025 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758368575; cv=none; b=ZOovzokHVT9g/CLYMGvLgpqyW6RAAUD0e69agVvRKuetCHcEDKxO9g+xwXdonxDcQqZuWfFtEPxgmY//Zjc8sDv69NRue4yLNKWPsHUjClm1u5zMvtRsE7fwsr2OlW2j/2Mx2WG8M886xFwFVvsaOzKzxxpnaECxPallV+6fQpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758368575; c=relaxed/simple;
	bh=pheYgxbGuW3hPbYr9qKgTN42vcHYbrDzK7Zbs3DzBz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jbjn6+BCvRfn5lxSWNRylndb3Qq/xCfhcEME5VLyBTgtAdESz44of3yvficA3crv4tQcT6cqAc2dh8Moon1b9pGadPrBfjZyQmRkgbWH7UVcUfhm5mnwLNJrkemDrYMSEwpDEiOYV9CMsHTGEvibaYNlzzd8MxOrnQQQXMrHp94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjSk6N/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A69C4CEEB;
	Sat, 20 Sep 2025 11:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758368573;
	bh=pheYgxbGuW3hPbYr9qKgTN42vcHYbrDzK7Zbs3DzBz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LjSk6N/Pxq2V5RnISBNcJm1DZcNtbPeTkDkseIF3QVgEOgBdErT8wwXsHXcBLoyeK
	 lFEJTt1x9hk+stZIMLs4l0c1DJYJ1975cmUwFBcvMt8IKCA3ez9MBIYtq6mYy5sxXA
	 24MLdJG4agqo+AK3S18uYhCbLcOxpf9AjRCe415OBmHsQrw7Jjcr9L0K/soJd/UZkC
	 zqYoyy8wJViw4NNry52ltrp0k7MfAibJOMyFQ0fDLFfKYpesNerPf4qikEdkBo6KCf
	 P8TEZe3g+pjfWyo0bQMqAYHbmV04baKhBy21RCPbsD+MwAQaQRX2RA97nrlhUfFKdY
	 eXIP0QhiFNRQw==
Date: Sat, 20 Sep 2025 12:42:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <victor.duicu@microchip.com>
Cc: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: Re: [PATCH v5 0/2] add support for MCP998X
Message-ID: <20250920124244.1c263df0@jic23-huawei>
In-Reply-To: <20250918111937.5150-1-victor.duicu@microchip.com>
References: <20250918111937.5150-1-victor.duicu@microchip.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 14:19:35 +0300
<victor.duicu@microchip.com> wrote:

> From: Victor Duicu <victor.duicu@microchip.com>
> 
> Add support for Microchip MCP998X/33 and MCP998XD/33D Multichannel Automotive Temperature Monitor Family.
> 
> The chips in the family have different numbers of external channels, ranging from 1 (MCP9982) to 4 channels (MCP9985).
> Reading diodes in anti-parallel connection is supported by MCP9984/85/33 and MCP9984D/85D/33D.
> Dedicated hardware shutdown circuitry is present only in MCP998XD and MCP9933D.
> 
> Current version of driver does not support interrupts, events and data buffering.

Similar to the emc1812, this probably wants a short statement of why IIO rather than hwmon.
Given it is called out as an automotive sensor I'm more confident this one is suitable
for IIO, but still good to state that in the cover letter.


