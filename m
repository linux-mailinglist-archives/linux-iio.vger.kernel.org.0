Return-Path: <linux-iio+bounces-22501-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF04B1F603
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 21:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A028625313
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 19:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8821EB5DB;
	Sat,  9 Aug 2025 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrWf3yF1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A04CE56A;
	Sat,  9 Aug 2025 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754768043; cv=none; b=cJ9EEMgHuDSKJ7ju/ljIEy2RQGTXR0hiQ2RKc8kxI02fAYOM1z+RUy9XL46zCx0eeAGqWhezwGIqdzj0QSOlDrXkUzjWR9H3UICTkDbw8zHk2MLoCaHm3ylofKHWHqVKVHdfdNtAybmpoW2a7W0+4IABswj9Dj73UbwQfMVyUy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754768043; c=relaxed/simple;
	bh=88YMXc/fmtHJGa5noRnDb7Y/UNMxP3j8eimnCnCiCno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChD7F23478zyfIrMyLe3xk2R0kPwKt/0PsWetbmbxVw7NcT/FM1EQm7dyERn7Ywx84sJS+JnO7zMwctaqvwAndHuDvYG+FhxfLjKh1ukdeMoLo/aeP4pVCF02e5evu9HjFlMvYRUTlOjJgi5Mjh3n08EnH5kFX+q2JN73NXRc4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrWf3yF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90491C4CEE7;
	Sat,  9 Aug 2025 19:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754768042;
	bh=88YMXc/fmtHJGa5noRnDb7Y/UNMxP3j8eimnCnCiCno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QrWf3yF1GKBOclz7PQIxqtMbn14h7L1yOa6UcM1g6T1HJOR7OJbahUiVeLTSt3A7p
	 s5beg4N5YcP8mIwI1C3GRyT6vUcJvPJ+9cqo2LLoJMIAmlnmhJ4LQYI3RqGE+/U9mS
	 9oscgrpJim8D4lTCU9A2+9zjnNtI3U++Y8kSbZPp6QZX+i1bv532lcRCbA3ROd2mi+
	 uwyPU7n7GG8lt18Y/CYp1+847D0/XbTuOkqCidmS8ZGnOTwEHhrGkxSgO3BhQ0eyLl
	 67WQqLU/SBFnpZafr9z4p75JQOP77r0sTa2kkrBbwb6iNNlJQV2wXZMVocJtaEslV8
	 JP0Ic/GfyHHiQ==
Date: Sat, 9 Aug 2025 20:33:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Stefano Manni <stefano.manni@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: adc: ad799x: reference voltage capability
Message-ID: <20250809203353.3bfec812@jic23-huawei>
In-Reply-To: <aef22644-2869-4888-8fc6-f14859917dcd@baylibre.com>
References: <20250807074850.130831-1-stefano.manni@gmail.com>
	<aef22644-2869-4888-8fc6-f14859917dcd@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Aug 2025 10:47:29 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/7/25 2:48 AM, Stefano Manni wrote:
> > This patch series refactors 6b104e7895ab16b9b7f466c5f2ca282b87f661e8
> > in order to add the capability of the chip to have an
> > external reference voltage into the chip_info struct.
> > And so avoid ugly conditional checks on the chip id.
> > 
> > In addition the AD7994 is marked to have the external
> > reference voltage as well.
> > 
> > Changes in v2 compared to v1 [1]:
> > * remove has_vref from the chips that do not support it,
> >   rely on the default false value
> > * remove useless message "Supplied reference not supported"
> >   shown for all the chips with has_vref = false
> > * refactor check on regulator being err or zero
> > * add external reference to ad7994 as oneliner
> > 
> > [1] https://lore.kernel.org/linux-iio/20250806090158.117628-1-stefano.manni@gmail.com/
> > 
> > Stefano Manni (2):
> >   iio: adc: ad799x: add reference voltage capability to chip_info
> >   iio: adc: ad799x: add reference voltage to ad7994
> > 
> >  drivers/iio/adc/ad799x.c | 30 +++++++++++++-----------------
> >  1 file changed, 13 insertions(+), 17 deletions(-)
> >   
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
Applied to the testing branch of iio.git.  I'll rebase on rc1 once
it's available.

thanks,

Jonathan


