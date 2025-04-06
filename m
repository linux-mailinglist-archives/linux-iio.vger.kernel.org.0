Return-Path: <linux-iio+bounces-17709-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E0EA7CF48
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30821885278
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D309199FA4;
	Sun,  6 Apr 2025 17:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L33FozdD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5F5190485;
	Sun,  6 Apr 2025 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743961292; cv=none; b=jU/zYTFZMPYxROvo5zvJnF6t/KVtJeMKDWuaxDWCHFf4RhYIwpfkwMaGAUo9hkw69BkzZUDx1AeGPfQ0jdjuFCqyl07GSGvDPRbH9cp4cBR1OloB7rF2iZru645mn65bbLCvEYx2z7BBEUJeZXpYa+pp7jMjE7GDdOaH4F/SFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743961292; c=relaxed/simple;
	bh=G2395PngP8PsRzf5cZT+gxfYRLzzHwxQWLBxuqMtvvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pF+F/R2Tie5sYS+OadLenHdvd5DbXXshTLqQwFypYFM6jmJn2lahNxoM3SAdQFYA1GVhjueOVhcfIRIbF5M0nGqhzoDRBl0GkrhONggDWgdjQV8CaN/VWQs/qNNeRd3mOKJkGVcdL2GJaKiVuD1yMOYuHVF7Lyf3XJyU9JNoEx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L33FozdD; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af55b7d56a1so2454267a12.2;
        Sun, 06 Apr 2025 10:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743961289; x=1744566089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JxmLRtJEJyieHfXxKBBazkkTPndIt5Qq1s+Aw5ot+y8=;
        b=L33FozdD12iM1/oGLwoZgPwdJ4rJG9KjB3oIogWBkxsul5c33tpNPcHcV8W1NaCyS2
         nZS1k3gqJ2yEjpKbM0RyeCK9FHFLT/PdDAsmAjSl3Vr8AN//Mx4ldXpj46HP7rNlmd4n
         xMwS0AZjSVQRr1cYchw8DhM+96AcCNu4/qf3vLOgfj6U4w1G5fjcKQgEDgMFCGJlIObr
         s6bHJh95sRRCQLW5QeV/BUzR/37SqiN0JwI25BHGtECpGumpphTPn2NkwhaXUD9b6o2P
         a6QULaVBW5zr3btf448kMoOsxJjqZ2oozJpj44qGTI9WRuzhbE6r0C/NbQCXr2wBBpmf
         VGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743961289; x=1744566089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxmLRtJEJyieHfXxKBBazkkTPndIt5Qq1s+Aw5ot+y8=;
        b=rMwJyuRVlDcgIDS3JlPAoiO8UiXLUoV3b8WaqedJTurJ0vsngdRW4HEATWGnpIfuJZ
         1DyM4MsVbPnU+H6VGeTGemcI6vizbzzAFCIgxn/7plAjfGpGKxeTlPPonpmuiLwCF6Y7
         0n3+hk6CPOvFl+1g2o8zsN85ATX/TA19ieiwaIE8A76K5LJaAgIJ0ZBbSb4ZBvGj5px0
         qcyo0kNNojpgZ2wCjah6CjUhSa4CBzucQdKChrjsXcQQLlvdMDXadnAhq119yXZa11or
         whPEopIEYSAIm1LzT3RtMNdA0vBv99xN5hVGF691WEbBcE/c4l2EQbayFDAFcKp4fZg0
         cCdw==
X-Forwarded-Encrypted: i=1; AJvYcCUpDAI/7iYH6SC1ErGW5uMh8wy9YGtf6DHGpOLj+0AmHEn+q+ESnNrr2IvUiRDd7dt6IdgBjW62Mf3q4iU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOP0a4gLkcu4ooL6S/pQ+nkSWBwZ4KzH1fHFmxtE+sjwlRMF8R
	3VrVZaXLriW82w966KRto+M4SuPfSTcizqapx4PiUt8NaztATl0T
X-Gm-Gg: ASbGncueJGsNf7dVhir4A4svoZthu9xqxLNph+O/guMR8PpazfzCaGPF3uNENeIiv0z
	CqYH3M7Ui6sJJPVpLAfFOFJjp8zHnjlz+CCRJYXgxJO7byNtGbj8r2IXbcqAZDC6ICaHOXpyHQr
	ix0ClcSGpq5r+HPm0oy3f8hcAkdgwQS3t1ivcuQPyxO3dlViD/FN3Yl5qgolDQ9h2yMK/XIgjk+
	1A5fb55FIwe2j+UyWcHv/0cPU+hj6beWgrChd4D6KBBjyNOUuut4Oc23qs8VRBGMzyhRc11XA6B
	FXs4Y/g68rersJrzBNHKQNyMw6xqEcDPc6bJO+Mzx0UgSku+tOfterk=
X-Google-Smtp-Source: AGHT+IHwY2vuse98936Fl6H6zUtJp8rDxk44jwOFGR0olWLhO2gXaZYHn5gUfApakL4mwJUnSqXvAw==
X-Received: by 2002:a17:90b:1d43:b0:2fe:a8b1:7d8 with SMTP id 98e67ed59e1d1-306a4b6fd75mr13167733a91.25.1743961288843;
        Sun, 06 Apr 2025 10:41:28 -0700 (PDT)
Received: from localhost ([2804:30c:1f4f:6800:9245:316f:6226:cc1e])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3057ca7fb75sm7378808a91.22.2025.04.06.10.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 10:41:26 -0700 (PDT)
Date: Sun, 6 Apr 2025 14:42:32 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Brajesh Patil <brajeshpatil11@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v1 1/1] iio: dummy: Add 3-axis compass (magnetometer)
 channels to the iio_simple_dummy
Message-ID: <Z_K9CFItAcYS8r4a@debian-BULLSEYE-live-builder-AMD64>
References: <20250406133349.50633-1-brajeshpatil11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406133349.50633-1-brajeshpatil11@gmail.com>

Hi Brajesh,

On 04/06, Brajesh Patil wrote:
> This patch adds support for 3-axis magnetometer data (X, Y, Z) in the
> iio_simple_dummy driver. It introduces three new IIO_MAGN channels and
> populates them with dummy values for testing and prototyping purposes.
> 
> Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
> ---
>  drivers/iio/dummy/iio_simple_dummy.c | 71 +++++++++++++++++++++++++++-
>  drivers/iio/dummy/iio_simple_dummy.h |  6 +++
>  2 files changed, 75 insertions(+), 2 deletions(-)
> 

I'm pretty sure the changes introduced in the IIO dummy tutorial [1] were 
for learning purposes only and not intended for upstreaming.
I don't see a reason for updating the upstream dummy driver with those.
It would also make the tutorial less interesting.

[1]: https://flusp.ime.usp.br/iio/experiment-one-iio-dummy/

So NACK for this patch.

Regards,
Marcelo

