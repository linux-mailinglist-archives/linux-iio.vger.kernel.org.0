Return-Path: <linux-iio+bounces-23572-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD25AB3E010
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 12:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8883317EC2A
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 10:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B6130E834;
	Mon,  1 Sep 2025 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9iepLqj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5EA305068
	for <linux-iio@vger.kernel.org>; Mon,  1 Sep 2025 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756722302; cv=none; b=EKIZg7dzr8jCtTXVpka1edHbTpuNgYO7fS5mBV21v73OMOWaiQ+RVHGfq/v7sEU4bkxC8dWGCwKlrT0JLuoYMg5nBto/+EU62bsmQgWh8u3J/p2Kg6lQdwztOl8ALroX1QOOpy2R9Bwh53BwNp0mWVZl3BAsBgrOH1nFK3/iIdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756722302; c=relaxed/simple;
	bh=3G7Ld1qpychcmtTgTNSsdZQiAfnbhqLqy04YO6fvdYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKZ542T1I64oMTHwfthAtLW+rlDk8sG+HheRTTaS/K3p9/x0AJfFuH/OB1FD0ZZS4HfdLDEUvvVcgr+kIueuSPSZ8AW6oghvcn4XQCD+rvcF5KYVojxQ4V7smoBSRE/BVJcQ7nX+dWE/DTYByHMFEZoaSHfqCkTwroASgD8x+MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m9iepLqj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b87bc67a4so9493705e9.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Sep 2025 03:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756722299; x=1757327099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3G7Ld1qpychcmtTgTNSsdZQiAfnbhqLqy04YO6fvdYc=;
        b=m9iepLqj1IbnnI64M41hS7psoA8qRIDcO2r50ehlPJxnb1pNueFmpG0kpOMOfFcav8
         skzTcnO7NSEKeuJRVsKPqOkDdu8jtE0oEkgBVRgDkmcssJXqGqZecop7kfDhBQgjkWSd
         +D0JM+DgF1+4wQZFrBiBBLrCs69j9KwrUBXvrFEx5CDAn+39IeH3f+SlBB9FGLxCIqtt
         duIb//Xz8Qwe37OlNUUhWS6a0atK367vob1Qw9+EqI5Hte8gOlG73JCNEdGvJljc6juM
         FRzzIqXS177oFetVeZB4eHA9xm52w8og+sHRqMB0XVgI5SNUaNDn4QUGOoTIdOTYR4Ka
         frkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756722299; x=1757327099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3G7Ld1qpychcmtTgTNSsdZQiAfnbhqLqy04YO6fvdYc=;
        b=Seq28BMKwNeuSXyJKhU7IIjqt+hqSp9GVainnd7ubj5bpTHzhCXf8JHfFsbEuhzTsr
         pU4tGz9pmedEoAyV8vChfmz7uqYGhNnO7swvcOqhmKiKdU63xMoR1TLW5d7DNTooyhob
         mb1hDp0aPolk0+070RyPSG4Z/BrCWL8f511lr5dgyvj9zLJaz2EmCq1GIXw0pLiJrHam
         dH58ViBYaaDe/35CxgKFpU0NorQDyJRIxFQq2kNj6yEd+JjZdNBJoiebmDpH71dXPEph
         uAoka/oJoocmeL9X5hUe35pUcEEC48tYjCy+yx8eLmU0D4J5wzZgsTTH6iH9w/Yu3aTj
         rbKg==
X-Gm-Message-State: AOJu0YyUNYIvbTPw1Io4d2u/D2JLyHQ13ugeU0NH23siRc8zYpHZDXNh
	8oLptmvcxceORmw8T7Q0cDN3cmUTI9YU3FrXTAgi5xXz1qnwS64+ql3J8bwu/92ThCY=
X-Gm-Gg: ASbGnctTJAQk2Mm5yqJyM0erkNchTBdXK1bNmziiCHFvQ+7wmB3s6VYC2mHF2SpgFcj
	bDxUc1RMpoS09GoXnH1fO2+uNsD38PTa1STUBK97EpDaPIht5HlSmckXkPuzABGdqls/kTMpi1W
	J0487t/aWGqBh9hjTcY/naDbdBPZTlxnREepjilRI0sEWCNAURkVkPGPikzqiTv1CG4hqCL+5Il
	/Xio1g33UhhYeJVoFyZJYkpfDRfioLnr5gB6Bvkq3a631YglFiZ/nYfH2qpZJu3snnJP3i+JRKQ
	0f7IUBrbNH/L1fiGkM/hmQJZI6TZcLBrbdLOpDLvl1ulXn6nD5CN/lHj1RVtXSJQv0zGZW25b8K
	LtWHZLK4wqYTMIjtwH+Qefa+Q21buy9KIV4+KVg==
X-Google-Smtp-Source: AGHT+IEec6vgPDcCrTDqOTyHepBVzBKIfJKmIoOvk/faBhoaRvzUBEt6+Jlp+ejld3jTxV+5QEbZEg==
X-Received: by 2002:a05:6000:1ace:b0:3c4:497f:ecd0 with SMTP id ffacd0b85a97d-3d1de4ba70dmr4550881f8f.31.1756722299510;
        Mon, 01 Sep 2025 03:24:59 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf275d2717sm14784721f8f.15.2025.09.01.03.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 03:24:58 -0700 (PDT)
Date: Mon, 1 Sep 2025 13:24:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH v3] staging: iio: adc: ad7816: add mutex to serialize
 SPI/GPIO operations
Message-ID: <aLV0d9sLbVRZdozH@stanley.mountain>
References: <20250901073750.22687-1-moahmmad.hosseinii@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901073750.22687-1-moahmmad.hosseinii@gmail.com>

Please wait a day between resends to allow everyone to review the patch.
Same comments apply as to v2.

regards,
dan carpenter


