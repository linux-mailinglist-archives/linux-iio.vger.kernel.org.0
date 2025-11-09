Return-Path: <linux-iio+bounces-26080-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48295C441AD
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 16:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DF834E4438
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 15:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57ED22FF679;
	Sun,  9 Nov 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4ASnQ/H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137F613B7A3;
	Sun,  9 Nov 2025 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762703886; cv=none; b=ucrb90qSHXP/s/Z8vd8Ca/9QCPMJFslIK+M4zFD9x2zv2F5vQKmp4i2FwW8uTDxasNl8LZWTZDx++7AZyS99x9rpxGeL1pxH7qg+WHSajz+cIehOWUpCUwcyguNmGDYs2Vd+TSWozPNLHgVWTTROvBe6Hy0U4fL9JFPdpBy74jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762703886; c=relaxed/simple;
	bh=Q9b1mi9IhV/RUcZIVoj4qCTeXua2YVgEjqYXa+t8ycg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWg6qoGGT6kWWJX/7SHKAvzRrd1aCTK+3AjdSAjckZk8SHtTr4gMVZD6uCRtaL89v+k7/2KquLxwzWaD/g9c7xVoug8a0Pa1pkAkOL5BlSgyHcxeIPZZ+nrb9ATE2XefQwbdRYPxw3wLCHldSZcXZDWRm731suJf/tkRx9O6u/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4ASnQ/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46CDC4CEFB;
	Sun,  9 Nov 2025 15:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762703884;
	bh=Q9b1mi9IhV/RUcZIVoj4qCTeXua2YVgEjqYXa+t8ycg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L4ASnQ/Hn4qshJfmUYvJzV2eVoBnhBhEIszecDRX0amSe0Aufa1dlRwBXDqDD7nlA
	 u9fuqbK6r/2hoWRGVDyGx24xSBL9lyDmVuzO59q38J2rStzNyjZPNX5RYSn3nAyckV
	 jJhEz3PGTA3HTCLCkBzwEVyLmvqb5i16R2b0ceh5UWwCBYP7gNl//f+YRuQ8YAfJ67
	 IkYxPr/0YYB2HQO8+Gnio7hJILCVeVRDShAlBjizy7MGaAaYckIooy9uWUkd52QgEA
	 VXTrTl8ToDtPp7KHXdmixmjSgmnRJpKbNCRPBz7o90GJgoblCexYXYYHMhZQm/jlhc
	 7xcxYZnfLQW2A==
Date: Sun, 9 Nov 2025 15:57:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v5 6/7] dt-bindings: clock: rockchip: Add RK3506 clock
 and reset unit
Message-ID: <20251109155757.087db448@jic23-huawei>
In-Reply-To: <20251104-mutt-spleen-31e1569f1674@spud>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
	<20251104-dev-add-ad5542-v4-1-6fe35458bf8c@analog.com>
	<20251104-mutt-spleen-31e1569f1674@spud>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Nov 2025 17:51:25 +0000
Conor Dooley <conor@kernel.org> wrote:

> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable

Hi Conor,

Strange email subject given you replied to:

20251104-dev-add-ad5542-v4-1-6fe35458bf8c@analog.com

I'll assume intent was to Ack that.

