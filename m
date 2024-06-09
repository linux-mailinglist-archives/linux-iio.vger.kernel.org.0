Return-Path: <linux-iio+bounces-6112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3DA901810
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 22:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A3728153A
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 20:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DD54B5CD;
	Sun,  9 Jun 2024 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1a6zNhyc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8161DA4C
	for <linux-iio@vger.kernel.org>; Sun,  9 Jun 2024 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717963586; cv=none; b=hyPLnld0NTOwofLo7fQ/ZuD0sG1ubqSFiqZ0OaTVBUcUmFgw42w8m+RV080ipu3lEMpzTv4TziESnJ5fAjoBqLwACfx0d+SLMN1zdyQv0deidPfHEgW0cDlNtDYCwxrDFFnkDFZE5hUw0XsUf8Z3JGEfpj10EbAG9iPP3ko7esg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717963586; c=relaxed/simple;
	bh=dV0HafcF6PMMuqh10cvuAZ5X5KeoDQVswsNpvA2TdBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=clTWPLeK1UQ4ccLUtZBx1Qg2MhJkYd+qrZ20/HZZtgEOs+vZDC+m/BGdZNaYVvq7sUMJsuqNNhUrdYvET0MXa4Am0qIbZ7b5HZ/mBGKY1fqxDCzGvYl4djiCguTqtkhjFz8NUmcPECd7vmB3vPZQ0g8Y3+L7Hcy/yDGEju+WNkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1a6zNhyc; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b970e90ab8so2308349eaf.3
        for <linux-iio@vger.kernel.org>; Sun, 09 Jun 2024 13:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717963583; x=1718568383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bCgjLGIvHnJpxhOHdQz2TYeCVliZVrQ6mIgWxXIdyLs=;
        b=1a6zNhycUCk4Pm+crqSjzPj6QkekJqLEAe8Y0hZyr+uSVtw7bozT22Ki5S5Oh5bDtr
         0vsHEczt6RqNFysHDTtMVT61xVIEtuiJYwpwwPxl6/ZdCVUE32kDY9ffo1gN1WHcVwOv
         r3JHfvAkU6TNghhEkytO6L7dib93Saw3eiSnBeAA7OBjhEo6P0FhcDcWPmY97Xp8Abpb
         I0uPQi7VP+oNBzsqttsGoFJROOrDdpCSgAc0n2mJwhBS0ub27g6w5NWP59+Il/zXLoRj
         gnOxBaTYw+npvRP+ZvgfpyeCn120hJxzva7SBd0yblpnT/M3O6y0f4kzGp5hivUCQ0Um
         fZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717963583; x=1718568383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCgjLGIvHnJpxhOHdQz2TYeCVliZVrQ6mIgWxXIdyLs=;
        b=SCFqN4dFr9Gd+1q82X+0y7kOW9jxeVdlZFXmMsDMUHvkPfaNtBLN7i3urAtz7k0yNk
         ZfjC7dkiCJ0prWPBvIbrX6hPEGOsV3d7cFZKeadssbYZrABeXuwekDOepVOJEf6PnIFx
         QoessFHwvkyU9c5/t6R8KJIHqzySxK81Clj5/OLMg9n1CW8cTd6UgHxOkcY7goUCEj+A
         eMiN+P5OSFE/7fG2nfOP0IlHnI60RDQHrx+A5vr+n7oXMUwmCnJGHBzxs7mliA9T8wW4
         r0wkPydIgJhlobUHdZrM8uw7xMWD6bXDvwCDA3306rMZPaEk1mabBPlZ9i0Qu6HGrAx9
         +Ybw==
X-Forwarded-Encrypted: i=1; AJvYcCXcCYMfX+yy5Zs4PixCuXsTkNOpW/aLpnoOi+5sE3d/Hf3lwlx9gZBQimDxzsqUp4X4gt+eqxoVTcINnJiooX3e2TRVegw90aGA
X-Gm-Message-State: AOJu0YyxbuwpzeC4StuDnYWCRRcdxpZF51lFOA6IyzzPN/bcQSMGc+9+
	t0zYjcvKPGu532rvaWKgu4rvTnCX7POt7kpuDRnFyXdpinANv7swMvyIUX6Xf5DJ5uUseQVocnZ
	4
X-Google-Smtp-Source: AGHT+IGUcR9xqr3+AxBdyVQ8ar8tP10gwQFPrDJQGF+erJK+HZxWPREAfdHRAmFKf7QcyMjOjK3RfA==
X-Received: by 2002:a4a:dc95:0:b0:5ba:bb77:bf51 with SMTP id 006d021491bc7-5babb77c5dfmr6153154eaf.2.1717963582922;
        Sun, 09 Jun 2024 13:06:22 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba977e121bsm1413278eaf.28.2024.06.09.13.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 13:06:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Judith Mendez <jm@ti.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] counter: ti-eqep: small cleanups
Date: Sun,  9 Jun 2024 15:06:14 -0500
Message-ID: <20240609-ti-eqep-cleanup-v1-0-9d67939c763a@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Judith got me looking at this driver again, so I noticed a few small
things that could be cleaned up.

---
David Lechner (2):
      counter: ti-eqep: remove unused struct member
      counter: ti-eqep: remove counter_priv() wrapper

 drivers/counter/ti-eqep.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)
---
base-commit: bb3f1c5fc434b0b177449f7f73ea9b112b397dd1
change-id: 20240609-ti-eqep-cleanup-254e6ba1e386

