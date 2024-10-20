Return-Path: <linux-iio+bounces-10822-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 822809A5451
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 15:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0DAE1C20D95
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 13:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273CB192D68;
	Sun, 20 Oct 2024 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+CVm9EM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54EA178372;
	Sun, 20 Oct 2024 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729430555; cv=none; b=bAEVPLauXzScbteDx4qTDdQJmeG/LDu1v1lgtL1YDC7d4eyRTPFfCdRFboHnMmI3x8X6Q6y09BR6d70qcpsM//ovldasNgsEJnp8bkNgVz3qm514z4hzqeajQliy156KQsJs4+8yPv0h68zN6+Tta4DLEowtLGC09P7XDtEKM8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729430555; c=relaxed/simple;
	bh=Zd3r0CPcOA4nCfzLV8bE9tSPbSIO/H0xsjf7QMppU40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXSCqMYkGWvJoQrJ4vqkAeKOnARpX2qBeTh9zsgFGfNvCimp8Om7oJUcUXZ6jsOhlYGXP//BXfU3qvY0xjzagpsZ9LfnATPiiEObhBK6/IDcMzfELqY0Xu+cAXpCON3YRj/aDn7MTpveIzqnxvGzT4o2nFUj1n2Mil2HQMIask8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+CVm9EM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC6EC4CEC6;
	Sun, 20 Oct 2024 13:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729430555;
	bh=Zd3r0CPcOA4nCfzLV8bE9tSPbSIO/H0xsjf7QMppU40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q+CVm9EMNyzpnKJpLYd2wO65NVypY9z6k9AaEGc6xJf4S4OvOwv1JLlA/iOqGYIFY
	 Ho6dr7g8MoXSxjNA+UeaSVOcDm6+o2FVOOA/LlmF1t0FGhxteBs5KUsD4Z4XpfXqsw
	 oRxxRxRWA7l/3sFEY31oUIEAK7VoemjwcGBe4qhprZZNDAzMe5/q0NdFh595bKDOZv
	 rfDC9QTdLSAe5+SRf2HN7BzdtN8sYbaV5GFPhSu63jWp7F0T3qhgnVqS1KeUDAw1VS
	 guoCCJx1JTYRzUfQ654KbI/cC669+cejDUM2RDYJ4ci0SQWlBZlRQrSRK3wGDLeOb/
	 5Vh+6/Pv+KJgw==
Date: Sun, 20 Oct 2024 14:22:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, George Mois
 <george.mois@analog.com>, Ana-Maria Cusco <ana-maria.cusco@analog.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 3/3] drivers: iio: adc: add support for ad777x family
Message-ID: <20241020142224.27bfdc04@jic23-huawei>
In-Reply-To: <20241020125437.72c1de38@jic23-huawei>
References: <20241014143204.30195-1-ramona.nechita@analog.com>
	<20241014143204.30195-4-ramona.nechita@analog.com>
	<20241020125437.72c1de38@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Oct 2024 12:56:12 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 14 Oct 2024 17:32:00 +0300
> Ramona Alexandra Nechita <ramona.nechita@analog.com> wrote:
> 
> > Add support for AD7770, AD7771, AD7779 ADCs. The device is capable of
> > sending out data both on DOUT lines interface,as on the SDO line.
> > The driver currently implements only the SDO data streaming mode. SPI
> > communication is used alternatively for accessing registers and streaming
> > data. Register accesses are protected by crc8.
> > 
> > Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>  
> 
> A few comments inline.  I also tweaked white space in a few places
> whilst applying.  Target in IIO is still sub 80 chars whenever it
> doesn't hurt readability.
> 
> Also, you had unusual formatting for some of the macros. Avoid mixing
> tabs then spaces for indentation of the \ 
> 
> series applied to the togreg branch of iio.git and initially pushed
> out as testing so 0-day can take a look.
> 
> One missing return in the debugfs register access as well. Please
> check I fixed that up correctly.
Seems I missed the cancel button when I noticed the build message
just as the other email went out.  Sorry for the noise!

> 
> Thanks,
> 
> Jonathan

