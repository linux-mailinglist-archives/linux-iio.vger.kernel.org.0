Return-Path: <linux-iio+bounces-7933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE9193D162
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 12:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63DE71F21A07
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BC21779A4;
	Fri, 26 Jul 2024 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsuB0gse"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7557F8;
	Fri, 26 Jul 2024 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721991392; cv=none; b=ippfRHpJqMCZVXZWRIU4O6Y59WhZLyyufUi2CsHc0/xjPK7ZODjqa4pO1vHKmfb/W2gTbS3fS5io7H2K+p+mNG1eiasPw9HqVU3hPBIlbTfoA2nclsiZKdkYtWGF8ov9D8AFp79xxhSUwhjZ4LC15jpx8muScttRYCllgmZbKyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721991392; c=relaxed/simple;
	bh=oKNueoEH0ZwpLHiT5+AGyjA9KWLfAAD2adLpOO4WHtE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SjyjTsoVL+rUsHf+zId46/k7bqIEkrgeqeRd3MB60BlSlsry8DzmZYXrM0C51sP+YNHf1LSk2DvrBFLe8OM1zYQDBQQVFRlAf2f4x8ePjrEIaGPnYG+9wK8y7C5azmKL2VEK9wqYo8FClwKTeHah+G6SziEI/Fa19cnMk5/AaYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsuB0gse; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5af326eddb2so729020a12.1;
        Fri, 26 Jul 2024 03:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721991389; x=1722596189; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oKNueoEH0ZwpLHiT5+AGyjA9KWLfAAD2adLpOO4WHtE=;
        b=RsuB0gseBE9ehoHGHsCQ3l05iwkFS6D6kQKsc6U0zCAVZWxKfwqEKqV5V8nqArNXOk
         x4gdGuh0vW2uDNcWZ8qqP6LZiu1VDXfasOsKFmuE1NeV0hCvODPaleDr7cVdXNbzNeul
         7neHoDY5ej1HDa0hCwgrGnAnh14V1e+LQcVp+/h4lcNqE8KuQLWVLrRcxxIx//q1l/jg
         F2kMpZ5LzQGuoZL7KQr1w4EqaV5ssRDfj/Qtc6cxQ4knZk+exycCnGaUL2ViH4D8nZIU
         BpIwLadCuXOxEfSZNeHYp4Y6LaVBCRbAL7y2Ddntotk7IkFIG8f6y8xYP7WcEzWV/rJz
         FSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721991389; x=1722596189;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oKNueoEH0ZwpLHiT5+AGyjA9KWLfAAD2adLpOO4WHtE=;
        b=C97q2B27epoeJ1/2OOVPRfvYZQRDIZwLmSBHJCPd6CgoaoQyGVCjbvV0FDgyICgFNV
         HyZK36Fc5eXwTB/jB9O2+XvQMKqE5b8uGI3wIbLK3cj6kFw7flMJ7RztyJx7YpH3qQJm
         aLhdi+A6G1WliIOUrWpPw7TmnfhM2djQA+KlYA2ZYxQLVRSxsemT1t0Jieibgv9ANgHE
         HuWsE+7kXYguxgl+z1Ow4EHFo2bTnxXiBUWy9K/zMQfbv8lXPV+PhSjI+21H8j5xqdYR
         UwEUBXRoaAqeE4hJNvWZNTk5UeC/iOAwLeYouwzysQkMmhDb+crCtk/XEDj6S+DUTW5S
         rUdw==
X-Forwarded-Encrypted: i=1; AJvYcCXoImBwUUyJI7S2D0si/W88N5yuDCsrGCQ7x2c6D6+moLMsEMWHDMXAo42D2ysUEhZNqqFOwsuei0N5CBTU3IejmfekVUruTbOqUNs2dFlWPxsP2TKv+yNT9Hx6pEANGK68bMAcnJtq
X-Gm-Message-State: AOJu0YwSKQyE4BJOrXnDTWz5mc9dWcAWjd82ElVcIE7aUrz+7XZLVD0K
	FZTVVv7cQ8b2AKj5I+THMk39UOM4iUMCgL9+BObj1C19urWi0Bs6
X-Google-Smtp-Source: AGHT+IHm/uc98yx0YVfPVV0mdfB6o62dIPmxgET4rdpibDAyjPU3HrB4jhIFCTzbo1k5Q4W5sVxDwQ==
X-Received: by 2002:a50:baa3:0:b0:58c:10fd:5082 with SMTP id 4fb4d7f45d1cf-5ab1a7af0f3mr8566405a12.10.1721991388618;
        Fri, 26 Jul 2024 03:56:28 -0700 (PDT)
Received: from ?IPv6:2001:a61:359b:e801:d44:32b3:6924:10d1? ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63b59c95sm1809400a12.50.2024.07.26.03.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 03:56:28 -0700 (PDT)
Message-ID: <24ca48955e3b005620bded16aabd91aaa6997ad1.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ti-tsc2046: use
 devm_regulator_get_enable_read_voltage()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Oleksij Rempel
	 <o.rempel@pengutronix.de>, Jonathan Cameron <jic23@kernel.org>
Cc: kernel@pengutronix.de, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 26 Jul 2024 12:56:27 +0200
In-Reply-To: <20240725-iio-regulator-refactor-round-4-v1-1-55e9dc1de325@baylibre.com>
References: 
	<20240725-iio-regulator-refactor-round-4-v1-1-55e9dc1de325@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-25 at 14:22 -0500, David Lechner wrote:
> Use devm_regulator_get_enable_read_voltage() to replace
> tsc2046_adc_configure_regulator() which does the same thing.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



