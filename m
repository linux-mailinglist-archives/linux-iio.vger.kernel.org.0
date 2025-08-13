Return-Path: <linux-iio+bounces-22658-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C9BB24773
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 12:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1925A07D5
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 10:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4202B21256A;
	Wed, 13 Aug 2025 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m45fT3KK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C182D12EF;
	Wed, 13 Aug 2025 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081312; cv=none; b=jWS8lTFFDKzq20Ir7PwD43KHZtegXYqhPG6mtLIqe/AE5fU9Tp05qYE/iLGdV0eqbOSTT/64VenChfOtbIf3FhZ42kxmAHdRiT7xWeJbzmeFwl8GBT930mctv76QAxptK6EK1gfJfx464bamJ2yyk825cXS+gAdHzvmqeZDbluo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081312; c=relaxed/simple;
	bh=DYdN5fQPZeUp+czZnPk87jd1+aveSqzRLTyqFtCf5lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+X6yY8/aO2p5cpF36UUDTGKxlQa+YD8qzak4cZb56i+KGDXeu+Y0E1ynJW4d4v6jlTMDraaTW1PIZwcit2NWBfD0rxp7JwbXX+kioIDsrEojGaXxEwQoOd/Fdv/2W1qyyQ7sfkexicHRD8M6zRL8tfi0XNHRZRMBethoXjmP/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m45fT3KK; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af96d097df5so1172753366b.3;
        Wed, 13 Aug 2025 03:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755081309; x=1755686109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYdN5fQPZeUp+czZnPk87jd1+aveSqzRLTyqFtCf5lY=;
        b=m45fT3KK6rq7lHaaANl7EVcAl9bBfoCKPN3x/HlYx6cy8ovGKue/uSP5sRpVihjZCz
         /A5RIoP7F6BAIhM5AtCcdUkz/oyJqUMgt3UV/t3EN3B57wf+7CbmmmbUK/SI+P6HyH42
         UHAD0RpTFWhYpXZXovwcz0vg46xqnGPi9sqO4FPK3iDyz34i6l/8bRQOITaYgSkfL3/x
         dF7Zn+dMbUgVKEm5DsCJlrahFMqFdpDoWpNxmA0T+4yHfGr9fqpBeA5rlOwl+PfD7dfP
         fLY88J6uDInRRNvIAVhX9by9enHH64A/2cnRmXHVgp7vs/s54K2eETKWCPkCQZC721HB
         Du1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755081309; x=1755686109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYdN5fQPZeUp+czZnPk87jd1+aveSqzRLTyqFtCf5lY=;
        b=h7jmF4qNkur+cO6UlAcrcaPfNqLmRN2apQ7LnZB2hBqFyQR29HtYxUSnXiwddwjCMa
         0U+n5uNzHDb7NAPf6qtNUq7tRlWOvG1sNfmCDWiHVzH1qlJHniKvp69OlSKUMp6a9EJ/
         dmUhn56t2lcTZ2WLZDHggBJNUAzHerofzkFUP0L+L+WxF2rNNdg8AVDkG+hAB7WBGYyH
         VQv8JuxJhnWB82fx1SwH5488HmuzpfogQXhqQB/iPecj/Nbf1zTd937fb+Fu3UpIN0vi
         cZCRuM5V8aDT36Ct3JR7KJLBbkT2aC1f605ILJ5rCWOoBlsgKX/2M36GZbHutJBbOPN0
         Lbyg==
X-Forwarded-Encrypted: i=1; AJvYcCWW7K0KlYSMOIgtwE4ezscumr3cMWEBNrNrEiyN3tPTU5woJamuJqSgqGQa2+7MVLFOe6o/gqiloc0=@vger.kernel.org, AJvYcCWYb3WQUKPv/46CFYzeWY94KXKQyXIrQ9/jA0/XPY0k4eo4isEapObLI0IrUurhpeECDMEq3q6iXFbbKkBz@vger.kernel.org
X-Gm-Message-State: AOJu0YwMtrP+yIMAk4WYzEDBstWkrwzmcvhzq667zJzAKcS99wXS5XDl
	W58ugXhI8Cf7CGv58DgK/9jre0gb8/Zh5YuHTs20b6vD+wzyH9GI5iBev1lZyULTjkqOrLliw0/
	nc4u889ZoOBQJsgDirxEVvSGsh/rWARk=
X-Gm-Gg: ASbGncu7w/AC4GA0GFma5FmSG5HRSVulxi+jQH63SwNFwczUboEpsshMFluZvioUnWE
	y7wHBBNaLcBZrokslHu/FgeUb0Y0sBOIXMu9SZXA4ogO89LHUaPa0DCIfueEqKamTfXSoCFjLJX
	94c60nnmjsbZ482hYteWAoxGDkOC3kv6MIQsXSTCwcn62cXpmV2KDDS9HwYHUGExCXbHZieYx5H
	mlaeumHZw==
X-Google-Smtp-Source: AGHT+IEo+49wmPczX9jlQXC2dDHCUVf/lSEuT8Q7I82/hWtLzqfzzrVMbtr0vDiq2TQh9hcqZmf37kbH4dMG+SMGaGk=
X-Received: by 2002:a17:907:6094:b0:af9:acc3:823f with SMTP id
 a640c23a62f3a-afca4ea0801mr249216566b.58.1755081308449; Wed, 13 Aug 2025
 03:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813075556.466872-1-zhao.xichao@vivo.com>
In-Reply-To: <20250813075556.466872-1-zhao.xichao@vivo.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Aug 2025 12:34:32 +0200
X-Gm-Features: Ac12FXy1V183PyG2P7KY2Mxjty-lInCZOOuCaRiEGNiQi8KltmLgYwehprr8yZA
Message-ID: <CAHp75VeRb6HV80P1B60sr4=-pdWW+GS1dQDYUbO0PWLhkKZsGA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ti-tsc2046: use us_to_ktime() where appropriate
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: o.rempel@pengutronix.de, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 9:56=E2=80=AFAM Xichao Zhao <zhao.xichao@vivo.com> =
wrote:
>
> The scan_interval_us and time_per_scan_us are more suitable for
> using the us_to_ktime(). This can make the code more concise and

This makes....

> enhance readability. Therefore, replace ns_to_ktime() with us_to_ktime().

Perhaps Jonathan may tweak the commit message to be more English, but
code wise I agree with you.
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

