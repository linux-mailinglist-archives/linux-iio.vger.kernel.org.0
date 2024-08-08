Return-Path: <linux-iio+bounces-8328-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4409694BE81
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 15:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A391C23E6B
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 13:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C701418DF6D;
	Thu,  8 Aug 2024 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COAEB1fI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD5D1487C8
	for <linux-iio@vger.kernel.org>; Thu,  8 Aug 2024 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123669; cv=none; b=ok1XwVo0GmShIEz6Df1L3SpTLNt6ob05R9wO9S3IXuwsnv6UKSya1I2IxSSP9ceUMj0KYns3XRHpmxy0mKvjJKLDaGJ6OWbp+0jwXmB9sLktPBJpztTeBg4lyeJ1Hhean4TKVaJBYqr5U2GCKh6r1oj5B9+fcXkE4bOpwG9zNqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123669; c=relaxed/simple;
	bh=3gkBn0evgBHfX/CcAEpnpji0b5ZLs54PODmGFp6+KgQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LgotkDWw6r6e/80wc4XlFlVyCDSRAFgJA4hRxXpvnQcrr5eMXLCfBCmpqvR8A/EyvMEQOoqb5M/ztoAuD1WuvTcY/wrnF9rCjRca5jy9BmOMfxaBoAIkvHvtFJblTG9tXmYbXB0e1Ftu/CfaiWEyl9as5oFZK4ip1GKkCnUF+Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COAEB1fI; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52efa9500e0so985712e87.3
        for <linux-iio@vger.kernel.org>; Thu, 08 Aug 2024 06:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723123666; x=1723728466; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3gkBn0evgBHfX/CcAEpnpji0b5ZLs54PODmGFp6+KgQ=;
        b=COAEB1fIaSl+csC50toPB0YcYf/7veP9rjf9ZLKPn84k+98o++FVuCqRB9TNzTEQ2J
         6ns7L8y+TXwL+CQRq1t2g0YOFZGRXaR5k4j2dlhjybJAgbM3To7QnJjMieAHPMxpObcW
         KxhGy6N9WwYhpf4qerIXmthHQbW0hp5DrrhLLWFM9S2zUV8RVNPgbTTwT7Q68X2v9at8
         96HF/aHenBDJATSniIQikqn2hpaWtjHqIbXYsYBvMEz7blmuiQZxzNQMaj+KoYcJUU7L
         ch0ou0bNRRENd0Roq8RWmxN7mgY+sorSatcT0q5rLX+8y80owDjYuoTeNp1hRFVvhny8
         aZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723123666; x=1723728466;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3gkBn0evgBHfX/CcAEpnpji0b5ZLs54PODmGFp6+KgQ=;
        b=tCsdMZUoR1BTSmg4MVqEpex08wZX9MaPRWv4Q5TgqSeDUMpv6EYpGNMz6+VK8+qHV3
         ascmBxdd+LKZff5L/XLNybDbMXludKvbNMtiHlg1eIws8yo0OMotdaNvYAXzbJiKiKLJ
         M6GY08DluGUjs2Edwt5BCt4fy+pgTww5+vFluW/dZOU5HFjzF6Yiq98G1y8h5TUOX8KP
         Ih7X4ekhUh9jxauJU8ofZsMs9cJzstuLQ/Gcg47QcxrP2XhM0S0v2Lk4Wo7npz8uZSOn
         JraoQnAxZIFMo66qeB4b2XBQTNqe2/YUlIoCDFAXYtxRbjTWCm0yTAbSUOpl1DdgBFRG
         IbAg==
X-Gm-Message-State: AOJu0YwPsmRzv+enRTm4STh0eDUrWNoGDIfNRVzcICj6ovf7PyiQkPmP
	8QwIq3ID4oBcP6Sb87y+ZeML/id7/G7QJzZ0H2lGYkTrOb9Nl3fpVPoLnZqLMRaY/viGrMlZCLA
	3qzrZ/KMvTSRdZT14/eHkFLfnkwhrGs15fNU=
X-Google-Smtp-Source: AGHT+IHr0Jji+fn16kapE9aTY2s19NCdDqkm6Gy1whjc5Efc4CjfkVwo/Kp1flpP9aOi2skZVbvIKESdC8xtm45K15E=
X-Received: by 2002:a05:6512:104f:b0:52e:95dd:a8ed with SMTP id
 2adb3069b0e04-530e584fe29mr1437972e87.35.1723123665460; Thu, 08 Aug 2024
 06:27:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Okba Slatnia <okbaslatnia@gmail.com>
Date: Thu, 8 Aug 2024 15:27:33 +0200
Message-ID: <CANArCKRKt4-Epxw6KCmrtRZNKBKTLT78m9Rq0__3GG9BJMh6ig@mail.gmail.com>
Subject: st_lsm6dsx minor issue
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I'm building a yocto firmware based on Linux kernel version 5.15.148
and i'm facing a little limitation or problem preventing me from
changing the value of the sampling_frequency of the accelerator:
/sys/bus/iio/devices/iio:device0/sampling_frequency
despite i'm following the
/sys/bus/iio/devices/iio:device0/sampling_frequenc_available for the
possible values.
for the info , i can successfully change the sampling_frequency on
another yocto firmware based on Linux kernel version 4.19 and despite
keeping the same kernel flags confs i'm still facing this issue , i
made sure it's not an access right issue because i can change other
files in the same path with same access rights.

Can you please help me and tell me if I missed anything ?
Thanks in advance.
Best Regards.
--
Okba

