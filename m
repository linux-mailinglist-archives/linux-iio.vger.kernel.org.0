Return-Path: <linux-iio+bounces-14811-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E823CA24928
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 13:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1711882DCC
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 12:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CF91ADC76;
	Sat,  1 Feb 2025 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fta73RwZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E07C10E0;
	Sat,  1 Feb 2025 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738414409; cv=none; b=OimxbAAp7ususJ3hPyDmFaq/AsWmRK2H0UNOw6dvt9IgjYnf+KiozPm0q+UH94BenxiikYvn/mz9sob9izGigfxeawvckBPXIND4u8RoiPCwcOS6oUG8pVsm2/jW35M6UCYnxzLEpeceoQOq6SDgGHu8akt5IFJOeUKk5nuFEOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738414409; c=relaxed/simple;
	bh=UlXlR9Nv9rAHTE8B8SLPx7a4dgN5Xrsk3AQ4atBfvOY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOYb6vzTLDCh0JoO25xrxu6b+G1JLYEPdq0+GI4nS1FR5WnGqK3QnSJzNRgyENH/npnol0T7DABP8ve+w7OOpRAwYCiPw99nJiPKbM7IhZqQ6yvNdgILpaSkhX5GjsOC7NswKQAm6hDgFFIYHSXDdDsTcBVszESNdw1NUI9MMQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fta73RwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD69C4CED3;
	Sat,  1 Feb 2025 12:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738414408;
	bh=UlXlR9Nv9rAHTE8B8SLPx7a4dgN5Xrsk3AQ4atBfvOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fta73RwZiDqwVCJiawPUaiHkhkUbjdzSopvXZJdGtkX68pUCSfhjXJRTvNznrkR6l
	 EpDrxcbMwTHH+OSbKOyTBqacY5YUrgICfDJ7vdBkQo3mthfuj4ltT5Ho0NVqLNvkyJ
	 QOL0voKc1L4wZsWHmBVuI+eSK++U2KYQ2R866w6I68tvzVrTMRjOsLixxdv4xrcoj1
	 S0RTb8DjkZxuL88pPvxv/ffMEh1bY9LnCXCe6Do/siJjCyNKraOtI4Ios/mbB7ckMO
	 /7Cpa+mHl4WpPeP6LJwBUs36IY+c/wKzBgyXOO+AlIVns78F7OxTyUM+59HJgGzLiF
	 x44cRd/4z+eag==
Date: Sat, 1 Feb 2025 12:53:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Alexandru Ardelean <aardelean@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Guillaume Stols
 <gstols@baylibre.com>
Subject: Re: [PATCH v3 08/10] iio: adc: ad7606: change r/w_register
 signature
Message-ID: <20250201125317.1de8d599@jic23-huawei>
In-Reply-To: <2f604280-f4dd-494f-9f54-83e8f613b64f@baylibre.com>
References: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
	<20250129-wip-bl-ad7606_add_backend_sw_mode-v3-8-c3aec77c0ab7@baylibre.com>
	<2f604280-f4dd-494f-9f54-83e8f613b64f@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jan 2025 15:31:18 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/29/25 5:03 AM, Angelo Dureghello wrote:
> > From: Guillaume Stols <gstols@baylibre.com>
> > 
> > The register read/write with IIO backend will require to claim the
> > direct mode, and doing so requires passing the corresponding iio_dev
> > structure.
> > So we need to modify the function signature to pass the iio_dev
> > structure.
> > 
> > Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> > ---  
> I don't think calling iio_device_claim_direct_mode() inside there reg_read/write
> functions is the right place to do that. It should be done at a higher level (in
> case we need to combine multiple reads/writes in an atomic operation). So I
> think we should drop this patch.
> 

I think this is a tricky corner if it is only needed when the backend is
involved. Not sure what the best answer is as we probably don't want the
higher levels having to comprehend that it is sometimes needed and sometimes
not.  Maybe fine to add it in all cases, but that sounds like it risks an
ABI change.

Jonathan

