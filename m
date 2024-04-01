Return-Path: <linux-iio+bounces-3981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD5089459A
	for <lists+linux-iio@lfdr.de>; Mon,  1 Apr 2024 21:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39351F21CE4
	for <lists+linux-iio@lfdr.de>; Mon,  1 Apr 2024 19:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D798E524DF;
	Mon,  1 Apr 2024 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v0/6EELo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D47524BE
	for <linux-iio@vger.kernel.org>; Mon,  1 Apr 2024 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000464; cv=none; b=r76jg7hDNnblbwDT3gtYgumh52cEX82lXL/TqVP7ceTI/ye5cbur90oHblGnCPVfZbLAsMxcMjYYSwySJMe2YE6fBqDw5XNleIvhIBIuBiCtNpdrAaJD0RXlDHbqZqIvBb6J7QrA23BL7JBvmovmt+Gns/jaEg6ez13HvjdtppA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000464; c=relaxed/simple;
	bh=18veSBurcj4Zy0ovVkcbXDSq6z8G14uZnoed51VrGs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFgE9B0Hc5PJnIP2EmFwzs7XKqO1jI1q4rUgr6FXVp8/VG6PkTScQD2k4+Gu1ebjkfXjFKTiwh+/zVDxrgjrCz/dY0qhgvI4cQ2JJd4S7KZAPi8ftO8FE19039joUn69wKSJ+WrOz73Om0CxtNMvjH1rl9Il5dZ7YPmoZYPGvc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v0/6EELo; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d700beb60bso76639691fa.1
        for <linux-iio@vger.kernel.org>; Mon, 01 Apr 2024 12:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712000461; x=1712605261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18veSBurcj4Zy0ovVkcbXDSq6z8G14uZnoed51VrGs8=;
        b=v0/6EELozykvAAFym+L88Q7AqJqKB/xAjNLsp+At2J+xHsvsXPhYJ3tRYzRwpLQQvl
         fpVGK3J8vJz3yqv+L5oBJZsF6SwaycEBiZDcoBiOv/o8vo5OySlE1jo4zM9mj3W0OZAB
         kP0ol6KUnPDhlcVdcKB599q2uLviTBIIUB+HMkSruufiEz7WiU1+EA61ke1pNXosc5pW
         9yc4ZGhxO6ET95SFQzTF2cI1SLlPube9/MJnVNtKpH9mKOMdXzr0pkMeuJ4Rma/8H1iw
         hUMjpZBl+isl9EdcH75CE4kmCoLTPeg0msOVmDl08gcwHkmw52od2We4HVyfcxG30l/Z
         dxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000461; x=1712605261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18veSBurcj4Zy0ovVkcbXDSq6z8G14uZnoed51VrGs8=;
        b=WfB0hVSruiF8sN8T/TJ6hM50LdB9z13YT5xuVOzta6GL4jHPQZvidsYrmkIcrN6VSZ
         aptqFWA1eHQLe5dQ65pnRL/2cRP5JOueheM8HMhFTlbgysA/9nKLGIDATScO1ycVc3N5
         OutGWHedNkFqQUor4YEb8t1/t7iXVhgmM+H9ksk/6HB5a50ewYHKsuvCjXNrKJDC5mPK
         8wnHLQRbsg/xeolIB1se0ekJ3JtUw1juf7YlQb6N8yz2hUMwWG/k8Div9B3sVq0vftaQ
         TymWc9Luj0gG7bobc3Qy3BpDhmV0MBpT0rQiHtPBFEdpMuGZ5XYErpZy8lFdHdRBFEx6
         wHyw==
X-Forwarded-Encrypted: i=1; AJvYcCV9pk9hY4f8nzAPGcWURvvUIapMXfNwmzHisNy+1BpgBNj7WA6eg2suUhN/sCGO/NYpMUQpSRM8H/KYL/Fx8bG0EPeKZvoZ4vwQ
X-Gm-Message-State: AOJu0YxtpvffAyAWr/0gC4b1XzMo0I9cJzdE9tWZKHN14R57aRWG3RID
	W1hW62ftO/9BeUPQigeUNvSQt0ZHLPf5cEbGAZQGig/J4WlCQ1WQX91dSyYZDL+vWIVuECPU969
	bpFp4thoR2eHKIbjC8Zry3gEkykGn0tS/B/GsYA==
X-Google-Smtp-Source: AGHT+IFEZ8XahK9BngJd58iuzQu8IyjebX4QQq2XzZIfDHs8ynLOM3rPpXsyA/GW4d5ZA3rsUGjfOg+JTRpT14xd2M8=
X-Received: by 2002:a05:651c:a0c:b0:2d7:1e2b:6284 with SMTP id
 k12-20020a05651c0a0c00b002d71e2b6284mr7833633ljq.27.1712000461409; Mon, 01
 Apr 2024 12:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com> <20240401-ad4111-v1-5-34618a9cc502@analog.com>
In-Reply-To: <20240401-ad4111-v1-5-34618a9cc502@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 1 Apr 2024 14:40:50 -0500
Message-ID: <CAMknhBEd=P7vEh9tWE_czCUBsQaD2Hm9D9+-uAd_qFjVdgCYjA@mail.gmail.com>
Subject: Re: [PATCH 5/6] iio: adc: ad7173: Remove index from temp channel
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
<devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>
> Temperature channel is unique per device, index is not needed.
>
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---

This breaks userspace, so the commit message should explain why it is
safe to do this (e.g. driver hasn't reached mainline yet, so won't
break existing users since there are none).

