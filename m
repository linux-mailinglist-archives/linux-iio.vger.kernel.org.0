Return-Path: <linux-iio+bounces-8455-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D501F950B6A
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 19:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1388B1C21E79
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 17:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A651A38C0;
	Tue, 13 Aug 2024 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GzgQlkzC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB431A2C14
	for <linux-iio@vger.kernel.org>; Tue, 13 Aug 2024 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723570012; cv=none; b=ZoX+r/znnLJOgSHZ21lmFTvdi1XjRK8VDQJy0Yl9zWZc0LulNNnSerBIRccNG11KLC/Q9y0oCOt71pyCj6ZWoyaFabDAKYdyseZMD+81BTF1Je4PTLLhMO9+b6XzOB6r4IRZiWv+GcKk/QNVK0CNQxxR2Z0NwvWZ1aLrEw1x0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723570012; c=relaxed/simple;
	bh=jYGb5mHlV+ihdJHe49QSxa9mK0oe4vJu7/WyfoVkd3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kvsi4UzAhSixNsgUvzwvK9CrvBGRXrveidw8VmklBv8JDFYlUARzwBeWn98sS2xtNWjIBouo6/D6a43YFu4L6nc/GUnkUNqRiSGj6O8nh8KAnHZf3rJesMoTw6WevMRORjmyICJSWF/wY2tdciWNN3mNUk1PHVSiuf2fRc4JHf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GzgQlkzC; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-260f863109cso3380372fac.1
        for <linux-iio@vger.kernel.org>; Tue, 13 Aug 2024 10:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723570009; x=1724174809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfCzq2Lvjd+sCpXqRW/b9Deb8m8Alkw4yxbwVX9rDSs=;
        b=GzgQlkzCcUnvtm6Smh8RDUus88FAsMGvuBhVVB3Uu82XFjdfaZTf05EIezqN/S5cHM
         kM6XQIyMCuZ2Jo7qEedUNoaJWQaTRP9uxwXSCeFN2VcH5uszbbiVAX388x/eol62hPg4
         EB4NjifeLv8NZOdA5l95nt2gaHbgebY7cto5lehfIvBQnU2nLIx2GM7HseWVF6Dk5qxJ
         gUVmme1iMQLsEnE+oI4t5SRuZ3E1A9knxjVDhqqpnhCxy/i6jVFk5caGu7XxVXqkCTpf
         6cOtRx+Xxviv8LMCOKvwhhCWTimYKRcrU0hPG6l5HXHZmx3HX1EeNpsNfN4XW2XfuUzC
         8PRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723570009; x=1724174809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfCzq2Lvjd+sCpXqRW/b9Deb8m8Alkw4yxbwVX9rDSs=;
        b=n8k0NF/GboL48ria/a0Yk0qvYW3z//IsLmhtL1xDFjsfpA9e2irJVXyvIs23CvBjo2
         J9GdX/XWehWv+wAi4mGXFQbxr2uDbtayCZJoX+Iq5/73wHJNO6LN9orxDTaTa5xosXdz
         /2IExZfc/oJ2hIZCm9b+MqoeDxCjf7XZ6wk7oFUOaKoYZL8MlPQtDK/lrjDkKLZCiD3H
         XhTre55w5XPoIKkFot1DjLQPDD5OKXHN/FTiYW/NTmWOhg9j7n048mnou55jgKAEnx70
         Rn426PgYBK7O9ilRgVmqabsZdFj3EH8lhakBehfMQ0mEixHOie38xFtBU1gMkFOK7YPx
         WRXA==
X-Forwarded-Encrypted: i=1; AJvYcCWtQfomgG6jCMRBYDI2rESRznAL+5TBX/KNBlHk8RAcXLH/0+Sh3xhCzYBZ4vQQX6FiDCW0zT5oZVzKojX/wrNVx+LYaVqCZybc
X-Gm-Message-State: AOJu0Yx2kRWFwtkl4UbWN4/N8LhyKvRLp3q0uNSyiTIkcNedyu/chi6z
	D2Zv4ayFniA99Tee78R6PKEU9bUgnRohO+9qPuajrBFLYGJd90ygqlT3v4JDsGY=
X-Google-Smtp-Source: AGHT+IHB7YiQIkoOes9wES0Mi+fNIeVmdTDb7hUa8Ff0QtR3A0cXdNJQk05/+elRrn+hXZiChbW9WA==
X-Received: by 2002:a05:6870:82a4:b0:26c:64f8:d69b with SMTP id 586e51a60fabf-26fe5bf8b32mr417984fac.38.1723570009443;
        Tue, 13 Aug 2024 10:26:49 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-26c7203f908sm2462915fac.11.2024.08.13.10.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 10:26:49 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 2/2] doc: iio: ad4695: document buffered read
Date: Tue, 13 Aug 2024 12:26:41 -0500
Message-ID: <20240813-iio-adc-ad4695-buffered-read-v2-2-9bb19fc1924b@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813-iio-adc-ad4695-buffered-read-v2-0-9bb19fc1924b@baylibre.com>
References: <20240813-iio-adc-ad4695-buffered-read-v2-0-9bb19fc1924b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

Update the ad4695 documentation to say that buffered reads are
supported. Since there are 4 possible modes of reading conversion data,
it is useful to know which one is actually being used, namely the
advanced sequencer mode.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
* Drop paragraph about temperature channel since it is no longer
  applicable.
---
 Documentation/iio/ad4695.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/iio/ad4695.rst b/Documentation/iio/ad4695.rst
index a33e573d61d6..7612596bb6e9 100644
--- a/Documentation/iio/ad4695.rst
+++ b/Documentation/iio/ad4695.rst
@@ -147,9 +147,16 @@ Unimplemented features
 ----------------------
 
 - Additional wiring modes
-- Buffered reads
 - Threshold events
 - Oversampling
 - Gain/offset calibration
 - GPIO support
 - CRC support
+
+Device buffers
+==============
+
+This driver supports hardware triggered buffers. This uses the "advanced
+sequencer" feature of the chip to trigger a burst of conversions.
+
+Also see :doc:`iio_devbuf` for more general information.

-- 
2.43.0


