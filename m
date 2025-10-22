Return-Path: <linux-iio+bounces-25343-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C86ABFB899
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 13:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815D7584FF6
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 11:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E016328616;
	Wed, 22 Oct 2025 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xsk4Kmj2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DA019D074
	for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131103; cv=none; b=ermxIuIAn4Y7+x65Mwv86QyiyBiyWqjQBvW4S1Ir27/NXJ859zX1REIZSqoZKamLbXqSBoGGoP01VUCAtI7MadaWSjWCbaBndAQE/QsYCE9/lIDivEM8ySGAYCiXmxGJUxcS/SlBZn2pFj+rcT8rrlN7RYb+A5lnRMV48PqVvys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131103; c=relaxed/simple;
	bh=zvK8oqIbpq9S6ONSC/uzbjYtPbhFw9p9XGBh7GY2yzw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bnjsh+AWagaWPgj3P+IRirP13TpGIK6xSEl8hiIHaQWALmJZLNHXHDjGxk2KRFhFtUx2PhxfwLix32k4YpQbT1IFEPQmCpUEbuwJ3WUmgpUFM07LC0ECaYOi6wX9KyhP8MMnSRuMegzShm9NK+T7ULtTrs1SMCT+m8enSNsFSso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xsk4Kmj2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4711825a02bso44661645e9.2
        for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 04:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761131100; x=1761735900; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rgzPCJZ52mqTzrhyZgVvDremACECcbY2tu/WZsAw294=;
        b=Xsk4Kmj2VDSI632PNH87nZDhQYbdesVuqt29QWn89ugMdnPjzCVs7qkQ5FCGtmP5ll
         wELEYdD1yyiXKBAJWf0w/sdrmHoZ7QK0Faxrf6yBdl9s3Gldyxb9G+wmfSLe1pnfuJTr
         twGhgE9AON069HFfKuOl5oJr0oBdE0Vr1+mSo0vY65af7ORVnj2km0Rsnl9fLvebJ98b
         3wP+/a6Cqgdt3J/foxiaA5+eC/pe0rGLkcWJicIw+xeEvXdf65z2n60/F8zYsXqDIzbb
         X/5eSPQ7lcSEFtIEdMoN8FeU04giErTXjo7Np3p0E9cy3H3VZBBTHpAboyWUO7NbF51k
         lMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131100; x=1761735900;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rgzPCJZ52mqTzrhyZgVvDremACECcbY2tu/WZsAw294=;
        b=m1Tyd2Ic3de/aKwFa9/AQ+lUk1VrXqtncOEq+XiZqy3WMS+/pChUX9Fi59GY+7GUF4
         XQndwDeE1ft88mK0z3zPEN7OCqeNLcNEYaK5+INDGTjdUyqoLEo5nbJxUEepaYcLSHrk
         ahIiPnmRSN9jEtzG+afHYBYEmZHcTE0WRF+ML9EBiDGcvg1sEdFRtheOYPExgx0qFn1B
         PIeaMPnKu3VTuHMKhvRa2yykK+YK2cxhph+1R9A6W53jgVeYvZfT0SJpadu4Kv++1q4z
         PtgQyKOSAckhLf5v9JBzQKEn3L+uAlAP928O5E5CbFH/iVp20F2/vDRtdCr09sor4xWE
         7vSg==
X-Gm-Message-State: AOJu0Yyg0vuyWXouUv64arlCNwPkg8xmoOcyWKaFw4ImIg815M6IPNeO
	koCc4uCvJbVpbv/jyNNMQGKDbDFQaoCo7HQhYHgl60NtPEP5ybthIOREShExoODM82BB+XVDPJB
	UPP8i
X-Gm-Gg: ASbGncvsq3UNyjIABDth8cbi/1R0Gf2ekCLeh8YFGyW/MKCCE6OQ2QdEkyb517ztEac
	NV970Z02NBL/3Ly0XbYB7yl16sVzfSgnm0vATBKwk1bF3uCJYNpTen8xLmzk4Nw6tPdYy8Z5Rxf
	KPSNxRi94mDCr1XxAJ0GOQSD6s2+Nk8tKr+mYUZHnF2A5a/wkQZOhwpzyIWIZ0huxCzgLjCC48A
	zTHHwlaEPByT7DSXEPx247+j6Ir4XlTV52jSRZmqOfxXsEhRJAcNO8cMAR/eQwH+yRcDRlK7m3n
	+Sqvs9n9ajMmM+/bq9eyQVfrqF8Nn/2xPnFjzsxGzOccA5TrO49RB3/+ajWmM0OYLCQrVBLQeDR
	UR1AW6+gPBvkXtfGlYDydlAd6zm71fl7oqmBFnb/oBdl9+r7bdiHWV+fS9L4YZzOHZuWc47Vwrc
	3aGf1S0zk0xmTr8NYj
X-Google-Smtp-Source: AGHT+IEmpt8Yp6R0xHvfAvQoZJlPe6/qWKOsvk19C+ZipEVXsHjGb4IJp0cY+XxUFF3zuUcFj/4U7Q==
X-Received: by 2002:a05:600c:3149:b0:46e:4b8b:75f2 with SMTP id 5b1f17b1804b1-471178a7ea5mr138900255e9.16.1761131099532;
        Wed, 22 Oct 2025 04:04:59 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475c428c62fsm40658225e9.8.2025.10.22.04.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:04:58 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:04:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org
Subject: [bug report] iio: adc: ad7124: change setup reg allocation strategy
Message-ID: <aPi6V-hcaKReSNWK@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello David Lechner,

Commit 9065197e0d41 ("iio: adc: ad7124: change setup reg allocation
strategy") from Sep 23, 2025 (linux-next), leads to the following
Smatch static checker warning:

	drivers/iio/adc/ad7124.c:595 ad7124_release_config_slot()
	warn: potential bounds check after use 'channel'

drivers/iio/adc/ad7124.c
    587 static void ad7124_release_config_slot(struct ad7124_state *st, u8 channel)
    588 {
    589         unsigned int slot = st->channels[channel].cfg.cfg_slot;
                                    ^^^^^^^^^^^^^^^^^^^^^

    590 
    591         /*
    592          * All of these conditions can happen at probe when all channels are
    593          * disabled. Otherwise, they should not happen normally.
    594          */
--> 595         if (channel >= st->num_channels || slot == AD7124_CFG_SLOT_UNASSIGNED ||
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^
If channel is invalid then we would already have read from out of bounds.

    596             st->cfg_slot_use_count[slot] == 0)
    597                 return;
    598 
    599         st->cfg_slot_use_count[slot]--;
    600         st->channels[channel].cfg.cfg_slot = AD7124_CFG_SLOT_UNASSIGNED;
    601 }

regards,
dan carpenter

