Return-Path: <linux-iio+bounces-13303-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD469EAAF8
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 09:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6DB28109C
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 08:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7750B230D08;
	Tue, 10 Dec 2024 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hisit47a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6FE22E3F8
	for <linux-iio@vger.kernel.org>; Tue, 10 Dec 2024 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820464; cv=none; b=uADQceZagd9Ha3W70+EOarseVRCFsS8Bj6qZPgmwD1grKqkINwemsGI77xpt6PacV08PMPYw4YPN/pzL1AeiPkZGPrUANWWzThvFkUCFxgyAdrsYCFk2om6R/MbTgNPtc/7PVODYI+YC/JS/fER7BxtRNGL9ovI/88UlRsb58AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820464; c=relaxed/simple;
	bh=ECuAT4nP7i9BweFK7juZ/y9yq7LiAJKWQ8pjhyaZfU4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bvrrTw8BFiqYQwmE+3UhbzYaBNNUsSbzV8aTwv6EXiXrQyLPkdYFsW29zL5pghZO4ifjZd+Xweo7Wu7M+Ws3Q5BvGL8Ll41YQ63ve5CSG3focXDor0KDy1f/VMJFe4gg8c+ttQmj6A9va9MtrMdq+qhXFwamkXvsksypE69sB7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hisit47a; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434e398d28cso21221775e9.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Dec 2024 00:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733820461; x=1734425261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LN3mYjDf0WLLoooPbhO+3Eb4XaEvDNDr4DXqom+zuiQ=;
        b=hisit47ayBdrn6NOlOd/osOhMZOh2Vwdj0N88+i8JsaSJrNutoZTZzsQF0b3jxBSNo
         cFhYI3Rh0TDuYZV3oAsUNlFBQ/U5d8wWBSzw4J8ezp7trY40SEE9U5U6+fUUbyFsWvLn
         FQ1SZpCS1ckGz/4OTuxaFMd8tWaxZVkv9nD8OtXMQmij3l7Wfj0MvuFPgsTeHbLvE7L1
         RxOsf0VgtMRBT7astiblLbToS+2jg79po1CaiGR5mw78TB5AReHhqg+XezCrcTksvUe9
         l8qBB37nP9bbGGkgbcAh2m9oc4M6qm/+sMvf6ouJfoFBcM6nibWgXld9XwoFLaUTnx1V
         Wy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733820461; x=1734425261;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LN3mYjDf0WLLoooPbhO+3Eb4XaEvDNDr4DXqom+zuiQ=;
        b=WaRtZtoJ2jK++9AVmyefo0KNvdA42Os8vbdF7ykpq34ZHYKkF9lfK0/5t9y7fZww/0
         +6gWWXIThhNaqLz05sOIPCLgTqVEWeCmW8zmTI+5ho16w9wOIyY8KXmkab+VMEzf1bAW
         aqoY6Zoz8+c7lfoICGcvhBqGARsKO2nTkM+a5SOiUBevm/ob/A6BTBodShtvpQ80FYg1
         Nq/vjPgw2lqjk04jdP/hGVqAS+kLtXwYezpmtPoTGTu7AbWiXIYzTBz6V4xvMZ4Q4syz
         ZgK1J2xjkjPHoy+GJg/vGpVo4mhKkiW7v2gFmDPR4lPYuMCGFmSZgCrr0Bvdm6lYEe+h
         +q2w==
X-Forwarded-Encrypted: i=1; AJvYcCVLOzeuQpTDm6uFw172CQYXIxsmjkXYYP3yM8QOBsVzm/FGiBeivukPepQlqpGYKUCkIUVXfJJR+60=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvcPZS6pLB3ORb6plmdhzoRhzvO4ahc75H7W4xHZ8+JU8G0/cc
	a+NwVEzhEafEQFCyOG2DBuRaWKfinhkgobUaz5ZDBHcovq/abfPT+0uhq7yTqe8=
X-Gm-Gg: ASbGncsBOaIqKJ8m3cvNaJ99ki48LUgyF0ph2vtBbga7Jo5xEF4WOZ67ZZ+p7TLETDX
	R30IbCd/rf/IA2iXGgmDjX3mIqAUStbRBkH6Xtq8+BfHH/fcuNIFipq51MpJqBPhQSr5cT+Uuq5
	vT2wR9lHLTzzNmBJEvq7FaqnzdTsosk3oT8LSLXPQQykyzA5OGG3GWxMwqJFETX/779tf2dHcbk
	rBs532cINKzeUetBg5KY/i89Br3AHT2B6luKm8aOt0IT3FJ0fV7AtASe6c=
