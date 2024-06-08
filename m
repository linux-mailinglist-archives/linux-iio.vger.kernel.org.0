Return-Path: <linux-iio+bounces-6041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DD8900F7B
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 06:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E91282D9C
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 04:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48EFFC0C;
	Sat,  8 Jun 2024 04:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzjQC/6H"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4E529B0;
	Sat,  8 Jun 2024 04:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717820824; cv=none; b=VtiXnwaoHvR8drUX0NlPNa+ufO7kMwRTQekXHzhhDOHa2DcORcGUEC7DdY3TKHkZQpwwOXbcuWZIXzkU8kHkQk2UflI4QiLCAvaLidNlRN1n8boiINvF5fH1whNiSQZSe3Zbalf/ClUtG+xLD+Hi+6mIjNqsxUVhApSUGUgA36U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717820824; c=relaxed/simple;
	bh=1jRsL3xuhZrL8aYetyp6Vw/OKHguTJHhqUQIIYOKz70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGQm/tuF63HGm6lBugyojsTehXm1IUBUP5iKx/aTGSyoVDTrHJH8UvzeqJFQCDsKvDFTbse9U3hbVxTe5M1SEai/G/Z1oSYJTiGvGaNsJD1Aiib00G/+cGwZbfUa3/nL0nqGpMKHqCfXQ0XrGgUluG6ZzCX2eyyGirWyxeY5Hw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzjQC/6H; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7041ed475acso568971b3a.2;
        Fri, 07 Jun 2024 21:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717820822; x=1718425622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s4+HeshVfzmG+iW9H1/f8wK6R+jL7lVVatFTYBjS0gs=;
        b=IzjQC/6HS8MKZ8YT1y0wBy0ZUBUD7WKFJXk1TT9KE0wvaQPiQcsDYnELof4sumFjmu
         5x4X4C301GWH+7HILfu+nCCsyZbwWdGHe3fgZuo9aRLEvPmGZyEUec9gbH0ABSOhSSP3
         ev4/n+y5ezucBgPCrNgHvg43bsbYSb1ZgvHoJEMBJONeMNziPLb75inaxlMjHGmf53OP
         lKq1fWZtKtpKItcsRnKibczMyrRlBp0eDcLiKXvPekxXhDuAbZ2c16ZsK+wZvztaZ3J0
         mPbQfrXGVdTgslWejdw9NP/kWBdf0+0PgTfU/VVPhcFdFM8OdZYKAZGG1OWFi4qmVmj1
         QNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717820822; x=1718425622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4+HeshVfzmG+iW9H1/f8wK6R+jL7lVVatFTYBjS0gs=;
        b=qSncIV7QK55ingQnK753H+DpcHMFrogJwNpPLXtMFuJpgISOc0WcOHms81XG/JyENA
         szhFtpzZgRTpeWv86pPExqLqJOeGPNOyCRC30wUC7BG6GXKPnIhNPrMhwWbqYXmb9jQ0
         Evz+6sjXQlzfFFhOLwhxmTOo+qXl27MTrBN7aRsFQzUIZT96mj9g9m8Hhjbl87MNdgxR
         z9y8hJuK+gaDSuX4VGBAGC0ft955fUVxSalpyzZOI+VN/CRjMHXD1qBkxu8ytU+kioTD
         q01sxNvnuCjok54LBlYVjfZh2P61VJbXh+EG3Ntbh4ATVB8ZZGLfyi58azBXBapmmW1J
         Gs3g==
X-Forwarded-Encrypted: i=1; AJvYcCUpTXAU7bTaQqGQ/hQdGMC1eVD513xIqQnl60jJKHzNc1fB2Hdxi7zMk5FGx554iQy4VEZptkf4gUfvvQKJXT+zbuaJlKv0HlP4yNK+pT+QJoWUGwIHEdWlGHrizTLKKcHs1KtozCwQ
X-Gm-Message-State: AOJu0YwVOCbMp3RMb4Pz2PZZNjGMMffyq+uFQqy8ZUVqDSzHrA8aIM/K
	ZDhPP77ll6aElnV9Kd0jc2o2Ve1tK2vauZly2MdBVcG5pB2Bg1VV
X-Google-Smtp-Source: AGHT+IEIDfUDRHNt8EK9CBGUlqcVUPLqkc5DfNBs6hIbh8wEI4Bh0roI5mlggd/E8uy01Ns4ZcagXg==
X-Received: by 2002:a05:6a20:5513:b0:1af:cbd3:ab4c with SMTP id adf61e73a8af0-1b2f9acbecfmr4022146637.35.1717820821918;
        Fri, 07 Jun 2024 21:27:01 -0700 (PDT)
Received: from localhost ([2804:30c:96b:f700:cc1d:c0ae:96c9:c934])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c29c22060bsm4529116a91.17.2024.06.07.21.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 21:27:00 -0700 (PDT)
Date: Sat, 8 Jun 2024 01:28:14 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: adc: ad7292: use
 devm_regulator_get_enable_read_voltage
Message-ID: <ZmPd3pdpSiJ1a2qo@debian-BULLSEYE-live-builder-AMD64>
References: <20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
 <20240531-iio-adc-ref-supply-refactor-v1-3-4b313c0615ad@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531-iio-adc-ref-supply-refactor-v1-3-4b313c0615ad@baylibre.com>

LGTM

Thanks,
Marcelo

On 05/31, David Lechner wrote:
> This makes use of the new devm_regulator_get_enable_read_voltage()
> function to reduce boilerplate code.
> 
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ad7292.c | 40 ++++++++++------------------------------
>  1 file changed, 10 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
> index 6aadd14f459d..aad4b782a3d2 100644
> --- a/drivers/iio/adc/ad7292.c
> +++ b/drivers/iio/adc/ad7292.c

