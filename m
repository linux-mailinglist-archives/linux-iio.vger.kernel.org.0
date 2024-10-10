Return-Path: <linux-iio+bounces-10412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BEB998FCB
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 20:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB901283DE2
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 18:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF941CEADD;
	Thu, 10 Oct 2024 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4JL97Li"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11E51A303E;
	Thu, 10 Oct 2024 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584548; cv=none; b=p2GqGn5gegSU+my9ddymXlekjwseQ8Y+KkHz7kArdrziS/3TaxZ5aHepi46J0WTChNeuG7hFLlSLeCfLO1ebHF9GgezdN8LeqSMdcemtJyW2A6DEAgfGEiWmcOPvl9tYxt7neNKC5FT5ZSkhMMx0wNsP56nLUhF2BLyU767AJ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584548; c=relaxed/simple;
	bh=iHHNxPo48eGIoD/CN3nF+gO4PuOB8rnALVXIRbOFEL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0t7RBpBZ9ZLQ8n1YPaWi++KPa6IVwdQNXbdAiUzyf3/XX8ey6wwH1qaBbl9p70RDc9WMY1UZfCbV3cBxI2DqKQNPrUqmQa9vkTirvDlyprtlfMJDoDlgNw/N2350M63EItGFxjdFmQrwKQ4DV6kKRoCHdNDoTwwyc8mfj7nXk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4JL97Li; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3639C4CEC5;
	Thu, 10 Oct 2024 18:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728584547;
	bh=iHHNxPo48eGIoD/CN3nF+gO4PuOB8rnALVXIRbOFEL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q4JL97LikGDNtRlMN7v1YzgtoBXDTbuxbY7QcervbrtMajmzPaTvlw+Bvme9CpgIU
	 ercXsLH5gRgqJT3j87lmM+9uTezE0kL+25wAD1XpCNDykOWVctqqsh3Vto6DI4yBXu
	 D2ent+xbtIk3QQUiTXsAoOTcRWfqTj6rkuI5IQzFxHpBqs6KBG5UjfCsP1qeaXedlL
	 raevMyrYtE20K6UwkYOpQWhIsXqiNhA42gZFm9hV4EwqUfp4anaK7ZnrTrTK2LnF9S
	 E4cDjfXoRbRwEikDTPNQeyeHOkUAXvoIcTK3RLxWUNsWfg7f5+lvDxyLfAV+ZtlwRK
	 oV91oMrOIf/Vw==
Date: Thu, 10 Oct 2024 19:22:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: iio: adc: ad7380: fix ad7380-4
 reference supply
Message-ID: <20241010192218.12808268@jic23-huawei>
In-Reply-To: <v7in5n6ktmu5kfzlndn4eujmk5n66fmft4lvwuvucqbcv5r5hb@etdqvn6ev6nl>
References: <20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com>
	<20241007-ad7380-fix-supplies-v1-2-badcf813c9b9@baylibre.com>
	<v7in5n6ktmu5kfzlndn4eujmk5n66fmft4lvwuvucqbcv5r5hb@etdqvn6ev6nl>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Oct 2024 09:52:50 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Mon, Oct 07, 2024 at 05:45:45PM +0200, Julien Stephan wrote:
> > ad7380-4 is the only device from ad738x family that doesn't have an
> > internal reference. Moreover its external reference is called REFIN in
> > the datasheet while all other use REFIO as an optional external
> > reference. If refio-supply is omitted the internal reference is
> > used.
> > 
> > Fix the binding by adding refin-supply and makes it required for
> > ad7380-4 only.  
> 
> Maybe let's just use refio as refin? Reference-IO fits here well.
> Otherwise you have two supplies for the same.
Whilst it is ugly, the effort this series is going to in order
to paper over a naming mismatch makes me agree with Krzysztof.

I think adding a comment to the dt-binding would be sensible
though as people might fall into this hole.

Other than the missing ret =, rest of series looks fine to me

Jonathan

> 
> Best regards,
> Krzysztof
> 


