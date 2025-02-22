Return-Path: <linux-iio+bounces-15964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19591A40A1E
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074CA420631
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 16:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF5E206F05;
	Sat, 22 Feb 2025 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWS4ZYqq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CB41FF1C2;
	Sat, 22 Feb 2025 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740242360; cv=none; b=Oep4sRQy6yVAgpdVoycfwROjn65TqQQGfMx62d3y0Hj7RDRLhsvyPbL/RFK++4ba1lsuszHRd3HkYVdbm2GGe/VWy4o0db8+84gGDdhguC/dSoWcEbCCSibV4MEERCVub9ApzuAojTnH1QW2uzZ++xyV+SBAHx6lMfPB/50eQtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740242360; c=relaxed/simple;
	bh=VYn5J+9Ya28kFIBrel1VMTgN5SpO3ynDT8MeFgcfFxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6ffde+alBfQbeUHn6/4M7yll8uzL/uZkumiabMuYU8bfhQDffEmW9ImEoasjOFTYAJ/9ODCyfaWcaaauHg9Wh2+RaekLfUYf6QkP4JyGI9XBBisCA++FYMbyIJxIvgI6VEpa7scZ5e3gIQH3ql/YhsxK7jkADM7JU/ai7m669s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWS4ZYqq; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c0ba89dda9so350149285a.0;
        Sat, 22 Feb 2025 08:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740242356; x=1740847156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uZ9++CEFVzWoVxevheqHWxFHy6Z1k6UXU+Z0TChW8kM=;
        b=jWS4ZYqqo7eVKyXrRnf2zERPGn0Q8rHtGlj+7EyJJ+tOjBexYR2Vi29cFIxDT3JBzK
         9r6qknj2bT+/IQgphK2H3tBRShkcr+Q5boxXI6lBMlMJZr//0hQaj4BPKuy920+qwAcS
         mwY4vgRvZaSssCXwQ2QA19D7OBdPvztM14kHievLAJmGFAEkFFOVlC+gIrmyyw+8LTMZ
         WhRGZA89vZZi60OeUk7gjausQW3F9JsAkfkwGgBoWQMjO4VbDW6iwqKia2YDibxuoI/r
         /mGzRJ3lKLKdxyLyZFFWN04+mEUCtdG+5dndWnR8ud9QX1fbSp/EAv8b07MWKktsZEDF
         +gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740242356; x=1740847156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZ9++CEFVzWoVxevheqHWxFHy6Z1k6UXU+Z0TChW8kM=;
        b=oJcUMoW6qANBfNrzzu2O7AfGUxTPePp5GSnehNTBlPEMU7DyDHJ6DiuaOlfJqMO0wQ
         zdq8pu54yF3ygxInke2JyJMOcBgwVlwKTTG6PNrSffed4Zgx4G5b/dEnJHWc3FvdURZJ
         XScyEe6RhnexinGACr0JU6dlUpLKCvTRrTnd2TlKAg+fia5BQssga7PlJS4XD8cghARc
         pKaJS75/h5jLA+yoMV1RKy4dT/PisgRq3v5NutEFvocSrTobR/g9QicGrxWGdPFLdbo3
         UWgtRcRqXGkvIf1N7VX0JHLfH0OeGbfvNe49LLowkXqHXBm2AANRi47vxj0t9qbdCO3P
         xP7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsOo2Phq9ZSA7QrdxBSDrTnRfFap9B0+65Wl13ITxTEThV5O06zqNWc9tAlLotpcPsAkf1Ui56g1LjpFEz@vger.kernel.org, AJvYcCWDXNAIBsx/ubQ5i2o7KUfenE2dBBd/4JGOWuPZ415ptagdmdFpTvZD68m53G+HrhAEEdjKQ3rcQqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDkbQ9gpjJDQqJDae6hYYZ6oxCdD95D2P/jvO1ja0M4nlpOAm+
	uorh0Ody20mSWWEIpLFO+rGodRory6unqdBSqUsCmuJctukliIlE
X-Gm-Gg: ASbGncsblxJpb8YN/8Rqy7H55G3IF6c0Eta+rNrU9TD8jDr6Iyl7OQViZo8/dM8VC4u
	hTFxOa5ETPVK54UNrmLo2Gc2IjDExPX8XXRE5rvYVMan1WOLF2aEzVc7kZzbgQ2/xMB9yLMcuCp
	75iZdUbIdCWb5v1BgQjSZWx0yS2vQHHlNcU7RqzQi5qBY9BtOcscWE/W/W68pcH5tP9vUAh3khW
	qm7R87Lzn2qckZkVU6ZYsolJFLQz6yWPAgR8VfwIq2QzuZnv+C0ll71tbgHKLyMl/Bg+E0c68kD
	oXZRhGBXxGg13/Xi9mLip259r96pDw3kh07E7bPFnOfHzvWOhaRd
X-Google-Smtp-Source: AGHT+IHxj4UL5/03N/AOuo36rx1E4Kf0GmYxZ86uL79QdVlBFKcA3QJkl9GUn/TnU1xwOsjKKQ2E6g==
X-Received: by 2002:a05:6214:2469:b0:6e4:4331:aae4 with SMTP id 6a1803df08f44-6e6ae7f391cmr103637516d6.1.1740242356479;
        Sat, 22 Feb 2025 08:39:16 -0800 (PST)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65dcece5esm110740746d6.115.2025.02.22.08.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 08:39:15 -0800 (PST)
Date: Sat, 22 Feb 2025 11:39:14 -0500
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: imu: bmi270: rename variable bmi270_device to
 data
Message-ID: <bqbz5ky7auncdedimcbjdarhx2en4g2cnaz2qqraz5m7p7z5j5@bs2rhq7wwkde>
References: <20250219-bmi270-irq-v1-0-145d02bbca3b@gmail.com>
 <20250219-bmi270-irq-v1-2-145d02bbca3b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-bmi270-irq-v1-2-145d02bbca3b@gmail.com>

On Wed, Feb 19, 2025 at 08:54:46PM -0300, Gustavo Silva wrote:
> Rename all instances of 'struct bmi270_data' to 'data', to ensure
> consistency across the driver.
> 
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>

Just to note, you should also include that you changed the name of the
nested struct in bmi270_data from 'data' to 'buffer' in your commit
message as well.

Acked-by: Alex Lanzano <lanzano.alex@gmail.com>


