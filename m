Return-Path: <linux-iio+bounces-11970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D959C02C4
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 11:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1AB1C21829
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 10:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815111E25F5;
	Thu,  7 Nov 2024 10:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPaaxCDg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32348126C01;
	Thu,  7 Nov 2024 10:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976323; cv=none; b=RE/LS/REWZGhLjDvc3irY2O6jqVdG9LNkVzN6dRU7GxXjntrJ5n1QSq20+EKL/JozSWqAbskgjvDhbP9XTs0IupeUX9Rk5dXskbDhBq5WWoF14eGbq3QKsPOXeZLz2fZ7rkNmOnDdx1tp7ePb+zh7DcAbMBx9niU3Br8hzzQru4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976323; c=relaxed/simple;
	bh=OBF0Rv+cD11Z7npbmm8wg9lLLq9u4fQoHSrg32i35Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQ00og9ewYzeVKOPLvXWCHZmGW5jC69PnPsZVevWqtKilkQ2k9YY6e6L/Q6LlEPLhuU4ZevyvLb94b+Zsfrs52+pzZZipbemmWV6TR3tMe3fs/WsxWgnWEeNgFpiTxlrq+dlONSYOaG2n7UqpTqEQ+OOWdoo6SKjRZICv3JYhE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPaaxCDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B3EC4CECC;
	Thu,  7 Nov 2024 10:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730976323;
	bh=OBF0Rv+cD11Z7npbmm8wg9lLLq9u4fQoHSrg32i35Nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aPaaxCDgklfMWwGQ7ykPjVP7HII7UzvONfHFORvNY5ePOLcza726yocsW0MEhkpEy
	 1vhYXWbYc/JEQNSatZ5VoPEGNeMLw1wAZ3iq1iH2VDJodFhHaVYuHgXKPV1lh4aMXw
	 9zfQA7C32+GLwxZSRUQ80hl+OiYedx/1pb1WBT4QbPidqOTj2S8fiidLrUNDpMrs9o
	 Z2h4Gze0f8tgIshazhKzeYEEB8xdVe0k0i0Ep5jXSsgVAknoOvlSZFkOD6YcIEDe4C
	 D8U7jDhQfo6w6L0VAhlx3BDxIgSV/txNGgejrXaVkhdgiAe+YJRElCAHImg13ibWAW
	 Yd1d8A0jRN1dg==
Date: Thu, 7 Nov 2024 11:45:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Robert Budai <robert.budai@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Nuno Sa <nuno.sa@analog.com>, Ramona Gradinariu <ramona.gradinariu@analog.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jagath Jog J <jagathjog1996@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, robi_budai@yahoo.com
Subject: Re: [PATCH 3/5] dt-bindings: iio: Add adis16550 bindings
Message-ID: <m4owgzz3de7kwv7parm5qfalruoaenoq2j6c7flqrrajwasiyc@4ktukd3cytot>
References: <20241028123550.9128-1-robert.budai@analog.com>
 <20241028123550.9128-2-robert.budai@analog.com>
 <20241028171146.0000676a@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028171146.0000676a@Huawei.com>

On Mon, Oct 28, 2024 at 05:11:46PM +0000, Jonathan Cameron wrote:
> On Mon, 28 Oct 2024 14:35:43 +0200
> Robert Budai <robert.budai@analog.com> wrote:
> 
> > From: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > 
> > Document the ADIS16550 device devicetree bindings.
> What is the difference between the 16550 and 16550w.
> Need to give an indication here of why the need separate compatibles.

There were no answers and it's almost two weeks. I am marking the patch
in DT patchwork as changes requested (which means it will disappear from
our view).

Best regards,
Krzysztof


