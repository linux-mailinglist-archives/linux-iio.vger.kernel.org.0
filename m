Return-Path: <linux-iio+bounces-20846-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77689AE2FC5
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 14:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9533AD253
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 12:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F63B1DF751;
	Sun, 22 Jun 2025 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ0C55eK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EEA1DED42;
	Sun, 22 Jun 2025 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750594322; cv=none; b=Y74WzOfedacQq+LZmUwvldTXjq1ed4OCJtXAx+5JnyzwTP80GtyLmHGU09EIO5K3nxDLKvHrDmJTe22Twf+g1At5WkcAHGg0WKKAFCtImcEfoMxlKD6xZD23c02Kg2SOWzqzk6+dsQ5uffAKPpYXGw+Wze6ssJrIjQhu0kzzNos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750594322; c=relaxed/simple;
	bh=BmFjEVcWLQuD6PoCBoUpHZ1sPPiBqau1jUV0apQtZPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hV92t3n7hwib7ORaUcHyhrLZW3JIJ8VMrvzMLqMG7FJ+w70CVXe/QMRI1BAOcvd/FKTnFTdGPJ7/oP0YDf5bVTmcC7FyQvlZS+FgZojindR2mbeipZdNzQVRqLE+6rjRTftVaRjvTkmnuAssHBHJwBaF8PVjOvObGz7t6jr8J+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ0C55eK; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e825fe1c8cfso352388276.2;
        Sun, 22 Jun 2025 05:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750594318; x=1751199118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmFjEVcWLQuD6PoCBoUpHZ1sPPiBqau1jUV0apQtZPI=;
        b=eQ0C55eKgFePVzB+BJt1obx7+oExjtbcfo1izzPr53ooi6unygYK2hVvMAbEEWF7gm
         TnOh04ZWe3R4lXJV/BqlkwYFZHwihi0qn3L8O4XSZttOZ2izcAH5lEB3qEtaCF2TDWMX
         4Rj0W+GCHiPpvtLy1evWlaz4cYn83IdwaMVSKh54aMuF9kROH48IdwKvQUyM7ZrDXOzY
         DD9kWg/7vzTPM/lbisiIbKZw6Yi7SFeFlfK3tZpbSpZ0d28HIrTnEnkzDWJ9+lKAJI3q
         Hgsn2LVpvNNx+LFJPRHyFaAsgFBMPMnjCy2vb+c2gDqGdkHk2XLl18I0eYLXqK/rFrcx
         rmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750594318; x=1751199118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmFjEVcWLQuD6PoCBoUpHZ1sPPiBqau1jUV0apQtZPI=;
        b=fUsMgIpdIudFbx+MsD+6gOjGt8Gje9B2wBKe1Hd4IlPUaWcmcDASQ7Px5i9JZUIBjt
         qgiJMhrdDgNhwG3RsjbuRx5jddrvPYAckbu62n45dgQFggXDnFVZOMoFIZNeTwjnhdQm
         PyDar14pejUlidhfXRkk+OkwmoCaq+j8okz2y5ULifTQt/iaCT7WPZgBsEK1Xmb0kNP2
         R//iLBCCVljJ1OrAouUm+5FwVxbmWf8UybzBWXENmNVshtfMBGFmQErbNS5MYBtKzKFu
         RHLem/1rpI/hfHNXa3epJP1+Xbalob1twrdY6zG72+hS3VwVPkNE5cUMgIuELvxn6b/x
         bJ8A==
X-Forwarded-Encrypted: i=1; AJvYcCUtqwW8T6r7YAgb0TfcJZ+cZxH6ATWWAOPe2cHhzN4ndBMJwy6ZeAS8NXV8B0dVIbr8BjBC7cpo9MI=@vger.kernel.org, AJvYcCXj+Cs17lCD+V1ZcxHvkRf6WOoRf2yUTlSLlEf26FCN/A/llxE8ikwndRHbhbgPJh+H1AHbKI5P9Lkhmlpj@vger.kernel.org
X-Gm-Message-State: AOJu0YzsNF0wACZdMdVdzhOOy6Y4jamNLtOOrBHkX+d7HLX3eeSzSBv1
	W4cQ+vzQWsONuGSBUCXuh8ZqN78JVMhsIMKHEqs63Yp9Wbnow/BiJ0F0CwAN0tt4ercbeFoXESY
	4d3FuEm1DB5a+6ZgLtpGuLoZ/Zc6MGqs=
X-Gm-Gg: ASbGncuLKiLdUf170BhFgmoLcUcFXFjOFICmpaunLxbkbJhAq5oBXWFXgrkY7SKFAzG
	+vvh5xuJu7yUDdf4KrDGBn1P0YKgVX+3XwugGUvgS4ftWETFCjEcBs2H6ut1KBVOC89bNDJcNkq
	EE1QlSkaZ6xrYols36zVYBpBPGR9Fuw/4VwYNrw3HA3K4=
X-Google-Smtp-Source: AGHT+IFWH99gytw3P0zfVMJSXeN2Xdpbij9NHTw4tzYgIF0t13l3Q0lEtDYPXcr1RxaI1CKWYxMSuGj1kZBZHFKgfEI=
X-Received: by 2002:a05:690c:a0a8:10b0:712:c14a:a363 with SMTP id
 00721157ae682-712c5fecc20mr43144177b3.0.1750594318310; Sun, 22 Jun 2025
 05:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616-bmi270-events-v3-0-16e37588604f@gmail.com>
 <20250616-bmi270-events-v3-1-16e37588604f@gmail.com> <20250622124426.60c71eb1@jic23-huawei>
In-Reply-To: <20250622124426.60c71eb1@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sun, 22 Jun 2025 14:11:22 +0200
X-Gm-Features: AX0GCFsgVqhZSLBf3GcWt0M6HO7PdBsLs5aATyGsnL7UHwFWBxVHWIW6wjEdkBI
Message-ID: <CAFXKEHYDSZbuKpu7_Kj52paqdZFw_iFK8YCX+LxMHv7PNCu3sQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: imu: bmi270: add channel for step counter
To: Jonathan Cameron <jic23@kernel.org>
Cc: Gustavo Silva <gustavograzs@gmail.com>, Alex Lanzano <lanzano.alex@gmail.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan, thank you so much, but.. actually, I still prepared
actually still another v6. I was about to send it in today (just
finished tests). Might be still some bugfixes, and I guess if any
possible, I'd prefer v6 patches over v5.

Let me know, or I send it in anyway and you might consider v6? BTW
adxl345 also should follow later today. Already prepared, but going
over the tests..

Best,
L

On Sun, Jun 22, 2025 at 1:44=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 16 Jun 2025 20:53:09 -0300
> Gustavo Silva <gustavograzs@gmail.com> wrote:
>
> > Add a channel for enabling/disabling the step counter, reading the
> > number of steps and resetting the counter.
> >
> > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> > Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
>
> Hi.
>
> Given this is ready to go and independent of later patches:
> Applied to the togreg branch of iio.git and pushed out as testing
> for 0-day to take a poke at it and see what we missed.
>
> Thanks,
>
> Jonathan
>

