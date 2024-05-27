Return-Path: <linux-iio+bounces-5322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106238CFB15
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 10:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41FDF1C2030F
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 08:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CFC3CF73;
	Mon, 27 May 2024 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/2UJLHD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B5D3A1B6
	for <linux-iio@vger.kernel.org>; Mon, 27 May 2024 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797663; cv=none; b=NObjp/Ldblt4J+jgT8tjOuPoGWDwqhcOK2o244ymIOfnOIVsWMBBVNjMGVciADL28zRjRAoko6aZELdrkLCka9yH+zLakWKls8aenHNHldZkH4F4S969VUBoaorCaQLqfxJUi4qItytf05AZUz6KUetky5xY1LcnetU4H8LtR9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797663; c=relaxed/simple;
	bh=nwYaraCxggBDKnVnYzLQQW0XR3XO/+s4UMrvkMG2ZYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLCvDkE/cO2V/l1TqRVg7HnO98vDkV66dCPeMQkgTe+oByFYL5FAOeZqBkrbhHhmYZhr8RVWoT834/tgnXy2zGX/br9dfzZRmodXw6dy07vyiYNAMJ21g60QzoGo/xczlUUXiIMeyPljyn+EhJg4F0rfV/YriHjhM9zmM4J60ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K/2UJLHD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6267639e86so331855766b.2
        for <linux-iio@vger.kernel.org>; Mon, 27 May 2024 01:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716797661; x=1717402461; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2gOfFJLDZFM1NLZoeu2fRwYilxYpWgEWWcHQQR/WPKs=;
        b=K/2UJLHDKW68eL9idw8EEEp8naRe7lSMEvpaCj6OZwGtuC561mk3rm0O5xGycLE+8Y
         GCFq9BSSZ9mN5sjpL/wSz+4aPufi02V5CzFs2Hkh5dHcWKBcdljP+gOW0kLpF11HcE5Z
         /xgaj11Nqsex5mL36G578m9+HwsrPs78Ejd33tp/H3jwMqtH2D0T0QApD4NqEX1QQHNI
         z1V+ovtNmJq6yQ8/+O5VOqlGLTUXqUsvmCwfZfxD35Ft+qP3j0LacJR2Qc2AkEW/l0Qc
         u2WxnpAb+T+izEzRRtB9i2//Y76sXce/+mlcVMxN13BbuSMj4EQCm4Y7jD0HNufmtctp
         7QCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716797661; x=1717402461;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2gOfFJLDZFM1NLZoeu2fRwYilxYpWgEWWcHQQR/WPKs=;
        b=SMACr10FRDedk32PyrkJnE+jfuJ7WE3WaM4yx0GOCWa/buVXIeUYHDGeiubrfW2kp9
         n0yMRozNJ8SKjh4PcRqu56IvLAdtSnWR+ehDDjs+k88FJuiFQIUmwq3buwnOD9w0+5sH
         +2XsRqJFGPLdr4orS3Du9gfJ5vVyAekYbKmJxvJZa3PDzcW3rS15wfDVTqIUYIb3TO3I
         6a74fgBnplOmkkSxUrhuPzbaABK1JAgyStTuqtyNZfLcHZJZa5qhiU0QGoc9pKM5w7SO
         1hrp31CE3fF5UgAddHHe3VFugDZKZ1BAW7ORtBToKPaGurNNxHfmKKRIxbY94B61n1Tu
         BADw==
X-Forwarded-Encrypted: i=1; AJvYcCWclPqTSM5SEAydjnfx6Y76mT9cxoTJpc2j+C2eOcwNBbZjx9aPLPQBmGG1NQYPK+Fxtix5SloIFdSiYKsYpiGZ6ge7hQXZgrI0
X-Gm-Message-State: AOJu0YxOSbR3TGhCPQqcGCaHOVmqhPSrj0CbMqnyv5V44lOunWszt+Zy
	/U64RXoKgim06W90LjUY6RnKThhICsHW6GOZcBJPusJE6aERV7AxWPMqXOOoYuY=
X-Google-Smtp-Source: AGHT+IHYnL+hf/PaVRs5w2cBRVnHz4XxYlxeikqwWQlJyhXrjPG34g7ILif/Bx2s4uuxLU41DeUKtQ==
X-Received: by 2002:a17:906:7f15:b0:a62:e9c:f621 with SMTP id a640c23a62f3a-a6265148c46mr601649666b.58.1716797660675;
        Mon, 27 May 2024 01:14:20 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8dcbdsm472629966b.175.2024.05.27.01.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 01:14:20 -0700 (PDT)
Date: Mon, 27 May 2024 11:14:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: oe-kbuild@lists.linux.dev, Yasin Lee <yasin.lee.x@outlook.com>,
	jic23@kernel.org, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	lars@metafoo.de, swboyd@chromium.org, nuno.a@analog.com,
	u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, yasin.lee.x@gmail.com
Subject: Re: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor
 driver
Message-ID: <6f479ca6-cd6d-4a28-8afe-8b74c4d171d4@moroto.mountain>
References: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>
 <59869d5f-3d97-48a2-8a96-127f7b46c0e8@moroto.mountain>
 <CAHp75VcTxXsnKVR5EQYTNhokHeXrOxQPe9gAkWFRr0yZT1KTPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcTxXsnKVR5EQYTNhokHeXrOxQPe9gAkWFRr0yZT1KTPA@mail.gmail.com>

On Sat, May 25, 2024 at 05:00:59PM +0300, Andy Shevchenko wrote:
> On Thu, May 23, 2024 at 3:42 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> 
> > 5e5a419c9407f6 Yasin Lee 2024-05-10  1110  static ssize_t hx9031as_raw_data_show(struct file *file, char __user *user_buf, size_t count, loff_t *ppos)
> > 5e5a419c9407f6 Yasin Lee 2024-05-10  1111  {
> > 5e5a419c9407f6 Yasin Lee 2024-05-10  1112       char buf[BUF_SIZE] = {0};
> > 5e5a419c9407f6 Yasin Lee 2024-05-10  1113       char *p = buf;
> > 5e5a419c9407f6 Yasin Lee 2024-05-10  1114       int ii = 0;
> > 5e5a419c9407f6 Yasin Lee 2024-05-10  1115
> > 5e5a419c9407f6 Yasin Lee 2024-05-10  1116       hx9031as_sample();
> > 5e5a419c9407f6 Yasin Lee 2024-05-10  1117       for (ii = 0; ii < HX9031AS_CH_NUM; ii++) {
> > 5e5a419c9407f6 Yasin Lee 2024-05-10 @1118               p += snprintf(p, PAGE_SIZE, "ch[%d]: DIFF=%-8d, RAW=%-8d, OFFSET=%-8d, BL=%-8d, LP=%-8d\n",
> >                                                                          ^^^^^^^^^
> 
> 
> > Also use scnprintf() instead of snprintf() unless you need to check the
> > results.
> 
> This is incorrect advice. You should recommend sysfs_emit() /
> sysfs_emit_at() in this kind of case.

No, this is not sysfs code.  It's debugfs.  The API is completely
different.

regards,
dan carpenter

