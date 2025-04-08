Return-Path: <linux-iio+bounces-17823-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F778A80D9D
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 16:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868D617F6A1
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 14:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B957A1B4243;
	Tue,  8 Apr 2025 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hN3VN5VS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352A215ECD7
	for <linux-iio@vger.kernel.org>; Tue,  8 Apr 2025 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744121610; cv=none; b=NCUhWhWCvS76CAkbNvtYPw6MFKj5RGJP6GAD+8Ek+Ixfcmc0vdFGuuOM+RDwfvhJaP2G7Uf7zCbr8SppwOZS0E5eVCgfquVUUs8KgjqYWJWRbBWKQDEnOXMT4ycpMJTDYIaEpyiUOHR00OTOUIdcmMoKQSxxvMdfVS8ss55uA40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744121610; c=relaxed/simple;
	bh=ahx8cR05k3qNGaOJea8NLD9wd9EkhgVI2XiZ9fruzls=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bn1GFY9d5OeQJjO3i94FQXewHzQXXoc7dy0n+qcNJgcl+9vC0gaFIStY0X4AxCs4k/BUDCwynLvgsDXjbAt9LUdIM+o03sCwHxoUQV83kWVkJGh0nfGQKdGDLbf+PnRulj8FiEHo6LJ5qE8nNAnNMKaEnJ7F9iXrw1agK9oXbSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hN3VN5VS; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-af590aea813so5246403a12.0
        for <linux-iio@vger.kernel.org>; Tue, 08 Apr 2025 07:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744121608; x=1744726408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l74Yci16jgG4pkaeHBNwts2U3/tJ+WNAfsUx5ggK314=;
        b=hN3VN5VScCEarDxVg+hW8pxPRcGUHSaB2j8yUENsxr7XPryJwym2TL/u2UE05FRVZg
         SHzgGbYuoY6k3Cgrllo+lAJWkJTMzR1DRy2xC05ky9i/r6lFDm/qNxvr3NSTf15p2Wt9
         XCseKHLUQ9BrmAmZOtwNbaIjfjU13UpXnATpBpszwT0EQi1GfGha1xeY9N6D8O1KOIU+
         uSc96ZFsRQ99TD6DtPocq3ktkn1ggswJ+H3eFBpqfUxvTK6fcGKst+3ADiLXlKuA3bqA
         Ebt6PIgRWlTTxhPuhJJzCAbGGlypiFqgeriVOsCYWAkAVeHha6TmJbS+IeVICLnJgsC8
         Pv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744121608; x=1744726408;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l74Yci16jgG4pkaeHBNwts2U3/tJ+WNAfsUx5ggK314=;
        b=Ng8OhQ7eliBic5cdDkgVj2g2zS8t7zd83+OfO+ydT/8Px87QsAIciBIoJ0TR0nLGCq
         DNK+VhlN7cacWGAD9VEiKsfnOsa8Ec38nRZpod0ya9m1TxdMX902t4Y+s1i4YzCLFK/U
         CPTAu5zXFWWA9qXWdsPu0fcLGYkLCZTz126/cBC17MoNLf2TyZooBQsGgrqcIm1w62O/
         fKQ4k/oN3e9HB1rN5Ng8rvyM5tA6obbBUvFeeVSnLf2i7/CY8XLqtY8esM5q0ruwELra
         bq/KuM6X1PwtkdKRGFPSKMERtMIyMl141hjxikvrKLCfk2nsFp/X5w1KIFc3WqnjhA22
         ZH5w==
X-Gm-Message-State: AOJu0YzZsXey8W74TVCMbnZWyJxzqVPYfoXcTAfnIRV6ftUoRECcFduf
	ERxL0jxsl6AEyaRbaPdiJhcALIvzi4qUF7mvqjjaI7QCgkChucTC
X-Gm-Gg: ASbGncv4bNKZkeavnO/jK6px8wSh4hWKolGLexozYn2eh9k6Cdp4fnRB9qCwyDi1J9s
	hYJGDHUeeKb7ZCQLoIO9O3nwJk3crE02MvjUmyDmsdKjFBj+f5oeco/y8VMJibl28qVXSu2iAnc
	AgopetOGNLyuEgrb1tLZrdd/32BKS30laNgZ/DMeBqrITZqmvz3nsYe3Au6i1VlW6Z9BUQwgn9q
	aVwDbHz/LAHP83w+EBYWltcyA+UBve9n1W9sqtX1jDY9NponMyVaJsPED8t/RUaBV5NB5NtP4Gk
	H5E0jDHOdmZl4ipfp+EGQoenMpBJlXLnJLQbaTCWMk7PatwusFM6h7Qr/dHvfnV5bwsvwQ==
X-Google-Smtp-Source: AGHT+IHZX3qWi+9w7wRE4f4VneyQqn5NThwdUYw4hqYIXr2nYNjjtblEyqozTJxUpq3ch6WLxGIBJg==
X-Received: by 2002:a17:90a:f944:b0:2ff:53d6:2b82 with SMTP id 98e67ed59e1d1-306d0d1d6e8mr4847557a91.11.1744121608272;
        Tue, 08 Apr 2025 07:13:28 -0700 (PDT)
Received: from brajesh-IdeaPad-3-15IAU7 ([103.205.128.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-305983b8726sm10910210a91.33.2025.04.08.07.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:13:27 -0700 (PDT)
Date: Tue, 8 Apr 2025 19:43:24 +0530
From: Brajesh Patil <brajeshpatil11@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, marcelo.schmitt1@gmail.com
Subject: Adding support for QMC5883L magnetometer to IIO subsystem
Message-ID: <Z_UvBIsQ4rdIYTN8@brajesh-IdeaPad-3-15IAU7>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

I have a QMC5883L magnetometer module that I’ve been trying to integrate with my 
Raspberry Pi using a kernel-space driver. While checking the mainline kernel, I 
found that there is a driver for the HMC5883L (under the hmc5843 driver), but nothing 
for QMC5883L.

I compared the datasheets for both devices and confirmed that they are not 
register-compatible — the QMC5883L has a different I2C address and an entirely different 
register map from the HMC5883L.

Given that this sensor is widely used (often as a drop-in replacement for the 
now-discontinued HMC5883L), I was thinking of writing a new driver for it under the IIO 
subsystem.

Would it make sense to move forward with this? If so, I’d appreciate any guidance or 
suggestions from the community.

Thanks,  
Brajesh 


