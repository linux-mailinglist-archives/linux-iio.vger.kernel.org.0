Return-Path: <linux-iio+bounces-7727-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A959380E7
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 13:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206521F21F12
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 11:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92DA8563E;
	Sat, 20 Jul 2024 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aATXEkIM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D17B67D;
	Sat, 20 Jul 2024 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721473652; cv=none; b=TTBocsqUZq8sXBHLidLMHFhJZuxVIvg3SCLEeBbyAn/v7DDwKd5j8zkZlhNs7AIJh0SCUUZPbJQMsVv9i1o/sZYKoyfaShD1rEEmret26cnHSzilO1arTb9POJyvFklEy6E2AGFKNvpMtKLgarMupY9p2jw6kseYwZSDaxHx6y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721473652; c=relaxed/simple;
	bh=uD7N3KBc1Kuinu6g/SLPyxRwZfgdlcbRTpavEDKIDSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H76447nwfg5yUew2ugOU5PFl5pgYrmoQSSdciCB9303M0xCHAn+6oaaDuZcyrI3qr3LZ+PAnoXg9yV8aKLdJH2nnsn0GQ9pnOkLJ+prsKH+SgCyOG3XLIlwDwUC65a3VY5DGsahFs53G7eso4iC8THYRdVH5tsG8mZ1M3nL8o78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aATXEkIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32638C2BD10;
	Sat, 20 Jul 2024 11:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721473652;
	bh=uD7N3KBc1Kuinu6g/SLPyxRwZfgdlcbRTpavEDKIDSs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aATXEkIM0xf3q9n3VOJoiJltDziwoFY2lN62z3QKsfrYl62Ihh+vyfNynd9tpWNnR
	 MRENwJI8jsYGcP4k/EUYFp69iCcEIuG6CDfsIQILFD5QKs4A9Oxr6KCa8e2SqqpSAI
	 IYrQJnQAL9L0cevivyUJWBwELTY6QWrw9b4lVdNnNCHEm0byTfa+fezW3PQDHFpIJS
	 A72whciJPx0RtAFezAyAQwdHb2wjJBMF1dwo0k4delJOnB1Os7G5iuJx7JzacGrwHo
	 N2Mv0LH+mNbZarlDYj0yq1RLe0LUBPgYMjLe33ItF03RgqMvLskApVSbaUTybf6DMb
	 qNDwrHeOXkD8Q==
Date: Sat, 20 Jul 2024 12:07:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/10] iio: pressure: bmp280: Sort headers
 alphabetically
Message-ID: <20240720120721.0d0539b6@jic23-huawei>
In-Reply-To: <20240711211558.106327-4-vassilisamir@gmail.com>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
	<20240711211558.106327-4-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 23:15:51 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Sort headers in alphabetical order
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied.

