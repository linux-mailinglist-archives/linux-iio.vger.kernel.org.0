Return-Path: <linux-iio+bounces-4762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77DF8B9F57
	for <lists+linux-iio@lfdr.de>; Thu,  2 May 2024 19:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139111C21E56
	for <lists+linux-iio@lfdr.de>; Thu,  2 May 2024 17:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5032016FF33;
	Thu,  2 May 2024 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQMRJBO+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BFB16FF26
	for <linux-iio@vger.kernel.org>; Thu,  2 May 2024 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670182; cv=none; b=QCNxEv7W/vhnX2pIcibZm1Zk5YP3xMfknhNL4nce1Jgv4Dn5/wiHcStOWJ1mf3VRJPINp7VNS7Q7qTw62b9oce6Jakp30AvCbkEAXrIT91aq9Y9r8ByYqsog+A5XunP49qKiaD+++npMAfPnYHAEN3CWpYl41KzLDqr2M+Tu/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670182; c=relaxed/simple;
	bh=2q4yuQP2Z1kjsl7kzR7hIt0xxAcbuR/d2lGxqM1SIuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jZaSUDcVb9Nhgt8kyb2ybddYQx5DnRGvYQuiQgyOEfX+sJ6nX0KjfRYcuVMkkMDK0MnjlWxOan+1up/lIcFWVBW5AO35ZPgH+/ab29TQCj2pbL7xPQ+JnNtU8CRikHettebkkTWZftTuIJXiYMRreJUAyYX2VidjwOvESdFC8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQMRJBO+; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51f174e316eso1186587e87.0
        for <linux-iio@vger.kernel.org>; Thu, 02 May 2024 10:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714670178; x=1715274978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2q4yuQP2Z1kjsl7kzR7hIt0xxAcbuR/d2lGxqM1SIuw=;
        b=dQMRJBO+ZNe+SSDA7UCRdPz3ZgawhNYIQLLX+srXrW2Gq1BR7FH95S3QTTXHuj1GYi
         3h7TzevY7ujslrK3OK1zP1lFILVlLhsTnBW3LC9CKI02O6flM6gN/+Ftn5QMkHQztyCP
         i29lIo3qA+Z2s+0UD9CVkozB3CGrWUynaXQLjFPZsgnEGmzyHqqsRxn4hT19DWhq+z+r
         c3vYJQNYTt62d1W25wc+RiPZozvh7339JSGAB02NZ8OAD/T/L0ekvfNdcDdZFl02a9It
         rR1nwqLtdvYC8LKr+jeNzNhOVKlFBw99Q+pDBWjIhvXgr1LqlUzPKiwPZ8OJq6cbrUdr
         Jt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714670178; x=1715274978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2q4yuQP2Z1kjsl7kzR7hIt0xxAcbuR/d2lGxqM1SIuw=;
        b=w9F1y5Eq54SG7rwxcsQ1BWqXSF3/HAJKvQkfiPZd7A+1tuqNPcqKvb8dNeqVOoCQIT
         HCxb24GEktrEkoZUqAboc0N/NydVAqbeWT9bUF+c/QODo0VHuCxdco1HdhoOtQpEslle
         wiybR46JqMShdXR8EOfOe/E64EX3NrKUzrTqqw8mkFLQ0KPdFZTr4SkqBqkrvifBwrwa
         7WZhYZQO3nXcPXwDd+wy9dmV43tNLNoss1FL2XtvuDcbtmTWl9DJ0GtGJmi2SfFP95jr
         Mwl9uBDJxnZjtTZgDlGVZ2lDnE0FbtJLU+sszBe9kx+oj+DNUmV0je4XXSiydyIzxjS/
         QDUA==
X-Forwarded-Encrypted: i=1; AJvYcCVVv08S3mz7pNWJjc1XKz0E3oVocfbXHLdfkyTKg93LFGJs4VBJRgdTgrZDywHdY/R4TbKAvJ+YM843aFUnfFo+ah73nu1Czg/+
X-Gm-Message-State: AOJu0Yw8zWYbbPLApiI+4iAZrzvkrn6r/e+F6oChTIX9nLIDjxFRuTok
	GQvyQYJU7idgWIcNmRVDy0v0RMsOW0UCV5LYnpSWwwYhndJEZKQU1XlPESzO
X-Google-Smtp-Source: AGHT+IEP7ZlHDgVLR5tVHFk0yZQ7mUW5wvVpec9yzhtWEwBxNhqOrRLrVm4MFsCqlDKkYS2VJXEWOw==
X-Received: by 2002:a05:6512:3a90:b0:51a:d7c7:769f with SMTP id q16-20020a0565123a9000b0051ad7c7769fmr290867lfu.65.1714670178360;
        Thu, 02 May 2024 10:16:18 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:9b84:d286:909b:17d1])
        by smtp.gmail.com with ESMTPSA id d17-20020a056402517100b0056fe755f1e6sm714150ede.91.2024.05.02.10.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 10:16:17 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: ang.iglesiasg@gmail.com
Cc: ajarizzo@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org
Subject: Replying to: [PATCH] iio pressure: bmp280: Fix BMP580 temperature reading 
Date: Thu,  2 May 2024 19:16:16 +0200
Message-Id: <20240502171616.154085-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <043f2be49df3c11152aaf32fc5467ed43fd59faa.camel@gmail.com>
References: <043f2be49df3c11152aaf32fc5467ed43fd59faa.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Angel!

Indeed the datasheet says that the pressure is a signed value. But this comes
in contrast with 2 things:

1) The BMP58x sensor does not have a compensation function so the value from the
sensor is a pressure value just in different unit from the one reported by IIO.
And the sensor is able to report in between 30-125kPa according to the
datasheet which are both positive values so it makes more sense to be an
unsigned value.

2) According to the BMP5 sensor API [1] provided by Bosch, the pressure is
declared as an unsigned value.

So, what should we trust?

[1]: https://github.com/boschsensortec/BMP5_SensorAPI/blob/master/bmp5_defs.h#L895

