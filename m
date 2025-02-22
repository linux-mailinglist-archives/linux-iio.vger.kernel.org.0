Return-Path: <linux-iio+bounces-15985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2EBA40BA6
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 22:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275A03BB8F6
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 21:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF142036FF;
	Sat, 22 Feb 2025 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcZNEgNo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430FB1F0E47;
	Sat, 22 Feb 2025 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740258313; cv=none; b=HhHQCvYiiCZCWNzleLega83QojMDCJPFmUTz6pZ7JsHiYDT7X4snNE3nmYh9tyDIK8TIY+dUhDFsrR4LFMBDbvYVVJqXXn2z5eY3GuwYOUGCEAC3n2plzBCou+SIUWn8jcb3vQ5swaUiWRxrKlQ2dqUWUlD+CRojnp2xi0+Cr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740258313; c=relaxed/simple;
	bh=kTTR6w28623z2PdahaVhPCG4rhr00t5rKMg7pVg8rzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/7Jr9QCBzXkF9bIhvwHitrLSFofNsf0lPP5ZcQ/z0RD6mk32p8PgcAtr4KbngaWqVmTANZbhKhxnWx18rEy4AjHDpG7qyHMlEgNr5M+Z6jrDA4K1Wf/0kxKTE5X81kqqyTcSfQydEqgwTRN5QTpAX3EQg3KJIYunGND+Mi1N+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcZNEgNo; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4720cfc35e9so56488811cf.2;
        Sat, 22 Feb 2025 13:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740258310; x=1740863110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GDNb8wB+xziXZf1Q+Ps5i32BsrwEBQPG7WlZhBCnMwg=;
        b=DcZNEgNoPm2sizI4Wkty19e3xgHKj4Qrb82/WOOoZjmLL+tNxtO6+/cnsvsZb/lfrs
         Ghy46+90rdJDgcaP5QR3okknLo12SPAdfCc7XBA6eEWwBcST7OfCllkuViOMQNAurx/q
         yER/JEi8YDh1jL8FRZK9EYvbB7+nyxReEMNyc/iO9TA8O42zOsS13z3XuyvY0V17/Ry/
         wbzzhU3dHi5wOF3r9oTnqFaYv9iSeMDHTASgJ5kzzx6+URCJp1ABRq87shFa6WJUgXA+
         jrfkj/8rDMHBRTaTiVEdCRO/KOaQAlNCjOpAavZsKL1B3tDV2RWNmufNXa4pa4TOMLVj
         pnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740258310; x=1740863110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDNb8wB+xziXZf1Q+Ps5i32BsrwEBQPG7WlZhBCnMwg=;
        b=k8AQ/NOMLB9qUIiyIOt97FBh1YQRDj4eemi1bzNvxTElxuYAj8iqx/tnalWIjtcJoW
         HgTydv+mu0rMWtNMZNTQBggPtcXOwqomDdi23INSLYQcPo9BA/dwN/EpbAlMvCqmxjz7
         pItmy9gQ/zHCbNTye2j8s3/7TQYsnjxV0MvnOgYv2zq9Ydws9l6od/b3RSutj8bMfaLc
         ooawH2zic0h1joEk7dIUuEEufDFgqB2yrLKAOGs3k7vguc4AQy4rYE+mu/c8TosI/svv
         tyq4ms7y1Z2RyryvGQD4HV8XB2DngHwKGvojmqaSK1pYrA7seX4PQSkFulZfFjxtY/Qv
         f13g==
X-Forwarded-Encrypted: i=1; AJvYcCUnk32nmmKtf9lF34EWIgVg2L1mXRLYGxvyIHMcfiQG0yZ03DGtdfXUfxJZ/EQOMwkz3BtLt+D83XE=@vger.kernel.org, AJvYcCWzYp1h4nRnWyC8LxQlyP9pItRw8tpvGUOZ57VD0vNyt37QlMCRLWWogdff89lB3wHqhAKsCmZgcmrzGzx0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3lNtvBMp+c0uHawr2Ua/KeFKTdIoEGjz2YptP61Otk5h87LBQ
	MJMdX2etAscH+CuzMrzOX7/8U7bu0pLgZzzmBDtV4XhpMQaNOURF
X-Gm-Gg: ASbGncuONUxbInc652VnRPRrhn8V8Bv8NomYPgiceUXamYDCkPtfnH3XS08UveEUla3
	fq10zLnnbtYHyDBAZQNsZiCxhqtxq5Q1ix7IavazYmVnsAwx/S6RY0F2jOXqbs90t/39JJy3Ktw
	NVd1ezt6Qt/bnyRfFYbnYxxzYVMd5dxLwweOeW9QvtWWnOqWnLRjojuSorfwJlrmy4YepWJVScc
	Xd5RbC56wN15vWKxD0N15dt2gyPq5fH0hCwhjdKIFTE4qM7I0EBIT2HfgzCiJqHoyBBlJrbVksU
	3xxKqye2gqNWlalTkAojlZsPaUbEqMTD0pGunpeS/yR9z4MBfPuQ
X-Google-Smtp-Source: AGHT+IHClFK4sot491eQ6FRxRejgHZy1N6FGOSlejiy1SySAtWdidtx39cNvfdCiVsZbY3u7E8qa5Q==
X-Received: by 2002:ac8:598f:0:b0:472:99b:4d75 with SMTP id d75a77b69052e-472228c95e5mr107993081cf.16.1740258310055;
        Sat, 22 Feb 2025 13:05:10 -0800 (PST)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-472042563edsm55544171cf.2.2025.02.22.13.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 13:05:09 -0800 (PST)
Date: Sat, 22 Feb 2025 16:05:07 -0500
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: imu: bmi270: add support for data ready
 interrupt trigger
Message-ID: <l2ir6hzh2e7f76hfeigzxwy4mvgireggmrq4advwq6hcw2txtx@jqaqgoz57ygh>
References: <20250219-bmi270-irq-v1-0-145d02bbca3b@gmail.com>
 <20250219-bmi270-irq-v1-3-145d02bbca3b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-bmi270-irq-v1-3-145d02bbca3b@gmail.com>

On Wed, Feb 19, 2025 at 08:54:47PM -0300, Gustavo Silva wrote:
> The BMI270 sensor provides two interrupt pins that can be used for
> different interrupt sources, including a data ready signal. Add support
> for configuring one the pins as a trigger source.
> 
> The interrupt pin can be configured with various options: active high or
> low, push-pull or open-drain, and latched or non-latched.
> 
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>

Most of this patch seems to based off of the implementation done in
bmi323. Double checked the relevant registers in the datasheet. All
looks correct.

Acked-by: Alex Lanzano <lanzano.alex@gmail.com

