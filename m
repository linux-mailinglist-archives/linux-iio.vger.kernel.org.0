Return-Path: <linux-iio+bounces-22301-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9915B1AED2
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 08:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1D23B353E
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 06:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB69121D5B8;
	Tue,  5 Aug 2025 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBGuSjFf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AF2367;
	Tue,  5 Aug 2025 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754376818; cv=none; b=u7nHXUTI9xnu/vT7L9N1lel3+zQXkArLIa7ywu0Q3lwY7gJOZBKzO9F1ePBvaIr91tRbNfohJVZcSXTK3vcQAOnjbTiY5AP7LGgNCmofAtNdk4k4PjFoWf/v1D8qxu+u0JoGC9Xe0gKcNxhukjU3RyQ7QM4xQzfVFGRmF7SbIKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754376818; c=relaxed/simple;
	bh=CmRWlV92762yR80zNL8c5OFgmvYfelATH19l779Etw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ri4FXodZYFoTXiR+zPnab8LYRG6ShMBHamZxHjYmdqjKz0cAUVrZ8HK7asHfTw5QdKyMJNtwqGHTYJrWbq0gFtVl5sNmH+5idX0n/6cfWWn8WIiA2XICDLBPfjDjGB9Si3IRii308xiYrKnic8MMrTVXIu2b06EmrIm60nhCgq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBGuSjFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C360C4CEF4;
	Tue,  5 Aug 2025 06:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754376815;
	bh=CmRWlV92762yR80zNL8c5OFgmvYfelATH19l779Etw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dBGuSjFfPn/fM/3Bg3K27xG0zO2m70UPVdEJTfIUL88efMc45VygczsY1TOQCcw6Y
	 1Qld+TQ0yho08lcset08ZhSq+TZ0kJRxQGcR0SqPQY31hLOz58TPEXfYp+lzwCB6qc
	 yN1qcdsWVV6ZSJ4ccOqT2sWWTR88A1lzjTqX6ulH/he1oVEyTuY3Gi0BLfuCws4cHE
	 GHvYKl25aOA/t1ciolQcGUDn9NIn1cf4tf379tylWTAE3XxTHUW6D23aQ/VdlWvlAj
	 uiHs684hnob5mg5iYxPTav5TfGb9dOIejDVGymoboN/nmSpEZhZCO8nK2K2c2wcmWP
	 hBj3+gHbTJK/Q==
Date: Tue, 5 Aug 2025 08:53:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: eugen.hristev@linaro.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, srini@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/15] dt-bindings: microchip-otpc: document sama7d65
Message-ID: <20250805-capable-coot-of-tempest-2cd3e2@kuoka>
References: <20250804100219.63325-1-varshini.rajendran@microchip.com>
 <20250804100219.63325-12-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804100219.63325-12-varshini.rajendran@microchip.com>

On Mon, Aug 04, 2025 at 03:32:15PM +0530, Varshini Rajendran wrote:
> Add microchip,sama7d65-otpc to DT bindings documentation.

We see that from the diff. Explain the hardware. Is it compatible with
existing one? How much compatible?

> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../bindings/nvmem/microchip,sama7g5-otpc.yaml       | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

This applies to all your patches, because several of them have the same
issue.

Best regards,
Krzysztof


