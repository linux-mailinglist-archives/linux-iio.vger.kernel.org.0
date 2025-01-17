Return-Path: <linux-iio+bounces-14423-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0EFA151EE
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 15:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2228A3A43C3
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202EE13B58C;
	Fri, 17 Jan 2025 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5zMDdIM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBBF25A62E;
	Fri, 17 Jan 2025 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737124607; cv=none; b=Rt69364Mone6A1r6F7yF/phTH8XPa/+GIC69IT4gciMlFLcvzqaKu1sboDeUCM7vMYF0W02SVQCqsXAwJrB7aF9d/h/wAT43EYhUXlo+gW7tVPscvqrU15GHR1s9aC2NfqpFsYilT0OnDLAmgsER/BSyalx8ek/qJ29l5deIQo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737124607; c=relaxed/simple;
	bh=iL1O6zkYTnJnqFA6yhmLLgMO3PEGM/7dDAfzdJEqBSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJNFIL4zPHfA/BBDFE2jVBFJK2uc8kfgWsO/NhCYNS/r3h0oKIBkQHPirURIqUg36T0tFAz94s7F385KK9mJ+zplUnxEEkiIDhL00dVW61DcEabC65ls5yvdrsrOuzBI9mrMdH3E2ML2c4Q8lrKDlyzF0/rnFF5Es4PTMEiL/cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5zMDdIM; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab2c9b8aecaso337915966b.0;
        Fri, 17 Jan 2025 06:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737124604; x=1737729404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iL1O6zkYTnJnqFA6yhmLLgMO3PEGM/7dDAfzdJEqBSQ=;
        b=f5zMDdIM7JqvMnu6fzaPe8OrFPrbBX1yEMdehW/hUjrxRpQ+R5sohkJ8wZIWnQhWwH
         d9EgGRmmHHlDcuoafa7BfbH84SYwWR6IJI5yBMcK7yJZ9b3pPwHkltZntDz31PtStCdP
         FkLFrU6rqqsV1UnnlbSvr9lSa8ZxLrfyIdcvOrNQnz2s3ttcCxBOViVp63v+VpU16tbX
         q9ieQQrMIr6UcvaY5Ggzzs60iM1aLLB4D2gzK1Sv2qKeB43MwqDIi9pm7TfzIJbx2AS0
         pabMKWyw6MnX64CwI1bzT52eQgo3Gem+Zwkk90HnuN8oJ4fPG0L3lzMRsOprKtDosNZb
         D5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737124604; x=1737729404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iL1O6zkYTnJnqFA6yhmLLgMO3PEGM/7dDAfzdJEqBSQ=;
        b=jYtAApBuU96LdHMnuriLHbu8S20fy3pwkLMBJnbyEivjHE7t4VfEb4pIAOSScvLFi4
         sKyXqXxgF85hR7aUhxrhQdjt9PdGcK6t4ESOVswbWnFokeQMD90BGwhsmQyeTcFuSNcg
         hOyTGLBUeHCyDgnEnlBIIjwWC4n0lMgHH66zy1tMxCc/gf9e7ofq09JWs+ShGyC4YYM8
         aeh5RXvBc+d6FKIOCa+ssavgmWmjaz7XrARBuI6WSbe04kGyo7mNtM3WnirtrX+98pn0
         qhki9RL/gF0ANsA6RTQ+WPnsPmLE3L66goQI0Vt4Zw+t/z+S9vCuiaMIvXnDPM+034ox
         RslQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhJEaUNlo7VSLHXFJplxaD13y49pEAH9T4f8yTXFUb07AGAW7Cq2GqdWm0PiUIadPgWqBVP9cmCZw=@vger.kernel.org, AJvYcCWFP+qrf3pS+HM9sOqdKE1mw7k8abe4tV80QE+Zsko5jfx5wrD5uZZziWznpzsqTVlPVxVpVQLYTSuqNtTw@vger.kernel.org
X-Gm-Message-State: AOJu0YxsJ6RAO/x5KQSFG6TjEOCSYHupYB4FpIUGkIYGn7YvW440Jv4f
	1x9lRrywyhWUZi50dLJPUlRuEV8qV36pccj1h4s+nP+/xEbTnD1Xv+fsNw1Wld1hWHEw7q+ACWT
	rk5cLHGtH29+/m6eXQE1ETTddyH4=
X-Gm-Gg: ASbGncsxadGs7l0hcOz6fr9MoxZyGte6ch4Fo/jDnrrfqQdoNgrql2AdyBvHIepA3xd
	bZLmRMyerZxD/u7qiA3Q1qZv7wVnKk0akmjEhoum9
X-Google-Smtp-Source: AGHT+IF2y4ypZckpi+SsFr+yK//9SduawIEE1x+8bxsocZ42lG1FW299Qfce653oB3pMp0iAFiCGIydYP23SVp87+mU=
X-Received: by 2002:a17:907:3e12:b0:aaf:208:fd3f with SMTP id
 a640c23a62f3a-ab38b10f4aemr251741166b.13.1737124604257; Fri, 17 Jan 2025
 06:36:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117065314.4431-1-victor.duicu@microchip.com>
In-Reply-To: <20250117065314.4431-1-victor.duicu@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 17 Jan 2025 16:36:08 +0200
X-Gm-Features: AbW1kvY-tUzRl96QdmWE0g2NF5cg1F1maC_qxDSoNMycuoM0FzHfUkKjl5iKVJ4
Message-ID: <CAHp75VeDAOofiDg--mVs2M416biv8qCeVFw_PJM_YJZq=xuvTw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: adc: pac1921: Move ACPI_FREE() to cover all branches
To: victor.duicu@microchip.com
Cc: matteomartelli3@gmail.com, jic23@kernel.org, lars@metafoo.de, 
	marius.cristea@microchip.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 8:55=E2=80=AFAM <victor.duicu@microchip.com> wrote:
>
> From: Victor Duicu <victor.duicu@microchip.com>
>
> This patch moves ACPI_FREE() in pac1921_match_acpi_device()
> in order to cover all branches.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko

