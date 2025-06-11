Return-Path: <linux-iio+bounces-20467-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6E6AD5C6F
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 18:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1258E1886EE4
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 16:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C771FBC90;
	Wed, 11 Jun 2025 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E93oMAjL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F919C556;
	Wed, 11 Jun 2025 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659850; cv=none; b=WMW0QapOc9Q5p5xV9rCT2YkUbaOLg7s1VqF4cwR5UhUs1xg0pse0p9+fzeSlql8dICmOUP78FyzLSrIqrx1Hj4vigfkYzL4nyhvT07i6dMivI4taA0mnRAw/s5nTk09SeFbumrZuFShpx/XvfF3Sj0amcnPn3riGsmZuJuq2234=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659850; c=relaxed/simple;
	bh=8f17JNCbmwhQzy5mD6f+45j2FzwIQnJv0xmMlafqAEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhhSQuWQmx6zasWiZUFrOP3FZ3Rl1I7p6IJMfjU8MONyt5ly4PMZpg1GujAVb9LKcCsnQUr1TDdVaLtR3RYo3J/2ODa8Ny6GIu3OAuTQz7EYJJSTagGeWHumYhwaDqdwgjK14ahz0GcxiX2uc6+jHB4EAhNb3SSGv4ST5Y5QRpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E93oMAjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA57FC4CEE3;
	Wed, 11 Jun 2025 16:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749659850;
	bh=8f17JNCbmwhQzy5mD6f+45j2FzwIQnJv0xmMlafqAEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E93oMAjLUPLSwW/zg0PztdZ7pXCSfwsLe9jNH0prZN9k4mHzriJxiuTnLEoUSUJ9Y
	 ycRzveSJshLaFIP+pC5gjH6ibNnVfyl9DoNz/n/rGl5EHmO8aY/tgzRHD0Afhb/Pkc
	 pZyRMPmOrK1o73d3S7vW9xPzekTYYAzR+E9YuTAEBe0rCmqXVDssRvJn0R1sE3rxSG
	 AF6X0370JwFK8uGCzzYJfMjev3Y7rAnaDD3rIcnbH1re9Z71jy1Nb7Kx70QTOeu40U
	 YQfEY8hqzDIRh6hKqYujacFnrn5Sx835DZL2FASOyPk7HhA/gk2j8+muKZKMed4Pd5
	 7Xx3A6Qjhwvtw==
Date: Wed, 11 Jun 2025 17:37:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Antonio Borneo <antonio.borneo@foss.st.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andy Shevchenko <andy@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, "Lee Jones" <lee@kernel.org>,
 <linux-iio@vger.kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH 4/5] iio: trigger: stm32-lptimer: Fix build warnings
 about export.h
Message-ID: <20250611173722.1f78b841@jic23-huawei>
In-Reply-To: <ccde5e45-9541-499f-b248-08cd6fad9a19@foss.st.com>
References: <20250610124855.269158-1-antonio.borneo@foss.st.com>
	<20250610124855.269158-5-antonio.borneo@foss.st.com>
	<ccde5e45-9541-499f-b248-08cd6fad9a19@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 15:05:50 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> On 6/10/25 14:48, Antonio Borneo wrote:
> > After commit a934a57a42f6 ("scripts/misc-check: check missing #include
> > <linux/export.h> when W=1") and commit 7d95680d64ac ("scripts/misc-check:
> > check unnecessary #include <linux/export.h> when W=1") we get the build
> > warning with W=1:
> > 
> > drivers/iio/trigger/stm32-lptimer-trigger.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> > 
> > Fix it.
> > 
> > Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>  
> 
> Hi Antonio,
> 
> You can add my:
> Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> 
Applied.

> Thanks,
> Fabrice
> 
> > ---
> >  drivers/iio/trigger/stm32-lptimer-trigger.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/trigger/stm32-lptimer-trigger.c b/drivers/iio/trigger/stm32-lptimer-trigger.c
> > index 2505ace440b46..c7bab18221c70 100644
> > --- a/drivers/iio/trigger/stm32-lptimer-trigger.c
> > +++ b/drivers/iio/trigger/stm32-lptimer-trigger.c
> > @@ -9,6 +9,7 @@
> >   * Inspired by Benjamin Gaignard's stm32-timer-trigger driver
> >   */
> >  
> > +#include <linux/export.h>
> >  #include <linux/iio/timer/stm32-lptim-trigger.h>
> >  #include <linux/mfd/stm32-lptimer.h>
> >  #include <linux/mod_devicetable.h>  


