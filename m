Return-Path: <linux-iio+bounces-9377-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2435797156C
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 12:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5B31F23BE1
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 10:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37541B3740;
	Mon,  9 Sep 2024 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrXjMbVs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410485733A;
	Mon,  9 Sep 2024 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725878237; cv=none; b=u8NaohAYgVsLQpaY82Hl6Br6Yj2Ge/OJmQtZpvyiz/SVheBTNBTifhNsM24dJfTAfx0I1zD889iU1DSP4c43aL0PID5meRYpc9RCNAWEvUTRsZcA1hucxAJAXPKvBxoLIgFVqJImTU4t9GhKjXUoxPUk05LQ5b4MFkNYOHpJvs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725878237; c=relaxed/simple;
	bh=0henjczPysIqv8jBRlqKenTZivI9zFpfSJ8x0Tro2kU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uscZhhLwL+q5BwpkL0SfPmHV/6RPm+ia4bjrHWdrivxia42cqSEbjYDHiFqiSe5+sci+KdpzvgG1pGloE+lX365il8DXn6C8xCqEYlJmCXhp2WzMyIKVAw413vHDJdUSpXozdzk2dpJUQIMkeCb3O2dyWB4ScRxy6sGhStFJVB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrXjMbVs; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2781cb2800eso2573447fac.1;
        Mon, 09 Sep 2024 03:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725878235; x=1726483035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+B3WOZyQAeblXK1Iez3czljtxG1sm/o5HHnVhLtxPtM=;
        b=NrXjMbVsGvZ02bz6rGY6Ct+xUUgZBbaXvzDv4hrkp4wH/xDdiKUQIOryRvihkkcEIB
         EN0B2unqYx23u2FfCBJ1xd7vXd9etQpqTh/2DubzbkJi/kdqQ5v2RcvQ04ANJKh/tnn+
         +b8fgGQha+rCQfQ6mK9BWyS+W3bCPaH2Lu+1MTp7F90F9GBpNjMToPN1rqHn5dBkuARU
         ql2IIX4W+t4GtWZM83BQP5BmxyESOXIOvgo53S1pbseVIytzITR8dxjRkXOJv/d1EB5u
         t1Iy/F0aLe63K77Ff8Z75uFh9v/mbdToPVp86T+bjB5Hwtg0F1Wh6vgSqr/JrrrsyxHv
         UTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725878235; x=1726483035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+B3WOZyQAeblXK1Iez3czljtxG1sm/o5HHnVhLtxPtM=;
        b=vwulBvu5Zd6GxdNvrhJ6tF82uFd1zD8jJvrszsFzGUEQrbZlYfWwmKBKUA8aWl0jtf
         hbsZ8+y/ZZ6o5XeJ1vTw04pjris8wH3+fxdWzou+wGbdkCkZiXNuDiwPMcAAYoJzJKA0
         9wpDhpXIDMyMjiyt3zH3zpsbHYoRAqvZsLF54y4NUym84zVKV7wg7BlhLnRp+qBJufFD
         e0Y9M5MDnU/oxb+bki689UscerQPhm3IWd8t0GnJerERcZfqewBBIsf3kQ83HRV9rYN9
         IImjeBevJPzEAwxw7s5mxi3CWSHHBEfIA2Heer9SisCXgySesA/tv5Z/O7V3nCt3ya6Z
         DDew==
X-Forwarded-Encrypted: i=1; AJvYcCWebMFmZzvWIg/Bw+4AHczpWsCicIB9TUMFE2BoiPQDXSOjpAEjwJf5N+OHKRFAB4GIR6XouajiEGYW758=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoEUVIwz2yWXDmdgjWteVHKvFPoP2DH13ReQYmyK1e01eRSL8L
	0joAaXHGiA/n6fChLxoBH3aZfb7azoaVBQWlNcrCHT/4RC2cVoEGwtH0YZVhue0=
X-Google-Smtp-Source: AGHT+IHBXmq/Egl4UyWMfIx6Sn6QT+qyM4DlAq+EfgqyRDxhZlR3tbQ8JBQwHfBHMztxrXziPycFFw==
X-Received: by 2002:a05:6871:68b:b0:260:ee13:e665 with SMTP id 586e51a60fabf-27b82fb67abmr12273917fac.37.1725878234645;
        Mon, 09 Sep 2024 03:37:14 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-718e5897b3fsm3258032b3a.25.2024.09.09.03.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 03:37:13 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH 0/4] Threshold event and Sampling freq support for LTR390
Date: Mon,  9 Sep 2024 16:06:19 +0530
Message-ID: <20240909103623.264113-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The first patch adds support for configuring the Sampling frequency of
the sensor. The available values for the sampling freqeuncy are provided
by the `read_avail` callback and they are in miliHertz.

Then the second patch adds support for suspending and resuming
the sensor by providing the necessary callbacks. And registering
the ops with the driver.

The third patch in the series adds support for Threshold events and interrupts.
Exposed rising and falling threshold events for both the channels. The events
can be configured via the write_event_config callback. The desired rising or falling
threshold value can be written to from userspace.

The fourth patch adds support for threshold interrupt persistance.
It triggers when the UVS/ALS data is out of thresholds for a specific number
of consecutive measurements.
Exposed the IIO_EV_INFO_PERIOD attribute by which userspace can set the persistance
value in miliseconds. The persistance period should be greater than or equal
to the sampling period.

Thanks,
Abhash

Abhash Jha (4):
  iio: light: ltr390: Added configurable sampling frequency support
  iio: light: ltr390: Suspend and Resume support
  iio: light: ltr390: Interrupts and threshold event support
  iio: light: ltr390: Add interrupt persistance support

 drivers/iio/light/ltr390.c | 361 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 359 insertions(+), 2 deletions(-)

-- 
2.43.0


