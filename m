Return-Path: <linux-iio+bounces-19017-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3769AA80DC
	for <lists+linux-iio@lfdr.de>; Sat,  3 May 2025 15:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BAC6189C22E
	for <lists+linux-iio@lfdr.de>; Sat,  3 May 2025 13:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6526F279798;
	Sat,  3 May 2025 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwe7R1xm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B7213FEE;
	Sat,  3 May 2025 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746279618; cv=none; b=hSdo3moU920lqrJI2w3ZpjPDRsFixvVBKwoLiQnJ/6iJ4xPWTSyyARRQdcEuKheu0pMGWkRkgUG1JhprxGnF1cDMe8dVrT+uzuT72Q61du/WS2/Vdffxk1Ki86wKH4LXNUxax1RScssrRJIG+CXIO6yOl2DSW9nGlj0QFp/MUTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746279618; c=relaxed/simple;
	bh=ncF4KvhuxeHE7ggXSI3uznrikpy8lB4Nyu6AvOT3fm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTvR29npreDW20PrCHEpaFDe5geI2bgSbNesY1HQowDXqhjT1hyvwiqGGfJRcTPApuflw/+CKuuIydfkV1b5Dt3Lnul4vO0tIFjw9/3G0YU+6vmSBoz8EGto8slPaWt93ODSlhQUm5Epd6bbnvLycrS1+9yP13l9k397TjEes/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwe7R1xm; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30572effb26so2903917a91.0;
        Sat, 03 May 2025 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746279616; x=1746884416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2U0Gh95jLT4YIXSOtY/Axi783QDt6YjjlaILb3YAGJc=;
        b=gwe7R1xmEURXS4707ftqXQ5qQZ/1SCv9LnZ445sLskuSp8HWuV365nLX5zQmF+dwx3
         Y2YrqjL6x6R8Aq/rUjdSmpu1VSfFTF2RYCkCIDWXHYhIe+jRjABHkU33r+ZDRk+zjQRh
         5N3i+tjlVOgxJkN2GH+T6IEwkhzZ/A+35xnV3sClgY4Eu/UkSkWE625hXRCdXBwZ8Vzj
         TQMM5PqgYeWjXkKIG2XFeitOZbh+F0nH6hgwIjz6FL0CKTEKodmLBdIxTcyebG0DpXIs
         MNbnS6HVF8Q3645100kPmptYMk08LvYnz/5fft29z71JCHd/AokN12fUqCn7AJEE4/hE
         3fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746279616; x=1746884416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2U0Gh95jLT4YIXSOtY/Axi783QDt6YjjlaILb3YAGJc=;
        b=Py1Hz7AGvW8RpVjPXCl/Lk2VrcHt83qBgzHLdJnADmAZrwUOSdN/zAWCW+bhgXDGJg
         L1jZ/5+FCR+wd0F48dDkKQwGfYb7c+yG+I2GieHqBI/ZdeFTPRx2P73qeJq9u+0EdW6L
         B342GZaFZsE3W1YWBmCOPWBzD58SvuQGaUoWkZx1qLuK6bwYtoZdgA1l6WO5YdLlkvC9
         /ODpOw+ABKjFfmXlHUYp78foPCslP7wmthVjvw23FJb8r2z+n5Ruvzvy8l0IsQUwc15m
         UapG+ZhN9IGopCOISKtTYKXN6rAw1y/pGkI/PJ7dqt4F9KW1rYCytU03BlvwI2tholM1
         MYVw==
X-Forwarded-Encrypted: i=1; AJvYcCUvIE+kisOzICinr9fd/ergbnxEWjH4JZhzAbanZqSpFBNHThpBJvQxx4TaDq4MNt3FZVmQOfDt@vger.kernel.org, AJvYcCWvKMPjKYc8XWClynMV9GR2sRyWaegFDhNPPql85FFqhquq7I0vpVvrv2+Mj2v0EEQE/eNcS+eicpk=@vger.kernel.org, AJvYcCXtDj3F2FvkTW/LsTte37IztKOytwxlJ8817xF1txT5fE99ImO0gil1faE+bb6U0GYCTOUKKNhGlAPIuY4W@vger.kernel.org
X-Gm-Message-State: AOJu0YysJNkjW2RkE8WpCwe+431reMjbY9cns5QmPVj1gv0Fv7bMbw1H
	zSztbYMsEXkpQ/La6Uo/xLtjfEqaIeknKblFL0UtbO5LBeatEbZg27Z8Iw0SQSI=
X-Gm-Gg: ASbGncvYJj2CSYTd3VGb/TM6R4Q3DCbNEFSV33tPqGrLyPsQ2yN2nuBXdncFcq/zTMd
	Er194xiBs3rP2xQo5yw/mmi2pcgNTlNqV9v9essLvm4p0sNgbC6eFR8M+12bW1yWYE4ywCLcr+t
	tDW1G0HsvFmUg9PGVTk6JckAOFZyBZKCWKetI6ZbAOeb9Ngnk30xcLfuB50v+WFD1jnfadOyO13
	tnuE/MKOosy8T1RzYJ7VJwekJSYiHz/Ksal2+V1KQpTEaHkVWGV4ftlwFMu1VT48amZkVLNtQlC
	MV/hDswpEtYJSlqE9R5fNR17/6iM04ifYkEajgTL7dq75Ls/AeMO8Q91Dnke
X-Google-Smtp-Source: AGHT+IHFQniELYcTgmi3Z5ImYoPmg9txKfljjgWfX32mK6252ape3L0moqGlglAwVabyiRaRmSMDfA==
X-Received: by 2002:a17:90b:1dc7:b0:308:5273:4df8 with SMTP id 98e67ed59e1d1-30a4e5a57e5mr12438772a91.10.1746279615799;
        Sat, 03 May 2025 06:40:15 -0700 (PDT)
Received: from localhost ([2804:30c:4024:1700:8e03:72a4:b895:b221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30a34829e51sm7767076a91.49.2025.05.03.06.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 06:40:14 -0700 (PDT)
Date: Sat, 3 May 2025 10:41:33 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: accel: fxls8962af: Fix temperature
 calculation
Message-ID: <aBYdDQYcOlDgvn9W@debian-BULLSEYE-live-builder-AMD64>
References: <20250502-fxls-v2-0-e1af65f1aa6c@geanix.com>
 <20250502-fxls-v2-1-e1af65f1aa6c@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502-fxls-v2-1-e1af65f1aa6c@geanix.com>

On 05/02, Sean Nyekjaer wrote:
> According to spec temperature should be returned in milli degrees Celsius.
> Add in_temp_scale to calculate from Celsius to milli Celsius.
> 
> Fixes: a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

