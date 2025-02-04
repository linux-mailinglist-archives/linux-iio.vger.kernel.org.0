Return-Path: <linux-iio+bounces-14962-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD808A2701C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 12:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E6F161E0F
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 11:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8772063E1;
	Tue,  4 Feb 2025 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YQ4NrwM4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DC720127B
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667923; cv=none; b=F/JW2jL+vcraMoAL6U6NEYMFX3poA6Le+sQZOCqnBvb4+9miG5zoMl/nxGuZbJJSoMcZQ8O2gfbZ47/THcVhNcQS1r6IRV5PSBS0hFRQQ5uDnhYOB4WlSHNs7HSh1dA8AO0vt3tM8mzHTNxYUpIVJHfxbUCokHB+Ktjuu2ACD5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667923; c=relaxed/simple;
	bh=FeMzTB4TxHFBb04KkfAYzM+GWfZ2x73P89kK6WTaw00=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dk6pTgjb82m7LJqngfInnHoxnB4ml7T7H7abeOVte3agQuTxadEj8uS9DkTwQ13+QjNQZlKJ4xr4UlkkNr0w6Se+BOLOdv/c+ASeTh07TQPYxne7FLh0mW0bL6236Hfg/mAaU0N3ioCY7JT0Jyr6LWNE4/lR7ZJtQKyrCkGFskg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YQ4NrwM4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361815b96cso37510335e9.1
        for <linux-iio@vger.kernel.org>; Tue, 04 Feb 2025 03:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738667920; x=1739272720; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5mhP8LiKBikXG8aVOM0BH6UI86v72MZsLtTtmlwEH4U=;
        b=YQ4NrwM4Ghj/tkdN5XGyvJtMsLCt0obLdeDiwLul+60dTzLzPtkN178guv5/jD78Lu
         b2eMM/q5vMFk3tyALAVS1/kYAINzrxFSlWfpY1LsDoStLQijHOydMJb/YWehBT1T6RoR
         nuiXcPeknv9IsBdhkuJiHPJPXv1NS/na4MWKQa2kFqcy7j8hZWIJIqWUCbe88ky6y+1q
         zRc3YFVglM4CqSfwa98f8L5GknMnEuyijnPJ12POWgRoHqc8fWdLTF3le9Qs3y64Qyjp
         03SufLzx0Psy4ELySAlezH6TnpERCvaDdycf01O7qthTekYJxgb6MtbL4Iy4dGpkRZ1C
         jpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738667920; x=1739272720;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5mhP8LiKBikXG8aVOM0BH6UI86v72MZsLtTtmlwEH4U=;
        b=Sv23Srhhaql8VQdckPhmtu8CBdUCXkvFxCaJpA1TspHUlfLsiLYnZBwif/0wFDIGVQ
         cpgTzjXnjPf0R0A59Mx2gWFNrt7gub8liL8v1DgnKpKLmjRUGxYjoetCckNvXUPUR73h
         F7UCeVEhOUhuwcMTHI5mlSzSulsHu3Kxp4t5PbaOcUUpC4wszMhAKuVDJ7L23TM1lMJw
         TGkI5gGr+0kapuew9eVyv9MmQbI8FW2q4f6ZvfjisKxe0bD0UTtT3LpokM3EA4rOA0cI
         FAYxVU4jZXSe3qbZvsWPnkVGnPU/OcmSYgDC3bEMNTn8y/aAdeEobKOPr5GzdyI/QXYH
         22PA==
X-Gm-Message-State: AOJu0YzHegeypc1j9D/ccjeGTf3+JwHBRBMj1knGEyYBw+ZZy+vX+qs3
	synGd8bav92ZvMByl1PzbBOjInfwMw/OMWvn28GJHY+8cqwqXpLPZLksdmSWUfM=
X-Gm-Gg: ASbGncvSGmM286LziJm4H3fEa1mrBgP5jkAPZooeiGT5S9iRhWVXTicDTwFBIGPHaFT
	H7vciZ/qsevbAZhfnkEMPDgZb5mf2nq2lkEDc0pWZdciP65bD767azUZymn9HdgfNwU/0I3cBNm
	tiWKvj5DyLjE2QEN2lx3ay5glMaKF6Bhpo/7MeMXSm515jdMDozIqkN8WfXPIrxt/d9rqVWGLTJ
	YhLoD6xp9K4vV2EWmaiVi/5Ir2zx/hvZxtNK2OHx7N7tG17B3/i7DyUg1BQQ2aul28tZTTp5pfW
	sP5C64cYUYP1KKe10K3Z
X-Google-Smtp-Source: AGHT+IFzl7/y6Jwc7f2kOr5FQm6oExyIULb06HdYpzPespKWBnXCKBwh2RzZYpUEYbMOms/34IE/kg==
X-Received: by 2002:a05:600c:c17:b0:436:51bb:7a52 with SMTP id 5b1f17b1804b1-438dc3bd7e3mr237072185e9.7.1738667920155;
        Tue, 04 Feb 2025 03:18:40 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-438dcc26b15sm221638245e9.11.2025.02.04.03.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 03:18:39 -0800 (PST)
Date: Tue, 4 Feb 2025 14:18:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-iio@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [bug report] iio: magnetometer: add Allegro MicroSystems ALS31300
 3-D Linear Hall Effect driver
Message-ID: <db435a8b-7546-4d16-9a15-ee44dac849c9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Neil Armstrong,

Commit 3c9b6fd74188 ("iio: magnetometer: add Allegro MicroSystems
ALS31300 3-D Linear Hall Effect driver") from Oct 30, 2024
(linux-next), leads to the following Smatch static checker warning:

	drivers/iio/magnetometer/als31300.c:248 als31300_trigger_handler()
	warn: check that 'scan.timestamp' doesn't leak information

drivers/iio/magnetometer/als31300.c
    226 static irqreturn_t als31300_trigger_handler(int irq, void *p)
    227 {
    228         struct iio_poll_func *pf = p;
    229         struct iio_dev *indio_dev = pf->indio_dev;
    230         struct als31300_data *data = iio_priv(indio_dev);
    231         struct {
    232                 u16 temperature;
    233                 s16 channels[3];
    234                 aligned_s64 timestamp;
    235         } scan;
    236         s16 x, y, z;
    237         int ret;
    238         u16 t;
    239 
    240         ret = als31300_get_measure(data, &t, &x, &y, &z);
    241         if (ret)
    242                 goto trigger_out;
    243 
    244         scan.temperature = t;
    245         scan.channels[0] = x;
    246         scan.channels[1] = y;
    247         scan.channels[2] = z;
--> 248         iio_push_to_buffers_with_timestamp(indio_dev, &scan,
    249                                            pf->timestamp);

So I guess we had some CVEs recently with regards to
iio_push_to_buffers_with_timestamp() so this was added as a "must be
initialized" thing.  The "aligned_s64 timestamp" struct member is
sometimes initialized in iio_push_to_buffers_with_timestamp() but not
always.  So this seems like a valid static checker warning?

These are simple enoug to fix if we add a "scan = {};" initializer
but the IIO function is slightly new to me so I thought I would consult.
There was also one in trigger_handler().

drivers/media/pci/mgb4/mgb4_trigger.c:99 trigger_handler()
warn: check that 'scan' doesn't leak information (struct has a hole after 'data')

    250 
    251 trigger_out:
    252         iio_trigger_notify_done(indio_dev->trig);
    253 
    254         return IRQ_HANDLED;
    255 }

regards,
dan carpenter

