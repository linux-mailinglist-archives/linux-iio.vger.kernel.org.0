Return-Path: <linux-iio+bounces-13237-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA499E8709
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 18:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E86516174D
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 17:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9838176240;
	Sun,  8 Dec 2024 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9Rbfvg/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8BA145324;
	Sun,  8 Dec 2024 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733678629; cv=none; b=AnZEn7zIrm6YNPIdTjdPthpz75KkknuK63wYkjYVD9Ji4YdGLexoLx9p15jTsAXR1N9wygw28QFT6+opmqXNHva8IZrNAd2lxCIflubsByIWWAl+szSdxjKVNnn6vzRebPVny9T8OLredLQC6aCpIAHGGICkf9xEeqGUpWw5HJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733678629; c=relaxed/simple;
	bh=0T9JCVjOVQFmdMhgahNhMmEbIybCaTDmPEvCf+olGoM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmqHTjsZCAL+JidzgsVUMRHE4eeQexsbYcpOTKc3Hc2XZb/dgkDJ+chUDCsrDqXdAKdqmO7CpB6nFLZLVenI8M7ErkzQuj6dAmvzu2+98FDgi0NmGxxqsojaGAoaMz6CpiCRSnOdM13DttiWBQshA/e9NUcsa1mMa7Kuqo2b2iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9Rbfvg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621C3C4CED2;
	Sun,  8 Dec 2024 17:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733678628;
	bh=0T9JCVjOVQFmdMhgahNhMmEbIybCaTDmPEvCf+olGoM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W9Rbfvg/xfVLMdOA0q5X9zU52BdBf4HGyZ6+OQTMqL/ILHcHpD35mmAHXkvHIs0Ru
	 /ySKpT7zt3kk564OPfLzWKVuYLrP/lRt6PR+CEsvgsj2Z445NFnkp6118CrAtBaz1i
	 Qze8QPJcTwO0NwjmGzI0iuJTizoULmrhbYPoWAPehCzme+oVb8xY/wqutdrZnlHFPo
	 oPRwc5zJMKAfYTswVdFMJTxjfaaKu2YBWEExDeyJnLM/9qUpZIWTznJkSFBQxaxP3M
	 L6Q4CwbPIvjDOiOcQXoxgmt+9SNlhRnr4Gwf77xWzr5t1GqH4+J0caquEg7Fc/6lVU
	 U5r2zqJx3PWWQ==
Date: Sun, 8 Dec 2024 17:23:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Sean Nyekjaer <sean@geanix.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: accel: fxls8962af: add
 wakeup-source property
Message-ID: <20241208172339.307bf086@jic23-huawei>
In-Reply-To: <20241203-famished-satisfied-13c6f350a387@spud>
References: <20241203-fxlsdt-v2-1-ef523461b507@geanix.com>
	<20241203-famished-satisfied-13c6f350a387@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 16:28:23 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Tue, Dec 03, 2024 at 08:22:11AM +0100, Sean Nyekjaer wrote:
> > Add a wakeup-source property to the binding to describe whether the
> > wakeup interrupts from the accelerometer can wake the system from
> > suspend.
> > 
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>  
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied to the togreg branch of iio.git.

Thanks

Jonathan

