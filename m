Return-Path: <linux-iio+bounces-8211-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BB9946A4B
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 17:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F46281786
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 15:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2728315445E;
	Sat,  3 Aug 2024 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyEZKGg2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19191EA73;
	Sat,  3 Aug 2024 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722698024; cv=none; b=Uxi3p8944Ettuoj6VrztjF8c41PpwBvKioxL9Z1H4AXSfN8k06QoXxFgnrG0YGUt1Qp8qE2VZWYcsIqvE5thcHmIVRLAPJ2jlYcFY3uLEuVc9Zw/+oXHr2EV+BwkJV/W+FiTGJRf8iDyzkb9PShlyqJuFi20yiT7cE3y8CQTT2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722698024; c=relaxed/simple;
	bh=nm5cQkyRZVUeKzhFs1HWWxL1TF+UFk5CcqlIwj2tOzk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KbqWTXxjkev1D3TSWZovPXepCTzyUzyrwKjGP5QIJrQkiMA72Z4HO69uirpt6sPeJpci1mj3lFOArLo1w+TeAmVKOdKVowLKK4pMn93nf6gTXfgfcoTC4QDyxGEEw7SLOf+vIiE0RLe7b8HV2zdhPcMYd945RNRVVGrl3XvLqyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyEZKGg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBDCC116B1;
	Sat,  3 Aug 2024 15:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722698024;
	bh=nm5cQkyRZVUeKzhFs1HWWxL1TF+UFk5CcqlIwj2tOzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LyEZKGg23ciGyzuv/ViKG+lhWMW0xwIy+G/9YszNWN3e3/W/F4jOsZNhDatR5x1kn
	 ctW9Vi0ZMl2+YjV3zUNuubkOpwElaMOFANLliZLNOFNhuwLOGmeOD93jIqe5nsGJb8
	 IMxuesWYW/edUDdKv/9t/5yxJrScQpKovDeqkA+TKbenoLSGpnk0BNhQmeVqnBxpMV
	 PdxJyYI/76lqYrHQbzUp7cNKeXTGWf0WSjl1+22W4Z3oF5teO7s7bZVOu9QS0bLiUT
	 nzrPQ8Wyo+nm2XgsNr3NoPQA5L+R08HaDufq2qIx9Qo0pQ7suvWAXypfk9SE/t+MMo
	 stzuZoyndklPA==
Date: Sat, 3 Aug 2024 16:13:34 +0100
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
Message-ID: <20240803161334.5e627178@jic23-huawei>
In-Reply-To: <20240730084640.1307938-1-olivier.moysan@foss.st.com>
References: <20240730084640.1307938-1-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 10:46:30 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> The aim of this serie is to add scaling support to STM32 DFSDM
> peripheral in the analog context.
> 
All looks good to me.  I'll leave it a little longer though as
some of the dt-bindings patches don't have tags from the maintainers yet.

Jonathan

