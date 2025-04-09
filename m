Return-Path: <linux-iio+bounces-17875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE7CA826D5
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 15:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1133AA669
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 13:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F842620D3;
	Wed,  9 Apr 2025 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXOkg183"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8129D25F7B0;
	Wed,  9 Apr 2025 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207059; cv=none; b=gMpKfYJFVrV7n6CvxOBfzsDAh20vvklgCQLEcWP7x5FiRDaW4F9L6yrcakN4QCtPA9v2Qr3QQ4d7cUZxCBLKMg6lLKoESLP+bOkyYdbF6MqKZu7cxg0vx/R3CUiao5RClpKS7owmvyM63hAmHLyV71DYXLOw3IGcfA2OiMviB+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207059; c=relaxed/simple;
	bh=+KniGIvKM27UhagRqjaYWZ4xLmaeUIgT5ELjSStSOfw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZXlwz9fS/1DTHyzjZvVnZ/katxZxg4DZ7M0DwxcAOLFCykse0Bx5RSrHoPuP+X1ttopyrdp+OX20k0DxCywAdGK6qYISiVHxZlewvALjJjhmadPfPkyw+WmPKXHdwFKWMMKMHh5fWqlk5lEIZ+creqeAvf25kegx13VQltNvywo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXOkg183; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso72417265e9.3;
        Wed, 09 Apr 2025 06:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744207053; x=1744811853; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+KniGIvKM27UhagRqjaYWZ4xLmaeUIgT5ELjSStSOfw=;
        b=UXOkg183Qn3CU/CVxG77v7ZvkPnbHfIc5+bLj/HuodCC3bHliX3oUhib+rEQEyriK3
         4mLnozQhoDnIc39zeaa3+T76+3nVYrkBIOJsN2TG/RqymvGfD5n15H/x+BU9aABDh8zD
         CUbsYvDaC2gM/bvNI4vGJgihEzp0Cbi1VuRIMxXCLKAjoIhLF75D5uX6xMwmKPQ6cdmH
         5T0wwAdayIb4GQVHZveo/bVQQS2vBpahM1k7YVtQjPJTAtn5UXH1jvwer3I6dXwnp0Z8
         KxgEloOCgmV0f5U/rfAS8ydOEDl2zzi3lq9Nu+HQ6WQiLiTyx8u69sS9rZAF7S/euypo
         lsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744207053; x=1744811853;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+KniGIvKM27UhagRqjaYWZ4xLmaeUIgT5ELjSStSOfw=;
        b=rO4PQ4+SECcvBdPAAk+QJYVKdb8emCO5HNo14pYjClGuvNBVHRzSg82c0AZ2Tbk0Fk
         kHd9oWsAJLVgDCAbtncpyJz0CK5JnfXPHCWY7Gf9q9NYc6yS0FXfMODKanEt/oF/xAU8
         UxRulJGIUI2VU6HIQQG1nyOj4+9Y1WmKJr7MG3trCOtq4Fmgh8Gc+PSRoK2Fr0/A+IND
         Bi1t4toCTW4Now7gAFgGPnlfApxx8JydS3Lvy3Jnzb18qfXF11ixgRmnwuGuvTADWWr3
         rPn3vr8kh3YSVlkV/SaMfEJqdpeI6YZkJN+eFrV1i7jzjYXQ5HSZepfsFSblY+X+af9M
         ChGg==
X-Forwarded-Encrypted: i=1; AJvYcCVu6dSKEw06UE9vydzruuQXWPiDHlXfUMWH4elY8+oOUI2qzGzngu0h80gRuPT6Xc+/BXNxQ7cL01+Shtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvhkRycIQSfpU7zzi+esljqPV/aJ0zfwNUuV0tGgSG/ppO6sQw
	5WDBxcOVJ2MdgbpZqjSkwVrlawdFOPBEcSLy9lTZM7RI3BVOPvxIOMbLqkyK/n6ZoA==
X-Gm-Gg: ASbGnctCs4XmwGMuAYfBqW4ufnVeAPqe7Vk56WcvHBUjecI/2EqBraZgxwRbCWneFc0
	JuRcFWwdRfG1eqRDmIOTL4u9WEyTv0l9dWjzvcD50mkQ7rXG4t9nlcy9IXtYJi/AxbGdT/FhyaB
	gjlT9oW9RzIZRwkQYImrZDdq9Fgffq8ZrDWQlNTU84DcvK95aRVkSyB/KQQR9426t5eSyV0enrN
	PaoIoKzDG6AAHz5+WQvAGeCL8VJlBXmIu5x1U45U/t1eJKQqYL7dfA8pz3zPJbElxvebYivyze3
	oaGKj7QI83MO1lDsS9coAd3jdeTaHOmELbecTEmGA39qb6K98wxeBaOCyttGSSW4fZJ4vJKB/K8
	aUkgbL/Z5ipCN
X-Google-Smtp-Source: AGHT+IGfiZr1Uzb1oCZNL5ETHd2w/Hr1bBuaeR1fGh7jnRFcM429pWR0YYMUlEgumSZoZdByXVtcsw==
X-Received: by 2002:a05:600c:5251:b0:43c:e305:6d50 with SMTP id 5b1f17b1804b1-43f1ed4ba2cmr24790135e9.24.1744207052790;
        Wed, 09 Apr 2025 06:57:32 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c817dsm16963225e9.23.2025.04.09.06.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 06:57:32 -0700 (PDT)
Message-ID: <ac50109f06d7191549a91779028aca6d639998cc.camel@gmail.com>
Subject: Re: [PATCH v2 0/2] iio: dac: adi-axi-dac: fix for wrong bus read
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Nuno Sa
 <nuno.sa@analog.com>,  Lars-Peter Clausen	 <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron	
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko	
 <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan
 Cameron	 <Jonathan.Cameron@huawei.com>
Date: Wed, 09 Apr 2025 14:57:33 +0100
In-Reply-To: <20250409-ad3552r-fix-bus-read-v2-0-34d3b21e8ca0@baylibre.com>
References: <20250409-ad3552r-fix-bus-read-v2-0-34d3b21e8ca0@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-04-09 at 11:16 +0200, Angelo Dureghello wrote:
> This patchset is intended to fix a random wrong chip ID read, or a
> scratchpad test mismatch, tests done in the ad3552r-hs driver probe. The=
=20
> bus "read" operation must always check for busy flag before reading.
>=20
> First patch reorganizes a bit the busy-wait polling code, second patch
> fixes the wrong bus read occurence.=20
>=20
> NOTE: due to ongoing changes in adi-axi-dac.c, this patch is intended to =
be
> applied after the linked "ramp generator" patch.
>=20
> Link:
> https://lore.kernel.org/linux-iio/20250408-wip-bl-ad3552r-fixes-v4-0-b33c=
0264bd78@baylibre.com
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

LGTM,

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changes in v2:
> - invert patch order, fix first.
> - Link to v1:
> https://lore.kernel.org/r/20250408-ad3552r-fix-bus-read-v1-0-37add66aeb08=
@baylibre.com
>=20
> ---
> Angelo Dureghello (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: dac: adi-axi-dac: fix bus read
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: dac: adi-axi-dac: use unique bus free=
 check
>=20
> =C2=A0drivers/iio/dac/adi-axi-dac.c | 40 +++++++++++++++++++++++++-------=
--------
> =C2=A01 file changed, 25 insertions(+), 15 deletions(-)
> ---
> base-commit: 6fb85f14853ddde06d57030c753168402bf69cd9
> change-id: 20250408-ad3552r-fix-bus-read-1522622fbd2b
>=20
> Best regards,

