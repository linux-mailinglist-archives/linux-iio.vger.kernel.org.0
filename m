Return-Path: <linux-iio+bounces-8291-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 481279495AF
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 18:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF521F22407
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 16:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AED40855;
	Tue,  6 Aug 2024 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L49ZGAD6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C982C697;
	Tue,  6 Aug 2024 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722962392; cv=none; b=JDiI7y4rb45FAkejBTrQ2q2eXemSIgvV5yf1UvN79mH5PuLKZwGfFXll3arkQS2rd/0LLGGWNi1BzS18lPASYrGm8qpcK95juZER0Z53RmU1WUKzqqU812w9+t2V8567+K1dDAVEdLY16i0/0hK4fylMkXObHGcl6QotNNta26Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722962392; c=relaxed/simple;
	bh=I9H7A7FupsbFLzyt6LiuEeDW4TvHpRMJlvPZymABxTI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqUNafP7J8puJ/9nyfVi9VCA5LnZNF9gvopAqkLOwuVJA0nHc+4N94Lmscd9F6FdcRxKPnGGGmzvvJBYayf54zYlYj82qyzZHdn9D2fQd21zDCdxXSiUTMib18gwokYY4o3IV3FpzGT0vf+Lo8OPGLNK75L4AscnemFf6deWo3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L49ZGAD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF5EC32786;
	Tue,  6 Aug 2024 16:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722962392;
	bh=I9H7A7FupsbFLzyt6LiuEeDW4TvHpRMJlvPZymABxTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L49ZGAD63IjjcOZfz6f+kmlxItx4dH5ZlZmPRi1pQrD4SFDcuw0rMcQykXH1HlpPX
	 LIO+dBTHM5yhS25UTAHWoIBzXC2v7/POfhHmLo3Ob0JO4fbAisiNfeeh6BpZoFwjDl
	 8aEsKq3GWz5ioLnQquf1Z6qyBtfakQD9gSeN+4oYJKZ4Y+M4nVCfujcp2TCR6zPjqq
	 lAw2PkfFOpB+bYYXHJ6gDxEiC/mrnWCTLfF0gMJno61RMJKquADdswx4rTHbiuTixk
	 Uiwly4lKczYfXmp0KXmHaEEg+fRKaWJrM3eWrFBjnbkUMlqO4N1ekG9V0zpjXI6y8+
	 AjfLwz8L9W4FQ==
Date: Tue, 6 Aug 2024 17:39:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: <fabrice.gasnier@foss.st.com>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Arnaud Pouliquen
 <arnaud.pouliquen@foss.st.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Nuno Sa <nuno.sa@analog.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 0/9] iio: adc: dfsdm: add scaling support
Message-ID: <20240806173941.074d37ee@jic23-huawei>
In-Reply-To: <20240803161334.5e627178@jic23-huawei>
References: <20240730084640.1307938-1-olivier.moysan@foss.st.com>
	<20240803161334.5e627178@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 3 Aug 2024 16:13:34 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 30 Jul 2024 10:46:30 +0200
> Olivier Moysan <olivier.moysan@foss.st.com> wrote:
> 
> > The aim of this serie is to add scaling support to STM32 DFSDM
> > peripheral in the analog context.
> >   
> All looks good to me.  I'll leave it a little longer though as
> some of the dt-bindings patches don't have tags from the maintainers yet.
> 
> Jonathan
> 

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to poke at it etc.

Thanks,

Jonathan

