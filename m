Return-Path: <linux-iio+bounces-18090-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04144A88779
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 17:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4474F3A6F3B
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 15:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D3B2749CC;
	Mon, 14 Apr 2025 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSkkysUl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AD123D2B4;
	Mon, 14 Apr 2025 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744644957; cv=none; b=F7AD4Ty61fTE/NZ+55NXuI7n/hKmmruvk+6KzXRAnxKg1tcpEZz/ZyaciKa3vv+JcUgg/KIV9SBSGvvsWmik31eLIFx6EZuAKJOAlppivMz0alu0Y3SCv6B0rq+O9Mr831IDFUt5qqFmqyyiDx56huU++77L/AJrY60hVtmSCoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744644957; c=relaxed/simple;
	bh=+v5GBdFU3hoXN+uGNfpMqMGmAv7vkRfYIU2MS99/34k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rm+4WDc0n3++mXJ6vEwK6psiZDcEz1EiAKVTcA8BlCcqFVzoR57LeIm7D6B5baUY5XSKEuMFf5VuGG89JDOxxRIRyHp8lZm6W9xp9M8BO8fTaWgaC7zaJQqEl+Y+FoqaGJxKe7U/C5IKIJ2hAH5Xjs/UqwQczje2FvlsocUeW7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSkkysUl; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c592764e54so551669685a.3;
        Mon, 14 Apr 2025 08:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744644955; x=1745249755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+v5GBdFU3hoXN+uGNfpMqMGmAv7vkRfYIU2MS99/34k=;
        b=ZSkkysUl4YoRJeE84NFIDe5sEoK22tXkmv3cu+r0YnL89uP+J6v0T7GGEYnczrIZ9N
         9UgHQr6/akCIqhX/pSz0iKjXU6AMD9gnhktsYDhxynYVaJ7vTU1AEac8h1ZmrT77irlc
         EYrcbYCWPePwyOJ6VamCbMH0yOO7cooqtxGMoCnt1TnqsZi+JgeuFYNP00a9/k4XhcDH
         7+l9O9AnQdUlU95gBvHCopG5Gf12mA1AcRGVkvxNdcHblJUdWHqKjcoOk0PjWGfDoU40
         yGv2XxfuDCAtgY/OVELmI+FECb4rY895Ezd+4GQqLi0FX6Iluw/0b5eKLbOYjwQ4jkk/
         bELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744644955; x=1745249755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+v5GBdFU3hoXN+uGNfpMqMGmAv7vkRfYIU2MS99/34k=;
        b=kw4L8/6REbCDppMguD1HhEZou5Ewz0Q2PqJZRKORNnhrKc5uMsXZWINnIanNtQEENs
         5sCIH98um+sJVdAcVvadmLggzj5U3tkNFOQ0VzFaqkG5UydqT+9+nDBtAsdBjensUEPK
         jFs7K/F1iSjgN9p390Mk1OC2iOybuwdqyGDVX119ZQsvIrtQYsiQI2WNgnX3482Ubav7
         qrH67M87YUAKPr3FBRtTtQ6k+PsSAJ81CzeDI0w4kGQLUxxvYRi5mxR6H3brp01cdZzK
         Us74v8Qg6dSeOw0pxrxnjyBs0/1OFYqUhP/ydLm0b2HOXUhCd7IOfmKn1Wm7+5wrV0sU
         GdcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCYpJByFPlq4RBzeppUWRL8nAd/E3p6Wlf7XVvThgW1qVvNt157flPfPJsmF/3XO53/ixdzy5v1R8=@vger.kernel.org, AJvYcCWeNV78spLlfUIr8KzcxhphkfZK3RtJLIjEH4fRycQVxlTx+Wvc+Xu4l1d6WqLoBOGoda+Setlx5NJvrJEr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4icDxZY92cttP5vHkVygtqRo20lZ4XpWwTkHHKdI3lvCjpnSO
	IgnjUP3dC4NWvciJ4LkKvQ4IWGAhDOtGaFUvaCZERe/lA4CR5N3tNyDAQTxbpuL3HPbfpFHSAnG
	qQNOkWwQf2bTj3NkOwTZechtCZFU=
X-Gm-Gg: ASbGncs7Gaj6jygv/+S4Dirms8xA7lLuhihSpw45MTa7/9ZpYIvUEt1Uae5HJX7gIhD
	shI64Agyo16KgXSAQRxTsuz84scUCU2BQgMhF+kCbAyReRwXqwH+9WyhGXcIQJiq3b5ghsJJuwg
	ipXmRl3WAyQbvb1F7knCvWrHOr6rUItHM9E8ja1ovIc1s8eNq5UogQ6S4NSs6ryQHN
X-Google-Smtp-Source: AGHT+IEXe+Wbw4q6CnrtWNp/owFqYsFsq2PQKIoSF9ymh5TUERZr/I6KyL4du/gXWT+SXUA8Un5UdgkX9zgThmHvwjA=
X-Received: by 2002:a05:620a:4310:b0:7c5:4738:8a0f with SMTP id
 af79cd13be357-7c7af10c12fmr1618638085a.15.1744644955019; Mon, 14 Apr 2025
 08:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414140901.460719-1-gshahrouzi@gmail.com> <0b1b428d-9ad0-4581-a13a-88f4ffd6c4e3@baylibre.com>
 <25db1c97-001b-4b9c-bc57-879fcd0abb14@baylibre.com>
In-Reply-To: <25db1c97-001b-4b9c-bc57-879fcd0abb14@baylibre.com>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Mon, 14 Apr 2025 11:35:43 -0400
X-Gm-Features: ATxdqUH9M8QgQytsQePy5fG22GAOlscRHU9LERyMaCWRCdJfNFKV9N9M4IYxo7k
Message-ID: <CAKUZ0zJs0mgmgfHaTzsPaiZFjHO941wJG2CmyJnA036aHu5vyg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Correct conditional logic for store mode
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	gshahrozui@gmail.com, skhan@linuxfoundation.org, 
	kernelmentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 11:02=E2=80=AFAM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> On 4/14/25 9:59 AM, David Lechner wrote:
> > On 4/14/25 9:09 AM, Gabriel Shahrouzi wrote:
> >> The mode setting logic in ad7816_store_mode was reversed due to
> >> incorrect handling of the strcmp return value. strcmp returns 0 on
> >> match, so the `if (strcmp(buf, "full"))` block executed when the
> >> input was not "full".
> >>
> >> This resulted in "full" setting the mode to AD7816_PD (power-down) and
> >> other inputs setting it to AD7816_FULL.
> >>
> >> Fix this by checking it against 0 to correctly check for "full" and
> >> "power-down", mapping them to AD7816_FULL and AD7816_PD respectively.
> >>
> >
> > Sounds like we need a Fixes: tag here that reference the commit
> > that introduced the bug.
Sounds good. Included the fixes tag and CC'd stable@vger.kernel.org.
> >
> >> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> >> ---
>
> There is also a typo in your email address in the cc: gshahrozui@gmail.co=
m
Whoops - I'll update that.

I just realized I didn't update the version for the second patch
correctly so I'll send in a new one.

