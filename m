Return-Path: <linux-iio+bounces-695-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978B7807C17
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 00:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532AA280E7C
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 23:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6011B2DF91;
	Wed,  6 Dec 2023 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TPvOngAV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179ADD4B
	for <linux-iio@vger.kernel.org>; Wed,  6 Dec 2023 15:10:29 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ca0f21e48cso716451fa.2
        for <linux-iio@vger.kernel.org>; Wed, 06 Dec 2023 15:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701904227; x=1702509027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbGZKjcZkRCkbq1eZtHyPwn9D1JWO1woSq1vnvUsQZ8=;
        b=TPvOngAVzCmaoThJHrCyNwjWw5Ejti13FXP5tBe9UDlCsTzMTv5FJoQvgKPfaIJKxu
         xwKfFm6UsL/6A6xTvfh61PFe1O/EEuUJZAiuWrQeqyqlrIUUT6N9PbfoxS9QHnYYEBzZ
         BIdRyz7kDoKyCWg23iFeVi6eAyUw90KUDBjeOuZFdiWt4cd571odbwA8nU7+30WcvjkO
         AcdxnJIH3SAW+2UAGbG3LeBDh3Hhh79azppaD4vv0HLA/5uyLc4ZexyBMd/Ud3kJ9NVg
         xXU5fwOsZAFkrmRnDhzvYZnnyik4xSGleVIWWUYXealYtEPjGuJ8fWQeKE1PfQLlm6+H
         8v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701904227; x=1702509027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbGZKjcZkRCkbq1eZtHyPwn9D1JWO1woSq1vnvUsQZ8=;
        b=nWxiNLykcUGJrADL4t+XpchZOxnna952IYzAYgDQ5NZWaO8vs1c825hG1qH27taL0E
         WOQpL0hj+u9MViLdwr2QLge+lc7dzyZ2uzSZR1hJduZALuj7SK5TaGoGi2yEDMIOwZcB
         XXOMnBuNrqpSZ6vfkH+R9gkelOAYBFIMbOiFN6xSHNEc040ruiffJe9/VOuLd0POwSUO
         1KYWRSbxhJyX09hGY6DOq5MP6mIlbUPt54Qew9kt6322jmGxRTPt6XCUP8u/HWHpo9d8
         zVvDdd2Ka+4PIj6pjhJOFcQfURqQmt75dpMmuoJSkEoWcjqhwct3A2iUAvM1wiYUjF1+
         rNvQ==
X-Gm-Message-State: AOJu0YzEC703iagHCJhqhH3FtE7rjuUYQE1VYOlt8iNqSuWZUMeiiC2q
	c1TxwgdG9Jd73YC8RjiNm1z7QRySOmJgzUgVh9kHpw==
X-Google-Smtp-Source: AGHT+IFTl+NxEc5B2sgUbagOjZScO1L/8PhPADq5tJ7xRYY23iU9XJh+zXD1v2iNNmb7SyyenYi/RyBXehAWPQtzrl0=
X-Received: by 2002:a05:651c:23c:b0:2ca:107f:c309 with SMTP id
 z28-20020a05651c023c00b002ca107fc309mr1003974ljn.86.1701904227193; Wed, 06
 Dec 2023 15:10:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com> <20231205-iio-backend-prep-v1-6-7c9bc18d612b@analog.com>
In-Reply-To: <20231205-iio-backend-prep-v1-6-7c9bc18d612b@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 6 Dec 2023 17:10:16 -0600
Message-ID: <CAMknhBFQJpfVBKkYTSKMswSHcMQTPiv8GOMD06TWh19WB6Of2Q@mail.gmail.com>
Subject: Re: [PATCH 6/8] iio: adc: ad9467: use chip_info variables instead of array
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 11:06=E2=80=AFAM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> Instead of having an array and keeping IDs for each entry of the array,
> just have a chip_info struct per device.
>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

