Return-Path: <linux-iio+bounces-3332-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDE0870463
	for <lists+linux-iio@lfdr.de>; Mon,  4 Mar 2024 15:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFF21C222C7
	for <lists+linux-iio@lfdr.de>; Mon,  4 Mar 2024 14:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A89746B8B;
	Mon,  4 Mar 2024 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="emGzoon8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB56C487B0
	for <linux-iio@vger.kernel.org>; Mon,  4 Mar 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709563165; cv=none; b=QI3ZYaaIA//MNj6yIxugFwmlTggxkAshnkveQhlSfX+xEzRv9XvxArvMvllRbfcy+/T8d/zl+JXkQh/wyZQQq23CnBhOcsz6o2DZ/N1rgS22Zuo+8Gf75/rDtYfBYFej0B2GeilorKiBpX9PvSW9EnkxH++qhhp3H24x5IWP+0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709563165; c=relaxed/simple;
	bh=vDGpRCxAORqJMueKt34edr+rCaYe1PnBVeh9tbmSp1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXpSVwsI5w72jO3FRaqwAgoO0R5Y8ktfTLtAF1cIaUeFYKyFt3hFO6MTfbA+U2InkG4CF5EcnV4CXesPI5BtQn0+Z7XttUvXSqd0sgx/LRBsBfsGAu/u2y1KBYmA5Sg/fdSc2KWrepTAiSgh/mP4SBh9GP7HzrAfYN/w5ewhkig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=emGzoon8; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d220e39907so68097021fa.1
        for <linux-iio@vger.kernel.org>; Mon, 04 Mar 2024 06:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709563161; x=1710167961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDGpRCxAORqJMueKt34edr+rCaYe1PnBVeh9tbmSp1w=;
        b=emGzoon81ObDc4HA71OMLgO4ZeiTeZ9nxIEmUiplvEnTErKGmNFq/UAAtQpMukhgeh
         UsUihWdRHlhFop3CKe1sbTPt+89G61a4VpVQYYAMhtzmasYXMRxrtvohfns29DIXSOlx
         C8E9N2dhuwZN31xn3F3yX1EXrCOGVbe/G8C6kCpBUQwiI7a9KwgzI5Ba92jPYwftLORI
         y/zmcdwE/EANdx1CfzNC+BakxmFGOeHkdfE3iirJGXtXUBMkL6FOOKd08r9A8aZedhd4
         CtA9k5nSfmskCkazvO/nYQWnlu16a1Rds1zf6mvBshyo8sHm/Chp7YcWbtlZjeQuNFAS
         +6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709563161; x=1710167961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDGpRCxAORqJMueKt34edr+rCaYe1PnBVeh9tbmSp1w=;
        b=iSWgVd2u5p7F/pZc/Q72cf+5BbI6IsyicCzceq0cl4QLu46yfcWLK4ccIXyrgJqGjM
         Sh+Wep9fBBxCz+KM6I6SJnaeWKuNFIE1pLM56NyPHl9a7+a9X/Kb0oOZp3Zm7GJYX42u
         uQJXQ6YHRWZCbw26RYboGHcvzDvimkBctaxRngQhHfQnSiRwr6vDcEvkPtFQFJkDX745
         knjqCohFwMkwKFqgW8RJG96AwTNtwiZLp3wO0isqQhyypEzjOv/fIEKW3jaJ7KvV3zOQ
         qtVo54lTByeD4bBzCxkKX/Bs0r3RcjX1PD+jfJdDOSnNVBn7iTXY7NanCDoosWCQu5zS
         hiqA==
X-Forwarded-Encrypted: i=1; AJvYcCWN1ql69LWnzghRdn0w8eFjYMGgUYjzWcw8SC7++yZbwJ6mCwJWRxj6Rx7YtiAapPx+HFQRIM/HFSxekbcPMbTLoogxK6lnYATQ
X-Gm-Message-State: AOJu0YxLAVf5cD4V5T0GSvd0i6lMMpgUDMHKCSa/4iitVgT2tgcjbgJ4
	7KyHcqs722n3GP7lBMmbtFAK6WiiKPb9OPSM7HPmllE3bf5r7N8NxIHVvHZdN1C4FAGqx3WEUL1
	6yL2AsqsYdtyWMGWzP3dJXO2YpXVYZCBe9JsxVw==
X-Google-Smtp-Source: AGHT+IHDk6ElikIs8iamzUoSTyAOXOafoUhC1GRAhOK3vIrfpyJwvtQAHDA/PPtsiDzT5clDw/wzuhOyU+TXxJplUy4=
X-Received: by 2002:a2e:b057:0:b0:2d3:3305:c37d with SMTP id
 d23-20020a2eb057000000b002d33305c37dmr6796096ljl.2.1709563161280; Mon, 04 Mar
 2024 06:39:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304140650.977784-1-andriy.shevchenko@linux.intel.com> <20240304140650.977784-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240304140650.977784-2-andriy.shevchenko@linux.intel.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 4 Mar 2024 08:39:10 -0600
Message-ID: <CAMknhBFLVaEBE_aPYADpDdYVNhfz5aSb4vhP6v7L3de27K7V1Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] iio: core: Leave private pointer NULL when no
 private data supplied
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 8:07=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> In iio_device_alloc() when size of the private data is 0,
> the private pointer is calculated to point behind the valid data.
> Leave it NULL when no private data supplied.
>
> Fixes: 6d4ebd565d15 ("iio: core: wrap IIO device into an iio_dev_opaque o=
bject")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

