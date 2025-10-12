Return-Path: <linux-iio+bounces-24949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0E2BD030C
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 16:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1F13BCC77
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 14:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815492773CD;
	Sun, 12 Oct 2025 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CembTxgk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA5427702B;
	Sun, 12 Oct 2025 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760277871; cv=none; b=n0UGMIPUJxzLXnRCloCo2O9WoNQHnt0dLWein/YDrGAH3Nmm8h88+1dadROVc395SzcNeObKVe+bjrej21mXiFvUHKO0xhk1Qv+b6QKcIOaIVWxa4ArRUOxYnic5wEvye2/rnQfu+oW5OXay0BsWaVyRrwDGnSp3Y6Amkiap0YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760277871; c=relaxed/simple;
	bh=fwvtWQqMT6I8OAsCjr3UAX6a9R64+xRdDIeBiRAe+LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TR9IXlAgsbCCCUd/ppRuHpT25yKl/lbRmyvDE/qOxeKRZ5LpzUIgivusfazqWJvaTb44tEFjuRb87jPTaUevm+r5Hu6hSbOPcKXrXl3ZRUiRZwO1OfohGZoouedeCDqzIyTBx8W3yzoWEFNy3UvVb3UD4EYRaQhbGuoe+ZbEu68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CembTxgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F37C4CEE7;
	Sun, 12 Oct 2025 14:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760277871;
	bh=fwvtWQqMT6I8OAsCjr3UAX6a9R64+xRdDIeBiRAe+LQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CembTxgkcpFp+DMs6SRkHJwGazCzF2vl0CVmTXIjiO1uOhwV4mYvnLLUY7Hm7+yyy
	 E2Q+/ucTauEO/S502MKIIDvB45U+ydpd8hNwzuzyFCcWReyFS4+k9WBMKN/BsSb/oX
	 f5T4QbUcI4vhWi4EvbSAgqSNwyk7st2Pn1inligVlkqQ6ZpF2MgpF7jnZhvzRy5OHW
	 YTTKUAXOt+tkUEez4kj82QUpXu6hHTqg8YANksT2wxDEtG1Ep0WwvqMJRNk2OCIuzv
	 eZ4Fw8isegbHYNYzQL/qsSE/xtCKJKhoILpluSDWJo2c6FyGpkERRaXdARUw6wv3sd
	 N1KIBQm+0XH+w==
Date: Sun, 12 Oct 2025 15:04:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: dan@dlrobertson.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] iio: accel: bma400: Use macros for generic event
 configuration values
Message-ID: <20251012150426.52605ea8@jic23-huawei>
In-Reply-To: <CAE3SzaTaq7QFoRZMTd33e__ORsHiCMqBK0joVEdSt2YnEfhkSw@mail.gmail.com>
References: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
	<20251002184120.495193-3-akshayaj.lkd@gmail.com>
	<20251004135829.531a03e1@jic23-huawei>
	<CAE3SzaTaq7QFoRZMTd33e__ORsHiCMqBK0joVEdSt2YnEfhkSw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > +enum bma400_genintr_acceleval_axescomb {
> > > +     BMA400_EVAL_X_OR_Y_OR_Z,
> > > +     BMA400_EVAL_X_AND_Y_AND_Z,  
> >
> > An enum for potential field values only makes sense if you are going to
> > use it as a type somewhere.  If not it is simpler to just
> > use a define next to the mask for the field.  Also these should be named
> > with prefixes that align with that mask.
> > If you do use it as a type in future patches that's fine but the naming
> > point still remains and you should specify values = 0, = 1 etc
> > as they matter whereas implication of using an enum is that the actual
> > values assigned doesn't matter.
> >
> > Same applies to the other enums introduced in here.  
> Assigned explicit values to enums in v4 patch series.
> 
Hi Akshay,

Trivial process thing.  This email doesn't need to exist. Just
have the change called out in the change log for v4.  That way it
saves a bit of time for everyone.

Thanks,

Jonathan

> Thanks,
> Akshay.


