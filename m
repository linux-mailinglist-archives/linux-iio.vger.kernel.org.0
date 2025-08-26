Return-Path: <linux-iio+bounces-23284-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C596EB3567E
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 10:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC283B4583
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 08:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194AB28506D;
	Tue, 26 Aug 2025 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cm9c6XIj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5366E19D081;
	Tue, 26 Aug 2025 08:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196138; cv=none; b=Qc6FA/MwsfoyLA66nCDlOIUhnNhiiPXYwxewjRjrtk/RQR7D5fG26s/knktmB5IQ18FHLyPCzyLRd3eivXvQxhCZVW9TWs0NV70m24OUyxYzVdfMaazv0NWSRrkNVQ2JbGiQw3onpCV0Y53tuB8FmtgNm3CA03qPuUhNUlWNkxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196138; c=relaxed/simple;
	bh=vH1s/qVM+wKYkLAArPKBMK9dC9IhIastVVlWT81ed4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/nQqgW7Ny+IlsQZQPe9wLPB/eQ+cXad6fiYtV6vqjwG+MUwVzz96QQ0lFIVD/EpeaFr2stXk1a3v6TMLd3FcK0Cr8cfoGy6jo6NZEwS3KuCEfe08tzu63RzxZfAgbe2IG28eLlqaLCaerqe3gEpHODFkiHiPJromcf8w0zyF2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cm9c6XIj; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb78d5e74so1013264466b.1;
        Tue, 26 Aug 2025 01:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756196136; x=1756800936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2q8212zjEFCbPtMQxkB3qmRsPilaVELd/edlGizi68=;
        b=cm9c6XIjWOgtl7zBIe73AuCkF6WrLBpFiUvXgeuDVgEVdrmlt6DIjgEub8UqOXarPv
         +uamvruXskNaHaW8CPQAP9y3OSqhyhTkiSWJzF8cfF7Oy1dD3BmpkaUWetQAFliD4rl4
         jEleSqq7kqyZv1LGfCZ+5iGJztXNJ1Rjzq/d8LD+BlIiAQp78m66NeTlIAR3pz/5IRJA
         tvmIvpw/r9gC4P/OFwx09GxS7exx8ada68M/+EODAIWX5giwpg2Y2apfI8/i9hkNALpb
         VVgDhZqOv+mZZdHF01/LQpLGSQUv2UgtOG/wzjWvd+9vxw9KksXPgBFe8toSxIcvDJA5
         Op0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756196136; x=1756800936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2q8212zjEFCbPtMQxkB3qmRsPilaVELd/edlGizi68=;
        b=L7em1jnPib0DL0I3meZQJG0imH2sMWk1jhngEki/z7ydgab5ecbmCW7swuO7R3T+67
         oTD7avTKOnbHCBJIc3iXPZJOVDo8DwuDw0EuWkPAkBBqmK96yCrH/hno8jPAo08NY+PY
         qABPZHrPT0UNQ1iExBR5RAaJjl8ytiSvdx+wVYHV+wKhBeEfsytXCnz+MZhGr13VIvkl
         wY1y0JQPJOa7HUSraBzHUWukAQ8GjqmRQTQZ8C5N5eEcvSzF/xm6gXKzNSIJxxohSL86
         EfsmB61B1I+DdFkjRYbEIJZ7vghzgzLB1udAjRmvCtrVWx8QjT/UacYhsBIC2JPGLqpi
         vOxg==
X-Forwarded-Encrypted: i=1; AJvYcCWQd1ZJkAo2D/Mbv9FcawBLgN4PmgilXAodX0i46IBtPrNsMLxOVtehc18SJw/Be3iSo5QkSAIe1oT6sFqw@vger.kernel.org, AJvYcCWYQhxqgrG0K7eO8ieDkw4zVa70HJXSAz9rT0W/MgQU/ihZJUb4C1hjKNkKJ+pP94dZoxWemOvr/4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1/21uxA9YE6KIACiqv/FUY02UEvcuoelB6dULN5BdqgjFFAe+
	BS3ptsLaPBsTBQDqk8wD1q5Sz+XznmhP5RiVEYUTxlQCJMk1DG6nYxe9XyF/VCObaEE0OLWjStO
	ppmtJyq3lstttpyLbiC1uDDH/NlXU7GA=
X-Gm-Gg: ASbGnctNoA7SE4zQoD5G91JzIkdlXntls34SRXy/n9vUaBkGcyuerZK5OAFIGrDL+5F
	OkHPG2m7WX7XuVKIEbSiD7AXoqHu2SfjBXpBfIA5dTw3nfH+7r5eovwdxwKugcSdEIxceCVsQ/+
	NrRiFUDkHkRauOzqXss3woTADoEWLG37s4RdPb1Wr5uwOm7rRQq8wLVKhnxHviW9v3QQLmQRXxb
	AckewU=
X-Google-Smtp-Source: AGHT+IH7iKsMwj3JRi2VS8NEIMYGY6iWHLh63hFgWW+s+d8mYzIC/E9H9VUPcYJxf9VJPjaxwcdQ/VEFKrNsHM9xLmw=
X-Received: by 2002:a17:907:1c8c:b0:afe:114f:11fb with SMTP id
 a640c23a62f3a-afe29631283mr1251002666b.64.1756196135448; Tue, 26 Aug 2025
 01:15:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
In-Reply-To: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 26 Aug 2025 11:14:58 +0300
X-Gm-Features: Ac12FXwedsMzxG4MGOIQh3eF2QdfSRTLN9ZLC4Ma-S20B9AsxbFv84W_9Qv4qGU
Message-ID: <CAHp75Vf_QL4Nm8KDCVT5GQaOqeQtpg_Tz7HTNt5YNFQ0fAAUEQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] iio: mcp9600: Implement IIR feature and add iio
 core support
To: Ben Collins <bcollins@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 3:10=E2=80=AFAM Ben Collins <bcollins@kernel.org> w=
rote:
>
> ChangeLog:
> v6 -> v7:
>   - Remove extra space before trailing \
>   - Don't add extra white-space
>   - Remove mcp9600_write_raw_get_fmt
>   - Separate out the mcp9600 IIR series into its own series as there is
>     a lot of conversation around implementation.
>   - Add rework of ad4080 to match filter_type "none" logic

Wasn't v6 already applied?

--=20
With Best Regards,
Andy Shevchenko

