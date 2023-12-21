Return-Path: <linux-iio+bounces-1214-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8EB81C12A
	for <lists+linux-iio@lfdr.de>; Thu, 21 Dec 2023 23:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5B21C23FFF
	for <lists+linux-iio@lfdr.de>; Thu, 21 Dec 2023 22:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C9E77F1C;
	Thu, 21 Dec 2023 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7yOcu5z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00A0539E0;
	Thu, 21 Dec 2023 22:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B65C433C8;
	Thu, 21 Dec 2023 22:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703198807;
	bh=KXvjFUiHX70HF64T8ILtJMgH6TV3lQn64cwiBFZ9nrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k7yOcu5zSkSTSDfP4+8GgK8Db54OwRIF52yUr5HF9Cxb6BFEK7TSNRLG6oMY4gFzk
	 WR/0wJvRdPpOMOQw2palzwQyZrZGO4ScT8eNpyqUfZvMnUBkN2LoGwU+4PQpPwUSJQ
	 KRQBWN4zTQfGu67kXkhbgh1Oq9tn3a9iwK6gJxYUzwACHsfpXCFjlrJ2ILp8Pt/ux7
	 uvuMyo9AGz1n7d3iwcZueL48K9ISAKF5/EjX3/H6leISfhIQTx+mHtx3reqvZV5Wpu
	 vPFX751AZ8aCqX3Ib3USlQVZHFazFoGZ2cqhl1D2NqjkDLAStBsUHPx/xEG5KYJ1t9
	 OSspJMbtcHP0g==
Received: (nullmailer pid 227326 invoked by uid 1000);
	Thu, 21 Dec 2023 22:46:45 -0000
Date: Thu, 21 Dec 2023 16:46:45 -0600
From: Rob Herring <robh@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, Frank Rowand <frowand.list@gmail.com>, linux-iio@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/8] dt-bindings: adc: ad9467: add new io-backend
 property
Message-ID: <170319880465.227267.11932534810200819301.robh@kernel.org>
References: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
 <20231220-iio-backend-v4-1-998e9148b692@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220-iio-backend-v4-1-998e9148b692@analog.com>


On Wed, 20 Dec 2023 16:34:04 +0100, Nuno Sa wrote:
> The ad9467 will make use of the new IIO backend framework which is a
> provider - consumer interface where IIO backends provide services to
> consumers. As such, and being this device a consumer,  add the new
> generic io-backend property to the bindings.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


