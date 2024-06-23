Return-Path: <linux-iio+bounces-6771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8800F913C99
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 18:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4606C1F2250E
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1911822DA;
	Sun, 23 Jun 2024 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFsMlyrW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B03BA49;
	Sun, 23 Jun 2024 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719158456; cv=none; b=TCC2FkV6s+/eLFpse8Wx/NumL3kzov0jaMjIslCmmvSzfjSwm1tvdGuDbjKeG/sSKs8t1jhobQAHjntqvLmZ1o3wJ1qTz1XVB862+oiqzQMWmmh4XAAtACF0AeSTHFh2rXQdwA7ikyi/sq2NrFR1FaHI1g/Qhg5mKpZ7WylGBCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719158456; c=relaxed/simple;
	bh=7Bc3FGeAGbXcLl44BwdvekO5m2ZHEBu+uNSb/Gnrjr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hN8TLpz1RRzdh5F11x8HsDau5CGzLPzQywIKXW/iHhWcae62CsWZMmyLhev+PfNW6TtPTFEQ52ae41Hx/6nLVgqcH0Yq025+OR2Ht5Fx7w22wpf5ouz+w/XcN2fd2RrY/VtwFTJPnZFAyHgGagd6VpWIiQ5tEMzgrjb2C+kx8I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFsMlyrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3979EC2BD10;
	Sun, 23 Jun 2024 16:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719158455;
	bh=7Bc3FGeAGbXcLl44BwdvekO5m2ZHEBu+uNSb/Gnrjr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OFsMlyrWJosv5vEdWHCi9PkWLV+VAF0VahqOpSNzt9JzeSTb/M5tEoNA4HNlO6umX
	 RCK7stPIIIr233PPw2U8iA9xpbaLw6vPTwziXYLpreMXfkt3D67YV8gvQid00t4QH4
	 FYlYlHbnSweqnHPOlLrwtBA0WzM5A/6ME7bMnjkSr5OGFbyw8FZjIGwaDOS6XUp2Gt
	 gc4Vs5sJ1Hk77PA71bq8B5scQ5Lz5vcRvJ5+RK2kjaGxLxnBVVljNAgsxT6NhGdpD+
	 YU6wxI7bG3FsnktpBYsiCTySLTZcK/QgK0WKNgUuQZWWRBERbAbd+FkTiTPwwobMxI
	 meNqEh+i15gXw==
Date: Sun, 23 Jun 2024 17:00:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Michael Hennerich
 <michael.hennerich@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 0/6] iio: adc: ad7192: Improvements
Message-ID: <20240623170048.78c07c09@jic23-huawei>
In-Reply-To: <20240618142138.520192-1-alisa.roman@analog.com>
References: <20240618142138.520192-1-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 17:21:32 +0300
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> Dear everyone,
> 
> Thank you very much for your feedback!
> 
> The series is based on testing branch, since the initial first commit
> was applied there.
> 
> Here is the upgraded series. Please consider applying the commits in
> order!

Other than the tag issue + answering Conor's question this looks
good to me

Jonathan

> 
> Kind regards,
> Alisa-Dariana Roman.
> 
> v4 -> v5
>   remove already applied commit
>   modify commit message to mention the register configuration
>   remove useless | from bindings
>   add removed example, but still remove it in a later patch to showcase
> new functionality
>   remove clock-output-names since ad719x have only one clock
>   new patch to replace old maintainer (i mistakenly sent it only to
> linux-kernel mail at first)
> 
> v4: https://lore.kernel.org/all/20240613114001.270233-1-alisa.roman@analog.com/
> 
> 


