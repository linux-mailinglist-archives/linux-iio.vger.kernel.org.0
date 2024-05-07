Return-Path: <linux-iio+bounces-4866-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BBD8BEEC5
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 23:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13D51F240B7
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 21:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6A973539;
	Tue,  7 May 2024 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW4YYgwR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886842746B;
	Tue,  7 May 2024 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715116559; cv=none; b=DfcKB43KsGAYh2GpcnoTP1uXLl0liY+NgUOF6I/dze5MFm9ZjAgNBDVeRCiA13o9Z8hD1HhI7vTUAURMccIxij+s0Lnagx9yMYT1Udl3MZSas/M2gXdw65iz42c/ygLE8Wj1luLywHsKjAVhTg4QrX2CuEeJ9JHhkuUSpuMgyD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715116559; c=relaxed/simple;
	bh=goUkuLckbYtMinqNxuCVrvPMEnCgp7dtnW5xcRA5XCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHZdvjroxPTI4aZp/Xt+nvZTd2Sk/0H9vTuvFcsWoOtB1c5k/Q9AILXIQFUzQHKFevthlqNBYba+El/j0dSnzqsesZzxV0OjNRyRjMJCqae+me8PrJ1KGr6c3Y+KZRXKWFa6JGhH6HCgfMmu4QkFqlULi62KbG7SBLWaitYhSdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hW4YYgwR; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6181d032bf9so35382707b3.3;
        Tue, 07 May 2024 14:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715116556; x=1715721356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mYeGMToteaskIs6sMPrkW/JKjEbgC3kWhMUNPICMUpk=;
        b=hW4YYgwRIZ5ICwtN0PsY/dE7VDSGa5C46FAZQCZrjcuOFdiIUNV70rYS31wdJzTTRR
         LGDUDvnOj1AlDNr18INE36Omcxfzh/0GuKrKE7SnzMnz8f9JJuz2Pc1Ky3Z3+vxXRGud
         dHxs3u10wE87d0vKF2+63vFf/9dCNi2vWdKgQzy8HuWMCcsUWUILzzBYd7eWwknof3zw
         WJcyCW6PCVs02szeK/bYtTab490bl/6wiGZ8sEecP/85ZYMyI11xzapV4cuVdIMdG/iW
         wyoGrSQIdfVut1uxsF3/+Jb5R+MBtJEhQaAUoDYYvIliAl0xEOgfIiPfYwWJXWPoyPA2
         p51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715116556; x=1715721356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYeGMToteaskIs6sMPrkW/JKjEbgC3kWhMUNPICMUpk=;
        b=YmKLOIlfCvhI4PU7GB0R9tG3DAaA1M/ZWP3+i7lKFcroF4CSdhL0/0rC8gM2WuevmI
         QpRfSgrcQ+o3rCi3Bz37iCKKWIBXIS8DrygBa6yE4ib8xJ3WTPOZndw2KZ+Ss+nLjDMj
         f1ayK2xeq75t6FKObMexn2WxedYbhr6PbPD/4xME0bwoRpel6ik+6XqOvqeXHhUaZkGP
         VhXWkQCQA3yWQ9vyYrQiYmVMg+nipEhNUjR7YUkB+bnmmksfUyF6VMxLicRX5qGNJBkv
         tZ6oKh8amsCzwoKwoBHj0DA0n3rMUC3rPKsvd3LG33jxzdsoFDAvoiwFntOky1sivM+g
         trHg==
X-Forwarded-Encrypted: i=1; AJvYcCX+VXSNQWR6vjfy3/2zkbVKUbfBfLh4b7HyuPFc/gDAFZDIp0lk8y2KfDSiVcyOmarO22CP8iklghBH8IDAlDzQinethtZxVuKdhLnWHgyTnlPf6ct0mEUDS7sSy0PgiGs6juP13jWodjGRSGDVHfoNBuITa7q0m8vxC+JFGyJyDCVnkbejGOLGecgthreNKdROcIB/8aawR5qz0Lvl9cERYL9oIzPLpQALC0rfQWGyRwrBC8kT3Z/6FPJtQA==
X-Gm-Message-State: AOJu0YxwNVTzm6F5l4ZZ5yWBMMo6Z57o/mDQ+PTj8kU69EYQEGiIGZFT
	uhUy8p6/cm7bjkPELOBXBIACt8ENzLJbasLFsfq+Q1Bk/IEhyKQb
X-Google-Smtp-Source: AGHT+IGkf8neUX4Td3fdf5viAkv7QSY2fzH2N80z+lW4vEfVjVZop7l7kDw3wXLDKTTm9Ao1ryNEdw==
X-Received: by 2002:a05:690c:3603:b0:61b:1718:7302 with SMTP id 00721157ae682-62086299e20mr10077027b3.31.1715116556362;
        Tue, 07 May 2024 14:15:56 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:e3c:6631:2efa:fee2])
        by smtp.gmail.com with ESMTPSA id u70-20020a0deb49000000b00618876dc75fsm2879497ywe.27.2024.05.07.14.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 14:15:56 -0700 (PDT)
Date: Tue, 7 May 2024 14:15:52 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Support Opensource <support.opensource@diasemi.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-input@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 7/7] Input: mpr121: Use
 devm_regulator_get_enable_read_voltage()
Message-ID: <ZjqaCHUc7PlbKDCK@google.com>
References: <20240429-regulator-get-enable-get-votlage-v2-0-b1f11ab766c1@baylibre.com>
 <20240429-regulator-get-enable-get-votlage-v2-7-b1f11ab766c1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429-regulator-get-enable-get-votlage-v2-7-b1f11ab766c1@baylibre.com>

On Mon, Apr 29, 2024 at 06:40:15PM -0500, David Lechner wrote:
> We can reduce boilerplate code by using
> devm_regulator_get_enable_read_voltage().
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Mark, maybe you will pick up this one as well?

Thanks.

-- 
Dmitry

