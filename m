Return-Path: <linux-iio+bounces-358-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D527F8C90
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 17:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCBB1C20ADC
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 16:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217A42942B;
	Sat, 25 Nov 2023 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRf8irJ0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7342117;
	Sat, 25 Nov 2023 16:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F268C433C7;
	Sat, 25 Nov 2023 16:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700931399;
	bh=IPD5Po2zb9ZkslvDJpcIYJpLgsFXk1lDbitaI3nB7EU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QRf8irJ0QLq2+Z7Wof9rCOq2IOeb0Oq7E1KKjD4Bu8Op9vbhmytFPShygaV2HDJSf
	 AR0jwuOQjKmuUs10jO4SOJqNxX9GXs610AoW98Xs3VxOXNLkopqPn8OEYpo322i4o8
	 LE4ygU5VvUJP76icBhYMRFlSGf/SGgSMZXIJT+nebZm+7Nx0bzIwjGsRQNxeedGSXs
	 1xgIcpBd6Qn6oSbqPXrmh5nw7FkBO7z0PoSBPULxUeE0X8ZPWBEEg/OAGCdgAiP+0q
	 d3Hw0+JTFLerKOZPjX+xKdy4+dp6rd2VUuZ4CIi8zQiFYtXx2JM55STqlSnDa2bwtF
	 BWx4CACk0PnFA==
Date: Sat, 25 Nov 2023 16:56:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: mitrutzceclan <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
 linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Michael Walle <michael@walle.cc>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu
 <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Leonard
 =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>, Mike Looijmans
 <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: adc: add AD7173
Message-ID: <20231125165625.4f68cc49@jic23-huawei>
In-Reply-To: <20231123152331.5751-1-user@HYB-hhAwRlzzMZb>
References: <20231123152331.5751-1-user@HYB-hhAwRlzzMZb>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 17:23:21 +0200
mitrutzceclan <mitrutzceclan@gmail.com> wrote:

> From: Dumitru Ceclan <mitrutzceclan@gmail.com>
> 
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel applications
> or higher speed multiplexed applications. The Sigma-Delta ADC is intended
> primarily for measurement of signals close to DC but also delivers
> outstanding performance with input bandwidths out to ~10kHz.
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>

An example of reference selection would be good to have. Otherwise
looks fine to me, but I'll wait for the binding experts to take another
look.


