Return-Path: <linux-iio+bounces-16701-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C299A5A4DC
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 21:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5414B3A6777
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC541DDA09;
	Mon, 10 Mar 2025 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eATy/SAJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03806EC5;
	Mon, 10 Mar 2025 20:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638185; cv=none; b=YO3bjXT3LYfFhhZqwPl/k6XQcSiKh6WuiH3CvQ3OFpDepQAwTODSxr9Sz4CN4q3IdKLshqwXpjh4DO3zZmz3Gmn0Q8B5JEqnJpl246oNGKS54nRRSjI6mdxYsRg5sNwRABIc/COkvPsfbguC1l1yS0Ke9BiCAYHtXJ4J7oGVW2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638185; c=relaxed/simple;
	bh=PBfB7zsuCWafYTfzaWtfPf+yNmlCmfjLBfhoGvaB8oE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wy2kWO9G898q7vxbv83sQTvAn2418I5FRhMFVeX3IT7QzXpsH1hV3WRRb8PCfH5WP91zvHgKWdgrkXWwjteOQevkn9m3LXOE/GBrFhwvmQ0KDwIgD2gNUSPYHILPDDt2e0O/9Iag3/AVvGS4hMGCj0X92q3p4yEMgt7Cf/7RH2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eATy/SAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8BBC4CEE5;
	Mon, 10 Mar 2025 20:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741638184;
	bh=PBfB7zsuCWafYTfzaWtfPf+yNmlCmfjLBfhoGvaB8oE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eATy/SAJQkGtPOC9xzd2vrFraHPPiUSfSg/+jHl9rtYJKkD+wzOgQCTJDC9gXWqkB
	 XLfuL2NkhmrmvYT7B+sZO2Q1+h3Dw+dMQAGf6jsFGGMH0PrL4g+8DZkcV8fkrRKmHN
	 BPEWxAD2NbY2IGn9lb53HBrHvSfYMNuQv27cAhJ/tlZIK7aH0lw3P3Pojb7kT0qgtB
	 e2vEJCiG4iKl64Bj0ctO+lwpayZ+fcKEWRgHFosUJoyPETOSPnB4T6AAW1dcfEHfYe
	 narVS4E0RuzsiEMXN9/tHdxyE3UgRbQl6Rk3Clq6Jxn2jyWcsTpXFc6DciO52zuVIM
	 cNbnJTJWzvK7Q==
Date: Mon, 10 Mar 2025 20:22:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, Guillaume Stols
 <gstols@baylibre.com>, Olivier Moysan <olivier.moysan@foss.st.com>, Dumitru
 Ceclan <mitrutzceclan@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>, Alisa-Dariana Roman
 <alisadariana@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v6 04/10] iio: adc: rzg2l_adc: Use adc-helpers
Message-ID: <20250310202252.1e903fe3@jic23-huawei>
In-Reply-To: <e0b08f7cb2b564d9bc7b21f5712e69961863dcb1.1741610847.git.mazziesaccount@gmail.com>
References: <cover.1741610847.git.mazziesaccount@gmail.com>
	<e0b08f7cb2b564d9bc7b21f5712e69961863dcb1.1741610847.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 14:56:23 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The new devm_iio_adc_device_alloc_chaninfo() -helper is intended to help
The function name changed.


