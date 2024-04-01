Return-Path: <linux-iio+bounces-3980-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB0A894597
	for <lists+linux-iio@lfdr.de>; Mon,  1 Apr 2024 21:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744191F21D5C
	for <lists+linux-iio@lfdr.de>; Mon,  1 Apr 2024 19:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582885337F;
	Mon,  1 Apr 2024 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yjSW9Puh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8184253E16
	for <linux-iio@vger.kernel.org>; Mon,  1 Apr 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000432; cv=none; b=kKKbyVFl8TPkNdcqA6M4GCDQ7JJVg5IfozW3hc99EHCXRc3wKDPQ9a3bUIIayYr5Di766MzNYzNUsZcM/9KDNLqU0v+VpHPq2oPeQB2rj2ifNRaDvtrtTIk2YoriBQjzDxkRMi4vzgIjmfVb7NYc22lvYkP6WsCJg1kjGMZmnEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000432; c=relaxed/simple;
	bh=l0Z6BGOa6aQ3LzuruVpcOIFCOQoft5ykkCp4c+D9ca4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lA3+s8FZ8bfeKcK0QX/0S2f/dXbhqavzYZagZbV7e/4KcBWsGrqa17OsnCRjyahKDo1eQTjL2tnUxCtNgYtn4sXCkbzSkOdb0DBZmR4q6sT+5fNM8PfCfVfClNO4kCLzfsHwZVwqlnURf18FxK/Tl13W+myeauYoWdvd6xQvBn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yjSW9Puh; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d4360ab3daso56445151fa.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Apr 2024 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712000429; x=1712605229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0Z6BGOa6aQ3LzuruVpcOIFCOQoft5ykkCp4c+D9ca4=;
        b=yjSW9PuhLmF2rczI2BlI6wkDGe2gcdZiKBQZO5vvvMxaJAOQPaYCcYC9O/Yh+00cBz
         uEGfmWuPUfWJzUCOpkwr+tuA2lxbxpMUGCdAVtetDeZOL9jeSwDWbi2WT2BFea2bjyW7
         lVIwx401xUi8pIPtTFKAyJtVz+jhfdTMFFuKxNYuKKCytgYaKY5UaCrWTFAbczMAt2C0
         ka1y1wf9l8h9gleVWyy/818gGpe8fcykMMqRP3+D4PnXzH3Io89LXKsIqTZq8s9M56r3
         kNqIxTuelmjl1E8NWNRU9JlVMAl+hJq+Y13Ke90XJjFeSS2Wr20KALFJhH7CxztyAYRO
         iydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000429; x=1712605229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0Z6BGOa6aQ3LzuruVpcOIFCOQoft5ykkCp4c+D9ca4=;
        b=cWZ1nq4zQkqKjc0yhsxxFpsv7gjsrA9NcUZQo/FA9O5w47mNMFe5fbE4hQT2Dubh0j
         3A3R7a3rtnxZC1yzQpB+y3bKVRDQMknEvBPHnHoqLvrjs6W/eDU+AxFB21Q/isn6Fp02
         rvClbju/MnlGjZomrA4Y59reRwX4GlfakKoGLQBSg6IEbyztOYo42L19izcZm1sVJe8o
         FPWCRE4QjOM+djUNq2DCDqFK4Yp5t1o1ya7S/vQO65J/JRBLhFzUKgE4c1xam1Q5tcXR
         0ALd4SuyX9oJ1gv1wETZaGjseH79kz41p8OsA2XtkpehfbJE6k9KRnxEE4xmQr8wU0EP
         HvWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX3weGhHoSmm8XdOCNiH5zcbecqT8X4OOnj+mI0Ju2XY5jW/Yv6BslFx3jahmuBaLC+NUb1VSTaXdNAHt8Fy5249FnQXqyp8Bf
X-Gm-Message-State: AOJu0YzfhZHp5w9NaIrIJDOlII1shwLcABKfIWVQRvroHByCxGTpbiuH
	mUehZybxZlJt9AJyP5XHvRzrIn/+yxO9/Ig/AxlUQrCM95zT58dvHSfSybZqo76iSv1Wj28+LL/
	0BiYpCwQsoagDwrSp9MFOcrAx3OfS3z8inlBkcg==
X-Google-Smtp-Source: AGHT+IFl6bzue3XRZCycrKbfasb0UTboZ3/Gvf+nMAgRiEG89W5cAu7gDepSOQQdI6cKXe1iJqAsYE9kdjEaNXBp2/I=
X-Received: by 2002:a2e:7a16:0:b0:2d4:d78:b05a with SMTP id
 v22-20020a2e7a16000000b002d40d78b05amr5775375ljc.19.1712000428742; Mon, 01
 Apr 2024 12:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com> <20240401-ad4111-v1-4-34618a9cc502@analog.com>
In-Reply-To: <20240401-ad4111-v1-4-34618a9cc502@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 1 Apr 2024 14:40:17 -0500
Message-ID: <CAMknhBH8UEPSyYiyMPo4en4vcjnJ7_W5q+iJtMOhdp5eNmP=8w@mail.gmail.com>
Subject: Re: [PATCH 4/6] iio: adc: ad7173: refactor ain and vref selection
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
> Move validation of analog inputs and reference voltage selection to
> separate functions.
>
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---

Same as my comment on PATCH 3/6. We would like to know why this change
is being made.

