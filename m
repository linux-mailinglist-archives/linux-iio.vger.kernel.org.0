Return-Path: <linux-iio+bounces-20950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1F1AE714C
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 23:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF2E1BC2E27
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 21:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82742566E2;
	Tue, 24 Jun 2025 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ghZYD+DE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD923074B5
	for <linux-iio@vger.kernel.org>; Tue, 24 Jun 2025 21:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799377; cv=none; b=W0bkdKZj67Htu/YDuyhPh3ELWg5CvLpA0AIWmyICjeacq4G/bbexA60QUKujgkYaI7k/3Ts+45F46qR8a41C4rhKADFPjW9FaUozq5TokKMwhD6TPGnIpRTHIUgCMTpEvs7gcgUZZWT1KoKUpg4I7OtNdheTVFsVXnMm7/LibKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799377; c=relaxed/simple;
	bh=2MF4EJfF3oGBbVNrPMSxxD/94fMu8AcVw/MFpO1v96s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQcsOdPbTc8aylrDlKIIYRf7EGfiPvZZJu4t7XlH6qfk7idZXC1QamstX428capppXL2Hz8I646hpx1JNwTtP01Wg9jBm0smrq+ZSMIevfbdUQ1WFAo13Eq9/bsim9SdAQmGUmetC2hiLhqA60Gstpz+jCUyAeXQJ4hg6pCTlgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ghZYD+DE; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32b43cce9efso47341871fa.3
        for <linux-iio@vger.kernel.org>; Tue, 24 Jun 2025 14:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750799373; x=1751404173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MF4EJfF3oGBbVNrPMSxxD/94fMu8AcVw/MFpO1v96s=;
        b=ghZYD+DEGwKL4TOu4Azgugxxc2q5llv1avyytvg5zrIbhf3Es0w/2gjpDx85ARMQRI
         xTgdRtVM7NEG5zDj4kEXd7gjpVR75MWWwP7YVqwWY8vQz+30j7AeVyiqeMu9tlMdnazG
         RmWpXRYOQOP67wG++rxsx9mngLKKFWzCRC+uuAeCPsgKsYoNZTEHyVn0hylPjy0ziG4G
         fKyOdl8sGAVXQb61/5TlJC/Ue+9uuIQjFkxkyZblsWrztI9BKQSlHykFCMNXheoiP9dB
         I5OvkspaBRFYgxIZQvji1B9fqZkRxfHr/DSM6EcCIvMnGxF94PptoS/CNuuIYIq5VvdO
         sY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750799373; x=1751404173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MF4EJfF3oGBbVNrPMSxxD/94fMu8AcVw/MFpO1v96s=;
        b=BRXqALWpgmiJGOz+fBMT28m7/grnoYvS3US65QOf0nC8Z90+sGZn57630xj5tu+XM9
         9tjOItHOCYRS5qS4YkEeUjtOeeYOWg5IxKxbMlm32klKXx3m/nNkaDYROVd+SZ5WEIL1
         7MEFr6G8qxcXH0nfB59+6YKdofP5UhaJlGjroF556QEUfcMSDlSqYiJnPSz3c0B+p/a9
         /iaDTdFLcyWeKvEBLbIEvs26GKLXpfVLckRqXHQy8Dv0f/2/AwecP8q4dR5pBMHNQpK1
         NO+sxkmB6Sa5nLxYxAOvGXe4Cws668jYy/zGWyj+b9zn9RyDNAdEDY+d91GVmjrj6n1y
         wfng==
X-Forwarded-Encrypted: i=1; AJvYcCVf4/upY4TdtaFyNNOZFARQ7gRCz/pOX7CfJ2YCg9/83SOXEsCec5IT0x7DI2LgXoDKR8mie6zQIOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4E8y/3WgPuOQzTYcWDGzc86HpvQWTXWGj4ityJ2BSK3CQDGNS
	8ssMG95TSFCL+qcjdFdknnqM9aELpd8myK+mx8zol1UKMF7yxsNl+51yefE480ORevmWrTLFi3K
	Gfahbwtsjh6G+DF3/shyMnaTE+ZR9DiBh/dQrOv2+OQ==
X-Gm-Gg: ASbGnctrJxHuOimv+WrXZlwzzTb8B0dIP/REzZeXw7/aw1KA8yQrlAqm3Zwr3KOk9Fj
	1096fH8VyJBf51ZJvDM4coY7pjBOaJiJg7Gr4fxwFAJ4dlech/EyT3ECchR6yrORh5tDJq+qSB0
	2M1+bTgaeOcQCDFUWFv6NKl84FVtSXTLpbsYar/J7yLYIW
X-Google-Smtp-Source: AGHT+IEYzudCBxLtnCVsGpuow7FpUkuw3nptQHQQRtw4oP1UaDU1p87rIunsZtDyNefrBc2V1Z/fJNG42iXx2/2pMso=
X-Received: by 2002:a2e:909a:0:b0:32b:3cf5:2ff3 with SMTP id
 38308e7fff4ca-32cc64e822cmr504241fa.22.1750799373290; Tue, 24 Jun 2025
 14:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619-iio-adc-ad7380-fix-adi-gain-milli-parsing-v1-1-4c27fb426860@baylibre.com>
 <20250622152506.238c1322@jic23-huawei>
In-Reply-To: <20250622152506.238c1322@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 24 Jun 2025 15:09:22 -0600
X-Gm-Features: Ac12FXxJ_KHu95Iz336-RQCdSp_KlXcDSn-GDiEWvLzfGuq68UC3oa_NRpx2lIA
Message-ID: <CAMknhBG0p_ODgKmu2EpWR=0VemZ5yWYVLxdST84YYfruTirK-Q@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7380: fix adi,gain-milli property parsing
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Julien Stephan <jstephan@baylibre.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2025 at 8:25=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 19 Jun 2025 10:24:22 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > Change the data type of the "adi,gain-milli" property from u32 to u16.
> > The devicetree binding specifies it as uint16, so we need to read it as
> > such to avoid an -EOVERFLOW error when parsing the property.
> >
> > Fixes: c904e6dcf402 ("iio: adc: ad7380: add support for adaq4370-4 and =
adaq4380-4")
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> Applied to the fixes-togreg branch of iio.git and marked for stable.
>

Hmm... looks like this branch hasn't been pushed to kernel.org for a while.

