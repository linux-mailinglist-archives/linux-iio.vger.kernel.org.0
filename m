Return-Path: <linux-iio+bounces-27248-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38277CD2780
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 05:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCA6F3010996
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 04:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395372EA731;
	Sat, 20 Dec 2025 04:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyCSCbFZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A035C288537
	for <linux-iio@vger.kernel.org>; Sat, 20 Dec 2025 04:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766205875; cv=none; b=DeAbqZob3jINru/iNB75J4FEWpnM8j2+elf5EevEGIGnGw2+V+P+uGC/HRwJ98RR2cHOauaZYrWTlIDsBY8Jks3pHy70bHbaEunhGc1PHCjbSjNZNeRkWlsxt8geYB3ozpbsfv+ynts45dbo1UPPXjbQ+8fKmei+tEPhAlt4Edk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766205875; c=relaxed/simple;
	bh=py0rLmQHZnVjeCdGEPg2KQ5tGweYdGYEFZaNamAbQKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAkZvPGthU21XOeoR8rBIjbRSN84y6Is6QwNG2D1PMKj9kEWeoMJ7f58RjyGdnZGEgLV00qDXA7dNsJRduYLAduiznj4REBcMPwxCGWs+3LWseMw8DOsvTekFVUBgHC0OX+yIUUGEf1eM6XoycVXDv8+dxk1fmGJTo4J2zdFa3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyCSCbFZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0bb2f093aso24912945ad.3
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 20:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766205873; x=1766810673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tYTO/3Dr7sVHjIc1oOCvfWdZVleNAcVradfe6xUs92M=;
        b=cyCSCbFZyaH0OIC0kALBjV0j4F+Akouf3kGbmPI+2QHguolhb8I/qy8/+8BQFRwtsl
         0LHSqUmnxBrxLEWvd9+mewQwTXPJCnrMcCpwmgkslUbGlt+YL/s1UQOKZAvjFearqAPT
         hjipflZnXqHgmKdbH7BMd+99tKSMFqx69W61Hp95q1ZeXgo/3a6Y9s1xV6LCTLxMWFip
         ZJbhxvChKdAbNeof7i9SYUE/uaxJev+qBsW/e3osfb6LVt/3Zz9hH74Lm6ZWeWYWPQae
         hbOsqrbz9wGy4rGdSqg1CWz8YS3dVqgpay1lq2RYn5/xhgbHmcYZfg8xwxVCJfZ5no5e
         iK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766205873; x=1766810673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYTO/3Dr7sVHjIc1oOCvfWdZVleNAcVradfe6xUs92M=;
        b=LuuXZHuGq4OWlF72AmRm9ywr1jBFOT3RsL1zfP5uZdSc+/3LSzayLQqnMoplm35aTp
         O0H0oVksIQE392BLxgUEOz/SY0vz6STTGvx9pmjha+luXhv/ky4oGI5VUNS3IWhBoJR9
         MpFLEQqh3E2yMezBHfT96m50zgNF3ekQmaovzv+StQoliuZm1qLPr094yoQEIzp1cVPn
         r8jh7nkIHbw4Vh69wJZzf/vYDqlSdY1IgBzbnvjq4cpvlNmDAhYcAOX4MyZm9WmJxQxI
         2q7Bhy/i0/J0satitzpd9ZXSiHhMZS78BipVFFvJkUujlDX07GEnDzNpSsYcZzoIJMse
         SP1A==
X-Forwarded-Encrypted: i=1; AJvYcCXXe/K9108o5SLSps3liqXhYoZoNKLCKm2KV6ZJeLXibao9KArfE3Qof7A2N+yGHbL2jSiQ+Eif3ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqZbVs0xqtrOmUSDpz9BJO6l5f/3Hz1jqq6xMRfgrztwAqw7or
	7R7nQgaACXL4lsECJPBQjynA13tSgDrvPYp+mQDHGG79b2hUdo2O/Lu2
X-Gm-Gg: AY/fxX5CZHLGV1RoeYjpW4AoFMhz7TvaCw+QpfRw9sGF278j4Ni9HA1TdS54hBm98+n
	qbsT8o6WQ6VfmTLShpE5mUPNh6aAt1jAAH1P7t3cj04ZyTWER7d0zkYc2Li/V5uFu7G0fz9OqfN
	Jj55phkYBLCBG+ipwR4Hylcb/jYqrco1PDJNetcl+IFUh8/J2LJ7xZUlpL7JzMz3E2dqhcpaNGg
	3+0WAHTfiEMshh9jAWGa8nPZtTQidC5sDOvfKsg2n9xqzxHrOcwMbr3LTYizh8DvMUnfmHz8vEH
	mp2IaKGXzF312VHFBpiDDVMglibFeU7WKFcnsskM6fxheIGftCQAg2UbF38zIBDLyO3MgI5Yuwn
	pkvVib3ed8lljY0lmiwG1yd5K24S5q0fvHeuImBMa/cEaLqqkisM5pCNni8LTdrZxNfwOuxsysV
	vFM444aCR9i7xlrgpZK24=
X-Google-Smtp-Source: AGHT+IHsI8MPFt0GEqij4lj2DGp+IX/axXUHECdzWOxqXAMZ+jjDVBgzGuP0yJGs8otck26OECptFQ==
X-Received: by 2002:a05:7022:e88e:b0:119:e55a:9be6 with SMTP id a92af1059eb24-121721aae3bmr5485161c88.2.1766205872882;
        Fri, 19 Dec 2025 20:44:32 -0800 (PST)
Received: from localhost ([2804:30c:165b:7000:d59:b973:da75:f845])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254cd77sm15965736c88.14.2025.12.19.20.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 20:44:32 -0800 (PST)
Date: Sat, 20 Dec 2025 01:46:13 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 04/14] iio: pressure: mprls0025pa: introduce tx buffer
Message-ID: <aUYqFbBnHHnpuWVe@debian-BULLSEYE-live-builder-AMD64>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
 <20251218-mprls_cleanup-v1-4-b36a170f1a5c@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218-mprls_cleanup-v1-4-b36a170f1a5c@subdimension.ro>

On 12/18, Petre Rodan wrote:
> Use a tx_buf that is part of the priv struct for transferring data to
> the sensor instead of relying on a devm_kzalloc()-ed array.
> Remove the .init operation in the process.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
LGTM
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

