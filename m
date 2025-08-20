Return-Path: <linux-iio+bounces-23033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA06B2D96B
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 11:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B0E188C01C
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 09:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552F629B233;
	Wed, 20 Aug 2025 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fl2lEtFI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707312DAFC1;
	Wed, 20 Aug 2025 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755683579; cv=none; b=j+dEDUwU6XCAneRD5KX/NApTbhOnQOcx+W6Wi6WkyC3OLBLm/ylX78l36GrX/RJUFSHUjun68IL3P2OBm3YxgbeZXlL5xc9YoF4zTKjoRV7CgWvfE4B2TKOV+2qVJun7rZFeeitYkA3vjXSQGuF5I4OkUxcpUsG1RmM5jJ9Iy1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755683579; c=relaxed/simple;
	bh=u9uYRjdMv075l6PIR/dTBMlODMX366ucyedSlgz1Gxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TE5TXqiaWqvJqaVmPHzYiBpWGu8YYKA3KnTMl+GCW1KboIvBH88gqAfGEBdCZwyGz3l4Z82xZwKtX5sidkoDq4fkOzgQ38k2Ey6wA25DCHc7dMiOvn2j/pCg0gUD7b0qJCurlz1GP+eHdeYwlz0dPZwU1SRWiKqDuGdfbNMKDBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fl2lEtFI; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb72d51dcso875437766b.0;
        Wed, 20 Aug 2025 02:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755683574; x=1756288374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9uYRjdMv075l6PIR/dTBMlODMX366ucyedSlgz1Gxk=;
        b=fl2lEtFIkVRE2lsxwvxOHRYmUGUnXdY5GJJWOW9E9dS+Uk40RwOy79BAEbmV1A9YmV
         VZUWMSWuxhwUu5fotco8DVCAXC5BjJj+TrdWl6X0XpH6vG5WdPsvKIT0t8fMyQvFwKTu
         BWji3TwEdYEDk2g4oAEUrYakrBxkFbqXby+ibR7M45hxxasr0Mp4Sc7WtXD+P5wsqw2g
         M2WQHsiAUuQGFcdDIBCd2+AnlLjSNmioi3UJGFwxdX9hJ7nLXK1Ua4EMrXC6+HbrFBYv
         TdTZqaQ9wqBgAXyS57waNTFLc0mts1feKCQAuzTFB3C8EFiwW8jpCxGr+ZXIQlYoOjQ1
         zeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755683574; x=1756288374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9uYRjdMv075l6PIR/dTBMlODMX366ucyedSlgz1Gxk=;
        b=OrXGNYYofjNdc1+Sfg4a/PgMeeCLZz588f6O1+gUGN91gAI7xraO7cOD9fYJoCsvE8
         enuONT9ZdL4izqA5qeu/UA4oTLVK6kauxrYmpZbo7t/ts0KlOZ/yCuvUQK2pHE2emNjb
         DNdqDJ6NiWyfPnt0qF9BzNFYIzaccd/5oJVahyp1A/gd4QflOuDAORDELXNszz+wzU6W
         uemPMxo711WXOULmykiNshZbxAISSPxBIzpQk2UJiJCVfJY5yPEyg7Qmc4mK/ORDFYh0
         /BATbjaCgdkxzFw/anxOfsphJ5tcq0rvGPZZm3xm92r0yD9R3osmRIqMbVgW1pKPf4Ts
         qZqA==
X-Forwarded-Encrypted: i=1; AJvYcCWuqt2SOpFfVm/5bmXwujAi3qpbiHYM4ZNxF4yZkgQCAGBJ8oxDSr3MFDhjNNAd6kCJKbv/3Pl0WYo=@vger.kernel.org, AJvYcCWzp8j6cwiB6hCVN1w/A2EmAKk+pScP2elJfrdm+Acu82QV+b4pRFfIEMZb9SZ1dgTyLo1g6Vd4xQ2k14gi@vger.kernel.org
X-Gm-Message-State: AOJu0YxSqHVL2CaDBd9d6RuIIiEqfKhHFbBHkWCZ+QJs7O8UiF8C+Bzo
	Sa+GXSqbvapkYj26OQ3gU69dOv4J/LjYUNsCEfOxamCPunPj8yqVWDzgbZ37C+guv+gea3lzt81
	vJ8toCb5AipfFo8u5fq7pE06q/rRrfBc=
X-Gm-Gg: ASbGncv/gLoaH8YErT58wWaQEddpX9NzaCC6ao07n4orGncFnGbEBmuIfvmFEEzNT6G
	zOkRKZcni2FI0n8D0Bfa6spLAVezA4mcvyYT8893JgNb9FONKw58tBVmWin2uo1uyNwIw7IxBAs
	TDSeuKpznG54XW1wF91KbECpYK49R8suBmD+evzhEJJv1nBxVQU8bJ0jeS6o/2UtfWCW4A8IwQm
	9v9MlTtnA==
X-Google-Smtp-Source: AGHT+IEqLNj6s7JGPI5J10T3PIT0G1ZblMYikwSDez3UXjYHwf4mAPTJU/mWilnwAxR8b7eYeW286woPMUcNE06+0nI=
X-Received: by 2002:a17:907:2dac:b0:af9:3ef6:86f4 with SMTP id
 a640c23a62f3a-afdf00fb159mr189733466b.20.1755683574290; Wed, 20 Aug 2025
 02:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820004755.69627-1-junjie.cao@intel.com>
In-Reply-To: <20250820004755.69627-1-junjie.cao@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 20 Aug 2025 12:52:18 +0300
X-Gm-Features: Ac12FXwc84J_va7In0sSLVCwiScoaEQxVZfEGZAQVCVk70zVR_-Mmfrtc4GKm1g
Message-ID: <CAHp75Vc_GYzDw77deKjK5Pn9duGi0p8W4C2Z9kmVWBWK5qgETg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: core: switch info_mask fields to unsigned long to
 match find_bit helpers
To: Junjie Cao <junjie.cao@intel.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 3:48=E2=80=AFAM Junjie Cao <junjie.cao@intel.com> w=
rote:
>
> for_each_set_bit()/find_*_bit() expect arrays of unsigned long (see
> include/linux/find.h), but industrialio-core passed const long * into
> iio_device_add_info_mask_type{,_avail}().
>
> These masks are used purely as bit arrays and are populated via BIT()
> (1UL << n). Switch the info_mask_* fields and the corresponding function
> parameters to unsigned long so the types match the helpers. This removes
> sparse warnings about signedness mismatches (seen with 'make C=3D1'
> CF=3D'-Wsparse-all') without changing behavior or struct layout.
>
> No functional change intended.

Thanks, this is better than v1.
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

