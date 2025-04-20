Return-Path: <linux-iio+bounces-18372-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1794FA94848
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 18:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202F33ABD09
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 16:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76E1202C21;
	Sun, 20 Apr 2025 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwpDL9Nu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5693C1BC073
	for <linux-iio@vger.kernel.org>; Sun, 20 Apr 2025 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745165254; cv=none; b=DVzDaWegtmwtKvv2WVfC7tWgg2FJiaUJPMqmk6tfi6cZDXciDBE+E23/YfBmMVZM06HJaecdlmZ4apv2O9xZhPWJnVDwPdxAXlXx9degMECZ/58HMBHQnDj5XFY5GT/dNQ92Hj0JjUo99JGPswBRvCtxK8pcrUpmIiBkcMOijUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745165254; c=relaxed/simple;
	bh=wHZkk16ri+5Mc2PvQSEWaY+Vh6jIGrmAUdH07LHeBCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ts4jCvWNd2e5l45kDjyGnnpHQRUnc6p5zYvePiciyszFRFXJQHVFA+x95qGVRUUmN0JAoT1RsENbU5/AHxiLh9hP8xK7H4wTo1bknvqJrO6CKQJn2HJYHoiebqjnR6/Y94eM2YxPDWf4pHjShsZh00BOxLcEOjluXeagFYThWuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwpDL9Nu; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3081fe5987eso2743825a91.3
        for <linux-iio@vger.kernel.org>; Sun, 20 Apr 2025 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745165252; x=1745770052; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KaGSaGiq+LmL/AdTRqPUeub952XiGKYhYcVBNx9i3yU=;
        b=WwpDL9Nurz0PITF8gPL3p5nv6xn5088NdAQXIcxwP4RTjwyC9HeYh6cxMkNMPiI5xC
         /F+izi8MWOItyvIf9VjwrmMPQgqSlQc1JtkimN7hSQyBmtK4McBj/IVp684hEF3gv7Ws
         I0ND1POZTLPaILXIlsPNA+gY09FvUzOXy0x7hB3Dycu/Zi2CtSeU1QSxJ2EIRX4yosQL
         INwMK5GJLkgVR6oS8+1Nh+HRlDydFHCJwm5jK5uknyiEx7iPeSgv/F8jf5L7iULN2mS8
         CWW7F61Yg3mtQK01rK6SJ5ewOj6J21MG9ZwbDMzKisfdiiv8lrslz1yBkvB5jUZndYjq
         j0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745165252; x=1745770052;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KaGSaGiq+LmL/AdTRqPUeub952XiGKYhYcVBNx9i3yU=;
        b=kQ6q0yLfHNd8Jecphkl+smRtBXPA45hKIRxShRh1lrwi7sIRkkhizPTN32nX4V7dz+
         4xkxpaKK7sIZgfSIfpzy957AxvcOlXMBYXIo8l0+S+jjN9iO/t/a+LfaMCYBjClWKLg7
         jo4hDGlKu40deZ9e2y4lk3Uoq6lY2Sc1sUxi4gvS5M+yG2RpambxDOcUut9E3MSUqdV1
         PJbDKI8To0nXtzqxg5+2diE+YugxfqlOm+bu3+8hOMG0Gz7Y+7lqZzr4Ur6KFIsxVEA+
         Ba4IIora69Nf5PzgNBh5yFrGY4L1EIPMHbYasdD7IiTijZDkQkSN+G+tYfJGJyYMMl4N
         oxdw==
X-Forwarded-Encrypted: i=1; AJvYcCUOyu0i+rl6YXs4rFQvk++LjxZLEmqKklVTamLaitDuTYaTYCmtyWqRDSRCqha5gdh842CT9xFfYlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrxCWXHKRs6SihGkYSjxzJrYmp8njilM6vq9Wf184d5/eFk9OU
	m33dhPiDkECav17pmd68mRSRTdsZjQPqHHSQaPK+8R0Kq08/37khfNTTtQDR
X-Gm-Gg: ASbGncvu/UQ8FSLWX5SlZMnoHsdk98hovqRk9GJUQdqFHzGnvvTiyJc3v0TOPXprcw2
	M9ftdSv8xdBZEAFm2yvonfq4DTpu+6BdYV7SCxNvUffQOTou9nXeb/ZvvsPR1a+d+Gxi1IDuqW9
	NPSS4tEUnM92GwJPIoppiayAEIgv4miZa2xooRAAXoo7k3y2SQhN6FKeUQ2S/pNlFoYtwI7/7To
	oNLGJLx/UL4el4rSuMciqBGQh0txVeasWoLDxSUZ4T3tptld4an0R5/DNTEu0z5pq7srWnUVW1/
	KxN1Tz/NAirDvK0fZHZZsqpTw+yS1Wj6gpV0KpgEHEywk//uZYfaOA==
X-Google-Smtp-Source: AGHT+IFfKObUCdAmzFxE5yV/Mnb8SaGt03Wclhs/DvALXo2W+sxPxH+aD02JwdBHUCq5gspDnA3I4w==
X-Received: by 2002:a17:90b:574c:b0:2ff:58a4:9db3 with SMTP id 98e67ed59e1d1-3087bcc8b4dmr12090008a91.35.1745165252632;
        Sun, 20 Apr 2025 09:07:32 -0700 (PDT)
Received: from joaog-nb ([2804:14c:490:1191:f66d:1f0e:c11e:5e8b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087e0feb37sm4882688a91.31.2025.04.20.09.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 09:07:32 -0700 (PDT)
Date: Sun, 20 Apr 2025 13:07:28 -0300
From: 
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: nattan <nattanferreira58@gmail.com>
Cc: francesco@dolcini.it, jic23@kernel.org, lucasantonio.santos@usp.br, 
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1119: Prevent concurrent access during
Message-ID: <c2golk6627ybfpw3t7lnerritq2yysi5zhdlvahnvhxoevmojn@j3d2stvivkyk>
References: <20250419232316.36002-1-nattanferreira58@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250419232316.36002-1-nattanferreira58@gmail.com>

Hi,

> Use iio_device_claim_direct() to protect register access via debugfs
> from conflicting with buffered capture modes. This prevents data
> corruption and ensures correct device operation when users access
> registers while streaming data.
> 

I understood the problem, but I think keeping at least the possibility to
read registers even when buffered mode is enabled is still useful for
development (e.g. you can check that userspace configurations are correct
by checking the hw registers). Of course, there's a chance of losing some
samples, but debugfs is meant to be used during development/integration,
where this probably is not an issue.

So, for me, a better solution would be to avoid writing to the device
when buffered mode is enable:

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index 9be7676f31bb..a22d7cb5c4a0 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -416,6 +416,9 @@ static int ads1119_debugfs_reg_access(struct iio_dev *indio_dev,
                return 0;
        }
 
+       if(iio_buffer_enabled(indio_dev))
+               return -EBUSY;
+
        if (reg > ADS1119_REG_CONFIG)
                return -EINVAL;

Best Regards,
João Paulo












