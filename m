Return-Path: <linux-iio+bounces-3568-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD4587DB54
	for <lists+linux-iio@lfdr.de>; Sat, 16 Mar 2024 20:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D63A1C20905
	for <lists+linux-iio@lfdr.de>; Sat, 16 Mar 2024 19:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437FA1BDCE;
	Sat, 16 Mar 2024 19:39:20 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7825918039
	for <linux-iio@vger.kernel.org>; Sat, 16 Mar 2024 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710617960; cv=none; b=mFAIGTzFrRqlqSgHgWlS0cig2RNvHUNXTeCfPn0mbL+h1bbrK6OExdwpvmBZ69GWAv5hGCbk7MWHYcsdZyGX2G6gHZX2aJMBHGEex0oPKFQM+B1eC3SJTkyhx7IAhpANWK6swBU5eUTUL0wFd0O9NVxnXOlGUcdj7WD7wr5A8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710617960; c=relaxed/simple;
	bh=Di5IshrrmzAVEAcv+fTXsAsHKLFT1BOi+zJUFOsCn0o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sm0979A7ASo4ymnKOjcvFNeb5AV9Uuu6g5e6DkqjGzMpRF79pP0IVFxVQboI0jxFSZpmFmNxVRLNQxSIMbHjmP1qggiyO41x31K4f5et4EsuNeA5mhq1FoTM5gfSSueX4WgIj3SF7j2gFx4kfn6myM2ef5hM0IMV3gXIfWIlYt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id dedfc795-e3cc-11ee-b972-005056bdfda7;
	Sat, 16 Mar 2024 21:39:15 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 16 Mar 2024 21:39:14 +0200
To: Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 2/4] iio: trigger: move to the cleanup.h magic
Message-ID: <ZfX1Yv456gRr0RU4@surfacebook.localdomain>
References: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
 <20240229-iio-use-cleanup-magic-v3-2-c3d34889ae3c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229-iio-use-cleanup-magic-v3-2-c3d34889ae3c@analog.com>

Thu, Feb 29, 2024 at 04:10:26PM +0100, Nuno Sa kirjoitti:
> Use the new cleanup magic for handling mutexes in IIO. This allows us to
> greatly simplify some code paths.

...

>  static void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
>  {
> -	mutex_lock(&trig->pool_lock);
> +	guard(mutex)(&trig->pool_lock);
>  	clear_bit(irq - trig->subirq_base, trig->pool);

Another side note: Why do we need atomic bit operation(s)?

> -	mutex_unlock(&trig->pool_lock);
>  }

-- 
With Best Regards,
Andy Shevchenko



