Return-Path: <linux-iio+bounces-22101-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E20B13BE2
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 15:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB19B189E362
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 13:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A2D26AAB2;
	Mon, 28 Jul 2025 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzeSKulx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A030C26A091;
	Mon, 28 Jul 2025 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710450; cv=none; b=Is5iWwXmzvKiaQOFBIh6yvWuMfHo+/++uaw6JgUVSfzIX6GyjcHK4qnK6+kLQJWaXMe5jCue9U70HmtXjrmQWmvVzE6OTYd4HX57FlxkAyK54E/otjUDkGRWYsmG2FLv2pG6cIiQTjk9VqbtaKgYc8YZo2iq5A9PzaiyES/oFnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710450; c=relaxed/simple;
	bh=AItEbBNl2zFy92ODxc3mp9jL4d5m71/4Fr68Dt4OVuo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KNmyFBlya4TNyxEJ7z8zRf0HPIYskSzrGiWkqqQMxhsOyVun6CgPkQAhRSC++Q0N/q/HGTkXD0LaRUZS3yorGAqCkp5S5iWZgrJhsoqh8dnYGKDgwC44dzmg8nc55uAVnTNbXcNGu/DHnd5/BJhhro0er9oVgb906nGu59z0VhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzeSKulx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E09AC4CEE7;
	Mon, 28 Jul 2025 13:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710450;
	bh=AItEbBNl2zFy92ODxc3mp9jL4d5m71/4Fr68Dt4OVuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rzeSKulxax2Km4aDCARHbj6ZXQNH3BVsFnwsNmh0CcaaFwLHp0gJRzK/lf0QoEgmj
	 lgwT+va6Edy8CqhC1xR8MCUU5b2wFfFAjaPRkp06cC0s3xfWwNUAHG6kBAYYXpeC2A
	 9GlfJpJttUelva3BCPnGmJONLBc/HJzgZ4x1RPfoJsvkdsz5VSjlVAVU8uAxyi4wtK
	 K2a/YQGaBd60Ucs3PyJXUlep7FCHw95pJD7MsyJt5EKiXMrDdOrXku+UsBnN3J/4FH
	 jrKUQM4Po2nwnq2nw4ht4kON5wbvM+F5IMtgG6An53JNlyhH8F8SD9kRQVLLBLl1Xj
	 gMPWUHlh/+++A==
Date: Mon, 28 Jul 2025 14:47:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lucas Stankus <lucas.p.stankus@gmail.com>, Puranjay
 Mohan <puranjay@kernel.org>, Dan Robertson <dan@dlrobertson.com>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Alim Akhtar
 <alim.akhtar@samsung.com>, Dragos Bogdan <dragos.bogdan@analog.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, =?UTF-8?B?T25k?=
 =?UTF-8?B?xZllag==?= Jirman <megi@xff.cz>, Alexandru Tachici
 <alexandru.tachici@analog.com>, Stefan Popa <stefan.popa@analog.com>, Linus
 Walleij <linus.walleij@linaro.org>, Stephan Gerhold <stephan@gerhold.net>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, Alexandru Lazar
 <alazar@startmail.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson
 <andersson@kernel.org>, Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>, David Heidelberg <david@ixit.cz>,
 Manivannan Sadhasivam <mani@kernel.org>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, Andreas Klinger <ak@it-klinger.de>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: Drop unused header includes in
 examples
Message-ID: <20250728144712.20bfc746@jic23-huawei>
In-Reply-To: <272b1700-7ebd-4693-829f-8d842e6eece7@gmail.com>
References: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org>
	<272b1700-7ebd-4693-829f-8d842e6eece7@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 09:33:37 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 24/07/2025 14:13, Krzysztof Kozlowski wrote:
> > Drop includes of headers which example code does not use.  No functional
> > impact.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>  
> 
> FWIW:
> Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> 

Updated and fresh testing tree pushed out.  Thanks

J

