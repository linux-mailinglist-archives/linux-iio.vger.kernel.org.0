Return-Path: <linux-iio+bounces-19082-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3278AAA8E41
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 10:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97CB8168B56
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 08:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A103F1F30A4;
	Mon,  5 May 2025 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O20Re9SS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F9A1E48A;
	Mon,  5 May 2025 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746433784; cv=none; b=BwPm8fdX0iBMUqoOJx8/DFGSu5awEmXREWuAgRp7b48gsipElylnkSGtVw8GDYI9CmK84T3T7Hm/iyeI/UOwf8EE7sHSUvTpwhWcHnAe6rb1aB9EId8I+fFMn1claBQpOOTLgwPMpN5D1V5d+04MNutGVVkAAmp4gEHeiahzWQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746433784; c=relaxed/simple;
	bh=S5Tp2z1VbSvjvzQ+8MGaiTfeix0Q20EWCslyJOi9uNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mk0Cpgh1DyAxHfr6lmy0eVUurNWT/N0sMu7Rd9LzhmKE8yphcjuLOfEbXyiQ/9SC4luG51a6mlQh8HOA4ns67F86wMhpEV/xHMmgSl51KO27j8vTzgNVO/lT7K1U9Q1dhkPijD0mjOL77+um7Uz3gtoKGy24N3kWVpdePFzvvNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O20Re9SS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso4131021b3a.2;
        Mon, 05 May 2025 01:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746433782; x=1747038582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aj4azZ7fh33b44a3AN6BPyR5yYCQepdbjWeWcHvz/c0=;
        b=O20Re9SSYcn5YCuOUwNfHxxXpJlPung91xKXJ2TaU/luViaLGNGYA3T8U/+WRixKJ7
         y8x/DthOgxIL60/0hDGX8r0bx+W1obsYaym4RiD9P/HwZu0ZqL/nGQG1hkUuXC9pmo84
         4AX+LFsgN3DJxyXPIlFyFc/a9d7F4oFu/PPjjKvgXWaO5qeEmZU6Cfu7sCfszbVzQo+o
         DHMuVjwY4xceEsQOzqxvY0rf1iZalyLBSU8DBq6z52+A044eYvByZ7ZqqpuWZl+dUuf7
         z9YZuFaZ1W3AeMm/Meq+8E3vqKXNkLQCQliDB5vQOE1wzPy5eIWZb7P+U6jJX43H7Fzn
         eK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746433782; x=1747038582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aj4azZ7fh33b44a3AN6BPyR5yYCQepdbjWeWcHvz/c0=;
        b=UAU3ID5XBmTzeNNElIInePmGK0rJWdwgePocEPGrhRAb5P2hZMr4ICfqaZ2wnMYvM7
         fn63FyKMuLOdmWfizANvscFaUfGhMhOVSlLjZERphtBUHeA/rMgR5JxlZRaCZ5j2w0eO
         YP8O2IQp45cUSgc8BO8+s8ner5LsLxqXDxeQCeaEbEoiOfU1n7NXgNQMDtEhiTLOqFQs
         POmsTKyS/NOFmsTFJ4rKVfOQ74S0pluC0A5uWUsCok0vTZmBzoBp4yeOL253MKxZopa/
         m6sDGhHQfkHnW0CHREDPx93mzLO9866t+1Z2Zd9vvMAv295vURlXdjiLerIsr1TVaHkw
         bECA==
X-Forwarded-Encrypted: i=1; AJvYcCU0Y8nBrtMF9DmJa+cYMWRF6TvI3fAAY+U8W6AQvPJVobC5sUGhnjFLBSlUGsSB+PA6qLtCc65buqsKIfR1@vger.kernel.org, AJvYcCVxgiqRBMlNuQYI0Ay/NMI7OzpJTXJEbQrCEegAz2YGYh4YpQFBZTXtU0M6KAJjEt6QnsCzeYuUD9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYzUmDaks8jQBUa0GqupvMYNgR0tgbUPTxiaHKOqcoj32q5go3
	vwgg1eHRYdzExQ1htIFdRAqsrIecFnVAOLjHdUVdWZlYX6cWeGI/mBYAisIXMAdqfpGcYI+9+a7
	2IPLYEIsGbq+mq+Z5hTOchb+60lI=
X-Gm-Gg: ASbGnctv+gwZuxgTzuU15y5hSh7hlw93nXY54XU2D79h8C/DbBksY9acNA5qpMriKhK
	GOgXym7Tf+FIE/zJmv2FNK41UN1fFjUTaUDvLYbJrw29DEliabBRrM18v3GFtlCVMr7QVhdvMiU
	lYCmV9ilUtAJ+VL5nTOvZ0xVg=
X-Google-Smtp-Source: AGHT+IHsZ/GzWW+iK6BvJNRpaeMV2gUGMVe0OaBaiclaSEKG7YlXTlRSL+65gSpRkTK3Z6tjdDacOqfmFEhf7kay2ek=
X-Received: by 2002:a05:6a20:7d9b:b0:1f5:6878:1a43 with SMTP id
 adf61e73a8af0-20cde85d355mr15710821637.14.1746433782310; Mon, 05 May 2025
 01:29:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503185651.29445-1-gye976@gmail.com> <20250504153044.1109d508@jic23-huawei>
In-Reply-To: <20250504153044.1109d508@jic23-huawei>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Mon, 5 May 2025 17:29:31 +0900
X-Gm-Features: ATxdqUE9h19Qmjg4geoGEuj72UMSxcxh495NoX0KQcd-VefWV0xbzZHhvDDsIIE
Message-ID: <CAKbEznvFv8zXJdeMFdY0kWrbcfi_FKx8kZUCt2r6KMQmZ_dYhw@mail.gmail.com>
Subject: Re: [PATCH] iio: trigger: Remove redundant conditionals
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025 at 11:30=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun,  4 May 2025 03:56:50 +0900
> Gyeyoung Baek <gye976@gmail.com> wrote:
>
> > Checks for null initially and return early.
> > So there is no need to check for null later.
> >
> > Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
>
> So the key thing here is what does this path mean.  trig =3D=3D NULL
> means we are clearing the current trigger.  The snag is you just jumped
> over the code that removes the old trigger or sets
> indio_dev->trig =3D NULL.
>
> So I think the new version you have here is broken.
>
> For changes like this it is fairly easy to test them using the
> dummy driver.  Please make sure to do so and make sure you trigger
> all paths.  Here that would be.
>
> No trigger -> trigger 1
> trigger 1 -> trigger 2
> trigger 2 -> no trigger
>

Apologies, I misunderstood the logic.
I=E2=80=99ll make sure to verify it thoroughly before sending a patch.
Thanks for the review.

--
Regards,
Gyeyoung

