Return-Path: <linux-iio+bounces-6994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C00B91B068
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 22:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6581C20F1A
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 20:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9612419E810;
	Thu, 27 Jun 2024 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovWUi9zT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4B619DFB9;
	Thu, 27 Jun 2024 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520258; cv=none; b=o2VDLYkMbZwubEQOTre73aqEGzxSljkDbEv++yW+zEBDV9CmnFdtk9cZbU4KT0q7LhBjFz+Si45IOm3p7ZUoL2++9dz/SjA2oFk0dQIXrq4WmaoeQiul5Ezr83LZ+XC4vB4w4RRXKCtdRTXpoNj06voYV1G4YP3nNCMWW0KpCJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520258; c=relaxed/simple;
	bh=zV8YQwWbR4WX1CZ5WjcxInaK7s1GYywgp10TQMTKIZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmhDOV5uVpvZWJJi8vVkWRDBBQyoaMTNn63TBwFX6TUMlehoe3OYORre1wKzuqKvp4DTbRU93411W9XLnz1mw3IQHjD0pcpRqxLVrjkS59ZMfNB6z9Eox3RbCLyEvW7uprm5d1NWmTLQrsXkHD4kgs5KMyZPoCrMxkdbZZB924U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovWUi9zT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A928C2BBFC;
	Thu, 27 Jun 2024 20:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719520257;
	bh=zV8YQwWbR4WX1CZ5WjcxInaK7s1GYywgp10TQMTKIZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ovWUi9zTkoQD1ZZjm2BMlGAAoi2bX2MpzREANn9iLyB9KFOnrlqzcCNza8OIPrsbW
	 nVzZcieZKBpjRJ7EgoIDBR/gVBSGBi7GvUx0l8MIfaWdjCjAYEYodT9YpB0yAe3Fqk
	 3s6AC0vwSekNZuL7H305qPqpvVw97wWzDV37woiFIN2Jvo2s+ccFb8bk+H83YRd1n1
	 vnLFjbwCtGSqlL4dDpLQmH2sTyyYYIfX2fzRUySiC6ra09hNXFAs9aV/NB9v5dMxAk
	 nT8/+zdKOpzbWb28mCbP6YwXzVBDSxWz1P6bP/n2J6Woa7OPRwvPQ/Pm5gSXJGk73k
	 0o4rIOsqzeUiQ==
Date: Thu, 27 Jun 2024 14:30:56 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, jstephan@baylibre.com,
	dlechner@baylibre.com, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Beniamin Bia <beniamin.bia@analog.com>, linux-iio@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Stefan Popa <stefan.popa@analog.com>
Subject: Re: [PATCH 1/9] dt-bindings: iio: adc: adi,ad7606: add missing
 datasheet link
Message-ID: <171952025424.477297.14698127361119381011.robh@kernel.org>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
 <20240618-cleanup-ad7606-v1-1-f1854d5c779d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618-cleanup-ad7606-v1-1-f1854d5c779d@baylibre.com>


On Tue, 18 Jun 2024 14:02:33 +0000, Guillaume Stols wrote:
> Add AD7606-5 datasheet link.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


