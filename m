Return-Path: <linux-iio+bounces-21704-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0429B06996
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 01:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A9258000D
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 23:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71377262D0B;
	Tue, 15 Jul 2025 23:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aIjSVP3o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990D92D0C64
	for <linux-iio@vger.kernel.org>; Tue, 15 Jul 2025 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620407; cv=none; b=ZhT1pa9qyKQgpYmDHu0KLWH/GSa23Q8SFDQwJM/1F0pNag79d83w4iX5cHZHLNLaus3gxq+l9zV4Fu2ZYZuDQ6IvYaZ/3R3m+kmwBIArBgi2rCsEvlZTYkw7YwzIQONQdXfbdvjOWeBSgovXmV52OlnH6BnypokVVCRZbX2z3W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620407; c=relaxed/simple;
	bh=d36tryP/Ua5vUtyyJ/UewKtRTP0UZvQIGX1Mo04u8lg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aI4YmJVWc6Eau4gcVI2Wbr+GdZvunMFKL4bh9a9EuJCa076hn0yZ+66uicrogHBpOBNxfiqzQQqoG6EbNckbYsfCijlHWzy4Tz0wWZ3EUPDvvf2Vt+LgwP6TmQnGm+MSW0ZU0ISQ3lKyTFu/3fUWBJ/RpweTKGUfcvcuoXx19A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aIjSVP3o; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-73e5d3916f7so438253a34.1
        for <linux-iio@vger.kernel.org>; Tue, 15 Jul 2025 16:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752620405; x=1753225205; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p7PCggX6X9bOzevMOg3SQbY3Yin5XHTMyASZacLZGeU=;
        b=aIjSVP3o7Z6NFW1tc9n+p2IJMJ/uNvBTpFpQSXnCvNQqUbwdElN9AF46GIStmz7BKx
         2sfDIEKzlH0270bgI8/7h4jnKlmM3YF/X4UBZNgnzVuMk5f2Q8eXWW37icdnuYgY9Qnh
         3wrK6Zq6n44tx1eKmrWzr7IMHSispXimz+5+S3J7Q35bb5zkMwgb1NBgAJC6wYVZxXRf
         ehQxbkob6/Gud6WCwG2nEfr7ZhaMZIgkhRpKAyTsJ32CRoXLNM0QcbleSgNnWL7NBUbO
         32JAKV7Qx1ZMUpIJxmnUHSgXiDUd8eLr95oodvZaPI8GoZeSdPnbUORA7SS98OrfNthR
         aXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620405; x=1753225205;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p7PCggX6X9bOzevMOg3SQbY3Yin5XHTMyASZacLZGeU=;
        b=sIOKMW+hyLJbGNpYHbwMrbCmn6bRR6JgbaLhE7RSyrHhI0/leIVqAV2OaULp5fxNti
         MDE92SLYEDR99XXLwhWEHTW37oB5RDDGAo6cMxgbkXD/vjuhc2ciP/5nAmflUtSmuDbI
         1THJHAAbcWAu4+0xGhM5cGhK1Xs6D4Rym6sWAXJqFOEMPdd8fIRILNnBrYA1+9HGIamt
         qPb2FBA5mTHPm9/MlrdpnvpNmeJkHWmGpeqZu/4d3rq8PgiYMdXoKGgEGDAZOqP1908Z
         KJc54mBQqSVfQLHdwV53pI/daN2c/m4uYk2rOC4cFfJ5X+0OOhwUJr8Ba4wW2JplY7bP
         NAig==
X-Gm-Message-State: AOJu0YyVM3cclubNvlyNSy0vb/ns1RA9Ot+ZbPXZGNPnXq9/w//Z1Sx8
	6QcSV+WU9UEK1mdOLfv/AfvzV7NWolxg8mK5R+lZtFybyPnua4WSsTdKpU3bKUUZi2Y=
