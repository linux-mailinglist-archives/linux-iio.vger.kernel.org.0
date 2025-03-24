Return-Path: <linux-iio+bounces-17260-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EDCA6E5E1
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 22:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9DA1887D56
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 21:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17A61B041E;
	Mon, 24 Mar 2025 21:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSF4UknD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C46B2E3367;
	Mon, 24 Mar 2025 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742852788; cv=none; b=lXj7uEvmSGgq7THBxu/cNwuZhhul7dsegdN9T4O0x/a3fWJToIvgALgk2tF1tjLTNypiksBjdOcb/YeXzaamH2H249WuR0BXybZHPZJc64xqLFnDrzTyJotobOBGDsiD3461WkxN8srYEZd92l2syPcMcwsGJ0RpBD65LCvVJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742852788; c=relaxed/simple;
	bh=1AD4NMZx+tlak7ArTNpCKa0DEcbYm1DLmGUGfHZthlo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h/p7aRa2dKT195Xqs4ZyFWfFzyrL7E/zzxn/gpCI7We0GeX7ajKAeQ2ISygnUu0YMc6LLZhcRuZhlplrfigMfeTB/ODj3ioqAJlnaH1pL+5roU4l3UvKrI07wJAdAUGSJF3W0eL8eur2kNthH4QQ313rrZILKEb/0yrZ824yQac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSF4UknD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22403cbb47fso93422815ad.0;
        Mon, 24 Mar 2025 14:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742852786; x=1743457586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2J+UAD+x8YAx+Jl/odmF3FttWk7q7+yx7kYzPL5KT0=;
        b=fSF4UknDAq2IGUGsUJIMyMHTuKPnChl0ibwEUOaZXAnB2dTxRjN8kazmklCNKh7Bex
         8zX094smsj04ikSluAlZrKzXcrCs3W+RMYRkEftzhjlZvk/Vhzuhn51IsdEn8nPxiNy7
         qLf6n/6RrBsOZDS81Yy13VAolfdW8zsCCEN0X4NzZTl6jaiQ9LOElzdoWkvUw2KEwHkH
         HzlNvR3JPDU7u1j0GwFx3oH6BwCCkTqMjwO7w3DL4yoEhWaLT+SnhnbAn9LYCLmRBA4p
         nGP2thSkByPbAxfs8nYyDJcvEnw3VGj0NabISXO9yOOORwIs7gUYD3l9wOMMDqpI6Wge
         UErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742852786; x=1743457586;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2J+UAD+x8YAx+Jl/odmF3FttWk7q7+yx7kYzPL5KT0=;
        b=hrx5aULXCs181ptZ5aT5iRWvXyz5W5KfYxFVKSfoN/wCZG8Y0PIEObRwPI9mDznfjB
         2TktflYTYGN4G/dBdIVYzA/7sYbFpUhz++cNXinM6jZRV0ruxYz5rXTiUlcvrgPpJ7Lr
         3gbjQO4CQWK4IPbixr7f1OIxeXmZr84Trn4Dg0WOtXRxdCHFHDsFLlBwdBHZUfiMml/D
         FtqExGBhmzXnOpKzmuEa3JfaA3Xd57FbOob6ZpekU3pDwrJdzZbvfkRKuOoOGTFhX9pb
         ps5XDdXeb26Ug0eS8QWMirwO3j0MZlKt6aU8PtSiN3+NLLb1EF6lYqko9F9vlYPQTmKy
         qaYw==
X-Forwarded-Encrypted: i=1; AJvYcCUCooppuq2fSswBOfYvZSiKXpYe29WUPEd37shk7khNhj2jLX1/9BwR3vD9vJTTnku3mVrctE8YF5K7a5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeO7M1LY6KVparcWlqge0jOmmi0S0y15DmeJxOqrxIsRQ63lS8
	GEQXyYpZ8aSIu+iLXsn6SZncXcOd3XSVJnbKk4i8gHgh/FBla1y24OMVY8yl0zg=
X-Gm-Gg: ASbGncsoCtP2R3jeioeq5LdeS/6a/39gQhS8tRW+zlMkCjHficV/U9/7L8tHDmbnmAC
	i2RAWhB6nxBa10qYr9z3bVrin4XnUq/UluR05jR8Ln24diTPPR1pHSbb0ON0lLodlOWSszCGB9O
	BHKwyvuFT7ybzfRbHdX/AzGSmv9lgam0M/foj2Vjg+ih8ombt1OxcxdB0VO9tcTiATvz5UnQIQA
	f5Mhamt+hC+kFJbOzxU2KQvjDRRKsFWC7jFWdl2PPx59eIdWlr3y+7naovyKDlCsSBcOaSfuNWz
	tBcph25s/fdyHrKZRNZ6+P+WRxzmBRz/8lJgLYGekA==
X-Google-Smtp-Source: AGHT+IFezafusgH0Nfqe3w8ofO8KtSLVyC8O3T1ydVc5DI21zpkwOsFMsSC0IuJ/AjjVDMl8vHiQxw==
X-Received: by 2002:a05:6a00:2918:b0:736:41ec:aaad with SMTP id d2e1a72fcca58-739059a3489mr22729359b3a.14.1742852786031;
        Mon, 24 Mar 2025 14:46:26 -0700 (PDT)
Received: from epsilon ([38.137.52.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390600a5f6sm8524905b3a.82.2025.03.24.14.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 14:46:25 -0700 (PDT)
Date: Tue, 25 Mar 2025 03:16:18 +0530
From: rose <i.roseoriana@gmail.com>
To: marcelo.schmitt@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	dragos.bogdan@analog.com
Subject: Guidance on GSoC 2025 and Future Involvement in IIO
Message-ID: <Z-HSqixMyrfqAtq1@epsilon>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi everyone!



Hope you're all doing well.I'm a CS student and has been interested in Linux kernel development,

While I'm still new to kernel contributions and open source in general,I'm really eager to learn and get started.

As a beginner, I find it a bit difficult to find good resources that could help me get comfortable with IIO or kernel

development. If anyone has some time, I’d really appreciate any suggestions or recommended resources that could help me.

I’m also interested in participating in GSoC 2025, but after looking at past proposals and timelines  that is 

asking for the exact time line which i  dont  know  yet  and have no experince  in contributing  so ,  I’m not sure if

someone totally new to the Linux kernel would have a good chance of getting accepted. Do you think it's worth applying,

or should I focus on contributing first and try in the future? Any advice would be really helpful!

 Looking forward to your thoughts.

Thanks,
Roseoriana

