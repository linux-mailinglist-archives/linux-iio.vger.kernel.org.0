Return-Path: <linux-iio+bounces-22752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B63CB27C26
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 11:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695221D02B75
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 09:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B432D12F7;
	Fri, 15 Aug 2025 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WItTfaBX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F08D2580F9;
	Fri, 15 Aug 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248245; cv=none; b=FxqR6sBvQUkKz2YPry7L8sEJUvp1Evl/eBD/hpu7lWNRFdGyIRT+n+aJhWn1Ysl8HHzYFSHBaydMP9Lz5g6yIgfzNw6hvPnczaXJ7R9wQdxyi7VWN2eFIrlJSURaILPfafLEi9Sikj+GguLiBMSAG0zwDS3pjOKCLSm2RtYrOdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248245; c=relaxed/simple;
	bh=9RYxds3zJQWcjwycHLlBlySBzfhuk3S8e/I6hEp1HyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoieHyep/OGzMuXwmplSwetqpsndhcm3sl8PlL7vPrkgPnNa6puWPuJ9l7shVjoyyq8cZLbuuPFw6EPgvFZgp/wOntGE9/VvTPee9MQYdHfmj/vJ2vuTWcL7/1nVHUbf4v4JGbmbaTWgR198akFGdm9/Y4VcUoRjK0mHtefPv+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WItTfaBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D80C4CEEB;
	Fri, 15 Aug 2025 08:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755248244;
	bh=9RYxds3zJQWcjwycHLlBlySBzfhuk3S8e/I6hEp1HyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WItTfaBXK/HwD9zkX1U8kmfMrgFXj3FRArMaBeNQkHQZ6MyGONH/EpRX2+wvii5Ky
	 pIga9TkqXpO7rDZn0/nT6mT+YNgN3p15VXP0HsTVJBTsVYxdmMAD1Fi0TJkAkDz6GL
	 68bNJbFhw5CAirIYEr10uTgbGe8qKMCzIAwzYzLDr2YayxbofmEdeTcwLuC0ocw3yb
	 XL8HjrLkSSUNuQWXBBMaEh45jxTF2tau/3lzTCipwF26606qppVZGqdtOooc3L6drz
	 2oUKv7pj0COzwVaUdGg/ivtUQ8Dd0a0ryntDjWQxiXkFh/agm5iVJQ0SzoGdyNqWwV
	 wEKcQm+it79Lw==
Date: Fri, 15 Aug 2025 10:57:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: adc: ltc2497: add lltc,ltc2495
 bindings
Message-ID: <20250815-fanatic-benevolent-whippet-ce6f19@kuoka>
References: <20250814-ltc2495-v3-0-c2a6cecd6b99@gmail.com>
 <20250814-ltc2495-v3-1-c2a6cecd6b99@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250814-ltc2495-v3-1-c2a6cecd6b99@gmail.com>

On Thu, Aug 14, 2025 at 01:00:17PM +0200, Yusuf Alper Bilgin wrote:
> Update the binding documentation for LTC2497 to include LTC2495 to
> enable support for its internal temperature sensor, which requires a
> different I2C command format and a new IIO channel.

Your patch #2 says they are compatible, so either this patch is wrong
(and you are supposed to use fallbacks) or patch #2 is wrong/incomplete.

Best regards,
Krzysztof


