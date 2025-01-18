Return-Path: <linux-iio+bounces-14460-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EFDA15E00
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 17:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1461886E75
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 16:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468B6192D9D;
	Sat, 18 Jan 2025 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogeqStwR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F088623CE;
	Sat, 18 Jan 2025 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737217220; cv=none; b=PWUzlFL4BZVugsGY0EOvoLpZNE9V9iKeO2hDbjRLykkwSWkzLz6qaNuVzYamVooUkmV2D1cLjLNL9kGv1eGA+Ee6bhlKbtFhSva9Ev4SamOoLavd3VSRL/T8VOWkR5sklAP5Z1teJcUOpH3ZaAf7zgwA97X8M5kfgFNBJmGPCxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737217220; c=relaxed/simple;
	bh=VEyxkr9+HdHNwnlS6cwS4n6YqtHcyLmIVbK/tE6OVKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GpuuzBXBG1jmBRlSbE5MeRbax4+QrXEdgiObivh+nSXrFDd+i55tn5o11MGOOFSLG96d8vRRXZP3FrkR3Iua+cGhj7VifCi8RKXK5259zM7DdtQio+35OB/pkiaMnStj8JSg5cogtXwt3Hdwpp/Lstpho9ZoD9OkR0fUAMuij6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogeqStwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24B7C4CED1;
	Sat, 18 Jan 2025 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737217219;
	bh=VEyxkr9+HdHNwnlS6cwS4n6YqtHcyLmIVbK/tE6OVKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ogeqStwRBAhQ+5GDY2yYZNKgw2ooHHkvotA+kq2FWXkWl3+ZpZusF7z+ATAvnNEPb
	 ZyiU0wtbbKxoIqm6aSxEkBpjhvVZBrxAewAoDxfNx0WcxTcdpCvMhY2PoHMRuJlIzM
	 spBxdf1Fd2C8fidjeKE8fPO6rWqjB8tMAD0DKhIHBMDs7romcHL1NBM3jbxBVzHjO7
	 WLZicemwbE1toYqEm+7I/ZLYOVAKVxMWRkk0I4W825q0RpAXOyIwrm0wWEHb8p6Nl0
	 NosJMPJ7Lnunp8aPKRu0shdoG/DcxYt/LuSIm+1+hIz2J66P9fQJ+vZqfJHJ/VSirA
	 pR3sda3L5F9Tg==
Date: Sat, 18 Jan 2025 16:20:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Vasiliy Doylov via B4 Relay
 <devnull+nekodevelopper.gmail.com@kernel.org>, <nekodevelopper@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RESEND v4 0/5] iio: accel: mc3230: add mount matrix, of
 match and mc3510c support
Message-ID: <20250118162010.08ac38f4@jic23-huawei>
In-Reply-To: <20250116164211.000079d0@huawei.com>
References: <20250116-mainlining-mc3510c-v4-0-a41308b85ec2@gmail.com>
	<20250116164211.000079d0@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 16:42:11 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Thu, 16 Jan 2025 16:52:41 +0300
> Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org> wrote:
> 
> Always say why you are resending.

Other than that, looks good and you seem to have addressed all
comments on v3, so applied to the testing branch of iio.git.
Note I'll be rebasing that on rc1 once available and only then pushing
it out as togreg.  In the meantime it will get some build bot coverage.

Thanks,

Jonathan

> 
> Jonathan
> 
> > Changes includes:
> > - Add mount matrix handling
> > - Add match table to work with DT
> > - Add MC3510C support
> > 
> > MC3510C use same registors as MC3230, but different value scale.
> > 
> > Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
> > ---
> > Changes in v4:
> > - Fixed commit messages
> > - Added const modificator to chip_infos
> > - Return name->chip_id->product_code->scale order
> > - `{}` replaced by `{ }` (with space)
> > - Link to v3: https://lore.kernel.org/r/20250112-mainlining-mc3510c-v3-0-9ee6520ab69d@gmail.com
> > 
> > Changes in v2:
> > - Ordered commits
> > - Fixed comment style
> > - Ordered struct members
> > - Fixed device table
> > - MC5310C commit splitted
> > - Link to v1: https://lore.kernel.org/r/20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com
> > 
> > Changes in v3:
> > - Fixed patch (poped stash)
> > - Link to v2: https://lore.kernel.org/all/20250112-mainlining-mc3510c-v2-0-322804a545cf@gmail.com
> > 
> > ---
> > Vasiliy Doylov (5):
> >       dt-bindings: iio: accel: mc3230: document mc3510c
> >       iio: accel: mc3230: add mount matrix support
> >       iio: accel: mc3230: add OF match table
> >       iio: accel: mc3230: add multiple devices support
> >       iio: accel: mc3230: add mc3510c support
> > 
> >  .../devicetree/bindings/trivial-devices.yaml       |  2 +
> >  drivers/iio/accel/mc3230.c                         | 95 ++++++++++++++++++----
> >  2 files changed, 80 insertions(+), 17 deletions(-)
> > ---
> > base-commit: 2b88851f583d3c4e40bcd40cfe1965241ec229dd
> > change-id: 20250111-mainlining-mc3510c-564702fba487
> > 
> > Best regards,  
> 
> 


