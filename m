Return-Path: <linux-iio+bounces-591-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5C18038B6
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 16:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAEEB1C20A53
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 15:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F752C1BE;
	Mon,  4 Dec 2023 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luWmtpc3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DEB25755;
	Mon,  4 Dec 2023 15:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9A3C433C8;
	Mon,  4 Dec 2023 15:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701703543;
	bh=87wG1kDj6b6gH/9dKdYLgikm7mMeRtoP3wmz09aZBmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=luWmtpc3YS8XrJMgI0Z803J9hR/unwQoXBr+bcRNQLPTJFTLEDPbWJz22FR5JPdx8
	 vmQJRGm1PUsJokWwExfhCe7NhddmUfamxS02hawMIhnRdPS4uBrLEiQvqjQoho5zTQ
	 yeiRLr+UOhJ907Jk56YYDhMF1RNh4JeD5ETVtexdRRkMPLtO8HIxpWIAz2mo4CnXDt
	 tC1Zf3UR49sXMw4ldMK9s7kFUuksrG9yHlmcAtqzJCNVu6nSROG7vwJg529TqaA1E1
	 KtRnMENQ8z4oZaaMNksBy7ad6OTbC5K4hzxLiAydtr8dh6NhACO9GqkiMGQ68Bnhen
	 2Dywz51C1yU1w==
Date: Mon, 4 Dec 2023 15:25:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Olivier MOYSAN
 <olivier.moysan@foss.st.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 09/12] iio: adc: ad9467: use chip_info variables instead
 of array
Message-ID: <20231204152533.252b6bfa@jic23-huawei>
In-Reply-To: <20231121-dev-iio-backend-v1-9-6a3d542eba35@analog.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
	<20231121-dev-iio-backend-v1-9-6a3d542eba35@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 11:20:22 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Instead of having an array and keeping IDs for each entry of the array,
> just have a chip_info struct per device.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Hi Nuno,

Probably makes sense to break out the various tidy up an fixes for ad9467 as a
precursor series and just refer to it from the main one (which will probably take
longer to settle).  Hopefully we can get these out the way and remove the distraction
from the stuff you really care about!

Jonathan

