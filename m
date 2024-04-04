Return-Path: <linux-iio+bounces-4059-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D4889861A
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 13:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBEB0B2158D
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 11:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B1B82D90;
	Thu,  4 Apr 2024 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GlrmqixO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C782C189
	for <linux-iio@vger.kernel.org>; Thu,  4 Apr 2024 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230591; cv=none; b=LtvUEX08dQSfRWsdCKSDiMMAQMZp+vUhkpxNIc28j9hdfrIDZ5FFGsXEvuJ2hykacofoXY8yaYNXHgwFk9bNqCiD0Ut1ESUMGpWIAErWgbD93zJ8fh3D+mjtsXJD5pr+B5LUqNATE1TfRG5eBeRLTY/W/exWMgjz2tIeFP1iylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230591; c=relaxed/simple;
	bh=KGuMIBcsl9wI2ckRU01PqRppnGK8iigFdGIoEim9GtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVFaJxx+zPOIx+Ngm7j5kdxH7gGP9GelsJKnzJ6KxuwwQUNDLfF96pTXfnDNq72LumgZqdhmvYLCxmevi/3Bej2Tzp+nsNEvnyrHxwgOjJwS5kWtKhSWBpajJnq4lifyOP/hLZ/0w9IP8qlPCg/qVFBJjyrzZv5JQtxBMoZ+SP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GlrmqixO; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6098a20ab22so8008747b3.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Apr 2024 04:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712230588; x=1712835388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGuMIBcsl9wI2ckRU01PqRppnGK8iigFdGIoEim9GtA=;
        b=GlrmqixOJ2xYymcP7b2c/7PHLqhU7vEuhp0P9nPGqI2iwpxwBm0RwJU2d9+guRqlEl
         +5mEVEfoKOOFTHZwR8aiHUu3pv6HC8mkUC4YTwMo7fOG5mtwAuA+gr4VWcMAySReqFXj
         HsO1mFH4TH+95ggHmzrlK5QH0dsxBgJX7qlz3xDsHXcoURs+GJGHqszwnBidsu9l4yaO
         QcqIXqb9ALfLARQ058JlSzPlrbkipiuufLMXrZaCUDkyUONYdbTzHuoM+O94AauT1epr
         6TMtcf5JgSt+hBsL+zDoh3BvLzIxMx+zGdqaORyqaBru10gaFbaeamAv3Ott51kDIiGZ
         UYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712230588; x=1712835388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGuMIBcsl9wI2ckRU01PqRppnGK8iigFdGIoEim9GtA=;
        b=g8VUW7XtG11onJWdixsGACVoqly/f/txHkpgI1QhxmPhXdWupOqCLWaQSZA2GSDSDY
         TvZ1urOHp9hxiNFpo7ycf+vFEjROKdRtZOkQ6MDdqp67OWSpdIlvnoTn5BcnDqOvYMnM
         mSJX5PYxvZUxZowf3CSWVmiQQvbA5qhfG59gM7wyDpM0ItOj0iVshM+CuTqSaihYYpsH
         jrNpm+VSZ87WMIfxYWHpy/iUOdNDC2ZrhE054TTybI6N2Vuw7SgduK1gqOwhvmUJ7+iH
         34aDfMxlxcyoKuyKZf7rU2sMiSbPXXed8z/cckyKucOOXwmuY01omLXxYIGU5beaA1Bp
         egSg==
X-Gm-Message-State: AOJu0YzfRe1YPHOdL/77gV9Wy1/MROvRePYnqmvcBmCWicahbtcgGilI
	mbCFVnJrROobaIBPvqnh46HNRvJZxn8QnO3Sq2R8J8naSMYlfeEAMcDVC1mZ3wsx4CI3ms+x5K2
	1+rDiIIkgxHJOFygLmkMFRcgCIS47DBOslpbmgQ==
X-Google-Smtp-Source: AGHT+IHwArJ8DHmfqo+yV77gb4IAZGRTl0grfOa3+ickb8v70OYh02BrzVgORlVFCGo/fThRJLRvfyY9x8UofQf5RRU=
X-Received: by 2002:a05:6902:102e:b0:dc6:db0c:4ff0 with SMTP id
 x14-20020a056902102e00b00dc6db0c4ff0mr2551970ybt.32.1712230588301; Thu, 04
 Apr 2024 04:36:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330190849.1321065-1-jic23@kernel.org> <20240330190849.1321065-2-jic23@kernel.org>
In-Reply-To: <20240330190849.1321065-2-jic23@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Apr 2024 13:36:15 +0200
Message-ID: <CACRpkdZzOi5vv6yxqheqGZAZYBLTEL-uB=dt-i6ByDEhF6H0Kw@mail.gmail.com>
Subject: Re: [PATCH 1/8] iio: adc: ab8500-gpadc: Allow COMPILE_TEST builds
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Marius Cristea <marius.cristea@microchip.com>, 
	Mihail Chindris <mihail.chindris@analog.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
	Kim Seer Paller <kimseer.paller@analog.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
	Cosmin Tanislav <demonsingur@gmail.com>, Nuno Sa <nuno.sa@analog.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 8:09=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The dependencies on various ab8500 components prevent this driver
> being useful but they don't seem to prevent it being built.
> Improve build coverage by allowing COMPILE_TEST.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

...but I think AB8500_CORE is a hard requirement because
<linux/mfd/abx500.h> does not provide register accessor stubs?

Yours,
Linus Walleij

