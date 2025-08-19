Return-Path: <linux-iio+bounces-22996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E02CB2C801
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 17:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8F53AAC34
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 15:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB5627F018;
	Tue, 19 Aug 2025 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Gtapy4UD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B272EB840
	for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615746; cv=none; b=B7fk7A6ZalDuewyncAwfE46woi1BDIVYeZG9N/q8bc/I64oVcrCdSjv8/xSxpUTZSWa3smnCCwmvqg6l4pVJHZ2HcBBZLVbI5yk5hPyRamgV2kcyC2F0xZr2Kr/44S3odAG9bSIIrvDm6OCSXORA7Yp+lmDlSEdKIuPSDpAlYy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615746; c=relaxed/simple;
	bh=UJ/laQvODenSS7FKqK0uE7wzV4yOI6b5LUkxJj66RJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5HMSue5Sn0442E+b2ettvQ0aL1+MXEHrDkQqxrKnFhNwp6xrT9t0GxfjqX+xo215N1yhIMrmiuAHP9mRFQS91d1zQ8BRDCTmFYkf58BEW8akqvplOge36sJULZOlUVLQRls7WbqOTFP0fKuqQh5Gl9Yl9vKU5TZ14fPVuifvhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Gtapy4UD; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-333e7517adcso57468381fa.1
        for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 08:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755615742; x=1756220542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJ/laQvODenSS7FKqK0uE7wzV4yOI6b5LUkxJj66RJU=;
        b=Gtapy4UDat+Cs3kNHEXt8nYenuK47I9UqQbFT5e3MW5X2rsC6j2I8fRSMo43jHRlgD
         F7Fv2KMGwTqch1iogPIYDqX9gAEugZ/pwE+HcqD/ETXEJapMhizgRzpTXE96wvgM0Oz4
         DmOkLnvwVdMu8SpRwmQx017Hlup7hhebrSyLs+kzsqJ7u7eTAOhg3PV486Y3g8l11Eek
         HQKprPYQmpEeJSEvYBO3/WLhbMdkjOlE4qwq6eW9ihSQEpBCaZ8LwCx6I8i8l1U06K3o
         z12hDx26gxUF6EaNptY58wR1EO1Uq9cDTFZNoApmXlDcmmk+ohOfepkvq2apiVyG75qb
         IpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615742; x=1756220542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJ/laQvODenSS7FKqK0uE7wzV4yOI6b5LUkxJj66RJU=;
        b=bnrbvFzoxhSRpHw2o8N6uewWikY+OJ7mXs0Nk/yCOtKl7JXpmdnD+XGZY4ZhZeCH3n
         W8aUOrAQjCFpn9Z1TZRH8G6ioJWm9vjXXB1AS3gR25Hj/dOXzIG7zYJyeTBMiF8hgOq3
         j613+0K/5zb4jEtt9YZT3fL8bHYkOJ1vBOcCb26yV593GiPlAgehKHrf+IlMiQvLQ+Lj
         0Xnu3fgmwsH9e2KQIFT0CyRgVo1nokur79l0nuOeaNoZvMdr3uGNbUOYPoY+RC3SWqfs
         3SiAC95j7pLGyHt8mlKKQclpZlM6XimBhogxAm3n1xw7tnpS1jHh3U+kLvK8rU9pHWZx
         BaUw==
X-Forwarded-Encrypted: i=1; AJvYcCVcYrybSFcqAq0vdnAQzoMJePvJxkdRomRKJjVg4cNjWhuJf5GbYrPp/YMlDDz6hpMac3mWRPtYSmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEzCjn2OogCBbhYfzShEIKxgxlc4TMC5noPGLn7a8XFRd+mSDW
	L/2/Hp8y3as/Qwn/4mdh43eB4JZKAShZEC2ybVem6wjo8sl7tQrk4lnCmj7WsPjNH9tWAZBmfhz
	uFrMHvtC2fHg0+hjRCtaJrY+zBVNgKAPEyFRsungP5A==
X-Gm-Gg: ASbGncsdgrbpMTjtq3KA+CIWEw3dbJq14tG3b0bZ+UTddXjRTAV7dGQ1lKWuMsv+FAF
	uB5ASd1v0etjkPKeKGT1E3d5ySo3pxGfD8zqythBN1YE+uN5Ffdx8jBO82xjAe2aroYSIBlGrph
	4EBCxxwz8nkUGaS1sHwhjl2Nx7dzW4c7quAJU9WjO4rPIQw5gPT0wdWbSNCCQvZK07vrXm9kPBD
	V1B/seT+/fQmCgwyjNtaYtyOfqnrBIzmFGbvhHbCg==
X-Google-Smtp-Source: AGHT+IEQt3BRtkjZ/CEQyRxB5/fQWuPJmmuJup3AesqNZ68WSzASFJZwiqG7Tu4QPuyMPNUXWCO4kN3arXh/DgbkcPg=
X-Received: by 2002:a05:651c:4c9:b0:333:b9db:f994 with SMTP id
 38308e7fff4ca-3353176483emr7860001fa.6.1755615742093; Tue, 19 Aug 2025
 08:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818183214.380847-1-bcollins@kernel.org> <20250818183214.380847-4-bcollins@kernel.org>
 <01eebb48-17ba-467b-b227-96784917c50b@baylibre.com>
In-Reply-To: <01eebb48-17ba-467b-b227-96784917c50b@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 19 Aug 2025 10:02:11 -0500
X-Gm-Features: Ac12FXxMP6uMsuK5LruMDdiY1MXNE_Mg2NbXu81YxUgiHffjOZ0aArC_GNr_vrY
Message-ID: <CAMknhBEbUjoHfN+7sQgwo8eW6u=Qt-Bwvfq4JJbo27oN4D2Sdw@mail.gmail.com>
Subject: Re: [PATCH 3/6] iio: mcp9600: White space and fixed width cleanup
To: Ben Collins <bcollins@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Cc: Ben Collins <bcollins@watter.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 9:55=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 8/18/25 1:32 PM, Ben Collins wrote:
> > From: Ben Collins <bcollins@watter.com>
> >
> > Make tabs consistent for register definitions and also fix width
> > to byte size.
> >
> > Signed-off-by: Ben Collins <bcollins@watter.com>
> > ---
> Reviewed-by: David Lechner <dlechner@baylibrc.com>

I made a typo above. Should be:

Reviewed-by: David Lechner <dlechner@baylibre.com>

