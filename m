Return-Path: <linux-iio+bounces-8379-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A8C94D5FD
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 20:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3951F22FAF
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 18:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD87145B25;
	Fri,  9 Aug 2024 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXLjv456"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F473501;
	Fri,  9 Aug 2024 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226801; cv=none; b=VFUYpoiW7AVOFH8IyrO9y8HN6ccM7Vi/zXX/6t07ijTThAod7BJxMAp6KalAFYVxDZHGX/uw3p7LS/nvDfQzeDwXUi1XLBy9ggdxOIf9KmGn8fb053pDjnyDcmefcdrqU/uYGrE6vdTt1YQq6c+JOimrHQU3B9GKlNuACxC3TqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226801; c=relaxed/simple;
	bh=pkZZTIQBl2I/prDiuY6DMo2Gj951jGw8jtf6z64HUIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVNrUaVx9tHMyYIknTPXqaW07gJ6J1FtBEuSNkxe3FLlLcaE2wHxF44WdXZL8FbG6n1l6u9r+ziW8CnoeGO0XJIjIQN1LrnOsgr0NhwaUvI3Ve3SPeyqPLVI+A4Egnj7F8VTTUaehxqSr9d0OxFRfvg5WWPQCxO/VaHL16AhItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXLjv456; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324F0C32782;
	Fri,  9 Aug 2024 18:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723226801;
	bh=pkZZTIQBl2I/prDiuY6DMo2Gj951jGw8jtf6z64HUIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AXLjv456/svfo4gZB5Th/V+U2kpiLPibheZWhP9HLuLdz6dSCz5s5+yeXF+uT/FnO
	 3olWRNvE2CCeWSF76N1mlNnc/qDIlO78eG51TaOCsQx65C/Uq+n6h3i7+udq6t1XXD
	 r3+vjGzF7NkHat0ExxC2hjUYd9BuwZ4FsL6ENa3thtW04ZOj4APY9r05WCGzU4uiyN
	 4sqVCm0F7XN4L9YlJyhPevZbFtaUhe59m3+LZQbk/V6VNOGALxwOHA4/4AB5Kwv2CC
	 8rclwGADNHxtW2JqwHnh96qKnnWMXy5rnYoDNRsL/IYHm2ntrq/MrJGX4YCZZdz1rE
	 mXlWoJZAe5aJQ==
Date: Fri, 9 Aug 2024 12:06:40 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: ad4695: fix common-mode-channel
Message-ID: <172322677990.966347.12423820402689548305.robh@kernel.org>
References: <20240808-iio-adc-ad4695-fix-dt-bindings-v1-1-5cf37b9547b0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808-iio-adc-ad4695-fix-dt-bindings-v1-1-5cf37b9547b0@baylibre.com>

On Thu, 08 Aug 2024 16:12:08 -0500, David Lechner wrote:
> The common-mode-channel property is a scalar, not an array, so we should
> not be using items: in the schema when specifying allowable values.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Closes: https://lore.kernel.org/linux-iio/CAL_JsqKaddw8FnPfdnhKhHUb8AcTxFadc_eZmxjX0QxFR80=mw@mail.gmail.com/
> Fixes: b40cafc11436 ("dt-bindings: iio: adc: add AD4695 and similar ADCs")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Thanks for the quick fix.

Acked-by: Rob Herring (Arm) <robh@kernel.org>