X-Google-Smtp-Source: AGHT+IG5cwePAttfHDiwnbYJqi1bg7G1KUe+FWSYgo/LN7Cys+F7UYQC66MSd4jFa0z12FH5wxvVww==
X-Received: by 2002:a5d:47c9:0:b0:386:3328:6106 with SMTP id ffacd0b85a97d-386453e5101mr2651418f8f.35.1733820460851;
        Tue, 10 Dec 2024 00:47:40 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f4a859esm15209515f8f.23.2024.12.10.00.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 00:47:40 -0800 (PST)
Date: Tue, 10 Dec 2024 11:47:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Lothar Rubusch <l.rubusch@gmail.com>,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: Re: [PATCH v5 10/10] iio: accel: adxl345: add FIFO with watermark
 events
Message-ID: <dc914326-7eae-4e4a-8c93-ae1a7007bcc9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205171343.308963-11-l.rubusch@gmail.com>

Hi Lothar,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lothar-Rubusch/iio-accel-adxl345-refrase-comment-on-probe/20241206-011802
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20241205171343.308963-11-l.rubusch%40gmail.com
patch subject: [PATCH v5 10/10] iio: accel: adxl345: add FIFO with watermark events
config: nios2-randconfig-r072-20241210 (https://download.01.org/0day-ci/archive/20241210/202412101132.Kj6R6i3h-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202412101132.Kj6R6i3h-lkp@intel.com/

smatch warnings:
drivers/iio/accel/adxl345_core.c:441 adxl345_event_handler() warn: unsigned 'int_stat' is never less than zero.

vim +/ret +321 drivers/iio/accel/adxl345_core.c

55d2386488598bb Lothar Rubusch 2024-12-05  433  static irqreturn_t adxl345_event_handler(int irq, void *p)
55d2386488598bb Lothar Rubusch 2024-12-05  434  {
55d2386488598bb Lothar Rubusch 2024-12-05  435  	struct iio_dev *indio_dev = p;
55d2386488598bb Lothar Rubusch 2024-12-05  436  	struct adxl345_state *st = iio_priv(indio_dev);
55d2386488598bb Lothar Rubusch 2024-12-05  437  	u8 int_stat;
                                                        ^^^^^^^^^^^

55d2386488598bb Lothar Rubusch 2024-12-05  438  	int samples;
55d2386488598bb Lothar Rubusch 2024-12-05  439  
55d2386488598bb Lothar Rubusch 2024-12-05  440  	int_stat = adxl345_get_status(st);
55d2386488598bb Lothar Rubusch 2024-12-05 @441  	if (int_stat < 0)
                                                            ^^^^^^^^^^^^
signedness bug

55d2386488598bb Lothar Rubusch 2024-12-05  442  		return IRQ_NONE;
55d2386488598bb Lothar Rubusch 2024-12-05  443  
55d2386488598bb Lothar Rubusch 2024-12-05  444  	if (int_stat == 0x0)
55d2386488598bb Lothar Rubusch 2024-12-05  445  		goto err;
55d2386488598bb Lothar Rubusch 2024-12-05  446  
55d2386488598bb Lothar Rubusch 2024-12-05  447  	if (int_stat & ADXL345_INT_OVERRUN)
55d2386488598bb Lothar Rubusch 2024-12-05  448  		goto err;
55d2386488598bb Lothar Rubusch 2024-12-05  449  
55d2386488598bb Lothar Rubusch 2024-12-05  450  	if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK)) {
55d2386488598bb Lothar Rubusch 2024-12-05  451  		samples = adxl345_get_samples(st);
55d2386488598bb Lothar Rubusch 2024-12-05  452  		if (samples < 0)
55d2386488598bb Lothar Rubusch 2024-12-05  453  			goto err;
55d2386488598bb Lothar Rubusch 2024-12-05  454  
55d2386488598bb Lothar Rubusch 2024-12-05  455  		if (adxl345_fifo_push(indio_dev, samples) < 0)
55d2386488598bb Lothar Rubusch 2024-12-05  456  			goto err;
55d2386488598bb Lothar Rubusch 2024-12-05  457  
55d2386488598bb Lothar Rubusch 2024-12-05  458  	}
55d2386488598bb Lothar Rubusch 2024-12-05  459  	return IRQ_HANDLED;
55d2386488598bb Lothar Rubusch 2024-12-05  460  
55d2386488598bb Lothar Rubusch 2024-12-05  461  err:
55d2386488598bb Lothar Rubusch 2024-12-05  462  	adxl345_fifo_reset(st);
55d2386488598bb Lothar Rubusch 2024-12-05  463  
55d2386488598bb Lothar Rubusch 2024-12-05  464  	return IRQ_HANDLED;
55d2386488598bb Lothar Rubusch 2024-12-05  465  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


