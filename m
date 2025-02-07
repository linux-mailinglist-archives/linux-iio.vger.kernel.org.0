Return-Path: <linux-iio+bounces-15130-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95C6A2C9E2
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 18:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DFE3A4F00
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 17:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C731194AF9;
	Fri,  7 Feb 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtDEsHU/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BAA191F68;
	Fri,  7 Feb 2025 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948337; cv=none; b=Q3ToGfpT+/LVuyWRiobyFQJkwksIuOIQLYpM7zE8nYDsB7eYloLe2u/sBpkPA4ql/rQgYym9raumFymMWriOU86zhXQ6VjGloluXYhc06dq9hhTm8p9sijoDsvgCUsbYO7rxGsSyWkqdw/wUiITCeaBWUGJXjZm1iJA+Mgg/O3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948337; c=relaxed/simple;
	bh=IYip1YqhHsS2uzPv6Wu4cM5VHM9i7DheidqjHcfSWek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5nGG6qHJRV5H8gbukMqtRVsAgel2J/yCaJg9MznnT2inZRT8tRiJEgksrFgXzfxbMCRDbP1zk9qduPcJumfZ0c0ICKlOhvHwj3kZL/TPx/pzHvnd3a3V/Se5fNqYqsmM7SK0VBYLHEjR05G9L+UKEuyip36/Ozc6rhsrgoaYUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtDEsHU/; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467918c360aso27568741cf.0;
        Fri, 07 Feb 2025 09:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738948333; x=1739553133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FF3nTXMvJMGvDQSF2A0V6jkD2B7Y2ARkN/opiAPaKdk=;
        b=AtDEsHU/J6vmIOUuDG5FGGjfxqKR796DusNG6AGnJCRGmijFynQDxqAEAUd1e/oIPZ
         a/iVNVUe00Dn8go7DktwmDe2/kLxIsF5AVSwvnrKV5diG/NBWDpnVzXCBYB+vkwga374
         000d4OYHxSy/9ZjEu/B3yHlwGY9lo7hzJs1H6UpoWQqh8Qs+2DOlakzHgYVMIV5pG8M7
         KDtlt/0t6SroO5CsP+IUzNjjMhZybqPMs8k7YUUAGx6DSR+77EiiTyn8SMyOssJkGJWb
         zZoSiu4cmhguhjnVCQvrCjeywc1Tb4LTNchHHnUAE6bu+9LvkhMEFGrmzlX1ZOp/saXj
         jeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738948333; x=1739553133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FF3nTXMvJMGvDQSF2A0V6jkD2B7Y2ARkN/opiAPaKdk=;
        b=DIE4xrN29bImxtKzdn+q5N8ZUagLIULh9bXeng1Ado31dYt+wq8l1j6CXoV5EebQL2
         c2iFaCrpOFe9UX2GKljuWyUFXbUuAtziuzO1V7uQ0FzGTHO7foqqCGMrNR09/5OAjVIJ
         t3tb7h3DlFCWE22OSEtL3KzqnST8lfNpK/cIDji1LT53p81lqalUfJpZi+b6VoMrdvOW
         Yu1J/pM33uennpaH/kbn24wljijhHs7Jac1UttfWfJtQuqg1rwx2CUIObdK2SSPGkUl7
         qfPEA8ucbR44foHYGQwD0Sf9xWLVRPBpQQKQVZiQ9m24PrC1CTXjEIHLf8ZOzmU5As0y
         kaiw==
X-Forwarded-Encrypted: i=1; AJvYcCVhXOsJZ9DUEI5h4ByubO3aJ6ZsemJcwArwy00ZsT/vyfVzHkKx4xT9jDkAQBQvVBsbsSC+v2LRfvGkBBIy@vger.kernel.org, AJvYcCWY4bWj6nfnPrnnlwDs4R102EaaJqGp6qHoJmGgB2JwUy9YlHh4FOfddqghnwjPUIVpDsRyoHHvqIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFJxgnh2rD8jgah8Uct10UUoLd/GVwZw0bGDPobdd7tU3XZ44C
	QuFdHv8vkww0W3H3JXlAlVa7V1SdxuCqbP1gJHTuyKtx4EFQMgJu
X-Gm-Gg: ASbGncuVDbBw5qY+HkMWiy1Pde0hkv7DaV+HspObTVhY1ijNbOWGFP16d9gU0mPkxi6
	z391j2AvGedLcAbdr+JHzl1K8jc/5VGtBxU3AcSCc49zKEqHeVwMIxveDlciIMHbMQjqoAYH4/Q
	ZQCKeeG68svW/xSgV6YQR1YB1jsKDk94Ma09eIUIJ/OrIf/7PsM7NYuJebQTHZoH8O4mldsqfKh
	jy1onq8ZoQHovYRe9FvhSFRk9BA11DHzzMc6qSFgL4Hibm9UIrlgkYfY9MJBW0bj1NJG24k2sOe
	IRmywFgfY/pTYIuSJg2Pr2V79XzSE53w0jzP9zqsHQ==
X-Google-Smtp-Source: AGHT+IERnOg7o13xEbrCeMl6GK6b0Q4GRVFscobpj8AlyyUB02myGt1e29vEfu5Qeugv6eCrfFgJgg==
X-Received: by 2002:ac8:5f54:0:b0:469:715:d965 with SMTP id d75a77b69052e-47167bcec03mr44315641cf.42.1738948333182;
        Fri, 07 Feb 2025 09:12:13 -0800 (PST)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47149275d5esm18776981cf.8.2025.02.07.09.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:12:12 -0800 (PST)
Date: Fri, 7 Feb 2025 12:12:10 -0500
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Cryolitia@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH] iio: imu: bmi270: Match ACPI ID found on newer GPD
 firmware
Message-ID: <6ktkjyqg4itckmadtbjiuhodcjmjxzg74esahdp676kfmmcsd2@2h3bkpdwwdhw>
References: <20250206-bmi270-gpd-acpi-v1-1-db638cfb9a3c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206-bmi270-gpd-acpi-v1-1-db638cfb9a3c@gmail.com>

On Thu, Feb 06, 2025 at 03:09:42PM +0800, Cryolitia PukNgae via B4 Relay wrote:
> From: Cryolitia PukNgae <Cryolitia@gmail.com>
> 
> Some GPD devices ship a buggy firmware that describes on-device BMI260 with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40[1], let's match the correct ID to detect the device. The buggy ID "BMI0160" is kept as well to maintain compatibility with older firmwares.
> 
> ---
> Some GPD devices ship a buggy firmware that describes on-device BMI260 with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40[1], let's match the correct ID to detect the device. The buggy ID "BMI0160" is kept as well to maintain compatibility with older firmwares.
> 
> Link: http://download.softwincn.com/WIN%20Max%202024/Max2-7840-BIOS-V0.41.zip
> 
> [1]. See the update nodes in the archive file above
> 
> Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>
Acked-by: Alex Lanzano <lanzano.alex@gmail.com>

