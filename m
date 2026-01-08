Return-Path: <linux-iio+bounces-27566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4D1D06627
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 22:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A07630245CA
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 21:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4EB33D502;
	Thu,  8 Jan 2026 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ruw/nLK9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F64C3033D5;
	Thu,  8 Jan 2026 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767909339; cv=none; b=LdI5F87jZi6Tnb8Hp7FOLSBNPuBVRIjlPDDhjNSzjHeiuNTl8p2o7laNcpYtGYRENBjH9w/IKBuJyAHwzxqJU0Q6SY+6t8BlmWTSrgPLJtCYjr+G9Fquc8sxsAF44KGAqrojsuOelrp4JFxz/94gzMunEOWmNVdMpPSaklOZuHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767909339; c=relaxed/simple;
	bh=yjj82v5sRbJNwVC6AkA+34yHNpIIioN5X3dWe8ePxbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S58/8tl8pDNfVFT3L0vCK+hrCci7a7CrPldhGrFVK6OcTGBpiJO/I872l/ZVGWEmd1dyxy4JrAyRGZJluyoUFALY9KQhs3HfDpNNnfS4Bcjrxo4KUG6Ws9L2/QLDihU20qMUeBkbx1hhbGmPeWEoETYgUVUhx0EhW12hDq7mnnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ruw/nLK9; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dnJcP4pR1z9vPL;
	Thu,  8 Jan 2026 22:55:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1767909333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYd2mPS7kO0TstKx0YIVrWRhdl/f3lZ0rtrivioDsHw=;
	b=ruw/nLK93aOBRe3kfFy7uDpazjuFSkuxqbRnkHQxafsqWwEhk2+BXMsmqaV32M2cq3mJ9W
	XAtaI8UIkA6IveAAD0ZJDuIgYG/GM8nMyMEJZc+aVdKZceg43f4gq4gx56kC8C4nkL+Kwv
	ZIJqyjFcqtaEwYTtZyQjeps0yEC9qND6TQAifsO7bPzFqzNc9gbG7kROXfip0Ag7BLi89c
	dmUbnwzpvYH5wTcO270VwIbIAfEK0GHtKuS2fs56w/4Iak8Aar+1Hrh+VDkhL0qHD5OeMn
	Vt/KTYSxpgkwqQuI0p3zK46d0MQmY7N/CLF5bsd1kLA75oikNiHTXq5h78IpJg==
Message-ID: <7d327efe-94ce-458a-9394-eb5582f1c263@mailbox.org>
Date: Thu, 8 Jan 2026 22:55:30 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if no
 IRQ connected
To: Hans de Goede <hansg@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Linus Walleij <linusw@kernel.org>
Cc: linux-iio@vger.kernel.org, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>, Peter Zijlstra
 <peterz@infradead.org>, Salvatore Bonaccorso <carnil@debian.org>,
 linux-kernel@vger.kernel.org
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
 <79946c40-e2ce-4fbc-a6b2-b37f6fd69d1d@kernel.org>
 <20250621181733.3cb6111e@jic23-huawei>
 <07d91b36-dbeb-42b3-8dd7-b0771df9b306@mailbox.org>
 <c42243fd-ffd2-4144-875e-b156133eb031@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <c42243fd-ffd2-4144-875e-b156133eb031@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 3bfa46ab7d610b32c46
X-MBO-RS-META: zzgq6xcx6psk73p5ew1ck6ida9phrbuj

On 6/21/25 10:14 PM, Hans de Goede wrote:

Hello Hans,

> IIO has separate interfaces for exporting channels which can be polled by
> userspace and for triggers which is a more event driven interface.
> 
> It should be possible to modify the driver to skip the trigger registration,
> while keeping the channels. E.g. iio-sensor-proxy will then automaticallt
> switch to polling in userspace.
I wonder if this got fixed by this commit in the meantime:

3aa385a9c75c ("iio: accel: bmc150: Fix irq assumption regression")

