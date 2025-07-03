Return-Path: <linux-iio+bounces-21284-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F1BAF6BED
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 09:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714061C47868
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 07:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9592989B7;
	Thu,  3 Jul 2025 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUuM5KPM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E5D1C07F6;
	Thu,  3 Jul 2025 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751528884; cv=none; b=oGWydLgyr9+T+h7qahbLCpxXfQodAVZePge00kkygqHZW5HNC4j7qeXRf8JGCFIXPVNaNH17JjOd9AEHOEA76ffW3CGA1pAz3i+YWXkwM9x0dtUeVRCtX0LnSjHs07WEGETaIWI8j6iq3K6IntDY+uS3eEBt/2tk7bd6oWV35ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751528884; c=relaxed/simple;
	bh=s9ykGtfs0LX3ujSHVCs3mx6zSWxs7c6uLiOZIRxMw1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvcwJMVqFOLAtD0YPDhPXhuGgR8Yf2kG73CZHVilJMwOJD2ysO2sBxER8JpXa760ZeNTgvJ/IWjdrJ0/r0linnUhrE2c0RZ4BmTS9UbWrQN4VL0FADuFasBY7hjTcm6hSZxUfUZz2+Zv3R5LQzKfabHCqliWE5rBxj2U2C/45/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUuM5KPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3CDC4CEE3;
	Thu,  3 Jul 2025 07:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751528884;
	bh=s9ykGtfs0LX3ujSHVCs3mx6zSWxs7c6uLiOZIRxMw1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUuM5KPMjzdteL2YobZ83lISj54WI3hx/7p6Y9OFk/b9TRhVpFerjnep5fby8I/n+
	 bbuIpReZ9qRj6L/6xRZGU8T3hMd4ldO0jaMEcRBNZdvdDycyVFZ30R6fe+vv0ZlaWq
	 doXZpPbxKiHhZEp93N6OAHQOa0ow8WbhVAdpNNyC/FRsc/DDOC7dHZPZwxJryewY+D
	 zcAEItZBbSGG298kslLneC3FlmokV24ffsP/DdsIPmLOZ++8L+0jY3ys03ly8PfUoI
	 c8xV9RFcUhhQxOCjmZxLYwJmAd7cMTqhMlF/vT+VaQf56K+xEDma7JTcHaJ5rydBgP
	 4V/DEDhyQ6A5w==
Date: Thu, 3 Jul 2025 09:48:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	zhiyong.tao@mediatek.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add support for MT7981
Message-ID: <20250703-impossible-determined-hamster-88da20@krzk-bin>
References: <20250702214830.255898-1-olek2@wp.pl>
 <20250702214830.255898-2-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250702214830.255898-2-olek2@wp.pl>

On Wed, Jul 02, 2025 at 11:48:29PM +0200, Aleksander Jan Bajkowski wrote:
> The temperature sensor in the MT7981 is same as in the MT7986.

This is not what your binding is saying. Binding is saying it is
completely different.

> Add compatible string for mt7981.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Please drop and request a re-review.

Best regards,
Krzysztof