X-Gm-Gg: ASbGncuAkRnLJymWd4MDgePZ6u1P70DPE/YnM0F3/tBejBbsel5BdNO5qJazw4N6BrF
	MRaE/VNhRL6pg0R16F0Q3FrcwozoV9yN68YS8l9+TWMYBss+OLUuk7ldmusbk0mNb2I/dHYus1u
	SqJQd5TXtT2EfcoB/JLyZVlVuOyGfiTWAdbwiCdXSA30bReLNs6xjo2hAVuYJHUG9qSiBkUnlyX
	tUjhBr+9SORwCjunti0V4nu5XeDy0k46K6OxB+H0yn+C/5Nn0QlO31qNcZKBTW/KvQ8+3jPivQL
	TQsy3tNmFL4qsN3FkOtcdnmqy578Lb4qOYnVT4Kc2hgbg9R1vDeMBm6HRDAz9DfFqYwHHE15AR4
	oQhYEb55FhrYDiS0p1UoyJ2qTF1Q8NNwQQhZduf8=
X-Google-Smtp-Source: AGHT+IHYspPQRwYXly2hM+1NoD5KYH+1JAo7QwT4JZvC3IlwPkCUZZAbuuPllnoQURyVWswGA/eOHw==
X-Received: by 2002:a05:6830:6f8d:b0:73a:e93c:ec22 with SMTP id 46e09a7af769-73e64a6ed48mr1158487a34.8.1752620404584;
        Tue, 15 Jul 2025 16:00:04 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:9b4e:9dd8:875d:d59])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73e5a69bcc4sm861828a34.47.2025.07.15.16.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:00:04 -0700 (PDT)
Date: Tue, 15 Jul 2025 18:00:03 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org
Subject: [bug report] iio: adc: ad4170-4: Add digital filter and sample
 frequency config support
Message-ID: <c6e54942-5b42-484b-be53-9d4606fd25c4@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Marcelo Schmitt,

Commit 6b648c49d491 ("iio: adc: ad4170-4: Add digital filter and
sample frequency config support") from Jul 7, 2025 (linux-next),
leads to the following (unpublished) Smatch static checker warning:

drivers/iio/adc/ad4170-4.c:883 ad4170_set_filter_type()	warn: always clamps to 4
drivers/iio/adc/ad4170-4.c:886 ad4170_set_filter_type() warn: always clamps to 1

drivers/iio/adc/ad4170-4.c
    870         /*
    871          * The filters provide the same ODR for a given filter_fs value but
    872          * there are different minimum and maximum filter_fs limits for each
    873          * filter. The filter_fs value will be adjusted if the current filter_fs
    874          * is out of the limits of the just requested filter. Since the
    875          * filter_fs value affects the ODR (sampling_frequency), changing the
    876          * filter may lead to a change in the sampling frequency.
    877          */
    878         scoped_guard(mutex, &st->lock) {
    879                 if (!iio_device_claim_direct(indio_dev))
    880                         return -EBUSY;
    881 
    882                 if (val == AD4170_SINC5_AVG || val == AD4170_SINC3)
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
So "val" can either be 0 or 2.

--> 883                         setup->filter_fs = clamp(val, AD4170_SINC3_MIN_FS,
                                                              ^^^^^^^^^^^^^^^^^^^
    884                                                  AD4170_SINC3_MAX_FS);
                                                         ^^^^^^^^^^^^^^^^^^^
and we clamp it to 4-65532.  Since filter_fs is always 4 in the end, why
not just say "setup->filter_fs = AD4170_SINC3_MIN_FS;"?

    885                 else
    886                         setup->filter_fs = clamp(val, AD4170_SINC5_MIN_FS,
                                                         ^^^
On this path "val" can only be AD4170_SINC5 (1)

    887                                                  AD4170_SINC5_MAX_FS);
    888 
    889                 setup->filter &= ~AD4170_FILTER_FILTER_TYPE_MSK;
    890                 setup->filter |= FIELD_PREP(AD4170_FILTER_FILTER_TYPE_MSK,
    891                                             filter_type_conf);
    892 
    893                 ret = ad4170_write_channel_setup(st, chan->address, false);
    894                 iio_device_release_direct(indio_dev);
    895         }
    896 
    897         return ret;
    898 }

regards,
dan carpenter

