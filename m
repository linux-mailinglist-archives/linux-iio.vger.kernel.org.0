Return-Path: <linux-iio+bounces-22633-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F9EB22EBE
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 19:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A467C16C372
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 17:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82E429994A;
	Tue, 12 Aug 2025 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZI/wav8B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF912BEC2F;
	Tue, 12 Aug 2025 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018853; cv=none; b=gdkhgpR2uxk11RRPqY5jFIuVbdqm9Og0vhVHmgkQYvICe5sfuKk727KRrV0G3eNvpMJK1mIOxUDzLpsYeRE8r+ZfEH6QqG/2wlwc40ZVpOsqCDIQktnzrczr9AcKbKa+VmeFUJrPgwvSfgUIShHcItPICJhEEYXuscg9CN0YVAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018853; c=relaxed/simple;
	bh=C2jHbcpKfeQ2R3bqbf5UCC7Rmw2IUUVNKPp5W23rBr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJomUplC/jsGa+i7EIvVaBPQDrg9SmuMh58oSersA3Q3OjK1IE5T6JcInhX1iHZtfpTcq/5ivbd+OLWOMrv+KOSNaIUTexO4EWKmOm2F3Ioav8bK2ImiKZpLwmL8z7ypGxBlsEF8sp5ZQef7lMvRa7VcAZIFtzQZULQmgunWDYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZI/wav8B; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-333dde3fa8dso6093921fa.2;
        Tue, 12 Aug 2025 10:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755018850; x=1755623650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2jHbcpKfeQ2R3bqbf5UCC7Rmw2IUUVNKPp5W23rBr0=;
        b=ZI/wav8Bzv88HnhiLa+brXsmGJn2i8gYFU0DGx9AgVuNURHgtI7sKh42RWnY6QPyEK
         5GZglOu4fh2o0O/Ir2qcZA/qTzmlZMda7KFnloZ6veE2zUxw3XiSFDfXRw0tnCtGLxA7
         AvtnOM/Yynq2lo6dssFK5aexc2b8+W3x5QTB8DzeMChsB0P6tClCsYFV5T5fEsYeVLFO
         023gyjit5MWEjKYUTZap49N8QeNx3+vSz4j7vnfDTGjwU02XeYJtXCk5uPpIN2buZJB5
         94Nh1skrnTkaqfa++rqkHIAfNF+Uls+rUsHftoL6wXyf1tImFzU3QgZ9x5lVrhUPeCAE
         D2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018850; x=1755623650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2jHbcpKfeQ2R3bqbf5UCC7Rmw2IUUVNKPp5W23rBr0=;
        b=IGl33IWBr4TncufLaG+1f/z6zgZ6gsT3kntByZY2irM0EZmHXmc38iYAsMTqFCjxIR
         VVyYXRQl/Bf1epD52AE9z09Wca5E4UwGgyyP3ITrLkWE+9UFwrfoQJlpmZmVXWov62RL
         UULbM9ukH4wEbcToL//VixQDwdCs6FqoM3MyIztaU9w+FUFht8DxsUbO+dbUjkCwg2gv
         jzFUwtuMt7J7HLljHo7WBQYUwkIKTXQTOI+M/T7fEOoMfml1hQZ5/gDX9yUcmbummen6
         dQIjH2QISixNsfgfHYmLlc2XIVCI+7Yo998Q3YYN2+RpuKvNQaqMgg+XSbJD2psicPNi
         mCXA==
X-Forwarded-Encrypted: i=1; AJvYcCV+4y4T4UTy20oO19ACtJZi1dSrRRm1+Ka7LepCpclaiablLG5xW6IP0B3YWinIZX/fLQd4i5Ki6nSzpVx1@vger.kernel.org, AJvYcCXCiq2V9MmYzoXXof7rr9qtxK7qr20wZCkh+KQo89JHqMFoBjb8gPI728jUp2p+ZHAf5TDtI4V5xBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMX35Wc/zP2J3NwOT65ZoVRcMtJUuz/Ymy0Ton8LUPcnic83XA
	/SAHZGf44ygN2UXM0lJRmEV/tGRLihGXIH4zBjTr14N+qxv3lnWe+wM/y4VDwU2p1SlP4sx4jCw
	jbvmVzago+w3gBsLlUgJuLv/v9GRnnpg=
X-Gm-Gg: ASbGncuHb7LEFxj/KFwU+0hU2oiianmitO88t+iVuUGu7sL3jvYnT76CRrOuenJY6N2
	FRp4fkrY5zJ0yR/UCLD53vmmRqTAmwan00hj7kwROg2B44LLWJcnrrHtOrgB7a4xyKyTpkOU1Hr
	j6nWsVZQDNuTu4SkS6vYimMjdLWkajFj7amcfHlX0jPIwlpfdvWCimxqeKx2sxTHLelFv7qsFgX
	/yXKb8Q
X-Google-Smtp-Source: AGHT+IE8d2JVDJgwI2eBKgYkUzDvzwoE93jwyeJH0axrXN6KTxg2ver1qMruUXk/L5f0gGwlhZtcFuVnpz3E8oZQE5s=
X-Received: by 2002:a2e:a27b:0:b0:32c:e5b4:a225 with SMTP id
 38308e7fff4ca-333e53e6d76mr1549971fa.28.1755018849974; Tue, 12 Aug 2025
 10:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812170723.51639-1-akshayaj.lkd@gmail.com>
In-Reply-To: <20250812170723.51639-1-akshayaj.lkd@gmail.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Tue, 12 Aug 2025 22:43:58 +0530
X-Gm-Features: Ac12FXyJhc-_gHg6NqcAZWHdfPLT_AuHKXQJ32q09ZuRvAokvj33SxssNFPMUzE
Message-ID: <CAE3SzaTTZNHwDJxCLUUZ-gCSL2qFtchow_+mwq1ghiqCH6zvBw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: light: ltr390: Add device powerdown functionality
 via devm api
To: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org
Cc: shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:37=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmail.=
com> wrote:
>
> Use devm_add_action_or_reset to do cleanup when the device is removed.
> Set client data with i2c_set_clientdata() to ensure indio_dev is accessib=
le
> in powerdown function.
>
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
> ---
Just realized I did not include a 'Changes since v1' section.

Changes since v1:
-------------------------
- Switched from remove callback to devm_* API for powerdown.
- Modified the changelog accordingly and summary accordingly.

Inorder to avoid redundancy, I am replying on the patch mail.
I am happy to RESEND the patch with updated Changes since v1 section.

Thanks,
Akshay

