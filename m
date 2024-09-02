Return-Path: <linux-iio+bounces-8957-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB259682D7
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE261F221BA
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 09:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A253186E5D;
	Mon,  2 Sep 2024 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvoLSr2h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3201976035
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 09:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268446; cv=none; b=VAmcf0E6GMG7UIvlYnv7MQTisnx72w89Iy8PT6kytUpke4lIcBN4Cic+Y/lZAwvXOwOKI1WR9vkwNP9Xc9OeRZdeSUJfOIhdrLjIqL/dyxUvjN8u7RdtomfdOxeQze+x5xWJY1JEKa/n+LUAXDvhUKZk0kIt/rnsJJQR4ULyk7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268446; c=relaxed/simple;
	bh=5e/6LMsJW4trgU5HcJOqnjBi1cFqQqTMk+I1u/D/7/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0GV3vYta3ZWMxi0mKFhoo3KZ5EVwavkkSDMixLGnPP9l0twGLqtHpmFP49KekW8W1l/HBIwnZsrX1A9nBLWl6ECgC+r3BQ654VrVHKByciMZTFgvg4T5J4fCrhBIlJBH4C/5ot73WLFYDW45F3ed3/bwyg4uK2t7EXMp4oN7sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dvoLSr2h; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5334c4d6829so4968458e87.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Sep 2024 02:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725268443; x=1725873243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5e/6LMsJW4trgU5HcJOqnjBi1cFqQqTMk+I1u/D/7/o=;
        b=dvoLSr2h9Jw2H9MMW/LVQeorWstviTa9HOYgLmdIY4IXmTzOmFkQ6OpJ4IkXGEjHYN
         Spnuk/ZTX0ONZWrDFky7CGtB7mLUHqRPEaJ4llHd6b8oQNhbeNjCybEud+hBlBbyf64i
         UkTgWErmapmDmryNrmZhZ2OQSy+QMuVH8ajQzO3TBDZYXne1UKQveiYDhnoJ/j+e+KVU
         43FmnUadAA1Dvt3qQFG9DbTvYSfRRV/K6/D6JSnC/7mad/DldkFB574n3xQCKwOq1SxM
         6mb5yh0DFfl49vcuPAzXTme9izuXcvOjbSK8VF2+aQEOsM9kHKOj6EMESSRCZ2331Ot4
         p3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725268443; x=1725873243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5e/6LMsJW4trgU5HcJOqnjBi1cFqQqTMk+I1u/D/7/o=;
        b=IrHpZ4bdjsyqvIsaeRenh2XO45zF54Irb4oRzt5y+Wv2Syg9NvP41U03J3cZ9BZHsn
         6bMfCFCDzP6MsEyIEsoAxHjxqqPjMh+Ax7T064ihgH1xB4W220F36h8XMmjCG3piX92H
         n5wrYJNLT/Sn5v6hyc238EvAwrSUYM8I54OOm1PjHZMD+VAs7mxUoGSPn7n5fJHkV+Bk
         OyF+pGp1k4c3dbw1Ky2MPm6h1K6cQvHw5yFBQf0z6p+mIdMeihtu7GxS1Vj4vCF+MRej
         Ax0dAPJ/Kp/2D8x4C/CoPyfCGgm/j5ewRoWF6GZD4W+qhIOn433YLzjBGYom/pgdcsKA
         L7tA==
X-Gm-Message-State: AOJu0Yz2I8VvFktLFbCkCnVgp3vIHWbHCyvbQiJCBsA0uc2SrcPOveYr
	m1AX+DRFWoSMi4VOwAjwKGtj4IGtcpV+thpXl994lT84ov0HVS9X4Oz5vYzQBueS6DdhviA9A53
	pnCTe2c8+A3QtxCBy2kN1l5pK7EcFLh7XlXJsLQ==
X-Google-Smtp-Source: AGHT+IELPfKWHgCrsUEfq215WcwRaDRvA/Y82xjPQ9I0VtPsdBTES7yq7tcU+52jo+QCHnHJNcx2h6oVV25ZFeogwa0=
X-Received: by 2002:a05:6512:138e:b0:52e:9b15:1c60 with SMTP id
 2adb3069b0e04-53546ba9d09mr5862981e87.48.1725268442400; Mon, 02 Sep 2024
 02:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901135950.797396-1-jic23@kernel.org> <20240901135950.797396-7-jic23@kernel.org>
In-Reply-To: <20240901135950.797396-7-jic23@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 2 Sep 2024 11:13:51 +0200
Message-ID: <CACRpkdYrrVNYD=yzaPe19JgEiCVccgze29roBHGsQJ+M+FHjTA@mail.gmail.com>
Subject: Re: [PATCH 06/15] iio: gyro: mpu3050: use irq_get_trigger_type()
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Sean Nyekjaer <sean@geanix.com>, 
	Marek Vasut <marex@denx.de>, Denis Ciocca <denis.ciocca@st.com>, 
	Rui Miguel Silva <rui.silva@linaro.org>, Danila Tikhonov <danila@jiaxyga.com>, 
	Jagath Jog J <jagathjog1996@gmail.com>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Vasileios Amoiridis <vassilisamir@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 1, 2024 at 4:00=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Use irq_get_trigger_type() to replace getting the irq data then the
> type in two steps.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

