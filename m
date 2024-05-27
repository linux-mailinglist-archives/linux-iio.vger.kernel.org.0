Return-Path: <linux-iio+bounces-5363-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F06F18D09EB
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 20:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90A34B21A59
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 18:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9141A15FA63;
	Mon, 27 May 2024 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMX5oSSF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D302F2B;
	Mon, 27 May 2024 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716835097; cv=none; b=pzyXAF5z8608VWIh64J8l5nneFTtQU69LqjDty/WOlpH/2JIlmNTLjAHN2sD9VQRNTBgFSbYvCUQ4jh5mmbgviqVtoUx9tKjsGuGpP27TnwuaJT/y7ucLrHxOjTn9ABzMlFMDOSzaiSL+OyJJH8YLaxi9eQzTyRiCDfNjnpZL8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716835097; c=relaxed/simple;
	bh=tMnPK23Bd3KunVXr8QqXPDCAM3j6iocEKexgtzGTs8c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=upntH2Z+w/kNwLoe28jksJlygsAK4C2DRi95a1iDFzoMmdyjm3rAWVANaeNMJOzsc9WKhP2q2zSdnFlME8yVsp/J7MEO97G3DtlIu0aUKsOYuxrxkja8lHXYwREYyj2ajjne76HNvOFC3+XekgdyI/Co88vF/SSKI1tlNEaxGSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMX5oSSF; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a626777f74eso7066766b.3;
        Mon, 27 May 2024 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716835094; x=1717439894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CyBhQx1agwSxo805DtO3PqMKr3RwM0Dt9Oyo7650Co8=;
        b=bMX5oSSFH5jXUtPrrLUxz54ExgUnL9JMteg6l4aq59Dt7kZL6kZRp3X5oH1RkpQzeO
         qQTzNKVQaeFmaneyCjj9q6wXEeTvZHUTtBw1LEjG++9rOpxWqbk5VJLySFv1YiNCwPon
         jxCoD8dDUgqzZhiJOXjWdjFSbHLGgrUbE1LvKWTEL5joSLp72kZsU2bbdNExYYJkH+d3
         llv3wKlJwAtNFVaRM+9V9blE34Zx4vG3aKx1yokxjhjhE1sf17d4mJSHsy9Da+0U9wX3
         9wzqfqZPYSFPe4h712n77dtE5zp0qouV7Mau8+zai05fJqshyrzYitj80bPJVhf5FlC9
         UvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716835094; x=1717439894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CyBhQx1agwSxo805DtO3PqMKr3RwM0Dt9Oyo7650Co8=;
        b=ZdM/gLd1NcoiPTDQ8m+W1huQd5r2FHHLdat2HLzqJSXfCDa2cQ1gVjFL0YDBdEIjdX
         /4IvEvv0K4BDht4785Mx2k7Y8cYX4OTloGnqM3G3oumTr19gn4gXmbVg9cGi1OlJIpav
         /vy8ECUtcGX5Fqq3sIaXD2+YiZ27pzHmRDauukLgeI9S+CobwpXyl5YhJ4C3a85yUe42
         m+LL115qnOX4BPBZTH2WpKMRbKfDhpHn3ygytXFvofO3KhFhCbJS/fA6rphXlGHYf8T6
         K6GelK1WR8U7YZEB4oQzTNPN+FWfY6sWQEbk2/tlEAW55lFvl7aZ8wnQPm9tsgAxkQjz
         Obqw==
X-Forwarded-Encrypted: i=1; AJvYcCU+MqxYPqo0lHzRIw+utHWyztcb8gTfVREoCuq/JkPSavA15VncU1SmxWXX/pM+Uy9K1RBFqBi27Om1/JXopEveH2EVFN9d0dcfytgv0F5e3PgwnTBFcOzyBLRqdvYxDiV/VT9/wkRn
X-Gm-Message-State: AOJu0YzZG9AvubcYYdSBBwcluc7U2RZqZYPE6moGFWJuLlIW51zYpl/h
	hAuY9jngNuIloacMS1oOt9BIHr5gu5wXImkEY/ThSdVoLS7QoBUG
X-Google-Smtp-Source: AGHT+IFX5TWNzO2dJTI0gl30QwUFA5ZWf8kBkOEmy8vRVL0RtvPCH5aKHV7DhpQRPr3A3aHUmNe0sA==
X-Received: by 2002:a17:906:185b:b0:a59:ea34:fe0d with SMTP id a640c23a62f3a-a6265119ae9mr1148217666b.47.1716835093568;
        Mon, 27 May 2024 11:38:13 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b45:3774:6be0:a177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc52398sm513825266b.105.2024.05.27.11.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 11:38:12 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: himanshujha199640@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 00/17] iio: chemical: bme680: Driver cleanup
Date: Mon, 27 May 2024 20:37:48 +0200
Message-Id: <20240527183805.311501-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This started as a series to add support for buffers and the new
BME688 but it ended up being just a cleaning series. These might
be quite some patches for such a thing but I feel that they are
are well split, in order to allow for better review.

The patches are mostly small changes but essential for the correct use
of the driver. The first patches looked like fixes that should be
marked for the stable. Patches [11,17/17] might be a bit bigger but 11/17
is quite straightforward and 17/17 is basically a duplication of a
very similar commit coming from the BMP280 driver [1].

In general, the datasheet [2] of the driver is not very descriptive,
and it redirects the user to the BME68x Sensor API [3]. All the things
that were identified from the BME68x Sensor API have been marked with
links to the original locations of the GitHub code. If this is too much
and we don't want this type of information on the commit message, please
let me know and I will fix it.

[1]: https://lore.kernel.org/linux-iio/20240512230524.53990-1-vassilisamir@gmail.com/T/#mc6f814e9a4f8c2b39015909d174c7013b3648b9b
[2]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme680-ds001.pdf
[3]: https://github.com/boschsensortec/BME68x_SensorAPI/tree/master

Vasileios Amoiridis (17):
  iio: chemical: bme680: Fix pressure value output
  iio: chemical: bme680: Fix calibration data variable
  iio: chemical: bme680: Fix overflows in compensate() functions
  iio: chemical: bme680: Fix sensor data read operation
  iio: chemical: bme680: Fix type in define
  iio: chemical: bme680: Add mutexes to guard read/write to device
  iio: chemical: bme680: Drop unnecessary casts and correct adc data
    types
  iio: chemical: bme680: Remove remaining ACPI-only stuff
  iio: chemical: bme680: Sort headers alphabetically
  iio: chemical: bme680: Remove duplicate register read
  iio: chemical: bme680: Use bulk reads for calibration data
  iio: chemical: bme680: Allocate IIO device before chip initialization
  iio: chemical: bme680: Add read buffers in DMA safe region
  iio: chemical: bme680: Modify startup procedure
  iio: chemical: bme680: Remove redundant gas configuration
  iio: chemical: bme680: Move forced mode setup in ->read_raw()
  iio: chemical: bme680: Refactorize reading functions

 drivers/iio/chemical/bme680.h      |  39 +-
 drivers/iio/chemical/bme680_core.c | 643 ++++++++++++++---------------
 2 files changed, 315 insertions(+), 367 deletions(-)


base-commit: 409b6d632f5078f3ae1018b6e43c32f2e12f6736
-- 
2.25.1


