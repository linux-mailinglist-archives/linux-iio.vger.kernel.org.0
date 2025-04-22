Return-Path: <linux-iio+bounces-18498-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5999EA9657C
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 12:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314DF3BB5EC
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 10:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D8F202F71;
	Tue, 22 Apr 2025 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zmgkONSZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A574200BBC
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316591; cv=none; b=mtCATo+4MvWRcvb7jXu9gt1dn3Asysdf4zBm23qV9nEnsNH976G4yapd2tT6dmsdc2Nfdo8cqWPGnSk41Ogojgv+3j7tG2RpKA9qqugPPrsUDBluy0DhHQSix8RA7ebR/SymfCR2UdnR0e8ivyMKBB95I7hTH8Zdr6L30RcGyNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316591; c=relaxed/simple;
	bh=gJ51U3OqINc8COkxIxukVEYOMtp81jpnzGm7X1OCfvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDom+iWlETcn6XgU2ZO5z2H+5COh+XZmygGwHWE/WC7AXpgxes9MJY1IUxNeFROXj+Fm1vaCqmbNnvVmQfxvk9xNeNfiW/x1p/FL6/sGPD57Y6gTi0G26Wt5QdCJ+ZidecVQcNgwX8PGIXwDliHFjyVX8yWr6I29aAGsxjL+fr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zmgkONSZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso3505640f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 03:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745316588; x=1745921388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dp1ZZcaQjMA4BnCcS6OmQTLRZmI/Eud1+9lMtliZJGM=;
        b=zmgkONSZM1kY/CQ6n4fXRH2iMXVs98zqQcBa9XplNh0MDuSZStpWNZa56A1OapjMb3
         9idb0Pk8xscrePdddUq4+5f5j/nK5mGr2UqUuAowGboPlgdmpzYNkZBlhPmObrXyF0x1
         EFFzWxWwaNcvSHB5R3Fff6SBZLoOLkaP/+pRz5yPHjDlNBuC084OPd09P/6OGtc4H3Qp
         jX99bsB83Cu5IxpaMvh3koFscSWROKNx5OOyhtAEG2lO/CpOI9MkFh4z9PDx+s79glBZ
         ecdPiEKzKEAyRu5ngJ3Mdp0nFxTtj3+IaJ7ArsnIhsfMRDsU9anFr51GnLVrONwH4Bfz
         YwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745316588; x=1745921388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dp1ZZcaQjMA4BnCcS6OmQTLRZmI/Eud1+9lMtliZJGM=;
        b=wTAlBE6/x3uJ9GX3W2GuDOdXr7E8zB1P5wqzJMNiqDJUoZZbEa5Ig6KGBUiJPaEMZj
         iSTVbMWL7AMaIwC/RdNu4mbR45u4I04mx6heB8xjNrhaWJny0dx4ce2V7I3rPor2txOd
         8tZzsZg9cGBwrarto1nKEGzmC+gIwu/EvSuTsBYmlfwWGccgmA5zR1eLyV0fUJXuf/8a
         Y4j58ohWepLO16JgO+ce6JWKcKayAZThhG1vH5WKXKa3yfG966voPKvhN5mUfAVS2JTs
         L2sWoNVcL5xq+fVtJCdYl8Gxl4/LrpMxz1jtqrqKp2E8a2guQwalj+ATINiOIvzNXya0
         cLEg==
X-Forwarded-Encrypted: i=1; AJvYcCVo7sTX28CN35ZBvKUwFkpx7e55fCskCsFINWSnSqjf2eRM1YSTw2Z5L9VXUqvPsYqFB1QvOSvZEbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwreinimbULPruUNPRAwqR73frpwW1vNWaXRr+Z4wkFDZ0KwT2C
	OsYdLHUWBNXbxQ1SFQvrNUx/BFHgzo36eJSP6maQ1LpZFI5QHzIKjeYLbgW2Oog=
X-Gm-Gg: ASbGncsWuEiWLRR2cye/28bnbpDb1p0Eqb7VLajZPoB7Pa3Hk1KNgUOQwm0PxHpZfb7
	XXACvM/j10LWHXCzSagfdlu9f9zqfl89BzTLlUdVo3IITAXt6u+wDdJNsW100jxQec9ClUUV2mZ
	zSNj3e/9hoTiyG/Y9oPWoqKSuMY5W7U3/8HirJILgS5ygrWKFYEMI0vKDlKhDVLctJ0e3wiKOdo
	htRHc+abgCNJaug9xajVbr/pVsiVKn2Ti22cWR/K8V49gZyA9g6rqAC5LSltZTHRNOVDx5fwthC
	mgS7qdA9sXBsT/GOqK/j3EenkQ3l+oudPszje20q5CUNT8rw06te1l5r
X-Google-Smtp-Source: AGHT+IEmHLJOQlOcSRcmVdEtr0KqjHjjJr7duO4pcXYqbZwwqR76CD1k4A3+rfbNuIehIKutY/tmZA==
X-Received: by 2002:a5d:59ac:0:b0:39c:1404:312f with SMTP id ffacd0b85a97d-39efba2cb94mr11712313f8f.1.1745316587993;
        Tue, 22 Apr 2025 03:09:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39efa43ce2esm14951548f8f.57.2025.04.22.03.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 03:09:47 -0700 (PDT)
Date: Tue, 22 Apr 2025 13:09:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 0/3] Fix and refactor output disable logic
Message-ID: <72fd8919-8413-45f4-94fe-277719192536@stanley.mountain>
References: <20250420175419.889544-1-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250420175419.889544-1-gshahrouzi@gmail.com>

On Sun, Apr 20, 2025 at 01:54:16PM -0400, Gabriel Shahrouzi wrote:
> Patch 1 includes the initial fix.
> 
> Patch 2 refactors the code to use the out_altvoltage_powerdown ABI.
> 
> Patch 3 adds small improvements by minimizing the size of types and
> doing a redundancy check.
> 
> Not sure whether to include a read function for powerdown as well since
> all the other attributes only had write permissions. I can also do this
> for the other attributes to help modernize the driver.
> 
> Changes in v3:
> 	- Include version log in cover letter.

Please don't resend patches the same day.  Give us a chance to review
it otherwise it gets split across multiple threads.

regards,
dan carpenter


